Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59C3591972
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 10:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbiHMIeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 04:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMIee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 04:34:34 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10CF6B664
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 01:34:33 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id tl27so5537797ejc.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 01:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=giMh6CV+ebQaMfil4WhC+L/0OniXZ48oEVWUpwWfMDs=;
        b=CKPeBNjSUoVfcYjf2H0tn6lNfb4WCfH+qcPtLe20kpAf1XSdq1ou13nbDylclZhgD6
         ki1V4f57v8AcfC4HPm7ZSkxfJfiHWfJFaxLzddNKM1YCsQQ0y2mKWNZdL8ixvJ6KD4J8
         FSylg13oxehSO15OyPeLWb7mTRuYpAAL3frMeLcLMGJVoAOwPze667o7nEn1k72/buOx
         BvmU9/stXwcHbfLUgxAW0GOsurGBjg3rXdRIeOfzxj0myq77l9NwosfecMYTlrV3UrZb
         UWcBO43HL3uWb/tUnXCuMy3NlC3B6+MmLoOxACezPUAOC61q0OW8TsrAAXKYtdcVAUr6
         wbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=giMh6CV+ebQaMfil4WhC+L/0OniXZ48oEVWUpwWfMDs=;
        b=SbfdsGi1HojZD+bWjkgneHDvI1aFupMPnQzg2w9uS0wQzGx0L6y0Nm3nKoEqOpd99G
         SWPCI6lSirYANkULSXe800RzHlS+q5KfXHmOrycQ6xvPQCuQpWqYES85Q1NtySD1wa1c
         Jpd3hhjwjta/vWSh6ecPwH3iMv4OLjzTO13OCEAZruLd3thJdXwDmnfxAPaIwwGAnf+C
         zhwG/X5X6jbrA+OkKWlbuKcBnVUgM83LQ/e/Gb+Kcg+Mj21Ba99rTipTcH0qb7FhmylN
         oXRHX74ckNZ06S5d6GJBb8hJwu2uA8SyOklkVVbN9muY0ZpRz9NuOs9zLcjcoNgQOt06
         xgEA==
X-Gm-Message-State: ACgBeo1MVpEjG6NvKLj0lgbI4j+8R/46SsptMC8yyqQAPGCpW4xIG0FK
        YzODBnEA8vSk4wVBjjrELw0=
X-Google-Smtp-Source: AA6agR5/50LsvrEBmEVylqJMNR6BNXGjnKBGmDDXPFCJ/to2MC9nIENXqMl7u4Pw4kWk29w7Fk5NdQ==
X-Received: by 2002:a17:907:e94:b0:730:af21:cf60 with SMTP id ho20-20020a1709070e9400b00730af21cf60mr4639547ejc.681.1660379672269;
        Sat, 13 Aug 2022 01:34:32 -0700 (PDT)
Received: from pca.lan (ptr-dc5856nwo1xazteick5.18120a2.ip6.access.telenet.be. [2a02:1811:bc80:f7f0:d03:1d8d:20cb:2215])
        by smtp.gmail.com with ESMTPSA id u26-20020aa7d55a000000b0042de3d661d2sm2718172edr.1.2022.08.13.01.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 01:34:31 -0700 (PDT)
From:   Pieterjan Camerlynck <pieterjan.camerlynck@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Pieterjan Camerlynck <pieterjan.camerlynck@gmail.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: fsl_sai: fix incorrect mclk number in error message
Date:   Sat, 13 Aug 2022 10:33:52 +0200
Message-Id: <20220813083353.8959-1-pieterjan.camerlynck@gmail.com>
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

In commit c3ecef21c3f26 ("ASoC: fsl_sai: add sai master mode support")
the loop was changed to start iterating from 1 instead of 0. The error
message however was not updated, reporting the wrong clock to the user.

Signed-off-by: Pieterjan Camerlynck <pieterjan.camerlynck@gmail.com>
---
V2: rebase against latest version
---
 sound/soc/fsl/fsl_sai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 7523bb944b21..d430eece1d6b 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1306,7 +1306,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		sai->mclk_clk[i] = devm_clk_get(dev, tmp);
 		if (IS_ERR(sai->mclk_clk[i])) {
 			dev_err(dev, "failed to get mclk%d clock: %ld\n",
-					i + 1, PTR_ERR(sai->mclk_clk[i]));
+					i, PTR_ERR(sai->mclk_clk[i]));
 			sai->mclk_clk[i] = NULL;
 		}
 	}
-- 
2.25.1

