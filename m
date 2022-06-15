Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA2254D093
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348083AbiFOSCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345270AbiFOSCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:02:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAA6C41
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:02:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h19so13171562wrc.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iUGfvUGZJFkqQvb1BclrKM+Qvg6hWolmp/RDxiXQRbw=;
        b=AK1QgD+vMnL2s8hn9Rs7Vedj1AIZHfjCE2hIxnYHZJ4lpUmCgjvWKXcbzGC8iVj8MV
         gQzwhhIoRxdRNJBLgJcnwggEFdzOg68MZFxyGd/Gets0UhBNf8F78pDCqYu/2ZIbqvRX
         uQd3LV/cqOjfgOJ1h0a92XH8ALQooef0NKdiWAM4qYi/4rV6h2RA/nCWB5KP9P5vIdy2
         7Hf2EwO8+Dzxpfp1SpMBaG0PT1sbf1laNy0di+tuatKxFTxNSAADG517SvwPo6l+uMJE
         p18g+/3gyt+PkYwF85WZ1Fgq+RDEYbQIdPqAC/3DwyfnpCrtdKLjca+CDPBMTrufkQTK
         ZMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iUGfvUGZJFkqQvb1BclrKM+Qvg6hWolmp/RDxiXQRbw=;
        b=aXpaav9pMNX0YOc4WxRhKcMLNII6d+HsuboDBUyLhYlkBUf+1ddwwDZLXxiyB6dtqB
         mDsM5Vzwv3cGhj6/mkeOXbVy9bnTET0bAetukcr7MjPChWOwQmk+K5upD3ZCz6vJsLqe
         4IGNDxO7SkEqwL65LBxCAwJOVAmhDVWz60yYWh6zDY05GSqMap90r9avZ4qVF7MfljHb
         wXO9Qg5Za1s+a1wMUgEM8KhqiphH5npxcit8R31yFt8S998e8EBOgShHjyrDz9LLff96
         dQZGhzNXTMcmAwUoJEr62ZdRrIlEjTMLl0r60N70SB/a8fijsUxlk3/7kzdCe4aDaV1z
         Bitw==
X-Gm-Message-State: AJIora8UL1EgMBvbV+lu8Eu+sYFIMNAqyj0fiMCZkAWgqslYRJrvBsRc
        C5cgSDA5vXC3vp9/8pmHwRs=
X-Google-Smtp-Source: AGRyM1v+Y9UjdqeP6KstzWoGGotBF3Gc8+ogji3NL81O9ayyefisQ0VVM/Stqp8PFsrCdpygu6PVCw==
X-Received: by 2002:a05:6000:1f85:b0:21a:14a0:b03b with SMTP id bw5-20020a0560001f8500b0021a14a0b03bmr961332wrb.355.1655316153785;
        Wed, 15 Jun 2022 11:02:33 -0700 (PDT)
Received: from laptop.. (82-64-133-20.subs.proxad.net. [82.64.133.20])
        by smtp.gmail.com with ESMTPSA id i30-20020a1c541e000000b0039c15861001sm3113050wmb.21.2022.06.15.11.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 11:02:32 -0700 (PDT)
From:   Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
Cc:     Erwan Velu <e.velu@criteo.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] nvme: Report model,sn,fw,pci device information during init
Date:   Wed, 15 Jun 2022 20:02:13 +0200
Message-Id: <20220615180213.760756-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI-based device get their identify properties being printed when initialized like :

[    1.245357] scsi 0:0:0:0: Direct-Access     ATA      HGST HTE721010A9 A3M0 PQ: 0 ANSI: 5

When initializing nvme devices, no identification message is reported
making difficult to identify them during the boot process. If the system
crashes during boot process or if the init phase fail, it could be very diffcult
to identify the faulty disk.

This patch reports model, serial, firmware version and pci information
as soon as possible making this early identifying task possible.

Reporting the serial has the interest of being able to ensure which
physical drive is concerned if a hardware replacement is required and
host features the exact same drive multiple times.

A typical output looks like:
[    0.383353] nvme nvme0: pci function 0000:00:03.0
[    0.418184] nvme nvme0: MODEL:QEMU NVMe Ctrl                          SN:deadbeef            FW:1.0     PCI_ID:1b36:1af4
[    0.422020] nvme nvme0: 1/0/0 default/read/poll queues

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/nvme/host/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 24165daee3c8..0922b7a470b1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2987,6 +2987,14 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	if (!ctrl->identified) {
 		unsigned int i;
 
+		/* Reporting model, serial, firmware and pci info */
+		dev_info(ctrl->device, "MODEL:%.*s SN:%.*s FW:%.*s PCI_ID:%04x:%04x\n",
+				(int)sizeof(id->mn), id->mn,
+				(int)sizeof(id->sn),id->sn,
+				(int)sizeof(id->fr), id->fr,
+				le16_to_cpu(id->vid),
+				le16_to_cpu(id->ssvid));
+
 		ret = nvme_init_subsystem(ctrl, id);
 		if (ret)
 			goto out_free;
-- 
2.35.3

