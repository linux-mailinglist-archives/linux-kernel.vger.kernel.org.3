Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BED4F11AB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349735AbiDDJKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349554AbiDDJJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:09:56 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C713BA61
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 02:07:59 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b15so8372575pfm.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 02:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=c4R3JJ+tk9qsvcjavAHFJ5wC1KGmyFCCYT/LvM1hEqY=;
        b=Ls68uvoOUR/HvzGT3MRTxlpWthdhU3tUNF4aOjl3xdUp65uTfi76PUS5jI+dbUcdaE
         cLqp5xrLy8rSPsGcnMlgnpN4FGY87jpzjfwKBcoSpAIvp8077bk/dLMbdcPZNmlgU3YJ
         Gy7EHuqAPdmftELz1JUVT39LOb58ukBenvxVttHwsiBVBpdl0y+q+lVu3fz0jWtIyvn8
         3bewdHaw5karz0Xr984lJIj29A0n0qfwxZP+QOVKOCndJIgBoPDAyJ2YchI81zG3j1Rr
         0NIMD9rUBcoFYrsQJwFKPMHEHBp0rC0m/6x96Vp2X02CYlNN4hSO8FqhDsL3flxSfPUR
         RRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=c4R3JJ+tk9qsvcjavAHFJ5wC1KGmyFCCYT/LvM1hEqY=;
        b=tUqMzsLdc+74TKbshbgvUU+DVCeGiieULW/Ha+vrf4JEu4pBBeQOCPBzrQEQo+Mciy
         TOghjyMpkwFJqOercHdTC+vMwRERuz32fgEz6eY76Ji2yDkbPIVi5gMK+jGVk5sEbe11
         xgav8O8dAnGcZPCoDgn2KZ98SBrOPiN61FSOdJd+fAH0QOjsMZRlPBQjjywHwHVHIc+e
         SpIrZ22FHlNV0SmxNW2uHy4vasq6jMEqMcB7u7CF2POA7gECCwM8dWqGMpIDYy8q2CHL
         ELLot/VVGB6vFSBEvLwhE/AxeXOYeuS506rXrWOgaUGbNTgFBv8bXKhXlkYb7VoRtSzo
         2Xvw==
X-Gm-Message-State: AOAM533xRzvfF2a5uG2oY8oBTBKibYul28oj2i7BWlGlJ5ULSC12wgd+
        H39xET27clCaTPwYHpSyWpxm5s5gFpXkHug7
X-Google-Smtp-Source: ABdhPJwG/xqzf7aCqAccqVqlycrMHQinGLZjwncodMQzeZKwvCOhlCagKN8TZY2f/EDfyzitWZjPmA==
X-Received: by 2002:a63:f515:0:b0:384:1f78:34b0 with SMTP id w21-20020a63f515000000b003841f7834b0mr24941626pgh.67.1649063279411;
        Mon, 04 Apr 2022 02:07:59 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056a001a8c00b004fab88d7de8sm11299922pfv.132.2022.04.04.02.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 02:07:59 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Colin Ian King <colin.king@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rk817: Use devm_clk_get() in rk817_platform_probe
Date:   Mon,  4 Apr 2022 09:07:46 +0000
Message-Id: <20220404090753.17940-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to call clk_put() to undo clk_get() in the error path.
Use devm_clk_get() to obtain a reference to the clock, It has
the benefit that clk_put() is no longer required.

Fixes: 0d6a04da9b25 ("ASoC: Add Rockchip rk817 audio CODEC support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/codecs/rk817_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rk817_codec.c b/sound/soc/codecs/rk817_codec.c
index 8fffe378618d..cce6f4e7992f 100644
--- a/sound/soc/codecs/rk817_codec.c
+++ b/sound/soc/codecs/rk817_codec.c
@@ -489,7 +489,7 @@ static int rk817_platform_probe(struct platform_device *pdev)
 
 	rk817_codec_parse_dt_property(&pdev->dev, rk817_codec_data);
 
-	rk817_codec_data->mclk = clk_get(pdev->dev.parent, "mclk");
+	rk817_codec_data->mclk = devm_clk_get(pdev->dev.parent, "mclk");
 	if (IS_ERR(rk817_codec_data->mclk)) {
 		dev_dbg(&pdev->dev, "Unable to get mclk\n");
 		ret = -ENXIO;
-- 
2.17.1

