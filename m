Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6140B4B5C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiBNVGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:06:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiBNVG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:06:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC15135486
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:06:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23CF26114D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 19:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA887C340E9;
        Mon, 14 Feb 2022 19:50:48 +0000 (UTC)
Date:   Mon, 14 Feb 2022 14:50:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ftrace: Remove unused ftrace_startup_enable() stub
Message-ID: <20220214145047.35b9df58@gandalf.local.home>
In-Reply-To: <20220214192847.488166-1-nathan@kernel.org>
References: <20220214192847.488166-1-nathan@kernel.org>
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

On Mon, 14 Feb 2022 12:28:47 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> When building with clang + CONFIG_DYNAMIC_FTRACE=n + W=1, there is a
> warning:
> 
>   kernel/trace/ftrace.c:7194:20: error: unused function 'ftrace_startup_enable' [-Werror,-Wunused-function]
>   static inline void ftrace_startup_enable(int command) { }
>                      ^
>   1 error generated.
> 
> Clang warns on instances of static inline functions in .c files with W=1
> after commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> inline functions for W=1 build").
> 
> The ftrace_startup_enable() stub has been unused since
> commit e1effa0144a1 ("ftrace: Annotate the ops operation on update"),
> where its use outside of the CONFIG_DYNAMIC_TRACE section was replaced
> by ftrace_startup_all().  Remove it to resolve the warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks,

I'll queue this up for the next merge window. (After it passes all my
testing of course).

-- Steve

> ---
>  kernel/trace/ftrace.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f9feb197b2da..a4b462b6f944 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -7191,7 +7191,6 @@ static int __init ftrace_nodyn_init(void)
>  core_initcall(ftrace_nodyn_init);
>  
>  static inline int ftrace_init_dyn_tracefs(struct dentry *d_tracer) { return 0; }
> -static inline void ftrace_startup_enable(int command) { }
>  static inline void ftrace_startup_all(int command) { }
>  
>  # define ftrace_startup_sysctl()	do { } while (0)
> 
> base-commit: 754e0b0e35608ed5206d6a67a791563c631cec07

