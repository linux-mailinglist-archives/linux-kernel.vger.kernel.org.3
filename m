Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A408257221A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 20:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbiGLSCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 14:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiGLSCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:02:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDBB4C5965
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657648918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gGUU8csqKmijlurVp5QMVe7bWGLLWRqgzi0YQOg1uuw=;
        b=QevpgB3FM3ZCLHmwtRiWOuS9bv1ZAHzlXIgkSJtP0ZLXWD5P5j++kWr6/hxOoj0wGCrenf
        9ksHZpcOTns6yZdDMoupCDT/SXDqSUH+r04vDaj1Kez7ltSnG4M+uE9d95qoPZavEwvE6s
        MPlfeSB3xbewPriOsEA39+OwtyeIH+g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-RDYGo0zENumXjkeQWh-Dxw-1; Tue, 12 Jul 2022 14:01:57 -0400
X-MC-Unique: RDYGo0zENumXjkeQWh-Dxw-1
Received: by mail-ej1-f71.google.com with SMTP id sh39-20020a1709076ea700b0072aa3156a68so2587478ejc.19
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gGUU8csqKmijlurVp5QMVe7bWGLLWRqgzi0YQOg1uuw=;
        b=bltNzSJOAwvDqZuv9Etix6nwyCEoHmGK+V0sSFHaKMUGnI9h/Ou7DwRaZIG9Qq9wrp
         PgM/FExhnMcwlJHIxd4w0SzQIihT1kjgiROJf5UJX+dHShJLRTEPqP983kwEs8ZfagGz
         wAXWkAdAIUD6PLpUoTfqD/KXLTR2MWJ61Lm2d28iIceC0XNql11U+WRE++vF1eb49ygt
         mXBW42uAXnoUYZ45Uap3D3bQizTPE9pmcW/Y2uKYcO5/CKzh0xaZo+jy3k3sJGcwJVkC
         32eVmRojVDoqc+8ZAZlzQq9kdqdNhctn4mrJTfp0XRh2U+cRyZxigH9mLVZxfsH1GtdQ
         zWOg==
X-Gm-Message-State: AJIora97QQqNa7UfbFpwyeczlnDF3jMAmGCSXpINm0rrPfwfL1AmctPd
        LEcAnoq6hsqjM25ahjiyB0eVEfSPbyMqw7w5txVcUmT1AW5XqvqgkJaMFzXAXStPHGrl1fVp8O3
        ILWwKNsRC9erye+lLvS1R6z61
X-Received: by 2002:a05:6402:294c:b0:43a:91a9:a691 with SMTP id ed12-20020a056402294c00b0043a91a9a691mr33932213edb.182.1657648916547;
        Tue, 12 Jul 2022 11:01:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uy/+eU65Fj+mAPs2WsLaFkz8F4pPt0qMmztKSV4dwMQQ3Oed1AnBOkX4uYV+DoG64f4Vn6wQ==
X-Received: by 2002:a05:6402:294c:b0:43a:91a9:a691 with SMTP id ed12-20020a056402294c00b0043a91a9a691mr33932193edb.182.1657648916399;
        Tue, 12 Jul 2022 11:01:56 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id gx16-20020a170906f1d000b0072b1bb3cc08sm4028352ejb.120.2022.07.12.11.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 11:01:55 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, tzimmermann@suse.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v4 4/4] drm/todo: remove task to rename CMA helpers
Date:   Tue, 12 Jul 2022 20:01:39 +0200
Message-Id: <20220712180139.1886590-5-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220712180139.1886590-1-dakr@redhat.com>
References: <20220712180139.1886590-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both, GEM and FB, CMA helpers were renamed to "GEM DMA" and "FB DMA",
hence the task can be removed.

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 Documentation/gpu/todo.rst | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 10bfb50908d1..fd5b3f2fb19e 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -343,19 +343,6 @@ converted, except for struct drm_driver.gem_prime_mmap.
 
 Level: Intermediate
 
-Rename CMA helpers to DMA helpers
----------------------------------
-
-CMA (standing for contiguous memory allocator) is really a bit an accident of
-what these were used for first, a much better name would be DMA helpers. In the
-text these should even be called coherent DMA memory helpers (so maybe CDM, but
-no one knows what that means) since underneath they just use dma_alloc_coherent.
-
-Contact: Laurent Pinchart, Daniel Vetter
-
-Level: Intermediate (mostly because it is a huge tasks without good partial
-milestones, not technically itself that challenging)
-
 connector register/unregister fixes
 -----------------------------------
 
-- 
2.36.1

