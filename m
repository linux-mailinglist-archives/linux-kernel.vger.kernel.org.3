Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027FF4BCAEF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 22:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243301AbiBSV4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 16:56:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243221AbiBSV4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 16:56:14 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B86A54690
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 13:55:52 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id l8so9892435pls.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 13:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OQDRi6ED3yUR5t/CfNm3XcVMLYaE2vx+NvYgZhn41jM=;
        b=6GHSa5GF8BjEaY7vMtmInKxOt8TmNQ1d0610AcajUoKsN4RkwwGGvXzpTXU+LlFdTf
         xvzpqg2g6Cwcsj81sxu/k3JXw9k4tLb7CjnQY+ugOdUniG1g6cHXCOkRzbBIHxuJS+VG
         aZSjxlhb52B5hQJBE0qy9W0tEO9+qg6Zx/jSgP5UafDVAZpQL03Uo3aZWHy73i37mDfc
         Ahq8VTCdE6ansytJJY97wCGy1MD8Zq3xZUJ2EhXAqk1QMBrDHaMLQrTnCNamc9j1J1wo
         VfsjsWpsUE3MbTgya/9DLmrY7FkksAM8otYWCck9N/R6tBazGrqTef1YWyAqT74E82qL
         OuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OQDRi6ED3yUR5t/CfNm3XcVMLYaE2vx+NvYgZhn41jM=;
        b=zEhSpDHId03KKt8DY523OfFWqMO6HxXvvpBedpqOrAeadWlnG9z7RWAV0DGRJymIQI
         VutRges9ENH4hGYQcmtbpl2kawDIqUOAggV/Hyn2cUS6zEwbghlyMdNPjJckzyxXTho3
         iz+8EvTqDgAyEPhtgE3tIi5/NGg3dQaF4tifWzxyJKthEzzYuHAY9+fdgorapLl58hOy
         56ZDuV02mkTvAEcl++zmdfQiHx63CLtnrjMPM76p/TwZ7wG3ecjCkHW+lacVnGVXL0oy
         bVxnABCMEcYJXR2Zi94Y5ZhqTbQCWqp+HuwsfwWFOSg4ubElUZteYGJleQLzfxPT6v+w
         7IGQ==
X-Gm-Message-State: AOAM531K8VK0+rgmCVlWOby+qerjPlik9akbyk3IQyY85c7Mjvgls+bC
        XLcrJZmBrXOFDExK1i374ZEvGQ==
X-Google-Smtp-Source: ABdhPJw0tEzcnvcnUL9jKO7VcMyldkWgIl50hqtyptCPIDfgsNjwWfxsyHfUYSMRG9qVpiLLUmxLoQ==
X-Received: by 2002:a17:90b:2516:b0:1bb:f8e6:f568 with SMTP id ns22-20020a17090b251600b001bbf8e6f568mr4198555pjb.118.1645307751504;
        Sat, 19 Feb 2022 13:55:51 -0800 (PST)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:31ab:1e81:9550:f30a])
        by smtp.gmail.com with ESMTPSA id i17sm13447337pgn.82.2022.02.19.13.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 13:55:50 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>, devicetree@vger.kernel.org,
        Drew Fustini <dfustini@baylibre.com>,
        Keerthy <j-keerthy@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>, s-anna@ti.com,
        khilman@baylibre.com
Subject: [PATCH 09/11] ARM: dts: am33xx: Add scale data fw to wkup_m3_ipc node
Date:   Sat, 19 Feb 2022 13:53:26 -0800
Message-Id: <20220219215328.485660-10-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220219215328.485660-1-dfustini@baylibre.com>
References: <20220219215328.485660-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

Add appropriate scale-data-fw names for all am33xx platforms.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
[dfustini: modified line numbers to resolve conflict]
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 4 ++++
 arch/arm/boot/dts/am335x-evm.dts          | 4 ++++
 arch/arm/boot/dts/am335x-evmsk.dts        | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 56ae5095a5b8..31b051651e4f 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -405,3 +405,7 @@ &rtc {
 &pruss_tm {
 	status = "okay";
 };
+
+&wkup_m3_ipc {
+	ti,scale-data-fw = "am335x-bone-scale-data.bin";
+};
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 659e99eabe66..92941a3b1add 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -782,3 +782,7 @@ &rtc {
 &pruss_tm {
 	status = "okay";
 };
+
+&wkup_m3_ipc {
+	ti,scale-data-fw = "am335x-evm-scale-data.bin";
+};
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index a2db65538e51..3986ed2a12d5 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -719,3 +719,7 @@ &rtc {
 &pruss_tm {
 	status = "okay";
 };
+
+&wkup_m3_ipc {
+	ti,scale-data-fw = "am335x-evm-scale-data.bin";
+};
-- 
2.32.0

