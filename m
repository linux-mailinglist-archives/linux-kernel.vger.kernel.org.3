Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451CD56BF53
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbiGHRIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 13:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiGHRIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 13:08:17 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C12A675A0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 10:08:16 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so1535365wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rjtnXjJTM76a8uBuPAjTSUIAKlaLeiPacD9QEtS4qDw=;
        b=MDtkeEsInPqXPzZim3GXqcRJnQOfNrk0zyh69sg/F7vVFzZs7k4LbrmXCyoJMhe+pk
         hV6nsVlhB1c8j3aePLXYPVgjfKdkU6l80MZxTr3QLcbG11/Pkn1zcGUlv8v9uLrr+Y2R
         zUbnawCQw1MwEaiv2QUN9UWeC6sUxoBqBUMkGsmZnfBgcqnehNvhJ6lSuElTcEB5F4ov
         fnl76H5vXeqI5YM0r2YMAhMa7Oe2ouD2XUJMLO8XC02bnjHKvz8/Z/bRDT6kP06yvLlp
         E3VxyeGZdW978yMpMTQWBWvM8vblfY6+0by9evAAG1hP2wYpL7l/LhvUnhkHrHW2V5+B
         TUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rjtnXjJTM76a8uBuPAjTSUIAKlaLeiPacD9QEtS4qDw=;
        b=3L8NGcXQ6EPv81Jp1J2AKHed0UpIECxCEhXXM3qORX/aKr6JrUDrMw0EbwU0jBBwMm
         2jZtDcvdKXLr/WUL1ywKZsFDIn9HKIgEn8+AJmwzS/vumnCz5+HUw/FTxHTixLsYv0Pc
         tAKiDUX1j0lP9Z5OilUZ0jcmuXjTv/LqIKzoYSTU7fwOg2XnH7tE9n98frhvPmt0IhKX
         YS6qBlLCDrzydaeuHsPzQJGqqsBOHLlgrgs6lUVmrgnJZz77F5b5SeTFp1CxgM1H4FY/
         JgOLxey5ElbZMPjLsK2tu2OFUuuuC9CL3hKNerJWNydcDfvbUIgRggyH1emdednMDtWj
         PzHg==
X-Gm-Message-State: AJIora/vj+m/CCnUwDtNL6TrDhCbiIQnt6RJnxXOQbp8LTExv1QZdqXm
        dUsno99dHaf473w+zDfvDAJMO58+pltzh6AU
X-Google-Smtp-Source: AGRyM1uLwrXqWANfQe+1Wila+2ISVN7BYY7M0YDfWZQ2VfUWRzFwS//um4Nxt9sS7P6MX4Tl60U/tQ==
X-Received: by 2002:a1c:7405:0:b0:3a2:de4f:5f07 with SMTP id p5-20020a1c7405000000b003a2de4f5f07mr840272wmc.117.1657300094872;
        Fri, 08 Jul 2022 10:08:14 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id k9-20020a5d4289000000b0021d9591c64fsm92701wrq.33.2022.07.08.10.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 10:08:14 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        iommu@lists.linux-foundation.org
Cc:     Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH] swiotlb: ensure io_tlb_default_mem spinlock always initialised
Date:   Fri,  8 Jul 2022 18:08:11 +0100
Message-Id: <20220708170811.270589-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the io_tlb_default_mem is used by a device that then gets used
by the swiotlb code, the spinlock warning is triggered causing a
lot of stack-trace.

Fix this by making the structure's lock initialised at build time.

Avoids the following BUG trigger:

[    3.046401] BUG: spinlock bad magic on CPU#3, kworker/u8:0/7
[    3.046689]  lock: io_tlb_default_mem+0x30/0x60, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
[    3.047217] CPU: 3 PID: 7 Comm: kworker/u8:0 Not tainted 5.17.0-00056-g1e9bac738084-dirty #310
[    3.048363] Workqueue: events_unbound deferred_probe_work_func
[    3.048892] Call Trace:
[    3.049224] [<ffffffff800048aa>] dump_backtrace+0x1c/0x24
[    3.049576] [<ffffffff805c5f74>] show_stack+0x2c/0x38
[    3.049898] [<ffffffff805cade2>] dump_stack_lvl+0x40/0x58
[    3.050216] [<ffffffff805cae0e>] dump_stack+0x14/0x1c
[    3.050460] [<ffffffff805c69f6>] spin_dump+0x62/0x6e
[    3.050681] [<ffffffff8004e000>] do_raw_spin_lock+0xb0/0xd0
[    3.050934] [<ffffffff805d5b58>] _raw_spin_lock_irqsave+0x20/0x2c
[    3.051157] [<ffffffff80067e38>] swiotlb_tbl_map_single+0xce/0x3da
[    3.051372] [<ffffffff80068320>] swiotlb_map+0x3a/0x15c
[    3.051668] [<ffffffff80065a56>] dma_map_page_attrs+0x76/0x162
[    3.051975] [<ffffffff8031d542>] dw_pcie_host_init+0x326/0x3f2

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 kernel/dma/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index cb50f8d38360..a707a944c39a 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -65,7 +65,7 @@
 static bool swiotlb_force_bounce;
 static bool swiotlb_force_disable;
 
-struct io_tlb_mem io_tlb_default_mem;
+struct io_tlb_mem io_tlb_default_mem = { .lock = __SPIN_LOCK_UNLOCKED(io_tlb_default_mem.lock) } ;
 
 phys_addr_t swiotlb_unencrypted_base;
 
-- 
2.35.1

