Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D74561ADB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiF3NAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbiF3NAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:00:31 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6B540E72
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:00:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v193-20020a1cacca000000b003a051f41541so1638371wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nh7MOeHqpu+KJjz+AQfMOAMAr6taCyP+a8n4nKC3Ilk=;
        b=it46n3LRqtbFUNmtsO5pMTfu8XVzRaw4AkZn64FfFqiNM1TD6/fI7WCexAZ0kter1B
         8V8OaDXmnLHFEVjmxaS1FdoZ/0Pf84G9bzIqI4QqQjedMkhnBmQBdU+PwdgSJrtv6ILa
         YojZAZPCS0q0Vzyef/v9d8v/StEujzRRvmdoxuC2JuWaNkyDRB8bjFaK+5U8690VKtQr
         A+dV+PdyNl/h0Za7ayvfNFEkp5xg/LIVabnTWn9hG40wAoh2NyJdEByXSjWVz2jTA68x
         5s7wTsAYHACQpXHMeszYGlsMUuVIWWWm/MTFVxmXg0L7vTMs+K/LI3Fcoc+RyBlDDobT
         xHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nh7MOeHqpu+KJjz+AQfMOAMAr6taCyP+a8n4nKC3Ilk=;
        b=ol1ERA+3iimzRr9KJP/wgT6IDpXHHVcfMJsSmjxES2zOOb2tJB42xOOWhII8nf69Ls
         KQmEC6KGkAA5vYO+gCibZINw5xOm4Idih6DBbBK6kSF/Ob2NO6hrbXgd13diZaGgAn8k
         8c6MYFUBdm0zj1fLAdJ0EBnoOpIjX+5Dk7WFCoSlzWUySjjuk/9mbxge4RJK6aN7V3l3
         ZMSWu069/5KSdRQX4UnWC0jH7Wr2WArMV2yV2HvVK0FEz3LuL8O7atZPaBx0nfoj7ylO
         nVrokiDVk7GfOzgb4aqWebO72Yx8MG3RV/mAQKH/JnKt9Yjvwps0h1lyx5WZZoW8e4yd
         6jvA==
X-Gm-Message-State: AJIora8BKqG5VXrssWJ/TLmJufId54nDtIfTDDGLzqEJ4OLFnHpSjHPJ
        63emIVNoOIUM7ipZDhKJ7cvvVQ==
X-Google-Smtp-Source: AGRyM1vJ3ZxH45D8hUgK2tFT90WipVg22meqPE/QRLhl20LRmrNPtv60AoVVnzHUObi1UxrNlko/Gg==
X-Received: by 2002:a05:600c:27d1:b0:3a1:7e0c:56bf with SMTP id l17-20020a05600c27d100b003a17e0c56bfmr3784642wmb.186.1656594026688;
        Thu, 30 Jun 2022 06:00:26 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b0020d02262664sm19273608wri.25.2022.06.30.06.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 06:00:25 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/2] ASoC: codecs: wsa881x: handle timeouts in resume path
Date:   Thu, 30 Jun 2022 14:00:22 +0100
Message-Id: <20220630130023.9308-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
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
Fixes: 8dd552458361 ("ASoC: codecs: wsa881x: add runtime pm support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wsa881x.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index dc954b85a988..6c8b1db649b8 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -1173,11 +1173,17 @@ static int __maybe_unused wsa881x_runtime_resume(struct device *dev)
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
 	struct regmap *regmap = dev_get_regmap(dev, NULL);
 	struct wsa881x_priv *wsa881x = dev_get_drvdata(dev);
+	unsigned long time;
 
 	gpiod_direction_output(wsa881x->sd_n, 1);
 
-	wait_for_completion_timeout(&slave->initialization_complete,
-				    msecs_to_jiffies(WSA881X_PROBE_TIMEOUT));
+	time = wait_for_completion_timeout(&slave->initialization_complete,
+					   msecs_to_jiffies(WSA881X_PROBE_TIMEOUT));
+	if (!time) {
+		dev_err(dev, "Initialization not complete, timed out\n");
+		gpiod_direction_output(wsa881x->sd_n, 0);
+		return -ETIMEDOUT;
+	}
 
 	regcache_cache_only(regmap, false);
 	regcache_sync(regmap);
-- 
2.25.1

