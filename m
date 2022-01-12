Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DBE48CBA3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356959AbiALTMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356630AbiALTLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:11:05 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67136C03401F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:10:55 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso14173813pjm.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BGP24qVZTEpaBQ1xv9moCmCJQ917JXiSUjVHHrmVp/E=;
        b=PVG7VTvqlLNGORnwYw9j1OMg3+3ZTPcoOj7kAksry9PLrHcTCLejULVii9l67Eb/Yb
         OyWS2q9EPoXcwoFq2f9ykMMa51KEQobaL9AdrHlljItrFlLb84qUPypxl7NeIFM2gYfP
         F73jNvzEHeYQkxbqSRA7deWpXLcHHVQuVGgD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BGP24qVZTEpaBQ1xv9moCmCJQ917JXiSUjVHHrmVp/E=;
        b=QvT2Xgb3+pigixJzuMADcX3Rhx7JAAqhr7EbC8GK1011BHOmlRlrzJGjepSrR3d+3d
         RHzKMYhTrT1MSc3PCUFrQHRBSjFrkrzdZ6CHr53gqx4gLtQtGyWsGYBpiyYex94lXbUC
         rWsNCyIiItRSxH3ZX88Rrh/JJr9rSfJT6ys0bHRNXmxNLtUE43+8C7h7yn9Msu+7ueoy
         +fjdVsDvETpptrUvGYFJJ5tF0yoSejaQzibWVcxf6y9diPSFyaDLeDHpjeLiuPiF0zjX
         cM88vlCyy2YnoX58w4g6o+vQovltgk9mgZISaxXlwE9otpOfCQ31JJI28nsaqauB4W3V
         zlWg==
X-Gm-Message-State: AOAM5308V3vXimhr0qYpkj9gNkwmNhfQKFcLbE60OQ7WRokL9OmvcFKT
        DzoJGo35UCa2Xq4U+8rgfRkTRg==
X-Google-Smtp-Source: ABdhPJw0V7BAx/B4MLxvQ6u03zIBW4izudN2SvaqvG2oZbVic37IkfQmBRwmo4ewdqAYV59wyZCiPw==
X-Received: by 2002:a63:a74d:: with SMTP id w13mr904351pgo.7.1642014654994;
        Wed, 12 Jan 2022 11:10:54 -0800 (PST)
Received: from localhost ([2620:15c:202:201:f6eb:5b26:28c:1ca5])
        by smtp.gmail.com with UTF8SMTPSA id n8sm356040pgh.94.2022.01.12.11.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 11:10:54 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-usb@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v19 1/5] of/platform: Add stubs for of_platform_device_create/destroy()
Date:   Wed, 12 Jan 2022 11:10:44 -0800
Message-Id: <20220112111028.v19.1.I08fd2e1c775af04f663730e9fb4d00e6bbb38541@changeid>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220112191048.837236-1-mka@chromium.org>
References: <20220112191048.837236-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code for platform_device_create() and of_platform_device_destroy() is
only generated if CONFIG_OF_ADDRESS=y. Add stubs to avoid unresolved
symbols when CONFIG_OF_ADDRESS is not set.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---

Changes in v19:
- still no changes ...

Changes in v18:
- still no changes ...

Changes in v17:
- none

Changes in v16:
- none

Changes in v15:
- none

Changes in v14:
- none

Changes in v13:
- none

Changes in v12:
- none

Changes in v11:
- none

Changes in v10:
- none

Changes in v9:
- added Rob's 'Acked-by' tag

Changes in v8:
- fixed C&P error in commit message

Changes in v7:
- none

Changes in v6:
- patch added to the series

 include/linux/of_platform.h | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 84a966623e78..d15b6cd5e1c3 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -61,16 +61,18 @@ static inline struct platform_device *of_find_device_by_node(struct device_node
 }
 #endif
 
+extern int of_platform_bus_probe(struct device_node *root,
+				 const struct of_device_id *matches,
+				 struct device *parent);
+
+#ifdef CONFIG_OF_ADDRESS
 /* Platform devices and busses creation */
 extern struct platform_device *of_platform_device_create(struct device_node *np,
 						   const char *bus_id,
 						   struct device *parent);
 
 extern int of_platform_device_destroy(struct device *dev, void *data);
-extern int of_platform_bus_probe(struct device_node *root,
-				 const struct of_device_id *matches,
-				 struct device *parent);
-#ifdef CONFIG_OF_ADDRESS
+
 extern int of_platform_populate(struct device_node *root,
 				const struct of_device_id *matches,
 				const struct of_dev_auxdata *lookup,
@@ -84,6 +86,18 @@ extern int devm_of_platform_populate(struct device *dev);
 
 extern void devm_of_platform_depopulate(struct device *dev);
 #else
+/* Platform devices and busses creation */
+static inline struct platform_device *of_platform_device_create(struct device_node *np,
+								const char *bus_id,
+								struct device *parent)
+{
+	return NULL;
+}
+static inline int of_platform_device_destroy(struct device *dev, void *data)
+{
+	return -ENODEV;
+}
+
 static inline int of_platform_populate(struct device_node *root,
 					const struct of_device_id *matches,
 					const struct of_dev_auxdata *lookup,
-- 
2.34.1.575.g55b058a8bb-goog

