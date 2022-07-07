Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDE856A9DE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbiGGRkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbiGGRke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D98C7237F1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657215633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gGUU8csqKmijlurVp5QMVe7bWGLLWRqgzi0YQOg1uuw=;
        b=A3Ea5xpocg3boAEFZVrsPr0caXGxP5ItQmxICQssz+ljixu+Few9uWeHIReMOuwKZmPiGv
        dY1QCUfJdwn80fvAhsSzbsLss5CX4ll3p6scfnrqP4Y1XuoEcKqzAVvujow1uzZwxTc9ij
        0/IPLwiKJ0RJG9tWryuOMmgQ6qLTYgc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-9dwGBpFHP2yMHFVu4srRuw-1; Thu, 07 Jul 2022 13:40:31 -0400
X-MC-Unique: 9dwGBpFHP2yMHFVu4srRuw-1
Received: by mail-ej1-f70.google.com with SMTP id oz40-20020a1709077da800b00722ef1e93bdso4966250ejc.17
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 10:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gGUU8csqKmijlurVp5QMVe7bWGLLWRqgzi0YQOg1uuw=;
        b=Lc/Ze9E6eIZLo7jwjstdhuZjZj/+nVvGqyuhjHOc5nYZWWGeX93njLNyqqOvt3VQ/c
         u0P5o6A5QFSzV3wQAoItJ52aj8zH1sSVu5EyhdN4nWf/AsKdER8MiKPx0SIAyNB21um0
         H+t/zcYj3jN2AZ7djhnsGO15nfggqm24xY8EtI5wF2/4mB/xKt7i9GhTCrNVRHh9E1z2
         VuiKiS03jtkBusMcd98wEk5MoJziBKVuRSaHvnNAXdqIx9v12Ltp/HpRhNh5EoeorDTD
         2IGCHRap+bEzLO9mh+631FaF9GjMPxMuQk2ap7FqGbo0SI7JfBMW7gE0qiGrd8JUpfel
         b2/w==
X-Gm-Message-State: AJIora+sce5rlUw7DPmvLrUQqTlIoO+thRO7jOFyihEEx8oni9ZzR1t7
        jvZfbgi/crdQxeLM62+HDiCPG+wLtFh0lq/yth0EiCR3rcQ905398/JlewG45hZ1My4GULG9QMR
        ZaMJOKt5B9Yeeh7PZc2as0z4j
X-Received: by 2002:aa7:c783:0:b0:435:2a52:3388 with SMTP id n3-20020aa7c783000000b004352a523388mr25532394eds.164.1657215630462;
        Thu, 07 Jul 2022 10:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vMHYRWt2bsRE6xTV+/1kBR3wQxwqI03PQBs+pw6SyB0ePUr1dLxWsHl5D3xjpNv8ERFU2Igw==
X-Received: by 2002:aa7:c783:0:b0:435:2a52:3388 with SMTP id n3-20020aa7c783000000b004352a523388mr25532380eds.164.1657215630322;
        Thu, 07 Jul 2022 10:40:30 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id jp1-20020a170906f74100b006fe0abb00f0sm19092424ejb.209.2022.07.07.10.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:40:30 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, tzimmermann@suse.de
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH v3 4/4] drm/todo: remove task to rename CMA helpers
Date:   Thu,  7 Jul 2022 19:40:03 +0200
Message-Id: <20220707174003.1390017-5-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707174003.1390017-1-dakr@redhat.com>
References: <20220707174003.1390017-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

