Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9346051E278
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444849AbiEFXBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 19:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351249AbiEFXBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 19:01:01 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14875A2F4;
        Fri,  6 May 2022 15:57:08 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id l1so4042293qvh.1;
        Fri, 06 May 2022 15:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Sxt7bLTssTeYGgR+I7SCEoY9oG9Ye7EjzwX7GHS4YA=;
        b=FyEpzqzMqKKRkhENJXzIx1SKNfuiDwTDe2hZnG9S3tlEf6FZtTCZRNgI4vwteFBePZ
         WK6lOvZ++KV0FS/HZmCxW6uotvBBVbSrt2rl54OwhQK6AbLwk3gcoBzDDnvpl8znNvOM
         h1fu7FodgNlfedOQZuSdmBIM5Ag1QXpzUrmpT0T/Gk8i3fKHcQBvKj5nmVYkETgpv+ah
         XdnEsCQ6p+9SGQWmH/fBS9GSsgVPdGBgXPG9V2jkiBSsMFl0T9/vkbJuf3wCc+UuhtPb
         oQbK7yBwXqT+fQywZQRi+nCglvl4ERdIRtuXmnE78W4U+kxZQoVi7EbtKnISfMXzTRj5
         Kjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Sxt7bLTssTeYGgR+I7SCEoY9oG9Ye7EjzwX7GHS4YA=;
        b=OIYvdlRfRkYXaOpVTP5Lxw+gHtITxrRJZvgDREUUBk75sNwkSAQjF8Vle2FoKzA0NZ
         Uw+IqPhyZy4xpxG/V4iNzQAS8IkCecyUZHRcXcWBn8RPVtZ/wEc7IQ54ixZxQG5xZANl
         c2T9IVdgX5pWNkmleAYHXPQAHgEzVg3GHuWCaB+/hAJTA9cjvLAqANn/yo1vX9/UyekR
         8v16px0LfXQiH0vL3Lof9m7g1c5btIL8xgHuCfK5/0bBkFmTK0mIHeTmo6oZApKxArm3
         xDh7CAOJe90zz75fwwE/j9XuPlrvWkBHA3v+pWf6MoPGPguCEW7yp+ees7EmlvQxsSp3
         XqKA==
X-Gm-Message-State: AOAM531a1J4ArzSdSKwNAcEJzfs5zWc/SX8kOkbWUNlb4jGMD8gE50JI
        8ZmJhFeuyEbm3QWeABTYMp4=
X-Google-Smtp-Source: ABdhPJyJUB99trwp20kwsbY6BLjfTSeFKbSoXp/o/cHRlk5ZjsS/u1oU3NXwrW8evzZn2PRvwCJ+uQ==
X-Received: by 2002:ad4:5c4b:0:b0:45a:8cc9:bdfd with SMTP id a11-20020ad45c4b000000b0045a8cc9bdfdmr4440496qva.1.1651877827789;
        Fri, 06 May 2022 15:57:07 -0700 (PDT)
Received: from grrm.lan (bras-base-mtrlpq4809w-grc-17-70-53-205-21.dsl.bell.ca. [70.53.205.21])
        by smtp.gmail.com with ESMTPSA id q188-20020a37a7c5000000b0069fc13ce208sm3187880qke.57.2022.05.06.15.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 15:57:07 -0700 (PDT)
From:   Yannick Brosseau <yannick.brosseau@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, fabrice.gasnier@foss.st.com,
        olivier.moysan@foss.st.com
Cc:     paul@crapouillou.net, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [PATCH 1/2] iio: adc: stm32: Iterate through all ADCs in irq handler
Date:   Fri,  6 May 2022 18:56:16 -0400
Message-Id: <20220506225617.1774604-2-yannick.brosseau@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220506225617.1774604-1-yannick.brosseau@gmail.com>
References: <20220506225617.1774604-1-yannick.brosseau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq handler was only checking the mask for the first ADCs in the case of the
F4 and H7 generation, since it was using the num_irq value. This patch add
the number of ADC in the common register, which map to the number of entries of
eoc_msk and ovr_msk in stm32_adc_common_regs.

Tested on a STM32F429NIH6

Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
---
 drivers/iio/adc/stm32-adc-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 142656232157..11c08c56acb0 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -64,6 +64,7 @@ struct stm32_adc_priv;
  * @max_clk_rate_hz: maximum analog clock rate (Hz, from datasheet)
  * @has_syscfg: SYSCFG capability flags
  * @num_irqs:	number of interrupt lines
+ * @num_adcs:   number of ADC instances in the common registers
  */
 struct stm32_adc_priv_cfg {
 	const struct stm32_adc_common_regs *regs;
@@ -71,6 +72,7 @@ struct stm32_adc_priv_cfg {
 	u32 max_clk_rate_hz;
 	unsigned int has_syscfg;
 	unsigned int num_irqs;
+	unsigned int num_adcs;
 };
 
 /**
@@ -352,7 +354,7 @@ static void stm32_adc_irq_handler(struct irq_desc *desc)
 	 * before invoking the interrupt handler (e.g. call ISR only for
 	 * IRQ-enabled ADCs).
 	 */
-	for (i = 0; i < priv->cfg->num_irqs; i++) {
+	for (i = 0; i < priv->cfg->num_adcs; i++) {
 		if ((status & priv->cfg->regs->eoc_msk[i] &&
 		     stm32_adc_eoc_enabled(priv, i)) ||
 		     (status & priv->cfg->regs->ovr_msk[i]))
@@ -792,6 +794,7 @@ static const struct stm32_adc_priv_cfg stm32f4_adc_priv_cfg = {
 	.clk_sel = stm32f4_adc_clk_sel,
 	.max_clk_rate_hz = 36000000,
 	.num_irqs = 1,
+	.num_adcs = 3,
 };
 
 static const struct stm32_adc_priv_cfg stm32h7_adc_priv_cfg = {
@@ -800,6 +803,7 @@ static const struct stm32_adc_priv_cfg stm32h7_adc_priv_cfg = {
 	.max_clk_rate_hz = 36000000,
 	.has_syscfg = HAS_VBOOSTER,
 	.num_irqs = 1,
+	.num_adcs = 2,
 };
 
 static const struct stm32_adc_priv_cfg stm32mp1_adc_priv_cfg = {
@@ -808,6 +812,7 @@ static const struct stm32_adc_priv_cfg stm32mp1_adc_priv_cfg = {
 	.max_clk_rate_hz = 40000000,
 	.has_syscfg = HAS_VBOOSTER | HAS_ANASWVDD,
 	.num_irqs = 2,
+	.num_adcs = 2,
 };
 
 static const struct of_device_id stm32_adc_of_match[] = {
-- 
2.36.0

