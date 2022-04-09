Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7444FA8F2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 16:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbiDIOZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 10:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiDIOZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 10:25:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8E7C04
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 07:23:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E6BE614B7
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 14:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E20C385A0;
        Sat,  9 Apr 2022 14:23:01 +0000 (UTC)
Date:   Sat, 9 Apr 2022 10:23:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, broonie@kernel.org,
        mark.rutland@arm.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Subject: Re: [PATCH RESEND v3 1/2] ftrace: cleanup ftrace_graph_caller
 enable and disable
Message-ID: <20220409102300.4cfc9589@gandalf.local.home>
In-Reply-To: <20220409085500.4549-1-zhouchengming@bytedance.com>
References: <20220409085500.4549-1-zhouchengming@bytedance.com>
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

On Sat,  9 Apr 2022 16:54:59 +0800
Chengming Zhou <zhouchengming@bytedance.com> wrote:

> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2721,6 +2721,26 @@ int __weak ftrace_arch_code_modify_post_process(void)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER

Actually, can you put this into fgraph.c instead. That only gets compiled
if the above config is enabled. Thus, you do not even need to add the
#ifdef around it.

I intend to move even more code into fgraph.c that is only for function
graph. I don't want to add any new code to ftrace.c for it.

-- Steve


> +/*
> + * archs can override this function if they must do something
> + * to enable hook for graph tracer.
> + */
> +int __weak ftrace_enable_ftrace_graph_caller(void)
> +{
> +	return 0;
> +}
> +
> +/*
> + * archs can override this function if they must do something
> + * to disable hook for graph tracer.
> + */
> +int __weak ftrace_disable_ftrace_graph_caller(void)
> +{
> +	return 0;
> +}
> +#endif
> +
>  void ftrace_modify_all_code(int command)
>  {
>  	int update = command & FTRACE_UPDATE_TRACE_FUNC;

