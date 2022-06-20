Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B408F552562
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344459AbiFTUJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344468AbiFTUI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:08:26 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CAA1E3EA;
        Mon, 20 Jun 2022 13:07:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m16-20020a7bca50000000b0039c8a224c95so6194766wml.2;
        Mon, 20 Jun 2022 13:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4twauV1jKrSap9S7bWtY2G6jDd+AwgeAtPmARMXtVJs=;
        b=HAVLNiSG1Db+lrcRkQRn8OxHpInOCKVObpVGiV2a54L1CQgeoGOooL330nzmb1IrII
         a3+TudV6Bx14k7cwx4iQj2dXFhyD/5OkarV2X1AcQ8112qn1+A6sYLyb7gP/k60vWcpp
         QlXmznoiGFzV+kfuaH3NwBCvN7xAfZ6eQWiXmrgD9jVR+QP4E0pwxB386bRkdp7qjh4v
         RRefsra95ego+spLsfQaC4Onjyy0W/nUDl+zsdYC0d5hRcphjIZcJd2yOdzoQBdmrOLN
         oGvMMVKLgN9yHbyQ2rgqGCUc73aP/jM/TLKGsXmkumYZuLKeHNvCzWm6gGOK0EhOiQTm
         KNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4twauV1jKrSap9S7bWtY2G6jDd+AwgeAtPmARMXtVJs=;
        b=n1I/l4btfN554ORe4LL40EcbWTZPBkOrJqJjzodPE8RcdXS6h1+e/nlE33qYNBb/Uj
         NS2oBMY2oFOyQoI48pDTNpLL68WueOsefTdDbazXhUH18ho0TSjHMc2Bppo+xGwmBNju
         QD837PJUKP7IftU6E8mgFx0zIHs1EdXiSxumUKWtcq+1uE9hwHcFRNlz830t6Mm2DbIn
         fRCpr7WEzy2gmN6/rjL8bqBG7FIj1MWQ+GLRh7dcN2TCpeRiKZ55pl5EJUo+i7vsx1yI
         ZZ+/pu+YELKTYgbYi6RZDNowp3VAWR1CwdlpMn900e019yxxrGPvBXakeBCFSNRB3XgA
         Gm9g==
X-Gm-Message-State: AJIora+8WJnTuvqraG5ZlM/KUNaUck8QkZq3ZT6a2K4h4gCd3NALJmvB
        vfdvtH0InAxtmPBKvXF3pas=
X-Google-Smtp-Source: AGRyM1vZj7DM/aKfxxiAy6DKWUA3/0+uS2K9N2/ZQZ6xqLKDO+9vKTvK3AWaJgypH2v81OQNNU2jMg==
X-Received: by 2002:a05:600c:4787:b0:39c:8576:8f55 with SMTP id k7-20020a05600c478700b0039c85768f55mr25382417wmo.1.1655755635917;
        Mon, 20 Jun 2022 13:07:15 -0700 (PDT)
Received: from localhost (92.40.169.63.threembb.co.uk. [92.40.169.63])
        by smtp.gmail.com with ESMTPSA id n37-20020a05600c502500b0039c5cecf206sm16544192wmr.4.2022.06.20.13.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:07:15 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        cw00.choi@samsung.com, krzysztof.kozlowski@linaro.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        michael@walle.cc, linus.walleij@linaro.org, brgl@bgdev.pl,
        tglx@linutronix.de, maz@kernel.org, lee.jones@linaro.org,
        mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, rjones@gateworks.com,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        alsa-devel@alsa-project.org
Subject: [PATCH 38/49] irqchip: sl28cpld: replace irqchip mask_invert with unmask_base
Date:   Mon, 20 Jun 2022 21:06:33 +0100
Message-Id: <20220620200644.1961936-39-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
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

An inverted mask register can be described more directly
as an unmask register.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/irqchip/irq-sl28cpld.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sl28cpld.c b/drivers/irqchip/irq-sl28cpld.c
index fbb354413ffa..f2172240172c 100644
--- a/drivers/irqchip/irq-sl28cpld.c
+++ b/drivers/irqchip/irq-sl28cpld.c
@@ -65,8 +65,7 @@ static int sl28cpld_intc_probe(struct platform_device *pdev)
 	irqchip->chip.num_irqs = ARRAY_SIZE(sl28cpld_irqs);
 	irqchip->chip.num_regs = 1;
 	irqchip->chip.status_base = base + INTC_IP;
-	irqchip->chip.mask_base = base + INTC_IE;
-	irqchip->chip.mask_invert = true;
+	irqchip->chip.unmask_base = base + INTC_IE;
 	irqchip->chip.ack_base = base + INTC_IP;
 
 	return devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev),
-- 
2.35.1

