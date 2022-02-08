Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC0F4AE260
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353788AbiBHTlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiBHTlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:41:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4705DC0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:41:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3762615EA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FB7C004E1;
        Tue,  8 Feb 2022 19:41:12 +0000 (UTC)
Date:   Tue, 8 Feb 2022 14:41:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     JaeSang Yoo <js.yoo.5b@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        JaeSang Yoo <jsyoo5b@gmail.com>
Subject: Re: [PATCH v2] trace: param: fix tp_printk option related with
 tp_printk_stop_on_boot
Message-ID: <20220208144111.6d5b5d2d@gandalf.local.home>
In-Reply-To: <20220208163031.885332-1-jsyoo5b@gmail.com>
References: <20220208163031.885332-1-jsyoo5b@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Feb 2022 01:30:33 +0900
JaeSang Yoo <js.yoo.5b@gmail.com> wrote:

> Kernel param "tp_printk_stop_on_boot" starts with "tp_printk" which is
> the exact as the other kernel param "tp_printk".
> In compile & build process, It may not guaranteed that
> "tp_printk_stop_on_boot" always checked before "tp_printk".
> (By swapping its __setup() macro order, it may not work as expected.)
> Some kernel params which starts with other kernel params consider this
> problem. See commit 745a600cf1a6 ("um: console: Ignore console= option")
> or init/do_mounts.c:45 (setup function of "ro" kernel param)
> 
> Kernel param "tp_printk" can be handled with its value(0 or off) or
> it can be handled without its value. (maybe it won't effect anything)
> Fix setup function to ignore when the "tp_printk" becomes prefix of
> other kernel param.
> 
> Signed-off-by: JaeSang Yoo <jsyoo5b@gmail.com>
> ---
>  kernel/trace/trace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index c860f582b078..5c8a28d74cf8 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -252,6 +252,8 @@ __setup("trace_clock=", set_trace_boot_clock);
>  
>  static int __init set_tracepoint_printk(char *str)
>  {
> +	if (*str == '_')
> +		return 0

Did you test this?

Need a space here (besides the obvious bug).

Also, it needs a comment above:

	/* Ignore the tp_printk_stop_on_boot */
	if (*str == '_')
		return 0;

-- Steve

>  	if ((strcmp(str, "=0") != 0 && strcmp(str, "=off") != 0))
>  		tracepoint_printk = 1;
>  	return 1;

