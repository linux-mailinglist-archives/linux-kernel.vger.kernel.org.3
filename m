Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8AB594BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 03:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242242AbiHPB0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 21:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbiHPBZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 21:25:13 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8991CBBE5;
        Mon, 15 Aug 2022 14:14:57 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a22so7046556pfg.3;
        Mon, 15 Aug 2022 14:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=w5QXaLkMtFzdjHDQHtPEU494QpdGuD1KjoIolDWdbN8=;
        b=LQS9J7WOTckVSScdQmwkDF/vckZLEnTZXZYYRi13AYNiKPC+iOVgJoaFvOtFriteqO
         pQ0GS3eocqTyQnArXwKTQcmQNd1os850upnkC6k+UDghPUgT4Bp8W1FLZjr6drlvaoxE
         lczs8pvPfx+x3L5d/8pBqRvttkW9Z+o+qVB4LUJmpHAzTTcIsjI/TaABs3UIdjwkOf32
         JTnKOPherPlT/HdXAwGHKlcPXg1s4Q+soD1smUkNAHD0NvRUVNUbnGoOAFPms7YB5cTT
         xZHstsjW9JwfXPMkEIS+7l5OEd6SFzZXLLFT1Z1V+NvyIRPVNNTu8ycHOR6CERs4Beso
         Vf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=w5QXaLkMtFzdjHDQHtPEU494QpdGuD1KjoIolDWdbN8=;
        b=0ukdb9QSu0XB83zeeWK/W6a/EZZrw+EhEDq0exVNUsFh8BQTzk1wwlmkjtvy5JUpAP
         PYzVq1X7+r52Mc9fRIMs2h//G2ETGMXv7VKw0vYIHO5U49/sFkPl6pWtMdbeTZbwx0cQ
         +Cd/iDeVVqFDlPjbQpz78Nz+ohipkwdWdywqdlTBa5o0FC8Ajo2DfTk1CFI+Jzbqs7t7
         clXLhRvJGCqKKtLVEbc5bKM5hibORhwfHEPcZET5wjUf+YY10tk+e5aHkrqTxqRGuMxa
         L8wz3On4sE/2LElU1rgHu/UIiI+3pSYTgpYVopEzJXAe6p8p3YmFYLQafn9xUyVYjlZU
         soFA==
X-Gm-Message-State: ACgBeo3tljfFFQXdi2S8d34gRO6bSC9oe78T25gf1zFqH7DleDH8yf4A
        +xYqgS/DBgRza7wsxuTQ7t8=
X-Google-Smtp-Source: AA6agR6q7mRFB9Y4ijyBy6CjBRfN48U1JfqaDyXBL5UsDXYLNsVjueHi1/tBu1MPs+/X+hVsTIeoTQ==
X-Received: by 2002:a63:ab05:0:b0:41d:a203:aee6 with SMTP id p5-20020a63ab05000000b0041da203aee6mr15354352pgf.144.1660598096597;
        Mon, 15 Aug 2022 14:14:56 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id z2-20020a170903018200b0016eef326febsm7498433plg.1.2022.08.15.14.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 14:14:55 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] drm/msm/prime: Add mmap_info support
Date:   Mon, 15 Aug 2022 14:15:14 -0700
Message-Id: <20220815211516.3169470-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220815211516.3169470-1-robdclark@gmail.com>
References: <20220815211516.3169470-1-robdclark@gmail.com>
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

From: Rob Clark <robdclark@chromium.org>

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 1dee0d18abbb..1db53545ac40 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1048,6 +1048,17 @@ static const struct vm_operations_struct vm_ops = {
 	.close = drm_gem_vm_close,
 };
 
+static enum dma_buf_map_info msm_gem_map_info(struct drm_gem_object *obj)
+{
+	struct msm_gem_object *msm_obj = to_msm_bo(obj);
+
+	switch (msm_obj->flags & MSM_BO_CACHE_MASK) {
+	case MSM_BO_WC:                return DMA_BUF_COHERENT_WC;
+	case MSM_BO_CACHED_COHERENT:   return DMA_BUF_COHERENT_CACHED;
+	default:                       return DMA_BUF_MAP_INCOHERENT;
+	}
+}
+
 static const struct drm_gem_object_funcs msm_gem_object_funcs = {
 	.free = msm_gem_free_object,
 	.pin = msm_gem_prime_pin,
@@ -1057,6 +1068,7 @@ static const struct drm_gem_object_funcs msm_gem_object_funcs = {
 	.vunmap = msm_gem_prime_vunmap,
 	.mmap = msm_gem_object_mmap,
 	.vm_ops = &vm_ops,
+	.map_info = msm_gem_map_info,
 };
 
 static int msm_gem_new_impl(struct drm_device *dev,
-- 
2.36.1

