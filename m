Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4834D39C7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbiCITQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237412AbiCITQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:16:24 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79D910F20A;
        Wed,  9 Mar 2022 11:15:24 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id p9so4556432wra.12;
        Wed, 09 Mar 2022 11:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JJE5QCHLqU96tMNAxHj8/NZAD9gp4mQlRTiwyoSvaQg=;
        b=Ylcrvms6wx7UcUhQ+Q6qYePvBt9ZKFU0zff0VCHjUgx9BikiWb+14fUoo7EBNVCWoh
         iqvvdroOwTLHl2a2adzBAnvCppxJViVlGk4GCP0R0MkBLt4hiCCnfEt35iV7oGbT/90y
         sYg4jie7Uj0ZUERl9RljPlJvCDsFEO6V9I5+2bHFUFgU7mo4jymZPJBtp/jJzLYfM0aT
         vrqCBw/+Gp8WwayHN7eWzDefdMtS5R1E2zSGrt3sNKrb6cItWTpO3z3krd92RTACfQsE
         fPsUY4lfGzN6mGNYGZ33L6z1BZBz6mJ1ZjSIpY6QUsguCWAfBSoMXUbx8eXZef6Qsp1y
         0zww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JJE5QCHLqU96tMNAxHj8/NZAD9gp4mQlRTiwyoSvaQg=;
        b=Pxro6OuzPwJmsDqBK9hky0KsH6ZUIfEnAr0eYqUzmqb5gXZUI7iwCk/qieki441MY6
         mRHFTVr0BTIuImoTGqeXjuKlG8w/LLr/7fEf5j0IzefVJG4QHjh4MAJD0GECeflrWrAB
         Jl9f4604HNFYMTsGZN4RSklFnaMXAYg6xVo8XsjvB6/DJupjYlMHsTNjkgwg58tC/BbQ
         5agxJa0HqIEMm55quBsuGKqCMKDmnBuqgU2k3JqhTY64VB1KS8wee89h7e5XYT22OSVT
         17KQCAA51lL+FtsF473Z10ztV5xM++erly/pwxGzPCgWttvu4DqlgF5DJ4aYsWXNpGsZ
         f8Ow==
X-Gm-Message-State: AOAM5334PNh7B0rYTvakCghnm0VZAq/keLG1//6a1SiTqfpZot4GziFE
        Vr1r/f4HVRko3/ax5yUnQUA=
X-Google-Smtp-Source: ABdhPJzFZCwv71cwlzesUU356ElelYbru0irDvuFTPjMFzqWJY2rIUXYKQUX4HXfvgrOPeBCnGa/3Q==
X-Received: by 2002:a5d:59a3:0:b0:1f5:1eee:fc90 with SMTP id p3-20020a5d59a3000000b001f51eeefc90mr825051wrr.625.1646853323293;
        Wed, 09 Mar 2022 11:15:23 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-79-47-249-147.retail.telecomitalia.it. [79.47.249.147])
        by smtp.googlemail.com with ESMTPSA id w6-20020a5d6806000000b002036515dda7sm2396699wru.33.2022.03.09.11.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:15:22 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v3 06/18] ARM: dts: qcom: enable usb phy by default for ipq8064
Date:   Wed,  9 Mar 2022 20:01:40 +0100
Message-Id: <20220309190152.7998-7-ansuelsmth@gmail.com>
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

Enable usb phy by default. When the usb phy were pushed, half of them
were flagged as disabled by mistake. Fix this to correctly init dwc3
node on any ipq8064 based SoC.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 9d658fcc1f12..e247bf51df01 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -1175,8 +1175,6 @@ hs_phy_0: phy@100f8800 {
 			clocks = <&gcc USB30_0_UTMI_CLK>;
 			clock-names = "ref";
 			#phy-cells = <0>;
-
-			status = "disabled";
 		};
 
 		ss_phy_0: phy@100f8830 {
@@ -1185,8 +1183,6 @@ ss_phy_0: phy@100f8830 {
 			clocks = <&gcc USB30_0_MASTER_CLK>;
 			clock-names = "ref";
 			#phy-cells = <0>;
-
-			status = "disabled";
 		};
 
 		usb3_0: usb3@100f8800 {
-- 
2.34.1

