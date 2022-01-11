Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F56848B818
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243354AbiAKUP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:15:28 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:59746
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243111AbiAKUPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:15:25 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 95CD13F175
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641932122;
        bh=yNEEeI5zCJmr7xVf7gFV3sEIRbcvfS4VZZqxLHMMY6k=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=l5P+3HhlOutfnfiGmChkLNyP9OGNBQ1o30O0S/6DlfYv1s4F9aPpULR1dUlFu5lkW
         DLdgDVpu+6nk0HMAy6+O3cXCbLCRRg+UOIwC4OnU3Ox6/SEdp+Rs8o7iibHEtMj0C+
         P48ay7+qx9kd62vRy3bDqq4J9yiGvAGxg7akWX9J9cT7W8cAkOYoCiPOhc001bNN0t
         8y+OphC4+g05ckG9qEE34e1nnhqWNhmqE4Xow4IlNGrNGS2pLa0O7+QFrkbvHsdYZ2
         QJdpv59TL2bUdLlkx/3IAMZ97WejKsY4IRMfePD7lI3vx0+pOUJY4T+Xt1zfdRCrgw
         PxM49DIeTPsSw==
Received: by mail-ed1-f72.google.com with SMTP id g11-20020a056402090b00b003f8fd1ac475so215032edz.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yNEEeI5zCJmr7xVf7gFV3sEIRbcvfS4VZZqxLHMMY6k=;
        b=xFDYh+pwwXygzcOyqkuiqhHVHF7Rcfqzo585e0+ZVSG4iG6V9IJke5A5iXEcgGqGMF
         25i8gEVU9limE+VxBp7qWRA1Be3LX/ltvKUR7lTgoH85tJ0lpTojq+cCyDfWlREibdI1
         adLYsJjmYJ1P6p6e1BlyeR2b9JVvmYcm4Lg2TLQiHN7motHGRNlw+oRkSc2kBK4HtPyl
         kuSRYH7mgRBUik5m/E3T/6EwFoz128O4/DXY6mUgTl275plVT0UDvBgekq9xvS/6BwLb
         kjXNfF87uHToo5gn6TgxkmOaeEjED1xs9bSBNQ1Z0DwqmD3K8DwF+0vHTqd6ER0LOZid
         +BHg==
X-Gm-Message-State: AOAM530Vh4qNXXYEBuRm4G2+L2doaZ+Tjw7IggT1Zs5SbAB2VW2+Iv3P
        6OGnPt99K4szWEXAPB6Gj2/3WUQjzm4SPSAbLsulxCr2pTqkKOtykLmDnrBGhwCTISWseAaymet
        nPqOcYR1I21qpS9hdodZAMpDrrGM/HiggnD7GcG39+A==
X-Received: by 2002:aa7:da50:: with SMTP id w16mr5952130eds.41.1641932118820;
        Tue, 11 Jan 2022 12:15:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKzK3Ptpd9d437ZzvCcxxfRuUl4Nu7v0FlOhHb5BgeOdhnGvZZDtlcZwgwq6CWiep3IXnraA==
X-Received: by 2002:aa7:da50:: with SMTP id w16mr5952118eds.41.1641932118626;
        Tue, 11 Jan 2022 12:15:18 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id f23sm3852212ejj.128.2022.01.11.12.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 12:15:18 -0800 (PST)
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
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>
Subject: [PATCH v2 02/28] pinctrl: samsung: accept GPIO bank nodes with a suffix
Date:   Tue, 11 Jan 2022 21:14:00 +0100
Message-Id: <20220111201426.326777-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
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
index b19ebc43d886..b3a5bc473841 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1012,13 +1012,56 @@ static void samsung_banks_of_node_put(struct samsung_pinctrl_drv_data *d)
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
+		if (len >= sizeof(node_name)) {
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
@@ -1082,17 +1125,7 @@ samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
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

