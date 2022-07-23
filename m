Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F16557F04A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 18:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbiGWQFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 12:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237623AbiGWQF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 12:05:28 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F84311823;
        Sat, 23 Jul 2022 09:05:27 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id g1so5663882qki.7;
        Sat, 23 Jul 2022 09:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vb7PoP3wBNM540eacheWW6lTPUsGBqPMe5PmxeEAKk4=;
        b=G9wHiFkZ8w7viyzJpNzyGDqkqehHhUb87LFsyF4SsM+ETuRcXUg1BdlVbyYy8AwP2i
         kV1e0mOjbJ0EmW0hMjF7Sdi8ABrpKw49G1dK+YWXVyD98uIqsGbjBULOvF1MCqYfiR/d
         QJtnwCehNfSAWNqZv/VNdBEMMT/XKrOEOc2wAAsl05/VYv6OxJLYAcsG+VgTIUWYmZ5/
         6dljd3oWf+xjzFl80xaG3x9Sqh/gRvsE4hiX1SgVIorVWYjHUjkt/OTyyCLNbzJCADqI
         CY4GM7wdpnjS3h7dskRSHr2Pf/UpeHXo88XpdVclp25wL6qKKH9spEfOFtNMmR5z/u0p
         iTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vb7PoP3wBNM540eacheWW6lTPUsGBqPMe5PmxeEAKk4=;
        b=8POC6lhmlu2ZFJ9PuSx6mvEa0P0KTu6peSxh6ncvLkPLKwcWzBwmkkFrggvZZqkQ3T
         2HW7dEG27F1cihGZwB8+RO3w8WWuSP4mYeeAaDXJGvtaqs2zYz/hHjsyYlynZ7j3aRC2
         SZWHMbh3xZtkoiUNtJrMdzoAnrrm+bra2SuY65rYgNp4gbGhYE3WcIWut4ixNc/5nbuF
         HSFqHNquE9lEobLi4c25coTpBjKEAfaSCO3AgYNuZKPBxT6E5gqJma6sC12ETX2YR1Uw
         ECdZaYN1dHt23/GJUd2KuoAhwIbZFxAe1EZRbNjDGgqyzxxXaAe/raKyhXLxLuD0gp+4
         A/uA==
X-Gm-Message-State: AJIora/II4Es9umFT3A06vCvsGmnsh9fjOXY9G0ZVEOS09q0rmHBPmI+
        qiC/I1w8LXnUi2BEDIaDM+o=
X-Google-Smtp-Source: AGRyM1s+XDWHp+nDbgOQKt5C4VcWRUXh3Npwnty6jfcEfY4Pu8pvrT/dEg+WdvKgBsMg8Y1b3A7zAg==
X-Received: by 2002:a05:620a:27cf:b0:6b5:473d:44eb with SMTP id i15-20020a05620a27cf00b006b5473d44ebmr3739764qkp.282.1658592326865;
        Sat, 23 Jul 2022 09:05:26 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id g4-20020ac87f44000000b0031eb3af3ffesm4935046qtk.52.2022.07.23.09.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 09:05:26 -0700 (PDT)
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
Subject: [PATCH v5 05/12] dt-bindings: serial: fsl-lpuart: add i.MXRT1170 compatible
Date:   Sat, 23 Jul 2022 12:05:06 -0400
Message-Id: <20220723160513.271692-6-Mr.Bossman075@gmail.com>
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

Add i.MXRT1170 compatible string to Documentation.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
V1 -> V2:
 - New commit to fix dtbs_check
V2 -> V3:
 - Nothing done
V3 -> V4:
 - Fix rebase artifact
V4 -> V5:
 - Nothing done
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index 30eaa62e1aed..2c2f3c97a125 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -32,6 +32,9 @@ properties:
               - fsl,imx8qm-lpuart
               - fsl,imx8dxl-lpuart
           - const: fsl,imx8qxp-lpuart
+      - items:
+          - const: fsl,imxrt1170-lpuart
+          - const: fsl,imxrt1050-lpuart
 
   reg:
     maxItems: 1
-- 
2.36.1

