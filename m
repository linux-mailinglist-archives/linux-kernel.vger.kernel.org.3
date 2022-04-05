Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A124F522F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849493AbiDFCie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443223AbiDEWUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 18:20:15 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40AD9D07E;
        Tue,  5 Apr 2022 14:08:07 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id j8so188061pll.11;
        Tue, 05 Apr 2022 14:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xQC5STMzw4TlY0FvT781KJXZa9jGBgzdgcysSv7pHIg=;
        b=hN5MBQWe16GY2+eRacLZyP2J2G0/eXm5i+hVYboOw4O/CEnwwh2Zrl0ANobFYmh9/A
         ylomaVTByFYvxkOwqktbrgMXfKNwYX9ClMbdnFJrv535F6dK24mR5xRaBv6cdIy+TKWh
         bsNgBOuGGBU71IKS+vKdWczk7a8eBukXDor7eFDBS0SfxicbTr7q0MeUZGKnCM5W5Rs2
         yR7lvR2F/+jFXYzMC7oOOLbCJFQ0cHXcLnUqC1guZ5YnEcYc+r8DzGAB4DN+Zs3Jhpfg
         E90b0QFByO64SiIBTAk4OFUpL3l048rh4MV7OYFt7M5BMKOGWVRPRR7DvntMynd52uoP
         Mjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQC5STMzw4TlY0FvT781KJXZa9jGBgzdgcysSv7pHIg=;
        b=xm8wzok6Q3eFh2l9pBP5PpU4Gxnf42ThhTTffRSgbbnPEhjNbqkO4LYLbrKS+nHodM
         CWgbVE2uwO43xP0ZSju+Ci4VNIaJ/UZMZNC1asWCP00DJY14fU10rBU9nnsumQVhfXn2
         OKJEIEv5SkTLBOp6NH/r5DfHlYBgr0XKrWs38gmu1WFD9w6piNbpTiOGViXqRX1oFv4B
         Z7FPItXjOKAZMg9NXZZTPKtTDnEPVAFawuVPe9ttW1BpbuN8DTyPnyS59FihVv6YPrLl
         qKjauZS7FF5MDzZdiriXYYLl71e+ruJggc7LF1dsgDKLsdM2ras8h8bugawnf8POuBEx
         kxtA==
X-Gm-Message-State: AOAM533oM9aWRjozIZZfT1slvX0pimGwWPRJfl34RK3cUOw4DVjgNuic
        OAiY66zpLsC1Xms53nPw+WU=
X-Google-Smtp-Source: ABdhPJy+2z/KOYY0vUQdalMA0BMC2rvgh2I4/uuGeF3/G929X6STDhElWLJEl6HJgPRI8UNAIdn10w==
X-Received: by 2002:a17:902:f0cb:b0:156:9c51:ca4 with SMTP id v11-20020a170902f0cb00b001569c510ca4mr5294481pla.93.1649192887386;
        Tue, 05 Apr 2022 14:08:07 -0700 (PDT)
Received: from jaschultz-Thelio-Major.corp.microsoft.com ([2001:4898:80e8:3:511c:41a7:57f7:f826])
        by smtp.gmail.com with ESMTPSA id k22-20020aa788d6000000b004faaf897064sm16240010pff.106.2022.04.05.14.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 14:08:06 -0700 (PDT)
From:   Jarrett Schultz <jaschultzms@gmail.com>
X-Google-Original-From: Jarrett Schultz <jaschultzMS@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: [PATCH v5 3/4] arm64: dts: qcom: sm8150: Add imem section
Date:   Tue,  5 Apr 2022 14:07:49 -0700
Message-Id: <20220405210750.619511-4-jaschultzMS@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220405210750.619511-1-jaschultzMS@gmail.com>
References: <20220405210750.619511-1-jaschultzMS@gmail.com>
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

From: Jarrett Schultz <jaschultz@microsoft.com>

Introduce the imem section in preparation for the surface xbl driver.

Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

---

Changes in v4:
 - N/A

---

Changes in v3:
 - N/A

---

Changes in v2:
 - Created to properly reference the xbl section inside of imem
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 81b4ff2cc4cd..bcfcb7306cdc 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1175,6 +1175,14 @@ gpi_dma1: dma-controller@a00000 {
 			status = "disabled";
 		};
 
+		imem: imem@146bf000 {
+			compatible = "simple-mfd";
+			reg = <0x0 0x146bf000 0x0 0x1000>;
+			ranges = <0x0 0x0 0x146bf000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		qupv3_id_1: geniqup@ac0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x00ac0000 0x0 0x6000>;
-- 
2.25.1

