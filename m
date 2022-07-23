Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C5857F04D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 18:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbiGWQFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 12:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237066AbiGWQFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 12:05:31 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8004513CF0;
        Sat, 23 Jul 2022 09:05:29 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id bz13so5442432qtb.7;
        Sat, 23 Jul 2022 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gwvQIgq3vhhcfZ1NYQsfvq3heagizQH5IEQrv2gja80=;
        b=hH8BE5VYW+TKL8xKwEP1hvTS0IvxYl5IcZc9Nzh4ZgesbztwmmaqsG/DDEy5Xqhew8
         ynDKgMxha39VxFlKP7CXLNlVrEDiB7GUyT6j3XS0aeHmhdQpWeEhx4Z+CvwgBtRjBQTw
         09eQ2OmqDfF/lcRUMCaXyabgXX7B9fFGE/8X1NRYAzJhG/7oRvisHOtjNhHSRGgDfYp9
         09WR1OIC/qUi/HW77LfwyCG1FLLo7f013uSX7otKLITQ4FNbBUc3x99UsHtX/1H6ssxf
         khDl0f2TCLP0731wCfCZdSmzkSychxJgYNkToHMEtle6PAb8oc3ANdkv4uVpGuXPlR6f
         GUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gwvQIgq3vhhcfZ1NYQsfvq3heagizQH5IEQrv2gja80=;
        b=R5o1n1/ikVKc/fP5GHCbRTxQBR4usLuiAPl3qJYuZTSKU7zFLSJY23oyL93BH6Y2q1
         DkJhSHuzSI+KNB6hCbzrn+lXOt3CXyoCH3Km3j28j6jr2u55DB3AZ+EoB/kcU8ZDj+HV
         vr0PB8n+Q4qErMDsMzc3wa9VhoN74mcIZtMGMiYgugbFeB/jKt8YGypLs++ZFqCRVOPj
         17EHZSEjMcN0yNtATSff7YLS+8pwRJk6oT47JGYrfxKtLc30GljNZOvdfTXHE1+hw7Sn
         yGl5jnznW6L5Qr61wU5ljuWIYJUq8+jlD2/KgK+aYENjA5QSq/mHMQOqfPGd6KSG3yCj
         dCsQ==
X-Gm-Message-State: AJIora+iy3YxPgSO/KDcvsG1TsvIt9BsUiCFRlid50bNveYEe2csc85h
        Ebv4vPuT4tIw/Yz9fiOhQLA=
X-Google-Smtp-Source: AGRyM1tR0ByQr20Um4ggLuRTncRgO5oc4F/nKqrO7Ts/0aN77zu2wS/X4t7bxa7CLvFM7d0czqK6EQ==
X-Received: by 2002:ac8:5fcf:0:b0:31f:3ac:487d with SMTP id k15-20020ac85fcf000000b0031f03ac487dmr4505296qta.148.1658592328649;
        Sat, 23 Jul 2022 09:05:28 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id g4-20020ac87f44000000b0031eb3af3ffesm4935046qtk.52.2022.07.23.09.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 09:05:28 -0700 (PDT)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, Mr.Bossman075@gmail.com,
        clin@suse.com, giulio.benetti@benettiengineering.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v5 06/12] ARM: mach-imx: Add support for i.MXRT1170
Date:   Sat, 23 Jul 2022 12:05:07 -0400
Message-Id: <20220723160513.271692-7-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220723160513.271692-1-Mr.Bossman075@gmail.com>
References: <20220723160513.271692-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "fsl,imxrt1170" to imxrt_compat

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1 -> V2:
 - Nothing done
V2 -> V3:
 - Nothing done
V3 -> V4:
 - Nothing done
V4 -> V5:
 - Nothing done
---
 arch/arm/mach-imx/mach-imxrt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/mach-imxrt.c b/arch/arm/mach-imx/mach-imxrt.c
index 2063a3059c84..0070214feb42 100644
--- a/arch/arm/mach-imx/mach-imxrt.c
+++ b/arch/arm/mach-imx/mach-imxrt.c
@@ -10,6 +10,7 @@
 
 static const char *const imxrt_compat[] __initconst = {
 	"fsl,imxrt1050",
+	"fsl,imxrt1170",
 	NULL
 };
 
-- 
2.36.1

