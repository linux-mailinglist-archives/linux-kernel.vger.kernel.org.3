Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD274F805C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244903AbiDGNWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiDGNWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:22:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A27F3BBDD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 06:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649337607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qwnyzBHU2ps0lg/u42dFlsQayDte7IETW+1w7Wx0wc0=;
        b=T45evgTkbJh4KqKuHEUTVjVD1QQtL8X9lZlcXMPhkUxOI9ueih9WAyHEP1zHaoLn6hnoZr
        YQUEJDsPD49FVL/iv9mw1sZn8u9KvwNRiv85PoIAtHjTrqj2/djD6dRiZmL8JO0Gbsf9m8
        5XWonHfEnqbXWjZ00StBEvy1GaJAJIg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-9spzz7JJO2K5DJzm08emXA-1; Thu, 07 Apr 2022 09:20:06 -0400
X-MC-Unique: 9spzz7JJO2K5DJzm08emXA-1
Received: by mail-wr1-f70.google.com with SMTP id g4-20020adfa484000000b002061151874eso1265119wrb.21
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 06:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qwnyzBHU2ps0lg/u42dFlsQayDte7IETW+1w7Wx0wc0=;
        b=NvcQnVA6n+ksi0vSMS+SB4q41+KlESUt8wcbwtVz4MWKPdjW/JjrSuYPgMDIV8w0NW
         6ifKZ5146eNZ9HrKZ1qV3sOd6sMq04P56Yf6il//2AVlzMF8/XVDtYQ9QSxieKDFic3s
         kPNyUnrm21COzhQyyD21qQtJkO4p5GlzEZnye4RK482FWaDugy48XYK00ckjmDFTkr3h
         l3vGOqMWViBdTpKwVSsJQjN7w2M8aKUsbG3QK0FTYM7ZfNRixFz9ucbtzuZJTdjYT7Y1
         FtxjnNr19Kf+4vPb9yVqgsPDPoi55j4MiyLMJN/lu1UCNiysRNtRL9qbFn3/2XJm7VQN
         AqXw==
X-Gm-Message-State: AOAM53203a0XUoQaor0oym395ti/q+xnNvZL4BsPj9evrSu+CDyR07oS
        8G6cU2yRwmMRL72zjXzDK4vtm+2LebjbmSBKo/VnlzE1ua4/NLBVchRNmo8zx2mAhIY803gkF56
        wabkrGQSbvBRzj3ysMJ0mqmE4zkpkAiCHq2nFCzRoeCk9//wCxOXotaL5m1P8K9eRWprfGG10RG
        U=
X-Received: by 2002:a05:600c:3c9b:b0:38e:4c59:68b9 with SMTP id bg27-20020a05600c3c9b00b0038e4c5968b9mr12255522wmb.105.1649337605428;
        Thu, 07 Apr 2022 06:20:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQBSQ6JsGQGmUQrZuo6fJZqwQPCpOMvTNMJmEk0YVL6Z/cfLYxjjpt866oxCfauhP9AWslsA==
X-Received: by 2002:a05:600c:3c9b:b0:38e:4c59:68b9 with SMTP id bg27-20020a05600c3c9b00b0038e4c5968b9mr12255486wmb.105.1649337605105;
        Thu, 07 Apr 2022 06:20:05 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f184-20020a1c38c1000000b0038e7d6825f4sm7678670wma.43.2022.04.07.06.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 06:20:04 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Emma Anholt <emma@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-media@vger.kernel.org
Subject: [PATCH] drm/vc4: Use newer fence API properly to fix build errors
Date:   Thu,  7 Apr 2022 15:19:50 +0200
Message-Id: <20220407131950.915091-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 73511edf8b19 ("dma-buf: specify usage while adding fences to
dma_resv obj v7") ported all the DRM drivers to use the newer fence API
that specifies the usage with the enum dma_resv_usage rather than doing
an explicit shared / exclusive distinction.

But the commit didn't do it properly in two callers of the vc4 driver,
leading to build errors.

Fixes: 73511edf8b19 ("dma-buf: specify usage while adding fences to dma_resv obj v7")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---

 drivers/gpu/drm/vc4/vc4_gem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index 38550317e025..9eaf304fc20d 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -546,7 +546,8 @@ vc4_update_bo_seqnos(struct vc4_exec_info *exec, uint64_t seqno)
 		bo = to_vc4_bo(&exec->bo[i]->base);
 		bo->seqno = seqno;
 
-		dma_resv_add_fence(bo->base.base.resv, exec->fence);
+		dma_resv_add_fence(bo->base.base.resv, exec->fence,
+				   DMA_RESV_USAGE_READ);
 	}
 
 	list_for_each_entry(bo, &exec->unref_list, unref_head) {
@@ -557,7 +558,8 @@ vc4_update_bo_seqnos(struct vc4_exec_info *exec, uint64_t seqno)
 		bo = to_vc4_bo(&exec->rcl_write_bo[i]->base);
 		bo->write_seqno = seqno;
 
-		dma_resv_add_excl_fence(bo->base.base.resv, exec->fence);
+		dma_resv_add_fence(bo->base.base.resv, exec->fence,
+				   DMA_RESV_USAGE_WRITE);
 	}
 }
 
-- 
2.35.1

