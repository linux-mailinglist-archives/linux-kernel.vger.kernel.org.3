Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01704F5665
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 08:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352845AbiDFFuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 01:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446731AbiDFE5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 00:57:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1518202155
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 17:46:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649205983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mhpo2Erwb4Hr62Oe++KrjfRdUmCMgVLEH3CRGWnSUZU=;
        b=VVCsLwCe9WroduPZLTOprTutk2/LjIHSHCoAMcbDcDQf3TSRxDVLJ9paBfFKHyEYYjolzw
        SeCqLE8Ym+eiEKX2EEvkBb9/2wwVp6+fTjvcbGuK0ZZXlzxCYQ43tIu90Lni2hbxl+x1SC
        rdgj5x7Z+ORnTN4gLLhIWZbZ47EntLimz8muiIsGNescmkqDk9F3nDe/lgGIY4y94XzV/B
        A87NsTFKqxXN4SuHdLy6fby9+5b8lDMYC3WBqDSLIgjc8YlSrVsDrabcqe9mLzECKfi02y
        k7ECoAxDmfL9I/befIKDot+182tTutJGU5ejv/KeOsVjknrNzIqkGcR4W8e1ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649205983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mhpo2Erwb4Hr62Oe++KrjfRdUmCMgVLEH3CRGWnSUZU=;
        b=bigqMih2qo6UghO2aXG8VmXwyOAhcsqT19RjrMOzUYbpYh3rmGh4257RDT8mWJhU/H2+Sq
        I9BiGflJ0eD58KAg==
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, mbenes@suse.cz, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: drivers/gpu/drm/i915/i915.prelink.o: warning: objtool:
 __intel_wait_for_register_fw.cold()+0xce: relocation to !ENDBR:
 vlv_allow_gt_wake.cold+0x0
In-Reply-To: <20220406000500.5hlaqy5zrdqsg5mg@treble>
References: <202204041241.Hw855BWm-lkp@intel.com>
 <YkxLqznOz0ldTz5a@hirez.programming.kicks-ass.net>
 <20220406000500.5hlaqy5zrdqsg5mg@treble>
Date:   Wed, 06 Apr 2022 02:46:22 +0200
Message-ID: <87czhv11k1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05 2022 at 17:05, Josh Poimboeuf wrote:
> On Tue, Apr 05, 2022 at 04:01:15PM +0200, Peter Zijlstra wrote:
>
> But objtool is complaining about a real problem (albeit with a cryptic
> warning).  I don't think we want to paper over that. See patch.
>
> Also, are in-tree users of trace_printk() even allowed??

See the comment in the header file you are patching:

 * This is intended as a debugging tool for the developer only.
 * Please refrain from leaving trace_printks scattered around in
 * your code. (Extra memory is used for special buffers that are
 * allocated when trace_printk() is used.)

....

> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH] tracing: Fix _THIS_IP_ usage in trace_printk()
>
> do_trace_printk() uses the _THIS_IP_ macro to save the current
> instruction pointer as an argument to a called function.  However,
> because _THIS_IP_ relies on an empty label hack to get the IP, the
> compiler is actually free to place the label anywhere in the function,
> including at the very end -- which, since the label doesn't actually
> have any code, is technically at the beginning of whatever function
> happens to come next.
>
> For example:
>
>       1d89:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
>   			1d8c: R_X86_64_32S	.text.unlikely+0x1d3a
>       1d90:	e8 00 00 00 00       	callq  1d95 <__intel_wait_for_register_fw.cold+0xd4>
>   			1d91: R_X86_64_PLT32	__trace_bprintk-0x4
>       1d95:	e8 00 00 00 00       	callq  1d9a <__intel_wait_for_register_fw.cold+0xd9>
>   			1d96: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
>       1d9a:	bf 01 00 00 00       	mov    $0x1,%edi
>       1d9f:	e8 00 00 00 00       	callq  1da4 <__intel_wait_for_register_fw.cold+0xe3>
>   			1da0: R_X86_64_PLT32	ftrace_dump-0x4
>       1da4:	31 f6                	xor    %esi,%esi
>       1da6:	bf 09 00 00 00       	mov    $0x9,%edi
>       1dab:	e8 00 00 00 00       	callq  1db0 <__intel_wait_for_register_fw.cold+0xef>
>   			1dac: R_X86_64_PLT32	add_taint-0x4
>       1db0:	90                   	nop
>       1db1:	0f 0b                	ud2
>
>   0000000000001db3 <vlv_allow_gt_wake.cold>:
>
> In this case _THIS_IP_ causes the instruction at 0x1d89 to reference the
> next function.  This results in a semi-cryptic objtool warning:
>
>   warning: objtool: __intel_wait_for_register_fw.cold()+0xce: relocation to !ENDBR: vlv_allow_gt_wake.cold+0x
>
> While _THIS_IP_ is inherently imprecise, we can at least coddle the
> compiler into putting the label *before* the call by using _THIS_IP_
> immediately before the call instead of as an argument to the call.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  include/linux/kernel.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 08ba5995aa8b..c399b29840eb 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -390,13 +390,15 @@ do {									\
>  	static const char *trace_printk_fmt __used			\
>  		__section("__trace_printk_fmt") =			\
>  		__builtin_constant_p(fmt) ? fmt : NULL;			\
> +	unsigned long __ip;						\
>  									\
>  	__trace_printk_check_format(fmt, ##args);			\
>  									\
> +	__ip = _THIS_IP_;						\
>  	if (__builtin_constant_p(fmt))					\
> -		__trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);	\
> +		__trace_bprintk(__ip, trace_printk_fmt, ##args);	\
>  	else								\
> -		__trace_printk(_THIS_IP_, fmt, ##args);			\
> +		__trace_printk(__ip, fmt, ##args);			\
>  } while (0)
>  
>  extern __printf(2, 3)

This covers the trace_printk() case which uses do_trace_printk(), but
the same problem exists in trace_puts() and ftrace_vprintk()...., no?

Thanks,

        tglx
