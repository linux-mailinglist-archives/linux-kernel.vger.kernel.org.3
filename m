Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC0F511DC3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbiD0R2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiD0R2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:28:11 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1762152E5F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:25:00 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gh6so4862802ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P52XUlnvWCDbdpSO0eow56ta8BYIoktLvffWsEefpbg=;
        b=EYyIJudDhVOE7nkfQP1R77baA7wbkc6ve+j0cW06+oPnAeLrfHkIPvjhM8VSs9RP54
         WUrZl2qV8Hp9WrdgrHudUuNOmQAsSwugxTKF0zdZhb98lU01+kJ0uTZZHDnfHo23KF8f
         7vJtUWbeJBZ48O+Rcz70/expiyA/HgPVGjOqzUyb1HzVmRkKPtKel1pAC8TrwJeDHSMa
         FR7WouWdsXS4BTgy5cayvj6E92lge1vx0YVkzM6lujQbbz75L2BvdPJnKRJVjEZyZTx5
         j8y1AT6+O7co6I6cll+Za0mbqMSTkEYbhG2ewGuphRI4UjAVKzM2+G71/z2L2pwD7pCt
         Lhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P52XUlnvWCDbdpSO0eow56ta8BYIoktLvffWsEefpbg=;
        b=OEB9owtn/uQPU6RhQnO1QiGCnebYWPqKTuAniN+iOHJsu27pPJRuyKLydIbYLJu3FW
         w0YpRoABbucO4GPm1MgbmGa3U5siTbiX2VyKS6YnAQcSldXOB0l/iqGI0V7jv/SLAS+s
         CTGLa19fVAAqka9VZsn52qkfy0Y4SHx4F+UlONJUdlzxvr7OEnwrItZC7hiJR7jLuyBc
         I7lakKkl/ND+2F8chAnpkaIQZDfk9tdyctsDkZI+XSshzg1a8ta2AoUvDQI2gtnKl/3E
         TRnnL7zudesn0AW06IZ7CCISWP5hqnuojgQftYGl3JlWUfcnX2pFaCAoB3kLGEWB3ove
         w7Dg==
X-Gm-Message-State: AOAM530pGQG94Sf8NggMlVQx/zHsLLoNJCHubz1XRzhTRRVigqElrS07
        yQVrp02eHAu/XZ0HAFT5eYg=
X-Google-Smtp-Source: ABdhPJwtWnz45yI608lXspTGLXjHmcLI45v3raOCKlRDG2j3PHMzL3wk9KyjzWEraDNpDJY3BuR5sg==
X-Received: by 2002:a17:907:97c9:b0:6db:ab53:1fdf with SMTP id js9-20020a17090797c900b006dbab531fdfmr27725391ejc.406.1651080298559;
        Wed, 27 Apr 2022 10:24:58 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id z2-20020a05640235c200b00425fff78dbbsm3328443edc.49.2022.04.27.10.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 10:24:57 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: rk3328: fix disabling mclk on pclk probe failure
Date:   Wed, 27 Apr 2022 19:23:11 +0200
Message-Id: <20220427172310.138638-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If preparing/enabling the pclk fails, the probe function should
unprepare and disable the previously prepared and enabled mclk,
which it doesn't do. This commit rectifies this.

Fixes: c32759035ad2 ("ASoC: rockchip: support ACODEC for rk3328")
Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 sound/soc/codecs/rk3328_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rk3328_codec.c b/sound/soc/codecs/rk3328_codec.c
index 758d439e8c7a..86b679cf7aef 100644
--- a/sound/soc/codecs/rk3328_codec.c
+++ b/sound/soc/codecs/rk3328_codec.c
@@ -481,7 +481,7 @@ static int rk3328_platform_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(rk3328->pclk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to enable acodec pclk\n");
-		return ret;
+		goto err_unprepare_mclk;
 	}
 
 	base = devm_platform_ioremap_resource(pdev, 0);
-- 
2.36.0

