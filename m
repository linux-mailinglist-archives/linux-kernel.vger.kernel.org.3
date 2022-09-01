Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F6B5A9F02
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiIASeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiIASd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:33:57 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F057E81F;
        Thu,  1 Sep 2022 11:33:54 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id f4so13967336qkl.7;
        Thu, 01 Sep 2022 11:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=WQ1Q0mz9FFzqj4DZ/mjMEZ15Ws6UL1GezqnQ2p7zS64=;
        b=UM51+arlg6z/CCre6QPOKyXnLdhVedrQVQT4q1qYMERqndsL0vqFdZxRK6fHfiD5vR
         p2fGC+qIRw4yd8hPKMl2PY3J+TlLj9VkJeaJT4YMYVUEMjAZIVsr8WJCYJUeIcKJTHPY
         OgH0c4LuWAsGoBl4pSAjTW6sYKAxngaN9pvI/OvElZRVZtCmni5xQ7RUhlRHBNSpPKF8
         lXwbef53MF/0m5so3LokRkX6+dwrY0kRhRGPHvDUwJL0R//qkAHISL4wsGXTk5aMDlLQ
         sKz0jlc7893EdDWW0QOKXdEmgsMBBLv/kri1qptyani3GrXl8V86UwQ9/aFb0kX0icqj
         Y1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WQ1Q0mz9FFzqj4DZ/mjMEZ15Ws6UL1GezqnQ2p7zS64=;
        b=JnJfWYMvVRTteFyHk57OfRvlUFD7OtlOLgCA4iaYe3avSV2aZIxd690T6rKxu+jXbA
         iYoP+f6r1qe+aUFJAEgso/NOtUH45FRC8aijd0ff3MWo/xISnZUUzoGMRZ80aJWitTLU
         kQADc4Z5cfIZEvIMrQpqp95nCaORNL2rQ5B7zALlTIK79H25qcpEYjIUQBL4TfqMwCEx
         2beedAXnkQrBd7dsmNoaAKH1bkGbJbNHVH3omqRgu4oEkUEyCHCihhyAkf6V3lt4gzGW
         6Z2tlPJJQCghO40gctF6HllVtCq8WQgmXlcysF82g5yJWUM8RbQD9S3wak14hxx4Dq0a
         7qLg==
X-Gm-Message-State: ACgBeo0eNgHG8vRJj9q2Netrm3l10bnRLcuV2Kr21RQ1wjpoqjE8FNwk
        Didtfncsojny1Ic/fXAfQ2U=
X-Google-Smtp-Source: AA6agR6pT51eIYfYIyYoIomfGEmepLPuLA7x8eDUHmhlaEnFi4XboSuLFgKSOOhCsW5nCmXv4bc7Ew==
X-Received: by 2002:a05:620a:c50:b0:6b9:6e6:428d with SMTP id u16-20020a05620a0c5000b006b906e6428dmr20469297qki.280.1662057233500;
        Thu, 01 Sep 2022 11:33:53 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id u20-20020ac87514000000b00342e86b3bdasm10563343qtq.12.2022.09.01.11.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 11:33:52 -0700 (PDT)
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
        linux-gpio@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v6 03/10] dt-bindings: mmc: fsl-imx-esdhc: add i.MXRT1170 compatible
Date:   Thu,  1 Sep 2022 14:33:36 -0400
Message-Id: <20220901183343.3188903-4-Mr.Bossman075@gmail.com>
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

Add i.MXRT1170 compatible string to Documentation.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1 -> V2:
 - New commit to fix dtbs_check
V2 -> V3:
 - Fix typo
 - Remove unused const
V3 -> V4:
 - Nothing done
V4 -> V5:
 - Nothing done
V5 -> V6:
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

