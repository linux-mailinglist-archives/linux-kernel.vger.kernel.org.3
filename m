Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A773F55AFA8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 08:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbiFZGps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 02:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbiFZGpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 02:45:39 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2359113CC1;
        Sat, 25 Jun 2022 23:45:38 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id q4so10635757qvq.8;
        Sat, 25 Jun 2022 23:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WDjEMkGqp/DVr6icsZzBPpHOB9pVxz5Q+/gwKMGXVAs=;
        b=bNI8hmVDqiGygKEdiipO9i/e/axRw3Ka/Nx06CnK+LY5TA8fu0Z4bpQcvP+NI3YlFR
         5Cc8l75nQKym9kPkh5pdY2zH1/3houmFNdWewsGJePPggijnAC8bvBRWUyGi6rkrIvv+
         4FaqYqubR5I2770bHT8LiLWi6Pz3NcHbIMyIbOMPtJvGrdWHANwnw7qhQyruqYQ/oc5t
         2T0JCiWzxcVsfxw0HXhdjoE+nl26xoNjULWMoYBtbun8Xq8LyC3pfwKSnjcwW406R/kS
         P7o0B/C5UWq9U7eyAQ2ynj2Jij9Br6VjUI9AW5O51ev1v4WR+uqJCn71pOWUYdXLbClV
         aYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WDjEMkGqp/DVr6icsZzBPpHOB9pVxz5Q+/gwKMGXVAs=;
        b=eN9M9W1bu6fCzIMnqkwwksquz1OLkxzbgVmZFqu2kV0qcBC7yHZqZDcwxM5MTs2gmu
         9pf+CtfYYjsirLkLT8AyCgOKqKx7I4917Kc32i0nxWQEFAHC+Y44j8HO2YG8dHQN1z3n
         kxJEFKUhHfDXWSgQQu4rkRRMAlol5oYwQ/TXQrxzGVJY5k2/PMz+zwLELZQ1797l9fI1
         d4FDKPDYlKZzAzsKh8ONOIDPn9WocSjqLYot/N2cLEp4PGiBabE8ZHoNNFTbIMe8cHwZ
         Gkh+/8knudP2XlAPQQGxl8poonDdLZhdx3C9LKIrDNXMc0vreM9Ql47XWC6NFXXJnkeh
         emrg==
X-Gm-Message-State: AJIora+1szkJAmYUG+txyva6yRQyuAZOROFNwAxhuHkUtBpQwZoZXD8b
        EWjampkAcK8SCQXJ4qWLx4s=
X-Google-Smtp-Source: AGRyM1tV4Vao1e0wDNf/ECwo0kJNWeWFXQkstmX3Gb0Y7ElPFduzVUVcM/A8VVot7kERSuwFJlEJVA==
X-Received: by 2002:a05:622a:1a27:b0:304:f1cb:e8c4 with SMTP id f39-20020a05622a1a2700b00304f1cbe8c4mr5238873qtb.194.1656225937185;
        Sat, 25 Jun 2022 23:45:37 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a424f00b006a76a939dbasm5914620qko.112.2022.06.25.23.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 23:45:36 -0700 (PDT)
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
Subject: [PATCH v4 05/13] dt-bindings: serial: fsl-lpuart: add i.MXRT1170 compatible
Date:   Sun, 26 Jun 2022 02:45:15 -0400
Message-Id: <20220626064523.3683775-6-Mr.Bossman075@gmail.com>
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
 - Nothing done
V3 -> V4:
 - Fix rebase artifact
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

