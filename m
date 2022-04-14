Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF515008E6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbiDNI4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241343AbiDNIzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:55:42 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B6067D34
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:53:14 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id p10so4107425plf.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uLc5LuG9DXxlk7SdW/vHLWzAxidCNAK1f7OoSBQxLQc=;
        b=qnyXFQ7FYH5F6pL3WLFATSJXtdiijMkQeXs8/yj2+YwPJaHulFoZGbQiHMbiDE91+p
         cUe7Yx6OF2vgFsoIl386+fhn2xBWMuowEbN/Rndu3udC/AwQyDi/NM8zUWH8wJ7AKS/T
         nvia84DR4Fkn1T+iKmcuSCbpgTpIGF23+DhJFCKfiUQQqPkRUX/gpRVW7BRr/72tzQ5Z
         T/OrY30V5Z0kkU5f6rmlBXzUyVmrwaNZWMe740WBz4QxmrzN+gdmoEhRd0T+2clmz9Eq
         tzGDDnrErsY1hUJ+uKF+GNxwtitUgH7qCauyKMLekTWHncPkceUxauzh4B4/RVMpny6i
         V6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uLc5LuG9DXxlk7SdW/vHLWzAxidCNAK1f7OoSBQxLQc=;
        b=YVoTTa+7xps2iOdNvxAxH465fWXrikTveuJGLA+Hjv56jZS+ylEDylehZhjMpvCmr1
         ejLvBuFoUbAbS8gG/0Ls7q4CUjd/zVsYjmgMDfP5faf7L0sVCo/FwO+uqu83D1gGS7R+
         RB5PFgRDIz7aKvO0sgrX8cUDeKifE2n+P5yiNNLvNHhVzjhnJlbaewI2jPdrrKkb0aS7
         XoTaCeUX91rOhDfXq3rw+6IM6lYyunkJ66xrAYuj5FaUkAoWIikEvgW4+xPcI3TaEBuI
         gQG/6hYUeThLlrDEsG7T12AgDbZ7qHRyHtL404L2vUK5qy/EoNznOr44nVq3PAQIYwJN
         I9uw==
X-Gm-Message-State: AOAM532Wh2MI+NvrYjk6uCGAzvErXd7zoZDjrkxmn86kQrLpWoTWiJhK
        14zFzGcXS3p6y0dnmWNDMdk=
X-Google-Smtp-Source: ABdhPJx0tQpLjh8XEtImq0YVQ7dWH0j69VdBypkfkQcK9Fda3lLIGA5Klhd5KmwXibG5Bvu/7fwUzg==
X-Received: by 2002:a17:902:cf05:b0:156:8445:ce0f with SMTP id i5-20020a170902cf0500b001568445ce0fmr46185920plg.99.1649926394326;
        Thu, 14 Apr 2022 01:53:14 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e12-20020a056a0000cc00b00508343a6f9esm720759pfj.5.2022.04.14.01.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:53:14 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ASoC: img-i2s-in: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Thu, 14 Apr 2022 08:53:10 +0000
Message-Id: <20220414085310.2541546-1-chi.minghao@zte.com.cn>
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

Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. This change is just to simplify the code, no
actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 sound/soc/img/img-i2s-in.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/img/img-i2s-in.c b/sound/soc/img/img-i2s-in.c
index f1f36f15a503..09d23b11621c 100644
--- a/sound/soc/img/img-i2s-in.c
+++ b/sound/soc/img/img-i2s-in.c
@@ -342,11 +342,9 @@ static int img_i2s_in_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 	chan_control_mask = IMG_I2S_IN_CH_CTL_CLK_TRANS_MASK;
 
-	ret = pm_runtime_get_sync(i2s->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(i2s->dev);
+	ret = pm_runtime_resume_and_get(i2s->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	for (i = 0; i < i2s->active_channels; i++)
 		img_i2s_in_ch_disable(i2s, i);
-- 
2.25.1


