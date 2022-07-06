Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40FE569635
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 01:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiGFXhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 19:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiGFXhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:37:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595092CDC6;
        Wed,  6 Jul 2022 16:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D09A+SL0PWvZ3ThuAmaRek+4bTTKIaie6FGwPac4dZI=; b=tyLYzUJ5gXXykof2FQlMnmuiWx
        c8qCBX6FN6VtidXXPgM0uCcjYG6jF4nSLSN5iFPTHZtp6ALwAMMhgXuhI8Ek11YZ58lOrrPll6/wN
        WzcQgPAOt+/WL9hogQ9/UfZ34VmkIG4HBTwfwkmg+DT00ojP2rvycN05j1Ss5dFwAg8LzBvzeb5F5
        bzfqxfsncAhtlP5el8PsfP3DIOAktWALp6Fmzs8CDXI0CXZ5K2NiO4rTvuOxe4nxUnAydrcN2wSJg
        JGR1G/fblzjbKIcNV6I152J/bBaNjPcgE6vuv8/DJ5zQlLS27fAJ9mKAv+6Ls1a9hU2gdvOn5nRfp
        ZU6qCWYA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9EZt-00CloN-E7; Wed, 06 Jul 2022 23:37:05 +0000
Date:   Wed, 6 Jul 2022 16:37:05 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] module: Show the last unloaded module's taint flag(s)
Message-ID: <YsYcoVKA0KzxykqN@bombadil.infradead.org>
References: <20220627164052.2416485-1-atomlin@redhat.com>
 <20220627164052.2416485-2-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627164052.2416485-2-atomlin@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 05:40:52PM +0100, Aaron Tomlin wrote:
> For diagnostic purposes, this patch, in addition to keeping a record/or
> track of the last known unloaded module, we now will include the
> module's taint flag(s) too e.g: " [last unloaded: fpga_mgr_mod(OE)]"
> 
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  kernel/module/main.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index dcb83cf18d84..0ca6fd38b903 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -524,7 +524,12 @@ static struct module_attribute modinfo_##field = {                    \
>  MODINFO_ATTR(version);
>  MODINFO_ATTR(srcversion);
>  
> -static char last_unloaded_module[MODULE_NAME_LEN+1];
> +/*
> + * Maximum number of characters written by module_flags()
> + * without a module's state information.
> + */
> +#define LAST_UNLOADED_MODULE_NAME_LEN (MODULE_NAME_LEN + MODULE_FLAGS_BUF_SIZE - 2 + 1)
> +static char last_unloaded_module[LAST_UNLOADED_MODULE_NAME_LEN];

First of all this then confuses a reader easily as one would expect
last_unloaded_module always just has the module. Second, "module flags"
really throws a user off, as one would expect a module flag is some sort
of parameter, but in reality these are just taint flags.

So I'd much prefer we split the taint flags out to its own buffer and
dump the data to it alone.

The first patch seems sensible.

  Luis

>  #ifdef CONFIG_MODULE_UNLOAD
>  
> @@ -694,6 +699,7 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
>  {
>  	struct module *mod;
>  	char name[MODULE_NAME_LEN];
> +	char buf[LAST_UNLOADED_MODULE_NAME_LEN];
>  	int ret, forced = 0;
>  
>  	if (!capable(CAP_SYS_MODULE) || modules_disabled)
> @@ -753,8 +759,8 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
>  
>  	async_synchronize_full();
>  
> -	/* Store the name of the last unloaded module for diagnostic purposes */
>  	strlcpy(last_unloaded_module, mod->name, sizeof(last_unloaded_module));
> +	strcat(last_unloaded_module, module_flags(mod, buf, false));
>  
>  	free_module(mod);
>  	/* someone could wait for the module in add_unformed_module() */
> -- 
> 2.34.3
> 
