Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB4255AF9A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 08:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbiFZGpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 02:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiFZGph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 02:45:37 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF57312D3D;
        Sat, 25 Jun 2022 23:45:35 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id u14so8008768qvv.2;
        Sat, 25 Jun 2022 23:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eGZwpTQJWCOqWUQ3tX/KiVLVF0VonoPl4VfwowE96/k=;
        b=qldV+y2ibIOQOuoseLt8RYVUTKo4IPaHUdvvyyoenssa94ulmhnc8+VCq6ZE2ODB3d
         fvAhTid09vY1RlfHyE6qeE6NfS5GUZ39VY6xkL0DN+zphPeDkJ9xBXWOygZAkXAcWg78
         eYQfFWjO3QLijR0VVAdtal53uUIphzEEQfzQ3nIkF0kUAUZ2l8Zfwt9aJVa16k4L1nX6
         ygaYR+liV6sVwvMvhs+LdtBtIz0pVL0y3FMF7aUDLxLeD+6RDrjtvPhX0T7JC21T5oeQ
         SYryyBjEPeqIHqiO2k5z0870DKnlea3GL0+fMW2voM6j507x0vjwMfAncuRtaFDbGthe
         cVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eGZwpTQJWCOqWUQ3tX/KiVLVF0VonoPl4VfwowE96/k=;
        b=0QFmY2CkJ9U1LJrfLSiwcRNNSfDIeldupz4JmBGIPloB1ckcQ5m0rhEREUtdetWmqU
         eq8S+xu4PrjXtBBDrSzzllQELXoPjY1h3O4KD7QMpyHo6+OCz2qz88mNw+Y5+h9vivsP
         e9xN68YHzHAhfe8+3PQebGN31rmIF53CS4Uba2gC9m/ZNwVeoFDYKxkffG2GRawh84s3
         N8y3jtmzn21tu8oXhKSHId0uFEZ42Evyx7tRB/I1v+ndTsnjIbMKrIqXKvfi8n4cEJd6
         rJ/YdesjpnNsOKx7CeqsEfKAUDZbp+/hzdmXBJPTpZ2jXrp3X8cZTzADt/NjO/S1Rwim
         3YSQ==
X-Gm-Message-State: AJIora9iL+BAZLTGDnq9+9cSvlSbLcMHIuqB2ePPAK5i9RT/owB6ZsGU
        gdENxVdqNfyKZW2xaFm9960=
X-Google-Smtp-Source: AGRyM1tFBYneWb9oO0o8iID+Q+ZxcJocjhisujPl4Wn9Kxt2phQbBrx9kONJq6l3N04aeZFaljB/GA==
X-Received: by 2002:ac8:7f04:0:b0:304:e37a:41da with SMTP id f4-20020ac87f04000000b00304e37a41damr5253686qtk.352.1656225935024;
        Sat, 25 Jun 2022 23:45:35 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a424f00b006a76a939dbasm5914620qko.112.2022.06.25.23.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 23:45:34 -0700 (PDT)
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
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 04/13] dt-bindings: mmc: fsl-imx-esdhc: add i.MXRT1170 compatible
Date:   Sun, 26 Jun 2022 02:45:14 -0400
Message-Id: <20220626064523.3683775-5-Mr.Bossman075@gmail.com>
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

Add i.MXRT1170 compatible string to Documentation.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
V1 -> V2:
 - New commit to fix dtbs_check
V2 -> V3:
 - Fix typo
 - Remove unused const
V3 -> V4:
 - Nothing done
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

