Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385C54B0129
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiBIXZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:25:40 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiBIXZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:25:38 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4D3E056596
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 15:25:33 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y7so304078plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 15:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cuDyqJtQkOZWq7GCqSKtM5Nekpy0WS9Wr09B0b+ZHEk=;
        b=mJUGs196QE4e+93P3XrLjGhPpdg6y+RWphSnf3Fr4PTAuc+HnrZgbhtvd06SXDn+gS
         GCqMgHjSLUhtpWCMI8WWXfqRS5edno6KEmX84YaoGfeDhvuzbjw7RdE7vhZFdoNXuEmA
         NEk2vKgifQiIGBMIiEdCXmVq6VOHYD3mph42Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cuDyqJtQkOZWq7GCqSKtM5Nekpy0WS9Wr09B0b+ZHEk=;
        b=4Hc1er0UGYY4sV/KDpAX7EHbHqY6c6wAm0iSYX9QEerzeatQniccTTl8gG1As0kdFk
         numiE4iMUJzMQC+s3pzcVyrU9eO/x8gfa8UK9O7l58+nomokVhLcKx/MLeJTHWf/m3oz
         uM4yuUAT8A831trcty0qWKyMOyAJU2jtSNt7HKnptm8xPK62VSM7CEZAHiMsMDYFlNRd
         8I2lfAuPgw9XjeH7RusO2/GBgWQicNHOPXe2XoAvVw9N4f5UgHBxh7Rq7+0CLb6dh6YC
         jlltlMHinxQ0+57uZHeeH9jd3UGbfnO0O82TQ3FYSerdBLllqdqFVikovSjV2SV3dsvL
         6V8g==
X-Gm-Message-State: AOAM530L+V1G1u6H+TLDaHbBuUQ7vqu8RmCuIWiq1lRmQwYpUDRYfpzB
        hAdc9AydM2F7F6dFsukOEmpDvw==
X-Google-Smtp-Source: ABdhPJyFlluWkTGxIDD8DAe+Rrtl/A4H7tmBZt3vNUZHOenuccFvdMBHj1zHh72rB0o4uWqYwAMcTw==
X-Received: by 2002:a17:90a:7083:: with SMTP id g3mr5220486pjk.209.1644449122551;
        Wed, 09 Feb 2022 15:25:22 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:5193:6865:e38e:3a5b])
        by smtp.gmail.com with ESMTPSA id u12sm22067162pfk.220.2022.02.09.15.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 15:25:22 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Subject: [PATCH] ASoC: qcom: Actually clear DMA interrupt register for HDMI
Date:   Wed,  9 Feb 2022 15:25:20 -0800
Message-Id: <20220209232520.4017634-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit da0363f7bfd3 ("ASoC: qcom: Fix for DMA interrupt clear reg
overwriting") we changed regmap_write() to regmap_update_bits() so that
we can avoid overwriting bits that we didn't intend to modify.
Unfortunately this change breaks the case where a register is writable
but not readable, which is exactly how the HDMI irq clear register is
designed (grep around LPASS_HDMITX_APP_IRQCLEAR_REG to see how it's
write only). That's because regmap_update_bits() tries to read the
register from the hardware and if it isn't readable it looks in the
regmap cache to see what was written there last time to compare against
what we want to write there. Eventually, we're unable to modify this
register at all because the bits that we're trying to set are already
set in the cache.

This is doubly bad for the irq clear register because you have to write
the bit to clear an interrupt. Given the irq is level triggered, we see
an interrupt storm upon plugging in an HDMI cable and starting audio
playback. The irq storm is so great that performance degrades
significantly, leading to CPU soft lockups.

Fix it by using regmap_write_bits() so that we really do write the bits
in the clear register that we want to. This brings the number of irqs
handled by lpass_dma_interrupt_handler() down from ~150k/sec to ~10/sec.

Fixes: da0363f7bfd3 ("ASoC: qcom: Fix for DMA interrupt clear reg overwriting")
Cc: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 sound/soc/qcom/lpass-platform.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index a59e9d20cb46..4b1773c1fb95 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -524,7 +524,7 @@ static int lpass_platform_pcmops_trigger(struct snd_soc_component *component,
 			return -EINVAL;
 		}
 
-		ret = regmap_update_bits(map, reg_irqclr, val_irqclr, val_irqclr);
+		ret = regmap_write_bits(map, reg_irqclr, val_irqclr, val_irqclr);
 		if (ret) {
 			dev_err(soc_runtime->dev, "error writing to irqclear reg: %d\n", ret);
 			return ret;
@@ -665,7 +665,7 @@ static irqreturn_t lpass_dma_interrupt_handler(
 	return -EINVAL;
 	}
 	if (interrupts & LPAIF_IRQ_PER(chan)) {
-		rv = regmap_update_bits(map, reg, mask, (LPAIF_IRQ_PER(chan) | val));
+		rv = regmap_write_bits(map, reg, mask, (LPAIF_IRQ_PER(chan) | val));
 		if (rv) {
 			dev_err(soc_runtime->dev,
 				"error writing to irqclear reg: %d\n", rv);
@@ -676,7 +676,7 @@ static irqreturn_t lpass_dma_interrupt_handler(
 	}
 
 	if (interrupts & LPAIF_IRQ_XRUN(chan)) {
-		rv = regmap_update_bits(map, reg, mask, (LPAIF_IRQ_XRUN(chan) | val));
+		rv = regmap_write_bits(map, reg, mask, (LPAIF_IRQ_XRUN(chan) | val));
 		if (rv) {
 			dev_err(soc_runtime->dev,
 				"error writing to irqclear reg: %d\n", rv);
@@ -688,7 +688,7 @@ static irqreturn_t lpass_dma_interrupt_handler(
 	}
 
 	if (interrupts & LPAIF_IRQ_ERR(chan)) {
-		rv = regmap_update_bits(map, reg, mask, (LPAIF_IRQ_ERR(chan) | val));
+		rv = regmap_write_bits(map, reg, mask, (LPAIF_IRQ_ERR(chan) | val));
 		if (rv) {
 			dev_err(soc_runtime->dev,
 				"error writing to irqclear reg: %d\n", rv);

base-commit: dfd42facf1e4ada021b939b4e19c935dcdd55566
-- 
https://chromeos.dev

