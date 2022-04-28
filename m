Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491F5513E18
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352479AbiD1VwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352451AbiD1VwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:52:01 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42660C0D33;
        Thu, 28 Apr 2022 14:48:45 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id o18so4498911qtk.7;
        Thu, 28 Apr 2022 14:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sq1McYDtncgu3zqIM7eDiykPH41EW1O9qKhBDq8HPzg=;
        b=m4c34C75x7Jtc8GQeKDtOPIV3Xvno2koB/GQ+gyU1FzvKGM/71kZxPDBCb8Msnji8c
         AImTDouWL4Ecj5YgVop44reRWi96UHzk6V6yZoro+Jod+BiheNJ+xPY3JAvasMNcai5q
         1RMD7Sz2dUQWnqnsmhgLWjO1+0ooyqtVn+CgJUCZO+mvLPLoaHANRA4oF6+I4xxd0HO4
         GlgEiLAsvFCIRzz1whMdDTruE0FGDAZ+zvSSHINee6LRL1sGteMYQoMGhYmCKVWD8dG6
         bhVHxZFbR0zr9bJu7j+rAa338PcFFiPOwOSjeWZICAKouv6u9y45J34ssFoehzi3snfh
         GHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sq1McYDtncgu3zqIM7eDiykPH41EW1O9qKhBDq8HPzg=;
        b=kgVzIYGB5LVighRT131GVjGLAV0sd4hMAZfJARr83GoHZYzA4Dlv2WS9xCKTEQzEVK
         JrbrNzHedHgpfRApNkJX+9Ab8ZX0fuzNhVVny8ALaUSHy1kv6H+4WB2BJkex/s0dmoB1
         fadgg1xOPem4hqbxIrotNnUlbYk7RvQ1YiKrHvgfXBRQkiEveVyP1OLUtFAhZfAbijcZ
         DoKLBc3jc9jdRmODNtQDJJT9zw4JS5PpsqosaHGgaiHY+HIyrQsqOQ704c5PgUZZXKRX
         eDRTvFzAaPaLFcr/an4pZWcN1y9HNJ04X8pbtQidgypcl1o9CyG4z6GiKRFdVb14ojng
         imgQ==
X-Gm-Message-State: AOAM530jpmu6FXp9GsurF/l5RwfwJOcau1odRT8g6qwnKF/RFeza59n1
        iiXoYqy8CuyrbXYs4r4J8eQ=
X-Google-Smtp-Source: ABdhPJxxIafmXjFknlk4ztopHK5xsw1FkhTDO3U2c6KXHwxESFM6VshJnXbBy2tSRwc7CfQUpFPlXA==
X-Received: by 2002:a05:622a:14d0:b0:2f3:4279:687c with SMTP id u16-20020a05622a14d000b002f34279687cmr25311866qtx.551.1651182524397;
        Thu, 28 Apr 2022 14:48:44 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id bl5-20020a05620a1a8500b0069f51e47c5esm546442qkb.110.2022.04.28.14.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 14:48:44 -0700 (PDT)
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
        linux-gpio@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 02/15] dt-bindings: timer: gpt: Add i.MXRT compatible Documentation
Date:   Thu, 28 Apr 2022 17:48:25 -0400
Message-Id: <20220428214838.1040278-3-Mr.Bossman075@gmail.com>
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

Both the i.MXRT1170 and 1050 have the same GPT timer as "fsl,imx6dl-gpt"
Add i.MXRT to the compatible list.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
V1 -> V2:
 - Nothing done
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
2.35.1

