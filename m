Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0439D465C68
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 04:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhLBDIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 22:08:11 -0500
Received: from smtpbguseast3.qq.com ([54.243.244.52]:49362 "EHLO
        smtpbguseast3.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355099AbhLBDG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 22:06:26 -0500
X-QQ-mid: bizesmtp36t1638414159t1g4ankc
Received: from localhost.localdomain (unknown [113.200.76.118])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 02 Dec 2021 11:02:32 +0800 (CST)
X-QQ-SSF: 01400000002000B0D000B00A0000000
X-QQ-FEAT: Jd++W0FxedHXR/8SxplsRCSONu04WlhnpdS3bDtQlCiQefp9Bb9KcJBcezXMY
        GvtzunS+MkiTlnT+7IN1ZqXG0HERGqzXFyZuFOETy7P0Nw+a5tfdgQBI1RHT3i1ZJKKrvOu
        xPM/PL6EKzvITjDmuuh4tFQIIy2u6t2LBk69Qlob22YW5Q9j5WgETWk81F+8KV+i03PHUnT
        mEg67kcTTqfPYcX6v9Imic8bNAf73IWz20yMk5UOTn21BLGPoFSVINpp9DVbL4f6ppVOOIg
        bojn9Ek9UDtRYRPdzacnIf3JrZBLfwQRpf7tSh9BPV5hCr6sWakgJc+CjXsLySm32G6vxSy
        H/ddiHs1AScaBbtfXlfoK33QrYcXPZ9xTCETUDS
X-QQ-GoodBg: 2
From:   caojun <caojun@uniontech.com>
To:     axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        caojun <caojun@uniontech.com>
Subject: [PATCH] add Intel 760p/Pro 7600p nvme disk
Date:   Thu,  2 Dec 2021 11:02:30 +0800
Message-Id: <20211202030230.17507-1-caojun@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: caojun <caojun@uniontech.com>
---
 drivers/nvme/host/core.c | 16 +++++++++-------
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  |  2 ++
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e64310f22..8e0dbfb6a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2155,14 +2155,16 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
 	size_t nqnlen;
 	int off;
 
-	nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
-	if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
-		strncpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
-		return;
-	}
+	if(!(ctrl->quirks & NVME_QUIRK_IGNORE_DEV_SUBNQN)) {
+		nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
+		if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
+			strlcpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
+			return;
+		}
 
-	if (ctrl->vs >= NVME_VS(1, 2, 1))
-		dev_warn(ctrl->device, "missing or invalid SUBNQN field.\n");
+		if (ctrl->vs >= NVME_VS(1, 2, 1))
+			dev_warn(ctrl->device, "missing or invalid SUBNQN field.\n");
+	}
 
 	/* Generate a "fake" NQN per Figure 254 in NVMe 1.3 + ECN 001 */
 	off = snprintf(subsys->subnqn, NVMF_NQN_SIZE,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 276975506..5f5a91518 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -90,6 +90,11 @@ enum nvme_quirks {
 	 * Set MEDIUM priority on SQ creation
 	 */
 	NVME_QUIRK_MEDIUM_PRIO_SQ		= (1 << 7),
+
+	/*
+	 * Ignore device provided subnqn.
+	 */
+	NVME_QUIRK_IGNORE_DEV_SUBNQN		= (1 << 8),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d7cf3202c..fcac05528 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2713,6 +2713,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_MEDIUM_PRIO_SQ },
+	{ PCI_VDEVICE(INTEL, 0xf1a6),	/* Intel 760p/Pro 7600p */
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
-- 
2.20.1



