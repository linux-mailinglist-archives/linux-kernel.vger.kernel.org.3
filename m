Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050804BD35E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242582AbiBUCCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:02:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238238AbiBUCCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:02:18 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31127220C9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 18:01:56 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id o5so28257664qvm.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 18:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xm1cMaCkcFSMVRTdtnPXUfUPWuii3wzaFgpfXsoXG2A=;
        b=Na8QdkPf6FigMgVQv+a7Y7Kx6u0cIM+zkaNaBVSaG1FBShpwJ97P+BUTV6yUBk26lj
         xSVBnFQjs6Sb9e9LEV+/dwWQ4oQ7p6KCwR89X7l0CBkicBCNITB2xlAisnQxKgVHjvyF
         sxZBZGLk4SQonSDI9Q5OQzj5XQCnwIIkdHKBJVv5+Y8Yi/Lpn5xrK7kZj3lMDCh8Auic
         hvhEmWEg0M8aiUGA/vpS19CNKR7AhQwSL5pnR6RZGCl5Cx7SKTcjA1FXTOP64k9hS1gp
         7SC/SRdgt8JDKojHYK6g8Gd4LGL5zMIxYp96V3uSZnnmIVSrQABWHeuwNPKhmJCWPYpZ
         /5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xm1cMaCkcFSMVRTdtnPXUfUPWuii3wzaFgpfXsoXG2A=;
        b=KGeYAftQX82t3QCU75rJZg6+ogqzZU2aT+7+Lj27vwJ0XD/YDX8b4n2Q7NlTYcEjy9
         eOAeti3BqV5l17avrDGwXRGz3Uzr45b4XYB7FHZ1VlkpqVcCXtKkasIE1iVx9gOdK6ww
         U0xmfW1zSio6y4B9ZxJ3wgFofF+852iHZJA8HVND+OjZ0eStexUYsy5PeY17Mh6v6GdR
         1ulfARsvFIBHsyS+QIG75MjQGzuXehz5NEXk7aHsou/rwXaNsMxPUV7RObBHAMbJNsXk
         /8hedmFAXDdmzKBufjqZvGMqkumfuM9WzzBBe9So9uJqPQ8Mn5HQaC50lc9jSTEzOfWI
         ZhmQ==
X-Gm-Message-State: AOAM530BMKzPptCdF2cfWgTnPGdjeh0JwMzSQkTfcvIptLkDUUMIcFH6
        u5rGqSetmWqsAGKAaG+9RxQgXexSQng=
X-Google-Smtp-Source: ABdhPJxf0c/OjvzGzIXOMLomQn7QEFY1yBhiwRUVfZgOYWPHyKCyJswQ2/4MsYKBC3PAFiY/tX6tgA==
X-Received: by 2002:a05:6214:5092:b0:42c:1e90:9b7c with SMTP id kk18-20020a056214509200b0042c1e909b7cmr13906133qvb.47.1645408915373;
        Sun, 20 Feb 2022 18:01:55 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w3sm30171434qta.13.2022.02.20.18.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 18:01:55 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     linux@armlinux.org.uk
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/armada: Use of_device_get_match_data()
Date:   Mon, 21 Feb 2022 02:01:48 +0000
Message-Id: <20220221020148.1925091-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

Use of_device_get_match_data() to simplify the code.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/gpu/drm/armada/armada_crtc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index b7bb90ae787f..b18daef75354 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -1026,13 +1026,8 @@ armada_lcd_bind(struct device *dev, struct device *master, void *data)
 
 		variant = (const struct armada_variant *)id->driver_data;
 	} else {
-		const struct of_device_id *match;
 		struct device_node *np, *parent = dev->of_node;
 
-		match = of_match_device(dev->driver->of_match_table, dev);
-		if (!match)
-			return -ENXIO;
-
 		np = of_get_child_by_name(parent, "ports");
 		if (np)
 			parent = np;
@@ -1043,7 +1038,7 @@ armada_lcd_bind(struct device *dev, struct device *master, void *data)
 			return -ENXIO;
 		}
 
-		variant = match->data;
+		variant = of_device_get_match_data(dev);
 	}
 
 	return armada_drm_crtc_create(drm, dev, res, irq, variant, port);
-- 
2.25.1

