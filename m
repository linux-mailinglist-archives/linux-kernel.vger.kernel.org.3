Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A615670B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiGEOOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbiGEOM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:12:58 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74752642;
        Tue,  5 Jul 2022 07:07:32 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id k30so7306263edk.8;
        Tue, 05 Jul 2022 07:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0YFb5A6KdjvJhiop1gIwQqe0ydIC7Ymlf3Zqrt9/HXA=;
        b=SU+LiU3NRZL+0sL2EGyf10/HJgsg5tvOe6O6SDA8Xo1ffDE8wBYTQAINXTnFNB0pYc
         h/kUsE2obU4zwwQEv5H65vyvaGqxvGFkU5UGhqWPFTlbWC37/f6uXOHLq/rYDXHT3Pmi
         f/bbJJNEiihVgi6NwvTe/BCfU9d1PFtpe701QZcnSBN84B0dfzdJGLnHuQjcFuQ1NXm6
         EiVSqPkXvkdGjxyi6DSsQCmFcXyMla38+u/Xh2ku5+sxZBZ+bekgvnF10ar5zZjjFGRR
         dPXdgWaa/ca4SxrB4ovBI0jQjla1CiA3w3Uby5X+K3GQlKN+EMWu0dlfMmxKMgMedsut
         ey2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0YFb5A6KdjvJhiop1gIwQqe0ydIC7Ymlf3Zqrt9/HXA=;
        b=ZVhYtX7UFUJw7PRfOL6P47LRmSbt+Ib2JndO9d++c2Pb+rx28dfl+WjEngkFnWuUim
         8mOJRvyJ6MzAaLT4PX8C8l7+oXK0aT6VGQmVffJ7qNfzk8/P6Gt/s6Cj8yZjbGKFSWj5
         jabuoQmhSTr32BRHBx/nDF8JNRoYeYGM9N8hlI00R5P0j7F8Jk+9YcOHQgkKDDXG6nVB
         HhepK/c7EKG+taLhAUXepso40bfCUHp2iGqmBDxfjr+MOIGZ6tb3aEUJD4EqoUzdF4KO
         o543tW+tri77fTbZVa1wU/Kxem0CJkgWOfH3qIMTR0rilu+ueVUpGBjvF7Oh3EzqQHOh
         GRQQ==
X-Gm-Message-State: AJIora/yxgbMjKaZ4Oub1C+fRUcAck3c5bwN0JdNjn5UIEMYEwMIhX7L
        lcdSk0Qj0DnRK1snhs8Azmk=
X-Google-Smtp-Source: AGRyM1tKmoWAWYt2kVH86I6/AKkp2X5hLoH+8fnhNUHsZ//MS7/G80GvkrJ1cxs2LmL1xDwu9fA7+A==
X-Received: by 2002:a05:6402:2708:b0:435:da6f:3272 with SMTP id y8-20020a056402270800b00435da6f3272mr45458429edd.160.1657030003230;
        Tue, 05 Jul 2022 07:06:43 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id ku5-20020a170907788500b0072aee605e0esm399709ejc.60.2022.07.05.07.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:06:42 -0700 (PDT)
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
Subject: [PATCH 13/13] ARM: dts: qcom: remove redundant binding from ipq8064 rb3011 dts
Date:   Tue,  5 Jul 2022 15:39:17 +0200
Message-Id: <20220705133917.8405-14-ansuelsmth@gmail.com>
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

Mdio0_pins are now declared in ipq8064 dtsi. Usb phy are enabled by
default.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064-rb3011.dts | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
index f651e813d75a..58893cd2bb5d 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
+++ b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
@@ -261,10 +261,6 @@ &gsbi7_serial {
 	status = "okay";
 };
 
-&hs_phy_1 {
-	status = "okay";
-};
-
 &nand {
 	status = "okay";
 
@@ -311,15 +307,6 @@ mux {
 		};
 	};
 
-	mdio0_pins: mdio0_pins {
-		mux {
-			pins = "gpio0", "gpio1";
-			function = "gpio";
-			drive-strength = <8>;
-			bias-disable;
-		};
-	};
-
 	mdio1_pins: mdio1_pins {
 		mux {
 			pins = "gpio10", "gpio11";
@@ -360,10 +347,6 @@ mux {
 	};
 };
 
-&ss_phy_1 {
-	status = "okay";
-};
-
 &usb3_1 {
 	pinctrl-0 = <&usb1_pwr_en_pins>;
 	pinctrl-names = "default";
-- 
2.36.1

