Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB49A4BFBB3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiBVPCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiBVPBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:01:17 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633D610E044
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:00:15 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 39F4E3FCA0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645542014;
        bh=YBEC74wb9GPpBj/B6mQOA+S5GClKlTxflH8/ImjOGfA=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=eu9OdbGwK/yj8IZU3LIG0KLQm/aFyrzjbIVAzrce6DAsV97pOn+lHMQvGPHXuGDFm
         BJTMtnm5jCq24DkEGBEo9yU5FwMhpZkIGNq8dILMzq6RqVd45/E8KIlPaSIeISvS/q
         2uHpI+28W4cJ0tKCqR9NedQwhNbWfjEaaSsVPN2I0YZrkaop8sIDDdxcoPyWUMwx6x
         Q6oFjCmJrw13zOu2ufVWwPM30xhySmhPivFWSZZVSVcsdGX0pxO0KOQEHcGYQiJKFm
         jddjB0I1bIRDsZpSpLSWecnAtiZRCy1mfR9FT15II4FSC2RyARl5BJbpmEzn22Cp20
         3c4hxzjOeZ0rg==
Received: by mail-wm1-f70.google.com with SMTP id i20-20020a05600c051400b00380d5eb51a7so661940wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:00:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YBEC74wb9GPpBj/B6mQOA+S5GClKlTxflH8/ImjOGfA=;
        b=RmqFUv4psQXbGfxELwPq1sO+O5E7t15hCOdhDFmeDFsZPApK6mhR/IGfn5pbRGEc3x
         HMSlBcQeyDhQCyu6CS7fzmRcOOuJZJwLJ5e2pHLXqWw8OiDfx6GU/qxrHeotX4hwM0OB
         gC+742mgp1eAM9trPFrMEtda+2VO+3snjxHd/2GnhYQz9r321LK4axljdc32OTWci/MT
         6vpe4oWzVVaASOz+9iyjlzwqDaSeumE0WolMgSfZTO2BxrGBr37HVcCSyvFVwxB+5fHg
         eweY6CJhrPNRVfDmiUh3+52+GpQxowvqMyQ4HOeagHp6ch5w5cNDqAWNxjgWLauekTLE
         Hssg==
X-Gm-Message-State: AOAM533dcIOSHsfJrOzEoKlRmUo1SvaCr0hklLwanUCh95zQrK7fy6ZY
        ew7Cmod8j9JOAO2lPTP3oMrmH3vDpC1G/cOU7W61glTu5gZCdbn+TGaev+yWtAq0Uv6nOylQqCI
        DqU9anwRL3WLbp11JFLj3rzxOeuKqhoqtuxlGGdEV0A==
X-Received: by 2002:a17:906:7746:b0:6ce:a12e:489f with SMTP id o6-20020a170906774600b006cea12e489fmr18914904ejn.551.1645542003130;
        Tue, 22 Feb 2022 07:00:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLi2RkpjMH1XnBpd7ijPxBtJkEM6ya606jWmcrmuPZusdxAuidRgjMaupSJDwmi2J8JqbfkQ==
X-Received: by 2002:a17:906:7746:b0:6ce:a12e:489f with SMTP id o6-20020a170906774600b006cea12e489fmr18914869ejn.551.1645542002826;
        Tue, 22 Feb 2022 07:00:02 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id m2sm2467960ejb.20.2022.02.22.07.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 07:00:02 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jan Kotas <jank@cadence.com>, Li Wei <liwei213@huawei.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 14/15] arm64: dts: qcom: msm8996: correct UFS compatible
Date:   Tue, 22 Feb 2022 15:58:53 +0100
Message-Id: <20220222145854.358646-15-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220222145854.358646-1-krzysztof.kozlowski@canonical.com>
References: <20220222145854.358646-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index fad1bbfa1c0a..f25c68511b64 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1728,7 +1728,8 @@ pcie2: pcie@610000 {
 		};
 
 		ufshc: ufshc@624000 {
-			compatible = "qcom,ufshc";
+			compatible = "qcom,msm8996-ufshc", "qcom,ufshc",
+				     "jedec,ufs-2.0";
 			reg = <0x00624000 0x2500>;
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
 
-- 
2.32.0

