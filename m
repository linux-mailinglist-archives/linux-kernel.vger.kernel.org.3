Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D21E468D66
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 22:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbhLEVF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 16:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238875AbhLEVF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 16:05:26 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DD3C061714;
        Sun,  5 Dec 2021 13:01:58 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id k21so10673855ioh.4;
        Sun, 05 Dec 2021 13:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VPcO1Y+IcTWAOW3b8aTl8BTHMy3hlj9aIUfXJHwhx+k=;
        b=BtvdlJDP0rS6N6wHUi/evu5IGoS/fXQbqh16/Aa/nfjXM5uwgs/EOw0R6/N6AQm7gN
         9va/nBcEeutVAqsAOTZlqXz8qfD5gEYPnzBuo1p+GyT2uRPBhaS54mCIwp0DljQDkdG1
         kvDrPiUer3cqlG/zbCIpo888RgMKVCsy81/hwLcyi0gKpFMkxWUw+4dV50sVCUq89XHD
         lw6xJBf7nlMYDqsQXfGctWWHt+IrUrw+x37fcjB13XHURZMaexFjgdR0j/EC04xJrh8P
         pW10rvZeli4aEFT7a17pvmcwaa7FFryHoLrR71AY5LInI1XKeFNybPICtdSOz4mLauHH
         LQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VPcO1Y+IcTWAOW3b8aTl8BTHMy3hlj9aIUfXJHwhx+k=;
        b=zKXL5AztiRESXI24uFR1t1Ml1jEDzFQ6rXbXDjKpp5GFbTyCKeNbIZiED8/BDp9Z1b
         Xumw3R/BLbWimFqsYAx3BYaurB0GxWAydHpefDxyU04JS42mkMcsK05w4kyFeWYcJV5B
         BekTAWVk1ndliljmI2xmklDSCvYu75sakgbtcEYIeyRaTJ7YC5LaWE3qpxHJP13hiOSG
         VotQBwwx1lzZ3cshi+osUUtzdHAOs9Cjp0gEHn76Vsi2gd/JgJKjQbuHkd0EyApx/0Bn
         OlRq1rVBsMJhGw9ATh4WZLVD4s46fP7rTZ6pno6pkGMnIIC5FPb+DjJFltZEj3iTM/c/
         +L7Q==
X-Gm-Message-State: AOAM531Y/71dC8IXAxLp8WjbCypEtUqVpNcOlRz4Ow8VWHSm1GoT3ol/
        h9lK0osJwgNq3UJhPv4qW0w=
X-Google-Smtp-Source: ABdhPJzd8Zo8GcEOxXovkYNJBd0wu3m7p1/xWhUsBibFiELY36inPdiGnIEm5tVl2bQtvFddeVriyw==
X-Received: by 2002:a05:6602:483:: with SMTP id y3mr29061135iov.42.1638738117886;
        Sun, 05 Dec 2021 13:01:57 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:9ea0:bb99:b16a:6159])
        by smtp.gmail.com with ESMTPSA id e12sm2409001ilu.3.2021.12.05.13.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 13:01:57 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Ford <aford173@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: fsl: imx8mq-evk: link regulator to VPU domain
Date:   Sun,  5 Dec 2021 15:01:43 -0600
Message-Id: <20211205210144.1072721-1-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SW1C regulator powers the VPU and the state isn't guaranteed
to always be on.  Link the VPU power-domain to the regulator to
ensure it is turned on before using the power domain.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index b83df77195ec..6778306aff3b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -326,6 +326,10 @@ &pgc_gpu {
 	power-supply = <&sw1a_reg>;
 };
 
+&pgc_vpu {
+	power-supply = <&sw1c_reg>;
+};
+
 &qspi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_qspi>;
-- 
2.32.0

