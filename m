Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF93D4B00E2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbiBIXCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:02:24 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbiBIXCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:02:22 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51210E01976B;
        Wed,  9 Feb 2022 15:02:21 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id co28so8046059edb.1;
        Wed, 09 Feb 2022 15:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WGIEHx+L4uAdTf1VzXQaUpLJlWUcIhu07EIIF1wAFus=;
        b=maSInnkknThRDgxyUU26cPJ/GRDE224IYjl3dSi18eCKyBLTJ97jIO6112ZO2In8QI
         x/0TAq3dIe01KVRgLgH5Ah5VOIkLIZdhfS7F3DZVxJBChqQcrScKSEDDnkP6zh+YTMWt
         n0ReI2QRmnzhetKFakFCSoOLxgjCx0du7xWhy+TWpRC0YJitAneSbEVoKGBOosEWo/ev
         pGm55G2vxJd6CUpIHFES9oZKgQYbtulzTLYxBeNkMyaAjzUaOHa5uxdk38iFmIUUECtR
         AZZUOfML8t/FnZnGziM6atPBwFuHuiFJGlbhK2yh0sERjVll1SNPt1sIrPmKxjaNVWWR
         u+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WGIEHx+L4uAdTf1VzXQaUpLJlWUcIhu07EIIF1wAFus=;
        b=6B2wSik8IrG6D4jD9U7IYKRRYdp0IkyZNudsW1CE9uorZL+GFNKnuHsKw8JbXFEZsO
         pnjAebh8aP9YtBBleXKUZmcU51Au7zh4NDyrAWB4fLrnmBWsRqZx2Yy2kdD5f9FkJL1E
         i/j+i506sPp5A6mD0//7xS9fRzTuHQXnLw1vn7hu2skPeobRd0rez64hxxsJNGe9DGb2
         UpQPLX4Lk5Inl8VEBF71cFZS9lx9MDj4PrIWXmT6hhqjh0oNQ2ENuKRQsPH8Dcu7h8Gn
         7jc79HKphrJkvsqUQoe8vAG2IgEyx647uzuVTNEZdJCQUABBxkGl+Uo+1qTPyII1/G8h
         K9xw==
X-Gm-Message-State: AOAM533iBDKoqMAzIutgSUW91Rx7dEc8ZdeK4fWohUv1QbHY/2mBc4AW
        ZYdTZkBM6jmRiG8f6c8tahI=
X-Google-Smtp-Source: ABdhPJzlM0o29Q+3zByPxKJEGxnYYWb7oyrYi3rp56w8xk/KHhpxnLk1OPFtL2bTTKxUmi0lbIujIw==
X-Received: by 2002:aa7:cfcd:: with SMTP id r13mr5265548edy.55.1644447739764;
        Wed, 09 Feb 2022 15:02:19 -0800 (PST)
Received: from localhost (92.40.202.147.threembb.co.uk. [92.40.202.147])
        by smtp.gmail.com with ESMTPSA id z22sm7843198edq.9.2022.02.09.15.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 15:02:19 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, robh+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: ingenic-tcu: Fix missing TCU clock for X1000 SoC
Date:   Wed,  9 Feb 2022 23:01:47 +0000
Message-Id: <20220209230145.18943-1-aidanmacdonald.0x0@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X1000 does have a TCU clock gate, so pass it to the driver.
Without this the TCU can be gated automatically, which prevents
timers from running and stops register writes from taking effect.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 arch/mips/boot/dts/ingenic/x1000.dtsi | 5 +++--
 drivers/clk/ingenic/tcu.c             | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
index 8bd27edef216..c69df8eb158e 100644
--- a/arch/mips/boot/dts/ingenic/x1000.dtsi
+++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
@@ -111,8 +111,9 @@ tcu: timer@10002000 {
 
 		clocks = <&cgu X1000_CLK_RTCLK>,
 			 <&cgu X1000_CLK_EXCLK>,
-			 <&cgu X1000_CLK_PCLK>;
-		clock-names = "rtc", "ext", "pclk";
+			 <&cgu X1000_CLK_PCLK>,
+			 <&cgu X1000_CLK_TCU>;
+		clock-names = "rtc", "ext", "pclk", "tcu";
 
 		interrupt-controller;
 		#interrupt-cells = <1>;
diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
index 77acfbeb4830..9c86043f673a 100644
--- a/drivers/clk/ingenic/tcu.c
+++ b/drivers/clk/ingenic/tcu.c
@@ -320,7 +320,7 @@ static const struct ingenic_soc_info jz4770_soc_info = {
 static const struct ingenic_soc_info x1000_soc_info = {
 	.num_channels = 8,
 	.has_ost = false, /* X1000 has OST, but it not belong TCU */
-	.has_tcu_clk = false,
+	.has_tcu_clk = true,
 };
 
 static const struct of_device_id __maybe_unused ingenic_tcu_of_match[] __initconst = {
-- 
2.34.1

