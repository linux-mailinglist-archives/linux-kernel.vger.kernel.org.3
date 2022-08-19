Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83788599752
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347354AbiHSIc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347580AbiHSIck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:32:40 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F2FE992E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:26 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d23so865185lfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8kKp2gVxl2IVtU6eBY60iDxS0j0PaTIOrvwgxTS4yV4=;
        b=WjZtC4ADWuqaywxx98ACB+Zd6WWZIbxhCkhYbD1R5SPGwubtGl7crrwW3VZqDwKv4l
         qspJRZMkY0RPZOfvEg4miGXS1EnV0EkmjbsZdadw21AGgYjsSNnuixwYOhsc44mOYf6S
         CfemEizejIsVbK8aGAZZC9W1rh1CD82bRS3TFq1brO2zjwlnEeBUUSXYCM+LvBSlaFrl
         3UsGCFXtuETx2OBDAc0NNfoLmxSWMGSZnSTGuobKg6H4u++ch1RrQlYpf+dk+n7rCevt
         L9C1rEjdG/YlOMcAbfujTDbTPyOu1Kiz2NKMoUgD00SNZNS7927Yk0kOw4c89LUiA7iy
         OT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8kKp2gVxl2IVtU6eBY60iDxS0j0PaTIOrvwgxTS4yV4=;
        b=Tnif1ctnYrG4BcRy6gO0JjdsvXyNI/bGJPX3kzbOfQ7I/Tu9xycZqbKwk7pCNf8HBp
         U699WLePlT3nWSu7itbLgbWhOVWVi5lKGym0513Owu50+neFwc0ZtxM3fVJ+sZDcq/rF
         QHA7pIhcQUxgC08OT13K2voKxSegBwKd+qzmwjKm6ZktJicF/Y7uI7F6kfot6Sxq2zqq
         OKZ6Ojuh/6Obr6jSHzZSUDKkCx8vOUxcPEETuyyMIV1yKab0EfVPS222pY/dZNOkoThD
         sOEbxPtjuI7rHDLXctTc0PzoF3GtqiUeGCKT/K2Wppv5uvkl1t+gI3rfeNJTMmczIs1H
         5Z7Q==
X-Gm-Message-State: ACgBeo1Me3LyctvMMHP8W/4GTUHiNG6CgCtfWtEEPobDUlRDd5Skb7On
        PY0dlkYYYkjRT7b0fI/ehSNm1g==
X-Google-Smtp-Source: AA6agR5isHHMh5jJA4xgLZE7AfZda2RabaQQ8z+Srqh3cVKl26ot3hQsxzAxApePeqsJZhIoaQLobQ==
X-Received: by 2002:a05:6512:3d08:b0:48b:123e:fcf3 with SMTP id d8-20020a0565123d0800b0048b123efcf3mr2080662lfv.418.1660897944944;
        Fri, 19 Aug 2022 01:32:24 -0700 (PDT)
Received: from krzk-bin.. (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id j8-20020a19f508000000b00492a54f0be1sm545355lfb.284.2022.08.19.01.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:32:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v3 08/16] arm64: dts: qcom: sc7180: switch TCSR mutex to MMIO
Date:   Fri, 19 Aug 2022 11:32:01 +0300
Message-Id: <20220819083209.50844-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819083209.50844-1-krzysztof.kozlowski@linaro.org>
References: <20220819083209.50844-1-krzysztof.kozlowski@linaro.org>
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

The TCSR mutex bindings allow device to be described only with address
space (so it uses MMIO, not syscon regmap).  This seems reasonable as
TCSR mutex is actually a dedicated IO address space and it also fixes DT
schema checks:

  qcom/sc7180-trogdor-wormdingler-rev1-inx.dtb: hwlock: 'reg' is a required property
  qcom/sc7180-trogdor-wormdingler-rev1-inx.dtb: hwlock: 'syscon' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 5d2dd21da79c..e8debb0da411 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -555,12 +555,6 @@ scm {
 		};
 	};
 
-	tcsr_mutex: hwlock {
-		compatible = "qcom,tcsr-mutex";
-		syscon = <&tcsr_mutex_regs 0 0x1000>;
-		#hwlock-cells = <1>;
-	};
-
 	smem {
 		compatible = "qcom,smem";
 		memory-region = <&smem_mem>;
@@ -1462,9 +1456,10 @@ ipa: ipa@1e40000 {
 			status = "disabled";
 		};
 
-		tcsr_mutex_regs: syscon@1f40000 {
-			compatible = "syscon";
+		tcsr_mutex: hwlock@1f40000 {
+			compatible = "qcom,tcsr-mutex";
 			reg = <0 0x01f40000 0 0x20000>;
+			#hwlock-cells = <1>;
 		};
 
 		tcsr_regs_1: sycon@1f60000 {
-- 
2.34.1

