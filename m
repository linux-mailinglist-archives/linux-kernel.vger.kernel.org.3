Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85DA54E093
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiFPMKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 08:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376779AbiFPMKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:10:37 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 753BB2CCBA;
        Thu, 16 Jun 2022 05:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=oC2+/
        LNKAYJzJDGB6msmArnHeDnp+bcp6dLSZ6JHMXA=; b=MQMsx6u6GvxCI91gf03b1
        lYJ7o+0OMyZYyczF+tw0veVE/0lNLwFAGkPZwKidyrKZk5qPa9v0K/qrQ8ltt4PA
        4JM8iGQD5jn4jd29bk0BypaFJnE0jv4VVG/hyz5oHoUeUHqRu3MGacyCfOWsvuLK
        9hMOiiv/Ma3QgRSArdoAdw=
Received: from carlis-virtual-machine (unknown [218.17.89.92])
        by smtp10 (Coremail) with SMTP id DsCowAAHhx_8Gatiy3J6IA--.11358S2;
        Thu, 16 Jun 2022 19:54:37 +0800 (CST)
From:   Xuezhi Zhang <zhangxuezhi1@coolpad.com>
To:     hare@suse.de, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Subject: [PATCH] scsi: fcoe: convert sysfs snprintf to sysfs_emit
Date:   Thu, 16 Jun 2022 19:54:35 +0800
Message-Id: <20220616115435.9980-1-zhangxuezhi1@coolpad.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAAHhx_8Gatiy3J6IA--.11358S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4DWF13Ar1rKF1xuF4Durg_yoW8KryDpF
        4kJa45uay7GFn5Kr15G3WDur909as7Jr9rG395J3s7W3Z5ArWDKF1kAa9F9F1fJ348GryU
        JF4qkr98ua10yr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jdDGOUUUUU=
X-Originating-IP: [218.17.89.92]
Sender: llyz108@163.com
X-CM-SenderInfo: xoo16iiqy6il2tof0z/xtbBOQohhV-PN8x1rQACsm
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

drivers/scsi/fcoe/fcoe_sysfs.c:376:8-16:
WARNING: use scnprintf or sprintf
drivers/scsi/fcoe/fcoe_sysfs.c:268:8-16:
WARNING: use scnprintf or sprintf
drivers/scsi/fcoe/fcoe_sysfs.c:253:8-16:
WARNING: use scnprintf or sprintf

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
 drivers/scsi/fcoe/fcoe_sysfs.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysfs.c
index af658aa38fed..eabab69f9861 100644
--- a/drivers/scsi/fcoe/fcoe_sysfs.c
+++ b/drivers/scsi/fcoe/fcoe_sysfs.c
@@ -239,7 +239,6 @@ static char *fcf_state_names[] = {
 	[ FCOE_FCF_STATE_CONNECTED ]    = "Connected",
 };
 fcoe_enum_name_search(fcf_state, fcf_state, fcf_state_names)
-#define FCOE_FCF_STATE_MAX_NAMELEN 50
 
 static ssize_t show_fcf_state(struct device *dev,
 			      struct device_attribute *attr,
@@ -250,7 +249,7 @@ static ssize_t show_fcf_state(struct device *dev,
 	name = get_fcoe_fcf_state_name(fcf->state);
 	if (!name)
 		return -EINVAL;
-	return snprintf(buf, FCOE_FCF_STATE_MAX_NAMELEN, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 static FCOE_DEVICE_ATTR(fcf, state, S_IRUGO, show_fcf_state, NULL);
 
@@ -265,8 +264,7 @@ static ssize_t show_ctlr_mode(struct device *dev,
 	name = get_fcoe_ctlr_mode_name(ctlr->mode);
 	if (!name)
 		return -EINVAL;
-	return snprintf(buf, FCOE_MAX_MODENAME_LEN,
-			"%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 
 static ssize_t store_ctlr_mode(struct device *dev,
@@ -361,7 +359,6 @@ static char *ctlr_enabled_state_names[] = {
 };
 fcoe_enum_name_search(ctlr_enabled_state, ctlr_enabled_state,
 		      ctlr_enabled_state_names)
-#define FCOE_CTLR_ENABLED_MAX_NAMELEN 50
 
 static ssize_t show_ctlr_enabled_state(struct device *dev,
 				       struct device_attribute *attr,
@@ -373,8 +370,7 @@ static ssize_t show_ctlr_enabled_state(struct device *dev,
 	name = get_fcoe_ctlr_enabled_state_name(ctlr->enabled);
 	if (!name)
 		return -EINVAL;
-	return snprintf(buf, FCOE_CTLR_ENABLED_MAX_NAMELEN,
-			"%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 
 static FCOE_DEVICE_ATTR(ctlr, enabled, S_IRUGO | S_IWUSR,
-- 
2.34.1

