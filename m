Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEAF4BFB8E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbiBVPBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbiBVPAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:00:41 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D0A10E56A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:00:01 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0E55C402F6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645542000;
        bh=1gnJNDJDw/4tQtVmWxy7bj3CuaQdR4fw8lY4W6WZrSM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=gixVhZQMyF3xxFGNUO3zr1OdYaZvOBXJAareyCcxtXn3sOSC2RYXGT9911qrUySI/
         I8PI0UyWYU4hnWXEC/oumqfpK7MtTZ4MsfB4TRXGXHrWf3ZG86nFXZoVJgURsgfj+L
         mer7HKSB3wloGIgpwOiWlSpl9OcPKYFWVOXC4OYdNaxKnC59w7hi+7G+avLzCRTENT
         1eY+oSAKHSV/0+p6dLG9ih0TrJvhzTpIL1wiyBNqKZwKdjQxW8+qBHcxZviQZn//z4
         Zeni9p7j2AFIM2UjbTRU7B5ABOW9OboMpYWulgBkEBYzP0VG+1BTgAw5JhN6KecrVa
         zGgeGeBu0i97A==
Received: by mail-ej1-f69.google.com with SMTP id la22-20020a170907781600b006a7884de505so5887966ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:00:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1gnJNDJDw/4tQtVmWxy7bj3CuaQdR4fw8lY4W6WZrSM=;
        b=PzzrCkaCEn3at4UOyKS4fjXb5m2NtgKcZIYXlJcsAcCvmaGjW9CJpxUA5Ax2YJN92w
         zqHzo6fVhkl52WZnC3INnp42JHuARhwEKs1/CLVdc5C4BANPGXOZCQjrmnYfEXBMHw1c
         V0uM53jQcSNYpa2yJ/IWmiLWUz+mFryUIc087agmq9lPsXsbXW1n7uP8JV3gwr/xEg8X
         1FALWTb3M0NrH1muLIXyo4KYfVnSCBcqYx34vZsBa1dfc9f7M3+PPz0XMjbDnivENkws
         YlsjjkIE/tjg0tXQZ1zz4jnu9l/lmOifN/PagxpmxMo3vI9kC2zeNYhyXX2/A0MhK974
         k88w==
X-Gm-Message-State: AOAM530j3Bj0zleLst7UyM8jdl14RS6r2AHrs/QoV7fwlnFwuILcT/5a
        WiuUY+6K5A0ffrJUlY24hB5utEJUfum0g/CDH0mCOW+zEfo4k+PQomXD9ptyYcOZNlBk0Xpw8ER
        t6xNq6c32dfgRfOI2CjUcBVDF7HoNlgacw2ioU0xGPA==
X-Received: by 2002:a17:906:b155:b0:6c9:ea2d:3363 with SMTP id bt21-20020a170906b15500b006c9ea2d3363mr19204648ejb.729.1645541999444;
        Tue, 22 Feb 2022 06:59:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2oukZ+ozjlCm/noxM1LqqYguIfKnFdQpkzhzOSXTFSlmiKD/vXLNfpJoPvuzwYTi07oxrug==
X-Received: by 2002:a17:906:b155:b0:6c9:ea2d:3363 with SMTP id bt21-20020a170906b15500b006c9ea2d3363mr19204621ejb.729.1645541999288;
        Tue, 22 Feb 2022 06:59:59 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id m2sm2467960ejb.20.2022.02.22.06.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 06:59:58 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jan Kotas <jank@cadence.com>, Li Wei <liwei213@huawei.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 12/15] arm64: dts: qcom: use 'freq-table' in UFS node
Date:   Tue, 22 Feb 2022 15:58:51 +0100
Message-Id: <20220222145854.358646-13-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220222145854.358646-1-krzysztof.kozlowski@canonical.com>
References: <20220222145854.358646-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'freq-table-hz' property is deprecated by UFS bindings.
The uint32-array requires also element to be passed within one <> block.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi  | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index c85825ea1623..fad1bbfa1c0a 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1761,7 +1761,7 @@ ufshc: ufshc@624000 {
 				<&rpmcc RPM_SMD_LN_BB_CLK>,
 				<&gcc GCC_UFS_TX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_RX_SYMBOL_0_CLK>;
-			freq-table-hz =
+			freq-table =
 				<100000000 200000000>,
 				<0 0>,
 				<0 0>,
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 2fda21e810c9..87336c5866c0 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -990,7 +990,7 @@ ufshc: ufshc@1da4000 {
 				<&gcc GCC_UFS_TX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_RX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_RX_SYMBOL_1_CLK>;
-			freq-table-hz =
+			freq-table =
 				<50000000 200000000>,
 				<0 0>,
 				<0 0>,
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0d6286d27dd4..23caa29e7862 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2274,7 +2274,7 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
 				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
-			freq-table-hz =
+			freq-table =
 				<50000000 200000000>,
 				<0 0>,
 				<0 0>,
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index d15fee495238..db2ac197c630 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1782,7 +1782,7 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
 				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
-			freq-table-hz =
+			freq-table =
 				<37500000 300000000>,
 				<0 0>,
 				<0 0>,
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index fdaf303ba047..8c9e3c4ac5ac 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2133,7 +2133,7 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
-			freq-table-hz =
+			freq-table =
 				<37500000 300000000>,
 				<0 0>,
 				<0 0>,
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index d242bab69c2e..a26bd3f13d4a 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1935,7 +1935,7 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
-			freq-table-hz =
+			freq-table =
 				<75000000 300000000>,
 				<75000000 300000000>,
 				<0 0>,
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 934e29b9e153..edb904b58c0c 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1398,7 +1398,7 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
-			freq-table-hz =
+			freq-table =
 				<75000000 300000000>,
 				<0 0>,
 				<0 0>,
-- 
2.32.0

