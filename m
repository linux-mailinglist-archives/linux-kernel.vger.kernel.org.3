Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1665B5354FE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349089AbiEZUqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349159AbiEZUqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:46:23 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494E1B1DA
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:46:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id n22so214062eda.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KQPHjD3c8QXyN7jVG+t3oRTkD3S6BZATZ+byBZXQpIc=;
        b=ykyjo9fiDDRysWdg8Ubk1v8ubnriDbcCKYYaZ5teRE5SYlk0m0juZYfS8CoVEYoeeA
         Lmq7nhoN0LkR5OynCoiMDl2rI+cT4+/YqDcZp9mfTQjOrulbGjBRN2xerJRBBe+b2qvP
         EfvVdivEheVDOZrLOYU+ImL9bRDXzAGblk7t/74uBd5RGYJ3IbpDZf3tE9x77kN5lsyN
         Qey8HqivbUNv6M60jnT24rSojwxzzSXhSzJGKn5EV8ZTha1jQjlx+N1/mmwvelss3dXw
         U+ajeDUvh5+LTiEUPI7ggPdNQUOnaDTKGKynVL92JpOT4+U9e4yxYjllUrOHdwZZbmCj
         T3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KQPHjD3c8QXyN7jVG+t3oRTkD3S6BZATZ+byBZXQpIc=;
        b=VYck8kXrPb/QbEWbs4oRwyx1hoK/szc38Xt19UAkpX543Hqma8LobwJEJ3aSv9ufLH
         9C1Lk4fqVeaSBeJL7dPsiCU5VPaTMEIagbHOQ/je862fTpurhw1T/8RdBtiJsL+hpU2w
         1I+uVbVgJraPzcCc8sG06R+elNIbaKgV9NB+hfi0xXHv3r1bMVXs5YUEPmjBYVWtUgB6
         N9Qdsy/DoquDF4OnHzBxJYZsfyp/DUmVxd7PTb7ZxCzopjhxkPWYJg9VUyccYK+7ZFKZ
         dR+0HrMH6bT65uDNyWbfl9/9hwlt6tz1f3pFV26Mc5LRHYFHkJ1XVciLDVcUj05hBqu+
         CNDA==
X-Gm-Message-State: AOAM530Xj8W6PjUbAYgP2DEQZxH6bbC+K3QL0dL4YHYgKvDoNoeMA9kb
        tjHeFj2kIVCukaKoU9cmvP5p6g==
X-Google-Smtp-Source: ABdhPJxnobfUufGwlnrmVi/R9ZAFVVpvRRBrBrdDup3R2hU57m9At3PhU7hsw2wv0Qjs3Ee8TFbnvA==
X-Received: by 2002:a05:6402:1610:b0:42c:6bf6:3d4b with SMTP id f16-20020a056402161000b0042c6bf63d4bmr60230edv.54.1653597973326;
        Thu, 26 May 2022 13:46:13 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gc21-20020a1709072b1500b006ff16f48e2asm813254ejc.76.2022.05.26.13.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:46:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/5] arm64: dts: apm: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:46:04 +0200
Message-Id: <20220526204606.833054-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526204606.833054-1-krzysztof.kozlowski@linaro.org>
References: <20220526204606.833054-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 2 +-
 arch/arm64/boot/dts/apm/apm-storm.dtsi     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
index a83c82c50e29..251f2ca0a649 100644
--- a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
@@ -601,7 +601,7 @@ serial0: serial@10600000 {
 		usb0: dwusb@19000000 {
 			status = "disabled";
 			compatible = "snps,dwc3";
-			reg =  <0x0 0x19000000 0x0 0x100000>;
+			reg = <0x0 0x19000000 0x0 0x100000>;
 			interrupts = <0x0 0x5d 0x4>;
 			dma-coherent;
 			dr_mode = "host";
diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index 0f37e77f5459..d49ea382154d 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -927,7 +927,7 @@ sata3: sata@1a800000 {
 		usb0: dwusb@19000000 {
 			status = "disabled";
 			compatible = "snps,dwc3";
-			reg =  <0x0 0x19000000 0x0 0x100000>;
+			reg = <0x0 0x19000000 0x0 0x100000>;
 			interrupts = <0x0 0x89 0x4>;
 			dma-coherent;
 			dr_mode = "host";
@@ -936,7 +936,7 @@ usb0: dwusb@19000000 {
 		usb1: dwusb@19800000 {
 			status = "disabled";
 			compatible = "snps,dwc3";
-			reg =  <0x0 0x19800000 0x0 0x100000>;
+			reg = <0x0 0x19800000 0x0 0x100000>;
 			interrupts = <0x0 0x8a 0x4>;
 			dma-coherent;
 			dr_mode = "host";
-- 
2.34.1

