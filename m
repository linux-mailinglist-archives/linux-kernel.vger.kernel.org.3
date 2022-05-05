Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A4B51B5BA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbiEECVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237927AbiEECVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:21:15 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5324A483B3
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:17:38 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n18so3119115plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 19:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F2nk/ssfCB0vTWyS6vaFNqXTpQUVylAvicTxU2kBcY8=;
        b=GC3/Rj8Izk85qe05Uvsum7tPpxVZtjLFcopo+A3fa8s/5loDut8y7iWCNEvjQme2WX
         EnmOc60vVyj8KiLzODlQ6vIc4N7UR5ztYnrnKC9I8VbRAiJLxxdpXtLE606l781T9l20
         5ecROuPBCMlPt4JR4HtdNs0QLHYVKSVgVoXNGT04VLTisI7byfTH4z95mpUs4rapUc9Q
         7aVMqa30ajkIpZ0g8BWQ7GjsJw8TipMOzn8T31rxkIqUD9anJ4X5bjAEbEiwRXyCq0Na
         azH+2woprSkwLESH9c3T2/k+xULIgJgKTh82lSDmEPV4jrXQzQ/iYZ6OFAaITkSOCqnk
         O+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F2nk/ssfCB0vTWyS6vaFNqXTpQUVylAvicTxU2kBcY8=;
        b=mI/D581KYhQO9YvKXDMV493nKbwved8/xLA3YeNyiuFySRnFGgKvksRQa1M4g7MUFw
         vbgyOtuxdNowttffvz7Wy29jL4/bdcbuCqFcXQz6CbfwSO2d75yZZGamSC7mvy62bCbo
         9VdMopVzqUE1tEfvzJ7dvgAvUOItMkNBJJg3yWZQ6Fxl+ixKnXquEauSHmXZGfQoxh39
         u8I1iur833asme+7wfwldqwFV1VWuBbQEmL5fq1ihtvGuroiVJNHEMggK3YRd1TNQ5Ql
         auozLFF47m1fzET3usIi1YuQhKYN6N8F9mY5Si3A3vYNIcg8LJ8e3iELwOGHBqEqWM8j
         CsxQ==
X-Gm-Message-State: AOAM533GWH/Ekv6LeYNr0ajLkGGV2Cir7ztXe5FSHLJY7XRxuxCp29VP
        zyU62eTu0cqgV3+uGiMcFN4=
X-Google-Smtp-Source: ABdhPJxIK9x8R05f9RBILPM4SBRiuoNiqtGSovQy5pR4hh+ZgLz2hy5Ac/8ilHaiMumxaeKAEigllw==
X-Received: by 2002:a17:902:bf45:b0:15c:df47:3d6 with SMTP id u5-20020a170902bf4500b0015cdf4703d6mr24385071pls.58.1651717057904;
        Wed, 04 May 2022 19:17:37 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f19-20020a63dc53000000b003c14af50631sm60468pgj.73.2022.05.04.19.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 19:17:37 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ASoC: uniphier: simplify the return expression of uniphier_aio_compr_set_params()
Date:   Thu,  5 May 2022 02:17:33 +0000
Message-Id: <20220505021733.54275-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 sound/soc/uniphier/aio-compress.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/uniphier/aio-compress.c b/sound/soc/uniphier/aio-compress.c
index 0f76bc601ca9..7d1492c15b57 100644
--- a/sound/soc/uniphier/aio-compress.c
+++ b/sound/soc/uniphier/aio-compress.c
@@ -139,7 +139,6 @@ static int uniphier_aio_compr_set_params(struct snd_soc_component *component,
 	struct uniphier_aio *aio = uniphier_priv(asoc_rtd_to_cpu(rtd, 0));
 	struct uniphier_aio_sub *sub = &aio->sub[cstream->direction];
 	struct device *dev = &aio->chip->pdev->dev;
-	int ret;
 
 	if (params->codec.id != SND_AUDIOCODEC_IEC61937) {
 		dev_err(dev, "Codec ID is not supported(%d)\n",
@@ -161,11 +160,7 @@ static int uniphier_aio_compr_set_params(struct snd_soc_component *component,
 	aio_port_reset(sub);
 	aio_src_reset(sub);
 
-	ret = uniphier_aio_compr_prepare(component, cstream);
-	if (ret)
-		return ret;
-
-	return 0;
+	return uniphier_aio_compr_prepare(component, cstream);
 }
 
 static int uniphier_aio_compr_hw_free(struct snd_soc_component *component,
-- 
2.25.1


