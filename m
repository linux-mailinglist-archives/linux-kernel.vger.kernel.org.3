Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDB750B5CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446978AbiDVLB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 07:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245078AbiDVLB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:01:26 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD02C56401
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:58:33 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n8so10082538plh.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=tTS1fwCyWcSTDM00kDqDYTwl3V38LvGKu4+L/n+uQHg=;
        b=Xg+IIXfjMQSpe0okWvUQFcO35h06GEqp9hRY1NxEq+1v2LWi9BVgdutkKCa6MP8DQu
         5ZhH1vLN8iITPUztAK+jd8Iopzqdi+jjpzOtTgEZ5YlrtOzM5frTsP+wqFP3TNpnK8E6
         mRYPGTefo24/IYOHK+sbFfq8kXIZ05iqykpPY9Atyq3444pMHzfjCkh4spPdUAkx3el+
         VQusD2SW0BOfOG+AVZMZv6ItAmceKhT2EkXxfILsM7n7FVI54XxK52D8e5oVNhBc8lrm
         1uh7FMfNJX7GAaTYE8y+zEN8dztaMODwHOCBy+20vkO27lye74lgUxdjmY2GVEJZJS2M
         8sMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=tTS1fwCyWcSTDM00kDqDYTwl3V38LvGKu4+L/n+uQHg=;
        b=Wl+V0YgPr+NXnvQjRREgllGAHP8Fl3WeOquqYwaPkmsTFViX2lfc7qtSw4OQm2y8zM
         hCemgMmwkdR+KIc5e6+ZoBbaFnRyKf86PU8ySriw204CaC3rArTI6+WWdsot9koD7P/X
         IJxY9rI82vXvdfKsJcYCBnA85sS+NUf4q/6D794Px9RJbZbpHypW+7u2XuzIht+z/W6M
         WYFeSn/zbqb+qt/BaFDDmhLkfQOPg9FSxDXPx0T1zLNRZMaAi6nZ8k6nePpmibWbOqiY
         lH2wPB9ek0vXlY+IjuWKy8swHJs7Rc7xNcnPS4rsPkDZ9kB/hWsCq1yn+wknTZ8YTWe8
         +o9g==
X-Gm-Message-State: AOAM530MFCI9RD8Q/7UDvOy9VO9qPYyimfR32o7QcPxqfE9/UlwdjvEt
        D3l2WSoo2HsCBa4O1/mHKh0=
X-Google-Smtp-Source: ABdhPJxb9VMq1QKT5klc7y15hWNuMSlDDKP+3Cwwv6BbkmAD8Adbt25AXC7Rvg90uwyPj0R7MPkA/g==
X-Received: by 2002:a17:902:7244:b0:158:41d3:b79b with SMTP id c4-20020a170902724400b0015841d3b79bmr4026718pll.50.1650625113381;
        Fri, 22 Apr 2022 03:58:33 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id f128-20020a62db86000000b0050ce37eb56csm2313158pfg.90.2022.04.22.03.58.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2022 03:58:33 -0700 (PDT)
From:   "brookxu.cn" <brookxu.cn@gmail.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] nvme-pci: allowed to modify IRQ affinity in latency sensitive scenarios
Date:   Fri, 22 Apr 2022 18:58:26 +0800
Message-Id: <1650625106-30272-1-git-send-email-brookxu.cn@gmail.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

In most cases, setting the affinity through managed IRQ is a better
choice. But in some scenarios that use isolcpus, such as DPDK, because
managed IRQ does not distinguish between housekeeping CPU and isolated
CPU when selecting CPU, this will cause IO interrupts triggered by
housekeeping CPU to be routed to isolated CPU, which will affect the
tasks running on isolated CPU. commit 11ea68f553e2 ("genirq,
sched/isolation: Isolate from handling managed interrupts") tries to
fix this in a best effort way. However, in a real production environment,
latency-sensitive business needs more of a deterministic result. So,
similar to the mpt3sas driver, we might can add a module parameter
smp_affinity_enable to the Nvme driver.

By default, we use managed IRQ. When smp_affinity_enable is set to 0,
we alloc normal interrupts for Nvme. Therefore, users can modify the
interrupt affinity according to their actual needs when the managed IRQ
cannot satisfy them. This method is not a good choice in most scenarios.
But for users who clear what they are doing, it may be better than not
being able to do anything.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 drivers/nvme/host/pci.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3aacf1c0d5a5..f8fd591b1839 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -74,6 +74,10 @@ static unsigned int io_queue_depth = 1024;
 module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 0644);
 MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2 and < 4096");
 
+static unsigned int smp_affinity_enable = 1;
+module_param(smp_affinity_enable, uint, 0644);
+MODULE_PARM_DESC(smp_affinity_enable, "SMP affinity feature enable/disable Default: enable(1)");
+
 static int io_queue_count_set(const char *val, const struct kernel_param *kp)
 {
 	unsigned int n;
@@ -471,7 +475,7 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 		 * affinity), so use the regular blk-mq cpu mapping
 		 */
 		map->queue_offset = qoff;
-		if (i != HCTX_TYPE_POLL && offset)
+		if (i != HCTX_TYPE_POLL && offset && smp_affinity_enable)
 			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
 		else
 			blk_mq_map_queues(map);
@@ -2293,7 +2297,11 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 		.calc_sets	= nvme_calc_irq_sets,
 		.priv		= dev,
 	};
+	struct irq_affinity *p_affd = &affd;
 	unsigned int irq_queues, poll_queues;
+	unsigned int flags = PCI_IRQ_ALL_TYPES;
+	unsigned int affvecs;
+	int nr_irqs;
 
 	/*
 	 * Poll queues don't need interrupts, but we need at least one I/O queue
@@ -2317,8 +2325,24 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 	irq_queues = 1;
 	if (!(dev->ctrl.quirks & NVME_QUIRK_SINGLE_VECTOR))
 		irq_queues += (nr_io_queues - poll_queues);
-	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
-			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
+
+	if (smp_affinity_enable)
+		flags |= PCI_IRQ_AFFINITY;
+	else
+		p_affd = NULL;
+
+	nr_irqs = pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues, flags, p_affd);
+
+	if (nr_irqs > 0 && !smp_affinity_enable) {
+		if (nr_irqs > affd.pre_vectors)
+			affvecs = nr_irqs - affd.pre_vectors;
+		else
+			affvecs = 0;
+
+		nvme_calc_irq_sets(&affd, affvecs);
+	}
+
+	return nr_irqs;
 }
 
 static void nvme_disable_io_queues(struct nvme_dev *dev)
-- 
2.30.0

