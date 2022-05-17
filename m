Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81F1529806
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239854AbiEQD2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbiEQD2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:28:06 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AB23FBE4;
        Mon, 16 May 2022 20:28:05 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id k2so13534977qtp.1;
        Mon, 16 May 2022 20:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZiOS/vicLJE9WEdrThn5lA73QwzwDarAXYYuEpv/t38=;
        b=GuMx0QJi/BbGxrLNR4hmBCktzb41Mq+TaJIoAywcw04Q4n9DsyqDcJCiSaLMBdI98H
         6DjzvmHWxl7qEmkNyWUt1rvXi1+i63u8yhwhHpjQ9om1sYwhhvrrlBVOOdkHZGuBlGZG
         zBB6fh+ABSl8gI9mrBLGWaNbXMipgLjTRJQdTYUZECJnE5BodealkZ6gW/Cpei38/70c
         wQfgl/3rkIy4+2ftCi0O0QYqDLKb8jChQ1CcrFsh8PP0F9wRW+n/7tt7Ndn0/Y+et3Ah
         opDDNyi221eKuD1zTtE3n3BmODVzN1EZLqinUn0r3MpZuUIikrW77Dwadu4o2GWjCUpM
         1G4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZiOS/vicLJE9WEdrThn5lA73QwzwDarAXYYuEpv/t38=;
        b=Vsyj87qFrbrU1gypWITxUpg1uMZPqeY33bc+FSx92O9gk0rdTHhcpBHcnNh9wLtkH5
         X/NMG19iFLg5XTRfj93dYcEbDIUBi6CFUZjWTvMXNeL74iePYYIwGwljyaiVH04TB8jj
         NUyE1xXf1WWoYOcVV9ULBwUz9V+yRxOBDROkhHpa8VBwo7owhK8DpI1C3YMF9lU4fQPG
         frGrbc7gp+jp+yaT7v+V6z9tAVmYCxZRwCNlUvS4+HM1fdDOLNFzFEP2LyFYQ68WGvNI
         AsM8SmFQFna9S9iHHb/LyVWpt/Bfi+a+0TZAMQIZ59DVix3UeoXqr0XV3FyorEqp4xWl
         Fy0w==
X-Gm-Message-State: AOAM532X0OdtYnZC2TVQvVJLdbZ9PFFBdozrBOuGhlDeCyPrFjZ4s/7U
        473kCKeqyamHVwnFiDpmMlY=
X-Google-Smtp-Source: ABdhPJxR3c5z0LY1qU0bR9Pa1M/8Q1xSFiaiCoy7+ewpfV1USVKihC8anAZHWlBMI4XrlWc5bZdCWQ==
X-Received: by 2002:a05:622a:1982:b0:2f3:b7c1:4426 with SMTP id u2-20020a05622a198200b002f3b7c14426mr18008779qtc.347.1652758084760;
        Mon, 16 May 2022 20:28:04 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id a19-20020a376613000000b006a098381abcsm7079535qkc.114.2022.05.16.20.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 20:28:04 -0700 (PDT)
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
Subject: [PATCH v3 02/15] dt-bindings: timer: gpt: Add i.MXRT compatible Documentation
Date:   Mon, 16 May 2022 23:27:49 -0400
Message-Id: <20220517032802.451743-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
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
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
V1 -> V2:
 - Nothing done
V2 -> V3:
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
2.36.1

