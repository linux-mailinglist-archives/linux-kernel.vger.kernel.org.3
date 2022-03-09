Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0469B4D39AC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbiCITQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237442AbiCITQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:16:27 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3E91107C7;
        Wed,  9 Mar 2022 11:15:27 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l10so1981625wmb.0;
        Wed, 09 Mar 2022 11:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UcuHyzhzP+5hjdfYei3RsVypThNPnUA0SB8MNR6XsKE=;
        b=e4sdgLDLdmEvY8wERiRJZydfE2M+FUi5X2dLkYr1ThNmeQx3Vbz61/wf+xEBXInuxw
         V1DBmuRgeEaZXw4P4FUTnNRESBxUzoXtWg22V6aW9qB93M0xv0AioPNfjlh1cmbl9oIT
         yR5sdM63eMGPhdCEpFNaKbJn0zczVHelyZgkhaI+CCgB8jYhoc9OUgieYL95DEHnmf9h
         MSdwVwIGxndPpHn81diBhT2+OYeWDftXysOm+SgT4q1hz+DM4/l0E3zE4QmUYJdFam1U
         Xe5D663GJNxz49fLQ6+iHlNDbvR566UbP3E/R/HS5FhH2VAh6eHiNPljAvJecayEnz1r
         N3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UcuHyzhzP+5hjdfYei3RsVypThNPnUA0SB8MNR6XsKE=;
        b=stCEtcmqQU6vTxsN712xEkTC7hOsYpkkbBmAsOL6r0ygCs90Tfc+A7OcjytfCwox0w
         R9h89YNRbdZ+rEUgsF/1CphH6d0+ylesZS1HgL8DzA7zrISxZsGvrIChxPLNmJMdmOaB
         wihHF7U+waCED279R6E/Y+EO6yWTbvtsEHgMC6KpOIUS0KoH70Xb4WALv2oaDMk00gPw
         4gtv/9SFjO96glNjsv1VUAg1EALCJzr5S8QHEeCCpSCtSJFhZRrJw/NlqAjigYd0xiVY
         OsSnsVksqFxhXL6OTD3rdlCjbRQJ0vJ63i7mDxaUloxZQQsOm3BHg+XNAM3ZYoxOg9lR
         NKSQ==
X-Gm-Message-State: AOAM533pcd5VsdtNGqGu+r/0dGTAahsqSIlMidichXgDVCpM3ICgsy+Z
        EVaqfAhvs8Sqb37cpYSLtHk=
X-Google-Smtp-Source: ABdhPJzEaSUFxljUe16ZnMooiH7xXlssMXfvEbHhs89wExTIR3YHt+STHesVAx97wG4ata5o80TlvA==
X-Received: by 2002:a1c:f018:0:b0:37b:c13c:3128 with SMTP id a24-20020a1cf018000000b0037bc13c3128mr8728223wmb.157.1646853326244;
        Wed, 09 Mar 2022 11:15:26 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-79-47-249-147.retail.telecomitalia.it. [79.47.249.147])
        by smtp.googlemail.com with ESMTPSA id w6-20020a5d6806000000b002036515dda7sm2396699wru.33.2022.03.09.11.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:15:25 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v3 08/18] ARM: dts: qcom: fix dtc warning for missing #address-cells for ipq8064
Date:   Wed,  9 Mar 2022 20:01:42 +0100
Message-Id: <20220309190152.7998-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309190152.7998-1-ansuelsmth@gmail.com>
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
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

Fix dtc warning for missing #address-cells for ipq8064.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 36bdfc8db3f0..6768f7ba0d04 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -352,6 +352,7 @@ qcom_pinmux: pinmux@800000 {
 			gpio-ranges = <&qcom_pinmux 0 0 69>;
 			#gpio-cells = <2>;
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 
@@ -473,6 +474,7 @@ mux {
 		intc: interrupt-controller@2000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <3>;
 			reg = <0x02000000 0x1000>,
 			      <0x02002000 0x1000>;
-- 
2.34.1

