Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972F35308C7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiEWF2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiEWF2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:28:19 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E861EC58
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 22:28:17 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p189so8002312wmp.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 22:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=am8B+AfzENDAWt/qUpAzFaFRwymNfGJXzUuOXFbCk5M=;
        b=epimhOkcWXRnlpp8as0ZW+FCbrusHfj/ITRwlU6Vhp/3I6NG2pkCv6U0JAXbECrxAi
         5JgX4XrBwfOygUCyihy2r2LJEbBes9nonYi7JaEe6elkb5RyKPBNoj6DDWiL3rX/GLl1
         xyLLbKsrVDmAJYjht4vIWAonOCNupzue4YniEXzr4VTxfQwYF5kqaSTlLp8sPhRngcLu
         dOYDtisMlBvTmVCC60hthfCVO5+6Au+C6JDq1HGzNPZwzZ5oP42aotzyjgnXulr9QUV5
         abEN04R+Umu8SsgDhPFY2wzEbh+hTg683evjd6Oy4unU/bhxeSf3igPWv144MTNMYyj5
         7oOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=am8B+AfzENDAWt/qUpAzFaFRwymNfGJXzUuOXFbCk5M=;
        b=1AZ8gNECjtqNxht+Kq3rKjdwSEAx7imvwbIQFTW1aTpJGGzEtCF6IFBdEJnM/XQxEM
         hh2ClVzKozvmNYrUvIp4wDua7wPYX73NkLEWkdLbm7JUTvg5s17Dv3QgviZy2iDTKdhV
         1yIHX7aLzNrd+iCiG/Tcir7H31fOy8cvSIt4Ppzg5uZc+Ek11U0yMBttCvurkmb5DG2+
         atpZOeeIznmKvWkQdXAFdivXo7KJ//CoG33svfT/orM2wyqTZBkRi5B9fXzXwjVsaknk
         2GK9aQ64eUVMlG0Be1VLc78K1eFFExWjZevu31SZ5ovBFkmUQijjvliV0he4qj+bkAYN
         HYGA==
X-Gm-Message-State: AOAM530LbPaEsrlOjspPP0laRZCTrgjwTWTYlVinfDPltW0NKhHpuyU0
        z7Dew0neMP89hZoHNEWodxtbVg==
X-Google-Smtp-Source: ABdhPJzm/entZ+SLPL0EhI0XgtI+1xyVC6MTxHThdpeAizznoJknLGj7DCHKY7ficjfSib+0ndrkiA==
X-Received: by 2002:a05:600c:348e:b0:397:3f81:2168 with SMTP id a14-20020a05600c348e00b003973f812168mr2752873wmq.168.1653283695871;
        Sun, 22 May 2022 22:28:15 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h2-20020a1ccc02000000b0039466988f6csm7802414wmb.31.2022.05.22.22.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 22:28:15 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     andrew@lunn.ch, broonie@kernel.org, calvin.johnson@oss.nxp.com,
        davem@davemloft.net, edumazet@google.com, hkallweit1@gmail.com,
        jernej.skrabec@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        kuba@kernel.org, lgirdwood@gmail.com, linux@armlinux.org.uk,
        pabeni@redhat.com, robh+dt@kernel.org, samuel@sholland.org,
        wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        netdev@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 1/3] regulator: Add regulator_bulk_get_all
Date:   Mon, 23 May 2022 05:28:05 +0000
Message-Id: <20220523052807.4044800-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523052807.4044800-1-clabbe@baylibre.com>
References: <20220523052807.4044800-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It work exactly like regulator_bulk_get() but instead of working on a
provided list of names, it seek all consumers properties matching
xxx-supply.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/regulator/core.c           | 92 ++++++++++++++++++++++++++++++
 include/linux/regulator/consumer.h |  2 +
 2 files changed, 94 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1e54a833f2cf..7286bcf3821a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4813,6 +4813,98 @@ static void regulator_bulk_enable_async(void *data, async_cookie_t cookie)
 	bulk->ret = regulator_enable(bulk->consumer);
 }
 
+/*
+ * Check if name is a supply name according to the '*-supply' pattern
+ * return 0 if false
+ * return length of supply name without the -supply
+ */
+static int is_supply_name(const char *name)
+{
+	int strs, i;
+
+	strs = strlen(name);
+	/* string need to be at minimum len(x-supply) */
+	if (strs < 8)
+		return 0;
+	for (i = strs - 6; i > 0; i--) {
+		/* find first '-' and check if right part is supply */
+		if (name[i] != '-')
+			continue;
+		if (strcmp(name + i + 1, "supply") != 0)
+			return 0;
+		return i;
+	}
+	return 0;
+}
+
+/*
+ * regulator_bulk_get_all - get multiple regulator consumers
+ *
+ * @dev:	Device to supply
+ * @np:		device node to search for consumers
+ * @consumers:  Configuration of consumers; clients are stored here.
+ *
+ * @return number of regulators on success, an errno on failure.
+ *
+ * This helper function allows drivers to get several regulator
+ * consumers in one operation.  If any of the regulators cannot be
+ * acquired then any regulators that were allocated will be freed
+ * before returning to the caller.
+ */
+int regulator_bulk_get_all(struct device *dev, struct device_node *np,
+			   struct regulator_bulk_data **consumers)
+{
+	int num_consumers = 0;
+	struct regulator *tmp;
+	struct property *prop;
+	int i, n = 0, ret;
+	char name[64];
+
+	*consumers = NULL;
+
+/*
+ * first pass: get numbers of xxx-supply
+ * second pass: fill consumers
+ * */
+restart:
+	for_each_property_of_node(np, prop) {
+		i = is_supply_name(prop->name);
+		if (i == 0)
+			continue;
+		if (!*consumers) {
+			num_consumers++;
+			continue;
+		} else {
+			memcpy(name, prop->name, i);
+			name[i] = '\0';
+			tmp = regulator_get(dev, name);
+			if (!tmp) {
+				ret = -EINVAL;
+				goto error;
+			}
+			(*consumers)[n].consumer = tmp;
+			n++;
+			continue;
+		}
+	}
+	if (*consumers)
+		return num_consumers;
+	if (num_consumers == 0)
+		return 0;
+	*consumers = kmalloc_array(num_consumers,
+				   sizeof(struct regulator_bulk_data),
+				   GFP_KERNEL);
+	if (!*consumers)
+		return -ENOMEM;
+	goto restart;
+
+error:
+	while (--n >= 0)
+		regulator_put(consumers[n]->consumer);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regulator_bulk_get_all);
+
 /**
  * regulator_bulk_enable - enable multiple regulator consumers
  *
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index bbf6590a6dec..b9b1d1cbdd07 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -238,6 +238,8 @@ int regulator_disable_deferred(struct regulator *regulator, int ms);
 
 int __must_check regulator_bulk_get(struct device *dev, int num_consumers,
 				    struct regulator_bulk_data *consumers);
+int __must_check regulator_bulk_get_all(struct device *dev, struct device_node *np,
+					struct regulator_bulk_data **consumers);
 int __must_check devm_regulator_bulk_get(struct device *dev, int num_consumers,
 					 struct regulator_bulk_data *consumers);
 int __must_check regulator_bulk_enable(int num_consumers,
-- 
2.35.1

