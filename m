Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27184824DD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 17:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhLaQUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 11:20:24 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:54872
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231267AbhLaQUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 11:20:18 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6BBB6406EA
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 16:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640967617;
        bh=DIlpbupBLlvhME495ccC/GJjqZBKtEWGWE9M06bGn4s=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=evOqhPfb7LoXf/Ar6zNSlbfnRZ/TkPFpJLtIXNhOIdvzSGaFsu3VOS3JH/+CzqhiG
         NPkBe1kiAc+bbW7hN2seX6qeLcd4E5rx9l+lPchCXbHL5ipp/O/TNHdVFspHpmzJBx
         0cwzQP+xulArfdG331NFQqOy9x5XpqvPMpCl5ARfZk7Y0yXNUY/VIZwxOgK4xNKNRK
         q377j/5OBSSWfR2lODwzVwRHs4KmVw+6z/D+ju8Xjgw+Ty3nR8bqR8dv39lX92BJ+8
         OI5wPRQ6BS+9xJYDlLr8Lu+2Emusjh6CZh33m5p8ttWCK6mPmIMKjrSnLtke5/ufMt
         xpITLsWOTErtw==
Received: by mail-lj1-f200.google.com with SMTP id y4-20020a2e95c4000000b0022dbab5f69eso6671377ljh.14
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 08:20:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DIlpbupBLlvhME495ccC/GJjqZBKtEWGWE9M06bGn4s=;
        b=SXroZ3x3+t1zLiao0GJ3LQjPf4uGYqfK2Y4RuD3wnNrLtWNZIwfOm/71zFBSdhc1eJ
         zEmm/gHHXeDk5UsD+IZmiHvLmhD42ga8RdofioU7iQkIDLOkYOM50SYFbGIf6RxXI6Bi
         dxDKGqUa223DvGlB9zWkMQqZWt1WuLm27CGdW54i86dx0S+dDaAB55qJj4mnMd2Ekk51
         j8HJN2VD1QR0ibAfiBDd73mZoYWAS4jHXoLHvfp0NqY8RJaha9VGYGjTqSs939JLAkBk
         yrmeMMiiK3GQ1/Uk9aQo6iUtCZRZacXyDCmzwNc7sWz9xoRWEr+dju9d2l54ifeLk52x
         nDdQ==
X-Gm-Message-State: AOAM533yGblpNsqKavMKNcBbUeGSgtvK3uiSSag5cpUClD5XLuOQYd1a
        c3wfGplmWpDe2WgrI/8bGeBfNQ6BfWhKEW0Rx9k2o+4Wk6hl30XJuuacwv9b7ASJPdTbXASZV7s
        ZeXws2NY4Nd4+2XMnjGYUfhzs3kOX0da68xwf6sxpZw==
X-Received: by 2002:ac2:5297:: with SMTP id q23mr29964317lfm.192.1640967616486;
        Fri, 31 Dec 2021 08:20:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJodevQXJIyAk4xZjnM+a51+YZ8a29g7tEjVrvpL5Dgq1KqQho2kvWsuAvQ/9Y8hwXYpClJw==
X-Received: by 2002:ac2:5297:: with SMTP id q23mr29964305lfm.192.1640967616316;
        Fri, 31 Dec 2021 08:20:16 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id bx10sm2817607ljb.3.2021.12.31.08.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 08:20:15 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 02/24] pinctrl: samsung: accept GPIO bank nodes with a suffix
Date:   Fri, 31 Dec 2021 17:19:08 +0100
Message-Id: <20211231161930.256733-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211231161930.256733-1-krzysztof.kozlowski@canonical.com>
References: <20211231161930.256733-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing dt-bindings expected that each GPIO/pin bank within pin
controller has its own node with name matching the bank (e.g. gpa0,
gpx2) and "gpio-controller" property.  The node name is then used for
matching between driver data and DTS.

Newly introduced dtschema expects to have nodes ending with "-gpio-bank"
suffix, so rewrite bank-devicetree matching to look for old and new
style of naming.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 57 ++++++++++++++++++-----
 1 file changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index f2864a7869b3..561853df8ef7 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1011,13 +1011,56 @@ static void samsung_banks_of_node_put(struct samsung_pinctrl_drv_data *d)
 		of_node_put(bank->of_node);
 }
 
+/*
+ * Iterate over all driver pin banks to find one matching the name of node,
+ * skipping optional "-gpio" node suffix. When found, assign node to the bank.
+ */
+static void samsung_banks_of_node_get(struct device *dev,
+				      struct samsung_pinctrl_drv_data *d,
+				      struct device_node *node)
+{
+	const char *suffix = "-gpio-bank";
+	struct samsung_pin_bank *bank;
+	struct device_node *child;
+	/* Pin bank names are up to 4 characters */
+	char node_name[20];
+	unsigned int i;
+	size_t len;
+
+	bank = d->pin_banks;
+	for (i = 0; i < d->nr_banks; ++i, ++bank) {
+		strscpy(node_name, bank->name, sizeof(node_name));
+		len = strlcat(node_name, suffix, sizeof(node_name));
+		if (len == sizeof(sizeof(node_name))) {
+			dev_err(dev, "Too long pin bank name '%s', ignoring\n",
+				bank->name);
+			continue;
+		}
+
+		for_each_child_of_node(node, child) {
+			if (!of_find_property(child, "gpio-controller", NULL))
+				continue;
+			if (of_node_name_eq(child, node_name))
+				break;
+			else if (of_node_name_eq(child, bank->name))
+				break;
+		}
+
+		if (child)
+			bank->of_node = child;
+		else
+			dev_warn(dev, "Missing node for bank %s - invalid DTB\n",
+				 bank->name);
+		/* child reference dropped in samsung_drop_banks_of_node() */
+	}
+}
+
 /* retrieve the soc specific data */
 static const struct samsung_pin_ctrl *
 samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
 			     struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct device_node *np;
 	const struct samsung_pin_bank_data *bdata;
 	const struct samsung_pin_ctrl *ctrl;
 	struct samsung_pin_bank *bank;
@@ -1081,17 +1124,7 @@ samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
 	 */
 	d->virt_base = virt_base[0];
 
-	for_each_child_of_node(node, np) {
-		if (!of_find_property(np, "gpio-controller", NULL))
-			continue;
-		bank = d->pin_banks;
-		for (i = 0; i < d->nr_banks; ++i, ++bank) {
-			if (of_node_name_eq(np, bank->name)) {
-				bank->of_node = np;
-				break;
-			}
-		}
-	}
+	samsung_banks_of_node_get(&pdev->dev, d, node);
 
 	d->pin_base = pin_base;
 	pin_base += d->nr_pins;
-- 
2.32.0

