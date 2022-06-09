Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD495454CE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240842AbiFITUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245512AbiFITUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:20:08 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB7831753A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 12:20:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w13-20020a17090a780d00b001e8961b355dso201968pjk.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 12:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vLKCtH9TakuUqk54EpzoBPA1XDOnud2z5RmTIYy238A=;
        b=a9YEBJkAz+xoaA4KVG/no6vZRzslKfjP87zE2WiwftU0netMy/IOrBH+COySZOnOdZ
         kD02vfMs8GkeyURwr7jGS/yfEPatFqq2pvvy71avWykoZYUNCbS43FLL/B1j1/0TCwy8
         j4gIYlL1dgndj27LC0d/rZcMNy0VnPRUczHPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vLKCtH9TakuUqk54EpzoBPA1XDOnud2z5RmTIYy238A=;
        b=xlFkLA18qltdwoepo1hYEkd8iyP4eoFVqu3yhfS3PopPm0HvvoYU4TbWrMKqDgAj7t
         cCVRD59l7bZNsP7OBYpCRZbbACSonH0yYyvLKwhppDCIA0Nxh2MTiYsqmtQltoUljSMg
         pQmlFCzMQ6vcIgioETpD48EEYfnSgiw5b2OLFuXobTpbg7iOwBuk9n0a8YrYeIu2Y0V8
         7BZM1Tt4zfMsg5LLuFjQTEX+itIDdiFSERAclvxKLJuaIVjCsk9RjgOsij4Et0M/6cOl
         yGYOV4BosR8NNj2RwSmoZ9Hmmv77zdqwEai56SubBvWQqNIUU8eDiLlDTxErRHbxh1mf
         kKdA==
X-Gm-Message-State: AOAM532ELFaNR2hN5M0Pz05TQu/og3eSB1fJfiqY0bN3u0XA3m+z1xaa
        P/p0RR5ObpRnd0tj2PmkoIggww==
X-Google-Smtp-Source: ABdhPJwd4IBhEsvEVkOSeWd2FTjMb5R1CmzJ8+wh7U9MwNuQ2qFEk6DiIZJWUkgv93jnKjlzR7iN9g==
X-Received: by 2002:a17:90a:740e:b0:1e2:a631:87e6 with SMTP id a14-20020a17090a740e00b001e2a63187e6mr4873261pjg.115.1654802406094;
        Thu, 09 Jun 2022 12:20:06 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:c543:2c9:1206:951b])
        by smtp.gmail.com with UTF8SMTPSA id z8-20020a1709027e8800b00163d8d9aefcsm17092404pla.80.2022.06.09.12.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 12:20:05 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>,
        Peter Chen <peter.chen@kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v22 1/3] of/platform: Add stubs for of_platform_device_create/destroy()
Date:   Thu,  9 Jun 2022 12:19:58 -0700
Message-Id: <20220609121838.v22.1.I08fd2e1c775af04f663730e9fb4d00e6bbb38541@changeid>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220609192000.990763-1-mka@chromium.org>
References: <20220609192000.990763-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
2.36.1.476.g0c4daa206d-goog

