Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3827854E024
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376891AbiFPLjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbiFPLjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:39:51 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF22B56204;
        Thu, 16 Jun 2022 04:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xGSrH
        Mmj3aUpaCaNuRf66Blu8ZkJ+1iykrzuHPRNKl0=; b=JE/K6rLro+hJI7XJ4lxta
        TKF+k6AgwYth0dBVSiwN1+Mqb2nbj8C1PnkKq1GeFMMgWLQhM0Jt/9kL7zEaHRGt
        oglLiAgRBbP4MrnST9PSuM24dD6nAg6syylzE9r51gGv8B3DnkSIPrzdoh40jnM+
        EFleRVBjJAjb53uLAr+R3s=
Received: from carlis-virtual-machine (unknown [218.17.89.92])
        by smtp9 (Coremail) with SMTP id DcCowADXhCFrFqtiB7ueJQ--.21682S2;
        Thu, 16 Jun 2022 19:39:24 +0800 (CST)
From:   Xuezhi Zhang <zhangxuezhi1@coolpad.com>
To:     satishkh@cisco.com, sebaddel@cisco.com, kartilak@cisco.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Subject: [PATCH] scsi: fnic: convert sysfs snprintf to sysfs_emit
Date:   Thu, 16 Jun 2022 19:39:22 +0800
Message-Id: <20220616113922.8106-1-zhangxuezhi1@coolpad.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowADXhCFrFqtiB7ueJQ--.21682S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF4fAw1xtFW5XF47GFWfXwb_yoW8Xw45pa
        4fGa4UurWUGw18Zr1Yk3Wv93WSvF93urW7A397Ww1DZF45tFWDtFyDCFW29r1rJrWkGryS
        yF1qkryUua1UAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jp89NUUUUU=
X-Originating-IP: [218.17.89.92]
Sender: llyz108@163.com
X-CM-SenderInfo: xoo16iiqy6il2tof0z/xtbBOQohhV-PN8x1rQABsl
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

drivers/scsi/fnic/fnic_attrs.c:35:8-16:
WARNING: use scnprintf or sprintf
drivers/scsi/fnic/fnic_attrs.c:43:8-16:
WARNING: use scnprintf or sprintf
drivers/scsi/fnic/fnic_attrs.c:29:8-16:
WARNING: use scnprintf or sprintf

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
 drivers/scsi/fnic/fnic_attrs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_attrs.c b/drivers/scsi/fnic/fnic_attrs.c
index bbe2ca4971b2..d02555bf3df1 100644
--- a/drivers/scsi/fnic/fnic_attrs.c
+++ b/drivers/scsi/fnic/fnic_attrs.c
@@ -26,13 +26,13 @@ static ssize_t fnic_show_state(struct device *dev,
 	struct fc_lport *lp = shost_priv(class_to_shost(dev));
 	struct fnic *fnic = lport_priv(lp);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", fnic_state_str[fnic->state]);
+	return sysfs_emit(buf, "%s\n", fnic_state_str[fnic->state]);
 }
 
 static ssize_t fnic_show_drv_version(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", DRV_VERSION);
+	return sysfs_emit(buf, "%s\n", DRV_VERSION);
 }
 
 static ssize_t fnic_show_link_state(struct device *dev,
@@ -40,7 +40,7 @@ static ssize_t fnic_show_link_state(struct device *dev,
 {
 	struct fc_lport *lp = shost_priv(class_to_shost(dev));
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", (lp->link_up)
+	return sysfs_emit(buf, "%s\n", (lp->link_up)
 			? "Link Up" : "Link Down");
 }
 
-- 
2.34.1

