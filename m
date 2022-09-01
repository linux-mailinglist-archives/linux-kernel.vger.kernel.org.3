Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B635A9041
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiIAH1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiIAH0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:26:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EAC24BC4;
        Thu,  1 Sep 2022 00:25:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v16so18371173wrm.8;
        Thu, 01 Sep 2022 00:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=JDrZS7nIxZE+ezQqB81Z1cPB0fQz6+CPtIEDV16ecMw=;
        b=dHIwZD32pIg5D+CUKK3U3imuivoxOxMDM6Mb+KpNlmDT4Q+JSMP/LNKSFeI24dfnsD
         dBq6ai8ZRck89HhE0oyrRtE7ytm8moFPYHHIXItBohVfldcQy3Bx4WWoRL3D3EB2VsTL
         6EpUcF7IKwRzV46nCjqodS7Q6+qA44/tBEfLWMqcA6j2xJk/Gzm/OSoaaIzhYCQOjwQ4
         afyPn51pnH0R9OqfDf/WNT4nkFaboFRDZr4EymEXe8yjLMTsmBD7Gn7GlK+kWeMeFYtt
         WuwuFFChOIqfPZqa6qmT+ozhhc3pixVzFKma1epmqYadDoe8tzT+l/8YeoUbVBuw6Q9n
         U00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JDrZS7nIxZE+ezQqB81Z1cPB0fQz6+CPtIEDV16ecMw=;
        b=2KE7EV1aSPY5x9zILCS5HUkZlfzOUoXqI/aKitmHZFTV16srY+HS5AsTP3kvyn5QEI
         IWgj+1w8/dtXU9i/Wv2O8LCfzcb2XCqQAyi2STd9/7InJCECQ7U/fE2DBWsl3ZEml/e3
         Hlg+vALcEUEIVdVX3bLgn7BwqaVeaAjYlVXhrGM6gtJQKdjtJIQK2EM482/+fUNxbdeP
         VJv7HaedI7IoT1UQ/5rQfeI/bYcy+cGcsmW4jSxfnzr7qeYtHaPKVwLyreS+XyknpO18
         rphsej0s0CE9+29IZQDvvQyIMzgw/AJYrbkKE+rJHsJXRvWnxffbDjq+CTMyHEG852vU
         8p9w==
X-Gm-Message-State: ACgBeo1SJubpAvFou+Pz8zbZHmfP0sEySgw8o0ZRLfp+jHimYqMbEH9i
        LMjmTwA4sdKtaKOYDBcLnBQ=
X-Google-Smtp-Source: AA6agR6vIT9+AX/UrAcVid9Ig2ak79xER/mRWsDktdeUD8IFxf/eCZZIlNk6vuzAmwCK3sCKPErFIg==
X-Received: by 2002:a5d:4443:0:b0:225:8759:c160 with SMTP id x3-20020a5d4443000000b002258759c160mr13631878wrr.199.1662017100735;
        Thu, 01 Sep 2022 00:25:00 -0700 (PDT)
Received: from localhost (87-126-55-15.ip.btc-net.bg. [87.126.55.15])
        by smtp.gmail.com with ESMTPSA id y2-20020a056000108200b002238ea5750csm16765351wrw.72.2022.09.01.00.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 00:25:00 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/14] arm64: dts: qcom: sm4250: Add soc dtsi
Date:   Thu,  1 Sep 2022 10:24:11 +0300
Message-Id: <20220901072414.1923075-13-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901072414.1923075-1-iskren.chernev@gmail.com>
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM4250 is a downclocked version of the SM6115.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm4250.dtsi | 38 ++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm4250.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sm4250.dtsi b/arch/arm64/boot/dts/qcom/sm4250.dtsi
new file mode 100644
index 000000000000..8cadf813e55b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm4250.dtsi
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, Iskren Chernev <iskren.chernev@gmail.com>
+ */
+
+#include "sm6115.dtsi"
+
+&CPU0 {
+	compatible = "qcom,kryo240";
+};
+
+&CPU1 {
+	compatible = "qcom,kryo240";
+};
+
+&CPU2 {
+	compatible = "qcom,kryo240";
+};
+
+&CPU3 {
+	compatible = "qcom,kryo240";
+};
+
+&CPU4 {
+	compatible = "qcom,kryo240";
+};
+
+&CPU5 {
+	compatible = "qcom,kryo240";
+};
+
+&CPU6 {
+	compatible = "qcom,kryo240";
+};
+
+&CPU7 {
+	compatible = "qcom,kryo240";
+};
-- 
2.37.2

