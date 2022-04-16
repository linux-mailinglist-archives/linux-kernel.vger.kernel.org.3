Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B88A503335
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiDPDBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 23:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiDPDBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 23:01:34 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C33CF8954;
        Fri, 15 Apr 2022 19:59:02 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t11so18118112eju.13;
        Fri, 15 Apr 2022 19:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4yoSPlz/nCpT9f9CFlcsdO73J5/c7HsnuFzDG+XyBWY=;
        b=lIkUPrzzBFIEbCAJ1I6ahW16LHpV54SkngCNw69KRVk6Zaa3yysF1Q0AawQ6QQAH53
         5eIr+tYYEOsbW7gkGQH/lJTdgAiLgx2xxtOfAiLgLRCJR304t5GXTmMMj2BVF5xyNtNn
         0OGq+y8VfNmFE14xC2dApUmueGuSiYLjFLWJDu8C7BNMYnNruYMEmFSPVATMAEUcAotA
         VZMwUMr0W9HOsrM8vbvCp8Ac2AEL15um01Gh4owU0vxiJjCH5vQgntAp4nwuZboVqX2p
         AVaObAH1YtoQRMA1NR7IAKGnRhUHv311dSYo4XUjltlZ+j4641pxa7vrEMMrocURyw5z
         CnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4yoSPlz/nCpT9f9CFlcsdO73J5/c7HsnuFzDG+XyBWY=;
        b=Obu2+FDoTwlEHsVarcnbzQBE+2IcgnYQaz2trFyjZWRK9VBfsPBplZBLUZrFrovfim
         dide+9fcz2BKWlkVQ2Td9liR2XkMm14FWuHxzuKsDm2ID5+xHRVi9TJO5yI3yQBVmA12
         fpzJVMw8h0Whgwe4cyHrZKUQaiyAC/mux5mOi2m+ph73CdPHTsgsDd2Nur5Kan87511t
         dwMmIyIyp50gzK1KfE+icRkCm7otfP3Kpj+bZKv+JH4xKXQPJSSlyT+50vagC78YlBU/
         D+4c11AH9ovlqE8mMYAYIhha0pcQqFzNFSVNTL7Jts6aN4Rc3VcyRCii8QmLWM4CuUQ6
         Py/w==
X-Gm-Message-State: AOAM5321YEfRTkGe/4bcrNDzSQ4WtXzzBcnuO+31xAk0xzZsQ7JIS3jb
        /VZ78FkJ+kAI81dWa0luhEU=
X-Google-Smtp-Source: ABdhPJz/KpAnwDuM8kYSwlL6csMHjK7Ms7q8ZS6U/xx+aB5YAwjcF8rJ0behvDIMocs9dbwR8N4j0A==
X-Received: by 2002:a17:907:3f8b:b0:6e8:318d:1def with SMTP id hr11-20020a1709073f8b00b006e8318d1defmr1394258ejc.153.1650077940389;
        Fri, 15 Apr 2022 19:59:00 -0700 (PDT)
Received: from localhost.localdomain ([138.199.7.159])
        by smtp.gmail.com with ESMTPSA id oz20-20020a170906cd1400b006e872188edbsm2200915ejb.104.2022.04.15.19.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 19:59:00 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH RESEND v2 6/9] arm64: dts: qcom: msm8996: Remove MSM8996 Pro speed bins from cluster OPP tables
Date:   Sat, 16 Apr 2022 06:56:34 +0400
Message-Id: <20220416025637.83484-7-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220416025637.83484-1-y.oudjana@protonmail.com>
References: <20220416025637.83484-1-y.oudjana@protonmail.com>
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

Now that qcom-cpufreq-nvmem doesn't use SMEM to combine both MSM8996
and MSM8996 Pro speed bins into the same supported-hw bitmask, remove
bits 4,5,6 from all opp-supported-hw in cluster OPPs. These bits will
be placed in a separate device tree for MSM8996 Pro.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 82 +++++++++++++--------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 6fb3ef9df05b..5695671bb934 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -142,82 +142,82 @@ cluster0_opp: opp-table-cluster0 {
 		/* Nominal fmax for now */
 		opp-307200000 {
 			opp-hz = /bits/ 64 <307200000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-422400000 {
 			opp-hz = /bits/ 64 <422400000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-480000000 {
 			opp-hz = /bits/ 64 <480000000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-556800000 {
 			opp-hz = /bits/ 64 <556800000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-652800000 {
 			opp-hz = /bits/ 64 <652800000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-729600000 {
 			opp-hz = /bits/ 64 <729600000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-844800000 {
 			opp-hz = /bits/ 64 <844800000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-960000000 {
 			opp-hz = /bits/ 64 <960000000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1036800000 {
 			opp-hz = /bits/ 64 <1036800000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1113600000 {
 			opp-hz = /bits/ 64 <1113600000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1190400000 {
 			opp-hz = /bits/ 64 <1190400000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1228800000 {
 			opp-hz = /bits/ 64 <1228800000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1324800000 {
 			opp-hz = /bits/ 64 <1324800000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1401600000 {
 			opp-hz = /bits/ 64 <1401600000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1478400000 {
 			opp-hz = /bits/ 64 <1478400000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1593600000 {
 			opp-hz = /bits/ 64 <1593600000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 	};
@@ -230,127 +230,127 @@ cluster1_opp: opp-table-cluster1 {
 		/* Nominal fmax for now */
 		opp-307200000 {
 			opp-hz = /bits/ 64 <307200000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-403200000 {
 			opp-hz = /bits/ 64 <403200000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-480000000 {
 			opp-hz = /bits/ 64 <480000000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-556800000 {
 			opp-hz = /bits/ 64 <556800000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-652800000 {
 			opp-hz = /bits/ 64 <652800000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-729600000 {
 			opp-hz = /bits/ 64 <729600000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-806400000 {
 			opp-hz = /bits/ 64 <806400000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-883200000 {
 			opp-hz = /bits/ 64 <883200000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-940800000 {
 			opp-hz = /bits/ 64 <940800000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1036800000 {
 			opp-hz = /bits/ 64 <1036800000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1113600000 {
 			opp-hz = /bits/ 64 <1113600000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1190400000 {
 			opp-hz = /bits/ 64 <1190400000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1248000000 {
 			opp-hz = /bits/ 64 <1248000000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1324800000 {
 			opp-hz = /bits/ 64 <1324800000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1401600000 {
 			opp-hz = /bits/ 64 <1401600000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1478400000 {
 			opp-hz = /bits/ 64 <1478400000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1555200000 {
 			opp-hz = /bits/ 64 <1555200000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1632000000 {
 			opp-hz = /bits/ 64 <1632000000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1708800000 {
 			opp-hz = /bits/ 64 <1708800000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1785600000 {
 			opp-hz = /bits/ 64 <1785600000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1824000000 {
 			opp-hz = /bits/ 64 <1824000000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1920000000 {
 			opp-hz = /bits/ 64 <1920000000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-1996800000 {
 			opp-hz = /bits/ 64 <1996800000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-2073600000 {
 			opp-hz = /bits/ 64 <2073600000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 		opp-2150400000 {
 			opp-hz = /bits/ 64 <2150400000>;
-			opp-supported-hw = <0x77>;
+			opp-supported-hw = <0x7>;
 			clock-latency-ns = <200000>;
 		};
 	};
-- 
2.35.1

