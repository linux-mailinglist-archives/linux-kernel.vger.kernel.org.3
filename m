Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5519538DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 11:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245249AbiEaJqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 05:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiEaJqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 05:46:48 -0400
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7741F1027;
        Tue, 31 May 2022 02:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Jb8fs
        wJyz/tr0acifTLtB81WMpjjXvlmzZ4UaNQJ10A=; b=aGKhtUP3+ez3q80NjBssk
        ABEn4xhym4ua73jo9MTu/nFlNW9iwBo2qibqKFq+7pibtl4kqdPneH3pCwHhh39c
        lOBYzW4f6aZ+9IU+aF/UW6nij5rocyj9WaJ+j8xPFBXSM3l99Cjp+dPbS096aCaL
        t5SJyoSFbq/bO+VS7HMaFI=
Received: from carlis (unknown [218.17.89.92])
        by smtp13 (Coremail) with SMTP id EcCowACnBma845VigXrXFQ--.35010S2;
        Tue, 31 May 2022 17:45:33 +0800 (CST)
From:   Xuezhi Zhang <zhangxuezhi1@coolpad.com>
To:     James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llyz108@163.com, Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Subject: [PATCH] scsi: 53c700: convert sysfs snprintf to sysfs_emit
Date:   Tue, 31 May 2022 09:45:30 +0000
Message-Id: <20220531094530.101983-1-zhangxuezhi1@coolpad.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowACnBma845VigXrXFQ--.35010S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF1kAryDGF18Jw1kJF17Awb_yoW3Zrc_AF
        40vw1Igr1ktwna9r1rAFsxZrZYvr40ga1q9rs5trWfZrWq9w4qvFWjvrn5try5WFW7AFy7
        X3Z2qF1fAwnxGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnk9N3UUUUU==
X-Originating-IP: [218.17.89.92]
Sender: llyz108@163.com
X-CM-SenderInfo: xoo16iiqy6il2tof0z/1tbiFR0ShV5mK9bQZwAAst
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
drivers/scsi/53c700.c:2074:8-16:
WARNING: use scnprintf or sprintf

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
 drivers/scsi/53c700.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index e1e4f9d10887..0406cb60916d 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -2071,7 +2071,7 @@ NCR_700_show_active_tags(struct device *dev, struct device_attribute *attr, char
 {
 	struct scsi_device *SDp = to_scsi_device(dev);
 
-	return snprintf(buf, 20, "%d\n", NCR_700_get_depth(SDp));
+	return sysfs_emit(buf, "%d\n", NCR_700_get_depth(SDp));
 }
 
 static struct device_attribute NCR_700_active_tags_attr = {
-- 
2.25.1

