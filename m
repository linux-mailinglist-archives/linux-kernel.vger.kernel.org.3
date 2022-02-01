Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFED64A62E3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241684AbiBARr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241736AbiBARrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:47:49 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBE3C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 09:47:49 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id k18so33554670wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 09:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R75JAp3M1abKRfmniOJ5Fuzudqh5/VKktmnzYEpT+SA=;
        b=oc9p+IVnBHLB7LZf1r+Ni3OD5gI1bzBxGsS5LT4cHBQaWFBb8jmm09tcie0gM8UUXm
         ibm81fKzJqBSY+FMLvG73EWI84K2BM1YX13xch+ZfGy/lkyDQmUlKPdd5ATMe4tP2qAY
         q2LLC47PesQHEdn+4fhjytGJiJ8lZaxKwWYKNVKC7mTuna62YxR4MvheG0z2k8wcTm5P
         y4irdy/vhh7Ze/iNid4lRN7TC6PRVv/3sRnZvxcMK59xmIrHUgLW9gCH7CvxL5r6bJsZ
         846qFCxExqndxRykCeG3S3C3H6tO3V8aBmYYve9TYbeFxWYiQ4I32VVGSXqXVIdVuoOC
         Tc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R75JAp3M1abKRfmniOJ5Fuzudqh5/VKktmnzYEpT+SA=;
        b=c+NJ0Yra9PHrGfd55lhBy2oQ9CzkR3S/xkjsSLmhROtplGBwEalWhEYw+9wjNYFaJ3
         aHm2ccikOH9ZmNOWSRsxSSzt730U0vk36T78+ZDL/jJKaR7fcgPF+qNIPseU5ShG6Wul
         MXlSTihUyqmvhbMynkXsX7Y6lk0YNfrji+PICPSpW9YDnP87WsJ4ZLzcL8xiiwAAZ3bB
         AZqNaPEBpvOcZHymgcYdFRupKaJtFWSknUTQRQ7GR7dy6GnQ32191O/u8S0LB5aKZbHN
         JnI3vQe84hDXt6ibADCEX7sUTfSEbOUQzLGzfisN+VScNX4d73+JKhvrh4FvrZMbwArW
         26tg==
X-Gm-Message-State: AOAM530gzIzhrVNT5RynBm2BxyNNSpe1LP2Le5bx5GGydZLhgThu6GRA
        JdsKVIwWVPzvppecqCV+Iuy/eg==
X-Google-Smtp-Source: ABdhPJz+0uF1t9U/iG6eoJW1NBuaJp+mrqnVdnHAzVxmlbZS8+iIV8r1hEW+Y3SrEIxDg2ACIbSF1Q==
X-Received: by 2002:adf:f141:: with SMTP id y1mr22073899wro.104.1643737667624;
        Tue, 01 Feb 2022 09:47:47 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id r2sm3392332wmq.24.2022.02.01.09.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 09:47:47 -0800 (PST)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drm/msm/dsi: Remove spurious IRQF_ONESHOT flag
Date:   Tue,  1 Feb 2022 17:47:32 +0000
Message-Id: <20220201174734.196718-2-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201174734.196718-1-daniel.thompson@linaro.org>
References: <20220201174734.196718-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting the header comments, IRQF_ONESHOT is "Used by threaded interrupts
which need to keep the irq line disabled until the threaded handler has
been run.". When applied to an interrupt that doesn't request a threaded
irq then IRQF_ONESHOT has a lesser known (undocumented?) side effect,
which it to disable the forced threading of irqs (and for "normal" kernels
it is a nop). In this case I can find no evidence that suppressing forced
threading is intentional. Had it been intentional then a driver must adopt
the raw_spinlock API in order to avoid deadlocks on PREEMPT_RT kernels
(and avoid calling any kernel API that uses regular spinlocks).

Fix this by removing the spurious additional flag.

This change is required for my Snapdragon 7cx Gen2 tablet to boot-to-GUI
with PREEMPT_RT enabled.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 6b3ced4aaaf5d..3a3f53f0c8ae1 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1877,7 +1877,7 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
 
 	/* do not autoenable, will be enabled later */
 	ret = devm_request_irq(&pdev->dev, msm_host->irq, dsi_host_irq,
-			IRQF_TRIGGER_HIGH | IRQF_ONESHOT | IRQF_NO_AUTOEN,
+			IRQF_TRIGGER_HIGH | IRQF_NO_AUTOEN,
 			"dsi_isr", msm_host);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request IRQ%u: %d\n",
-- 
2.34.1

