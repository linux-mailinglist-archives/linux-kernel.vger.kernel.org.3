Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6D34956E8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378335AbiATXVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378232AbiATXUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:20:50 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127B9C061574;
        Thu, 20 Jan 2022 15:20:50 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f202-20020a1c1fd3000000b0034dd403f4fbso14390158wmf.1;
        Thu, 20 Jan 2022 15:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=70y9nP+1TJuyoQVHWKHYrgk62/1kbAozVgHhQoGQnWU=;
        b=W9FIXQ88UaSTP59Qi7+oime1sFU7XPsBBr+GgtIZuDCxabPolRSg0UVB57+j7xn3TL
         L4J7c3XN5cVXU9vUf/jC5K7uxhGch/2CdvfibqBaKT5alYLpdgoGJC0Sechz5wI13ueW
         yz1HoXFN/s6m+/l2+I2rKH/GFcdU6pu9U14eRH0Vb4jaqUZSyKndqo0sqB3evNjZHBfe
         9MgvwW7Su+DfBOpYp0wZpCnECInP2+66b0NQDJscSnZgYRNWUL8Bs3pua9a6K1rwKdtY
         TTyirOIfrj5QFrdL/rS8eb23El1xVwL1JItJRWwdE30ei42exZSy7tk421zuJVgwzPRz
         gavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70y9nP+1TJuyoQVHWKHYrgk62/1kbAozVgHhQoGQnWU=;
        b=ryWacxUS5gcpzIpAapqVN/nXu+mTYaCl07RCEn222HIN73nJ8anwgGJtOQDJxRvRWK
         yKR4eX97TNvuCSLfXOyCwwxbraHHAkGRnfNf3Y1itRpsUsrWPugps/RLGLL8gOJKWw9k
         t1vNnn21+A3fqfxfRbv46TmYE1mMlsvng/aEyPna7HkSe6l20Yd1zQvNA+VLxZhgoYkj
         6giLeHjOCuixBtCeQm02RV8bIPkIjwjoHl5xGZhx9dGBVIha8SDfVQDBcJBeTZIH1JSL
         RsrNr5O8Tqk7RJk/zeK6Sq7jMslwXunUibh+1+Jixgmb64s8oHgfTuZI8nABF7Ml9WtN
         ilCA==
X-Gm-Message-State: AOAM533jLCkXh2hQCvUNuC97ObA1SPjKLzcf8Eo4JkOI1zUuhiZeKRir
        lpzOJiW8gMB0zKiEWMciGak=
X-Google-Smtp-Source: ABdhPJy2EAGYqEGxCHtEc43zDu9wvxI6e81Sk5trFgKtuU1q9UCCbNWoXPBJztPhW8RkxnbwpfmtgQ==
X-Received: by 2002:a05:600c:5125:: with SMTP id o37mr1107030wms.161.1642720848419;
        Thu, 20 Jan 2022 15:20:48 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id a9sm3939283wmm.32.2022.01.20.15.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:20:48 -0800 (PST)
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
Subject: [PATCH v2 15/15] ARM: dts: qcom: Add syscon and cxo/pxo clock to gcc node for ipq8064
Date:   Fri, 21 Jan 2022 00:20:28 +0100
Message-Id: <20220120232028.6738-16-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220120232028.6738-1-ansuelsmth@gmail.com>
References: <20220120232028.6738-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.33.1

