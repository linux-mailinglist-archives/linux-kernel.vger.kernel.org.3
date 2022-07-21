Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22F557C436
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiGUGMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiGUGMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:12:02 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A207859F;
        Wed, 20 Jul 2022 23:12:00 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id bf13so722921pgb.11;
        Wed, 20 Jul 2022 23:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6sF8VJbpidhbdsrvIAVkvPjdZOS37WXf+C4sKxMlkj4=;
        b=MlZBc9WnBM1JQcT/JZtcUavjwfHgEnHx2myTDkl3q84VKT/Ztb1PeXIyZEBArzd2qU
         6Agxh/SqYh2PS8GgX7AQDopKsI6c+FglP3J6u9xD0SwpEWCfz0hdHNJfGF672dcVYMRb
         Y7DpCu0ixooie8cY55HeVNIu2JqR3uz3qHm/RY+GU4twmjlLfJtbTwrNRmGNS13uIXR7
         fOgOoVMkM2XfRCv8nn8dHpPM6FxjcCRJadAL10Q9pKXsXQcd0w1OUpjTQxiL/AalJT44
         jEPqbRQ9dILkluIDFDR/mCzaTyNpIhXwU9rLzKG9cu+vm0fAptg/1Rv+hDANwT5vA9MR
         52VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6sF8VJbpidhbdsrvIAVkvPjdZOS37WXf+C4sKxMlkj4=;
        b=HfABtk79INbUllH9dDN0x3GIIlJlOl1oPY+NH7IyIXTn1pey2WB1cdtILbn2yMJub2
         u7XyMa6zwYcphV/UU8hIi1ma1mUKEJcR/cFYcCRHgzHX8jTibv0mApAZaEx8FvMy7BWe
         +Tw1QT4J5lH+RRsv4pOunNAzVenuMU7KBlXXVHqDLHLElzG9zmEkL5zNoR1OPCAkraAU
         AWElp85c4LZDElNxh9RWpug+q85ADGVGlah579mZBkjqw3Fmnwel3YxmZOFjJ7YdFRU5
         ANPADbNo9/mbBNZInYcS7nFCriC61a8iRGwGXk+D1cvXiqJztC1gQn874XA6DiDGq3zm
         LVSA==
X-Gm-Message-State: AJIora8J8f8dhwxUd6Tbc5gb1jzwTPV+Qw9bhTrR1Qb495Ds7jO0qnRN
        NPjpQBLaoqCiXTlp/6VCRXg=
X-Google-Smtp-Source: AGRyM1vcjYkOvrCXzM8VN+s2Q5kugMc1hPNGKeopAgUbzjuVJvXngm/Gc84CM47+fHTD295B4/tv1g==
X-Received: by 2002:a65:6151:0:b0:412:e419:d651 with SMTP id o17-20020a656151000000b00412e419d651mr37227145pgv.378.1658383919592;
        Wed, 20 Jul 2022 23:11:59 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:46a:8b75:f825:a44d:6d0d:6d6e])
        by smtp.gmail.com with ESMTPSA id 13-20020a62170d000000b0052ba782f4cbsm744998pfx.7.2022.07.20.23.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:11:59 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH v2 3/6] usb: typec: tcpci_rt1711h: Add regulator support when source vbus
Date:   Thu, 21 Jul 2022 14:11:41 +0800
Message-Id: <20220721061144.35139-4-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721061144.35139-1-gene.chen.richtek@gmail.com>
References: <20220721061144.35139-1-gene.chen.richtek@gmail.com>
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
index 3309ceace2b2..52c9594e531d 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -10,6 +10,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
 #include <linux/usb/tcpm.h>
 #include <linux/regmap.h>
 #include "tcpci.h"
@@ -40,6 +41,8 @@ struct rt1711h_chip {
 	struct tcpci_data data;
 	struct tcpci *tcpci;
 	struct device *dev;
+	struct regulator *vbus;
+	bool src_en;
 };
 
 static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg, u16 *val)
@@ -103,6 +106,26 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
 
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
+		return 1;
+
+	if (src)
+		ret = regulator_enable(chip->vbus);
+	else
+		ret = regulator_disable(chip->vbus);
+
+	if (!ret)
+		chip->src_en = src;
+	return ret ? ret : 1;
 }
 
 static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
@@ -246,7 +269,12 @@ static int rt1711h_probe(struct i2c_client *client,
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

