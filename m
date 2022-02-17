Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600314BADEE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiBQX7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:59:48 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiBQX7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:59:38 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8B42E08D;
        Thu, 17 Feb 2022 15:59:14 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id p9so11627561wra.12;
        Thu, 17 Feb 2022 15:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=g3H8tOvYka3MHkICVbkvjI48HA63lA9VQLbmV9F1OAQ=;
        b=U0JbSyWgvbgz1wvc6NzKGXiJmcv4W7XaJLMpXGnFCqcW3gONW2tYFhlNGYsiNiGHaS
         Nvi9Ys6piSsb9FXWh8bsHcef+8YUgE46LiCZtFbr5YgwPFfk6UdQh0mpL47eUf/fDcD6
         se1CwyWuQYhAfmBZPdjlzCA7mTIUTbB82iY0hOKUCG0xTQ1nV29oHqBiHRDLrmFUj7H8
         qA9lHXeRRGcl04inq3YNABnFwPAU2MEGHzAnZwdQqA7VUGAprgYxzzObGLu0l+iMc2ah
         wyVEU3I3I+L930zbwkxkX2IfFeeXVnD8H6tZgTml78G/NOQ1+KSHGw0xoJ6cCpeMUPeU
         eL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g3H8tOvYka3MHkICVbkvjI48HA63lA9VQLbmV9F1OAQ=;
        b=YN865eT2axRCX7FWUSf03tEcDr+IhOyQmX2zPIyLWtMqogGZJnsq9vz0LWSNAfHC+y
         xH2Joczflq/QSUPdQCxOR7h55dltEB59JoGYNWkUZEFe1zTvrwXlnF+g9qcRhA4OpH8n
         Q3J07VFdCbwCrvFTA+gCFj+ExGYTgs/B1mDfa79LOgeO/hKnU34VaSY65E0rSPrdtYQ9
         e82XlaqLYbiCUh989l2J4QfajrGPUozQynuRpm/fnTkT2JMLOT+HqU+T1Cx3IgLBk0DD
         bR5jyZVZN1jRq6//8AAPX59pPd4nerHbLDfvQiB9VgJ+LrlzbI5S2MOoXeJqrCzjovBC
         PTlA==
X-Gm-Message-State: AOAM533PDh/Fn3E1JEoqbTXlfblrVsi3ztIUBF8NtKzzFOhiKStH+Fz2
        svOtwvhzGniH0kXzGz+pmc0=
X-Google-Smtp-Source: ABdhPJxUXi9EJni7SmfF9zA5T/CqgubQKgH7dzM0zxTYKfWqAO3WHnIPta90bm7i9bub1UUUL3VEkw==
X-Received: by 2002:a5d:518d:0:b0:1e5:8cc9:5aa4 with SMTP id k13-20020a5d518d000000b001e58cc95aa4mr3845871wrv.119.1645142240450;
        Thu, 17 Feb 2022 15:57:20 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id r2sm3691694wmq.24.2022.02.17.15.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:57:20 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 16/16] ARM: dts: qcom: Add syscon and cxo/pxo clock to gcc node for ipq8064
Date:   Fri, 18 Feb 2022 00:57:03 +0100
Message-Id: <20220217235703.26641-17-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217235703.26641-1-ansuelsmth@gmail.com>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
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

Add syscon compatible required for tsens driver to correctly probe driver
and access the reg. Also add cxo and pxo tag and declare them as gcc clock
now requires them for the ipq8064 gcc driver that has now been modernized.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 11481313bdb6..5524a68cf3d1 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -298,13 +298,13 @@ smem: smem@41000000 {
 	};
 
 	clocks {
-		cxo_board {
+		cxo_board: cxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <25000000>;
 		};
 
-		pxo_board {
+		pxo_board: pxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <25000000>;
@@ -736,7 +736,9 @@ tsens_calib_backup: calib_backup@410 {
 		};
 
 		gcc: clock-controller@900000 {
-			compatible = "qcom,gcc-ipq8064";
+			compatible = "qcom,gcc-ipq8064", "syscon";
+			clocks = <&pxo_board>, <&cxo_board>;
+			clock-names = "pxo", "cxo";
 			reg = <0x00900000 0x4000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
-- 
2.34.1

