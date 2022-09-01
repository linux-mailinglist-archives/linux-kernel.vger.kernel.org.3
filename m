Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAD35A9F22
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiIASeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiIASeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:34:06 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7477F0B8;
        Thu,  1 Sep 2022 11:33:59 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id kh8so14137329qvb.1;
        Thu, 01 Sep 2022 11:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=YdtFHMRN/r3oFnRnKHqmURrUXOCIm7+fBetlO5pq8CQ=;
        b=aYl2vS9Ns3ibcHpoQzkVFaSyDdfB74G2pc8Qt2Rgft0RsKbbUfjvN3KItqiyHfJFD4
         VyklUZv0B3CvrVu7HmIHVwUXrMBpJYTpP5lgyDXzn6R+tkVP79LIyS7VTx0xa8QHpMjP
         SRh9bQF6I7009IdtMq6mC5sDlJEnsFy1bh03T4zyFx+8u/FmNy4WKN/Cf7vZrR229/9W
         Vw7uj5NnqwGTbdvRLAQO1o6Z1QQr4AufLiw+uAOfNvcxDHqconDrxnJ3LrSV3w+QOkb0
         gUTCOD6CtPgqZG7riUcfkKP05frv06g7CT8WUKF9CaRRu2G2j4L2xqbWZJkJtIX8sDMv
         G/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YdtFHMRN/r3oFnRnKHqmURrUXOCIm7+fBetlO5pq8CQ=;
        b=VqDLX3zLFMJYMKloRCheg8inXAGyG++OQoyEU35axonNHfF70xwPMwnFsBIfUA5Q6h
         RPf+lZW8DYYQYPaw8WOshU96k0PpM3YuTIqUQJ89bTAeC0vB0tLrGDt7MKG95zwBw2Kd
         TL3J71t/MHNaXE9zFueFcaKP9gq2oXmQwFTSUsoLRuQBS90G6+WEjmRBPthklzLesylx
         52rpbTxpnpj91etglZekwTKQmH7n8fbvyQvzYG7YR0snODPp8//UlrIAHwdHmw+v571p
         HtY2+13lN0RFdddGeCkQxU99kLcnm5njxH249K+7o20voDIyUnwDItGqtqXXREod8uQU
         lk9Q==
X-Gm-Message-State: ACgBeo1sg9tiKqwjf+/SQpKJMQt3XmAarnFYgsTjSiaFJy/oyblAVA3S
        MvLXGsTCXOPKiDCBCedA2Zc=
X-Google-Smtp-Source: AA6agR46lSqIFUvCtXJ/+X5Skmn0JT1a5CDHDpxEmseppesoKd0bDCqvDlzsSi1tHr2dSLZ/blK6Lw==
X-Received: by 2002:a05:6214:2489:b0:498:f243:b9a3 with SMTP id gi9-20020a056214248900b00498f243b9a3mr25402269qvb.19.1662057237556;
        Thu, 01 Sep 2022 11:33:57 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id u20-20020ac87514000000b00342e86b3bdasm10563343qtq.12.2022.09.01.11.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 11:33:56 -0700 (PDT)
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
Subject: [PATCH v6 05/10] ARM: mach-imx: Add support for i.MXRT1170
Date:   Thu,  1 Sep 2022 14:33:38 -0400
Message-Id: <20220901183343.3188903-6-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901183343.3188903-1-Mr.Bossman075@gmail.com>
References: <20220901183343.3188903-1-Mr.Bossman075@gmail.com>
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
V4 -> V5:
 - Nothing done
V5 -> V6:
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

