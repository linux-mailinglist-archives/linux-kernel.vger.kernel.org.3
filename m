Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C36D556DF2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 23:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbiFVVtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 17:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235790AbiFVVtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 17:49:40 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560BE3EF3F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 14:49:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id f16so15699936pjj.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 14:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RYo72b6Ijno9jF+3oVXVAu6rYky7oicN7MbfvMQU10Y=;
        b=L+30HUEUe2KDcIAq1uFJrj2Z5LR7I01NP2W/YaBtnp/sFrf8UrfzzY9/HfFOUAtKfz
         7WjJru0+PyIXFx4RwJZpfoOThNWYekGY8vzi7JB++QE3hvpcD3GdnZL3MAc1Ykd9YNQ2
         CNs7zjfQU4emUngu8c6FB6ngrqfvbD3UgwinM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RYo72b6Ijno9jF+3oVXVAu6rYky7oicN7MbfvMQU10Y=;
        b=iQE0sR/vm968C29GYXZnDelyChFKELEaGKKSIkq0852A4iq6uyDj2rFqtrutzpMQYM
         2TFhQ3tobyEhzRJujl0P4Ib44Zf6lDktR/njoJcQr3acGQo3YW1I1og4YPzWZzvAE7jV
         X4KQJpNM4Hsx9uECJ9gZQ+TCU+I8leiACCkc5AoRCQSGHhtJRLJoTxlcG/lbYhEO2ZPX
         dW4us6Xfq48ZdGv6kJZtP/wG+NbL6s6VrDrcvBsgr76TmoD1I9cwhpidnQ1alpgKE4ob
         3/mFmGqHucs14tbLlZtz7V3uLVMjtcD/EPdhOPcgC/+wvBLABukTLpE7lYJ8GRYUtzNd
         LTDQ==
X-Gm-Message-State: AJIora+IytH8pKtG/xt6bOILyiC1dK5WhqaX3+SZJvNh+K7e3yeSeexR
        hDI/FfBJXF/xas63AROshjRKhA==
X-Google-Smtp-Source: AGRyM1vcEnofwplspmPqXo/cxwmtOIHXhYS3FkGFuH7j/q/BgcTozPwcRKVgSdRL0exE/1XA0/BcxA==
X-Received: by 2002:a17:90b:1c02:b0:1e3:4b6d:4269 with SMTP id oc2-20020a17090b1c0200b001e34b6d4269mr468613pjb.57.1655934578721;
        Wed, 22 Jun 2022 14:49:38 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:83c:92dc:a659:2900])
        by smtp.gmail.com with UTF8SMTPSA id i188-20020a62c1c5000000b005187431876fsm6752817pfg.180.2022.06.22.14.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 14:49:38 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bastien Nocera <hadess@hadess.net>, linux-usb@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v23 1/3] of/platform: Add stubs for of_platform_device_create/destroy()
Date:   Wed, 22 Jun 2022 14:49:29 -0700
Message-Id: <20220622144857.v23.1.I08fd2e1c775af04f663730e9fb4d00e6bbb38541@changeid>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220622214931.1914770-1-mka@chromium.org>
References: <20220622214931.1914770-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code for platform_device_create() and of_platform_device_destroy() is
only generated if CONFIG_OF_ADDRESS=y. Add stubs to avoid unresolved
symbols when CONFIG_OF_ADDRESS is not set.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v23:
- none

Changes in v22:
- none

Changes in v21:
- none

Changes in v20:
- added 'Reviewed-by' tags from Stephen and Doug

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
2.37.0.rc0.104.g0611611a94-goog

