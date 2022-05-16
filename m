Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0BA529237
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348993AbiEPVFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349027AbiEPVE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:04:27 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6675C64E;
        Mon, 16 May 2022 13:40:03 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 185so13181706qke.7;
        Mon, 16 May 2022 13:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L3le14rhaSocQeKQwxrRTldErgYW+NHKabztIF2/qZ4=;
        b=YwBuId0XmN7JIWITFrXT+8veOWLqw7slTOSwB3fed+CJpB+0z/tm4v5Rf2B+9pj+pQ
         T7mdFXHx9Hg1Ca4MmX/x9HtjhrlDEWLEXPA5auHE2CRdEKkG8fJbYktrABWoYO8nQzNL
         XINzLvXYqqjOseUog68ZikVGx7Rx4ghnE65h2Z7PZ5/ZKKlnWgEqCifCFLgqRpZYM34d
         mYeJAv5soR7JZGQSnd8TGdhPO6Xetsu1JJjy9oSrI1u2bxlbgcUTDgoVmDXExlzVa5gW
         RGqfTRbCbX8CGu4a3gbLIC3EaK8p3r+/PJ5w/5Chu/nZA0Huo/nPxgCBXWt3MjOI/XIh
         CAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L3le14rhaSocQeKQwxrRTldErgYW+NHKabztIF2/qZ4=;
        b=ERRxbxI7E7MGZVrJEW7AC7nMLw+7RCv3G+DYBp8Z83I7zAYcOdvIZzt7uGtw06lplD
         TGQfxZl611pBW2HTMt33j+zKYCywSluVMwYm8svbeWdyV13p/YHlhk0tqbauE2WnslWi
         9lS+O0LZbY+ylqsqAVa0fNCopaOkDsvtcIkrs2r/Lt7QTM2KO/vVSOzs32PbVskot3sC
         QdaWLoax2NONlnMi7aE9aBc4QZ6aff0tFZx+eNZ/n86sH1qcldZ8SKA4UkrP4I6syDJj
         mcnilwh7rkQB5sO60jyJNctnorSUcyC9yjiSY86VbnmQayEye0+n6dg1eh4j6hzgTTC2
         e57A==
X-Gm-Message-State: AOAM5309BJXP50lJ5yXAUZ42pZkdoeRju5XQfzB0mKqVP47SpWwzx3uC
        fBI16udCI+CWwSBUSaN9KFc=
X-Google-Smtp-Source: ABdhPJxJnWTboPrcAFadimt77on92UDhywlvLKxVgUleScXkQ+vnAbz0mZZhuvSEuAjMyTfTw8dscA==
X-Received: by 2002:a37:a953:0:b0:69f:9314:ba62 with SMTP id s80-20020a37a953000000b0069f9314ba62mr13554460qke.398.1652733602008;
        Mon, 16 May 2022 13:40:02 -0700 (PDT)
Received: from grrm.lan (bras-base-mtrlpq4809w-grc-17-70-53-205-21.dsl.bell.ca. [70.53.205.21])
        by smtp.gmail.com with ESMTPSA id k67-20020a378846000000b006a00fabde68sm6364016qkd.10.2022.05.16.13.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:40:01 -0700 (PDT)
From:   Yannick Brosseau <yannick.brosseau@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, fabrice.gasnier@foss.st.com,
        olivier.moysan@foss.st.com
Cc:     paul@crapouillou.net, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [PATCH v2 1/2] iio: adc: stm32: Fix ADCs iteration in irq handler
Date:   Mon, 16 May 2022 16:39:38 -0400
Message-Id: <20220516203939.3498673-2-yannick.brosseau@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516203939.3498673-1-yannick.brosseau@gmail.com>
References: <20220516203939.3498673-1-yannick.brosseau@gmail.com>
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
F4 and H7 generation, since it was iterating up to the num_irq value. This patch add
the maximum number of ADC in the common register, which map to the number of entries of
eoc_msk and ovr_msk in stm32_adc_common_regs. This allow the handler to check all ADCs in
that module.

Tested on a STM32F429NIH6.

Fixes: 695e2f5c289b ("iio: adc: stm32-adc: fix a regression when using dma and irq")
Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
---
 drivers/iio/adc/stm32-adc-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 142656232157..bb04deeb7992 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -64,6 +64,7 @@ struct stm32_adc_priv;
  * @max_clk_rate_hz: maximum analog clock rate (Hz, from datasheet)
  * @has_syscfg: SYSCFG capability flags
  * @num_irqs:	number of interrupt lines
+ * @num_adcs:   maximum number of ADC instances in the common registers
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
2.36.1

