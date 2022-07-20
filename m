Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2106C57B77D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240886AbiGTN3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiGTN2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:28:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B0E84D4C4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658323724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9VV2A0xt4iWoClogWKWNXWu4TrFupjD6pG6MWFdRlyI=;
        b=Ii4YL/cIEpBhSUwdYpuDTRJkn1RsWIZBVNIJnKvchb/If7m31beMJC5xBU8HVYknydRAF6
        K+pSw+4rYPRpyKK5uFuRQFawSziP6bjna4PDEmDo86AQx9LZbZ9kpnLWvYsn6RTnE7MRRj
        opNY6GB0GdJdb+B6Gwxcf4SetrgzSj0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-MdnAwj_gMRKkjPZR0IDlYA-1; Wed, 20 Jul 2022 09:28:42 -0400
X-MC-Unique: MdnAwj_gMRKkjPZR0IDlYA-1
Received: by mail-ed1-f70.google.com with SMTP id w13-20020a05640234cd00b0043a991fb3f3so12027728edc.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VV2A0xt4iWoClogWKWNXWu4TrFupjD6pG6MWFdRlyI=;
        b=zLH56cjdASnlcT2nGdbW6Bb0UzWm0ytoH8l66YdZSPzbOvVMIiIodKwXvDuqFVLiIg
         6r8au1lG9mg0IpX9s2QOQGyWpkDhvZP+rWIuBQRqudRhqGINp76Rx5VSNsl0QRC5Bszg
         Sp26Y8eOtnBK1HelO7kxH/W7h6lmDO/PhdbkE+QikcMn76cWCPZWaHd+RtujrEenxayI
         RixnW8mmfveRoanof2Y0ODBucEM5YYzQmpp544VumIqI7PCExIbRtyIilBeXzpFA6wIa
         6wkFTVE5Utgs2Kmao3idYCh/YZlLKX6/IuiOhQ+E+iIlYUSx+XUpNnV/T+dOHxwLxP5c
         eN/Q==
X-Gm-Message-State: AJIora9epAH25ubxv6KZq65N1CGNumJ1e0dXoBLis+N3Mf6flQk+K3GC
        rYlMKcvIuipfmT5IGB872RX/F5ju+b+O4DZvQMoX46uLT0o37M/c7FRvYvVnE7XeSiCk42+nDXK
        PWvyhwjgsSnbBCHCgqPt9Ep9B
X-Received: by 2002:a17:907:3f07:b0:72b:54b2:f57f with SMTP id hq7-20020a1709073f0700b0072b54b2f57fmr34761344ejc.502.1658323720507;
        Wed, 20 Jul 2022 06:28:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uo8j6q388d7B1LrZ24MTAZEsBiw/LrA6Unb/g8/2liHXECnlfsKgcPxbProCFsFD4KKLtndQ==
X-Received: by 2002:a17:907:3f07:b0:72b:54b2:f57f with SMTP id hq7-20020a1709073f0700b0072b54b2f57fmr34761333ejc.502.1658323720343;
        Wed, 20 Jul 2022 06:28:40 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id x7-20020a05640225c700b0043ac761db43sm12220687edb.55.2022.07.20.06.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:28:40 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@linux.ie, daniel@ffwll.ch, mripard@kernel.org,
        christian.koenig@amd.com, emma@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND 06/10] drm: use idr_init_base() to initialize mode_config.tile_idr
Date:   Wed, 20 Jul 2022 15:28:26 +0200
Message-Id: <20220720132830.193747-7-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220720132830.193747-1-dakr@redhat.com>
References: <20220720132830.193747-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idr_init_base(), implemented by commit 6ce711f27500 ("idr: Make 1-based
IDRs more efficient"), let us set an arbitrary base other than
idr_init(), which uses base 0.

Since, for this IDR, no ID < 1 is ever requested/allocated, using
idr_init_base(&idr, 1) avoids unnecessary tree walks.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/drm_mode_config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index e2a295a4ee0b..3d1c1ade5a25 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -412,7 +412,7 @@ int drmm_mode_config_init(struct drm_device *dev)
 	INIT_LIST_HEAD(&dev->mode_config.plane_list);
 	INIT_LIST_HEAD(&dev->mode_config.privobj_list);
 	idr_init_base(&dev->mode_config.object_idr, 1);
-	idr_init(&dev->mode_config.tile_idr);
+	idr_init_base(&dev->mode_config.tile_idr, 1);
 	ida_init(&dev->mode_config.connector_ida);
 	spin_lock_init(&dev->mode_config.connector_list_lock);
 
-- 
2.36.1

