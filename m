Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E39505F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 22:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347905AbiDRU61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 16:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347853AbiDRU6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 16:58:18 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED211AD94
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 13:55:38 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s137so21015585pgs.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 13:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X5lGqMUBSdh+IsaWIFm9V2j3b3mWZ6jlDPDrC88fnn8=;
        b=hiE5I/10WBJRaFjNB6D/rRDZwXT/xuzJ2mj/Av1hWwh/BVRDmp1J0lAnKOcKKQPx9w
         UTmzlIqdsx1fJILGPHYKP0DquFNZbHnpRp/YbBhsAE0yJEK4vpsvzPyO7V8yil8s7pNU
         TYMDFqWOE05ZLRriNXZJ2jZB3O/5poojPUspgV8VYgWVlExnPm0VQ3F4YoimVaGlYn7l
         rJseCXn2+iETxSxUVtsx+nlGqHn1TNOzitqBya4KU1V3DklWGBaLEUnCNjbt8zwVB1tP
         qth61vRmVDVBPf4XjSG26Qt393j5w3aMQfTAvEQaDlpGH0GBRAEyCDYg4uLbEGh34Lde
         yLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X5lGqMUBSdh+IsaWIFm9V2j3b3mWZ6jlDPDrC88fnn8=;
        b=yO1bykF2xKo+7hntkC35PLQrxTykmXUeJcqbsZw3IOtayC0inWm3D2s4hqij5HphUW
         Q/GYcEHP+kFcctbAB4svxBF9w2Hn95twSjwHuDOmTnDLVcr4qd/D5HJSX7L8BZFL0ZR8
         7lE9np6YePsKqHBe6NxnsMeTgnax1YLQcheQUDSW5N6OveX2Nv2k/oNXD3xiDnYQF4sf
         wEuaVdhiaI+2U9hxTVIXLoP5rBDCTeuKEEz+8ehBhipGygBPLGBdo0bv/lvY2087eewG
         ENQNG+7Zgcxs32tUtSsqEXnPzePZoKDxlgUABA2aSSIlGW4TpV37WEmeo3R/c/F/ZSMV
         /SxA==
X-Gm-Message-State: AOAM5308mh4DpT8vetszs1cni+lHAHuIIplGXXCJgvooMymcKHMfeOYM
        rl4ZPTJQdNtKJs1EYB71cFV3Nw==
X-Google-Smtp-Source: ABdhPJz0GZ8rmXR8DQp/WwKaRGivzMhug8KVXDar9yqo3iYmc/+XHEC2EuSLHiOZul7woMMVqAgFIQ==
X-Received: by 2002:aa7:8049:0:b0:4fd:bfde:45eb with SMTP id y9-20020aa78049000000b004fdbfde45ebmr14262857pfm.76.1650315337740;
        Mon, 18 Apr 2022 13:55:37 -0700 (PDT)
Received: from localhost.localdomain ([223.233.64.97])
        by smtp.gmail.com with ESMTPSA id q60-20020a17090a17c200b001cd567fecaesm13498859pja.26.2022.04.18.13.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 13:55:37 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, vkoul@kernel.org,
        bjorn.andersson@linaro.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 4/4] arm64: dts: qcom: sm8450: Fix qmp phy node (use phy@ instead of lanes@)
Date:   Tue, 19 Apr 2022 02:25:09 +0530
Message-Id: <20220418205509.1102109-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418205509.1102109-1-bhupesh.sharma@linaro.org>
References: <20220418205509.1102109-1-bhupesh.sharma@linaro.org>
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

Fix the following 'make dtbs_check' warning(s) by
using phy@ instead of lanes@:
arch/arm64/boot/dts/qcom/sm8450-hdk.dtb: phy@1c0f000: 'lanes@1c0e000'
  does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 2cfc67b75259..721bd9495eb6 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -851,7 +851,7 @@ pcie0_phy: phy@1c06000 {
 
 			status = "disabled";
 
-			pcie0_lane: lanes@1c06200 {
+			pcie0_lane: phy@1c06200 {
 				reg = <0 0x1c06e00 0 0x200>, /* tx */
 				      <0 0x1c07000 0 0x200>, /* rx */
 				      <0 0x1c06200 0 0x200>, /* pcs */
@@ -958,7 +958,7 @@ pcie1_phy: phy@1c0f000 {
 
 			status = "disabled";
 
-			pcie1_lane: lanes@1c0e000 {
+			pcie1_lane: phy@1c0e000 {
 				reg = <0 0x1c0e000 0 0x200>, /* tx */
 				      <0 0x1c0e200 0 0x300>, /* rx */
 				      <0 0x1c0f200 0 0x200>, /* pcs */
-- 
2.35.1

