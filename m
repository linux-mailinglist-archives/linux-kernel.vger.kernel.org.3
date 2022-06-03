Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E1553CA74
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244533AbiFCNK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiFCNK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:10:56 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEF32F017
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:10:54 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 129so7202755pgc.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 06:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ODbT0QmWB07HWQTaFHLu0hivC2LQ/JBbuZ19CEiGVKM=;
        b=Ujk00q4GB9oPPURMhFVVwAwk0dUMGhQ76fKMOl94E00NDlBzmec8WnG80cYUoPQxDa
         uyHoSvt7Nv0t7hBT8kV61CzcV9zBn7zHIhctmnhq9VW7SgOApql44cEt9RIyDxd7T7gJ
         QH71bCiTFsi/K+KKjS9ut10gaB/rQyQklxU4wSxS6jWKjeEswiYC9AvYH28+8tg/wtjm
         ku2Kc6DdXUkTTtAeOcUJ+0673SS3oIRr7EkHdHOE9A/GFlsT/CqAzSW7hm1Qez17K87g
         NXkJtFHGc5FF+Rvbicrt5BTGlscw3ZACG5834nzQSkCim2qiCYfjGK3usCH9EjyTwJX3
         JTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ODbT0QmWB07HWQTaFHLu0hivC2LQ/JBbuZ19CEiGVKM=;
        b=Y4hk3FtjmS2g4RdoI1KVqLi0tVxQgzbAIB5ZjSViU7pZjnHxZhx9ScYdrCqs8kZUM8
         tvKCCMj1DZC2nBEp6/0i8UAagHzmQtdcE+22C4Vfe1X5hhA/ZLp6BXVe7kM4IKjoc6IG
         vwdpmujtnmbS9GLkS6C8wpqX6cejBqXY4bMI74+S+FiTOvWDr4byRGC7eACzLFeY472F
         JWA3hR9yCDcfpOJTWihs92YnhqKx7TjvOloKb4pj3PW8SXU3x9DaG+gLm81b4V8UStA+
         ODsk8rHbIDSNjPWykrdShUzbjB9Md3cAWva3sQy8RBA56yLHJ60FFLraW4Nhzmf/SngY
         g14g==
X-Gm-Message-State: AOAM530ega4x10qf4yx4purFe25rJ6k9xwEIKSAJG/ouEtmymfn5Jdc9
        hk2mN5jUnW7SrVdvra3NrZ4=
X-Google-Smtp-Source: ABdhPJyncMHC8GX1hRGNfDO4RAiZqdv/DEEl//mlI7eR6BEaT34FyQYkwf35dD33khPIgmRlk33AkQ==
X-Received: by 2002:aa7:8e44:0:b0:50c:fc0e:8d25 with SMTP id d4-20020aa78e44000000b0050cfc0e8d25mr10473724pfr.81.1654261853775;
        Fri, 03 Jun 2022 06:10:53 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id a3-20020a170903100300b0015ea4173bd6sm5279133plb.195.2022.06.03.06.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:10:53 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Cheng-Yi Chiang <cychiang@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        chrome-platform@lists.linux.dev, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] ASoC: cros_ec_codec: Fix refcount leak in cros_ec_codec_platform_probe
Date:   Fri,  3 Jun 2022 17:10:43 +0400
Message-Id: <20220603131043.38907-1-linmq006@gmail.com>
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

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: b6bc07d4360d ("ASoC: cros_ec_codec: support WoV")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- update Fixes tag
v1 Link: https://lore.kernel.org/r/20220602114529.6303-1-linmq006@gmail.com
---
 sound/soc/codecs/cros_ec_codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index 8b0a9c788a26..11e7b3f6d410 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -995,6 +995,7 @@ static int cros_ec_codec_platform_probe(struct platform_device *pdev)
 			dev_dbg(dev, "ap_shm_phys_addr=%#llx len=%#x\n",
 				priv->ap_shm_phys_addr, priv->ap_shm_len);
 		}
+		of_node_put(node);
 	}
 #endif
 
-- 
2.25.1

