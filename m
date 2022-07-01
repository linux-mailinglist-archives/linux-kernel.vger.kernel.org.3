Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743A9563967
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiGASxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiGASxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:53:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A477D12AED
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 11:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656701593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=63rX3ptgchfOBbW8BmUq0MeFehoHIgkdOiFcVPPOAq4=;
        b=VcxX4/9eT2OwXWWLKMkaYuzm4wD+MlGrRdqZ8x3HpxRavRlmUzhQtB4YFbWvxx6n5WGoaL
        2IMSEoQrqTjF9LhaetlAIYdUhEBRjg6WrzK386PpH2fi0UnBcYYj7YOdBI9G+Oh8AlTPc/
        6YgZQBfWY+SWIm6VbGBiXPQBQT0Nivo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-rhGjZb02ObaSRJ8TtAU4Tw-1; Fri, 01 Jul 2022 14:53:12 -0400
X-MC-Unique: rhGjZb02ObaSRJ8TtAU4Tw-1
Received: by mail-ed1-f72.google.com with SMTP id m8-20020a056402430800b00435cfa7c6d1so2298120edc.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 11:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=63rX3ptgchfOBbW8BmUq0MeFehoHIgkdOiFcVPPOAq4=;
        b=AHXO86SgcjRlo0rHX391EdiKL2NMW6e3OnjzE+groQOy7moTEF0GWle2scoeBIEz3o
         dxYyATo85bC7BNB2cg6mogjAtm3suLYG2sfEQw0x7/6rSj3+uJldYUdfGGWMSQNRglmS
         cOrjLZIveKYMwL6f0FQ4VSWF0DLf1kN8Zoq+KauLpNYb646uKklKwXvp9VZgPlgFNPjt
         /rnz743M/lkp3RtZ9E9c595oVXvIW4cdXkgf/CpJZkqr39FjpPCUyT840WOHSMc2xWXA
         s9gVfl/ssQh2BDa9w2IwpizsWbnqjw0/ShB2uTnL16n7bNNfQu9Cof8Lknvw9SwkaJ9H
         WwpA==
X-Gm-Message-State: AJIora/kCLyUstQjf+4AgBqJOTq6l96Sprk5YdZsMGDyKKQjcxMtsRII
        uJYt8ft8wi4p6UtrdC54WhFNl5u1zPojwBhPOetBMt4f3xTqdvlnxkzC8VitBQBmcpSJDVy15N0
        D1ed87vrifbwAkpGSOPAl+CR9
X-Received: by 2002:a17:907:3e82:b0:6ff:1e04:a365 with SMTP id hs2-20020a1709073e8200b006ff1e04a365mr15143279ejc.617.1656701591431;
        Fri, 01 Jul 2022 11:53:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t2CRyy1sngD6eC2nYuVt9TTA6P9z7wTWn5nnIISMwguXpv2JkANsqjZQx9hF16u8hYh17A3A==
X-Received: by 2002:a17:907:3e82:b0:6ff:1e04:a365 with SMTP id hs2-20020a1709073e8200b006ff1e04a365mr15143268ejc.617.1656701591277;
        Fri, 01 Jul 2022 11:53:11 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id cb25-20020a0564020b7900b004359dafe822sm15406658edb.29.2022.07.01.11.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 11:53:10 -0700 (PDT)
From:   dakr@redhat.com
To:     airlied@linux.ie, daniel@ffwll.ch, christian.koenig@amd.com,
        emma@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 02/10] drm/amdgpu: use idr_init_base() to initialize fpriv->bo_list_handles
Date:   Fri,  1 Jul 2022 20:52:55 +0200
Message-Id: <20220701185303.284082-3-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220701185303.284082-1-dakr@redhat.com>
References: <20220701185303.284082-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Danilo Krummrich <dakr@redhat.com>

idr_init_base(), implemented by commit 6ce711f27500 ("idr: Make 1-based
IDRs more efficient"), let us set an arbitrary base other than
idr_init(), which uses base 0.

Since, for this IDR, no ID < 1 is ever requested/allocated, using
idr_init_base(&idr, 1) avoids unnecessary tree walks.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
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

