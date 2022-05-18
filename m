Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4859452C416
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242410AbiERUKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242350AbiERUJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:09:51 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A512375DD
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:09:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w4so4131462wrg.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SriQP5QFvjv+22faclUlTpDEJWTfd/KIKG1YNKb9hlI=;
        b=J4LewnuHwL3OxcTIVsMV6xN29ahSYB41PufuCCLLZzBavi8wqCUKbAi0RjpMnBEpa5
         noxOj3l/Q0xa0pfPtdvf18gKW9Zb/EZaRa/SOxIXnyxjw+nuiJb5QP5Q6GQR5P1GglVi
         JFHu9Ng85tUZ/O9Sni3weCi6mg7weoktZDBqFRtWbtamXTRTq3qS6/kmEPrzaItPPhXM
         KyOlMGsf+AphBrM5hvPo9sL4hpneCx/gYzeyF2xGgBAX7rF84qgKn4c3qUhmUOWjcsDg
         tHhCmxt7XboKoK+gHTmUYvQd0fnpwDrMxVY+s2J+1UdWz6fGjXwJ8f6y7QumTnTlUZ3R
         AZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SriQP5QFvjv+22faclUlTpDEJWTfd/KIKG1YNKb9hlI=;
        b=naQcGApTybp6BQzl+V9biY0BDoKmb1+8WzyuOXj01eilD5ABx+dC7Slp0I8b+oetWI
         QgwTdF2w2K8JPrFEnJWiheCZ9UR210qaEA3j7EaQa/KeePObJSnqNPCMFfHqRcWwL4wU
         R2B6xSB1Bi+gug9qnt59lJhYLQUtEjezHTBhXnwk9FtD8k+9IPYYFxey9gBt4UTdf8MH
         3L+xfTpD0PWNhlqnG2/+euh1K3bCnWYTYQNBMe50wpEIQ1uDog7LYD2JdQC/hs3zKpLe
         VwIpAqSsThcpLU7Ychjswvi2hq2RKw6WaL51liryD2r0dG9L40oDDpuZQYRq2K3ikUpT
         Vz0Q==
X-Gm-Message-State: AOAM530ioZk+uhYwyhsl4PaSoczGuAUdZhbNY2xxLaBke8VzYSIjc8rG
        Tg0V6l2u9+bMZ3bNSa/YM0LTAw==
X-Google-Smtp-Source: ABdhPJzppEln44MKcc9NY2qMbwnqkJ2Uq4IVab5lsOYJZ/r22l4fVuEatjuvyjoXfolPItUTNK1ZoA==
X-Received: by 2002:a05:6000:186f:b0:20c:5f3d:44a4 with SMTP id d15-20020a056000186f00b0020c5f3d44a4mr1126253wri.152.1652904588901;
        Wed, 18 May 2022 13:09:48 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o23-20020a05600c511700b0039456c00ba7sm6859281wms.1.2022.05.18.13.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:09:48 -0700 (PDT)
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
Subject: [PATCH v2 2/5] regulator: Add regulator_bulk_get_all
Date:   Wed, 18 May 2022 20:09:36 +0000
Message-Id: <20220518200939.689308-3-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518200939.689308-1-clabbe@baylibre.com>
References: <20220518200939.689308-1-clabbe@baylibre.com>
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
provided list of names, it get names from a regulators list.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/regulator/core.c           | 49 ++++++++++++++++++++++++++++++
 include/linux/regulator/consumer.h |  2 ++
 2 files changed, 51 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 09578c3595de..719ce9a0db1b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4849,6 +4849,55 @@ static void regulator_bulk_enable_async(void *data, async_cookie_t cookie)
 	bulk->ret = regulator_enable(bulk->consumer);
 }
 
+/**
+ * regulator_bulk_get_all - get multiple regulator consumers
+ *
+ * @dev:           Device to supply
+ * @consumers:     Configuration of consumers; clients are stored here.
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
+	int num_consumers;
+	int i, ret;
+	struct regulator *tmp;
+	const char *p;
+
+	num_consumers = of_property_count_elems_of_size(np, "regulators",
+							sizeof(phandle));
+	if (num_consumers <= 0)
+		return num_consumers;
+
+	ret = of_property_count_strings(np, "regulator-names");
+	if (ret != num_consumers) {
+		dev_err(dev, "regulators and regulator-names does not have the same size\n");
+		return -EINVAL;
+	}
+	*consumers = kmalloc_array(num_consumers, sizeof(struct regulator_bulk_data), GFP_KERNEL);
+	if (!*consumers)
+		return -ENOMEM;
+	for (i = 0; i < num_consumers; i++) {
+		ret = of_property_read_string_helper(np, "regulator-names", &p, 1, i);
+		if (ret <= 0)
+			goto error;
+		tmp = regulator_get(dev, p);
+		(*consumers)[i].consumer = tmp;
+	}
+	return num_consumers;
+error:
+	while (--i >= 0)
+		regulator_put(consumers[i]->consumer);
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

