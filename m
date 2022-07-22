Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB46157DB7B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbiGVHsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVHsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:48:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7785A79EED
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658476095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3hxncbcIe4Kl6PZy4gQqi0arV/C4q3zp6iiC7bYlb70=;
        b=ZJz22yDdMQGF3mzy4nymmWe3JsVFgs2ea5ToGIyGCXbnZ5luJfBGUyL88HbeA7QO5A31VS
        PSqmwF0n2DQCf18bUc1RQ7R2zveuuzDLBX2P/u80uCa3RQUly9vNqjhHEWnyUqZJqUBv0J
        RO6GHkkTKb8i8R+XRkbYU1A03vOD0yk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-hoGTVvVGN8OmaUcLoSCC1g-1; Fri, 22 Jul 2022 03:48:14 -0400
X-MC-Unique: hoGTVvVGN8OmaUcLoSCC1g-1
Received: by mail-wm1-f69.google.com with SMTP id v11-20020a1cf70b000000b003a318238826so1490422wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3hxncbcIe4Kl6PZy4gQqi0arV/C4q3zp6iiC7bYlb70=;
        b=Oq/jg6JMY429hjOHowiOHbePxjt+uZQM6OZy1ilMP/mXp8p9Rp+Fp7mE3x7m93mfE1
         wFM6EmknrdgAZ9kNXzLto9zya2sdYDIyTmMD5z/Q6NW+8mdYuFQveRBOcsq8qiStTpMB
         uKMrvkOXgadyUXhgUy3rnMj3okBJW2NHyplE27Q99wbsee5WMe73KFrl4Wxe37jMyzlJ
         VL+sMWg7IOps/atdreBC2zBpu7TvJMN+Hc7x7Io0DLWZKFSFopd+EFzCYs/uaCNsvByI
         C7PbZ1Lh7wkiSLx8u6E3RvL/Ct5YDAR+nmNXfssawO1WLPjnG0Dj7EZ6eaMWvZL3KBE1
         6gVA==
X-Gm-Message-State: AJIora+8AnD3MfGlsqwfPN6+Sv8LnczBSalucOXnd0zHBCcuOHZkNTAx
        seT8yHbmpfPWylx6+G5eyVZGLAQf6hUpEen5GuVwFA0fkDl2SLcRwIOLzSCClRWMXwZAMUMO5CD
        rJUWRAp8BWBvG7UxvYAh3vHrO0vt5ymVYAKQ5jOWuMxE6LSn0+i6TTxKi49uAFINl1ap0VnYwjd
        8=
X-Received: by 2002:a05:6000:156a:b0:21d:b22b:e5b with SMTP id 10-20020a056000156a00b0021db22b0e5bmr1525073wrz.348.1658476092693;
        Fri, 22 Jul 2022 00:48:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sDNNi2fuV3Q+f07HSbxoQkeX1wVwLud1oPEReIagKxVgo1g2hage93fB9UK5tJJAF3bhMQdA==
X-Received: by 2002:a05:6000:156a:b0:21d:b22b:e5b with SMTP id 10-20020a056000156a00b0021db22b0e5bmr1525046wrz.348.1658476092351;
        Fri, 22 Jul 2022 00:48:12 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f5-20020adff445000000b0021e5f32ade7sm553115wrp.68.2022.07.22.00.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 00:48:11 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Erico Nunes <ernunes@redhat.com>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/bridge: ti-sn65dsi86: Use dev_err_probe() to avoid polluting the log
Date:   Fri, 22 Jul 2022 09:47:55 +0200
Message-Id: <20220722074755.660258-1-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If devm_drm_of_get_bridge() can't find the connected bridge, it returns an
ERR_PTR(-EPROBE_DEFER) to indicate that the probe should be deferred.

But this path also prints an error message, which pollutes the kernel log
since is printed on every probe deferral, i.e:

  $ dmesg | grep "failed to create panel bridge" | wc -l
  38

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 369bf72717f6..90bbabde1595 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -1206,10 +1206,9 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
 	int ret;
 
 	pdata->next_bridge = devm_drm_of_get_bridge(pdata->dev, np, 1, 0);
-	if (IS_ERR(pdata->next_bridge)) {
-		DRM_ERROR("failed to create panel bridge\n");
-		return PTR_ERR(pdata->next_bridge);
-	}
+	if (IS_ERR(pdata->next_bridge))
+		return dev_err_probe(pdata->dev, PTR_ERR(pdata->next_bridge),
+				     "failed to create panel bridge\n");
 
 	ti_sn_bridge_parse_lanes(pdata, np);
 
-- 
2.36.1

