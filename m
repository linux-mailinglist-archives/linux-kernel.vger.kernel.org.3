Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DA954BC8A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357913AbiFNVJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352155AbiFNVJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:09:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00504B1D9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:09:14 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w17so5326522wrg.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QA+6zqPfpknDlOYAQ8mQVKw6wFTP9MDVA9zNZsWiDes=;
        b=ocIvtOKy2TmZef3STpknKFoF2mH6tq6wXdvwJRomcq1MQinFdxYqxgnSd2Z9eF6j7S
         oi4swQzizTOuugao+BKi+OU1o29wH6nm8weAUjXDs/n4unapQOt6+ovGJhZu5LwBGxrQ
         Aa9XufIAodoHJY5K2syAdWnztRaC7g6Iyc5EX7mmUek0KcDRHxKBeXNmT1mZql6csQLo
         +l5IXZ/Vgf8IfWFY+08M6R+UbFVgboLF0ROCYtq1z/XafQr8EhI7dneouX20uIEz00ND
         iZiryEcqfPneYyKU1ro5qsE0q1i9VzsreWWiYA5X5aZhIE0CkJoT6YAKDtPF9DLZGoF5
         ZH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QA+6zqPfpknDlOYAQ8mQVKw6wFTP9MDVA9zNZsWiDes=;
        b=lIEqAZ6YMgWtHnjiojhn7S8LyZ6+zCqP41fOOaid1qpsM4NcjXDH5DG78qWx8KSzam
         jS2wwtLCsrHKius0n+RYqjbv20KaPSK197uJHG0kqxXljgWaDEVXFHmroQuSq+NYPwfz
         OK0/RBXV1LJXh6jXi5FIqC+9obUObIkBU9lC+WYIwM/mJJL/0U9zPRlkPqSOBsGKk9r2
         /++TyjsxlqK+g4gSnPoc6abrhNsIBmJU+LU3lQvra3JChZ5rqC1Wsu/6sEeywmokE3Xj
         vvzq/gvHZCrhqkA7vZpGNnotOLLSEVN1q+86tAUUCd8CReo+QyO+Dh9P884MWs5IXPhV
         9vVg==
X-Gm-Message-State: AJIora/uisIF58LKFsQFz7Y4UZxk9dR2C0NdzK+yhIx+kMMozV4V2GNX
        TYUsVC/jP4b7y9hZvXKefC0=
X-Google-Smtp-Source: AGRyM1uWTLjcqmhhytRYteL0y3Djy6Xdt4X3+CiwfadO9nxLc59O7U8pC/fSIwBd2wO5k3vXLZao8w==
X-Received: by 2002:a05:6000:3c5:b0:219:d09:6fce with SMTP id b5-20020a05600003c500b002190d096fcemr6578565wrg.197.1655240953159;
        Tue, 14 Jun 2022 14:09:13 -0700 (PDT)
Received: from laptop.. (82-64-133-20.subs.proxad.net. [82.64.133.20])
        by smtp.gmail.com with ESMTPSA id bt15-20020a056000080f00b002183cedbf34sm3546649wrb.73.2022.06.14.14.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:09:12 -0700 (PDT)
From:   Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
Cc:     Erwan Velu <e.velu@criteo.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] nvme: Report model,sn,fw,pci device information during init
Date:   Tue, 14 Jun 2022 23:09:02 +0200
Message-Id: <20220614210902.744318-2-e.velu@criteo.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220614210902.744318-1-e.velu@criteo.com>
References: <20220614210902.744318-1-e.velu@criteo.com>
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

A typical output looks like:
[    0.383353] nvme nvme0: pci function 0000:00:03.0
[    0.418184] nvme nvme0: MODEL:QEMU NVMe Ctrl                          SN:deadbeef            FW:1.0     PCI_ID:1b36:1af4
[    0.422020] nvme nvme0: 1/0/0 default/read/poll queues

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/nvme/host/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0f7e625e8bd0..f73ca92412a9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2982,6 +2982,14 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 		return -EIO;
 	}
 
+	/* Reporting model, serial, firmware and pci info */
+	dev_info(ctrl->device, "MODEL:%s SN:%s FW:%s PCI_ID:%04x:%04x\n",
+			id->mn,
+			id->sn,
+			id->fr,
+			le16_to_cpu(id->vid),
+			le16_to_cpu(id->ssvid));
+
 	if (id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG) {
 		ret = nvme_get_effects_log(ctrl, NVME_CSI_NVM, &ctrl->effects);
 		if (ret < 0)
-- 
2.35.3

