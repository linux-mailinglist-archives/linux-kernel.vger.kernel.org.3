Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C2A4BAB49
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243395AbiBQUwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:52:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiBQUwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:52:11 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F0A255B3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 12:51:53 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id c10so1246960ljr.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 12:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ZiDUkCYJFO1OHRaVO1/kwEux4anXgQqPRU7RhCvElE=;
        b=jMdlK5xyQg0PxJfQGKnYHUnmQoVNafMhSFPxDOLfSTKJCLlq4b3yJDSJ5vlCPDvqqo
         tZRG8DbXjXRbAqsOHyAxpCpqLwz9Cjr8tW/+xNghgW0pqxILNg+x9G1d3tJjrLpD54xK
         mmmPX8e8HM+qg5T6vA6XqWQ5dPnz7e0UgCQHkUssv+jacs2ClE74WVaSWxntSVY+tF+H
         uE1tiyVLO9ER9aC/ldRQkf/0F9rHL7+/xZQe/nkLseI9BAIkrqQmmpn3m07xmRxNDP1R
         6+3TSubyIraHVx2dgIjNlEI06rGh9lJAbyqtSjmYa4i1B6l3TtU33srUBcZYzH4qJbQf
         74dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ZiDUkCYJFO1OHRaVO1/kwEux4anXgQqPRU7RhCvElE=;
        b=AmGtgD7+JaV6v6RzrJqJbaUlfS4vuSiJ81YRP2tX76F9BGVT8KCt4HZDG2Zsl+R8C7
         QRzbB+RWfB47sbIqdy0dR+q9KU4DIAzjad5Tp+Yk/VNSOa90SAVtrBgwH7h74TjZEt4s
         59TyIB04ml8hKgOUJj3IXznrxNN7IfoE1hYZnz2kT3H8QDAN7zJGvGkI9IEYMl+uIs4o
         sFh+PDrH45pcnK7jAeNdB9ii/IzJHqAmfoiuXCjYLcyKOeTWwRkXFVJJ+Aj5sWJtu4n/
         Lcc3jvy5jFnzToMSsYsUIufT6zOx1JPLBe/FGBP/susZwjYP/mYmPuMAnKGjHcGKrSN1
         9gaQ==
X-Gm-Message-State: AOAM5331UrKFXHZRPgPoDB1BkEtAA6snVqjIIHOvCRhS95p2cxf6PBWZ
        BCgoIWXAgJj7OL/k4vRlVxYZeE3sSuM9SixM
X-Google-Smtp-Source: ABdhPJzdI5/FgG6Qac5fqy66PTplck6g3JrVarPKz4VuW/5CEH3YItG5A4KZnGatg8oS1YHYlfgNRw==
X-Received: by 2002:a05:651c:1594:b0:239:9df5:f447 with SMTP id h20-20020a05651c159400b002399df5f447mr3361080ljq.463.1645131111631;
        Thu, 17 Feb 2022 12:51:51 -0800 (PST)
Received: from TebraArch.. ([81.198.232.185])
        by smtp.gmail.com with ESMTPSA id e16sm66319lfs.67.2022.02.17.12.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 12:51:51 -0800 (PST)
From:   =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
Subject: [PATCH] dmaengine: fix dma_issue_pending_all to work with async channel removal
Date:   Thu, 17 Feb 2022 22:51:47 +0200
Message-Id: <20220217205147.35586-1-davispuh@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma channels can be removed asynchronously while we iterate over them so fix that.

Without this fix we would dereference null pointer when dma_issue_pending_all
is invoked while some different device is being unloaded.

kernel: BUG: kernel NULL pointer dereference, address: 0000000000000018
kernel: #PF: supervisor read access in kernel mode
kernel: #PF: error_code(0x0000) - not-present page
kernel: PGD 0 P4D 0
kernel: Oops: 0000 [#1] PREEMPT SMP NOPTI
kernel: RIP: 0010:dma_issue_pending_all (drivers/dma/dmaengine.c:562)
All code
========
   0:   48 8b 45 20             mov    0x20(%rbp),%rax
   4:   48 8d 68 e0             lea    -0x20(%rax),%rbp
   8:   48 3d 60 36 35 bc       cmp    $0xffffffffbc353660,%rax
   e:   74 4d                   je     0x5d
  10:   48 8b 45 48             mov    0x48(%rbp),%rax
  14:   f6 c4 02                test   $0x2,%ah
  17:   75 e7                   jne    0x0
  19:   48 8b 45 10             mov    0x10(%rbp),%rax
  1d:   4c 8d 65 10             lea    0x10(%rbp),%r12
  21:   48 8d 58 c8             lea    -0x38(%rax),%rbx
  25:   49 39 c4                cmp    %rax,%r12
  28:   74 d6                   je     0x0
  2a:*  8b 43 50                mov    0x50(%rbx),%eax          <-- trapping instruction
  2d:   85 c0                   test   %eax,%eax
  2f:   74 0f                   je     0x40
  31:   48 8b 85 88 01 00 00    mov    0x188(%rbp),%rax
  38:   48 89 df                mov    %rbx,%rdi
  3b:   0f ae e8                lfence
  3e:   ff d0                   call   *%rax

kernel: RSP: 0018:ffffbc5004897de8 EFLAGS: 00010282
kernel: RAX: 0000000000000000 RBX: ffffffffffffffc8 RCX: 0000000000000000
kernel: RDX: ffff9c2300e36a28 RSI: 0000000000000202 RDI: ffff9c2300e36a10
kernel: RBP: ffff9c24473a3970 R08: 0000000000000001 R09: 0000000000000000
kernel: R10: ffff9c23ab165ea9 R11: 0000000000000000 R12: ffff9c24473a3980
kernel: R13: ffff9c2367bca000 R14: ffff9c23112ae000 R15: 0000000000000000
kernel: FS:  0000000000000000(0000) GS:ffff9c2a5d500000(0000) knlGS:0000000000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 0000000000000018 CR3: 0000000700d0a000 CR4: 00000000003506e0
kernel: Call Trace:
kernel:  <TASK>
kernel: raid5d (drivers/md/raid5.c:6563) raid456
kernel: ? schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6370 (discriminator 1))
kernel: md_thread (drivers/md/md.c:7923) md_mod
kernel: ? do_wait_intr (kernel/sched/wait.c:415)
kernel: ? md_submit_bio (drivers/md/md.c:7887) md_mod
kernel: kthread (kernel/kthread.c:377)
kernel: ? kthread_complete_and_exit (kernel/kthread.c:332)
kernel: ret_from_fork (arch/x86/entry/entry_64.S:301)
kernel:  </TASK>

Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>
---
 drivers/dma/dmaengine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 2cfa8458b51b..9465dc89b945 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -553,13 +553,13 @@ EXPORT_SYMBOL(dma_find_channel);
 void dma_issue_pending_all(void)
 {
 	struct dma_device *device;
-	struct dma_chan *chan;
+	struct dma_chan *chan, *n;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(device, &dma_device_list, global_node) {
 		if (dma_has_cap(DMA_PRIVATE, device->cap_mask))
 			continue;
-		list_for_each_entry(chan, &device->channels, device_node)
+		list_for_each_entry_safe(chan, n, &device->channels, device_node)
 			if (chan->client_count)
 				device->device_issue_pending(chan);
 	}
-- 
2.35.1

