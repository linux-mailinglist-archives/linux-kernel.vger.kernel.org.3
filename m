Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DE7586768
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiHAK1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiHAK10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:27:26 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF201BEB8;
        Mon,  1 Aug 2022 03:27:24 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id m2so3282195pls.4;
        Mon, 01 Aug 2022 03:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y7hOrypHABOrUYY7mPx6WzbUKkmZSajxEE3MVrQlsPs=;
        b=b15uEYkWYgfp537+pzlYAD4ZzavMpQrl+KgbOwrIyXQi8OU009J7s9NjHe8OnT47MB
         ors41+qa2lRASDWKPsTsfnjUDwtkjPIG/KWSWzeaLTp3nAQHD44xlO47gqzxMYtLECZZ
         sUjSkOKTwJuR8iMXlXOwoSoWU8z4Ojl2Y3mqvi49oSpYeiCkhlplDbtJGl+3k/AfshqB
         p8QtT8IJDrgs4jS8cZaWJxv6lbYVgfSBeusyuteTDF8p+elq7jWwiOOOppWiwWeIjTG0
         qYil2bBabWn+ucGIa950ukMpFJmgwFQq9QLzIG58SU3jUr14YuAFUR5aBK22cbBNlt/o
         8Jrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y7hOrypHABOrUYY7mPx6WzbUKkmZSajxEE3MVrQlsPs=;
        b=onQfLqw+BrbjL62iARaeLef8JznkBxMimyeparagUPVvqsz1UAwrLL/SF/8FiJ67Ec
         I7DpYcUIU5VeznnNK6TP+m5+z/wRXnVIq8qSoaboSzdGo6Sq972VcFoO0nEHtPy+nz31
         1/zDSBgMbqkGj4febU15+L7hcjrJK5h1hCwPn34SPnZwecYzpRShUl0WbjeMsv+wHqCS
         Fv/WmPVS7/ifKx7RQ48AFjdRE6ch+/b1p5Z1vAT8IsxUmJHfu81i56QmD9CpeKuqJm/9
         x73gZ6ZNk3mMjxU8xy4Dp5DfcPbN5HzcjPZ/2e//V0krnvACN/tA9qDw4EIOXestiUEs
         HQLA==
X-Gm-Message-State: ACgBeo2cag/vXRkrIB4xoJz7BngCSMPYtOVvd5PwnzJsoWM4/jaxo+HK
        pGNHCEb8D8UbrZ3G7iT/lko=
X-Google-Smtp-Source: AA6agR4unMXM/o8ReAcZPhZYlQvKEykwqvDuzjzFUoluKCpKIsGMEVPbfjJmmeMiZtpmk8I3s2wRkw==
X-Received: by 2002:a17:90b:3702:b0:1f3:366c:8c77 with SMTP id mg2-20020a17090b370200b001f3366c8c77mr17409901pjb.119.1659349643076;
        Mon, 01 Aug 2022 03:27:23 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:579:6a6f:8d46:b2ef:57e3:7c30])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016c6a6d8967sm9199302plb.83.2022.08.01.03.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 03:27:22 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH v3 3/7] usb: typec: tcpci_rt1711h: Add regulator support when source vbus
Date:   Mon,  1 Aug 2022 18:14:43 +0800
Message-Id: <20220801101447.86207-4-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801101447.86207-1-gene.chen.richtek@gmail.com>
References: <20220801101447.86207-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add regulator support when source vbus

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 6197d9a05d36..df7bfe299987 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/usb/tcpm.h>
 
 #include "tcpci.h"
@@ -42,6 +43,8 @@ struct rt1711h_chip {
 	struct tcpci_data data;
 	struct tcpci *tcpci;
 	struct device *dev;
+	struct regulator *vbus;
+	bool src_en;
 };
 
 static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg, u16 *val)
@@ -105,6 +108,26 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
 
 	/* dcSRC.DRP : 33% */
 	return rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
+
+}
+
+static int rt1711h_set_vbus(struct tcpci *tcpci, struct tcpci_data *tdata,
+			    bool src, bool snk)
+{
+	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
+	int ret;
+
+	if (chip->src_en == src)
+		return 0;
+
+	if (src)
+		ret = regulator_enable(chip->vbus);
+	else
+		ret = regulator_disable(chip->vbus);
+
+	if (!ret)
+		chip->src_en = src;
+	return ret;
 }
 
 static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
@@ -248,7 +271,12 @@ static int rt1711h_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
+	chip->vbus = devm_regulator_get(&client->dev, "vbus");
+	if (IS_ERR(chip->vbus))
+		return PTR_ERR(chip->vbus);
+
 	chip->data.init = rt1711h_init;
+	chip->data.set_vbus = rt1711h_set_vbus;
 	chip->data.set_vconn = rt1711h_set_vconn;
 	chip->data.start_drp_toggling = rt1711h_start_drp_toggling;
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
-- 
2.25.1

