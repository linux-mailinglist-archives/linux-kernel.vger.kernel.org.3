Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D0B529817
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbiEQD21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239404AbiEQD2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:28:10 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AD73FBF3;
        Mon, 16 May 2022 20:28:09 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id v11so13754711qkf.1;
        Mon, 16 May 2022 20:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xuQULfnMRIZxwNK+Ml9um+QR+n0TJ9GdbQgbpfprxdg=;
        b=EZIbojQOe6IM7QSVAW67HEFr7KFhfQ1zmRZrVlI+OKgfAW9XK3UFpVVVBZTSaajWEX
         LE48v1uNVoVF8+WTsmi/Y3n+fyNJKcUSn2w8kzi39YYt06b0v+Cr5+6gB/p1t5bc4wiw
         BYiFgTRdk0RvuqrqQ9SAv6jB/97Z2MDqzI/AJ389B1S7UlqFBOrM8qXJx3QID0/o62nr
         bvqOEsCrLLynpZSURV5PYz1C69/RZjgTNLvlcOTdK3u1azXiToM+G8cDL8nNR3/8W3hc
         V4mnCR6U6/k6iVhoenudoVzT7BMO2biVy4aUAsgi1MUXuSj+Cq1TuNHgxLueM2jaxwKQ
         GJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xuQULfnMRIZxwNK+Ml9um+QR+n0TJ9GdbQgbpfprxdg=;
        b=fpC9yfK6tEolXpFCkyTtD9xgUAkcVbadlnZ6aDwR2ecWIGiu3WT6OIj3gYkMalhHSd
         d2XtrwpozP1ObpAMzqO28OUlhorFyAGaZiVjA0R+oGltHeTBGZbR9Y3U25PjddEnr3HP
         dNcVoVQBVtrvojdD7oLb2+Mnw/NGgo7c69fQtTllMIR88jNBaSrOgNLPpAPMD19VZMFZ
         x0puXPV/9LCoonFCJZhtuyMGL/BJx12wFJ/cBW993qTEuqP5NXtltfHAcssi7OX1V2QF
         QC+V5TKXILDElPGLw/qpEXASOd4iGtlFu0PZ+4alg9aOFgSXY+zeQoRmBqxkds4r7DrP
         Lebw==
X-Gm-Message-State: AOAM531usNq1m99ycs0mwckTxud+9PEBkbbH04c77E6CqO0vyZzr/xzo
        AvYzO9PU+EF+8yhEGoeqJr8=
X-Google-Smtp-Source: ABdhPJx8HQ7DoYvRCYmnm1vmwPHbRIvWR8oSqYO6NSkvLcSbEhBTsGN0Dq43lzY/lr0YfwSFVM8sVQ==
X-Received: by 2002:a05:620a:40cb:b0:6a0:922b:2d67 with SMTP id g11-20020a05620a40cb00b006a0922b2d67mr14834359qko.20.1652758088180;
        Mon, 16 May 2022 20:28:08 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id a19-20020a376613000000b006a098381abcsm7079535qkc.114.2022.05.16.20.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 20:28:07 -0700 (PDT)
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
Subject: [PATCH v3 04/15] dt-bindings: mmc: fsl-imx-esdhc: add i.MXRT1170 compatible
Date:   Mon, 16 May 2022 23:27:51 -0400
Message-Id: <20220517032802.451743-3-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517032802.451743-1-Mr.Bossman075@gmail.com>
References: <20220517032802.451743-1-Mr.Bossman075@gmail.com>
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

Add i.MXRT1170 compatible string to Documentation.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1 -> V2:
 - New commit to fix dtbs_check
V2 -> V3:
 - Fix typo
 - Remove unused const
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 29339d0196ec..0e7833478869 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -75,6 +75,10 @@ properties:
           - const: fsl,imx8qxp-usdhc
           - const: fsl,imx7d-usdhc
         deprecated: true
+      - items:
+          - enum:
+              - fsl,imxrt1170-usdhc
+          - const: fsl,imxrt1050-usdhc
 
   reg:
     maxItems: 1
-- 
2.36.1

