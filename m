Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CC749C8BD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240806AbiAZLgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240783AbiAZLgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:36:02 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35485C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:36:02 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id k18so25237785wrg.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bXVjE+WHy8056yU6PQ186TKgk9YFsJSf/z9MoSICAgo=;
        b=bOPFKWeSDz/5+SWrCSqxTxArgqoAVTVn9JPw/LwQVWw/KF8qXvJXOqSe+p0LykVAMl
         FVHAvDWl4uq+Twi3eh6lCLiaMXN2PjAqVCezLLxc2VTlKJL4V9FMusPREkrzc18XNK60
         P2GhDxWYXChfe2PmIXOrCdKEjLmpQi7RantbrgMCzXL7uphq0emDusi5DtgizxaxvnBn
         q8nIoIuTRT21j9n3EZpMW9+5fyqF+9pxctLuV2LVwTZVkByAvGfM639trJdAOOvWMbpo
         E/bS5WOiEOIE0kXb/hi4CE/hRZcYL78/7AvmLPJk91Rr2hxlGTm7pG93zIoUcJpbLfhJ
         7Ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bXVjE+WHy8056yU6PQ186TKgk9YFsJSf/z9MoSICAgo=;
        b=feG9BPrCqiMVnDrcU5K2y0Hp6oVk9SQmFP6yMc+CNf0XSXdSpRcG2/kjRBsrM2fidK
         cR3pAZ6HzLY64sIsmkfmxF+xWA+BIhmiH+No86QnJwKHQCnNb+9rMqdSuBygLZfPoTo4
         tfqhs4TAOKTg+kszD+nrUR8x/KOFYFQg6jvIMY0BKASKKLkKa4yPYMXUxRl5J3PGgLsU
         P5onmB3l3fTrRWyKqqw9mwbH0teTas6Ls/5KynGbs5W8MRaR3HCi6OZGdRSCRPfU2p+v
         W22CqVS6INNUBRVLHeOgErVA+drwEVqTaWe4/eTiRir9EoyHgMACaoGw8rpiWsgs8ya+
         /ADA==
X-Gm-Message-State: AOAM532a64gjoMGfAtJoYF70UIHc4PAIPHyY3D6ts6UNCNQFuMx5SrRc
        DYwm9mr1YVLPVziqvDMEEyytWw==
X-Google-Smtp-Source: ABdhPJzXvbDq09qiBfc5o13vwHQzmqhkxGwNvWS1trLsF9xfkIUo9E3GK79OPSvS6pT/ByTWosOOxA==
X-Received: by 2002:adf:e48c:: with SMTP id i12mr21498933wrm.43.1643196960863;
        Wed, 26 Jan 2022 03:36:00 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n14sm11999188wri.75.2022.01.26.03.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 03:36:00 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/4] ASoC: codecs: lpass-rx-macro: fix sidetone register offsets
Date:   Wed, 26 Jan 2022 11:35:47 +0000
Message-Id: <20220126113549.8853-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220126113549.8853-1-srinivas.kandagatla@linaro.org>
References: <20220126113549.8853-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason we ended up with incorrect register offfset calcuations
for sidetone. regmap clearly throw errors when accessing these incorrect
registers as these do not belong to any read/write ranges.
so fix them to point to correct register offsets.

Fixes: f3ce6f3c9a99 ("ASoC: codecs: lpass-rx-macro: add iir widgets")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index aec5127260fd..6ffe88345de5 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -2688,8 +2688,8 @@ static uint32_t get_iir_band_coeff(struct snd_soc_component *component,
 	int reg, b2_reg;
 
 	/* Address does not automatically update if reading */
-	reg = CDC_RX_SIDETONE_IIR0_IIR_COEF_B1_CTL + 16 * iir_idx;
-	b2_reg = CDC_RX_SIDETONE_IIR0_IIR_COEF_B2_CTL + 16 * iir_idx;
+	reg = CDC_RX_SIDETONE_IIR0_IIR_COEF_B1_CTL + 0x80 * iir_idx;
+	b2_reg = CDC_RX_SIDETONE_IIR0_IIR_COEF_B2_CTL + 0x80 * iir_idx;
 
 	snd_soc_component_write(component, reg,
 				((band_idx * BAND_MAX + coeff_idx) *
@@ -2718,7 +2718,7 @@ static uint32_t get_iir_band_coeff(struct snd_soc_component *component,
 static void set_iir_band_coeff(struct snd_soc_component *component,
 			       int iir_idx, int band_idx, uint32_t value)
 {
-	int reg = CDC_RX_SIDETONE_IIR0_IIR_COEF_B2_CTL + 16 * iir_idx;
+	int reg = CDC_RX_SIDETONE_IIR0_IIR_COEF_B2_CTL + 0x80 * iir_idx;
 
 	snd_soc_component_write(component, reg, (value & 0xFF));
 	snd_soc_component_write(component, reg, (value >> 8) & 0xFF);
@@ -2739,7 +2739,7 @@ static int rx_macro_put_iir_band_audio_mixer(
 	int iir_idx = ctl->iir_idx;
 	int band_idx = ctl->band_idx;
 	u32 coeff[BAND_MAX];
-	int reg = CDC_RX_SIDETONE_IIR0_IIR_COEF_B1_CTL + 16 * iir_idx;
+	int reg = CDC_RX_SIDETONE_IIR0_IIR_COEF_B1_CTL + 0x80 * iir_idx;
 
 	memcpy(&coeff[0], ucontrol->value.bytes.data, params->max);
 
-- 
2.21.0

