Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CA34F0926
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 13:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbiDCLyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 07:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiDCLyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 07:54:39 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C563C2717D
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 04:52:45 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y10so6475623pfa.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 04:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=sR5C+V0BrLQBvN4cusDa5moM4/Z0FLGEO0DiyFna108=;
        b=Ee9rnOJhOBjbwfUSmVUZIZfOs5YVvsbxIvZdyUKIdR3l3FHoadRLpLaEPPQikn9aGS
         QAVB3GDAeU4bYDihcUQh3U619pl56DdpqOWgDKWnxJU5BOpBIq0Hn9NZH25OEpJ+kEIA
         jjbpr/qAV+Vhxb3Uy/IdWyuLyevXlGQsMkRGYeBtsu8lHcVvjN2gEX/iFunRkImPZ7xq
         GVB6Eng8EqQ1jI2R0JG9S3JZVhj09A8EXXVQKTNaCtDMfPvzThbv9syAWoQhO7/FtgHt
         BS3WKNZQRTt5hmf1tjc2Pipfx90evF7PZbrW9dIvxCizxDTkM2SBB1tomOQ+j88E7w6G
         Jn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sR5C+V0BrLQBvN4cusDa5moM4/Z0FLGEO0DiyFna108=;
        b=hmUW33PhFS0FtMIi2SFG4tLcaq3DmJVMlIA41OybB0njVuyh6dNOIm8XGBHKnz195f
         yR010rx35Qsc8RRYc6I7FyPDF1krzhRk9z1qy4pjDm87zBD3FqkijuGa5vOjbYQzitPE
         oC4iS+EzZPTyuaZ5dfkaZzz9bNBiRDxET6ucwjiHkV9GdrIhiR1rluxzLFdlFAriMCzE
         uB8w6W/KxrmNTlaJ8iMsYCCMj7PuRMHmBARbfkQhcqa1eVt2Kpb7Mh3QA0U/ezrdIZ7P
         +iMa73PCM/ZJTNKwJ9/idzQfD4a7DGouIwBsZ3NcdbAzStyGrkvh5x9ec66tOxnMbj/P
         uSog==
X-Gm-Message-State: AOAM533Omv6Qnsxg1FMYdB/OaafM2k8KIvcss30ZtZ2oswUEgWiugb9W
        F1AfDAT2txshFwp3ch++Mqo=
X-Google-Smtp-Source: ABdhPJxJpvKl7ZEMtIJIZuVzN0aHjDDFf0Pkq8k5nYH6/FmT/Hogjjvq7L3y8TNkvFQMZ69xqIWeAw==
X-Received: by 2002:a62:cd83:0:b0:4fa:7410:6d86 with SMTP id o125-20020a62cd83000000b004fa74106d86mr53480921pfg.52.1648986765232;
        Sun, 03 Apr 2022 04:52:45 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id u18-20020a056a00125200b004fb112ee9b7sm8031095pfi.75.2022.04.03.04.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 04:52:44 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ASoC: msm8916-wcd-digital: Check failure for devm_snd_soc_register_component
Date:   Sun,  3 Apr 2022 11:52:39 +0000
Message-Id: <20220403115239.30140-1-linmq006@gmail.com>
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

devm_snd_soc_register_component() may fails, we should check the error
and do the corresponding error handling.

Fixes: 150db8c5afa1 ("ASoC: codecs: Add msm8916-wcd digital codec")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index 9ad7fc0baf07..20a07c92b2fc 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -1206,9 +1206,16 @@ static int msm8916_wcd_digital_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, priv);
 
-	return devm_snd_soc_register_component(dev, &msm8916_wcd_digital,
+	ret = devm_snd_soc_register_component(dev, &msm8916_wcd_digital,
 				      msm8916_wcd_digital_dai,
 				      ARRAY_SIZE(msm8916_wcd_digital_dai));
+	if (ret)
+		goto err_mclk;
+
+	return 0;
+
+err_mclk:
+	clk_disable_unprepare(priv->mclk);
 err_clk:
 	clk_disable_unprepare(priv->ahbclk);
 	return ret;
-- 
2.17.1

