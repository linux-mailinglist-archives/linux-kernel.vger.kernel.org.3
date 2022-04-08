Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06224F9E85
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbiDHVCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237244AbiDHVCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:02:40 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359FFF7F67
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 14:00:36 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id y7-20020a4a9807000000b003296ea2104eso1675707ooi.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 14:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/6bF252QqnY12H7PjXHxtHVXzmjhuS4IY4ywpEiT3F4=;
        b=t9eaw3470SQsd1wU8fIBzSCDwU93D3/U5o7El/OjmTy/I/XW40z25vnyJRfDe180ji
         6GVsXBXQorbud91CxmGZV4Na3ft9TgYHHi3PIzLFlx+1OKjL2aphMwALvb3tTiabF6gN
         RcLnSJ1kAy9nybVb9TvGuxKDqFdxuiM/rg7UmqX4psrIvVxOh/VEnAWbQM1sqNEDW/7I
         NE+0X4K7taXlXnSSd2OIutuIRZWpiW0RJQIb1dvIHpfxxhxlUDtgoiAFSQcXkv+l8Ku2
         jtixuZhBORYm/NPQtNHLsPDs1p6hE3PPik4BqIPP0qxY/HZ/Ll0eVZEK9ZU9n64KkqKI
         TUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/6bF252QqnY12H7PjXHxtHVXzmjhuS4IY4ywpEiT3F4=;
        b=xVY1hx0hMiG8ClJtNB07Q7PRH/PlrG5L6gydPHuBwls4w6rbHTflZvBcq/qOE2Sarr
         /L0NtQi2SfduZ2/6kosXFImaVZ3eiA6eZgxghS6+cM3Fe67V2zgq5NQCd9ka8Qfkg94G
         lmSNVM7LUkaPUWUncXl2GE9qZuyBTkS5RpOXqFDYy3snj6liogHWmt9tRrV2EzKCkNsB
         dOs/tiswQiGgNlFYmGn4C4V5t9yvvCRXbJdtFbLnnynYMangd7W+/1NrC/bMp284JpiB
         I4IMkidM1QH9hPT49TnDePUeYz8pgxslVyjovJo9dlaUBDW+txcsIVeSXXo52YbhiKjA
         MU0Q==
X-Gm-Message-State: AOAM532FskcUS6a9cjEbWe9lc8DTcNMtKs58M6KUr6WXOt4FjkfVNo1D
        KMtcSd9iLM5XBm2MwlJ9ItcNgw==
X-Google-Smtp-Source: ABdhPJzEyHtkxoluS20SeKqiN/F4ipRlBq7hIPzS0/fxSKWetul7V//ubEQF1a5ctnVubF0wepHU3w==
X-Received: by 2002:a4a:d08d:0:b0:321:54c7:8fe0 with SMTP id i13-20020a4ad08d000000b0032154c78fe0mr6782448oor.10.1649451635561;
        Fri, 08 Apr 2022 14:00:35 -0700 (PDT)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id j126-20020acab984000000b002da77222b7dsm9160490oif.22.2022.04.08.14.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:00:34 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/msm/dpu: Issue MDSS reset during initialization
Date:   Fri,  8 Apr 2022 14:02:53 -0700
Message-Id: <20220408210253.581337-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408210253.581337-1-bjorn.andersson@linaro.org>
References: <20220408210253.581337-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's typical for the bootloader to bring up the display for showing a
boot splash or efi framebuffer. But in some cases the kernel driver ends
up only partially configuring (in particular) the DPU, which might
result in e.g. that two different data paths attempts to push data to
the interface - with resulting graphical artifacts.

Naturally the end goal would be to inherit the bootloader's
configuration and provide the user with a glitch free handover from the
boot configuration to a running DPU.

But as implementing seamless transition from the bootloader
configuration to the running OS will be a considerable effort, start by
simply resetting the entire MDSS to its power-on state, to avoid the
partial configuration.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- Move the reset before the probing of the children, to avoid issues if child
  drivers touched hardware at probe time.
- Extend reset assert time as the previous 1us showed reliability issues on
  Lenovo Flex 5G.

 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c | 32 ++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
index b10ca505f9ac..6f921910d0e0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
@@ -3,10 +3,12 @@
  * Copyright (c) 2018, The Linux Foundation
  */
 
+#include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqdesc.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/reset.h>
 #include "dpu_kms.h"
 
 #define to_dpu_mdss(x) container_of(x, struct dpu_mdss, base)
@@ -197,6 +199,32 @@ static void dpu_mdss_destroy(struct msm_mdss *mdss)
 	dpu_mdss->mmio = NULL;
 }
 
+static int dpu_mdss_reset(struct device *dev)
+{
+	struct reset_control *reset;
+
+	reset = reset_control_get_optional_exclusive(dev, NULL);
+	if (!reset) {
+		/* Optional reset not specified */
+		return 0;
+	} else if (IS_ERR(reset)) {
+		DPU_ERROR("failed to acquire mdss reset, ret=%ld", PTR_ERR(reset));
+		return PTR_ERR(reset);
+	}
+
+	reset_control_assert(reset);
+	/*
+	 * Tests indicate that reset has to be held for some period of time,
+	 * make it one frame in a typical system
+	 */
+	msleep(20);
+	reset_control_deassert(reset);
+
+	reset_control_put(reset);
+
+	return 0;
+}
+
 static const struct msm_mdss_funcs mdss_funcs = {
 	.enable	= dpu_mdss_enable,
 	.disable = dpu_mdss_disable,
@@ -210,6 +238,10 @@ int dpu_mdss_init(struct platform_device *pdev)
 	int ret;
 	int irq;
 
+	ret = dpu_mdss_reset(&pdev->dev);
+	if (ret)
+		return ret;
+
 	dpu_mdss = devm_kzalloc(&pdev->dev, sizeof(*dpu_mdss), GFP_KERNEL);
 	if (!dpu_mdss)
 		return -ENOMEM;
-- 
2.35.1

