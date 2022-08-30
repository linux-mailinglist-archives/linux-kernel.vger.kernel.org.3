Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B7D5A59BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiH3DM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiH3DMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:12:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914C27F0AA;
        Mon, 29 Aug 2022 20:12:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CBAE6149C;
        Tue, 30 Aug 2022 03:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3779BC433D7;
        Tue, 30 Aug 2022 03:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661829140;
        bh=x0YlO3a82EbZFbjYl7BY0zJYn245uoKtubGXUDLaGC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ukDRAzHO07g70fKxt1F72gzET13k3CKdi6TGw67XNy2I2jKQ0dX2UUJMZ7S0mlp1o
         d3xKlLMdStI83ySBwfacRjQafl2rHkPIHgmkAMmG5gyTJbziyIi00Y245TkrLyO4Er
         O7eW/133ppQIGwlMgaCVq4+DZiFgz+MdnhQikDJ73tZeoj7Z7QK9niPPtEDawZq2YX
         YSlwT/9/v3klOIycd6lmT/zRij+zoL+fhzuXFBr+jerNJcXdtx3Kot7g9Coab2VQqi
         O6O7GrlhjbB/3sugT1V0mOVNi0f6Bba4DY7wjXZoZHXOnfRH+hgJN2/vVQPQBnrQWr
         p5Nu2K73oIU9A==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Date:   Tue, 30 Aug 2022 06:12:01 +0300
Message-Id: <20220830031206.13449-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830031206.13449-1-jarkko@kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sgx_init(), if misc_register() for the provision device fails, and
neither sgx_drv_init() nor sgx_vepc_init() succeeds, then ksgxd will be
prematurely stopped.

This triggers WARN_ON() because sgx_dirty_page_list ends up being
non-empty, and dumps the call stack:

[    0.000000] Linux version 6.0.0-rc2 (root@4beb429beb4a) (gcc (Debian
11.3.0-3) 11.3.0, GNU ld (GNU Binutils for Debian) 2.38) #382 SMP
PREEMPT_DYNAMIC Fri Aug 26 12:52:15 UTC 2022
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.0.0-rc2
root=UUID=56f398e0-1e25-4fda-aa9f-611dece4b333 ro quiet
module_blacklist=psmouse initcall_debug log_buf_len=4M cryptomgr.notests
[…]
[    0.268089] calling  sgx_init+0x0/0x409 @ 1
[    0.268103] sgx: EPC section 0x40200000-0x45f7ffff
[    0.268591] ------------[ cut here ]------------
[    0.268592] WARNING: CPU: 6 PID: 83 at
arch/x86/kernel/cpu/sgx/main.c:401 ksgxd+0x1b7/0x1d0
[    0.268598] Modules linked in:
[    0.268600] CPU: 6 PID: 83 Comm: ksgxd Not tainted 6.0.0-rc2 #382
[    0.268603] Hardware name: Dell Inc. XPS 13 9370/0RMYH9, BIOS 1.21.0
07/06/2022
[    0.268604] RIP: 0010:ksgxd+0x1b7/0x1d0
[    0.268607] Code: ff e9 f2 fe ff ff 48 89 df e8 75 07 0e 00 84 c0 0f
84 c3 fe ff ff 31 ff e8 e6 07 0e 00 84 c0 0f 85 94 fe ff ff e9 af fe ff
ff <0f> 0b e9 7f fe ff ff e8 dd 9c 95 00 66 66 2e 0f 1f 84 00 00 00 00
[    0.268608] RSP: 0000:ffffb6c7404f3ed8 EFLAGS: 00010287
[    0.268610] RAX: ffffb6c740431a10 RBX: ffff8dcd8117b400 RCX:
0000000000000000
[    0.268612] RDX: 0000000080000000 RSI: ffffb6c7404319d0 RDI:
00000000ffffffff
[    0.268613] RBP: ffff8dcd820a4d80 R08: ffff8dcd820a4180 R09:
ffff8dcd820a4180
[    0.268614] R10: 0000000000000000 R11: 0000000000000006 R12:
ffffb6c74006bce0
[    0.268615] R13: ffff8dcd80e63880 R14: ffffffffa8a60f10 R15:
0000000000000000
[    0.268616] FS:  0000000000000000(0000) GS:ffff8dcf25580000(0000)
knlGS:0000000000000000
[    0.268617] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.268619] CR2: 0000000000000000 CR3: 0000000213410001 CR4:
00000000003706e0
[    0.268620] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[    0.268621] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[    0.268622] Call Trace:
[    0.268624]  <TASK>
[    0.268627]  ? _raw_spin_lock_irqsave+0x24/0x60
[    0.268632]  ? _raw_spin_unlock_irqrestore+0x23/0x40
[    0.268634]  ? __kthread_parkme+0x36/0x90
[    0.268637]  kthread+0xe5/0x110
[    0.268639]  ? kthread_complete_and_exit+0x20/0x20
[    0.268642]  ret_from_fork+0x1f/0x30
[    0.268647]  </TASK>
[    0.268648] ---[ end trace 0000000000000000 ]---
[    0.268694] initcall sgx_init+0x0/0x409 returned -19 after 603 usecs

Ultimately this can crash the kernel, if the following is set:

	/proc/sys/kernel/panic_on_warn

Print a simple warning instead, and improve the output by printing the
number of unsanitized pages, in order to provide debug informnation for
future needs.

Link: https://lore.kernel.org/linux-sgx/20220825051827.246698-1-jarkko@kernel.org/T/#u
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Fixes: 51ab30eb2ad4 ("x86/sgx: Replace section->init_laundry_list with sgx_dirty_page_list")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
Cc: Haitao Huang <haitao.huang@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>

v5:
- Add the klog dump and sysctl option to the commit message.

v4:
- Explain expectations for dirty_page_list in the function header, instead
  of an inline comment.
- Improve commit message to explain the conditions better.
- Return the number of pages left dirty to ksgxd() and print warning after
  the 2nd call, if there are any.

v3:
- Remove WARN_ON().
- Tuned comments and the commit message a bit.

v2:
- Replaced WARN_ON() with optional pr_info() inside
  __sgx_sanitize_pages().
- Rewrote the commit message.
- Added the fixes tag.
---
 arch/x86/kernel/cpu/sgx/main.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 515e2a5f25bb..903100fcfce3 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -49,17 +49,20 @@ static LIST_HEAD(sgx_dirty_page_list);
  * Reset post-kexec EPC pages to the uninitialized state. The pages are removed
  * from the input list, and made available for the page allocator. SECS pages
  * prepending their children in the input list are left intact.
+ *
+ * Contents of the @dirty_page_list must be thread-local, i.e.
+ * not shared by multiple threads.
  */
-static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
+static int __sgx_sanitize_pages(struct list_head *dirty_page_list)
 {
 	struct sgx_epc_page *page;
+	int left_dirty = 0;
 	LIST_HEAD(dirty);
 	int ret;
 
-	/* dirty_page_list is thread-local, no need for a lock: */
 	while (!list_empty(dirty_page_list)) {
 		if (kthread_should_stop())
-			return;
+			break;
 
 		page = list_first_entry(dirty_page_list, struct sgx_epc_page, list);
 
@@ -92,12 +95,14 @@ static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
 		} else {
 			/* The page is not yet clean - move to the dirty list. */
 			list_move_tail(&page->list, &dirty);
+			left_dirty++;
 		}
 
 		cond_resched();
 	}
 
 	list_splice(&dirty, dirty_page_list);
+	return left_dirty;
 }
 
 static bool sgx_reclaimer_age(struct sgx_epc_page *epc_page)
@@ -388,6 +393,8 @@ void sgx_reclaim_direct(void)
 
 static int ksgxd(void *p)
 {
+	int left_dirty;
+
 	set_freezable();
 
 	/*
@@ -395,10 +402,10 @@ static int ksgxd(void *p)
 	 * required for SECS pages, whose child pages blocked EREMOVE.
 	 */
 	__sgx_sanitize_pages(&sgx_dirty_page_list);
-	__sgx_sanitize_pages(&sgx_dirty_page_list);
 
-	/* sanity check: */
-	WARN_ON(!list_empty(&sgx_dirty_page_list));
+	left_dirty = __sgx_sanitize_pages(&sgx_dirty_page_list);
+	if (left_dirty)
+		pr_warn("%d unsanitized pages\n", left_dirty);
 
 	while (!kthread_should_stop()) {
 		if (try_to_freeze())
-- 
2.37.2

