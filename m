Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4CA4C4587
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240985AbiBYNLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240372AbiBYNLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:11:24 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E931EDA11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:10:45 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j22so4397855wrb.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=fcpSanLXTluEH1o3Di3VGPHlfJFzXldmeWc3Lc0lqLs=;
        b=Zk1vTZUmiGcgGskXNTXtWMVdtBc28Z/taq9E7cQRToI1sWHpLiL0pG2iwpEOoiqEnT
         DifajOEgMkiTp6w4TAkNWoJFa4l8GKcO6umclQvtwbsMZGTkNeEMMhhhieO90DjzyBA1
         vLU8Gwh5/iiSrChSx6OFHHzLTIpwT8mmd3aqd7eqOGcLZzVSi5o8QYxuxxEXBzO62Qm9
         ir6xdbc0uD3c8DGyoHSwN3XmgB7/Tca6UBc0YC6/TDHE9QzTTvECJgcInRz3hrY/DaG+
         TExuv2PP4qJMKcqjSwwMY6ussMfFX8ynFxpgJ09IuA0rYfITvbu+0M+l3UiNN5cmzl1R
         xFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fcpSanLXTluEH1o3Di3VGPHlfJFzXldmeWc3Lc0lqLs=;
        b=EL2ja08csJQ84YmR1+Hc1THXi1DKg4DP2v1JJfByaJFtET5g/cesa/iY4NxktBcqkk
         l8pFCjmlLLg8YteRtRY8v8vyrfQI0R3y+IuenvIfM0bt7iEbNasZdliLQ/ObEAUlOtp9
         pBXhJ6zzH3zM2JxUmhoOdUbn/2yMT1MT7cqdOTtoww7zQBRVEK4WUpA/fxeKwivNoEu+
         iRRdNXjXB3QcRYsZQVytRuQ/JMioGg7Uy0vxS3MT//HWtfzn7aNxi4Metwkt7pdItxna
         h5Yk/6y1Mz6+87MH5wecENvPppW1hyvNcVNKl/Kj4sUy/b1+JmhnuBHsnB1r2nbW7ti8
         4Sng==
X-Gm-Message-State: AOAM533fuonWaUpfszzfQsBRrJmuGLXdcmzEydOsOIvVhcBp4sPjU1gl
        hGHyNx1eyWO73Bbu59nQpmk=
X-Google-Smtp-Source: ABdhPJyre3/XXa54d/UN7EUXy/JFbdoL52eQtuhRqP5E+3QcqPH/s40WiFNE1Y8lkp08FQKUN7/IrQ==
X-Received: by 2002:adf:e18d:0:b0:1ef:7c17:cf96 with SMTP id az13-20020adfe18d000000b001ef7c17cf96mr330851wrb.444.1645794644476;
        Fri, 25 Feb 2022 05:10:44 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.58])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b0037d62a899b1sm2494089wmq.6.2022.02.25.05.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 05:10:43 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] ALSA: rt5663: check the return value of devm_kzalloc() in rt5663_parse_dp()
Date:   Fri, 25 Feb 2022 05:10:30 -0800
Message-Id: <20220225131030.27248-1-baijiaju1990@gmail.com>
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

The function devm_kzalloc() in rt5663_parse_dp() can fail, so its return
value should be checked.

Fixes: 457c25efc592 ("ASoC: rt5663: Add the function of impedance sensing")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/soc/codecs/rt5663.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 2138f62e6af5..3a8fba101b20 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3478,6 +3478,8 @@ static int rt5663_parse_dp(struct rt5663_priv *rt5663, struct device *dev)
 		table_size = sizeof(struct impedance_mapping_table) *
 			rt5663->pdata.impedance_sensing_num;
 		rt5663->imp_table = devm_kzalloc(dev, table_size, GFP_KERNEL);
+		if (!rt5663->imp_table)
+			return -ENOMEM;
 		ret = device_property_read_u32_array(dev,
 			"realtek,impedance_sensing_table",
 			(u32 *)rt5663->imp_table, table_size);
-- 
2.17.1

