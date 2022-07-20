Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A160957BA66
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiGTPf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiGTPfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DB1232442
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658331339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gGUU8csqKmijlurVp5QMVe7bWGLLWRqgzi0YQOg1uuw=;
        b=BatfOPffuObgQjsTDTax7/+57lbZrNEVlovcXn+DFlojyDgvl2Qwf3SErs0yE68gyCsvbi
        LPTr9+FocacqoMAwg7SI3TWIqUn1FlE9zYQ/vgQlP1vx0pfm5TLewoqDDi5iKOstJoGLS0
        oGmlkKLVyRUCGchALGpblkhBVTqSODg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-kBJfqayeM1Wh_zKHoGSb_Q-1; Wed, 20 Jul 2022 11:35:38 -0400
X-MC-Unique: kBJfqayeM1Wh_zKHoGSb_Q-1
Received: by mail-ed1-f69.google.com with SMTP id z14-20020a056402274e00b0043ae5c003c1so12318522edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gGUU8csqKmijlurVp5QMVe7bWGLLWRqgzi0YQOg1uuw=;
        b=2CS1Rp8zIk/be5pgceTbKLmh4lYWnkGg9wPU1SJkhOGUOsYn3FJuKPYpNfCf9rDSrG
         6BApjDMh0a5RpMjOUfvDhmcEQMRQZ4NAWIm4NMgvGYpBvAITZEU4JLuKmeCA/LmXeupS
         Ht8csD0LZ7QeqLcE2CB6rEhjuEy6+h5yqUgmGm9cD6J21XNWYYN9pM0+fgTaO582dDlx
         AS2mZZtgAb+xbOwU+b07ayJrm4KJtnErgPa6sIUveKZxkFH44LeOCtlncn/VyOUQxSTk
         fZmv825FOmFUBlC1HxtbOqCc8kSqVqZcTOKvVf4BAtst984jWRyoCSzn5tgdwyrAH7lo
         OyAg==
X-Gm-Message-State: AJIora+BSO7tMCWdIJ3l1w4mCpgXdu56uyMXdWErIbkS5a0iRt4/LQWO
        VtmOgT0+Qb18LZpFE0ihL/495la7+ZN7pCZ7UVMoiqOkQZrqGYISpWWlvQqkl9JwwPaxpjhGxAg
        Wq27bgoQ8ttbSCUX44BMXP019
X-Received: by 2002:a17:906:cc45:b0:72b:313b:f3ee with SMTP id mm5-20020a170906cc4500b0072b313bf3eemr34840118ejb.362.1658331336809;
        Wed, 20 Jul 2022 08:35:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sY5G1nZetzS4UPMQm0eyWT397zECsjSO4tfdUAB3orTdb89qM+POvod/pD2euFrQggM69qFA==
X-Received: by 2002:a17:906:cc45:b0:72b:313b:f3ee with SMTP id mm5-20020a170906cc4500b0072b313bf3eemr34840107ejb.362.1658331336636;
        Wed, 20 Jul 2022 08:35:36 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709060cc900b007263713cfe9sm8110409ejh.169.2022.07.20.08.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 08:35:36 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, tzimmermann@suse.de, mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v5 4/4] drm/todo: remove task to rename CMA helpers
Date:   Wed, 20 Jul 2022 17:35:32 +0200
Message-Id: <20220720153532.527458-2-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220720153128.526876-1-dakr@redhat.com>
References: <20220720153128.526876-1-dakr@redhat.com>
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

