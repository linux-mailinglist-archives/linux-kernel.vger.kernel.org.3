Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6F053B1C2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 04:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbiFBCoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 22:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiFBCoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 22:44:18 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAD91571A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 19:44:17 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id x12so3556776pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 19:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HbupgAkmVR1GYm3il4PytB0cVYenSOe+g7j17XkI4d4=;
        b=fiQbviVV7NONRimAi0Ctaq/RDSxgHCrya9Q/2+k+U8fhlYYHFuDQBk/tSbFZ1fx5Im
         GTbau0ekaRCChwa0jE4epT8v+rnupS7lwj7ZNrItTPZA8Q+94zKfN0aDAwGMmJODHL00
         GqL3iGIrLQeU8a4KLi5s9jUt4pt8BiUTJFc7kVIkY/L05xH/MSaAQV9SAgBpvtZAQYew
         gKZolAh5E/gQ2YLrLgFSKis9V88NSX4ZIoNcXiPZnNnEDsuk/rCo+rBQ6RKcK2TlOUL0
         cWD8WxU8v0cKLb/Vfp4h4BNKeIsC6Z7hXnRdNYiEhoQxt1n9PAjeHpRhcSwU3jb7tert
         yEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HbupgAkmVR1GYm3il4PytB0cVYenSOe+g7j17XkI4d4=;
        b=B2DDgO3G1KhHEJ+h3cBIg7854uEJqF+BCXF/IlmrbwrEFmV+ogL+mAYkGxmng+Sm+M
         MERz+ZH2GoCj9mHhPGeAjA9hnM+9VuWD64WgT+K2lLNGsDegT8cCveYPeHQQjL6GUbNu
         2Kbo0ze4cRcBnl5kzm7QlUY98CHmf4SwYTUPrR4STsN1nw5GjTo4g7V2cPBdzOSX2amJ
         Z8D0eUthPPfZ88tdgb3Dyf8NuydVtPIld+QFqiJNfhBiXwENDoryVbX7Ga07jA355h+g
         gqMF3avQXD7fAOQ51sQ3STXlOCzbi1p/YRkrFTTx155Lcd0rNc/kVL/QE4SsaxL7VmkZ
         rmNg==
X-Gm-Message-State: AOAM5313i9LLEg7zugs4EDajdpJrAwRYup5PVmMSAlcT/qJ2p6b+YSTD
        iUupao6xh1uAuaJxAqTe3Q4=
X-Google-Smtp-Source: ABdhPJxTF2ECTA8cM8yplQy/idwVYTfY2GW0aaQ29KadG3GJLzrn5lLiXgz9B3rxdlpt/qdnJ/wjkQ==
X-Received: by 2002:a63:441f:0:b0:3fc:8bd2:f828 with SMTP id r31-20020a63441f000000b003fc8bd2f828mr2134422pga.579.1654137857033;
        Wed, 01 Jun 2022 19:44:17 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id d62-20020a623641000000b0051baaa40028sm2208273pfa.11.2022.06.01.19.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 19:44:16 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v4] drm/v3d/v3d_drv: Fix PM disable depth imbalance
Date:   Thu,  2 Jun 2022 06:44:07 +0400
Message-Id: <20220602024408.43070-1-linmq006@gmail.com>
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

The pm_runtime_enable will increase power disable depth.
We need to call pm_runtime_disable() to balance it when needed
use devm_pm_runtime_enable() and handle it automatically/

Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Changes in v4:
- use devm_pm_runtime_enable()

Changes in v3:
- call pm_runtime_disable() in v3d_platform_drm_remove
- update commit message

Changes in v2
- put pm_runtime_disable before dma_free_wc
- rename dma_free to pm_disable

v1: https://lore.kernel.org/r/20220105120442.14418-1-linmq006@gmail.com
v2: https://lore.kernel.org/r/20220106124657.32737-1-linmq006@gmail.com
v3: https://lore.kernel.org/all/20220601122050.1822-1-linmq006@gmail.com
---
 drivers/gpu/drm/v3d/v3d_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 1afcd54fbbd5..563ad4b9c2e8 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -282,7 +282,9 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
 
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, 50);
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		goto dma_free;
 
 	ret = v3d_gem_init(drm);
 	if (ret)
-- 
2.25.1

