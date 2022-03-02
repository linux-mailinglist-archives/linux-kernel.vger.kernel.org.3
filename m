Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4623B4C9A67
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 02:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbiCBB23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 20:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbiCBB2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 20:28:24 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7223B019
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 17:27:40 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id s5so424856oic.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 17:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tv+YgwvAaGuJMMXzyf8UKPqJBKWn/rWVKPq429RSyAw=;
        b=x3LtYqtKWT+YwkG6aAomkFJqE6JU/MeXuxpFJ2KtyAYFGYKoKOeI40r8rnf/ayswII
         E47xrummwGUAXr1NOPjw4BOQY0pDjWlpO58zJuELtiacrBW/iJFYzzd9s1X5t5EM11q1
         09kpz+lXNSepjtrEr3XjDD5D7usBJ7ZJOKN/ttIZC0AzyNoVFcM7YRhBWsB4dZOASqg5
         T/bdPwwM3Nw8IhMqH9O7rYIvI4y02rvoj7RAZFy2pWkTf6rWbQRQvIs5ltlBMzMAYmcm
         uX/hyel18lnuhsEddrvP0SUcJBP+3lZ/gAsd5DZtrCLGAaDhjlr9tUQ1U7TqWPd1LDjH
         z1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tv+YgwvAaGuJMMXzyf8UKPqJBKWn/rWVKPq429RSyAw=;
        b=nkChftCLDccr97z7hhHbc9YjY3pwk/Pfduz5mtpRQ3TUC51b/Gu6IK8DcA38sf84rT
         56hPgX2iffe83wTqRf4sYH8Usqx/vQwZLW0a4dn1l+rMOLC94dXyiiNiPG4TVJWmQ7MB
         /5EJj0UIGbVhn++TdP7FB3JB3CyU0IhNmHB6LN2HNXyup31dsFxs62d4jT6ykn6pQfTI
         AUOiNFayeflC6i83Lhls1pVTsWOF878mFF1zGFw4SWjZqRVR5MMK1yYzf5r6Ju0bvMNr
         frP63fqpo/4YpP853m6sRSVpBZ8kIoy645fmvWzohwgPHDmGgCSZT+AHe8AX4zwYJtWX
         Qm5g==
X-Gm-Message-State: AOAM530tYXJ1Yl05EG075AkPpig/tUjJBV1pJljhDZ0rmblO4Yxbl/nr
        kIWnyz4CvEzXJriNGRwpMB6gog==
X-Google-Smtp-Source: ABdhPJw1w163ZojylGuWVadLsX0xJp3N7FA4hCgFYCgLBgnY+wNU4byJA3FAoTr+v9eYoM7s9CYlaQ==
X-Received: by 2002:a05:6808:e89:b0:2cf:cad3:e427 with SMTP id k9-20020a0568080e8900b002cfcad3e427mr15963208oil.20.1646184460000;
        Tue, 01 Mar 2022 17:27:40 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id t9-20020a056871054900b000c53354f98esm6728948oal.13.2022.03.01.17.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 17:27:39 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/msm/dpu: Issue MDSS reset during initialization
Date:   Tue,  1 Mar 2022 17:29:31 -0800
Message-Id: <20220302012931.4107196-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220302012931.4107196-1-bjorn.andersson@linaro.org>
References: <20220302012931.4107196-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes since v1:
- Rather than trying to deconfigure individual pieces of the DPU, reset the
  entire block.

 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c | 18 ++++++++++++++++++
 drivers/gpu/drm/msm/msm_drv.c            |  4 ++++
 drivers/gpu/drm/msm/msm_kms.h            |  1 +
 3 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
index b10ca505f9ac..419eaaefe606 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
@@ -7,6 +7,7 @@
 #include <linux/irqchip.h>
 #include <linux/irqdesc.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/reset.h>
 #include "dpu_kms.h"
 
 #define to_dpu_mdss(x) container_of(x, struct dpu_mdss, base)
@@ -31,6 +32,7 @@ struct dpu_mdss {
 	void __iomem *mmio;
 	struct clk_bulk_data *clocks;
 	size_t num_clocks;
+	struct reset_control *reset;
 	struct dpu_irq_controller irq_controller;
 };
 
@@ -197,10 +199,18 @@ static void dpu_mdss_destroy(struct msm_mdss *mdss)
 	dpu_mdss->mmio = NULL;
 }
 
+static int dpu_mdss_reset(struct msm_mdss *mdss)
+{
+	struct dpu_mdss *dpu_mdss = to_dpu_mdss(mdss);
+
+	return reset_control_reset(dpu_mdss->reset);
+}
+
 static const struct msm_mdss_funcs mdss_funcs = {
 	.enable	= dpu_mdss_enable,
 	.disable = dpu_mdss_disable,
 	.destroy = dpu_mdss_destroy,
+	.reset = dpu_mdss_reset,
 };
 
 int dpu_mdss_init(struct platform_device *pdev)
@@ -227,6 +237,13 @@ int dpu_mdss_init(struct platform_device *pdev)
 	}
 	dpu_mdss->num_clocks = ret;
 
+	dpu_mdss->reset = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(dpu_mdss->reset)) {
+		ret = PTR_ERR(dpu_mdss->reset);
+		DPU_ERROR("failed to acquire mdss reset, ret=%d", ret);
+		goto reset_parse_err;
+	}
+
 	dpu_mdss->base.dev = &pdev->dev;
 	dpu_mdss->base.funcs = &mdss_funcs;
 
@@ -252,6 +269,7 @@ int dpu_mdss_init(struct platform_device *pdev)
 irq_error:
 	_dpu_mdss_irq_domain_fini(dpu_mdss);
 irq_domain_error:
+reset_parse_err:
 clk_parse_err:
 	if (dpu_mdss->mmio)
 		devm_iounmap(&pdev->dev, dpu_mdss->mmio);
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 129fa841ac22..7595f83da3f1 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -388,6 +388,10 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 	if (ret)
 		return ret;
 
+	/* Issue a reset of the entire MDSS */
+	if (priv->mdss && priv->mdss->funcs->reset)
+		priv->mdss->funcs->reset(priv->mdss);
+
 	/* Bind all our sub-components: */
 	ret = component_bind_all(dev, ddev);
 	if (ret)
diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
index 2a4f0526cb98..716a34fca1cd 100644
--- a/drivers/gpu/drm/msm/msm_kms.h
+++ b/drivers/gpu/drm/msm/msm_kms.h
@@ -205,6 +205,7 @@ struct msm_mdss_funcs {
 	int (*enable)(struct msm_mdss *mdss);
 	int (*disable)(struct msm_mdss *mdss);
 	void (*destroy)(struct msm_mdss *mdss);
+	int (*reset)(struct msm_mdss *mdss);
 };
 
 struct msm_mdss {
-- 
2.33.1

