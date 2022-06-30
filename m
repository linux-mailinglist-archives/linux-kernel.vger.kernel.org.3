Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914F2561ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbiF3NAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbiF3NAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:00:31 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7075B40A15
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:00:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k7so2711152wrc.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bzABi/fIb1/5+rkmhKsgJLpztE30/Fc5MNL46LXzMCc=;
        b=pd5SdccGVl8fDIHgsEq50W5KKB+B/zDoKkQ2eQ3o7PderfSIAUhs85dKlWE6ZnFsQq
         brEjiFes/oABy40kFwb6MHkYsUEtZnadZKYDg/XBOKOLgrDyERsV0YKD9yHJ+9DHj0D9
         azzEfOiXYljcqCLAv9Pux2dt+9T9aVvPUff4z4WxNmy4nWFORochi7eWOZAn5fY1Yl9H
         XyPaP1hOK++tUU5RvL7zxlUeyzglAihehbJvmjku2RQIT/rEE3ZNzQVCogABOoQFsJt2
         BGMbMwdDfGB3D4GLT8OMhr1zrKVp9cHVsn1qMV7SINf0uRZFfd1HVFEsm3H3GOUqiZVW
         mlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bzABi/fIb1/5+rkmhKsgJLpztE30/Fc5MNL46LXzMCc=;
        b=x5ZyA5wTPVCSfMp8nEnzf6Is+LhHy/K1tqryc0hRZAK4WDtPhYN6tKnXZKNMbkg1r6
         MMxjOGDfzHUBtUbTnMzXL7v6j6qK5fKbMDp8asfg6uOGd/lRiJU/jdronHhaxLlah0gj
         3/OGRO1t6GXX9uKKghn4GWpvSZXgbGvwTmvV8WvdgHM6rthWgTWnwdJi+q4urWOIHeRY
         NlkzpS4jkSj/yFqRDTdJmYnMQsSweiQ/K8B9T0ch9PJK0W/k2SqCJipr64OXET1LCb3b
         lEKSaf6Jz8EqFj0P3jOVNApIooiShfu4uftmx0XBe75T2Lr2M/cf3R12j3phqr83crkQ
         ZRnw==
X-Gm-Message-State: AJIora/RxD330hixhCtTgwvIpvy0DU6Devks9jJMKHfX6SEqSplqXh/i
        UbOopBJHDP2B+W7+OD+NTxbGBQ==
X-Google-Smtp-Source: AGRyM1vENCHbsQi0PnAYac3E99zxWkQjJFZN5frPbYEF/+WF6yo+5/ej3mMLC1VDx4o9B+4Wt+NCuw==
X-Received: by 2002:a5d:5967:0:b0:21b:903f:e095 with SMTP id e39-20020a5d5967000000b0021b903fe095mr8133140wri.162.1656594028050;
        Thu, 30 Jun 2022 06:00:28 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b0020d02262664sm19273608wri.25.2022.06.30.06.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 06:00:27 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/2] ASoC: codecs: wsa883x: handle timeouts in resume path
Date:   Thu, 30 Jun 2022 14:00:23 +0100
Message-Id: <20220630130023.9308-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630130023.9308-1-srinivas.kandagatla@linaro.org>
References: <20220630130023.9308-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we do not check if SoundWire slave initialization timeout
expired before continuing to access its registers.

Its possible that the registers are not accessible if timeout is
expired. Handle this by returning timeout in resume path.

Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Fixes: 43b8c7dc85a1 ("ASoC: codecs: add wsa883x amplifier support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wsa883x.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index e8f519e89213..40c7d64a9c41 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1455,6 +1455,7 @@ static int __maybe_unused wsa883x_runtime_resume(struct device *dev)
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
 	struct regmap *regmap = dev_get_regmap(dev, NULL);
 	struct wsa883x_priv *wsa883x = dev_get_drvdata(dev);
+	unsigned long time;
 	int ret;
 
 	ret = regulator_enable(wsa883x->vdd);
@@ -1465,8 +1466,14 @@ static int __maybe_unused wsa883x_runtime_resume(struct device *dev)
 
 	gpiod_direction_output(wsa883x->sd_n, 1);
 
-	wait_for_completion_timeout(&slave->initialization_complete,
-				    msecs_to_jiffies(WSA883X_PROBE_TIMEOUT));
+	time = wait_for_completion_timeout(&slave->initialization_complete,
+					   msecs_to_jiffies(WSA883X_PROBE_TIMEOUT));
+	if (!time) {
+		dev_err(dev, "Initialization not complete, timed out\n");
+		gpiod_direction_output(wsa883x->sd_n, 0);
+		regulator_disable(wsa883x->vdd);
+		return -ETIMEDOUT;
+	}
 
 	usleep_range(20000, 20010);
 	regcache_cache_only(regmap, false);
-- 
2.25.1

