Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EEA54E55B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377237AbiFPOu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiFPOuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:50:23 -0400
Received: from m15113.mail.126.com (m15113.mail.126.com [220.181.15.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE6A543EF1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 07:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ARBcG
        NcD3T88nKaXT4MWM/zoSyK1nZmN5buYZLmG/Ok=; b=ZsvkMzs/NznMFaHRatqKk
        O7Js+dZEmVL5eYjbA71d+mH7Q5qiWtRQDKX/1Cd1CCKuI1wHdSY146DAhF/okeTM
        uQoKKpZs43siheQnNcy0NUp9BdmddvVePiJEgy3SbaWiJ7EdSAswy1fII2+xxGr7
        FClXStbkw3rgdJmwbfTHdI=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp3 (Coremail) with SMTP id DcmowACXp5_rQqtigmn6DQ--.14906S2;
        Thu, 16 Jun 2022 22:49:15 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     narmstrong@baylibre.com, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com
Cc:     windhl@126.com, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: amlogic: Fix refcount leak in meson-secure-pwrc.c
Date:   Thu, 16 Jun 2022 22:49:15 +0800
Message-Id: <20220616144915.3988071-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowACXp5_rQqtigmn6DQ--.14906S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF18Jw17Jr1UCr1rGw43GFg_yoW3AwcEka
        ykJrnrXFy8ArWxtrWFkryS9rW09F1j93yv93W5tFy3Aw4UAr18XF9rurn3W3y7X3yvyF4U
        XFykJFZrtrZ2yjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjnYwUUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7QwiF1pEANi9CQAAsm
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In meson_secure_pwrc_probe(), there is a refcount leak in one fail
path.

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/soc/amlogic/meson-secure-pwrc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
index a10a417a87db..e93518763526 100644
--- a/drivers/soc/amlogic/meson-secure-pwrc.c
+++ b/drivers/soc/amlogic/meson-secure-pwrc.c
@@ -152,8 +152,10 @@ static int meson_secure_pwrc_probe(struct platform_device *pdev)
 	}
 
 	pwrc = devm_kzalloc(&pdev->dev, sizeof(*pwrc), GFP_KERNEL);
-	if (!pwrc)
+	if (!pwrc) {
+		of_node_put(sm_np);
 		return -ENOMEM;
+	}
 
 	pwrc->fw = meson_sm_get(sm_np);
 	of_node_put(sm_np);
-- 
2.25.1

