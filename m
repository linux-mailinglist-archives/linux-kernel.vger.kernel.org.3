Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703C651F843
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238004AbiEIJeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237940AbiEIJVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:21:24 -0400
Received: from mail.codelabs.ch (mail.codelabs.ch [IPv6:2a02:168:860f:1::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453A71A0AFE
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:17:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.codelabs.ch (Postfix) with ESMTP id C21CD220002;
        Mon,  9 May 2022 11:07:15 +0200 (CEST)
Received: from mail.codelabs.ch ([127.0.0.1])
        by localhost (fenrir.codelabs.ch [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PsW_K7vs4HTv; Mon,  9 May 2022 11:07:14 +0200 (CEST)
Received: from zaphod.codelabs.ch (unknown [192.168.10.129])
        by mail.codelabs.ch (Postfix) with ESMTPSA id 115D2220001;
        Mon,  9 May 2022 11:07:14 +0200 (CEST)
From:   Adrian-Ken Rueegsegger <ken@codelabs.ch>
To:     dave.hansen@linux.intel.com, osalvador@suse.de
Cc:     david@redhat.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Adrian-Ken Rueegsegger <ken@codelabs.ch>
Subject: Unhandled page fault in vmemmap_populate on x86_64
Date:   Mon,  9 May 2022 11:06:36 +0200
Message-Id: <20220509090637.24152-1-ken@codelabs.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

While running Linux 5.15.32/x86_64 (with some out-of-tree patches) on top of
Muen [1], I came across a BUG/page fault triggered in vmemmap_populate:

[    0.000000] BUG: unable to handle page fault for address: ffffea0001e00000
[    0.000000] #PF: supervisor write access in kernel mode
[    0.000000] #PF: error_code(0x0002) - not-present page
[    0.000000] PGD 1003a067 P4D 1003a067 PUD 10039067 PMD 0 
[    0.000000] Oops: 0002 [#1] SMP PTI
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.32-muen #1
[    0.000000] RIP: 0010:vmemmap_populate+0x181/0x218
[    0.000000] Code: 00 a9 ff ff 1f 00 0f 84 a1 00 00 00 e8 91 f7 ff ff b9 0e 00 00 00 31 c0 48 89 ef f3 ab 48 85 f6 74 0a b0 fd 48 89 ef 48 89 f1 <f3> aa 4d 85 c0 74 7c 48 89 1d 2e e2 05 00 eb 73 48 83 3c 24 00 0f
[    0.000000] RSP: 0000:ffffffff82003e00 EFLAGS: 00010006
[    0.000000] RAX: 00000000000000fd RBX: ffffea0001e00000 RCX: 0000000000180000
[    0.000000] RDX: ffffea0000540000 RSI: 00000000001c0000 RDI: ffffea0001e00000
[    0.000000] RBP: ffffea0001dc0000 R08: 0000000000000000 R09: 0000000088000000
[    0.000000] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[    0.000000] R13: ffffea0001f80000 R14: ffffea0001dc0000 R15: ffff888010039070
[    0.000000] FS:  0000000000000000(0000) GS:ffffffff823ea000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffea0001e00000 CR3: 000000000200a000 CR4: 00000000000406b0
[    0.000000] DR0: 000000000000003a DR1: 0000000000000003 DR2: 0000000000000000
[    0.000000] DR3: ffffea0001e00000 DR6: 000000000200a000 DR7: ffffffff82003d58
[    0.000000] Call Trace:
[    0.000000]  <TASK>
[    0.000000]  ? __populate_section_memmap+0x3a/0x47
[    0.000000]  ? sparse_init_nid+0xc9/0x174
[    0.000000]  ? sparse_init+0x1c1/0x1d2
[    0.000000]  ? paging_init+0x5/0xa
[    0.000000]  ? setup_arch+0x740/0x810
[    0.000000]  ? start_kernel+0x43/0x5bb
[    0.000000]  ? secondary_startup_64_no_verify+0xb0/0xbb
[    0.000000]  </TASK>
[    0.000000] Modules linked in:
[    0.000000] CR2: ffffea0001e00000
[    0.000000] random: get_random_bytes called from init_oops_id+0x1d/0x2c with crng_init=0
[    0.000000] ---[ end trace 44fe402cfef775de ]---

Announcing an available RAM region at 0x88000000 to Linux (via e820) triggered
the issue while placing it at 0x70000000 did not hit the bug. Since the problem
had not been observed with 5.10, I did a bisect which pointed to commit
8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges") as the culprit.
Further debugging showed that the #PF originates from vmemmap_use_new_sub_pmd
in arch/x86/mm/init_64.c. In the error case the condition
!IS_ALIGNED(start, PMD_SIZE) evaluates to true and the page-fault is caused by
the memset marking the preceding region as unused:

    if (!IS_ALIGNED(start, PMD_SIZE))
        memset((void *)start, PAGE_UNUSED,
               start - ALIGN_DOWN(start, PMD_SIZE));

If I am not mistaken, the start variable is the wrong address to use here,
since it points to the beginning of the range that is to be *used*. Instead the
"start" of the PMD should be used, i.e. ALIGN_DOWN(start, PMD_SIZE). Looking at
arch/s390/mm/vmem.c, vmemmap_use_new_sub_pmd seems to confirm this. Is the
above analysis correct or did I misread the code?

The attached patch fixes the observed issue for me.

Regards,
Adrian

PS: When replying please include my address as to/cc since I am not subscribed
to LKML, thanks!

[1] - https://muen.sk
