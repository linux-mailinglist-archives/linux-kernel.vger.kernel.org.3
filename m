Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E13458E867
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiHJIFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiHJIFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:05:25 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7102C2228B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:05:22 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id o2so12841497lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=dwg6yv71NfB5knx8pj12cTQqtHRrsNvcyNO++oQeMQA=;
        b=FMNSBXCSpo4ArITqBSQAN1d8gM+7xmtOI+8DrB0WnI8PAeHdkhICrAoJWNu2dHGuR/
         H5CNqruS5J0MNMXf8VZyyL+XDY1fEtVJ5u2e6oY0MXACTInHRMahYPCgeZQqJfKFjl70
         E1GBCRKDZyj+DVUksuf+9nGIq3xLxYdMjPLq3C7nfz7AqHLCsk0fRvq4LNEYwZ254waj
         if3206/LlbgMjty5Jfoo/mJ0Assx/E9psijN0hPaJQ+MQYsOHS6PTXb3X2N6SZyJx5LW
         fU+InTPHHsPGNXX4wgI56vuC53p/8vsP8ByDvQMLJWl09DMLnf+uMk5CHsx/Z4QS7THd
         OBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=dwg6yv71NfB5knx8pj12cTQqtHRrsNvcyNO++oQeMQA=;
        b=a39rTgIfKrhG81K2nGZAMDVz2zDIh/kVCDTYQz2P4VqJfNOB4xYqqEIhAgO38XH2f6
         mCAKaM5pH6k5W4pgXDqcMKs54xyYOJ8EdAwNQA4OY4e7DZ/37KnODstzeoHPzQyYZKiU
         6P5pcg6GohjvpjtMfjIh9NBmZ1HzA6osmrzi7lExbR7BZd/6R/TGDOmGqtiR5zVt4z9U
         T4FF/GYlKGGJDkaD8vQSWKLhPPEinO7A7UFtxTX2WMg9xOHJVLdJuNDexSU7bAhKxL3r
         TYC82z321WdB56yNAu97DTcsCnguH5PYPBRRzu8N+Ry1Y/swEEz8S/HEIDJdAAAYlln4
         h+Bg==
X-Gm-Message-State: ACgBeo1uNC5QhD1NR3Xa8fkUoXwVkZHIjnfyYyUkq46RApm9XMLou331
        AyGlphoZRB1hUIb2kH2Cn5oF2N7hE2MwxoWX
X-Google-Smtp-Source: AA6agR5dKLBqtcVBYIHtAAnB7lVoZAYXipJKiodI92zWu+Uo21MR5j32O9atljdkQ/ByXQPhGXe6ZQ==
X-Received: by 2002:a05:6512:3d0e:b0:48b:3976:b319 with SMTP id d14-20020a0565123d0e00b0048b3976b319mr8415597lfv.362.1660118720844;
        Wed, 10 Aug 2022 01:05:20 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id h12-20020a2ea48c000000b0025e040510e7sm309571lji.74.2022.08.10.01.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 01:05:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] ARM: dts: qcom: msm8226: override nodes by label
Date:   Wed, 10 Aug 2022 11:05:14 +0300
Message-Id: <20220810080516.166866-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220810080516.166866-1-krzysztof.kozlowski@linaro.org>
References: <20220810080516.166866-1-krzysztof.kozlowski@linaro.org>
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

Using node paths to extend or override a device tree node is error
prone.  If there was a typo error, a new node will be created instead of
extending the existing node.  This will lead to run-time errors that
could be hard to detect.

A mistyped label on the other hand, will cause a dtc compile error
(during build time).  This also reduces the indentation making the code
easier to read.

The pre/post DTBS are the same.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dts | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dts b/arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dts
index d159188c8b95..290e1df631f0 100644
--- a/arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dts
+++ b/arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dts
@@ -18,8 +18,6 @@ chosen {
 	};
 };
 
-&soc {
-	serial@f991f000 {
-		status = "ok";
-	};
+&blsp1_uart3 {
+	status = "ok";
 };
-- 
2.34.1

