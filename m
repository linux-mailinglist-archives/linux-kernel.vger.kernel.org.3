Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD2E55C3F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345172AbiF1K54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343573AbiF1K5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:57:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5589831DC0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZbTA/j68aTlnjcY67lJUFPEb0duybQF4bMVkW5X3NhM=; b=e2Ri/2lcEWImxKOYbuWXDJab/L
        WTKvECRA4e1ANNzivqZkYLgjqDqC13sVC/M0PvAtkY4L4OQSUzgekng0FROzIFJucxtNWDugyBuF/
        2a85Q5YyJ5l7nrn7EEm+P76WF1EMJ99A70rYUCBwdX3U/PjKkLUBdkpWDX9jCCNWvXs69ydzFtODg
        aNuoZ2wHh46bOwQkDwyoTSJODWhv7zKHNFBx/vBE0UE/vTfe2+/4CMtIcQHnXYL5AP21UCVO/d753
        v0MU+0L+3oBW8jSCL8v9uPSeQS7WEhpMs2SQpZjA7oIIOFtl8be4aeF7YXAbRfd09uPz1cbvw39E1
        aKZDBJuw==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o68ue-00CDvJ-LD; Tue, 28 Jun 2022 10:57:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B30E3003B0;
        Tue, 28 Jun 2022 12:57:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A9472020A5BD; Tue, 28 Jun 2022 12:57:42 +0200 (CEST)
Date:   Tue, 28 Jun 2022 12:57:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     Zijlstra Peter <peter.zijlstra@intel.com>,
        Su Heng <heng.su@intel.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: There was missing ENDBR BUG in 5.19-rc3 mainline kernel on TGL-U
Message-ID: <Yrrepdaow4F5kqG0@hirez.programming.kicks-ass.net>
References: <Yrq7yrxxsd8WAGm7@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrq7yrxxsd8WAGm7@xpf.sh.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 04:28:58PM +0800, Pengfei Xu wrote:
> Hi Peter,
> 
>   Greeting!
> 
>   We found one "missing ENDBR BUG" on 5.19-rc3 kernel.
> 
>   Platform: TGL-U
>   Kernel: 5.19-rc3 mainline
> 
>   1. Boot up TGL-U
>   2. Execute kernel self-test shell script "ftracetest" in
>      kernel_source/tools/testing/selftests/ftrace/
> # ./ftracetest
> === Ftrace unit tests ===
> [1] Basic trace file check      [PASS]
> [2] Basic test for tracers      [PASS]
> [3] Basic trace clock test      [PASS]
> [4] Basic event tracing check   [PASS]
> [5] Change the ringbuffer size  [PASS]
> [6] Snapshot and tracing setting        [PASS]
> [7] trace_pipe and trace_marker [PASS]
> [8] Test ftrace direct functions against tracers        [UNRESOLVED]
> [9] Test ftrace direct functions against kprobes        [UNRESOLVED]
> [10] Generic dynamic event - add/remove eprobe events   [FAIL]
> [11] Generic dynamic event - add/remove kprobe events
> 
> It 100% reproduced in step 11 and then missing ENDBR BUG generated:
> "
> [ 9332.752836] mmiotrace: enabled CPU7.
> [ 9332.788612] mmiotrace: disabled.
> [ 9337.103426] traps: Missing ENDBR: syscall_regfunc+0x0/0xb0
> [ 9337.103442] ------------[ cut here ]------------
> [ 9337.103444] kernel BUG at arch/x86/kernel/traps.c:253!
> [ 9337.103452] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> ...
> [ 9337.103506] Call Trace:
> ...
> [ 9337.103512]  asm_exc_control_protection+0x30/0x40
> ...
> [ 9337.103540]  ? trace_module_has_bad_taint+0x20/0x20
> [ 9337.103547]  ? tracepoint_add_func+0x15f/0x360
> [ 9337.103551]  ? perf_syscall_enter+0x1f0/0x1f0
> [ 9337.103556]  tracepoint_probe_register_prio+0x5c/0x90
> [ 9337.103560]  ? perf_syscall_enter+0x1f0/0x1f0
> "
> 
> Dmesg was in attached.
> Do I need to do something further for this problem?

your .config would perhaps have been useful... and a Cc to lkml.

defconfig + kvm_guest.config + x86_debug.config + X86_KERNEL_IBT + lot
of tracing options gets me:

$ ./scripts/objdump-func defconfig-build/vmlinux.o syscall_regfunc
0000 0000000000181120 <syscall_regfunc>:
0000   181120:  f3 0f 1e fa             endbr64
...

So the function does have an ENDBR on for me. Now the other possibility
is that that ENDBR got scribbled by the sealing.

$ readelf -Wa defconfig-build/vmlinux.o | awk '/Relocation section.*ibt_endbr_seal/ { P=1 } /^$/ { if (P) exit } { if (P) print $0 }' | grep 181120
00000000000022a8  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 181120

And yes, that's it. So objtool somehow misses that the address of this
function is taken.

If we grep around:

$ git grep syscall_regfunc
include/linux/tracepoint.h:extern int syscall_regfunc(void);
include/trace/events/syscalls.h:        syscall_regfunc, syscall_unregfunc
include/trace/events/syscalls.h:        syscall_regfunc, syscall_unregfunc
kernel/tracepoint.c:int syscall_regfunc(void)

we find it is only used in tracepoints, which then suggests the
following patch:

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 864bb9dd3584..57153e00349c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3826,8 +3826,7 @@ static int validate_ibt(struct objtool_file *file)
 		    !strcmp(sec->name, "__bug_table")			||
 		    !strcmp(sec->name, "__ex_table")			||
 		    !strcmp(sec->name, "__jump_table")			||
-		    !strcmp(sec->name, "__mcount_loc")			||
-		    !strcmp(sec->name, "__tracepoints"))
+		    !strcmp(sec->name, "__mcount_loc"))
 			continue;
 
 		list_for_each_entry(reloc, &sec->reloc->reloc_list, list)

And that does indeed seems to do the trick!
