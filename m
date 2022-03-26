Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783134E8180
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 15:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiCZOpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 10:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbiCZOpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 10:45:03 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB0C209A71;
        Sat, 26 Mar 2022 07:43:26 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id k125so8129523qkf.0;
        Sat, 26 Mar 2022 07:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+xVO0FJIQ2qgJrLzRi1aEh/qFk31sqidposkUwWuxO0=;
        b=jk1eFwQbW5J3JQg/Sv9ZOMundApGSkh69I900OR1CHGbCmSPfmdqji4oRdijiCNdtJ
         em45AdU9UlD4j4vESEKWOi55qyrWR2yqN4wnI6yNgLxT2OW1QMZIYBMHlFub/z5zeiRf
         PNCsbxIGM1JwQafF04enc0tn4taEwu3Vgw69qIC6uyv/BW0mAEHB98lVjB1a/sWy3Sgb
         hMcPELmqqYs1TEBFS9X9Yq6tkLXIUvjx01crvMBL2x8L14lVsXmjaEmiyzb85wC/7yzL
         bSz2HZh2+BUut5b/dEshyOV60bevPD0w7OwG/rNalQWnnF5iG3e4mibyhlvxaKA7KyNE
         k40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+xVO0FJIQ2qgJrLzRi1aEh/qFk31sqidposkUwWuxO0=;
        b=QZLHPAzybWgVumpxIu99UJCMG4VfEpSWiCMGx8K/T767sAPq4dRu5mhpSlh5cEkP0s
         4pBD5GMRf3Ip5qktyv1TMjIv/XYRPAXfmkToyO4DX8HPRYni96hqfpnBKu1WlQ91wsXJ
         JFOFZdOlTMiFYXmSa3EI3a4gcjI3VFWg0Fdq5om6RPd7ffsUQApEL/a4B6S5Afi1QqZ7
         imUOb/uZosm42UCjvol5yb6aUWSUmtrbr7eu3RURZQP/+YvYNXor2GeSS7i9qRj1fWMO
         dB97XN/SMpvPMiINXkliqo2Qk4g0hmIwl0wRfJ2cj4DOZpdLCmV+UCqQf9krydOXyNGj
         0TYw==
X-Gm-Message-State: AOAM5317i59pqE7C/EubdTP4TrKmMFZPDlTmQfclU99bffFea7PqTw1P
        jcj1NPm/UcA8hpCIwSgJCX0=
X-Google-Smtp-Source: ABdhPJzPp95tZ/3hOw0AU+b1NISAzh7LPEzM6bb2PU1W+2UFcf48+O0FA+ubdsRrS+3YTFbaBP7Cfw==
X-Received: by 2002:a05:620a:2a14:b0:67e:ca33:a46d with SMTP id o20-20020a05620a2a1400b0067eca33a46dmr10595581qkp.360.1648305806063;
        Sat, 26 Mar 2022 07:43:26 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id 70-20020a370649000000b0067b4cd8ffbasm4908918qkg.60.2022.03.26.07.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 07:43:25 -0700 (PDT)
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
Subject: [PATCH v1 02/12] dt-bindings: timer: gpt: Add i.MXRT compatible Documentation
Date:   Sat, 26 Mar 2022 10:43:03 -0400
Message-Id: <20220326144313.673549-3-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
References: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
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

Both the i.MXRT1170 and 1050 have the same GPT timer as "fsl,imx6dl-gpt"
Add i.MXRT to the compatible list.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
index a4f51f46b7a1..716c6afcca1f 100644
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
@@ -31,6 +31,8 @@ properties:
           - enum:
               - fsl,imx6sl-gpt
               - fsl,imx6sx-gpt
+              - fsl,imxrt1050-gpt
+              - fsl,imxrt1170-gpt
           - const: fsl,imx6dl-gpt
 
   reg:
-- 
2.34.1

