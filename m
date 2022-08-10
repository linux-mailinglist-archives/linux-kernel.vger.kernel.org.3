Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A0958EACB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 12:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiHJK5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 06:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiHJK5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 06:57:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86E756BB8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 03:57:24 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v131-20020a1cac89000000b003a4bb3f786bso827019wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 03:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=H+cCd/oCZzsaL3SLtp3P98P4HpXIWIWHyxYJ/oYAqVs=;
        b=yS2nQcxbDmZ0SCqPxlXpfAzI9ErOhoB8mg1eWnrLfZVuyA/SMjl8Sh/s+aQAGHFLbf
         R2nsO3wC6vxxzmPQvMVL3e4YRLeB3I2DpIl/CCH2T4bQBVjgUblaOHJEKfN1mpeaHuLD
         HboIIckFkxYwO27WOcu+iplJmWMMigiq+XaI0rSGSv6bwxLkuVdfpjnbIMFMJBGFvzUW
         VTFbg21Fm2TXp3NWqGfmBwAe+lTK6LrOybYbvsasJ24iccFl5lHgb3COzp5TM3rFNWZH
         FO9J9em88hwMyYPqjv/dtNd4P9/czpTtPQFGrbtFVfe4vgp4CvLT0firyENIX1E8GC+u
         cSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=H+cCd/oCZzsaL3SLtp3P98P4HpXIWIWHyxYJ/oYAqVs=;
        b=XMRpBZMspLGeJAa519/B8kfCYVc7iNGTeerCpJQr6cDiFqbZ8SohyjkmiZS7Zm067+
         +/diQxtMeemt04KPR0Da0lHxI1ezqezhVdjiJacZBLJ4iZFQLTMLHlHNofw8dzIp2qNI
         xoymC2/v0SSJHuyncl/2UycNAMXJyhiVxEWz2mwJwIHnCTIsn2LzO+EgdcSyoKeAW7kY
         4PkCHGVQ6Uxv52wQ5Y3M9PFdfzOWJrNJisKULnghlIN4Icunvf7WYsfOiy1WY7DynFRU
         4OQ1rM1XXk0+9jArBSuViGktwKJLVI+xoc9/JGnnmywRShECG91rpdaWTsZO431imvUT
         bezQ==
X-Gm-Message-State: ACgBeo1APHP8vQdSagyz7TnjHCTVjXRHzZNsPB7sh0KnE842g+mKIFhS
        /5SN2vTozOfD2QqB2nAxgUnJ1w==
X-Google-Smtp-Source: AA6agR5iDxXkIjNtDiCKXbPwQ347O0MKtbJwsYVMgkFBBJ1Tmq4An8mZy12GvIH7kZBLUvpHNI5hpw==
X-Received: by 2002:a05:600c:3b18:b0:3a5:2490:cb2d with SMTP id m24-20020a05600c3b1800b003a52490cb2dmr1998307wms.183.1660129043326;
        Wed, 10 Aug 2022 03:57:23 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b003a53731f273sm2101446wmb.31.2022.08.10.03.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 03:57:22 -0700 (PDT)
From:   abel.vesa@linaro.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 3/4] arm64: dts: qcom: sdm845: Add the RPMh stats node
Date:   Wed, 10 Aug 2022 13:57:17 +0300
Message-Id: <20220810105718.2137015-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220810105718.2137015-1-abel.vesa@linaro.org>
References: <20220810105718.2137015-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@linaro.org>

SDM845 is a special case compared to the other platforms that use RPMh
stats, since it only has 2 stats (aosd and cxsd), while the others have
a 3rd one (ddr).

So lets add the node but with a SDM845 dedicated compatible to make
the driver aware of the different stats config.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 5bea96a9ce06..5bcdc17f9d3e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4851,6 +4851,11 @@ ebi_cdev: ebi {
 			};
 		};
 
+		sram@c3f0000 {
+			compatible = "qcom,rpmh-stats-sdm845";
+			reg = <0 0x0c3f0000 0 0x400>;
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0 0x0c440000 0 0x1100>,
-- 
2.34.1

