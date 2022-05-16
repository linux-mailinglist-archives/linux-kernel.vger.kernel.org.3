Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777EC52924B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348654AbiEPVEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349085AbiEPVEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:04:33 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A405C766;
        Mon, 16 May 2022 13:40:09 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id u3so2741715qta.8;
        Mon, 16 May 2022 13:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hKBcyX3Ppfu6XQjIjRejfr2DzYtK4WWEcAa5qty3cHg=;
        b=oukrXqAAZdBan6tdF/K2D/kCxUwWgPeZLEnHGfR+Ln2zBB1SI+qLLEfyNCPPXVMh22
         qjUN8mwA7XKNfDNOaSMbYwhl8TJQOibuS9mVrzonAfGAO/iqdUCpyVD7K6RYYt6Ck+09
         5I0enB+WW4r5ELpXeKMMneOKTFZK9+adctc1HrJ/lqyJ0JqYaBrrnZfsP4R8kybDxWNY
         cY+mKVgXNFoEggevYW+sqUyma+gTEVo8vb7W7f/KFatUHvASyI950xDNhsrgxw5WnpKh
         2pNj5+4jAfv5YMPMByRTCn6tNxzFhWmWAonNqG+6rB5jM/Qr5rcj4nZzcbgnRhsSq9x6
         tnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hKBcyX3Ppfu6XQjIjRejfr2DzYtK4WWEcAa5qty3cHg=;
        b=xrEV1G3My8xR/PpbNq6g1RiYbflL9NHySwQmRtUCVTXEq0C44pl6xDFzvQ9Btrjas/
         vTBOmfwSK1Ejr28HZgdl+5C1qoJX+Kk+t2bqECX7M3vYvsjLWHlXZIX5wjvkYXqlmRH2
         R1jxDkfzlydGDEqB+iI3STsO+jVFRUgw3rVOqWzu8PX1gyMEV9nk6zgc6YJ5px5WxXyi
         sSgxGp4RxzY2LCUHbVpuzh6nwOToXBk5xLJKYzwYeuKMvBu8ew5CZknT6aYUlQpnawjU
         c24jslWxFmU9yCeQGrgmeJHMkWul2SS5aE1W4D6lXRgF93VtZOLIg/eyuiAHUp2XiKUF
         jVuw==
X-Gm-Message-State: AOAM531De2ZZ1mSdncqY4isVzBiKmAE+apIFkJBnmhegIuoFHXke7Rt+
        3PGdmCX8EjJwk2CMHmI8/I7FLfxtvTfcWQ==
X-Google-Smtp-Source: ABdhPJyYvbcv8J+a4WY5fmCWaSGt/mt3uew74uDkCuyrQ24GIBr26QFwVCeQkFKfAyRihFdydtDalw==
X-Received: by 2002:ac8:5f06:0:b0:2f3:cbe5:1e1d with SMTP id x6-20020ac85f06000000b002f3cbe51e1dmr16773074qta.389.1652733607848;
        Mon, 16 May 2022 13:40:07 -0700 (PDT)
Received: from grrm.lan (bras-base-mtrlpq4809w-grc-17-70-53-205-21.dsl.bell.ca. [70.53.205.21])
        by smtp.gmail.com with ESMTPSA id k67-20020a378846000000b006a00fabde68sm6364016qkd.10.2022.05.16.13.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:40:07 -0700 (PDT)
From:   Yannick Brosseau <yannick.brosseau@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, fabrice.gasnier@foss.st.com,
        olivier.moysan@foss.st.com
Cc:     paul@crapouillou.net, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [PATCH v2 2/2] iio: adc: stm32: Fix IRQs on STM32F4 by removing custom spurious IRQs message
Date:   Mon, 16 May 2022 16:39:39 -0400
Message-Id: <20220516203939.3498673-3-yannick.brosseau@gmail.com>
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

The check for spurious IRQs introduced in 695e2f5c289bb assumed that the bits
in the control and status registers are aligned. This is true for the H7 and MP1
version, but not the F4. The interrupt was then never handled on the F4.

Instead of increasing the complexity of the comparison and check each bit specifically,
we remove this check completely and rely on the generic handler for spurious IRQs.

Fixes: 695e2f5c289b ("iio: adc: stm32-adc: fix a regression when using dma and irq")
Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
---
 drivers/iio/adc/stm32-adc.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index a68ecbda6480..8c5f05f593ab 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1407,7 +1407,6 @@ static irqreturn_t stm32_adc_threaded_isr(int irq, void *data)
 	struct stm32_adc *adc = iio_priv(indio_dev);
 	const struct stm32_adc_regspec *regs = adc->cfg->regs;
 	u32 status = stm32_adc_readl(adc, regs->isr_eoc.reg);
-	u32 mask = stm32_adc_readl(adc, regs->ier_eoc.reg);
 
 	/* Check ovr status right now, as ovr mask should be already disabled */
 	if (status & regs->isr_ovr.mask) {
@@ -1422,11 +1421,6 @@ static irqreturn_t stm32_adc_threaded_isr(int irq, void *data)
 		return IRQ_HANDLED;
 	}
 
-	if (!(status & mask))
-		dev_err_ratelimited(&indio_dev->dev,
-				    "Unexpected IRQ: IER=0x%08x, ISR=0x%08x\n",
-				    mask, status);
-
 	return IRQ_NONE;
 }
 
@@ -1436,10 +1430,6 @@ static irqreturn_t stm32_adc_isr(int irq, void *data)
 	struct stm32_adc *adc = iio_priv(indio_dev);
 	const struct stm32_adc_regspec *regs = adc->cfg->regs;
 	u32 status = stm32_adc_readl(adc, regs->isr_eoc.reg);
-	u32 mask = stm32_adc_readl(adc, regs->ier_eoc.reg);
-
-	if (!(status & mask))
-		return IRQ_WAKE_THREAD;
 
 	if (status & regs->isr_ovr.mask) {
 		/*
-- 
2.36.1

