Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165D74A62E4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241705AbiBARr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241747AbiBARru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:47:50 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A6FC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 09:47:50 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u15so33549581wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 09:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7TPcuWXxFU6hWv6NeLAOie1udRWkhLJ1DWe5t2FsQ+M=;
        b=NuDwlgu6ILp+04FQNgBAsUPzgY4AJ4bWp5fA+81vgbrR5oDX2XCAO6zFTyz1N6KBkU
         1kdQkH85xpE2ggU6G7YOsyHHkTToqT8hEBjk5z4lr12RD7yj4VqBh0sdrZL5PnVifknW
         4Yd8p3bHKpvTFcIiHl+wEjbshC1kHaYl4TwJhUINoU5P7+NT6/c0K3F2jcQT7LSNe9yy
         FaXvEgb0ZLMnKx8Bk9pyEz77Z7+wYBdKtsrkqcuuKGXhgjKJySsryv8ltvb/6sadloTy
         UzkbJtcaH9lrLMA/LhpmdFsKm7icqg8TsZuhhQDF0expi5wKdSPQ3x9ySEnfmKNh7Pkn
         ccBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7TPcuWXxFU6hWv6NeLAOie1udRWkhLJ1DWe5t2FsQ+M=;
        b=WqixQdAHfM6MYvF9949/whJQHSiV4Upa5d+xI53F1NeTOpRhoV9rJAcSfnGVM3su8U
         acs4MSpiqXULKnN4e79uOIWVoqCqohUBgClg2oghiJLeobQGF8cEayGRLKGPLLtXn7jq
         V38g49/kJ/wTCZHl8rXnVBaxetkY0d+GflN7GTQTFy9NiI7VkEbCyQ0k12dS90OyRu7k
         Br0HtvIP5RhYX1Wr/n2Jgqwr8+utl89yfuHCq/iKva/WTWcrDew21RoRoVLV5TphD4G+
         4dhVwcTGyVauxz4m4YXbEKXI2bQfkfoNMpTsivG0ASbESMH2wCEe1ZnWiBMjpgogubdY
         jrDA==
X-Gm-Message-State: AOAM530M7et9sLwMR353TKw+EVOwutkHVtn9n/HcyAGnA5tgnTBp13d4
        jiswmqr5AjaU2omjwyfsRX6vMw==
X-Google-Smtp-Source: ABdhPJwDJNj1YVlHWPoJ293olzLjFEIQcMbpGy6i0JMKcmYgnDUgr1EqX8iuwkgOa1W/rpbnq/zJPg==
X-Received: by 2002:a05:6000:1548:: with SMTP id 8mr21586066wry.504.1643737668657;
        Tue, 01 Feb 2022 09:47:48 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id r2sm3392332wmq.24.2022.02.01.09.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 09:47:48 -0800 (PST)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/msm/hdmi: Remove spurious IRQF_ONESHOT flag
Date:   Tue,  1 Feb 2022 17:47:33 +0000
Message-Id: <20220201174734.196718-3-daniel.thompson@linaro.org>
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
which it to disable the forced threading of irqs. For "normal" kernels
if there is no thread_fn then IRQF_ONESHOT is a nop.

In this case disabling forced threading is not appropriate because the
driver calls wake_up_all() (via msm_hdmi_i2c_irq) and also directly uses
the regular spinlock API for locking (in msm_hdmi_hdcp_irq() ). Neither
of these APIs can be called from no-thread interrupt handlers on
PREEMPT_RT systems.

Fix this by removing IRQF_ONESHOT.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 719720709e9e7..e167817b42958 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -306,7 +306,7 @@ int msm_hdmi_modeset_init(struct hdmi *hdmi,
 	}
 
 	ret = devm_request_irq(&pdev->dev, hdmi->irq,
-			msm_hdmi_irq, IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+			msm_hdmi_irq, IRQF_TRIGGER_HIGH,
 			"hdmi_isr", hdmi);
 	if (ret < 0) {
 		DRM_DEV_ERROR(dev->dev, "failed to request IRQ%u: %d\n",
-- 
2.34.1

