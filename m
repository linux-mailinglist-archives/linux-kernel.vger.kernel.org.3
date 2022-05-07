Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8C951E6ED
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 14:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384768AbiEGMe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 08:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384695AbiEGMey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 08:34:54 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862BE10FE4
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 05:31:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id m20so18877581ejj.10
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 05:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VbilywkyD/M8bgsQ+Goos9KyMxX3bX3Ox36YlxJ8d/c=;
        b=jSWuncNAiU0XkPaOT1H89zBzD0IQbe9EpFSJVAJNDrfrhJ475C3/F1a3IRUpkfdmfl
         z5FYvQB3AxePJWNCui/KXqmyoKXJvtMUI3YmIK3SI/XfbdKwbALc15eOsfve/uT1hAV5
         KrV5JwXSKPUIr6C9cB0qe+O8iSfy6eiSlf7p6ihESMr7M1iGsnLs0ze8PAOL35nKHjCi
         TrulnuUgvOH98Ktl1Y+5P9gLjG69IA+KtlBrubuLth9BWu3HNiuqdsoC70GxoAqZ6bux
         Ew2//PR/5ufgtbHfTK62Pagl53ORU3lyO6MqepZsTijkUelvniZTwsuIS3MPFNeP7YNz
         Du8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VbilywkyD/M8bgsQ+Goos9KyMxX3bX3Ox36YlxJ8d/c=;
        b=zq77+Fc3TwSykY7LmIRF4fNEAv5DVqeLnsbHH5b6pVura2kXm8oEX4ydkPyKglW2ID
         Vgym0uqGwaSADztg+52gi/KmWXS0ZTfbw2a22lP3xaDZvBCRNBuBdlJkqbNltIkhmKYs
         cq28OlWPA8d1oHPWJXSIFDCkwJPjDdGc6B6ZH8vu0kSTEH7lsRyHZ+0c5PQhpZq0UgHG
         j+mIHmiGFUg+F8Pkg4Zctm81OsZPaflHteTMBXsa+1JC4JhRdZlhsnNSHyy0RZFjuKCi
         035JGbQN8rJIert0SI4CMMtrOf/G50ITbUvzzgyMwZ89DjssJHOlV6BQDnwKjXygXGK0
         DgIQ==
X-Gm-Message-State: AOAM531L6GUuwxTsH9LGxeQXT05jorzTYdQE46ejLEdfX1/XMBFV9SxQ
        A3lzg3S2+K/acSt3u4jXIks=
X-Google-Smtp-Source: ABdhPJwgi2oAExzw1tYk1Mg5zfE640UsZvBoS4IF5pYyh1DxuoHxiAg8VieZVSJo8xU8ihZXToPuwA==
X-Received: by 2002:a17:907:7e9f:b0:6f6:e9ce:9939 with SMTP id qb31-20020a1709077e9f00b006f6e9ce9939mr4108603ejc.456.1651926665959;
        Sat, 07 May 2022 05:31:05 -0700 (PDT)
Received: from pca.lan (ptr-dc5856ogfk7hh0p2zet.18120a2.ip6.access.telenet.be. [2a02:1811:bc80:f7f0:311d:17d5:927c:28c5])
        by smtp.gmail.com with ESMTPSA id d23-20020aa7d697000000b0042617ba63absm3468466edr.53.2022.05.07.05.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 05:31:05 -0700 (PDT)
From:   Pieterjan Camerlynck <pieterjan.camerlynck@gmail.com>
To:     shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Pieterjan Camerlynck <pieterjan.camerlynck@gmail.com>
Subject: [PATCH] ASoC: fsl_sai: fix incorrect mclk number in error message
Date:   Sat,  7 May 2022 14:31:01 +0200
Message-Id: <20220507123101.10938-1-pieterjan.camerlynck@gmail.com>
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

In commit <c3ecef21c3f26> ("ASoC: fsl_sai: add sai master mode support")
the loop was changed to start iterating from 1 instead of 0. The error
message however was not updated, reporting the wrong clock to the user.

Signed-off-by: Pieterjan Camerlynck <pieterjan.camerlynck@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index ffc24afb5a7a..f0602077b385 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1054,7 +1054,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		sai->mclk_clk[i] = devm_clk_get(&pdev->dev, tmp);
 		if (IS_ERR(sai->mclk_clk[i])) {
 			dev_err(&pdev->dev, "failed to get mclk%d clock: %ld\n",
-					i + 1, PTR_ERR(sai->mclk_clk[i]));
+					i, PTR_ERR(sai->mclk_clk[i]));
 			sai->mclk_clk[i] = NULL;
 		}
 	}
-- 
2.25.1

