Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA544BCA0C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 19:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242921AbiBSSnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 13:43:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242890AbiBSSm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:42:59 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7690C2716B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 10:42:40 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A5B444086E
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 18:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645296157;
        bh=eds4hwJvnu4NA5qKYzbOl5rJlIyGJooNPDbjWhSXxPA=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=fTjNbmylLjXP0VN1lczGMn7EWl0yR/zOu58pVD0L5rRcLgyeQEfIqto0WPKTuVfJM
         VtNm8KVCeF2Mwd85R4fpwmole6OYXnVdFEPBuxZwZ/EeN41e3IFnIHe7r+gxmpRxup
         TM/hUwupkBT48qzKxzfTVQ1JlyFB4Ybw4IeW6Jj5ebNCNfkHFS6/4MrYjwlTVi9VM/
         GAiv1lQkhs1PaskYjyBGV2rBSofAGT1TMoIbQGVs7FM5s9pRCINzUBnFoE/df1Pa+t
         V/77b0QegT6/g2JUONoomAQxMh3nHO4S4UmTgIsZIjMrWHokBngmDY5a3vDWldZ50l
         koZU5oMA3qe+Q==
Received: by mail-ed1-f72.google.com with SMTP id eq13-20020a056402298d00b00412cfa4bb0eso2771780edb.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 10:42:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eds4hwJvnu4NA5qKYzbOl5rJlIyGJooNPDbjWhSXxPA=;
        b=RejzfHu/Z60b1IoUehHiBi2RHgzx7JCm2XUcq9g66voR59zKPM4sBzlcPJQaXREmbF
         PltbBxgOEkOkDZBNTFcltunZfDpFsPbyZEjwocARWxIARpvwhrbwcUIvQ8gaXDuP6hCv
         qIY4YyczrhBoIEENZWBo1wvTtczDKAFPnXUUgeS+/BwJY0l0/Hp/jiU9jVajzuQ25+N/
         U/S3lMpb3eSu7NQ+nVYMYjLuO/TOx6C4hKxNWkccVX4Va6QgoT1kgK8F1tzec5gGyhOm
         2XYqO/Vg6zcu77VIHfz3NFFogIEZ4iS5CENDyaNp5ZIJVFynQiXc1eoTrTMITKF7ZJz2
         I+5w==
X-Gm-Message-State: AOAM531JukvVgICtSZ3ZEC41ckl0yGjs9pzNrdarymppuJvoy36kcatl
        R1dOhEeQdJdT/d3noMNFcx63BBLUB8yh9w+jpzKdJZjKsWzzWuRxWlvAeguVQiXeGvp6/aGBfCO
        IBKw0l6vrM8mMPyonRq96+EOcMsP32iQeF7XUf7o9FA==
X-Received: by 2002:a17:906:8557:b0:6cf:2730:b5cf with SMTP id h23-20020a170906855700b006cf2730b5cfmr10757178ejy.368.1645296156513;
        Sat, 19 Feb 2022 10:42:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyiBlObuIE4yboQDPgcUgD7fnjCG8ClJXJKKeDYvCOmZcNc7+X05uMuAKMAKm2NUzCGxOVM8g==
X-Received: by 2002:a17:906:8557:b0:6cf:2730:b5cf with SMTP id h23-20020a170906855700b006cf2730b5cfmr10757162ejy.368.1645296156345;
        Sat, 19 Feb 2022 10:42:36 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id j8sm6680745edw.40.2022.02.19.10.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 10:42:35 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Wei Xu <xuwei5@hisilicon.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jan Kotas <jank@cadence.com>, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [RFC PATCH 6/8] arm64: dts: exynos: use 'freq-table' in UFS node
Date:   Sat, 19 Feb 2022 19:42:22 +0100
Message-Id: <20220219184224.44339-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220219184224.44339-1-krzysztof.kozlowski@canonical.com>
References: <20220219184224.44339-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 arch/arm64/boot/dts/exynos/exynos7.dtsi      | 3 ++-
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index e38bb02a2152..beeca27a7415 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -656,7 +656,8 @@ ufs: ufs@15570000 {
 			clocks = <&clock_fsys1 ACLK_UFS20_LINK>,
 				<&clock_fsys1 SCLK_UFSUNIPRO20_USER>;
 			clock-names = "core_clk", "sclk_unipro_main";
-			freq-table-hz = <0 0>, <0 0>;
+			freq-table = <0 0
+				      0 0>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&ufs_rst_n &ufs_refclk_out>;
 			phys = <&ufs_phy>;
diff --git a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
index 807d500d6022..0d00543952c6 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
@@ -311,7 +311,8 @@ ufs_0: ufs0@17e00000 {
 			clocks = <&ufs_core_clock>,
 				<&ufs_core_clock>;
 			clock-names = "core_clk", "sclk_unipro_main";
-			freq-table-hz = <0 0>, <0 0>;
+			freq-table = <0 0
+				      0 0>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&ufs_rst_n &ufs_refclk_out>;
 			phys = <&ufs_0_phy>;
-- 
2.32.0

