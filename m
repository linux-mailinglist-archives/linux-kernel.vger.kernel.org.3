Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BD04682CC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 07:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384360AbhLDGOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 01:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384195AbhLDGO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 01:14:26 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396F4C0698C0;
        Fri,  3 Dec 2021 22:10:59 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id m17so4922202qvx.8;
        Fri, 03 Dec 2021 22:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QwRfYjASEKPn0rq5hMtwE+U5/hpOlafLmLBHxtSVut8=;
        b=iAjEND/Mh7t5gE3MiutOA5kD4GuT4VcfXfE/01XZX8Lvz6UPEeqzU2qnC0mop7JBzZ
         ul7thdgrRklDjioFARJitkMUFgI79Qq9V+IVCMDOWgmfTC9Px0xFX3h4avsG55sXaFbd
         jRka5odj2+i5joX44uUfe4M2l4/Lbq8OdyaLX65NKbhbOCnsAPBacSg1Y3EFPywLFngz
         Ma817eTkKrKPunb6uOTyFOSkfAa0YkjV6DLmfzjjYy3z8sp9Nk+yhTYKek9xcdAYnc3T
         KvnCbRzvcwu5Y0/hTjMr2oPA99T5SwAL/yMo7fmTxVGburZatwNb7NlqtAwqcBBO5j9P
         1ZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QwRfYjASEKPn0rq5hMtwE+U5/hpOlafLmLBHxtSVut8=;
        b=Qn8KVu0arsbTCmn9epCm0YseXL5lcaVEmbTftQ0D1CyGFsYIxYH3fLU4rKZ7fC7roK
         CB6Wx9QmE5vg53ZNQirAmuqiHIpRLt1W21u+94pc7sCAPXdq6uIVOxBBow4iC9ctgylX
         S6RbD4JtKGumvm9l3muPD+yEak573nhWpH0tfMh7QQ3xZhl0CS/hVjKcOHZwtv6HYWEi
         x99Tab2WTVH74ZqKgeRWxpf4BdLDCItWR1Kpg0eNSoJx9BjXeDOdGeRDbVrdlj4wv94v
         A6Z1MnJ24MkePL2E2t3DLWDNaZzLSyE38Fm4F9aMwlnlf+47v5UT4WPmR+YWW4KCzXFn
         MFyg==
X-Gm-Message-State: AOAM532ctmZjlz7VApUMEAVkCF0pcIBIKyZSp1cl40QQm0jyGi/TTq9t
        L7Fw3oAD3gAIMZ3oZrbJsEI=
X-Google-Smtp-Source: ABdhPJxYfVzxgKC+nPGJXmboncoTRe3DyMT1qjF1zeWOAGV9Y6uPFtdTjRxy4mG0Nzxh+iwoC1TESQ==
X-Received: by 2002:a0c:df0c:: with SMTP id g12mr23373490qvl.24.1638598258442;
        Fri, 03 Dec 2021 22:10:58 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id l1sm3500913qkp.125.2021.12.03.22.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 22:10:58 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, abel.vesa@nxp.com,
        adrian.hunter@intel.com, jirislaby@kernel.org,
        giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, Mr.Bossman075@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, Jesse Taube <mr.bossman075@gmail.com>
Subject: [PATCH v4 09/13] tty: serial: fsl_lpuart: add i.MXRT support
Date:   Sat,  4 Dec 2021 01:10:38 -0500
Message-Id: <20211204061042.1248028-10-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
References: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Taube <mr.bossman075@gmail.com>

Add support for i.MXRT1050's uart.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
V1->V2:
* Nothing done
V2->V3:
* Rename imxrt to imxrt1050
V3->V4:
* Nothing done
---
 drivers/tty/serial/fsl_lpuart.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index b1e7190ae483..884bc4e70d70 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -247,6 +247,7 @@ enum lpuart_type {
 	LS1028A_LPUART,
 	IMX7ULP_LPUART,
 	IMX8QXP_LPUART,
+	IMXRT1050_LPUART,
 };
 
 struct lpuart_port {
@@ -310,6 +311,11 @@ static struct lpuart_soc_data imx8qxp_data = {
 	.iotype = UPIO_MEM32,
 	.reg_off = IMX_REG_OFF,
 };
+static struct lpuart_soc_data imxrt1050_data = {
+	.devtype = IMXRT1050_LPUART,
+	.iotype = UPIO_MEM32,
+	.reg_off = IMX_REG_OFF,
+};
 
 static const struct of_device_id lpuart_dt_ids[] = {
 	{ .compatible = "fsl,vf610-lpuart",	.data = &vf_data, },
@@ -317,6 +323,7 @@ static const struct of_device_id lpuart_dt_ids[] = {
 	{ .compatible = "fsl,ls1028a-lpuart",	.data = &ls1028a_data, },
 	{ .compatible = "fsl,imx7ulp-lpuart",	.data = &imx7ulp_data, },
 	{ .compatible = "fsl,imx8qxp-lpuart",	.data = &imx8qxp_data, },
+	{ .compatible = "fsl,imxrt1050-lpuart",	.data = &imxrt1050_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
@@ -2625,6 +2632,7 @@ OF_EARLYCON_DECLARE(lpuart, "fsl,vf610-lpuart", lpuart_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1021a-lpuart", lpuart32_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1028a-lpuart", ls1028a_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imx7ulp-lpuart", lpuart32_imx_early_console_setup);
+OF_EARLYCON_DECLARE(lpuart32, "fsl,imxrt1050-lpuart", lpuart32_imx_early_console_setup);
 EARLYCON_DECLARE(lpuart, lpuart_early_console_setup);
 EARLYCON_DECLARE(lpuart32, lpuart32_early_console_setup);
 
-- 
2.34.0

