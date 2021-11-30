Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F14463EAC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 20:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbhK3Tha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 14:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbhK3Th3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 14:37:29 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB683C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 11:34:09 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id t11so21379666qtw.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 11:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8zaMGeRfyPWwhrpK4hlWNibcjKi7zgMyl76pGBmvMas=;
        b=DP2ZuuADuq4ve2aheQWcyU6KIsAFFdohg6gRu+JNuTgWBaJHh4dyY0DqWg0RR4gnc4
         OTy9VDIdJLJkEF85AUC4qv13XTawi5y5pZPVhxbx90ekxARus/eDXWgariZmM4Vdcy6X
         LkwuX4VoC/3O5HE9nh8Vt+H+/4SLrsCXA4MD2sGjZY+ubc7iMfjgLv5uVHQwj52Iev9b
         4PR96btq4ixWChGuS5hOWnFNZpWraKrcG/xSx3QCq9zWMKlGu8xAXaWRgnNTfCphik5Y
         miUb/4kNiBlOt0FRvTuTRdQRJajKrV4CGVnEqacvckgB1/0UHUrOIeHbkKFcBHQDrxmT
         OhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8zaMGeRfyPWwhrpK4hlWNibcjKi7zgMyl76pGBmvMas=;
        b=YTZ2Hm0JjgfuFYvb6z0aOKJREY6cKusKqjhjzIGzlTGxhwAXGJshB3T3QkF2SvMGOs
         /GBT4gbF34N/f9pyzgtiwpSdFaTGHct8wmH025iNVmAKxcllKd6uThW4uShXBZJbExrB
         rPqAkchz4U2ToRMCa+q4MAnpuMu65IybWfaMqh9mdPfcMMyZQbKEJIjvzHwplqg/v3Nz
         W6FYpMNlzFpw6g1cdwALPTSiKQHmZMUuRczlKoLckYh6wrRGKk1QcTa41l9C53jw2b7/
         ZdkZ/oPuQatp8P/GMsDPvpN8xTX8sXMk0Rmnimu2Fn5PThfbWf+H6NcxVAw7mNt9epmw
         meOg==
X-Gm-Message-State: AOAM531Ne4BfR8LzE/0ukTE8oO5xYOuXxtCM3Mqc2FMEE3iQnu3p/QnT
        CS7FfsjzqEcXgQxAzgRBPWwPLw==
X-Google-Smtp-Source: ABdhPJwI+s+jofwgDiLgAyn4mUWC4TGLN6gaMCv+15hzOQiD2tLr++nf1f8dALxgtr5e2WphXeKziw==
X-Received: by 2002:a05:622a:14d1:: with SMTP id u17mr1610188qtx.579.1638300848931;
        Tue, 30 Nov 2021 11:34:08 -0800 (PST)
Received: from localhost.localdomain (c-68-36-215-189.hsd1.mi.comcast.net. [68.36.215.189])
        by smtp.gmail.com with ESMTPSA id r20sm11104832qkp.21.2021.11.30.11.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 11:34:08 -0800 (PST)
From:   Jason Kridner <jkridner@beagleboard.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Jason Kridner <jkridner@beagleboard.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] counter: ti-eqep: Enable for TDA4VM/J721E
Date:   Tue, 30 Nov 2021 14:33:46 -0500
Message-Id: <20211130193346.678544-1-jkridner@beagleboard.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Counter TI-EQEP was tested on TDA4VM/J721E SoC.

Overlay used for testing EQEP0 and EQEP1:

    &cbass_main {
	#address-cells = <2>;
	#size-cells = <2>;

	eqep0: qep@3200000 {
		compatible = "ti,am3352-eqep";
		reg = <0 0x3200000 0 0x100>;
		power-domains = <&k3_pds 94 TI_SCI_PD_EXCLUSIVE>;
		clocks = <&k3_clks 94 0>;
		clock-names = "eqep0-ficlk";
		interrupts = <GIC_SPI 322 IRQ_TYPE_EDGE_RISING>;
		interrupt-names = "eqep0";
		symlink = "bone/eQEP0"; /* A - P9_42, B - P9_27 */

		count_mode = <0>;
		swap_input = <0>;
		invert_qa = <1>;
		invert_qb = <1>;
		invert_qi = <0>;
		invert_qs = <0>;
	};

	eqep1: qep@3210000 {
		compatible = "ti,am3352-eqep";
		reg = <0 0x3210000 0 0x100>;
		power-domains = <&k3_pds 95 TI_SCI_PD_EXCLUSIVE>;
		clocks = <&k3_clks 95 0>;
		clock-names = "eqep1-ficlk";
		interrupts = <GIC_SPI 323 IRQ_TYPE_EDGE_RISING>;
		interrupt-names = "eqep1";
		symlink = "bone/eQEP1"; /* A - P8_35, B - P8_33 */

		count_mode = <0>;
		swap_input = <0>;
		invert_qa = <1>;
		invert_qb = <1>;
		invert_qi = <0>;
		invert_qs = <0>;
	};

	eqep2: qep@3220000 {
		status = "disabled";
		compatible = "ti,am3352-eqep";
		reg = <0 0x3220000 0 0x100>;
		power-domains = <&k3_pds 96 TI_SCI_PD_EXCLUSIVE>;
		clocks = <&k3_clks 96 0>;
		clock-names = "eqep2-ficlk";
		interrupts = <GIC_SPI 324 IRQ_TYPE_EDGE_RISING>;
		interrupt-names = "eqep2";

		count_mode = <0>;
		swap_input = <0>;
		invert_qa = <1>;
		invert_qb = <1>;
		invert_qi = <0>;
		invert_qs = <0>;
	};
    };

Signed-off-by: Jason Kridner <jkridner@beagleboard.org>
---
 drivers/counter/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 2de53ab0dd25..453490059c88 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -51,7 +51,7 @@ config STM32_LPTIMER_CNT
 
 config TI_EQEP
 	tristate "TI eQEP counter driver"
-	depends on (SOC_AM33XX || COMPILE_TEST)
+	depends on (SOC_AM33XX || ARCH_K3 || COMPILE_TEST)
 	select REGMAP_MMIO
 	help
 	  Select this option to enable the Texas Instruments Enhanced Quadrature
-- 
2.30.2

