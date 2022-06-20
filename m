Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6193B5521DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243797AbiFTQG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbiFTQGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:06:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72696201A7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:06:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g27so8679253wrb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1hWIp6gyzPawjh1VYTnBY7bZuvMtRrsBKXWqmX440Jo=;
        b=ImEBBc8Mfaf3egC0vLFYHtdUnz5XmDGiODkNpny5L5NPHSAFnXLokHTZEmjWbnT3WC
         gKlKSq67gALLdEBqLgVdXM2EvbJUo00ndmOR842m86KRxt5VX6WrM2ri21wVe6d1j7aL
         2DWC1bN/+70XXpa175XD+jNo2Nn+8IjjsbjnSvPQoe2SzNGGEekAiR77TERTEKSH176b
         76cmdO2wc36wuiKAp7akZkAhM7tikVlSgafLp+f9VtDUdvd9St/saVksJfNvu6bY78Iz
         FsckfGv9MJiGxHIyijZejdm61HMTuqSlGGr5T+nSRVBqmkWj+ClP4Tfkkk0K/gA3a63j
         w2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1hWIp6gyzPawjh1VYTnBY7bZuvMtRrsBKXWqmX440Jo=;
        b=NW+WkNkbWHhqj57P0/kjx6gbiBUFfUxND4DXXMCGYF/58rEU5/L2tZzRyUZd/K18Ks
         dC1/YU3ppuAmxJ3OfLL3Wgy+AK+tvVxOQffBT96g1d9/JLRt9psxRj+Idw1FKh0LosqD
         1bxTyCrJKrslagCcWPtlf71K7xsJNnYFK3Hx3L924KnzL7VeuTS+b0ALA/A4S2JJK3rN
         7EAV5xlE3TvAo5FwlHf9t0Y+XqeLuyLd5oCVIfM56t+gg2oTl9IFpWkFXJaBPLBDEK8U
         /Vhr3NpXdKFzLtxxXI3hJ2t0LW7VPtzOf+ui3TkWiJBmBxQ8cRMH1Vg0TeQ2JANvHrOx
         na0A==
X-Gm-Message-State: AJIora/wV4eQTGPj9w8OJyo23QXX+vZMpSQ9bxzsA6oRVJ6FIatZDIzh
        EzohzCytXtO268mlnzuKTv4=
X-Google-Smtp-Source: AGRyM1tS84pAl4gPEG6VUAiyQ3CNBgM/Fof7DG4xoDCk5JDIMJryIQAgfInVIRMaMIhvmvCck0bUzQ==
X-Received: by 2002:a05:6000:2a4:b0:218:77ba:988e with SMTP id l4-20020a05600002a400b0021877ba988emr23689984wry.459.1655741208896;
        Mon, 20 Jun 2022 09:06:48 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d430e000000b0021b90cc66a1sm2986096wrq.2.2022.06.20.09.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 09:06:48 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, jani.nikula@linux.intel.com,
        maira.canal@usp.br, isabbasso@riseup.net, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v4 1/3] drm/rect: Add DRM_RECT_INIT() macro
Date:   Mon, 20 Jun 2022 18:06:38 +0200
Message-Id: <20220620160640.3790-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620160640.3790-1-jose.exposito89@gmail.com>
References: <20220620160640.3790-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add a helper macro to initialize a rectangle from x, y, width and
height information.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 include/drm/drm_rect.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/drm/drm_rect.h b/include/drm/drm_rect.h
index 6f6e19bd4dac..e8d94fca2703 100644
--- a/include/drm/drm_rect.h
+++ b/include/drm/drm_rect.h
@@ -47,6 +47,22 @@ struct drm_rect {
 	int x1, y1, x2, y2;
 };
 
+/**
+ * DRM_RECT_INIT - initialize a rectangle from x/y/w/h
+ * @x: x coordinate
+ * @y: y coordinate
+ * @w: width
+ * @h: height
+ *
+ * RETURNS:
+ * A new rectangle of the specified size.
+ */
+#define DRM_RECT_INIT(x, y, w, h) ((struct drm_rect){ \
+		.x1 = (x), \
+		.y1 = (y), \
+		.x2 = (x) + (w), \
+		.y2 = (y) + (h) })
+
 /**
  * DRM_RECT_FMT - printf string for &struct drm_rect
  */
-- 
2.25.1

