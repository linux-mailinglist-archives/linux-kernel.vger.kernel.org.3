Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA88515D28
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 14:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380521AbiD3NDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379403AbiD3NDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:03:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62B474DDC;
        Sat, 30 Apr 2022 05:59:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z19so11858649edx.9;
        Sat, 30 Apr 2022 05:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xms5zfJXU21gn+xhCN9GQNWCbbshl8bU7hgfQRBr4Es=;
        b=KpY7oN8xp9U1nZKemOVcHmQaIp6qiHJBCXboc8JAqGFoj/aTcBgo35ILbEae75vtls
         4FRoMKhvsQhkF10wi5U8ftQhdozY0Q36tUbwdqPk2EKOSA/1zn70yCFFvn0HPR6sTnst
         wauoayG6rJ61Q9xT/r5cmN5sT1ubrDf6SuTNFTVXGWVpCqEoIUTqQRwX5I5nyAPgdGmc
         TIH8Pre0aUlNe5DvqYZMHtho6tC/Mp2SoB/EiKWA6d5YMhBmEaVI6cwgE66s7PJmM/NZ
         VWxqonxJSwkJkfB9iJc5WBoqQXyzPMO7usGDhQhaYv/OJlSmM25pORrKNSIwfmeoqfYX
         OCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xms5zfJXU21gn+xhCN9GQNWCbbshl8bU7hgfQRBr4Es=;
        b=E9NKdpuCPTW3Grg4JnseQuENvhwXFRgkcK6zDrkBj8jjE1h8+RnAHe9wBGNT+iq7JU
         SdRTMhxOof+rqWpTYrfQCeuSVqrJioYh8569Ty6vDSP9p+69c2PKJYcQ0FH4uLicaw3H
         wzK7CwkMoNQSY7kAz2CApvJvlHmj/FqlRzxR4gFisqv4KjdyT5ksRpkQ7JdKgaV06ByO
         gBflbnPpW5zS9wkHtJvXCM+o3BulSEa+Dj7njlllWeuTTeYdRc8VgyIotULAyic/2bfD
         ybcczobipxnTJ361HXKpOf3QNu1/oGXtlN/1OS0vovJZ9YoH4jovbyEFNeoWv8yMQ7yf
         wVdg==
X-Gm-Message-State: AOAM531Uz4Bmp7hr3PHcsP3e9w44FCQq3C2mGZwvIiWqNBHt6jtko58t
        ITKUziwUJiVEUlqRyyR+yQNJUSofFOg=
X-Google-Smtp-Source: ABdhPJx2RM498J744bx4vjzGZmJZYTeBt6E5wh1lOL6Fxtj+KpwRFQeS/ym9IiPq+keAFoYaArtPlg==
X-Received: by 2002:a05:6402:11cd:b0:425:ee49:58cb with SMTP id j13-20020a05640211cd00b00425ee4958cbmr4372158edw.157.1651323580259;
        Sat, 30 Apr 2022 05:59:40 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id a25-20020a056402169900b0042617ba63c8sm4125077edv.82.2022.04.30.05.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 05:59:39 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 1/2] ARM: dts: qcom: replace gcc PXO with pxo_board fixed clock
Date:   Sat, 30 Apr 2022 07:51:17 +0200
Message-Id: <20220430055118.1947-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220430055118.1947-1-ansuelsmth@gmail.com>
References: <20220430055118.1947-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace gcc PXO phandle to pxo_board fixed clock declared in the dts.
gcc driver doesn't provide PXO_SRC as it's a fixed-clock. This cause a
kernel panic if any driver actually try to use it.

Fixes: 40cf5c884a96 ("ARM: dts: qcom: add L2CC and RPM for IPQ8064")
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 996f4458d9fc..e6ca8d1d1c5f 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -304,7 +304,7 @@ cxo_board {
 			clock-frequency = <25000000>;
 		};
 
-		pxo_board {
+		pxo_board: pxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <25000000>;
@@ -782,7 +782,7 @@ tcsr: syscon@1a400000 {
 		l2cc: clock-controller@2011000 {
 			compatible = "qcom,kpss-gcc", "syscon";
 			reg = <0x2011000 0x1000>;
-			clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
+			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
 			clock-names = "pll8_vote", "pxo";
 			clock-output-names = "acpu_l2_aux";
 		};
-- 
2.34.1

