Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92DD4922EB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345769AbiARJiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:38:05 -0500
Received: from unknown-3-146.windriver.com ([147.11.3.146]:10400 "EHLO
        mail1.wrs.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230172AbiARJiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:38:04 -0500
X-Greylist: delayed 1051 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jan 2022 04:38:04 EST
Received: from mail.windriver.com (mail.wrs.com [147.11.1.11])
        by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 20I9Jttq032351
        (version=TLSv1.1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 18 Jan 2022 01:19:56 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 20I9JtAZ010520
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Jan 2022 01:19:55 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 18 Jan 2022 01:19:54 -0800
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 18 Jan 2022 01:19:54 -0800
Received: from pek-lpd-ccm3.wrs.com (128.224.156.163) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Tue, 18 Jan 2022 01:19:53 -0800
From:   Dongyang Wang <dongyang.wang@windriver.com>
To:     <christian.brauner@ubuntu.com>, <akpm@linux-foundation.org>,
        <ebiederm@xmission.com>, <legion@kernel.org>,
        <varad.gautam@suse.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] To fix the below failure of handling page fault caused by the invalid input from user.
Date:   Tue, 18 Jan 2022 17:19:52 +0800
Message-ID: <20220118091952.37001-1-dongyang.wang@windriver.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[786058.308965] Unable to handle kernel paging request at virtual address 01000004
[786058.316286] pgd = 38a99693
[786058.319080] [01000004] *pgd=07800003, *pmd=00000000
[786058.324056] Internal error: Oops: 206 [#1] PREEMPT SMP ARM
[786058.324100] CPU:  PID: Comm:  Tainted: G         C
[786058.324102] Hardware name:
[786058.324114] PC is at __copy_to_user_std+0x4c/0x3c4
[786058.324120] LR is at store_msg+0xc0/0xe8
[786058.324124] pc : [<c0c0587c>]    lr : [<c0871d04>]    psr: 20010013
[786058.324126] sp : c3503ec4  ip : 00000000  fp : b4c9a660
[786058.324129] r10: c4228dc0  r9 : c3502000  r8 : 00000ffc
[786058.324132] r7 : 01000000  r6 : 546d3f8b  r5 : b4911690  r4 : 00000ffc
[786058.324134] r3 : 00000000  r2 : 00000f7c  r1 : 01000004  r0 : b4911690
[786058.324139] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[786058.324142] Control: 30c5387d  Table: 0edc2040  DAC: 55555555
[786058.324145] Process  (pid: , stack limit = 0x25018bdf)
[786058.324148] Stack: (0xc3503ec4 to 0xc3504000)
[786058.324153] 3ec0:          b4911690 546d3f8b 01000000 00000ffc b4911690 00000ffc 00000000
[786058.324157] 3ee0: 00000ffc c0871d04 546d4f73 c3407801 c3503f28 c3407800 00000000 b49106a8
[786058.324161] 3f00: c4228dc0 c087abd4 00000002 b49106a8 617b9d03 00000000 00000000 c121d508
[786058.324165] 3f20: 00000000 bf06a1a8 d1b634cc 16b26e77 c5af5280 00000100 00000200 db806540
[786058.324170] 3f40: 00000001 c121d508 00000008 0000005c 00000000 00010008 b49106a8 c0601208
[786058.324173] 3f60: c3502000 00000040 b4c9a660 c087b474 c3503f78 c121d508 617b9d03 00000000
[786058.324177] 3f80: 2303d6cc 00000115 c0601208 c121d508 b4c9a660 b4c9a660 00000001 b49106a8
[786058.324181] 3fa0: 00000115 c06011dc b4c9a660 00000001 0000005c b49106a8 00010008 00000000
[786058.324185] 3fc0: b4c9a660 00000001 b49106a8 00000115 00000000 b4c9b400 00000000 b4c9a660
[786058.324189] 3fe0: 00000115 b4c9a650 b6b253bd b6b254b6 800d0030 0000005c 00000000 00000000
[786058.324201] [<c0c0587c>] (__copy_to_user_std) from [<c0871d04>] (store_msg+0xc0/0xe8)
[786058.324211] [<c0871d04>] (store_msg) from [<c087abd4>] (do_mq_timedreceive+0x29c/0x484)
[786058.324218] [<c087abd4>] (do_mq_timedreceive) from [<c087b474>] (sys_mq_timedreceive+0x88/0xbc)
[786058.324226] [<c087b474>] (sys_mq_timedreceive) from [<c06011dc>] (__sys_trace_return+0x0/0x10)
[786058.324229] Exception stack(0xc3503fa8 to 0xc3503ff0)
[786058.324233] 3fa0:                   b4c9a660 00000001 0000005c b49106a8 00010008 00000000
[786058.324236] 3fc0: b4c9a660 00000001 b49106a8 00000115 00000000 b4c9b400 00000000 b4c9a660
[786058.324239] 3fe0: 00000115 b4c9a650 b6b253bd b6b254b6
[786058.324247] Code: ba000002 f5d1f03c f5d1f05c f5d1f07c (e8b151f8)
[786058.601808] ---[ end trace 0000000000000002 ]---

Signed-off-by: Fuchun Sun <fuchun.sun@windriver.com>
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Signed-off-by: Jing Zhang <Jing.Zhang@windriver.com>
Signed-off-by: Dongyang Wang <dongyang.wang@windriver.com>
---
 ipc/mqueue.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 5becca9be867c..c904400f8fd9f 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1211,6 +1211,12 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
 		goto out_fput;
 	}
 
+	/* checks if buffer is invalid */
+	if ((unsigned long) u_msg_ptr < PAGE_SIZE) {
+		ret = -EINVAL;
+		goto out_fput;
+	}
+
 	/*
 	 * msg_insert really wants us to have a valid, spare node struct so
 	 * it doesn't have to kmalloc a GFP_ATOMIC allocation, but it will
@@ -1262,6 +1268,10 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
 			store_msg(u_msg_ptr, msg_ptr, msg_ptr->m_ts)) {
 			ret = -EFAULT;
 		}
+
+		if (msg_len < ret)
+			ret = -EMSGSIZE;
+
 		free_msg(msg_ptr);
 	}
 out_fput:
-- 
2.26.1

