Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD035A9F14
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbiIASeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbiIASeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:34:06 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578407EFD9;
        Thu,  1 Sep 2022 11:33:57 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id b9so10871qka.2;
        Thu, 01 Sep 2022 11:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Tv2a7wU2lhgN97bYzJfah37NqTdtlxQ5678kEaFGvZM=;
        b=F4sesasecjX/JIjBPB1nFlGezzl2EeRQ8PgoBgGj3g4d6Ns1fXzIk41ieUigoQ+yjT
         0uFYW0xf/DD7010ylr5FjsS0DHRTt0g9rGc7hL90W5t9Welnd3LBoB25th+9/3oIYE0G
         sC5Ssv8s0j1vMM1VASi2/yVOZ5U+HHy6j2Ji8RM9k1O/DueagTExMiqdtnESMfTTO3xe
         UTUjFxEZJ0ecmo+4nnv2/HuDfWjdvhzFkMudTqcPZNnn5xpgDshWi0CNWZmkXrr8oXcR
         ZXH4vXPeTqEpK99/4uvTo5ZOoRkn171FhULAPIIOL0kxJOPOsQeNM8m8jt6fRLw+Bzrp
         ohtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Tv2a7wU2lhgN97bYzJfah37NqTdtlxQ5678kEaFGvZM=;
        b=nApxgRrcT95dzxCzZGw/j1USa2awSlaP+j7jnq/LC7J40pqWBeLWv72hhoVuignOQn
         7qBQ3E+m14ZKyxJi6ZHt2d4NRiR9A9zkk8W0E3dd3j4NJ5UnpSp5csNTtt+stFZVaibI
         V2E0mFnBa25kewt3qkjVO9q7dmT8Nxv0QDoMDcjw0qE5zh2CALeAPJq96ewdFX1OqxgL
         ZfmoDB56Kvw87JNZJ5wJazTJONRAZQIcH0Z6vsXFys1jDD0QjDs6TS3YRh6lmVPM1gtc
         DQO8GufPnvAYXSq1q5iBdBr25m3ze33xScPcKikqtPn3QwW1KOKpIEUz+G0lohlwXRZM
         BGpw==
X-Gm-Message-State: ACgBeo3hrzJm/9oyLuzqeA8XMAmhXquBcLwQ7pVbNKMdXSEMwwjF6AJY
        fjcqv4X1oheNd6gavAeMJmk=
X-Google-Smtp-Source: AA6agR7f87gfbRhIG1C0yYL3bG7qyjKY2RU+B86kNZIwcfhp5tMMsI2JVVyb5GHrZ2AsPNa+rWfgIg==
X-Received: by 2002:a05:620a:2890:b0:6bc:6ecd:2c4a with SMTP id j16-20020a05620a289000b006bc6ecd2c4amr20912427qkp.603.1662057235658;
        Thu, 01 Sep 2022 11:33:55 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id u20-20020ac87514000000b00342e86b3bdasm10563343qtq.12.2022.09.01.11.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 11:33:54 -0700 (PDT)
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
Subject: [PATCH v6 04/10] dt-bindings: serial: fsl-lpuart: add i.MXRT1170 compatible
Date:   Thu,  1 Sep 2022 14:33:37 -0400
Message-Id: <20220901183343.3188903-5-Mr.Bossman075@gmail.com>
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
V5 -> V6:
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

