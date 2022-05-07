Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F021251EA25
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 22:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447043AbiEGUkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 16:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447023AbiEGUkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 16:40:23 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DA61A83A;
        Sat,  7 May 2022 13:36:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id i19so20127514eja.11;
        Sat, 07 May 2022 13:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7DWoX9+H0DxYYZrmDNlSMsfSAn3l95094c1JRWnLT7M=;
        b=AenD+lrs+dbZfipB99nC/SkuwXSY9y7aLz1aNvVX3KuhfTydePoQhobTR1YZmakS9J
         fpUAKi8zgzpbhvXz89r7lEPz6/rHq6UK1bImTesNXqo0kGD52tC5u0aMhanaHeOZjtPo
         ijVhcRHHIgAU96ruRwJn+XS5dhgcMAIFatvWUB1hTLmZXHOFu7jkjaESle7EposTvUxJ
         +7uVJ4qyomMXuO4/BxHcxEaoOPhVJHbRzp+feYUcO7MwHGa0TXg18zygbRKcf+ulIYl7
         0eQrr+h0TOSPL1j/YBnJK+E6wC23rCE7nas72qRFsGiFHb47gqZZh2ovHYlt0LW5b3Uv
         Ah1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7DWoX9+H0DxYYZrmDNlSMsfSAn3l95094c1JRWnLT7M=;
        b=0bv20Wbvs3tnB85qpfSM1IRyr1zaf1U4F9Zl0YVrawVn3DussRjm3Et4R+LilaJF1z
         cDBn9ddLSMbIj751HS047mZA7lY4sHj6qzK1Gu7x/mveLRvN2nC8xVC7A3B3oPY/CnyJ
         Y3M+CbWANK4JDTxbeQzdv2XonefZjDz4nSRCzUoYMxMfV94IuD01SXkve2eLigQqlrKs
         kILtudQwK3HRSLu2MOvT42zpXUrNa9MVHBJM79nxqNrMxw3hzcrIov8ATOOhofDlqrW4
         8qzj5v/UjesX88WTvVCPdU/4h/be4Bgput3oWPDuoqyFMR/2yCefnjhtEfLXa7Tx0Bvs
         PXLg==
X-Gm-Message-State: AOAM530cF1BrxczeX4RsTS/QkKeAmGmBT6S/lK5arLd8IQYLDjrl523/
        RA18pHgqMU0ZTLNi+gu6BO+nJGxx2Rltgw==
X-Google-Smtp-Source: ABdhPJxuH5K94XMR19pYP05cjMRB9Q7KjTAQoTwIfGqgCVeDwE3dKA6WgFxqpBNYl2rqszK0RxqJ3w==
X-Received: by 2002:a17:907:9806:b0:6f5:f45:8736 with SMTP id ji6-20020a170907980600b006f50f458736mr8528972ejc.731.1651955791345;
        Sat, 07 May 2022 13:36:31 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id eb20-20020a170907281400b006f4c557b7d2sm3283456ejc.203.2022.05.07.13.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 13:36:31 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 6/6] arm64: dts: ipq8074: add APCS node
Date:   Sat,  7 May 2022 22:36:20 +0200
Message-Id: <20220507203620.399028-6-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220507203620.399028-1-robimarko@gmail.com>
References: <20220507203620.399028-1-robimarko@gmail.com>
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

APCS now has support for providing the APSS clocks as the child device
for IPQ8074.

So, add the required DT node for it as it will later be used as the CPU
clocksource.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v3:
* Node does not currently exist in the upstream kernel, so add it instead
of modifying.
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 0bc21b0c177f..271eb733f2c8 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -886,5 +886,13 @@ IRQ_TYPE_LEVEL_HIGH>, /* int_c */
 				      "axi_m_sticky";
 			status = "disabled";
 		};
+
+		apcs_glb: mailbox@b111000 {
+			compatible = "qcom,ipq8074-apcs-apps-global";
+			reg = <0x0b111000 0x6000>;
+
+			#clock-cells = <1>;
+			#mbox-cells = <1>;
+		};
 	};
 };
-- 
2.35.1

