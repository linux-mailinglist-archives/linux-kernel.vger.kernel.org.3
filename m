Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12AE550C34
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 18:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbiFSQu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 12:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiFSQuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 12:50:22 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB23963A3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 09:50:21 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so488047wmb.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S1wp9fg7GLV3pi+6N9b23chCh97u+d99m5VcERi7ehs=;
        b=bPnyXKWN64AHnZToeVUO26HMas9/tkxyQqtdLVRhdC+buVatlHnFMXdVVxgkESp/A0
         /1fXdPu57m3R1lk+dB2zygAbwZRjSH4KVqkRLvwHDPruj9h14mCjz2zVNu3s5f1awmS0
         ewXdPp8hughiHf3N7oWAaA4pNA75h6XO7zS/+w73bY7EoxpqSF1ormze50BhwXH2jj3L
         lQ5rnsJPdJa6O/VqkNvxSArJLsPmkZh9EP+It4o5yFg+rUYq0lsu6Hm0KD3QL1a+1ofC
         SMMoEZEFRu5ys/E9neTRnaJM+st+vUuX/9TzcjuY54aS9fckKvnumpv3lIJCcqy4HozJ
         EAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S1wp9fg7GLV3pi+6N9b23chCh97u+d99m5VcERi7ehs=;
        b=flkuUN/JpqZ1Y/YVfyD/SYyBWK1hwZHYVJFlvOKkLBgQuEuPtWa6ax4u7DswxiQoRi
         0pXpWao3SdejVn68+vjcqTJ9dmf4klmRDL5msfPUgI9K26ILoHzSmUNAYl/SkXbqt5Ml
         3LkhkVgXRRocguGz8KVm28vNfAkwEg10aeZ4A8KDrf0C4tFG2Sop98rJ4zf10EOb8/XB
         ed/+Qqw51EoRPRNWQjMM+pfTkapf39drws3QRKkqS5pYUPwBarA7DfhJ1AEDKIdH6H/k
         DRUpFWFoXTLnQLjqAof1M0ZZ2KStCHgFXTHROrYKo0im8Py7CexBDMcwvHLZkotGJtBQ
         D8tw==
X-Gm-Message-State: AJIora+OdtHU6ye82mzvwf88Q3RMNWSA/hD9xMFPqAHGrw56oyapcrnr
        8JcaRRIEuE6E9ZeXLD4TSOPItA==
X-Google-Smtp-Source: AGRyM1uF0ceBCoDGb8f7820OuMYLUviRQuhZsDcnfdtER4rIoj2V0+8xcQxMV4x24fp4JC4HNI8OQw==
X-Received: by 2002:a05:600c:3d18:b0:39c:474c:eb with SMTP id bh24-20020a05600c3d1800b0039c474c00ebmr20396587wmb.87.1655657419809;
        Sun, 19 Jun 2022 09:50:19 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id m14-20020adfdc4e000000b0021a3c960214sm9189510wrj.6.2022.06.19.09.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 09:50:19 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [RFC 2/6] dt-bindings: net: cdns,macb: document polarfire soc's macb
Date:   Sun, 19 Jun 2022 17:49:32 +0100
Message-Id: <20220619164935.1492823-3-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220619164935.1492823-1-mail@conchuod.ie>
References: <20220619164935.1492823-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Until now the PolarFire SoC (MPFS) has been using the generic
"cdns,macb" compatible but has optional reset support. Add a specific
compatible which falls back to the currently used generic binding.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 86fc31c2d91b..9c92156869b2 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -28,6 +28,7 @@ properties:
           - enum:
               - cdns,at91sam9260-macb # Atmel at91sam9 SoCs
               - cdns,sam9x60-macb     # Microchip sam9x60 SoC
+              - microchip,mpfs-macb   # Microchip PolarFire SoC
           - const: cdns,macb          # Generic
 
       - items:
-- 
2.36.1

