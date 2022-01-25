Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6302849BEC6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiAYWos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbiAYWor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:44:47 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58706C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:44:47 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id d12-20020a17090a628c00b001b4f47e2f51so3075655pjj.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JeNHRfVJhJwg7c4aib6D7QwGiFz7LtBrAhsdC3k1Vao=;
        b=WXZHwtbBOzHwpYqp1KDddlJWPoC3eJajLidWMzC9FCf8C3IKmHVZUFNYzMBwbbgNPz
         TL23fihIz/RktI0Lz7XwCV+IFigj7cc+M6PqVuoiffsbuo+pBpYXwsVfDdeedgjoz18D
         iljTRpEFRX8KHA9oxICJvj3uUURX6JO7DeylM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JeNHRfVJhJwg7c4aib6D7QwGiFz7LtBrAhsdC3k1Vao=;
        b=6o255cWtXeIq3Xlpzj4XaX+2+j8tvb6GL071VPATn6D45+TaIvUUw3DPTXgi9VqnLn
         DRkASpTW7eHmcgrbjDwGnEH3+UF2GXt/9vOi1VoBZ20s9L6W09otpED82iKVSvZ9YClb
         nAx+R/sv44K0UprST5dFmcZhtnmwjcG2KvsGM3KoTGS+7zx9OBLsKi/uNAPNbJD5oBOu
         i0HtsBzp/0gMYMs9g3bww5myYkVD3X5ls1rBPuExu+cvPrRozJn5sS8iVDMnicFEMZmz
         392mUho+i+RivCUiw9QlxSSkHLHHdIk0p3H/WRRU14u13r5j3Ykymau4XAQyf5mIbIGp
         9tPg==
X-Gm-Message-State: AOAM533PxpRhETuasXMKvYBQE3oy7n8bkma4BxTdh+FjA7BdLMgGDGbR
        B4hqeh3yydHQdo9k6WxgoCHZ0A==
X-Google-Smtp-Source: ABdhPJy6ec4tjI1AWJjK5aTs6WwY/im+MX2OpcaSR6P1r8xYXhvw74RBZqCGjKUX5PC4QJ4L/N2AGg==
X-Received: by 2002:a17:902:da8a:b0:14b:370b:23fe with SMTP id j10-20020a170902da8a00b0014b370b23femr14704876plx.103.1643150686908;
        Tue, 25 Jan 2022 14:44:46 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f313:ff03:9fc5:6152])
        by smtp.gmail.com with ESMTPSA id p12sm1322335pjj.55.2022.01.25.14.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 14:44:46 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     konrad.dybcio@somainline.org, swboyd@chromium.org,
        kgodara@codeaurora.org, mka@chromium.org, sibis@codeaurora.org,
        pmaliset@codeaurora.org, quic_rjendra@quicinc.com,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] arm64: dts: qcom: sc7280: Move herobrine-r0 to its own dts
Date:   Tue, 25 Jan 2022 14:44:19 -0800
Message-Id: <20220125144316.v2.2.Id9716db8c133bcb14c9413144048f8d00ae2674f@changeid>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220125224422.544381-1-dianders@chromium.org>
References: <20220125224422.544381-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upcoming herobrine-r1 board is really not very similar to
herobrine-r0. Let's get rid of the "herobrine.dtsi" file and stick all
the content in the -r0 dts file directly. We'll also rename the dts so
it's obvious that it's just for -r0.

While renaming, let's actually name the file so it's obvious that
"herobrine" is both the name of the board and the name of the
"baseboard". In other words "herobrine" is an actual board but also
often used as the name of a whole class of similar boards that forked
from a design. While "herobrine-herobrine" is a bit of mouthful it
makes it more obvious which things are part of an actual board rather
than the baseboard.

NOTE: herobrine-rev0's days are likely doomed and this device tree is
likely to be deleted in the future.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/Makefile                  |  2 +-
 ...rine.dtsi => sc7280-herobrine-herobrine-r0.dts} |  6 ++++++
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dts      | 14 --------------
 3 files changed, 7 insertions(+), 15 deletions(-)
 rename arch/arm64/boot/dts/qcom/{sc7280-herobrine.dtsi => sc7280-herobrine-herobrine-r0.dts} (99%)
 delete mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index f7232052d286..9db743826391 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -82,7 +82,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r3-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r0.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
similarity index 99%
rename from arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
rename to arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
index 4619fa9fcacd..8676c93590b5 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
@@ -22,6 +22,12 @@
 #include "pm8350c.dtsi"
 #include "pmk8350.dtsi"
 
+/ {
+	model = "Google Herobrine (rev0)";
+	compatible = "google,herobrine",
+		     "qcom,sc7280";
+};
+
 /*
  * Reserved memory changes
  *
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dts
deleted file mode 100644
index 7a92679a688b..000000000000
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dts
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Google Herobrine board device tree source
- *
- * Copyright 2021 Google LLC.
- */
-
-#include "sc7280-herobrine.dtsi"
-
-/ {
-	model = "Google Herobrine";
-	compatible = "google,herobrine",
-		     "qcom,sc7280";
-};
-- 
2.35.0.rc0.227.g00780c9af4-goog

