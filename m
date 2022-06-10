Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D0E5468CD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 16:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244709AbiFJOti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 10:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238613AbiFJOss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:48:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EC612FB09
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:48:24 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h5so36893912wrb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dASImwNQ4lKnjqAZylKMyljkWPUewrzG4+oBeRN/mDc=;
        b=G+cIdmS8P0uX6K17wjNEk8gIw4CPGyMbc1Vy7LEPlgztd6qDiUMW08DkEQjsDqbJ28
         LVWqoWg7nksaLKwJgJ5/xal4EvO21pdjfiHcl6eXcp9CrE7loaFrxmqV+VEZ7uaz6y+d
         hRC7gtUQJBkuFR2WlkHLh/JFwrxlg8xev2EosiExx/O2/GpSqz9cLih4hqpmrgXNRi1g
         fT34CbHd9lcn6kclIdpG5vnTHWyvXztwR4yc7x8QWVi7sPTd4sc8k/F1XfX/Om6uTiwG
         50zHG0fCLJ4vly4DUCC9V4/i94fkuMbvl7rv+I5D1NO70xmGEQ/OygcWXcSMGDqLQIe5
         9kMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dASImwNQ4lKnjqAZylKMyljkWPUewrzG4+oBeRN/mDc=;
        b=BG2gQNCQRQvNLUnQrbwDLyDneOkYuPnBgBNxya0Tb7lssUw7In6ohVeAoPPb/gTV+Q
         2pXR8JYQyE0ybRII+j36PrvTTvxLt62kHZVMk0zTiTRRTqGTUVxW3nSJRtN7Eazr9krZ
         qTmXPESoHduL9OLfAjP3ATYeuxx39EoMIQtOrs50i5d/0EQzTaMDFiKbfMDb+hZLES2o
         Z76BxQAd0vKWncFYzFPrA010I+3rki8qVuF/3x3XoIw8RTu1+DSFF6zJCRxtdFlWnTJI
         z2ZZTUPAA5bw8W1OsCCeTZxFWXZ+f6VVozI1U++ExoUlPGTbE18kZIACwToyMN96NtQ8
         6Rvg==
X-Gm-Message-State: AOAM531/mO0zhiEXqxqrpZivMnCKoYknxERPb7wmQirTFKjMAHvdYveV
        ExXf6xBcEKEwjYBs2UvLXis1WQ==
X-Google-Smtp-Source: ABdhPJwwor12U+NJ1Y3A97V4xBrTDNSS2pCfrcUD+2ZelNq8m/l02RTsCwtRkBE0U0SK1UFNnjqSvw==
X-Received: by 2002:a05:6000:1567:b0:217:abea:6a67 with SMTP id 7-20020a056000156700b00217abea6a67mr31203490wrz.305.1654872502733;
        Fri, 10 Jun 2022 07:48:22 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id bp3-20020a5d5a83000000b0020cff559b1dsm27212085wrb.47.2022.06.10.07.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 07:48:21 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH] ASoC: qdsp6: q6apm-dai: unprepare stream if its already prepared
Date:   Fri, 10 Jun 2022 15:48:18 +0100
Message-Id: <20220610144818.511797-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
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

prepare callback can be called multiple times, so unprepare the stream
if its already prepared.

Without this DSP is not happy to setting the params on a already
prepared graph.

Fixes: 9b4fe0f1cd79 ("ASoC: qdsp6: audioreach: add q6apm-dai support")
Reported-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 19c4a90ec1ea..ee59ef36b85a 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -147,6 +147,12 @@ static int q6apm_dai_prepare(struct snd_soc_component *component,
 	cfg.num_channels = runtime->channels;
 	cfg.bit_width = prtd->bits_per_sample;
 
+	if (prtd->state) {
+		/* clear the previous setup if any  */
+		q6apm_graph_stop(prtd->graph);
+		q6apm_unmap_memory_regions(prtd->graph, substream->stream);
+	}
+
 	prtd->pcm_count = snd_pcm_lib_period_bytes(substream);
 	prtd->pos = 0;
 	/* rate and channels are sent to audio driver */
-- 
2.25.1

