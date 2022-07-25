Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC7D5804CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 21:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbiGYTvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 15:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236648AbiGYTvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:51:35 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC61644B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:51:34 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id w18so3289021lje.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NSvCdh1JnXJV9BbG2iR0o84dBDKvxPiIeG8bGlvazDU=;
        b=xsjZBnC1h16SdVwOv69103yJ7hO97v8dLs2zdN2O4KxVzHXqRwfphYqI8u8uTVZqfS
         xKxFQO7E0Ja7DGUJo7FxUWTZcRzByKZiLn4rnejAsufbrpvmKkJetJJRi5i8mF8c4uHp
         m3q82dp3fRMepzhpdrKnF/I5KM7B3Kb7ZkzFQ4UlwKeNSjaJ8wZFtN+zywJjZor4Tov5
         jxY6aY8JcVxI+pmKqqq2BC4eztpitVV2Skt0SoSexnEO9jgFwzKlB7NbHPak97zvesfA
         E536fifPlfED1t8jHicLmTmnw2wCwdJ/is5eg0QSgNd2xdRZLUOvbj3woL42nF02FE5S
         AYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NSvCdh1JnXJV9BbG2iR0o84dBDKvxPiIeG8bGlvazDU=;
        b=3W/FMgf1DJOcQECtHi6jSdc+86upLkDwm0eMx6mlyRwM+ks3uJCFUvvQ6F1xnUVo/B
         UN/FC5HHw1Ik2WJi0QGflgJRNUxy/2jYcSUpniPca+W2Us7K8RiO3oTEiz5XUf5StOQe
         LqGNEEPp7EmJDpVd6H6fctSECzKSznZywefgQtQFfKd3kbNRSFkCS2TR8PzVJcotOh9X
         dvM7AqorRNtEkpGHsnrR8cT2jzRHt77BuyQptZIIR8c9cNNGYznPeV5S6KxQ2yld7dO7
         rZqjDz+SO2M1/bmS+B38FsnqOVNmi4Stjr/peEwyNJH2VsCK909vBMZ1wNXOgoi125DE
         m2Vg==
X-Gm-Message-State: AJIora94BRH1YTurujxdylEQSMPANkt69AacOtA6+iGp+uKZ326lksZd
        R3JU/aI8gj6imJx/yoRm6YDJ+cgDhSz/6+da
X-Google-Smtp-Source: AGRyM1spGbsSycgVACNNAANYiq5JFc/Ei6oPs14LVv5I2tM/XVAm8OoPyqzI/f+mAcLTXancVL6+IA==
X-Received: by 2002:a2e:8046:0:b0:25d:e520:8b80 with SMTP id p6-20020a2e8046000000b0025de5208b80mr4998856ljg.319.1658778692457;
        Mon, 25 Jul 2022 12:51:32 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id a20-20020a056512201400b004790a4ce3e5sm2824973lfb.278.2022.07.25.12.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 12:51:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH 2/2] net: cdns,macb: use correct xlnx prefix for Xilinx
Date:   Mon, 25 Jul 2022 21:51:27 +0200
Message-Id: <20220725195127.49765-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220725195127.49765-1-krzysztof.kozlowski@linaro.org>
References: <20220725195127.49765-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use correct vendor for Xilinx versions of Cadence MACB/GEM Ethernet
controller.  The Versal compatible was not released, so it can be
changed.  Zynq-7xxx and Ultrascale+ has to be kept in new and deprecated
form.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Harini Katakam <harini.katakam@xilinx.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 4cd4f57ca2aa..63d23e341dad 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4797,14 +4797,16 @@ static const struct of_device_id macb_dt_ids[] = {
 	{ .compatible = "atmel,sama5d3-macb", .data = &sama5d3macb_config },
 	{ .compatible = "atmel,sama5d4-gem", .data = &sama5d4_config },
 	{ .compatible = "cdns,at91rm9200-emac", .data = &emac_config },
-	{ .compatible = "cdns,emac", .data = &emac_config },
-	{ .compatible = "cdns,zynqmp-gem", .data = &zynqmp_config},
+	{ .compatible = "cdns,emac", .data = &emac_config }, /* deprecated */
+	{ .compatible = "cdns,zynqmp-gem", .data = &zynqmp_config}, /* deprecated */
 	{ .compatible = "cdns,zynq-gem", .data = &zynq_config },
 	{ .compatible = "sifive,fu540-c000-gem", .data = &fu540_c000_config },
 	{ .compatible = "microchip,mpfs-macb", .data = &mpfs_config },
 	{ .compatible = "microchip,sama7g5-gem", .data = &sama7g5_gem_config },
 	{ .compatible = "microchip,sama7g5-emac", .data = &sama7g5_emac_config },
-	{ .compatible = "cdns,versal-gem", .data = &versal_config},
+	{ .compatible = "xlnx,zynqmp-gem", .data = &zynqmp_config},
+	{ .compatible = "xlnx,zynq-gem", .data = &zynq_config },
+	{ .compatible = "xlnx,versal-gem", .data = &versal_config},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, macb_dt_ids);
-- 
2.34.1

