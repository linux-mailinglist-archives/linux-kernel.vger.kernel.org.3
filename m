Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40E3581904
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239742AbiGZRux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239709AbiGZRuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:50:40 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B811C326F2;
        Tue, 26 Jul 2022 10:50:32 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 6so13727102pgb.13;
        Tue, 26 Jul 2022 10:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4TbOfcqFkaHon89dsPDId7NNakdXJT5mDYYEM5ZbQu4=;
        b=L6BQD4cXM5g5dYWRDLi8nY5qoHZfLmMHeICkpsIp8/zpGHD7MHsTBwJ0WdnIqyzjRj
         OTnF41mIR4JwzXo7ivQfNKCQlAybcsKzx3mUFAvqolbc4R9nHXtrNcMEWycDpX/j6/nb
         Jr8JHjSh5N1SukZwESLj7sS0l8rwC4FzXIBl9pF/rOuMR9kBuC6TVRXjWfc1oTirfjcy
         1i4iavoi04XDICP8qbX2K6l1eV/ojMB41WZmonDubdpTUm5pUWy5RCB84LLoRjJunYcJ
         AhGXNsMLlYogW/4BqRyjTug/Sm3UTlny21SFIvzA1qAsmseb7n2j3ls7ZL4hpumfazHo
         AZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4TbOfcqFkaHon89dsPDId7NNakdXJT5mDYYEM5ZbQu4=;
        b=Nr+gTz7imeOJ4OVc6B5w52+l/0p/NnFiCyk8419IU11K8gsz96BSHavO49i83jb9Ws
         UXFaRWWlutBtzRSswoQ1DqXkW836XBUmqEXsfwJHpZZesLHPRtXXU4xdAyOltulMIHii
         Nbypj2eqpWoCwD3wuxP1Wz7GSqvpebVFZS8S6Y2U24+un+gLizl0tWlHfqH8E2qoReQR
         RpqYLSFL/ipk0LEChbw389cPkCuDFF6QTZdePUXqN2R43AIUKlKmzxzL4VIs0xbHrEk+
         zi3Q4LZprNrZ2cdePzP5egtfnKuG6RfyIgEIDlkQjvsuSYXvUycfoE4+T8iB7M384a58
         PjlQ==
X-Gm-Message-State: AJIora/+qVqoXHB7iiJW3YNbonX2uSfeL0HFKQu11hUK3mpuefAaWJaF
        bB+QUwn/kM88ne72TrYrmTE=
X-Google-Smtp-Source: AGRyM1vCBSG+2MrD8YxRCZnLd4kzxFePAWMM6fI3FYTppOWPEniQ5DooTQ8G8XP9tEpMhR/8KhVvrg==
X-Received: by 2002:a63:8742:0:b0:41b:85d:1f9b with SMTP id i63-20020a638742000000b0041b085d1f9bmr6780871pge.352.1658857832417;
        Tue, 26 Jul 2022 10:50:32 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id ij5-20020a170902ab4500b0016c574aa0fdsm11745788plb.76.2022.07.26.10.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:50:31 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 06/15] drm/msm/gem: Rename to pin/unpin_pages
Date:   Tue, 26 Jul 2022 10:50:30 -0700
Message-Id: <20220726175043.1027731-7-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220726175043.1027731-1-robdclark@gmail.com>
References: <20220726175043.1027731-1-robdclark@gmail.com>
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

From: Rob Clark <robdclark@chromium.org>

Since that is what these fxns actually do.. they are getting *pinned*
pages (as opposed to cases where we need pages, but don't need them
pinned, like CPU mappings).

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.c       | 18 +++++++++++++-----
 drivers/gpu/drm/msm/msm_gem.h       |  4 ++--
 drivers/gpu/drm/msm/msm_gem_prime.c |  4 ++--
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 97467364dc0a..3da64c7f65a2 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -177,30 +177,38 @@ static void put_pages(struct drm_gem_object *obj)
 	}
 }
 
-struct page **msm_gem_get_pages(struct drm_gem_object *obj)
+static struct page **msm_gem_pin_pages_locked(struct drm_gem_object *obj)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 	struct page **p;
 
-	msm_gem_lock(obj);
+	GEM_WARN_ON(!msm_gem_is_locked(obj));
 
 	if (GEM_WARN_ON(msm_obj->madv != MSM_MADV_WILLNEED)) {
-		msm_gem_unlock(obj);
 		return ERR_PTR(-EBUSY);
 	}
 
 	p = get_pages(obj);
-
 	if (!IS_ERR(p)) {
 		msm_obj->pin_count++;
 		update_lru(obj);
 	}
 
+	return p;
+}
+
+struct page **msm_gem_pin_pages(struct drm_gem_object *obj)
+{
+	struct page **p;
+
+	msm_gem_lock(obj);
+	p = msm_gem_pin_pages_locked(obj);
 	msm_gem_unlock(obj);
+
 	return p;
 }
 
-void msm_gem_put_pages(struct drm_gem_object *obj)
+void msm_gem_unpin_pages(struct drm_gem_object *obj)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 0ab0dc4f8c25..6fe521ccda45 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -159,8 +159,8 @@ int msm_gem_get_and_pin_iova(struct drm_gem_object *obj,
 		struct msm_gem_address_space *aspace, uint64_t *iova);
 void msm_gem_unpin_iova(struct drm_gem_object *obj,
 		struct msm_gem_address_space *aspace);
-struct page **msm_gem_get_pages(struct drm_gem_object *obj);
-void msm_gem_put_pages(struct drm_gem_object *obj);
+struct page **msm_gem_pin_pages(struct drm_gem_object *obj);
+void msm_gem_unpin_pages(struct drm_gem_object *obj);
 int msm_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
 		struct drm_mode_create_dumb *args);
 int msm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
diff --git a/drivers/gpu/drm/msm/msm_gem_prime.c b/drivers/gpu/drm/msm/msm_gem_prime.c
index dcc8a573bc76..c1d91863df05 100644
--- a/drivers/gpu/drm/msm/msm_gem_prime.c
+++ b/drivers/gpu/drm/msm/msm_gem_prime.c
@@ -63,12 +63,12 @@ struct drm_gem_object *msm_gem_prime_import_sg_table(struct drm_device *dev,
 int msm_gem_prime_pin(struct drm_gem_object *obj)
 {
 	if (!obj->import_attach)
-		msm_gem_get_pages(obj);
+		msm_gem_pin_pages(obj);
 	return 0;
 }
 
 void msm_gem_prime_unpin(struct drm_gem_object *obj)
 {
 	if (!obj->import_attach)
-		msm_gem_put_pages(obj);
+		msm_gem_unpin_pages(obj);
 }
-- 
2.36.1

