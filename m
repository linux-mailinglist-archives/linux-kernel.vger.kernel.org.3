Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B874F4BE3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454158AbiDEXG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443184AbiDEPjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:39:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA1614751F;
        Tue,  5 Apr 2022 06:55:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 179A16187A;
        Tue,  5 Apr 2022 13:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A647C385A1;
        Tue,  5 Apr 2022 13:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649166902;
        bh=734Ww1lhb6yXzwvS5Q/fYydkFrT3wJNGgskJNRm7z/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aggaKz7TshzGrHY8ajlnsspAZDhiSDUvH7+gKKiUYvIOYkIaeNqG5TWmNDCrmPo+c
         hg6cr1Tx3xRi1MhdEcYDeuFz2bHIBkCikwFOyX1ucVnWbxvOxfxE4R4FO18pr+XGT2
         h2lDvAJiEfu9KBhaC7tIijqW8PIoeTy/NR8SGX8+iIiZcMRsT76V28Qqof0FXt6U8J
         Z2V3spmmImApENwehbpzWFiwZ7LhBKRicrHsuJBgYbU0ZyYlQsGoSC3jYVBTPljLtS
         8QHTqfOAkXsxbaK5wRj0Ikd7VdPZ969UcGsvNmCMpOR/xhxQZW5yo7bCXfCUGdWacS
         RIhZ8XlF5puzg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nbje8-001q4g-2E; Tue, 05 Apr 2022 14:55:00 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, kernel-team@android.com
Subject: [PATCH v2 03/10] gpio: Add helpers to ease the transition towards immutable irq_chip
Date:   Tue,  5 Apr 2022 14:54:37 +0100
Message-Id: <20220405135444.199295-4-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220405135444.199295-1-maz@kernel.org>
References: <20220405135444.199295-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com, joey.gouly@arm.com, jonathanh@nvidia.com, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, bjorn.andersson@linaro.org, agross@kernel.org, jeffrey.l.hugo@gmail.com, tglx@linutronix.de, Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a couple of new helpers to make it slightly simpler to convert
drivers to immutable irq_chip structures:

- GPIOCHIP_IRQ_RESOURCE_HELPERS populates the irq_chip structure
  with the resource management callbacks

- gpio_irq_chip_set_chip() populates the gpio_irq_chip.chip
  structure, avoiding the proliferation of ugly casts

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/gpio/driver.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 066bcfdf878d..832990099097 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -583,6 +583,18 @@ void gpiochip_enable_irq(struct gpio_chip *gc, unsigned int offset);
 int gpiochip_irq_reqres(struct irq_data *data);
 void gpiochip_irq_relres(struct irq_data *data);
 
+/* Paste this in your irq_chip structure  */
+#define	GPIOCHIP_IRQ_RESOURCE_HELPERS					\
+		.irq_request_resources  = gpiochip_irq_reqres,		\
+		.irq_release_resources  = gpiochip_irq_relres
+
+static inline void gpio_irq_chip_set_chip(struct gpio_irq_chip *girq,
+					  const struct irq_chip *chip)
+{
+	/* Yes, dropping const is ugly, but it isn't like we have a choice */
+	girq->chip = (struct irq_chip *)chip;
+}
+
 /* Line status inquiry for drivers */
 bool gpiochip_line_is_open_drain(struct gpio_chip *gc, unsigned int offset);
 bool gpiochip_line_is_open_source(struct gpio_chip *gc, unsigned int offset);
-- 
2.34.1

