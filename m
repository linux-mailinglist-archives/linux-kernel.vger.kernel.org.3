Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B069569F8C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbiGGKVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbiGGKVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:21:04 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B42812766;
        Thu,  7 Jul 2022 03:21:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id e15so1593641edj.2;
        Thu, 07 Jul 2022 03:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9poEAF6D1LGffPpxZSKhQyYw8/o6eStscZWlsJlZK0E=;
        b=NYGJuSP8FWyLhZwYpVHjrJ684G/tZCmN90tKaMFJG3JLOZ7fzkzZqzcpB37WejQ72o
         9sfLKzDwAxF+6P3/Ise248CxCVGzLHlvCrUdS6ZrWjXzAu+7JbiHp2F8jDii8vgO9ROO
         xQxrvCqiFCXKtHMbEFlSucKoviwscZeJHZyRhz+OzZ3F+kQ0VH7Y+a0Rm9Fhhk3CaIT+
         0PcjTXkabhCRGLFRs/dXvQoRJxtqF3dR/KlMLMUoeO5jZA9/W6FUARm/0MzwtJgQZoqN
         KKumMUNQF2ohnfLzCIvia0uu4zouQOI1WJGgFI5SqMb/VvpEagjpyR2dOHHReWIjTmdy
         RBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9poEAF6D1LGffPpxZSKhQyYw8/o6eStscZWlsJlZK0E=;
        b=hluT01ryPf0pDEmXqC/Ns008+4sNDKeX3R/k1K5w0Nc0Gyahed6jh27nhSaUs/Md6m
         O21QG7pNaEYAISnCknA1ESqouQgUBTitAojW0xRhuuGAdaTMXDSdMoMjPDkcpwrdyl3x
         2u6V17gxSGwr9F9ouUFq1oTpRmF5AXH2jRlr2IiamYV0cUHmSvDyGGC/UZBFCumVuhvg
         sWqkDSF2QxDFNOXa6Zo7yJksuUJwJ0UlCLQebBLIbej0F4WZnocPKxP0mqjXiC+l8lo8
         qFKSpddW3CoSUz5vF2rGU6PYYHqazzXFB6e+qiJNYvGjTF4IKFIhPdV3/mcbYR97xKL+
         yKGg==
X-Gm-Message-State: AJIora8rpTiM8XeBWPXSrGpsDhDhmr2SR4JMesepO4W9o3QVxrQ/SrMo
        XINdcHIJpq54luYbGURB1OU=
X-Google-Smtp-Source: AGRyM1tn0JgtItLwZ29WPGJsMx5g0B6EpmxvunPQ9iQCNgL6/yZ6ZJzgN8edTvwo3QELADXGq3iZrw==
X-Received: by 2002:aa7:cd86:0:b0:43a:26e3:d333 with SMTP id x6-20020aa7cd86000000b0043a26e3d333mr32597845edv.178.1657189261582;
        Thu, 07 Jul 2022 03:21:01 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id s22-20020a170906a19600b0071cef8bafc3sm18701117ejy.1.2022.07.07.03.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 03:21:01 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/3] ARM: dts: qcom: add missing hwlock for ipq8064 dtsi
Date:   Thu,  7 Jul 2022 12:20:39 +0200
Message-Id: <20220707102040.1859-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707102040.1859-1-ansuelsmth@gmail.com>
References: <20220707102040.1859-1-ansuelsmth@gmail.com>
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

Add missing hwlock for ipq8064 dtsi provided by qcom,sfpb-mutex.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 4b475d98343c..cd1b43e2cab4 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -1224,4 +1224,11 @@ sdcc3: mmc@12180000 {
 			};
 		};
 	};
+
+	sfpb_mutex: hwlock@1200600 {
+		compatible = "qcom,sfpb-mutex";
+		reg = <0x01200600 0x100>;
+
+		#hwlock-cells = <1>;
+	};
 };
-- 
2.36.1

