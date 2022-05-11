Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455EF522BA2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238765AbiEKF14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiEKF1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:27:53 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F8912FC00
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:27:52 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d22so812623plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xhdm254L1jYhgvQgbJzDhHX/1k7BNUYa5TibU3+NCCw=;
        b=pZ7INeRKE7ikbL0Wp1J2nkeg5H+ixeNlVyt8PYCddh2qShvjPh+hek64IhQ72pjYiI
         7emBeRFo+ZBiSd6HXcaXOmhC+lL3WiJqfw6jXaPXvYjcjTJk8+EAcrW7nBNknBW8MamG
         y3IM79TAD97U/nTxtEo9yvf5XYzIF4gzw+u7IgzhoT3ceHSuOUOwpuYMb/KzCmOlru5l
         9aNHlqiUqt3TaR84XMjujDYI71Svp937IGTCm9Oiuv+bXoeSRUiGHWiNMlWtcPUtFmKD
         BYh9nNVtPT2zfyA8wsUHIo3lHKyxQV33wgLC9Voh85/bQ8qPt9QSI43AUrUeQuBnwwSu
         gbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xhdm254L1jYhgvQgbJzDhHX/1k7BNUYa5TibU3+NCCw=;
        b=usqZVnPHSTF9lIQYC9mrYRS8agkhDm/PBTf9SvvfFYjM0+fnoSg1RL3UdVlFi+5Yho
         646xkEmyXx8r6mPT2Gg0JW+ZhSVTvTHtkIHmS0/hlgAoWozfdBLUzk4xv2x1Adi9XNL4
         ncPemwVP4KbE8rr6UW/sp3FzwWO3Ug28pNrOcZDwBil0hjET92uinueEcmt2RTjO0/Ho
         cK2efK4+aEjNUCMpwaweJVbL5J9a5RIt/274MU1QWVMbfB5ZoOR/FVQTRAXiNKOiAhAW
         ZYnoCeg31EYYHrfpCCvpL2SW4k5zMWTrCcUPrHZ0CgyepWhTdvVX7sewThH78g3ieK42
         zAwA==
X-Gm-Message-State: AOAM5310X5Fz7WQur4GFD9n3x6xVrQE/WDaw5twihHyFjvdw9PcC8Hoq
        ThsfSxH1eig17SrAPBGRFMY=
X-Google-Smtp-Source: ABdhPJxp27enUzauf894HfT9NP3kw4axhqglDt0NeLn5w5FytMmzOkolsl2i+qdZja+aIx6uEVmDBQ==
X-Received: by 2002:a17:902:7fc2:b0:153:3c90:17b9 with SMTP id t2-20020a1709027fc200b001533c9017b9mr24081383plb.61.1652246872324;
        Tue, 10 May 2022 22:27:52 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id s12-20020a170902c64c00b0015e8d4eb2e6sm588632pls.304.2022.05.10.22.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 22:27:51 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ye Guojin <ye.guojin@zte.com.cn>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ASoC: imx-hdmi: Fix refcount leak in imx_hdmi_probe
Date:   Wed, 11 May 2022 09:27:40 +0400
Message-Id: <20220511052740.46903-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_device_by_node() takes reference, we should use put_device()
to release it. when devm_kzalloc() fails, it doesn't have a
put_device(), it will cause refcount leak.
Add missing put_device() to fix this.

Fixes: 6a5f850aa83a ("ASoC: fsl: Add imx-hdmi machine driver")
Fixes: f670b274f7f6 ("ASoC: imx-hdmi: add put_device() after of_find_device_by_node()")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/fsl/imx-hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/imx-hdmi.c b/sound/soc/fsl/imx-hdmi.c
index 929f69b758af..ec149dc73938 100644
--- a/sound/soc/fsl/imx-hdmi.c
+++ b/sound/soc/fsl/imx-hdmi.c
@@ -126,6 +126,7 @@ static int imx_hdmi_probe(struct platform_device *pdev)
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data) {
 		ret = -ENOMEM;
+		put_device(&cpu_pdev->dev);
 		goto fail;
 	}
 
-- 
2.25.1

