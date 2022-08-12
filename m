Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4150591053
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 13:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbiHLLqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 07:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238229AbiHLLqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 07:46:47 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9594B9018B
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 04:46:45 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a89so1017696edf.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 04:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=06Z6GJcD54x41e0t+YKAiliCLRRI6h46exlRnJSDDOQ=;
        b=D+Sc4KxwwSTbPBV0CPhSaEVniSRZc21Ok5bwtCAv8M5je8j5xDCfgUCFEIjhiADpxs
         S9X3TnSg2ckFdqx6E4Sc+2hOj6sNj5Lqub8hw1V00h8w0mgTrE/ru41nVRn8ptBLVBB5
         ySBNUH07AxEUwTasenR7VUbc06BtpMmj7n7i3083BMYFPB2/GGt07CxVv3Qaqu8tFxdH
         Z4Di3HFU9goFVmrzu7l72NafzSgxURDWOx7X+b3zw/JdYOpTo2TLlqErkxVShjrOBTpk
         fL+Jwpvg38ghXCWrm/QVAY02b+fUS8I9Nria9q4qwdmFYKFB5lBHgGgDufxzDmNUqQkE
         oaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=06Z6GJcD54x41e0t+YKAiliCLRRI6h46exlRnJSDDOQ=;
        b=e0lnW72GuVu5yidFZQWEptbyKWZvUQuGECzw7PlXvP7UJBlB+4EllFSAQk65KyXeib
         PygGkDLoBx6IKQigde8xuq71sZ/DDp1eoi8dP8PSVO+A/Pp0AACX4DKtpPHbwl5w5tgX
         RG7dhRu8jlu6JITopUJkzlLbtjsezGUHAB+vVcdQ9OG3a+V4RsvvW6nTwF46L2z+S+z8
         8BIbCCsIg1pkfJr9gOK5YVilMs4UF/FAqPQ0QuYRA/drmEuvFjG/bpCXZCk/O4jrdY6X
         cOKZTSPa5i1iX/Xs9Q3xLdRaXJEyFmRGp2gKH9gLf80pQGU4TX79EANSPhoIoJvCepR/
         sgHg==
X-Gm-Message-State: ACgBeo1iUkSLxzNhTL6eVcFqn/rIZZT7Hi4Pw8xTiiSQ2ojv7FzLbMVB
        RpZLIjqz67QlYb5QkGTga1lsIw==
X-Google-Smtp-Source: AA6agR6KeG3p7wiDG03hxJzWCoWNAkcztEp1+dsyHFqZbBjGYRWVOCLu2jT3rViHkH+/z5D/MUkBmQ==
X-Received: by 2002:a05:6402:26c5:b0:43e:2f1b:31c2 with SMTP id x5-20020a05640226c500b0043e2f1b31c2mr3212843edd.424.1660304804091;
        Fri, 12 Aug 2022 04:46:44 -0700 (PDT)
Received: from otso.arnhem.chello.nl (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906210100b0072b31307a79sm713168ejt.60.2022.08.12.04.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 04:46:43 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: pm6150l: add missing adc channels
Date:   Fri, 12 Aug 2022 13:46:15 +0200
Message-Id: <20220812114614.1195679-1-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.37.1
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

Add the missing adc channels and add pre-scaling property to die_temp
channel, as per downstream dts.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/pm6150l.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm6150l.dtsi b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
index 7aa2ef90cb6a..f02c223ef448 100644
--- a/arch/arm64/boot/dts/qcom/pm6150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
@@ -20,10 +20,29 @@ pm6150l_adc: adc@3100 {
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 
+			adc-chan@0 {
+				reg = <ADC5_REF_GND>;
+				qcom,pre-scaling = <1 1>;
+				label = "ref_gnd";
+			};
+
+			adc-chan@1 {
+				reg = <ADC5_1P25VREF>;
+				qcom,pre-scaling = <1 1>;
+				label = "vref_1p25";
+			};
+
 			adc-chan@6 {
 				reg = <ADC5_DIE_TEMP>;
+				qcom,pre-scaling = <1 1>;
 				label = "die_temp";
 			};
+
+			adc-chan@83 {
+				reg = <ADC5_VPH_PWR>;
+				qcom,pre-scaling = <1 3>;
+				label = "vph_pwr";
+			};
 		};
 
 		pm6150l_adc_tm: adc-tm@3500 {
-- 
2.37.1

