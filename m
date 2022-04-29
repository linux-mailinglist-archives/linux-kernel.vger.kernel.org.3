Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558D6514EE1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378242AbiD2PRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378197AbiD2PQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:16:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927EAD4C6F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:13:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r13so16046930ejd.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XmWTkrnDHxaYal5xWnuaRpjNtd+tcEw5nlEomifzpik=;
        b=khBxDWEkVsHXzWgPYs09wFzc8pXVHFkcS41HCN8o3dBRgOhEVEKNfgK5fdZ1xWPI+2
         ddByw1yxZGydKmodYqsuBPeOLC8YMWXQ0GYlX6PAf3WI7WV+GzoeJ299Mm4a1k99492q
         lk86SdW4g5u2+iWE4JfCq+0EiBAf236rD4lQlkiBEJS2PB9ZwTv+KCtYGjccgCIpkQ6D
         BOxtuNU3L4akFeBWUyZgSXere5W0Q7sDdbFMuJxVjOZdKY0k22CMMGBD08C1/0TmYdnH
         MEiDFKEdmblynHciXNrMeVe+CeswpQCZtr4n8wMUnuB2z8pcTU1g7S+Xf7zTQTIXq1Pv
         Xn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XmWTkrnDHxaYal5xWnuaRpjNtd+tcEw5nlEomifzpik=;
        b=QH6ANZ80wzii0NgA0LVzIXKeoHDuDLoRWryv0bE9MlDEiFaUmc/WEwB7Pipt8oXid0
         yunSe1cbQQ6fTNEs59guhj+a+VNJvU79n1bC3Ih+nUBaMFQrys4iN1IIGoNciELDDKb6
         SGFss0W82PcNTztgy4O2HuZvRC13nxWIS8jclbC8aWbEoVSH4s2BemuEBPJMp90vcFNW
         c/O2ss4hJ3TOHQ6DZ1QdlQRlqOOmzODNXGxBQjd9P9WU6uFxCtcCqZ0I4Ms2sgQWR6F8
         vAZlexzZR67jUZ0uZfX/biPtpylx/SzUjgYc/bvamtvC3xMRbJhsWyxOeTubblIeuBNR
         FgDA==
X-Gm-Message-State: AOAM530DtUdWDUrA1FwEeoJUrRuuDjc3fjozieLRK6snA4SfpdjvD0e3
        ZKK0LvhaCc6i8Qr65OlRO7WpJA==
X-Google-Smtp-Source: ABdhPJy9vkqVUbS7PECM71ls7fqnFNs/IxepWSd6tyZvvnY6HB6uWH4BPw8mLsWC6SfHU7RQgbIstQ==
X-Received: by 2002:a17:906:1186:b0:6f3:e700:75be with SMTP id n6-20020a170906118600b006f3e70075bemr7037737eja.350.1651245202891;
        Fri, 29 Apr 2022 08:13:22 -0700 (PDT)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id zp15-20020a17090684ef00b006f3ef214e4esm712677ejb.180.2022.04.29.08.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 08:13:21 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, jonathan@marek.ca, tdas@codeaurora.org,
        anischal@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v1 8/9] arm64: dts: qcom: sm8350: Power up dispcc using MMCX regulator
Date:   Fri, 29 Apr 2022 17:12:46 +0200
Message-Id: <20220429151247.388837-8-robert.foss@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429151247.388837-1-robert.foss@linaro.org>
References: <20220429151247.388837-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulator controlling MMCX power domain to be used by display clock
controller on SM8350.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index c0137bdcf94b..c49735d1b458 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -278,6 +278,14 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x0>;
 	};
 
+	mmcx_reg: mmcx-reg {
+		compatible = "regulator-fixed-domain";
+		power-domains = <&rpmhpd SM8350_MMCX>;
+		required-opps = <&rpmhpd_opp_nom>;
+		regulator-name = "MMCX";
+		regulator-always-on;
+	};
+
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
-- 
2.32.0

