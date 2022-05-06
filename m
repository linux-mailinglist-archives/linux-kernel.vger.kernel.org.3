Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE17D51E214
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441999AbiEFXBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 19:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444733AbiEFXBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 19:01:03 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D737C5C667;
        Fri,  6 May 2022 15:57:13 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id ke5so6428180qvb.5;
        Fri, 06 May 2022 15:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BGM4e8dlW2rnY5tjhs9oiiib3imBRnPsRxxY6qM+kZ4=;
        b=Cv7nqR/tLqVTBsytmAQLGkwrOSuyqjm9iJALV8wRpxzyMxwLGuvaxVOBblpzJdiQkr
         lCI6oDGbUiipN5u9wBh/WD5G3ZEVmbbk/NuaoAczXPucBVI/Q3/81679OvLoGosOn0Ms
         6w+j96cFj08P6QyRK264+FYtPJZ+6b9HgAhOw5AJTysJudS+l1FZGCdcLUfxMCnCtVn0
         OqDLaqgEFe189lgdb34G6dDmobZ0BtWgqv/HopPqRApa/OBc+bA2nM3l2JZfLkIqbPF5
         tFQY+kx3Ji5mBO7mKOd1zNS+/3LeTKjkUSSA8r0bZA07+d0pM2JeJdOTA7gdXboJsey9
         cAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BGM4e8dlW2rnY5tjhs9oiiib3imBRnPsRxxY6qM+kZ4=;
        b=MT0k+aNYlV7xaH+nhxi7xIFGueJqZ1Z15E9cIE6XDVBr/imvdXp/klgGpEYwqj/1EP
         P1xPnl5BvUjf9hHtDtTA/fx41L3bojpZvOVZT01ixdifH8z5OgJUgYGiZZx09STGxbiZ
         H3FQXAiOwm6CNG0z+71/dcNnJ7cEVeuSQ2vc/54pQX33yKUC0d1Mv2EpYSQsLXxMPaIo
         HscahI9QmP1h4kqYn7jsR67t5+QShjPb2JWnRZ+hsEyWSCHrKlfiu8xZt0/K4b0fdgiY
         Jmb+TFWUSdRrCW5DdyigP67bju1odsVkvoJltXi9Xwf2IQP9DZPpqdnODPIu/0LuB2et
         y7Eg==
X-Gm-Message-State: AOAM530Ag6u7nDR/jpX0/7TgvGRSSMgWBDR2Ad4E5MSxchL/vEWLShki
        fvmxgFPx9PNrsyAXbeWBJfU=
X-Google-Smtp-Source: ABdhPJyA6WWf4fVWUYojRIP+BmLp52WJkFjnyvtqNqoebTb6GRjKlflgRAV3EUUYrS3J1hQsfNXsxA==
X-Received: by 2002:a05:6214:b94:b0:456:38b2:2d76 with SMTP id fe20-20020a0562140b9400b0045638b22d76mr4403222qvb.70.1651877833036;
        Fri, 06 May 2022 15:57:13 -0700 (PDT)
Received: from grrm.lan (bras-base-mtrlpq4809w-grc-17-70-53-205-21.dsl.bell.ca. [70.53.205.21])
        by smtp.gmail.com with ESMTPSA id q188-20020a37a7c5000000b0069fc13ce208sm3187880qke.57.2022.05.06.15.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 15:57:12 -0700 (PDT)
From:   Yannick Brosseau <yannick.brosseau@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, fabrice.gasnier@foss.st.com,
        olivier.moysan@foss.st.com
Cc:     paul@crapouillou.net, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [PATCH 2/2] iio: adc: stm32: Fix check for spurious IRQs on STM32F4
Date:   Fri,  6 May 2022 18:56:17 -0400
Message-Id: <20220506225617.1774604-3-yannick.brosseau@gmail.com>
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

The check for spurious IRQs introduced in 695e2f5c289bb assumed that the bits
in the control and status registers are aligned. This is true for the H7 and MP1
version, but not the F4.

Instead of comparing both registers bitwise, we check the bit in the status and control
for each interrupt we are interested in.

Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
---
 drivers/iio/adc/stm32-adc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index a68ecbda6480..5b0f138333ee 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1422,9 +1422,10 @@ static irqreturn_t stm32_adc_threaded_isr(int irq, void *data)
 		return IRQ_HANDLED;
 	}
 
-	if (!(status & mask))
+	if(!((status & regs->isr_eoc.mask) && (mask & regs->ier_eoc.mask)) ||
+           ((status & regs->isr_ovr.mask) && (mask & regs->ier_ovr.mask)))
 		dev_err_ratelimited(&indio_dev->dev,
-				    "Unexpected IRQ: IER=0x%08x, ISR=0x%08x\n",
+				    "Unexpected IRQ: CR1/IER=0x%08x, SR/ISR=0x%08x\n",
 				    mask, status);
 
 	return IRQ_NONE;
@@ -1438,7 +1439,9 @@ static irqreturn_t stm32_adc_isr(int irq, void *data)
 	u32 status = stm32_adc_readl(adc, regs->isr_eoc.reg);
 	u32 mask = stm32_adc_readl(adc, regs->ier_eoc.reg);
 
-	if (!(status & mask))
+	/* Check that we have the interrupt we care about are enabled and active */
+        if(!((status & regs->isr_eoc.mask) && (mask & regs->ier_eoc.mask)) ||
+           ((status & regs->isr_ovr.mask) && (mask & regs->ier_ovr.mask)))
 		return IRQ_WAKE_THREAD;
 
 	if (status & regs->isr_ovr.mask) {
-- 
2.36.0

