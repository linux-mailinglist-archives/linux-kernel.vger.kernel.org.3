Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662E257EC5D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 08:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbiGWGlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 02:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiGWGls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 02:41:48 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D17464E11;
        Fri, 22 Jul 2022 23:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=kucPn
        kJPET0vErhB73+JEC1LgKSF0wQdv8SoTfgnP4A=; b=BJPrKQh/vhuRZ+NC2pWDR
        CdpiBHLOLW/NSN7g8tEdAnk1FGze9taU8hIvGb6YjmsJLY5wQCT+MWbVm+X61YOe
        AEJqFQv9B92eAreMcQj1qzrh847UFCVf43Gq+jNbpSeKj3x23XKtbJqLP6egnjwJ
        fBIl3GTzD8PRkQ8vmLc3dI=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp4 (Coremail) with SMTP id HNxpCgCX5ITfl9titVQzQQ--.40765S2;
        Sat, 23 Jul 2022 14:40:32 +0800 (CST)
From:   williamsukatube@163.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH] scsi: lpfc: check the return value of alloc_workqueue()
Date:   Sat, 23 Jul 2022 14:40:27 +0800
Message-Id: <20220723064027.2956623-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgCX5ITfl9titVQzQQ--.40765S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWxCF4UXF4kAFykZw1xuFg_yoWDAwb_ua
        y8ZF1xXws5GF1xAasrJr43Z3sI9r48XFnxu3Z0qryrCr4xZF1kWFs8WFn8X3yUArn5JFyD
        Ga1rX3y0yr13ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5uwZ7UUUUU==
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/xtbBiAFHg1aECKfLXAAAsn
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Dean <williamsukatube@gmail.com>

The function alloc_workqueue() in lpfc_sli4_driver_resource_setup() can
fail, but there is no check of its return value. To fix this bug, its
return value should be checked with new error handling code.

Fixes: 3cee98db2610f ("scsi: lpfc: Fix crash on driver unload in wq free")
Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: William Dean <williamsukatube@gmail.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 750dd1e9f2cc..8e9594f4ed16 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -7958,6 +7958,8 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 
 	/* The lpfc_wq workqueue for deferred irq use */
 	phba->wq = alloc_workqueue("lpfc_wq", WQ_MEM_RECLAIM, 0);
+	if (!phba->wq)
+		return -ENOMEM;
 
 	/*
 	 * Initialize timers used by driver
-- 
2.25.1

