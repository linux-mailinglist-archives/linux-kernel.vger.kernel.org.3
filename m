Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A28538BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 09:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244505AbiEaH3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 03:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242971AbiEaH3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 03:29:01 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 415EE793A9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 00:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=NGUDH
        gG8iVG5OQXyT3DJVTMbEFQi7F2v0GBzMtCTvKE=; b=J3Mp6mC4DOU8h8S0Dqecp
        xeVldRi7P9WRfVXGRsZOZxwHLtfjN8gByg/SeujOzFfOS+TK6luQoSJT2/ZlRGHg
        zzsKXB2PSgWtbCvzNy1iRyX62sjOW6R/KZCSJ2faYF/rgDLjCrJUJJRATELIdo0A
        VR85OAoN+Z5mDIuDQS0pis=
Received: from carlis (unknown [218.17.89.92])
        by smtp7 (Coremail) with SMTP id C8CowACXyaCQw5Vi53O0FQ--.54171S2;
        Tue, 31 May 2022 15:28:16 +0800 (CST)
From:   Xuezhi Zhang <zhangxuezhi1@coolpad.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        dankamongmen@gmail.com, jcmvbkbc@gmail.com, siglesias@igalia.com,
        zhangxuezhi1@coolpad.com, igormtorrente@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tty: vt: convert sysfs snprintf to sysfs_emit
Date:   Tue, 31 May 2022 07:28:14 +0000
Message-Id: <20220531072814.34999-1-zhangxuezhi1@coolpad.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowACXyaCQw5Vi53O0FQ--.54171S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWxKw1DKryUWFy5Xw13Jwb_yoWkCrc_C3
        WxZrWfKF48ta1UA3ZrAr4avr9avF4vvF1UXw4qq3yfJrWq93Z7Zr9F9r9xtry5W3ykJFyU
        Cws7ZFyfursrWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnPku7UUUUU==
X-Originating-IP: [218.17.89.92]
Sender: llyz108@163.com
X-CM-SenderInfo: xoo16iiqy6il2tof0z/xtbBORAShV-PNp6tOwAAsQ
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:
drivers/tty/vt/vt.c:3942:8-16:
WARNING: use scnprintf or sprintf
drivers/tty/vt/vt.c:3950:8-16:
WARNING: use scnprintf or sprintf

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
 drivers/tty/vt/vt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index f8c87c4d7399..7ea7d14e9271 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3939,7 +3939,7 @@ static ssize_t show_bind(struct device *dev, struct device_attribute *attr,
 	bind = con_is_bound(con->con);
 	console_unlock();
 
-	return snprintf(buf, PAGE_SIZE, "%i\n", bind);
+	return sysfs_emit(buf, "%i\n", bind);
 }
 
 static ssize_t show_name(struct device *dev, struct device_attribute *attr,
@@ -3947,7 +3947,7 @@ static ssize_t show_name(struct device *dev, struct device_attribute *attr,
 {
 	struct con_driver *con = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s %s\n",
+	return sysfs_emit(buf, "%s %s\n",
 			(con->flag & CON_DRIVER_FLAG_MODULE) ? "(M)" : "(S)",
 			 con->desc);
 
-- 
2.25.1

