Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6492154ECAB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378925AbiFPVdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378817AbiFPVdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:33:11 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9736B3AA6A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 14:33:10 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id n28so3842237edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 14:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=laSJoDIgvQBCTId5pVKj53fMxGvIURwK5+ffKs0ASlY=;
        b=UBd17f/1SnZchYlExkTEs7FEuYTDz5ujzCzXm/SGFxfc7vQJ4lD7bhjBqiIPj2yGEY
         OwWwEycnPAU139vVsRVxUyNnf6H75fg5PESXPcSy4hSPmAVLjAgzMN7gutw+N7PP/V/n
         4Xha3koafKzw6BNAP+dZFpiWU3OKxLzLTXz5t7r/ZXiv/OgndLmncmtxxVKo22qgcomS
         nTxiiFAiPY6wxRbda4CwsKu1nSWydVfLTtRpNEv6aAzv+AsbfvhPMIOeOhCoOLZPP9Ws
         w+cmzNI/W2M1sMrVY8ka2YLMDqLl5axbTOql/Vt16eIKZ39AGlUcV6dPfCwO1RUQQdn0
         B45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=laSJoDIgvQBCTId5pVKj53fMxGvIURwK5+ffKs0ASlY=;
        b=Uld0Xke1rhFbAWyWF6Xr+YGtHfQJlikhN7U48CBpktd9RmJ1+Y4TaLN76hP4nuauOS
         xujg4RVfYQBV39kamRq6LHoayB8ES2wWS6YIR2MSZm0JozNgIgdlwYI8SwsAPdnP9etc
         2QD45Q0LyFot4XstXEqlN5Jz631UZrLQcqYyoti6PyFOFAKjeB9IHslS6zHVcpPVpojS
         S9NqDL5drn8S6OlP5aJ0g/FCBBIsLwDN3ePVRsN1Wildop2Uxd1QF0CDxFpu153bhv6w
         b1PtYpftxy7zIIA/1x1QiTp1F73TPJ5osBI+D8Kt38MmKDDhA6rlhLCsfS08zruxo4Qi
         YohQ==
X-Gm-Message-State: AJIora+Ya6lkQUTdI9RCWbg+TS/FZ7c40ta+art621l0MloP0iJCenLD
        qn+XGwueUHydVpSthVNJD+0=
X-Google-Smtp-Source: AGRyM1smWRQNfSGi+fNS3fxjPTkk1JtE/FL1CrltkwNtsatE8j54xbfVNS+Jv1BDstvw0sEj54qO3A==
X-Received: by 2002:aa7:c857:0:b0:433:5c62:ddbc with SMTP id g23-20020aa7c857000000b004335c62ddbcmr8865690edt.218.1655415189047;
        Thu, 16 Jun 2022 14:33:09 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id d5-20020a170906304500b0070f7d1c5a18sm1241230ejd.55.2022.06.16.14.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 14:33:08 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, samuel@sholland.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] drm/sun4i: Add DMA mask and segment size
Date:   Thu, 16 Jun 2022 23:32:40 +0200
Message-Id: <20220616213240.392041-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Kernel occasionally complains that there is mismatch in segment size
when trying to render HW decoded videos and rendering them directly with
sun4i DRM driver.

Fix that by setting DMA mask and segment size.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 275f7e4a03ae..83f4e87f77f6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/component.h>
+#include <linux/dma-mapping.h>
 #include <linux/kfifo.h>
 #include <linux/module.h>
 #include <linux/of_graph.h>
@@ -367,6 +368,9 @@ static int sun4i_drv_probe(struct platform_device *pdev)
 
 	INIT_KFIFO(list.fifo);
 
+	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
+
 	for (i = 0;; i++) {
 		struct device_node *pipeline = of_parse_phandle(np,
 								"allwinner,pipelines",
-- 
2.36.1

