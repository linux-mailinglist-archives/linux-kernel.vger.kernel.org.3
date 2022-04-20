Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F746507F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359160AbiDTDGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359110AbiDTDGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:06:19 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F8239815
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:03:32 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id q75so360443qke.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CCQfkH82Dpv/txvDTzosoWFisSIFdL3o03R2vl6HtCM=;
        b=VkQntLRqujQdmG7D7luBRFasyuLd5VGWWy2Njp865rEjOFK2iFgQg2wIml/G4Yj100
         WSzW6E+o2/57UuXD7vlNZ3VRDQ89pvsH/XFRIyKM3s/VpvLEeIb1eldZLXbogwuXi9mj
         Pwk4trmtwiR9vdLZsHvQ1gimsQSuE+5VxzpoCZBM5VEehNtPP8tVSdoOWD6nQ8TjvX+s
         c6R9mQebiqxK+PQpmshJAp8Kbc4Mbl0SubhIMQUDzs7EYfbK4sh1Y+p8r5XLpFgAbPnB
         uB0LZdqJga8u7r+cXp529exkgtFXwENl+quRn6bOdPolFbpx8tDw7IWFvV3LOQlrDviv
         cOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CCQfkH82Dpv/txvDTzosoWFisSIFdL3o03R2vl6HtCM=;
        b=BYFyh9G5dCKFkPepNrwc7sTmGP+WZSsPf0vjHEjhUX/Jucu0AtGr9CW/8N48EgGa7u
         g+YK02nze53YVRIK2xe+SuwkWcBk0aX2pd/rNPgh3TXosyPleHwx3ZZkxqtVXavwiZI/
         JPFO/MOT/Gxu0X59eFX3iTz9gmcpE4fJR/6eYL2PXBVhRmJD+TgT4PquMHqCYof6QAhD
         U4E4wJKY3oWMonsN+eWzTDK4qGGNLeJa0WIbig0js2ARzbzw4VUFj2h506zAdQYwBkIE
         s2NShmT91rvC/HkFXwscCD6tS6fOma7i+xuk/YhhmcuNQ0FVHaYSZoxIWIKT0i//pKqZ
         ZpaQ==
X-Gm-Message-State: AOAM531s44ipRdy2xpUhXusPLlneNvuZ2p0e9O5hj7/1J4d9KRGMcLWq
        AkPZ7FvRm02Wrg5KDisalxs=
X-Google-Smtp-Source: ABdhPJy1C1g2Kf4YHazszq9HYtDEp84aNZiOFK2Mc6gSxH+oWhyqN7sscDsElcGcafi1CGbWt1/Z0g==
X-Received: by 2002:a05:620a:404f:b0:67e:a3ed:472c with SMTP id i15-20020a05620a404f00b0067ea3ed472cmr11563949qko.556.1650423811803;
        Tue, 19 Apr 2022 20:03:31 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w4-20020a05620a0e8400b0067b1bcd081csm843587qkm.66.2022.04.19.20.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 20:03:31 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     pierre-louis.bossart@linux.intel.com
Cc:     lgirdwood@gmail.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com,
        broonie@kernel.org, sound-open-firmware@alsa-project.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ASoC: SOF: using pm_runtime_resume_and_get to simplify the code
Date:   Wed, 20 Apr 2022 03:03:15 +0000
Message-Id: <20220420030315.2575691-1-chi.minghao@zte.com.cn>
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
 sound/soc/sof/sof-client-probes.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sof/sof-client-probes.c b/sound/soc/sof/sof-client-probes.c
index 797dedb26163..c4c6e03c8133 100644
--- a/sound/soc/sof/sof-client-probes.c
+++ b/sound/soc/sof/sof-client-probes.c
@@ -503,10 +503,9 @@ static ssize_t sof_probes_dfs_points_read(struct file *file, char __user *to,
 	if (!buf)
 		return -ENOMEM;
 
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0 && ret != -EACCES) {
 		dev_err_ratelimited(dev, "debugfs read failed to resume %d\n", ret);
-		pm_runtime_put_noidle(dev);
 		goto exit;
 	}
 
@@ -568,10 +567,9 @@ sof_probes_dfs_points_write(struct file *file, const char __user *from,
 
 	desc = (struct sof_probe_point_desc *)tkns;
 
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0 && ret != -EACCES) {
 		dev_err_ratelimited(dev, "debugfs write failed to resume %d\n", ret);
-		pm_runtime_put_noidle(dev);
 		goto exit;
 	}
 
@@ -621,10 +619,9 @@ sof_probes_dfs_points_remove_write(struct file *file, const char __user *from,
 		goto exit;
 	}
 
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
 		dev_err_ratelimited(dev, "debugfs write failed to resume %d\n", ret);
-		pm_runtime_put_noidle(dev);
 		goto exit;
 	}
 
-- 
2.25.1


