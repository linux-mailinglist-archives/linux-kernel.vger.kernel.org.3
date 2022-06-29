Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C346555FA24
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiF2IEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiF2ID4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:03:56 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24DD39B85
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:03:54 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 9so14587288pgd.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kYKmRwqhkod5kWIfzS16sS6jaDGBM3foLD2Ky8UkHos=;
        b=cvTkmfHi796POn8CJZVh8BuxQwCNHiL3lhRSUhCOi/iv8SBNkEjDUwW4bPCRwPQn2T
         78pmahWeeTSLx9N8hoYKAFzkZ06RUSRYZKtuOJJQ6OcBO/9FvozCxrj7AraN/NoC9Ugn
         Y8+1EFUP24BNpDYGjvcxFLYXVBUf7tkUheYHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kYKmRwqhkod5kWIfzS16sS6jaDGBM3foLD2Ky8UkHos=;
        b=QvegphI1o4LMZeaCSXmSNoonfG48TYfITRBwc1of8uIjmYqi4FzmEziG8R1OqNe269
         wd/cteU+rEY0WLQlEQ4e4M3PONmnDTQfnpiXKP1V8tqMGcI5h+ncj3mGb0qMXS/VdJ+V
         d9eMMfCxumW1tOWfC2Q6JhDo4LiRU3CTmLkaj4maAZr9AdtpuHIhgMn01Wm31dEgh4uq
         tEBNz97sNMgZzf3g7YeM2BK8AeUFD/JevTACG6jU+W0UaA2CaNkJfMxY+o2YuKkkj5PB
         QkErqVPqPnr7DwwobswJeHDgTLSeZnNwWsVPyLmzqyRXeL+UGsUipYnk9Sl15aQwIX0R
         4duA==
X-Gm-Message-State: AJIora9LSxNxhQ/eOoY+wQD5cCyKX+gIiNxA/UX/Ll0hxjUNmRYCt7rJ
        zjjsgG78s/wmacg48NIzOrVVgg==
X-Google-Smtp-Source: AGRyM1uLKuVxfxJVTSk72PzpYK6KFIsep162OacqzigSpO++IFBp3TTs/nUxCAA0MTJPJWRHyAz0Dw==
X-Received: by 2002:a05:6a00:c91:b0:525:8c3f:269 with SMTP id a17-20020a056a000c9100b005258c3f0269mr9140613pfv.66.1656489834468;
        Wed, 29 Jun 2022 01:03:54 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f7d200b001624cd63bbbsm10676727plw.133.2022.06.29.01.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 01:03:54 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Chen-Yu Tsai <wenst@chromium.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Judy Hsiao <judyhsiao@chromium.org>
Subject: [PATCH v1] ASoC: rockchip: i2s: Fix the debug level on missing pinctrl
Date:   Wed, 29 Jun 2022 08:03:45 +0000
Message-Id: <20220629080345.2427872-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_dbg on missing i2s->pinctrl as the pinctrl property is optional.

Fixes: 44f362c2cc6d ("ASoC: rockchip: i2s: switch BCLK to GPIO")
Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 285b6455be28..f783994cc16a 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -812,7 +812,7 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 			}
 		}
 	} else {
-		dev_err(&pdev->dev, "failed to find i2s pinctrl\n");
+		dev_dbg(&pdev->dev, "failed to find i2s pinctrl\n");
 	}
 
 	i2s_pinctrl_select_bclk_off(i2s);
-- 
2.37.0.rc0.161.g10f37bed90-goog

