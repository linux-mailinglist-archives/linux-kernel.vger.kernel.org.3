Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713B85670AD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiGEONn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbiGEOMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:12:54 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658F262D4;
        Tue,  5 Jul 2022 07:07:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id fi2so21822083ejb.9;
        Tue, 05 Jul 2022 07:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5pW+LGdGa+yB3l9T441GO4AwfhNQkGODHFHNmvhWdCw=;
        b=GUD5kprOgvBu+70ifTcthe9/sGCv1EyOjHGHaJoOyLB92Jmu3d5Plf9g1tvDxBUoB4
         UfU1wqe8idKTEpEMExXnq1KavRSD6UJG+0SmFgPhbzh3p7jduUSZDxgPtKKbWNV8EXd6
         PxzrdldpNmMsaThH17YCFWyGjDc7n3n9IYHGGyAYGERL7gflZc5Qt1u7QXYXvSLI+8Hn
         0h8eUko3xR0qaUR5H7D+2F6ulTL80/XKrzQZha3oskIdfdaWxq6/r5DX115MQjnOIu+T
         xzxAij57+8zj554oSxqtVOztH3OjpDK/xUztXgZaGaRxJZkslhRDt5Kow5+T0i/SZyFw
         w7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5pW+LGdGa+yB3l9T441GO4AwfhNQkGODHFHNmvhWdCw=;
        b=fynSVSymRSqbabPCnleQ+WWm2Sum8nut6SVXlynVPSVJxoK4OzLGBJ/w37/9YUqH+O
         Xkr0IqW5h/m/AB6qI2lP6GP8/gqumFW2elcrWLcqofWTDAhT6+LeMN1ZxT9oclWdNB5x
         JOXTaYdZfWvVkZXo6rxPqk+4O8suiJIZzHLBOwxLwMgahgeOLG3IHC/5NltQbccB7pT0
         3rzRhRv6xS93mgE+ylKasUzTFvGTWph6Gwpn0hFzIa781avXzyS0RNVPo6U6bdA0QzaE
         tSvHy0alyZljoWhnlhAwYkpoXaZWcNUjoBBzRzfY6HySoOFqcdWLRC51P7ZbWX1gz9DB
         YvlA==
X-Gm-Message-State: AJIora9eTshpzDEEz01LGdzWdytnB0kT6n1UK0GK3zLx/rGgeEvBdHYl
        k8n61j8MW4WvJbY1Zw+GSJxCFHTuKBw=
X-Google-Smtp-Source: AGRyM1vqq2PL3EbJksOAZryk7Y0FMKL7AXkrFYo9BXh/a1QCqer1yjviwO824JWR2rtbwkgh0Zx+cg==
X-Received: by 2002:a17:906:3f02:b0:718:bdf7:790d with SMTP id c2-20020a1709063f0200b00718bdf7790dmr35335560ejj.479.1657029995894;
        Tue, 05 Jul 2022 07:06:35 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id ku5-20020a170907788500b0072aee605e0esm399709ejc.60.2022.07.05.07.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:06:35 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH 07/13] ARM: dts: qcom: reduce pci IO size to 64K for ipq8064
Date:   Tue,  5 Jul 2022 15:39:11 +0200
Message-Id: <20220705133917.8405-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705133917.8405-1-ansuelsmth@gmail.com>
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
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

The current value for pci IO is problematic for ath10k wifi card
commonly connected to ipq8064 SoC.
The current value is probably a typo and is actually uncommon to find
1MB IO space even on a x86 arch. Also with recent changes to the pci
driver, pci1 and pci2 now fails to function as any connected device
fails any reg read/write. Reduce this to 64K as it should be more than
enough and 3 * 64K of total IO space doesn't exceed the IO_SPACE_LIMIT
hardcoded for the ARM arch.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 9c32c637ea46..e13f6ae92e05 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -920,7 +920,7 @@ pcie0: pci@1b500000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 0x00100000   /* downstream I/O */
+			ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 0x00010000   /* downstream I/O */
 				  0x82000000 0 0x08000000 0x08000000 0 0x07e00000>; /* non-prefetchable memory */
 
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
@@ -971,7 +971,7 @@ pcie1: pci@1b700000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x31e00000 0x31e00000 0 0x00100000   /* downstream I/O */
+			ranges = <0x81000000 0 0x31e00000 0x31e00000 0 0x00010000   /* downstream I/O */
 				  0x82000000 0 0x2e000000 0x2e000000 0 0x03e00000>; /* non-prefetchable memory */
 
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
@@ -1022,7 +1022,7 @@ pcie2: pci@1b900000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x35e00000 0x35e00000 0 0x00100000   /* downstream I/O */
+			ranges = <0x81000000 0 0x35e00000 0x35e00000 0 0x00010000   /* downstream I/O */
 				  0x82000000 0 0x32000000 0x32000000 0 0x03e00000>; /* non-prefetchable memory */
 
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.36.1

