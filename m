Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46224BAE97
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiBRAbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:31:16 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiBRAbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:31:08 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292A8723D6;
        Thu, 17 Feb 2022 16:30:44 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m126-20020a1ca384000000b0037bb8e379feso7413630wme.5;
        Thu, 17 Feb 2022 16:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UIO9mpkTH5IkHFgirMq25fX6Lj1NXThCSNpSEYRoRzk=;
        b=pWORFmWiDM1++kafCUhfh1sc9tqnR6rsXNIX78cgvYKWWjKGGx14eZk/g1kVuXWZ1g
         JwRxsSyzSrFzXGz+ybJNi74683QqPROmjMkwbZ2vRhFv1+vBr+eheH2ygJFC8EeDTShO
         gdWZNVeTV9nHS9DCoMH6tmXwr49nC2GICu5qPPcdGxWyEnR3UVeWDrnhwe8wK/tUjgDP
         il5v1bIy6Ecd4OxUCLpco5d0xLxuH8HxoW5p1BBEA1wPtoWVLljzFXUt+AoZFkm2icyN
         tYGRRsCAMR3DuIM+xw8a6zAEpztgeDWcpGZzUV/XGEF5IYj/FDRXHqtlbb1DtaSN3i1T
         IFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UIO9mpkTH5IkHFgirMq25fX6Lj1NXThCSNpSEYRoRzk=;
        b=jDm/GTGRZydOMPmt/CL2D5vTxu0YafYrbQWMPa6aXbwn0fVf/peGffxVkg7KyooFn4
         uxuqZjmlCZKxIlD07CHOvqHuLI4Mlekt7e32CjaI2Dx1RzDHqo+Pec2UtIUF4e662YvT
         2dRqyMUUnQUbXldmY5rykRP3CqUVGAUV1AaamtoJlzhQbVUzXolWve6W/3bcVbVVbrMD
         p6kREYcefaytLOsaQKsxRSSRyNNJ5r+NBTHtioPmOhUpM84+W4Ksye4BqcRVlHTXxdYk
         dNHbBcpNyQd+7UDWQXZxLmxBcZfl4IogBJwCnQzhV9N32y4nb299uXjt2Hvkxo90VnDz
         8yDA==
X-Gm-Message-State: AOAM532TRk11PWN/mhjgVrgizo9yYjv5N5yYyqCDhZCPrWNzmJsnGdEZ
        5dUQlD7OdUYAqNFf3gTMb2qph0MmpXc=
X-Google-Smtp-Source: ABdhPJzZJtXFSJ6Cog6BgIHNrzKiRT+cNmFLRAKAgKp6C///YeYe59gGXGzmcHwXZP0pq1DPcpOPfQ==
X-Received: by 2002:a1c:720c:0:b0:37b:eb64:4fa3 with SMTP id n12-20020a1c720c000000b0037beb644fa3mr4822113wmc.93.1645144209860;
        Thu, 17 Feb 2022 16:30:09 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id d29sm3640406wra.63.2022.02.17.16.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:30:09 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 15/18] ARM: dts: qcom: add multiple missing binding for cpu and l2 for ipq8064
Date:   Fri, 18 Feb 2022 01:29:53 +0100
Message-Id: <20220218002956.6590-16-ansuelsmth@gmail.com>
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

Add multiple binding for cpu node, l2 node and add idle-states
definition for ipq8064 dtsi.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 36 +++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 629e22236f5b..1079572f4f5d 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -30,6 +30,16 @@ cpu0: cpu@0 {
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc0>;
 			qcom,saw = <&saw0>;
+			clocks = <&kraitcc 0>, <&kraitcc 4>;
+			clock-names = "cpu", "l2";
+			clock-latency = <100000>;
+			cpu-supply = <&smb208_s2a>;
+			operating-points-v2 = <&opp_table0>;
+			voltage-tolerance = <5>;
+			cooling-min-state = <0>;
+			cooling-max-state = <10>;
+			#cooling-cells = <2>;
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		cpu1: cpu@1 {
@@ -40,11 +50,37 @@ cpu1: cpu@1 {
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc1>;
 			qcom,saw = <&saw1>;
+			clocks = <&kraitcc 1>, <&kraitcc 4>;
+			clock-names = "cpu", "l2";
+			clock-latency = <100000>;
+			cpu-supply = <&smb208_s2b>;
+			operating-points-v2 = <&opp_table0>;
+			voltage-tolerance = <5>;
+			cooling-min-state = <0>;
+			cooling-max-state = <10>;
+			#cooling-cells = <2>;
+			cpu-idle-states = <&CPU_SPC>;
+		};
+
+		idle-states {
+			CPU_SPC: spc {
+				compatible = "qcom,idle-state-spc";
+				status = "disabled";
+				entry-latency-us = <400>;
+				exit-latency-us = <900>;
+				min-residency-us = <3000>;
+			};
 		};
 
 		L2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			qcom,saw = <&saw_l2>;
+
+			clocks = <&kraitcc 4>;
+			clock-names = "l2";
+			l2-supply = <&smb208_s1a>;
+			operating-points-v2 = <&opp_table_l2>;
 		};
 	};
 
-- 
2.34.1

