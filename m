Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA2955AF9C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 08:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbiFZGpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 02:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiFZGpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 02:45:43 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599BB12D27;
        Sat, 25 Jun 2022 23:45:42 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id o43so10679900qvo.4;
        Sat, 25 Jun 2022 23:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cJciAkJZiUNOuB8bAF3b+ptAQT+SSNGszkUs7akC0t4=;
        b=LPD1tKFkwLaVBuNxvs9dtoi6QhsjulAJlaryUkl8ay9e+h1LFrziATi3AuJ4UwXrUo
         RvjeED0H1uLCBH1c6c0dXSZFaucz2E64Blnv19VFOTDQFBJmLIFARE5KLorbW67IC5+1
         +Jjb+jjP6Peg5D1ut/1HM1KKj8Sa6ynbLzq4C+T2ZekpUxXmpytef6E6u7INoKQ/92Ld
         1C4+P3FMCeu/OtnfVJgDlz404ep/kMSxPoq6Yb/Y+aLbMBrXr2ep/R1pEJ5Qqdbr3o8E
         UTmbLs/4p9yHhYgVzpAt9FCAjAC82iUdw0MNcwtddgqLQT5aa7hdIkZOs67ebmwZROjy
         FcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cJciAkJZiUNOuB8bAF3b+ptAQT+SSNGszkUs7akC0t4=;
        b=msj3xRx4VMusXTud+yTTHORBpgO9ahakFDbf+W00/5adyv5C2/yMAuEEV4ioNsGDQ6
         nB6koklBXOt016vhGoScxZW0i+ibTwNb00X1OjZDS056zUdUon/EVZYcX8+XwFd5/M3v
         wTRDLBft0+rCkWvt93Z2qDIF+ao0L5RrELwTO+8mKouj3IMYNyZL7sSOZbGZdAQ/JeoZ
         lB0hyToN7GBaLPde92vYDrt+e34DyiG0cAIiy5zFngRc2tqge5KaWax5fIEpg8OCUOfV
         6CGMWLcePZ+1t4gQ3PHHw3dnXqiHPnIenBG8N52+tNw/a6uaeha8y8SOp7fcWxZjaIRv
         cNaQ==
X-Gm-Message-State: AJIora8MH4LJn2Xq/By7vljJ0VxBTNIL0jzBBNnMqejmswPHXd9bMwVA
        TJ+vSW0nkdn8ToT2LhdzA4A=
X-Google-Smtp-Source: AGRyM1vdhEB6gPGxqRWmQbQJkNoSwBZvyZGknQqnJ/GeLTqriTm18Mx9y9D0CadTbvKkRF10ooySxw==
X-Received: by 2002:ac8:5a50:0:b0:305:20c4:791d with SMTP id o16-20020ac85a50000000b0030520c4791dmr5230293qta.437.1656225941524;
        Sat, 25 Jun 2022 23:45:41 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a424f00b006a76a939dbasm5914620qko.112.2022.06.25.23.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 23:45:40 -0700 (PDT)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, olof@lixom.net, linux@armlinux.org.uk,
        abel.vesa@nxp.com, dev@lynxeye.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, leoyang.li@nxp.com,
        sebastian.reichel@collabora.com, cniedermaier@dh-electronics.com,
        Mr.Bossman075@gmail.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: [PATCH v4 07/13] ARM: mach-imx: Add support for i.MXRT1170
Date:   Sun, 26 Jun 2022 02:45:17 -0400
Message-Id: <20220626064523.3683775-8-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220626064523.3683775-1-Mr.Bossman075@gmail.com>
References: <20220626064523.3683775-1-Mr.Bossman075@gmail.com>
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

