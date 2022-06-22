Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63665542CC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbiFVGLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiFVGLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:11:41 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2250520F4B;
        Tue, 21 Jun 2022 23:11:40 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id v1so31878185ejg.13;
        Tue, 21 Jun 2022 23:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UW2Ck9w89+CRbSGkJklsBtZoHdtGh6tH/2JzcL/UeIs=;
        b=ZhQS152JxW4cErBWVBT/CBqcn1OxR/7hxNTSEg1QnWtG8/VvBfQccC520UTUyfmBQl
         bxYshbZgmA7AGe0bykq+WAp8mod1GR0FJfTijbSGs4deievvk46aFAlYykIsWRGKX1En
         SFhJf1RMW7JpBS/ewTG8bRBl0K94+rQ2GbM/aNPv2634wQGkf38vQETVKzWAMpBTKOB1
         9hGzK4xrA8gnowqlcfXDWZaLwUzAjJ3EnDYdC10AHzx9H5tyocH5tiWZkMQrNr249B3g
         T3il3m9MnxyE7yKuK1iZ+oMsem/QFLiPBHxcaNa225lCVvxoi0QHaYwigh/k3RQfhPXM
         WxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UW2Ck9w89+CRbSGkJklsBtZoHdtGh6tH/2JzcL/UeIs=;
        b=CWeDfvYSSxw1ZPpdNxDRdTh015qy5x4tncFxYgPWrP8E5ifw2QxXx0tCacwK9k9TnD
         tU2rjqfOK4j1ZMlnl28IyNzxlC4FodIo5fipHSThuB4ldF44pwgeSoxPJqZ3PKRke7rC
         /sE+UXleaUshr5hVcx4r831/Z6jESla7xQcZDZmhfGPAhwCE/brgyKTVTMCD9SCwtpnG
         1SS/ChxWwpqPglp45DM3hnkFUyuT7/wrzlttUEU4X7P1j32ZVALbjK+XhPg+2czJbDZA
         5hON1MHH7Ups6wLoYAwCGo7PpOAnTW2hTQn9WEK+TocV5bGbrdLuG/ROexS5tITrlPKd
         K7cA==
X-Gm-Message-State: AJIora/cQh9ZSYGoZnesbhU+8sPsd21DizO5iBSqIzoElpDxN1ac6mpc
        TLCb/y8aTGwcRJAevPAh610=
X-Google-Smtp-Source: AGRyM1urqCYHq44g/9jk0TQ1Yx4JIHQbieaeZQTZRxKAqzdghsklsf4K1NPbXPEYAM750UzhGcDDeA==
X-Received: by 2002:a17:906:7a56:b0:722:df69:3bd5 with SMTP id i22-20020a1709067a5600b00722df693bd5mr1482293ejo.581.1655878298528;
        Tue, 21 Jun 2022 23:11:38 -0700 (PDT)
Received: from localhost.localdomain ([185.107.95.225])
        by smtp.gmail.com with ESMTPSA id p1-20020a05640210c100b004357dca07cdsm7347566edu.88.2022.06.21.23.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 23:11:37 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: qcom: apq8096: set driver name correctly
Date:   Wed, 22 Jun 2022 10:11:06 +0400
Message-Id: <20220622061106.35071-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.1
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

Set driver name to allow matching different UCM2 configurations
for the multiple devices sharing the same APQ8096 ASoC.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 sound/soc/qcom/apq8096.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index c7b7d0864d1a..5d07b38f6d72 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -113,6 +113,7 @@ static int apq8096_platform_probe(struct platform_device *pdev)
 	if (!card)
 		return -ENOMEM;
 
+	card->driver_name = "apq8096";
 	card->dev = dev;
 	card->owner = THIS_MODULE;
 	dev_set_drvdata(dev, card);
-- 
2.36.1

