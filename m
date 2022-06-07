Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF6554220C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbiFHC5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448544AbiFHCy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 22:54:27 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E9A22CEC0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:32:29 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 257Dp7RS005196;
        Tue, 7 Jun 2022 23:32:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=tteCDJduDnLaPT3UrtfGVEXpLQ6Eom01HkHJbWAJnmg=;
 b=nBziXhMM5mjUyc2h0og/zFDpSK/T1pukaGpVucB2fxJkUJ3fQTQs7OiaeXoZxUEER9f5
 HEn1cGjZDOr7Gpc9we8iHq/5waKDvpAGQQd5hN7BJJL+bgFrkDRQlzwKTLI+ig2+fxB+
 zUfqpTHX4LLZ6rEYRjIZq1QqbOBv/qfMoQ1DWv7E/wjbEtaWdTKBeAJ5rdV/eHq1Y0Rs
 Z9vlbdT0m3kRrXJpXktOZBfK01Ot/xYWw58UzK5QKdvdPek6Nbhb3fj2KKkSv5awP7dK
 v7+MQQg7O5r/ahdI0+Huv0UQFnUqdj0whM5Gu6nikIXKllQSfpW0sRz41AAiElHy0AUW Lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gj3d3mbd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jun 2022 23:32:12 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3920510002A;
        Tue,  7 Jun 2022 23:32:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2310C20AA91;
        Tue,  7 Jun 2022 23:32:09 +0200 (CEST)
Received: from localhost (10.75.127.44) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 7 Jun
 2022 23:32:08 +0200
From:   Antonio Borneo <antonio.borneo@foss.st.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>
CC:     Antonio Borneo <antonio.borneo@foss.st.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH RESEND] drm: adv7511: override i2c address of cec before accessing it
Date:   Tue, 7 Jun 2022 23:31:44 +0200
Message-ID: <20220607213144.427177-1-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20211218182804.208906-1-antonio.borneo@foss.st.com>
References: <20211218182804.208906-1-antonio.borneo@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-07_10,2022-06-07_02,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 680532c50bca ("drm: adv7511: Add support for
i2c_new_secondary_device") allows a device tree node to override
the default addresses of the secondary i2c devices. This is useful
for solving address conflicts on the i2c bus.

In adv7511_init_cec_regmap() the new i2c address of cec device is
read from device tree and immediately accessed, well before it is
written in the proper register to override the default address.
This can cause an i2c error during probe and a consequent probe
failure.

Once the new i2c address is read from the device tree, override
the default address before any attempt to access the cec.

Tested with adv7533 and stm32mp157f.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Fixes: 680532c50bca ("drm: adv7511: Add support for i2c_new_secondary_device")
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

---

This patch got somehow lost, I'm resending it.
Added reviewed by Kieran Bingham.
Rebased on drm-misc-next.

---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 5bb9300040dd..074c2e650cae 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1065,6 +1065,10 @@ static int adv7511_init_cec_regmap(struct adv7511 *adv)
 						ADV7511_CEC_I2C_ADDR_DEFAULT);
 	if (IS_ERR(adv->i2c_cec))
 		return PTR_ERR(adv->i2c_cec);
+
+	regmap_write(adv->regmap, ADV7511_REG_CEC_I2C_ADDR,
+		     adv->i2c_cec->addr << 1);
+
 	i2c_set_clientdata(adv->i2c_cec, adv);
 
 	adv->regmap_cec = devm_regmap_init_i2c(adv->i2c_cec,
@@ -1271,9 +1275,6 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 	if (ret)
 		goto err_i2c_unregister_packet;
 
-	regmap_write(adv7511->regmap, ADV7511_REG_CEC_I2C_ADDR,
-		     adv7511->i2c_cec->addr << 1);
-
 	INIT_WORK(&adv7511->hpd_work, adv7511_hpd_work);
 
 	if (i2c->irq) {

base-commit: dfa687bffc8a4a21ed929c7dececf01b8f1f52ee
-- 
2.36.1

