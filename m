Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE15A50CEDC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 05:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbiDXDXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbiDXDXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:23:08 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DF53A6;
        Sat, 23 Apr 2022 20:20:09 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id ay11so8251284qtb.4;
        Sat, 23 Apr 2022 20:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EBA8aWav/CoBSWehGgBZGEgzVa0RTgL7rHF90t0PF20=;
        b=JtCtdl+5DWWk4Pj9mz99phQ52W2SEjVTzE0ETbG/GthiQd5Wtt48zvgm17LijeXvJr
         6IzCxPrwD4LoIgSQ2+7/ourtejJG8l6yw8eLo6FoULmb+Oj/bnsSYX1ft83j+PyhqiWp
         IwvEvi6FBAiL3t5BDs6w2mairv9tUe5Op/o3lYtpLWQ51kqOY/n6STPEvu9VIBUKqZ5Y
         X3DbqKe/e4ol+BBWSRXv3w7+CzjMtQzfgG4oDyuipqiGkaN06SKC/1N+ePKNwmwyredJ
         zpSOf1dW+mHjE7kL1PxJCRTK4HkX9LmIABQTXTYCGVMOToQfQbHoOISYkqgd8BdTffdS
         m0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EBA8aWav/CoBSWehGgBZGEgzVa0RTgL7rHF90t0PF20=;
        b=TJSMiUJpHtjVmtPWjAPfhLv1QHo1xqwP58MykzT2R3vdxptzTlRBKBWhPBK8W3gkQo
         kYFXyczpr7X6MfZkcizMQtEhFAzqmS0Gde/qeqXCKWGmnMXZhcAFX7HEcpHdAdtwHKrd
         LCShFrH9c5JnePcAR+OJ1OFXQfOdBz3bej8ivtpzXYJzwgHbLhBVfosmN08qsseOxoGR
         vPm0nVCSLAge3+h1QE9029qxNnGHkbDCwKEXcMUZggbAf+/VmjtlIg/h55yATpbNiKKJ
         QSSsAgd6iuvYka9rtcUhnaLU7k275Mgj9KJFRWdJOpmyk1gZZQfle87toBFqPyh9yrmr
         pr9g==
X-Gm-Message-State: AOAM533QkFteeTLud1MDq8xT5ZyVhBmhj6aA10ols2HBzhQ0VgmwQf1b
        Hg8a3ye/zqum96H+PhOKoM7cM4vUWNM=
X-Google-Smtp-Source: ABdhPJxjmwV+ialnqEb/Pgpw43PsgJzk6QNcPOzlVGXfI4DjI6QU1OgP12eLiyjzGuEKuW7rqWPBSA==
X-Received: by 2002:ac8:7f53:0:b0:2e0:77a0:1d35 with SMTP id g19-20020ac87f53000000b002e077a01d35mr7983018qtk.496.1650770408094;
        Sat, 23 Apr 2022 20:20:08 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y5-20020a05620a0e0500b0069c28a4e8ddsm3060267qkm.72.2022.04.23.20.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 20:20:07 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     dmitry.baryshkov@linaro.org
Cc:     airlied@linux.ie, angelogioacchino.delregno@collabora.com,
        cgel.zte@gmail.com, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lv.ruyi@zte.com.cn,
        quic_abhinavk@quicinc.com, quic_mkrishn@quicinc.com,
        sean@poorly.run, swboyd@chromium.org, vulab@iscas.ac.cn,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] drm: msm: fix error check return value of irq_of_parse_and_map()
Date:   Sun, 24 Apr 2022 03:19:59 +0000
Message-Id: <20220424031959.3172406-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <39b3828e-064c-6aa4-de77-35b201b1b40f@linaro.org>
References: <39b3828e-064c-6aa4-de77-35b201b1b40f@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

The irq_of_parse_and_map() function returns 0 on failure, and does not
return an negative value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
v2: don't print irq, and return ERR_PTR(-EINVAL)
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 3b92372e7bdf..44e395e59df9 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -570,9 +570,9 @@ struct msm_kms *mdp5_kms_init(struct drm_device *dev)
 	}
 
 	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
-	if (irq < 0) {
-		ret = irq;
-		DRM_DEV_ERROR(&pdev->dev, "failed to get irq: %d\n", ret);
+	if (!irq) {
+		ret = -EINVAL;
+		DRM_DEV_ERROR(&pdev->dev, "failed to get irq\n");
 		goto fail;
 	}
 
-- 
2.25.1

