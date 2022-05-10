Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D48F521EF1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242814AbiEJPiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345933AbiEJPih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:38:37 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5021F15BF
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:33:50 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x52so15241485pfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JCXe0wXtApkFt+51sQevrUY9NGf5KMQ0zb0sSdWlRTM=;
        b=oeMMxho23U1nt4kB5/OiiGKWPW0aBfGIBhekswXi29AXRBPmAKIp1Vccofvqw7Y73R
         eDkaGyMh1v+OYfQMI5qUgfRDLV28JFQn34l66u4qjN0f8b1NmnL4EqQH1WA1CSO0nV7K
         iqHI5k+Oh4uvS48sKrApyy3d6jfQgZ1Tee+8Jc/5cNoAfE6CHOHlwA0bj+QJ1r/l2TBf
         A411E2agO4eedeIefsR+oKvbirwIjb4Cva3U/q7vjMgRY6PvDo5LMwAQzaVCzI41s/bP
         9KbaxZ0jt56cMXJnHT5ncSPBJ4yPotcRELk51D/CA+YxLGjWtaB4HFGjr/rMOVa/7U1d
         8S7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JCXe0wXtApkFt+51sQevrUY9NGf5KMQ0zb0sSdWlRTM=;
        b=TFuaYfwF7CPXJVNU9yX/g1U84XkGIG1hjscqlamO6kUOP9dJdhiEF2KdXIypDVvDN1
         kYx53QRXHTJqFdQ3OAkRMqz4vb2Hm7FbLCG6jxEdoJieTVaNVm1fb//Bie1yw5Wh9a/X
         pRiTyfGi0F3CQQny8pKAR5ENKcR4OA0h6CbzIJ68nfEODXZTBFkw1tP2VcW5OkkWTVUv
         qXC9mn+ohLxffbNdjIR5RviD/3iWlPd5p+Mkj8XWuRI160kNUzW6aLt+S+/4UKkURozI
         lUpFfD83eBD9E1Bn8/zqv0n5Cd4lhYn8VXDyD/oyJo7bmRgTbn8WJTICFCvAPiZHas9k
         UBgQ==
X-Gm-Message-State: AOAM530Ed1mrWi9kA+gT1XbG10E4oAeDi7YYtthEaAkAV2BANMSDulOD
        dOkENKeawwNqYB5adlDnsw==
X-Google-Smtp-Source: ABdhPJymdQLmnMeadu7zJaG6Axddm9eIn3kMd/AHeVLO1r8GTjTSUp0gO0bYjtmy+WK69CiGNo8cjQ==
X-Received: by 2002:a65:63d1:0:b0:3c6:25b2:22ba with SMTP id n17-20020a6563d1000000b003c625b222bamr17306825pgv.360.1652196830491;
        Tue, 10 May 2022 08:33:50 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id cd10-20020a056a00420a00b0050dc76281d0sm11104248pfb.170.2022.05.10.08.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:33:50 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     james.schulman@cirrus.com, david.rhodes@cirrus.com,
        tanureal@opensource.cirrus.com, rf@opensource.cirrus.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, oder_chiou@realtek.com
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 5/6] ASoC: tas6424: Fix the error handling of tas6424_i2c_probe()
Date:   Tue, 10 May 2022 23:32:50 +0800
Message-Id: <20220510153251.1741210-6-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510153251.1741210-1-zheyuma97@gmail.com>
References: <20220510153251.1741210-1-zheyuma97@gmail.com>
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

After enabling the regulator, The driver should disable the regulator
when failing at probing.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 sound/soc/codecs/tas6424.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index d87444efed37..22b53856e691 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -756,7 +756,7 @@ static int tas6424_i2c_probe(struct i2c_client *client)
 				 TAS6424_RESET, TAS6424_RESET);
 	if (ret) {
 		dev_err(dev, "unable to reset device: %d\n", ret);
-		return ret;
+		goto disable_regs;
 	}
 
 	INIT_DELAYED_WORK(&tas6424->fault_check_work, tas6424_fault_check_work);
@@ -765,10 +765,14 @@ static int tas6424_i2c_probe(struct i2c_client *client)
 				     tas6424_dai, ARRAY_SIZE(tas6424_dai));
 	if (ret < 0) {
 		dev_err(dev, "unable to register codec: %d\n", ret);
-		return ret;
+		goto disable_regs;
 	}
 
 	return 0;
+
+disable_regs:
+	regulator_bulk_disable(ARRAY_SIZE(tas6424->supplies), tas6424->supplies);
+	return ret;
 }
 
 static int tas6424_i2c_remove(struct i2c_client *client)
-- 
2.25.1

