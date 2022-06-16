Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF0254E027
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376870AbiFPLk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376544AbiFPLkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:40:52 -0400
Received: from m15113.mail.126.com (m15113.mail.126.com [220.181.15.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DB475EBDE;
        Thu, 16 Jun 2022 04:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hWoOt
        Psu1gQScWL2O61ZqNnjFafUe4MdGUNnAujDm6s=; b=ReOb/rrN8X12mibvhUOXp
        hBEXrsYnbkzDAaiuUikz1lS76cXXlaKOCy4s5a22d9z9NFxJ2fu2wUmfrxLfT+oH
        7KGeR1xzJnn8C3IRD2zScz4O4bwJapcnTeB7k04cZxu5VXcrSFkPVCml39xHEQX6
        R0cfbGU7lrCiuEUw3kEvFw=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp3 (Coremail) with SMTP id DcmowADXb5GoFqtiT23jDQ--.9871S2;
        Thu, 16 Jun 2022 19:40:25 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     tharvey@gateworks.com, rjones@gateworks.com, jdelvare@suse.com,
        linux@roeck-us.net
Cc:     windhl@126.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (gsc-hwmon) Add missing of_node_put()
Date:   Thu, 16 Jun 2022 19:40:24 +0800
Message-Id: <20220616114024.3985770-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowADXb5GoFqtiT23jDQ--.9871S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFyfGF15Jry8Cr17GrWrGrg_yoWDKFg_Zr
        1xWr9xXryDKF1fAr4DAF4S9ryqkr48Wrn7Xan3ta95CF1DZrnxWrnFvrn7W343urWagF98
        Xw1qyryIvr4fujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRWq2tUUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3AoiF1pEDu4YEwAAsW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gsc_hwmon_get_devtree_pdata(), of_find_compatible_node() will return
a node pointer with refcount incremented. We should use of_node_put() in
fail path or when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/hwmon/gsc-hwmon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
index 1fe37418ff46..d64be48f1ef6 100644
--- a/drivers/hwmon/gsc-hwmon.c
+++ b/drivers/hwmon/gsc-hwmon.c
@@ -269,10 +269,13 @@ gsc_hwmon_get_devtree_pdata(struct device *dev)
 	/* fan controller base address */
 	fan = of_find_compatible_node(dev->parent->of_node, NULL, "gw,gsc-fan");
 	if (fan && of_property_read_u32(fan, "reg", &pdata->fan_base)) {
+		of_node_put(fan);
 		dev_err(dev, "fan node without base\n");
 		return ERR_PTR(-EINVAL);
 	}
 
+	of_node_put(fan);
+
 	/* allocate structures for channels and count instances of each type */
 	device_for_each_child_node(dev, child) {
 		if (fwnode_property_read_string(child, "label", &ch->name)) {
-- 
2.25.1

