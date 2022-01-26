Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744D649C8BF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240799AbiAZLgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240790AbiAZLgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:36:04 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F040C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:36:04 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n8so27440237wmk.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wTvnkKEb+4UL86WLI4y9ZHDzYIRRSQJF903Pn2y7+HU=;
        b=jte/6bj9Lu4Bn2k+uHE6Nlb3BHk5VedwUaNZG2hSiwCE7TR4bBfsTigqHAcN3aXB1Q
         3dgOb9H4cRMzlz9RYKQWB9+xtrcxyz/kWLe/9yrdAD3gEcPnR8eKaF4UbzvipPkBdCfW
         pCoYATosVlFVnGSArIihhOrsDJFkYvI7ZxCgMs5m899RVlIJM++jFILUgkLX82FYA0O+
         6xZqTmsmGEV6PMGTX5lziQUM/jYrg6g7+3U72oFv8wtKruHpslTaroqVL6847EWsBxP8
         XblL5KZKFVBkJb8SvhZgxL8hYjK9WMrd7ugCzgR0swA+c+zg6TBvc35nE6BA+FF6SGZM
         vt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wTvnkKEb+4UL86WLI4y9ZHDzYIRRSQJF903Pn2y7+HU=;
        b=LaK+H8N/FM7gffbWnWl0hHSj5LlB+bfYEIgOrcmA3LAeRHw/pl9o2C2zEDhVtM8WOO
         03yO4w1e4qykaRtQKgKJMcUkAdcWtwB3T5Uod1eGgQra7spk+KWqa5zitloOUL30DK3T
         XdglmNSe7zpfzWDVl98bdCJ/P7iRJU0kZR1JkjdETl9xQSmjp3DgD2VJr+tcWMgBBEPM
         riVpbmgR0bC9RTgQ/RjkzfgQOBJNOBHA2av/xDB2MiGv3WGfBc+BYNeTwq/uRfL6RN8e
         7H2x3l7VOruFXkkc0+AfIQjpsWCjySD1xEz49frYG0YLnMByJvLQnKh50GWzruoVyRAM
         mrjA==
X-Gm-Message-State: AOAM533vep9kTdWofw6MZvn2u49F6ekVU2DqGD2gM/XoP7Er5+A1P7LA
        YrglUJBNWQQ+aOTvIROQo88k0Q==
X-Google-Smtp-Source: ABdhPJxNol80N6KgPVyzOBjJcP+P3qPnV0rBGrzx5NQUKiryTqB/K9m2g9NoTimj/hv+KNyRbSBHhw==
X-Received: by 2002:a7b:cd14:: with SMTP id f20mr7156768wmj.110.1643196962831;
        Wed, 26 Jan 2022 03:36:02 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n14sm11999188wri.75.2022.01.26.03.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 03:36:02 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4]  ASoC: qdsp6: q6apm-dai: only stop graphs that are started
Date:   Wed, 26 Jan 2022 11:35:49 +0000
Message-Id: <20220126113549.8853-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220126113549.8853-1-srinivas.kandagatla@linaro.org>
References: <20220126113549.8853-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Its possible that the sound card is just opened and closed without actually
playing stream, ex: if the audio file itself is missing.

Even in such cases we do call stop on graphs that are not yet started.
DSP can throw errors in such cases, so add a check to see if the graph
was started before stopping it.

Fixes: 9b4fe0f1cd79 ("ASoC: qdsp6: audioreach: add q6apm-dai support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index eb1c3aec479b..19c4a90ec1ea 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -308,8 +308,11 @@ static int q6apm_dai_close(struct snd_soc_component *component,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct q6apm_dai_rtd *prtd = runtime->private_data;
 
-	q6apm_graph_stop(prtd->graph);
-	q6apm_unmap_memory_regions(prtd->graph, substream->stream);
+	if (prtd->state) { /* only stop graph that is started */
+		q6apm_graph_stop(prtd->graph);
+		q6apm_unmap_memory_regions(prtd->graph, substream->stream);
+	}
+
 	q6apm_graph_close(prtd->graph);
 	prtd->graph = NULL;
 	kfree(prtd);
-- 
2.21.0

