Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B50535110
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347671AbiEZOyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240687AbiEZOym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F311F36E28
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:54:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64D6561BD4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 14:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B38C385A9;
        Thu, 26 May 2022 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653576880;
        bh=hXEWABgFpEb92wPiah32bOUadWzKqqT8anhnxU8Zme4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gxnYoBkeS3NxwCgvDe4m6Dx0JZZwcrlaMoSIowVytmagQF0rks1f9f1xDRYzSIXTX
         8HQrs8k5K6JplK/SDHUPmhfhMOV2A/+Lr6uI1A1+2M1OEHHkuAuYD8JfWn2P9XKwQA
         oCiA4jgyxubHUWIjSdhwedpENiX0Kj2EIB5NA06J6GPofQFPHs14bzeMBW+S8kjkhR
         n2BKZmKtT+gLxF5kkqjQep8fS4ou/1syxNAdSDdo96tjmp2ZjVFi5pV/mI0RVQP2Kx
         7YCC201dH74AM+38Xn6Bu7C1myxh5NIlLNEFVGvgbh88CK7Jcq10KmzexW2uSAa/X8
         ikaMnv2jAcjew==
Date:   Thu, 26 May 2022 23:54:35 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Gautam Menghani <gautammenghani201@gmail.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] kernel/trace: Initialize integer variable to prevent
 garbage return value
Message-Id: <20220526235435.59a1b3074ecfb30825824948@kernel.org>
In-Reply-To: <20220525112551.37e86da6@gandalf.local.home>
References: <20220522061826.1751-1-gautammenghani201@gmail.com>
        <20220525112551.37e86da6@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022 11:25:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 21 May 2022 23:18:26 -0700
> Gautam Menghani <gautammenghani201@gmail.com> wrote:
> 
> > Initialize the integer variable to 0 to fix the clang scan warning:
> > Undefined or garbage value returned to caller 
> > [core.uninitialized.UndefReturn]
> >         return ret;
> > 
> > Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> > ---
> >  kernel/trace/trace_boot.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> > index 0580287d7a0d..778200dd8ede 100644
> > --- a/kernel/trace/trace_boot.c
> > +++ b/kernel/trace/trace_boot.c
> > @@ -300,7 +300,7 @@ trace_boot_hist_add_handlers(struct xbc_node *hnode, char **bufp,
> >  {
> >  	struct xbc_node *node;
> >  	const char *p, *handler;
> > -	int ret;
> > +	int ret = 0;
> 
> Looks good to me. Masami, care to ack it?

Thanks! This looks good to me.

Fixes: 8993665abcce ("tracing/boot: Support multiple handlers for per-event histogram")
Cc: stable@vger.kernel.org
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> 
> -- Steve
> 
> >  
> >  	handler = xbc_node_get_data(hnode);
> >  
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
