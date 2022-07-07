Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AF956977D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiGGBa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbiGGBay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:30:54 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6E02E6B3;
        Wed,  6 Jul 2022 18:30:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id sb34so29843427ejc.11;
        Wed, 06 Jul 2022 18:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8uqZn4HAdLB1AC8QpQQ0n5So/DO9QfHEVB2iIBEuJuc=;
        b=PwTXzFfl+bPjR3kTDvoh6EfebNJQtPW4iahTRsvPbW9K66nXesvdknJotclrb4aJym
         HviucPNN6udwKpUn6nBv6/cNr9KaPi4dXaxgAwkl+F2FYY/a5gVlgZ06m0Jfao5opRez
         rDJIblimsZLApGBBVyRoBA664FMHCTAOHGuJXDdbyx5+w6mC7WEuBErXcDyl6G0+6d5c
         DgKda/tBiesc1X+nZrzM7RWI1HP5BfAhLlJmFhwd/rFzY3w2pOQwbF9DGzhKSPM3orKg
         hlmRbP8b1ZL9C3Q1U+3r2qYZTGJHZSxb18+vwE0CjVqAx6snh7vL3xry1gad+mQtHYr7
         pmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8uqZn4HAdLB1AC8QpQQ0n5So/DO9QfHEVB2iIBEuJuc=;
        b=yr8kDRyafDbnaIpG8dg7Pj05434iojhVdct6qp14CxGay2GUVys/zUo5keC8XUfzom
         zsVURlV+WcnrdlFHkKAS4GeS7aAaJruNzkKzvCtgi3Xpa3xGkKQXKLcunOGDPf6KbM0T
         1tAtyEg7t56dFGDSC3A5ne9oTQPZeWq8YvX5gDTgS2YB5o0LJSAceVcLX5WAj5pHyywC
         taF0C+NkX8d1w3OxFxbRnVnAFvn8Ja1hPDO5p10UItR88QV0mowJlvik3T6Iq0LoYkpG
         XtuEW5ot1Z+1uxgt+FeJuUkm6l/bc94RKU0L5NbRnqhbB9NPz0KmM4IsOG/Pu2hazkk3
         iRJw==
X-Gm-Message-State: AJIora/7Ao7stO1nATTQIREdRZUcmZ3htW+UCCfO5B89n//PVIazG6IH
        fVP2pc3TRV/3N13BMMMxgsE=
X-Google-Smtp-Source: AGRyM1uziJSTcG7jIDbIil/Ple3MITi3ef+ntMudi6c9/rnhEFPwvjygxxBi44dHXxA+yD1w6icnNA==
X-Received: by 2002:a17:907:7288:b0:72a:f967:8f89 with SMTP id dt8-20020a170907728800b0072af9678f89mr5917797ejc.359.1657157451664;
        Wed, 06 Jul 2022 18:30:51 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id t27-20020a17090616db00b0071cbc7487e1sm18025172ejd.69.2022.07.06.18.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 18:30:50 -0700 (PDT)
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
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 3/3] ARM: dts: qcom: add missing smem node for ipq8064 dtsi
Date:   Thu,  7 Jul 2022 03:30:17 +0200
Message-Id: <20220707013017.26654-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707013017.26654-1-ansuelsmth@gmail.com>
References: <20220707013017.26654-1-ansuelsmth@gmail.com>
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

Add missing smem node for ipq8064 dtsi.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index cd1b43e2cab4..ff1a2acb1d83 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -292,8 +292,11 @@ nss@40000000 {
 		};
 
 		smem: smem@41000000 {
+			compatible = "qcom,smem";
 			reg = <0x41000000 0x200000>;
 			no-map;
+
+			hwlocks = <&sfpb_mutex 3>;
 		};
 	};
 
-- 
2.36.1

