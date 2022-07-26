Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D77581607
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbiGZPGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbiGZPGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:06:36 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656172ED59
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:06:35 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w15so15045284lft.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wW0IWmjou8/dbPXah1VWrs6p56bqB8L10WNLYq+BYMk=;
        b=qDESDsM6z2YlfNP0cD/3mhpYSq6cXuUKLfMLKZlOs1dhfSy08VdRyP9Oa3+8S0T8jk
         sFLzCdTP2s0w7pmDZno4ng20azaKpFprHBPRvJFzcnqNaRnP9ZPKfZj+q/4hX+SvBCLZ
         xhNAVztqUV0uVMrHLbBmm1wpF6RfJA6BX7tCodepClHtZEDunf/XVuBpuLqPrYcQdu3N
         gm//dRwS5pDqFycDSoZ9t4N+LnJQN/kaJ9heqcSD4mSHMjA8Yn38UOEbQ0Rh9sU30ZSi
         eRX6NcXAu+zCQQV15zv0iR1PAFr26Qg7WK11v9c8UerSwxHq9wgFtg8lA4M4ZNDYBo2i
         NZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wW0IWmjou8/dbPXah1VWrs6p56bqB8L10WNLYq+BYMk=;
        b=4PYxusA/85F81N851QcueOlO5LpIiyBIPp6XtbH7Yq2luhqyCeSv5FdpvLtSpSQEnY
         eY0UFD+lVHkpMt4mjRtcbx4tDNE4m+OKUBudax94QADEas1ux/O1nGhMRGkTJbIZmbTJ
         UDwx0F/mbzPt3L33xbIeBlFKsbGxfOOZXaAct2+fFYYU6Ec1GSHITCuEcgm9URPx8aZ/
         PNnuq+LK7K7u9hC5yTmR39CeIuYZzF8Ey5/7BMRhPueml6Ew8v4o+JIHtX35bSZrzGF/
         1huhddadlah9zvpIdGt3VcIgTUB2B6falNFPJTGdoiwnk0+Ua2yn8ZXTwXRH3OJ4NTu2
         Vhdg==
X-Gm-Message-State: AJIora+teUecI54SJJVGmsYjuUueWSawmLYjwEXLhbq1Ns3keS2Nzcds
        G5DEfESOpPOT7zK5CRTjezeJ+Q==
X-Google-Smtp-Source: AGRyM1tAgch/au8T5kQ/rWdhreC8Ug/00Dbzb6RiGBVSBm1ncbmkjKs/jSdPrbnrQ3dFH4jzm0acQQ==
X-Received: by 2002:a05:6512:13a4:b0:479:3b9f:f13c with SMTP id p36-20020a05651213a400b004793b9ff13cmr6424614lfa.380.1658847992278;
        Tue, 26 Jul 2022 08:06:32 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id a26-20020a194f5a000000b0048a95c16849sm836620lfk.282.2022.07.26.08.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:06:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 4/5] ARM: qcom: include defconfig in MAINTAINERS
Date:   Tue, 26 Jul 2022 17:06:08 +0200
Message-Id: <20220726150609.140472-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220726150609.140472-1-krzysztof.kozlowski@linaro.org>
References: <20220726150609.140472-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM Qualcomm entry should cover also its defconfig.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ca4dfecc047..5623fc9667af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2582,6 +2582,7 @@ F:	Documentation/devicetree/bindings/*/qcom*
 F:	Documentation/devicetree/bindings/soc/qcom/
 F:	arch/arm/boot/dts/qcom-*.dts
 F:	arch/arm/boot/dts/qcom-*.dtsi
+F:	arch/arm/configs/qcom_defconfig
 F:	arch/arm/mach-qcom/
 F:	arch/arm64/boot/dts/qcom/
 F:	drivers/*/*/qcom*
-- 
2.34.1

