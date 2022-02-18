Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530194BAE6F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiBRAaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:30:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiBRAa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:30:26 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CD75FF23;
        Thu, 17 Feb 2022 16:30:04 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id o24so11773709wro.3;
        Thu, 17 Feb 2022 16:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E4soHMSATnNXl5TODVc2MH8fE4HFAE18vCS3jN0AyCU=;
        b=eTt+PB3ZXWEDlQ98HexFmltN5qSpGv9AHykfbj2LCIiz9okn86PyW/bYrj4Wb0GKBm
         rJZ6kOUtkHDHyaM98dC16RwD8ZKSVUbt5SuaGs9NpXnVUcSgMJwgmf4LO2qk+eowMmZS
         6hIk1THOFd2KlbTnBPKoHZsJ3chiDcKVIRCJBpVoNqohC8EMV2zdzwmpZd31waP+i266
         pMXkVf+45yZbnLBM/+4pFybbTUXnpqoqt2Ez6Tv0BRl5oWqCJhRJNYtkuk2twgRQI/8u
         Ik3dwHkPrxg4aY8uu+pT8T9dy56lv66NsLZwH57lXkROK1jxZnCHfjbHzRDu6kn1PHMQ
         yw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E4soHMSATnNXl5TODVc2MH8fE4HFAE18vCS3jN0AyCU=;
        b=gh8pfc51VVVK5+2xmXk55YOFk1D1LHxicgmrZ2oHVNUMO3ZHWiE+hXOlyW4b4fEElb
         nLw39KG6moKY4K/jH8jc3BIADElSyaHCCuFgVRwO8+4aMsbtzurXLXDO5Fh2FoZeGE1v
         vssqWocwEuEXLXhsdOnjAMSfkKJGdCTQmgbOSyD57/Oh8t8M0L4x3pPCABxgV3l80Nja
         mxPLQ75IPGPdkZ9uiFC4BS9Dv55xxG4Q/XdtSY8W+/XFnnSLJ2WRcVR+tpxGQEFwU8Pa
         KTnozfqPTtqW2jdjSLMMfZoE97uXP1IUsmjdnoXF7Kayfe+uwVKCzNtiwY0ukwxf6qUF
         DbLA==
X-Gm-Message-State: AOAM533hcCwOWgsx7YDfbgzlQJDXMRlVIRzHjEAoAQ5JXxJgS0mm3SGm
        NGFf8D2SwtnpE2fN6Wt31cE=
X-Google-Smtp-Source: ABdhPJxtrSYvDBVuWr0TKfvdX56ZBXqXbv3sIzVqEjkRlEDZtqcPZoS+/Z1ClDldA8i9Y55B2t0vyQ==
X-Received: by 2002:adf:face:0:b0:1e3:260c:f824 with SMTP id a14-20020adfface000000b001e3260cf824mr4057543wrs.181.1645144201541;
        Thu, 17 Feb 2022 16:30:01 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id d29sm3640406wra.63.2022.02.17.16.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:30:01 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 06/18] ARM: dts: qcom: enable usb phy by default for ipq8064
Date:   Fri, 18 Feb 2022 01:29:44 +0100
Message-Id: <20220218002956.6590-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218002956.6590-1-ansuelsmth@gmail.com>
References: <20220218002956.6590-1-ansuelsmth@gmail.com>
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

Enable usb phy by default. When the usb phy were pushed, half of them
were flagged as disabled by mistake. Fix this to correctly init dwc3
node on any ipq8064 based SoC.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 9d658fcc1f12..e247bf51df01 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -1175,8 +1175,6 @@ hs_phy_0: phy@100f8800 {
 			clocks = <&gcc USB30_0_UTMI_CLK>;
 			clock-names = "ref";
 			#phy-cells = <0>;
-
-			status = "disabled";
 		};
 
 		ss_phy_0: phy@100f8830 {
@@ -1185,8 +1183,6 @@ ss_phy_0: phy@100f8830 {
 			clocks = <&gcc USB30_0_MASTER_CLK>;
 			clock-names = "ref";
 			#phy-cells = <0>;
-
-			status = "disabled";
 		};
 
 		usb3_0: usb3@100f8800 {
-- 
2.34.1

