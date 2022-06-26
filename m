Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A23655AF90
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 08:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiFZGph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 02:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbiFZGpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 02:45:32 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0266912D27;
        Sat, 25 Jun 2022 23:45:32 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id z16so97136qkj.7;
        Sat, 25 Jun 2022 23:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=96f+y0GBItTKKdXBhw+uPGKc3yY89An13mxne3v5i1k=;
        b=ZobfSJ+/shjFXbwaD6MGCqUPUAbfeqCAxO8B4E0jejV5IN7YtwtqZgd/RM48V6NTtC
         n3kqV9AIz4doUprcjsPQp2gNvywLxunDbMI/MvlfOs1C/aBaoyVkWBVvN/1RCbb+f+Kw
         zNopI+gP6cQpDsB4bRByosZ6jruPYVepfTl9N+b89lYlBm1NI37t7hZgC9z8AcRE5WJ6
         4RamT1UJ7sBCWBipl3bBVYGX6dHMPh1+S8LpUDvQU2947Lf2u9+InY6D3rnfe8cEInZo
         hQdXDDwqVAcSYblpoM5dLg+el/kY50lTTzSJqM6yysPhgVFBFRYcINikh1hti9kwQJdC
         t4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=96f+y0GBItTKKdXBhw+uPGKc3yY89An13mxne3v5i1k=;
        b=stWvdPqXEeaWRJuEjHUlW5uAkrdmM/gM7y/NaDkgEDWdmgOvDsZ7G7/Kc4MV2xrK/F
         Ev/z1ay2Zgf7IYF297gtoR+hoXgRQONo7iTwZaZ99StTIrbiS6Lj1gAFjCKMPFUuua2O
         2cqAJ+FyWfTJADloZTdvKkMJa8zAyvvbP38l3NWwfAX3StVY5xp2Avv/wplFkmSSj/wl
         sAlfkBdqsKdmTfW30UPQSTgS2g4ZlD2v81+glSn7VGMAsCYcsMEI95aqugoOJrm6WxP+
         mHSDQ80bCt+S01/E+yx4pa0vkd5scsfPr8JqfUlAlgVgmypVU/AdGQMIgTRVp2Ii1jVM
         CKfg==
X-Gm-Message-State: AJIora9/jQXj+gZoj7RUE65G9YT0cJHAuIxOTXgodx5FiUW8p5mXm3Ec
        BDIjjenNuIgj8PnIXwDIbMNVRKQDRJg=
X-Google-Smtp-Source: AGRyM1vaIQXAVIkWpXCGTvRLGKJ5Smn8oka0Y/TKMAbrTjICiP8EqazACbJGd6WTvpfsSl4+gsk7uA==
X-Received: by 2002:a37:4644:0:b0:6af:271e:a510 with SMTP id t65-20020a374644000000b006af271ea510mr15065qka.515.1656225931175;
        Sat, 25 Jun 2022 23:45:31 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a424f00b006a76a939dbasm5914620qko.112.2022.06.25.23.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 23:45:30 -0700 (PDT)
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
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v4 02/13] dt-bindings: timer: gpt: Add i.MXRT compatible Documentation
Date:   Sun, 26 Jun 2022 02:45:12 -0400
Message-Id: <20220626064523.3683775-3-Mr.Bossman075@gmail.com>
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

Both the i.MXRT1170 and 1050 have the same GPT timer as "fsl,imx6dl-gpt"
Add i.MXRT to the compatible list.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
V1 -> V2:
 - Nothing done
V2 -> V3:
 - Nothing done
V3 -> V4:
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

