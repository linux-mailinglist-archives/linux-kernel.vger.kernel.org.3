Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666AE4F533E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 06:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392391AbiDFDkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 23:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2360329AbiDFD3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 23:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 886284F9D4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 17:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649203506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rVxMyqFU/MnAj54r01ob7SoIRTM/hdrBYXIVayM4vfo=;
        b=hiEEuFSTWCvB6/qlKso7HHv/Ow6v/Xdd8CkBpI2IqEd4DtnkT2Ave/EyL9B7+uFLLBPCd9
        snXYS5lVkB+qeoVV9DID6/BT3oDHPQbsZ9m521E3Add4VB8cdd7w+vxGC/Gl0Fw2zTX8/N
        GACFoqH0+cvY+f6mfx2N3XvwS4/KhnA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-mTE7PLCzPx6dzag1y__DTQ-1; Tue, 05 Apr 2022 20:05:05 -0400
X-MC-Unique: mTE7PLCzPx6dzag1y__DTQ-1
Received: by mail-qv1-f71.google.com with SMTP id e10-20020a0562140d8a00b00443c3595342so1446648qve.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 17:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rVxMyqFU/MnAj54r01ob7SoIRTM/hdrBYXIVayM4vfo=;
        b=fqLBRplKYmxLtLa+KtCH1wiLDFAUWhr8InwCBcWJgeutavQ9NYLsJ3lp69Hx7iXpH0
         484xyxsLs3WI2z2XY0LDt/ROtcA84UyqelZOwiF+/N7PFIGwU8sl++DNspiPOTd4ARmb
         DpcpWKpJChx2macQm28vRKPJdiw5tdTSlptdvE/+6euqV/uX9JxziFWU5wUW+gaOJyAn
         FreWWnM9CewM2ACofKARpbEHpBODIIVLOkndz5Dq7bZvbr1PvAsX0a3N+uJvWWKbb35G
         5iJOoTqCwfbQnNKK18SiBLTyCPZLpWmmSZHNwzT0mxbwUS+ak76PRjscvA0nUoS995wX
         3fWA==
X-Gm-Message-State: AOAM5329mHwFTDZVVGMyD4FksMSeXoH9QmvFkvNzuL2KJhzZKGnxgTbN
        jTwgjtmimsGmUxmo0wdJP7U7ZxoIpxYMXvJyhZ7KNcWQvF7yZ+Zv4Hqe+0fHBHWA5Fk/BN4R7Vb
        yhrh2wLaPv0OyOAICI09EOebU
X-Received: by 2002:ac8:7e8e:0:b0:2eb:8e71:8dcc with SMTP id w14-20020ac87e8e000000b002eb8e718dccmr5307251qtj.67.1649203504883;
        Tue, 05 Apr 2022 17:05:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+JdKga3+njuZkWIRBw5ly5Cv49rUEh27nzn8a7zk20PzHHM9n4BBsgFWjAQhk+eM6b7Tp3Q==
X-Received: by 2002:ac8:7e8e:0:b0:2eb:8e71:8dcc with SMTP id w14-20020ac87e8e000000b002eb8e718dccmr5307238qtj.67.1649203504634;
        Tue, 05 Apr 2022 17:05:04 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id y7-20020a05620a0e0700b00699a30d6d10sm8140405qkm.111.2022.04.05.17.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 17:05:04 -0700 (PDT)
Date:   Tue, 5 Apr 2022 17:05:00 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, mbenes@suse.cz, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: drivers/gpu/drm/i915/i915.prelink.o: warning: objtool:
 __intel_wait_for_register_fw.cold()+0xce: relocation to !ENDBR:
 vlv_allow_gt_wake.cold+0x0
Message-ID: <20220406000500.5hlaqy5zrdqsg5mg@treble>
References: <202204041241.Hw855BWm-lkp@intel.com>
 <YkxLqznOz0ldTz5a@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YkxLqznOz0ldTz5a@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 04:01:15PM +0200, Peter Zijlstra wrote:
> Subject: objtool/ibt: Allow _THIS_IP_ at: sym+len
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue Apr  5 15:54:41 CEST 2022
> 
> 0day robot reported:
> 
>   drivers/gpu/drm/i915/i915.prelink.o: warning: objtool: __intel_wait_for_register_fw.cold()+0xce: relocation to !ENDBR: vlv_allow_gt_wake.cold+0x0
> 
> Which turns out to be GCC placing a _THIS_IP_ past the end of the
> function:
> 
> 0000000000001d00 <__intel_wait_for_register_fw.cold>:
>     ...
>     1dce:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi        1dd1: R_X86_64_32S      .text.unlikely+0x1df8
>     1dd5:       e8 00 00 00 00          call   1dda <__intel_wait_for_register_fw.cold+0xda>    1dd6: R_X86_64_PLT32    __trace_bprintk-0x4
>     ...
>     1df6:       0f 0b                   ud2
> 
> Add an exception for this one weird case...
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

But objtool is complaining about a real problem (albeit with a cryptic
warning).  I don't think we want to paper over that. See patch.

Also, are in-tree users of trace_printk() even allowed??

From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] tracing: Fix _THIS_IP_ usage in trace_printk()

do_trace_printk() uses the _THIS_IP_ macro to save the current
instruction pointer as an argument to a called function.  However,
because _THIS_IP_ relies on an empty label hack to get the IP, the
compiler is actually free to place the label anywhere in the function,
including at the very end -- which, since the label doesn't actually
have any code, is technically at the beginning of whatever function
happens to come next.

For example:

      1d89:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
  			1d8c: R_X86_64_32S	.text.unlikely+0x1d3a
      1d90:	e8 00 00 00 00       	callq  1d95 <__intel_wait_for_register_fw.cold+0xd4>
  			1d91: R_X86_64_PLT32	__trace_bprintk-0x4
      1d95:	e8 00 00 00 00       	callq  1d9a <__intel_wait_for_register_fw.cold+0xd9>
  			1d96: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
      1d9a:	bf 01 00 00 00       	mov    $0x1,%edi
      1d9f:	e8 00 00 00 00       	callq  1da4 <__intel_wait_for_register_fw.cold+0xe3>
  			1da0: R_X86_64_PLT32	ftrace_dump-0x4
      1da4:	31 f6                	xor    %esi,%esi
      1da6:	bf 09 00 00 00       	mov    $0x9,%edi
      1dab:	e8 00 00 00 00       	callq  1db0 <__intel_wait_for_register_fw.cold+0xef>
  			1dac: R_X86_64_PLT32	add_taint-0x4
      1db0:	90                   	nop
      1db1:	0f 0b                	ud2

  0000000000001db3 <vlv_allow_gt_wake.cold>:

In this case _THIS_IP_ causes the instruction at 0x1d89 to reference the
next function.  This results in a semi-cryptic objtool warning:

  warning: objtool: __intel_wait_for_register_fw.cold()+0xce: relocation to !ENDBR: vlv_allow_gt_wake.cold+0x

While _THIS_IP_ is inherently imprecise, we can at least coddle the
compiler into putting the label *before* the call by using _THIS_IP_
immediately before the call instead of as an argument to the call.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 include/linux/kernel.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 08ba5995aa8b..c399b29840eb 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -390,13 +390,15 @@ do {									\
 	static const char *trace_printk_fmt __used			\
 		__section("__trace_printk_fmt") =			\
 		__builtin_constant_p(fmt) ? fmt : NULL;			\
+	unsigned long __ip;						\
 									\
 	__trace_printk_check_format(fmt, ##args);			\
 									\
+	__ip = _THIS_IP_;						\
 	if (__builtin_constant_p(fmt))					\
-		__trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);	\
+		__trace_bprintk(__ip, trace_printk_fmt, ##args);	\
 	else								\
-		__trace_printk(_THIS_IP_, fmt, ##args);			\
+		__trace_printk(__ip, fmt, ##args);			\
 } while (0)
 
 extern __printf(2, 3)
-- 
2.34.1

