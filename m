Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3A65670B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiGEOOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiGEOM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:12:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA5DE48;
        Tue,  5 Jul 2022 07:07:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lg18so2043138ejb.0;
        Tue, 05 Jul 2022 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z2qvagdvkgzEk1isMwjSllduix1zdSWNV4qccAdh7FU=;
        b=MHB5VmF3QPSByPVfjCgSZc56+o8mUHXfTuCp7kQtL/iPdihjtOvFZiYyQSIQ81RyZC
         FDiRmcaK6lUTZkEJvSVDyi0P0BXWRwBy4DLpMNUVakM8J4vvqC9Y58lu/6yTXZYXJlGl
         WxwMQTXcbgC8rztR8/4KRJn66HFBUu81BAnw9PZT1/O4yjQolLOF3fPM2vbvXAq7qxqi
         XGuIyFvKP92I5AE4zzq+Sn2CZ4FKgYlc1XhyVo1WBhpZGB2sWHCoaCj/mzHFphwj+mSA
         WtMTfzwMCuG3xh7wyZqj3GT+75gIrUXwMHQ4lBNAzeMQeH11fCueDQOny8IS5hDdVa1P
         X7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z2qvagdvkgzEk1isMwjSllduix1zdSWNV4qccAdh7FU=;
        b=ss+6ZW0jdnQ6Hfs27kcPWr22xJBH2Baqc8lWvi1YxfT6x1NP+otdOVTLLwIeAz/6RK
         NLY1PBepgvsVhjU3rDfdksCB14TVejRkoCWXob4L4SIDQWzEBwECRf2MfCqW0mK8azaE
         DsSw1xyQeX8MmWwUSAZVMjzCCO2q2LrpCNSSMTK6r3C5NIMP/g7F5wX4eQkdjSbWqf92
         AACxv4a1dB+FaIUPI8+vB1/qA7/qyOBLmhghpBQxefH1hKhY+4WV+xYlC1IkYwuyaEp4
         Qu+v39HlYwiec2BXTUvLm3BYqPWWti02eRXSpHsWwBoOR4klj4q62GTLYsauyfLhi5pm
         3mEA==
X-Gm-Message-State: AJIora8Kh+/dngi23OqG/BaaVB1tI/jwSFKb6or/q1eySgQKqeVfP2sT
        4uaQ7oBus5YUlakVtIoSDqA=
X-Google-Smtp-Source: AGRyM1uVnZt77Nz5XJHxfF/ncLPsn3z75y9uk+m/MH3SSnPAYLwmUFcI4OfzGa1ar5cQfNwXZohRGw==
X-Received: by 2002:a17:906:6545:b0:722:7c99:1ad7 with SMTP id u5-20020a170906654500b007227c991ad7mr33843952ejn.325.1657030001845;
        Tue, 05 Jul 2022 07:06:41 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id ku5-20020a170907788500b0072aee605e0esm399709ejc.60.2022.07.05.07.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:06:41 -0700 (PDT)
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
Subject: [PATCH 12/13] ARM: dts: qcom: add speedbin efuse nvmem binding
Date:   Tue,  5 Jul 2022 15:39:16 +0200
Message-Id: <20220705133917.8405-13-ansuelsmth@gmail.com>
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

Add speedbin efuse nvmem binding needed for the opp table for the CPU
freqs.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 777851bed95a..45e713387deb 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -862,6 +862,9 @@ tsens_calib: calib@400 {
 			tsens_calib_backup: calib_backup@410 {
 				reg = <0x410 0xb>;
 			};
+			speedbin_efuse: speedbin@c0 {
+				reg = <0xc0 0x4>;
+			};
 		};
 
 		gcc: clock-controller@900000 {
-- 
2.36.1

