Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D8C4CEABF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 12:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiCFLMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 06:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbiCFLMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 06:12:48 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C1D606EE
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 03:11:56 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5FBF63F618
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 11:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646565111;
        bh=vMFnkOH1WJAajK2DqdRDAa0cLEGNFmbkS8Gtp9GKvtI=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=WiBbxPhTZcukfSK2kIrCzy4EgQ6Xmrqg4kZ1DP+O9ZyP+L5tmzRvcbW0DQJOxJduJ
         CE3+4Kq08ySBGyK0feYbvATUXy2SF8gy19halz3cynV77vwz1EiIqb5eRGfvGPnhjR
         COF6fWAtZWgvikG6cCvI2mRQ4aHQoLEUUMiEXDZuV6AoQkNdLdO91mGc7qL2M9IR7c
         9x3/9dehC0CaXjSZYRzHUOjS+GGFLjhOuPseDHcOx3IiHglX18Cnc6Ta9DTFx+bFn4
         HoSQSXmir4WKnRIP//Mj5IbZ/jUVdtPBQ4Xcj8W3eWW9JkZ6c721sqSAfbC4bkbvzD
         VNkx20E7MT3Gg==
Received: by mail-ed1-f72.google.com with SMTP id y26-20020a50ce1a000000b00415e9b35c81so4493662edi.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 03:11:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vMFnkOH1WJAajK2DqdRDAa0cLEGNFmbkS8Gtp9GKvtI=;
        b=x3/NXG7OdMYtC3tjyFSkNpor2wlOSvp9Yx6QrJHF7JjC/IdiJ6d0k2qVgFVJ21Auqd
         rS4ZECPyPL//E+wcLYmFn++jzEMsjVV/GCvHGV77AH58WX2rIY0hEWA118LEUpCVxwp1
         XtGM9TrxaLTGFQtJepj+Sf8VMv2mLhIUjR8UMTkVvMgjy187yjU20LzePCc1789yYDra
         ehC3jWp3Czvksm7ChseNMvPDMPAqQfFtdXRH3QFEYwoPHMqCjXgmsraF3VquteAwCwhS
         p3D1XkomJKwA3OxLGoBfbt5bVAkoNe3jah9uWDO7/LmLkpKTU5sn3P4DkI6GbEkNnBtW
         /PSQ==
X-Gm-Message-State: AOAM533E/++qV5MDKRGp0ylJyD440JJr/zzJOl2IYV4rxqX+X9flDiR5
        TOmKM9MoFfkYJ/Q6sz0mC9GzWj7POR+nEBNs55B4UV5yQbyCkMU32x4HOPlk6zigBUd/P3RAxNm
        hRcJtMrOnjM0Cnf7beMR3sSgEPvKknpu5YkQH4DDxVw==
X-Received: by 2002:a05:6402:2d8:b0:416:34b0:5d5c with SMTP id b24-20020a05640202d800b0041634b05d5cmr2294049edx.6.1646565107741;
        Sun, 06 Mar 2022 03:11:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTQ1jrVfZZl3Nu0dKHXWLrV//RroIxSgPbz2wvMOZz/2cmoQu/ylE+3YUml5SvnaWO1iXePw==
X-Received: by 2002:a05:6402:2d8:b0:416:34b0:5d5c with SMTP id b24-20020a05640202d800b0041634b05d5cmr2294031edx.6.1646565107595;
        Sun, 06 Mar 2022 03:11:47 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709066d4900b006da888c3ef0sm3720444ejt.108.2022.03.06.03.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 03:11:47 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jan Kotas <jank@cadence.com>, Li Wei <liwei213@huawei.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 11/12] arm64: dts: qcom: msm8996: correct UFS compatible
Date:   Sun,  6 Mar 2022 12:11:24 +0100
Message-Id: <20220306111125.116455-12-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220306111125.116455-1-krzysztof.kozlowski@canonical.com>
References: <20220306111125.116455-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm UFS bindings require to use specific (qcom,msm8996-ufshc)
and generic (jedec,ufs-2.0) compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index f0f81c23c16f..fa491f2271ff 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1730,7 +1730,8 @@ pcie2: pcie@610000 {
 		};
 
 		ufshc: ufshc@624000 {
-			compatible = "qcom,ufshc";
+			compatible = "qcom,msm8996-ufshc", "qcom,ufshc",
+				     "jedec,ufs-2.0";
 			reg = <0x00624000 0x2500>;
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
 
-- 
2.32.0

