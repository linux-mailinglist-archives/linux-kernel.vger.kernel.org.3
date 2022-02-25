Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF9A4C3AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbiBYBc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbiBYBc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:32:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B58186216
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:32:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37AE4B82A85
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 01:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A727C340E9;
        Fri, 25 Feb 2022 01:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645752740;
        bh=WM2n7P5HcptYIrh/8Oiu/xF67/AfvdZbOpDJ2NsVTG0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NtfrDuV7INO5SSDNC/bwDgj1rZN0s1VgQAtJpxtUkr1iCnvPdtcYD5iJ4QYvKilFb
         FfAG37xLNz1PwpOE8baMBsqJfLZaizdGJcK8uxWFZoZNoRs6X9PHTcnrBxnZvDBN3r
         aPiJgjZrow2gkUWpfBKlQZruveUxh/o+/eZK3tgo5CpAqrcrXeE+xB5qj6tJcFig3B
         W/x1eHkv6GMxQy+jhJQrZymMXD/iWNNzcckMj5fkZbbch228zklzfqVi8MWvBVKnyy
         j4epE+f4tRyOt4mLYo64+4hTi8xDAqWv9N1kwt3hGls84V+Lyt+nTIqn770PReOFLQ
         6713mU+pS483w==
Date:   Fri, 25 Feb 2022 10:32:15 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
Message-Id: <20220225103215.77080de0b3edd0fa2839b8fa@kernel.org>
In-Reply-To: <20220224151322.892372059@infradead.org>
References: <20220224145138.952963315@infradead.org>
        <20220224151322.892372059@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, 24 Feb 2022 15:51:53 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> With IBT on, sym+0 is no longer the __fentry__ site.
> 
> NOTE: the architecture has a special case and *does* allow placing an
> INT3 breakpoint over ENDBR in which case #BP has precedence over #CP
> and as such we don't need to disallow probing these instructions.

Does this mean we can still putting a probe on sym+0??

If so, NAK this patch, since the KPROBES_ON_FTRACE is not meaning
to accelerate the function entry probe, but just allows user to
put a probe on 'call _mcount' (which can be modified by ftrace).

func:
  endbr  <- sym+0  : INT3 is used. (kp->addr = func+0)
  nop5   <- sym+4? : ftrace is used. (kp->addr = func+4?)
  ...

And anyway, in some case (e.g. perf probe) symbol will be a basement
symbol like '_text' and @offset will be the function addr - _text addr
so that we can put a probe on local-scope function.

If you think we should not probe on the endbr, we should treat the
pair of endbr and nop5 (or call _mcount) instructions as a virtual
single instruction. This means kp->addr should point sym+0, but use
ftrace to probe.

func:
  endbr  <- sym+0  : ftrace is used. (kp->addr = func+0)
  nop5   <- sym+4? : This is not able to be probed.
  ...

Thank you,

> 
> NOTE: irrespective of the above; there is a complication in that
> direct branches to functions are rewritten to not execute ENDBR, so
> any breakpoint thereon might miss lots of actual function executions.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/kprobes/core.c |   11 +++++++++++
>  kernel/kprobes.c               |   15 ++++++++++++---
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -1156,3 +1162,8 @@ int arch_trampoline_kprobe(struct kprobe
>  {
>  	return 0;
>  }
> +
> +bool arch_kprobe_on_func_entry(unsigned long offset)
> +{
> +	return offset <= 4*HAS_KERNEL_IBT;
> +}
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -67,10 +67,19 @@ static bool kprobes_all_disarmed;
>  static DEFINE_MUTEX(kprobe_mutex);
>  static DEFINE_PER_CPU(struct kprobe *, kprobe_instance);
>  
> -kprobe_opcode_t * __weak kprobe_lookup_name(const char *name,
> -					unsigned int __unused)
> +kprobe_opcode_t * __weak kprobe_lookup_name(const char *name, unsigned int offset)
>  {
> -	return ((kprobe_opcode_t *)(kallsyms_lookup_name(name)));
> +	kprobe_opcode_t *addr = NULL;
> +
> +	addr = ((kprobe_opcode_t *)(kallsyms_lookup_name(name)));
> +#ifdef CONFIG_KPROBES_ON_FTRACE
> +	if (addr && !offset) {
> +		unsigned long faddr = ftrace_location((unsigned long)addr);
> +		if (faddr)
> +			addr = (kprobe_opcode_t *)faddr;
> +	}
> +#endif
> +	return addr;
>  }
>  
>  /*
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
