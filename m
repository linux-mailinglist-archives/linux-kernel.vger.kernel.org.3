Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069E8513E1D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349698AbiD1Vw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352537AbiD1VwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:52:13 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E6DC3E85;
        Thu, 28 Apr 2022 14:48:55 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 1so4159637qvs.8;
        Thu, 28 Apr 2022 14:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ychtn8SD4NMRNaGjpVNr9S3Ei5rtR05oQ+ZMmU3VmQk=;
        b=BV3xaN9mU4t9ycFzzpXdCJhcZYdak1cPV3uu+3RRUt+NIESdWtCc5MtmbmnStfBbU4
         Z+w8VjvZhiis1K3RJiKbH+dMtwBiP1tzZVs7uJ0EIg8p4pAeDoZajdaeGiSyHTK07SVg
         Aai5AUqGpwIH/0KLCmLeySL7p3HfSQoMogC6pXcT4H96HLAqfqRfWNq+ZWh04ge6dyKz
         xYBWKQLc+5CeoVstl0nIAa/53jDSr1mQ6NbZvJ/jQU5jUPvy32+wxXkMjgsrrRn1lmsR
         UomUO6ylkc/ZdT9czHk4q6Yk80XFeE4eHK4Ths/Rm6cBLzNBFesjf9XZrK5IDjmrsmMJ
         /keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ychtn8SD4NMRNaGjpVNr9S3Ei5rtR05oQ+ZMmU3VmQk=;
        b=bov9jpkrK6IvmIYRWlkFr5u8BU4bRb44UZ0QLy+p87f49NrklNt3DSg+WB0rRHIjTt
         L2HL9jTWUqbKCnBoELrmoKCYU2w1VtxjP0Im+w+YlAfIRdUQf/yDEpno140+U2V9oEdy
         FVJJq7TAXFS0o+C5XgI5E8lRFK9+uYE/2ODGl5IijOqNrwJ+6h/nntZCOUpR10AKDMbf
         0VgG/8xbAzqiYcu8jOmajapOHvELvHyOOZicJnelRRfkMpe2yE6jpTU1Ac3+N0dTLB7O
         bS9NOCIUD4V/OGGbapm+q1CZt5jl9VQ9DPnc3Gl9e/MdDs+WsIUkIwC55Se+5zbtmco5
         f/vg==
X-Gm-Message-State: AOAM532T67AMHfEnVwysjlRvzJX2JshpXk112lbw6fK65DRwwpy9vzM2
        0k16nmSmvzV8d0lS3wbXMus=
X-Google-Smtp-Source: ABdhPJwut13QdUA10q/S608ZFTUULF1LRhMsjGAMh86U9IZsVz5jMxqzbxxGJkGrkrcNyaWMMYmS4g==
X-Received: by 2002:ad4:5ba8:0:b0:456:3c2a:dcd9 with SMTP id 8-20020ad45ba8000000b004563c2adcd9mr14947726qvq.14.1651182534148;
        Thu, 28 Apr 2022 14:48:54 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id bl5-20020a05620a1a8500b0069f51e47c5esm546442qkb.110.2022.04.28.14.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 14:48:53 -0700 (PDT)
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
Subject: [PATCH v2 08/15] ARM: mach-imx: Add support for i.MXRT1170
Date:   Thu, 28 Apr 2022 17:48:31 -0400
Message-Id: <20220428214838.1040278-9-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428214838.1040278-1-Mr.Bossman075@gmail.com>
References: <20220428214838.1040278-1-Mr.Bossman075@gmail.com>
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
2.35.1

