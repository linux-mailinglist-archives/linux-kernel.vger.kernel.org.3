Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD084B75EB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242912AbiBOSLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:11:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241262AbiBOSLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:11:05 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F31119432
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:10:55 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D66921F37B;
        Tue, 15 Feb 2022 18:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644948653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f5aYonr4ORj/YqnUtWpVYe8Wlx+8kb4tQX1zRaFkQXM=;
        b=eRPqXI1wLrkr5zsnIdC54ETnDCn4VS64jwF4HQ2vVHaeBfXXXd3ZQz2+E/ziKmQ4iyxliC
        PrgPFP8biPRmTW/PERINncy88J8B4Y/RY5XOuFeG522brrR3nsJYUDAFAMiHjJ7JVXZJnS
        gf1x1/v38gCszbe1s8x2Jd4R9koZ34o=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BD709A3B83;
        Tue, 15 Feb 2022 18:10:53 +0000 (UTC)
Date:   Tue, 15 Feb 2022 19:10:50 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andre Kalb <andre.kalb@sma.de>
Cc:     john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, senozhatsky@chromium.org
Subject: Re: [PATCH v2] printk: Set console_set_on_cmdline=1 when
 __add_preferred_console() is called with user_specified == true
Message-ID: <YgvsqldT1sjfF5lf@alley>
References: <YgKSbe9d3haHKMid@alley>
 <YgpXWQqjfJBISG1v@pc6682>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgpXWQqjfJBISG1v@pc6682>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-14 14:21:29, Andre Kalb wrote:
> From: Andre Kalb <andre.kalb@sma.de>
> 
> In case of using console="" or console=null
> set console_set_on_cmdline=1 to disable "stdout-path" node from DT.
> 
> We basically need to set it every time when __add_preferred_console()
> is called with parameter 'user_specified' set.
> Therefore we can move setting it into a helper function that is
> called from __add_preferred_console().
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Andre Kalb <andre.kalb@sma.de>
> ---
> Changelog v1 to v2:
> Move console_set_on_cmdling into separate function set_user_specified(), which is called from
> __add_preferred_console().
> 
> The old patch v1 could be used to backport to stable 5.4 and lower.
> ---
>  kernel/printk/printk.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 82abfaf3c2aa..3654695ca5d2 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2324,6 +2324,15 @@ asmlinkage __visible void early_printk(const char *fmt, ...)
>  }
>  #endif
>  

We should add a comment explaining the less obvious behavior as
discussed in the thread. Something like:

> +static void set_user_specified(struct console_cmdline *c, bool user_specified)
> +{
> +	if (!user_specified)
> +		return;
> +
	/*
	 * @c console was defined by the user on the command line.
	 * Do not clear when added twice also by SPCR or the device tree.
	 */
> +	c->user_specified = true;
	/* At least one console defined by the user on the command line. */
> +	console_set_on_cmdline = 1;
> +}
> +
>  static int __add_preferred_console(char *name, int idx, char *options,
>  				   char *brl_options, bool user_specified)
>  {

With the above comments:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Sergey, is it enough from your POV, please?

Best Regards,
Petr
