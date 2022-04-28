Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0DB513DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352530AbiD1VwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352470AbiD1VwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:52:02 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07B4C3E18;
        Thu, 28 Apr 2022 14:48:46 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id p4so3938329qtq.12;
        Thu, 28 Apr 2022 14:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=emhy1c4wokkALHU5zhTa1PBa9uxMNsXAmSHPjRucwAA=;
        b=D0+8ewP7DGpkqMUTQhOAmPXQl97EdeP5vP501RVMyfNnKrsvSFYTe3Q38CH0ke35ho
         5XzDmBoIupeynqp2zzbRteYC0y+gc+DEi6JpHNRhoXzOOd25VOWlBZQ+MsQhAlB64Zge
         /YEi4+7r+zSl8eISdPoWtAYCtOfaejAQeGEvFVZa3DDTSqL5DcGzTD2mPVeO7QAsqnya
         anjX1dhPhOaiGpf8Gfh8LAldatBnVFy46j4ZOET+dRdzwXT2qDeAe5gjtmzeSJJnQBMp
         R2lolCsMzu22b1hX0Y4F1/gD/eFMr2wHgGIJK9Rn6tLackK3kNJvmbxlLSAvbpp7zCVB
         /G5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=emhy1c4wokkALHU5zhTa1PBa9uxMNsXAmSHPjRucwAA=;
        b=z1gzCVIBNNjYJZoOQZ33KGM6acLc14SDNcyIlI8z2BO8jYNVQDVbFK7l14tLE3kzD6
         SeElapG6PUqLgeFejDRWv8vuzACavbm3yUanDWY2jPKfzZ+aO6QlpKpriCQ6bhKG8lvk
         4mMFoU+JNyJBHrYCW/FSATF0z9yQMpEieFgryj3GUdP+mgRLdHsOXoqseTF2CNc+ohOc
         kqBRU1rkntmlv2LqdGuH16cRLLvjeXUOnfBdkv1TOgUjahZ2+X6rumoW9MljLCTIQZUS
         HX1VxJ7V/p5V5jqADDR2ojpRts+2XOvGVHsHJ3N27xj3Mamyb3qffPDpjHAbPLCpp6pP
         kl7A==
X-Gm-Message-State: AOAM530eCJJOswdFWR7oZ4Z0KeHqesf9mIdu9zCI4Th8bQ9hX3YNilYT
        DOecwhMxzsTA0d7Az5PnbbM=
X-Google-Smtp-Source: ABdhPJyILod4JLI+sqUQNfFlWiZsTjRBp9iaMkgiRQbFlJC9w9yqmrtnzeK8CWeGEXOb1NRx4dEoZw==
X-Received: by 2002:a05:622a:1981:b0:2f3:6390:c232 with SMTP id u1-20020a05622a198100b002f36390c232mr19125660qtc.677.1651182525992;
        Thu, 28 Apr 2022 14:48:45 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id bl5-20020a05620a1a8500b0069f51e47c5esm546442qkb.110.2022.04.28.14.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 14:48:45 -0700 (PDT)
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
Subject: [PATCH v2 03/15] dt-bindings: gpio: fsl-imx-gpio: Add i.MXRT compatibles
Date:   Thu, 28 Apr 2022 17:48:26 -0400
Message-Id: <20220428214838.1040278-4-Mr.Bossman075@gmail.com>
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

Both the i.MXRT1170 and 1050 have the same gpio controller as
"fsl,imx35-gpio". Add i.MXRT to the compatible list.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1 -> V2:
 - New commit to fix dtbs_check
---
 Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
index f57d22d1ebd6..ae18603697d7 100644
--- a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
@@ -37,6 +37,8 @@ properties:
               - fsl,imx8mp-gpio
               - fsl,imx8mq-gpio
               - fsl,imx8qxp-gpio
+              - fsl,imxrt1050-gpio
+              - fsl,imxrt1170-gpio
           - const: fsl,imx35-gpio
 
   reg:
-- 
2.35.1

