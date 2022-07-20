Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB6F57B770
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbiGTN2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGTN2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC0772A41A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658323720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g0aUb76AKpcqinp04UULk4k3wJtOXAh9lLl0DFNwwBk=;
        b=F/m9/84DF1zk7zQ2DnUIDn7O9xvTr+WLBFtIxPfOLzZZFFKA9VMTqTWrvv6OzaAmvxoNGh
        PCwsFt5JmIB/FI2ktcu4dZXwCcAH1f7giq/eFnWST8ZbSLfVZWLjREbFA9X6bdC6Q3x1bq
        6fqdvj6Ikj2VFjK93U5kwTnOuOETCJI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-4feDie8yPBOiU3xJrjS-cw-1; Wed, 20 Jul 2022 09:28:37 -0400
X-MC-Unique: 4feDie8yPBOiU3xJrjS-cw-1
Received: by mail-ej1-f71.google.com with SMTP id sb15-20020a1709076d8f00b0072b692d938cso4045511ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g0aUb76AKpcqinp04UULk4k3wJtOXAh9lLl0DFNwwBk=;
        b=CuoKt8WODPnCZ1G7LzLvtzbg67fJxF+hErbu0mihmvS3GcIUsVzF/VqPXjEjBuP4nu
         YsA8nRj5nHE3qsArwvRgFeC7r+peaDFojVNf0K9ALEx96G6dYs/jQ7doQeK3E1d+ZfZR
         Ei1DBqaiglOo32Kvu8jPxgiLFLI9tV+7o5TduT4YYNOliBjXNfEXPvVsJuMAn7UaxcFH
         DO67TTgkIPFDNY1LrBwylaF+reBAgfGdLiAgCzt48J+YE6MVtKkNkq8wUJmdtftQyjeH
         boFPlFqnZwKVJID4IdzXRApNjI+EkwebNPKoaoVdkIccnifOfR4bZuObTMKh2cm3/JFw
         UJ9w==
X-Gm-Message-State: AJIora+I8tIFN5nCtbdlHSGWv/fiahz8mS8mxQJnkzfu1J4rKiRTjGZO
        TlYXkf8GPRCa3iOIjBv+ZEl8ieYZDtjazoq/60s1xtKr1K6p3ynvVtrYua16KHo7RAFw7QUx4AH
        +RD+Bob5tC+rKWYSf/kr7ltZo
X-Received: by 2002:a05:6402:4007:b0:43a:7de8:2802 with SMTP id d7-20020a056402400700b0043a7de82802mr50665918eda.13.1658323716139;
        Wed, 20 Jul 2022 06:28:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vd+mjGZZnD1P3oypeeTfNuxLWMjp+6F8sRSDwHasiOupx08H4bDmLgynZ4GDTntTb+QIUyRQ==
X-Received: by 2002:a05:6402:4007:b0:43a:7de8:2802 with SMTP id d7-20020a056402400700b0043a7de82802mr50665895eda.13.1658323715953;
        Wed, 20 Jul 2022 06:28:35 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id x7-20020a05640225c700b0043ac761db43sm12220687edb.55.2022.07.20.06.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:28:35 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@linux.ie, daniel@ffwll.ch, mripard@kernel.org,
        christian.koenig@amd.com, emma@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND 02/10] drm/amdgpu: use idr_init_base() to initialize fpriv->bo_list_handles
Date:   Wed, 20 Jul 2022 15:28:22 +0200
Message-Id: <20220720132830.193747-3-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220720132830.193747-1-dakr@redhat.com>
References: <20220720132830.193747-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 6de63ea6687e..103927c48d05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1148,7 +1148,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	}
 
 	mutex_init(&fpriv->bo_list_lock);
-	idr_init(&fpriv->bo_list_handles);
+	idr_init_base(&fpriv->bo_list_handles, 1);
 
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
-- 
2.36.1

