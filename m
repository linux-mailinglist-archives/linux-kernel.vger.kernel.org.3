Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68F757B771
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbiGTN2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbiGTN2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC9B728E15
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658323720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gkqfIGU1jFp3Ya/5fwJtXiMW+j3VZbkqa61u3PfPfGg=;
        b=CjTX6GS8ElfhlcT/eXry7AJKvvQZQC+AGduQFFnkH41Kcl4oDz1g+qgI7E2zztOmJiq+cg
        lBHbjUVsjH37Y9ELv/RTlBg5ZHkcHSusCU0LgJdeb3Akaxh+ainfCeLBC7Aax6ED6LwzQo
        rfEFtUYgKoXKjo9VNrHWcvh1I3D33dk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-dq3FwDOnOMGwIzj1bqoOIw-1; Wed, 20 Jul 2022 09:28:38 -0400
X-MC-Unique: dq3FwDOnOMGwIzj1bqoOIw-1
Received: by mail-ed1-f70.google.com with SMTP id g7-20020a056402424700b0043ac55ccf15so11978857edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gkqfIGU1jFp3Ya/5fwJtXiMW+j3VZbkqa61u3PfPfGg=;
        b=AMnECoLgAUqM6Is2rBRg8FkFCWt74V1dAoNlZCiStlRhSSY8S7Q99t4nRb5NM9qUQt
         Mau33hPdnXLRihTnVYw4K/BsEHLvnRb1PSmi04ljcNM8pnOh71l7p8VYttBurq+ZgB10
         E3VrPnkVlKSPglHBbNhEWEhTbp9KxyRew67PVZzmkaiksk5OPZA7j4HuxzwR9685meUg
         bVWguFM86qe0X+EK34zeOVdiiokuSl7fy/UV+7R6iiWSMpuF+2Xm0k0q7oT7b+CYY175
         rUaPaoAGzx86IUiOJRwKKz8hm8jMaURoS/hFSix6CS4C7VrOm/AwD+nxnJcuemWM7MNw
         /fiQ==
X-Gm-Message-State: AJIora/Li7wIFsZId1qV5SSuovRNyrGHwMZpHIPZXQDr1MxY93GSGnzZ
        z9MXFkPzKsiidEOyhaP5ViNfsuNDAhHHkFm7orVXOibDMKuTdrzcqOgnfJ1PpHBDMLyc772GYNW
        E4Khflm7SOBIZ4yUJXGcq5J5J
X-Received: by 2002:a05:6402:378f:b0:43a:d3f5:79f2 with SMTP id et15-20020a056402378f00b0043ad3f579f2mr51775759edb.338.1658323717205;
        Wed, 20 Jul 2022 06:28:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t3fSyGyUhItvWNAfzBrVUs5sXM+vSZQoJwXk+V++H1tUF1Sa+Sg+abJ9GPTpm2/Ve6F4StiQ==
X-Received: by 2002:a05:6402:378f:b0:43a:d3f5:79f2 with SMTP id et15-20020a056402378f00b0043ad3f579f2mr51775750edb.338.1658323717069;
        Wed, 20 Jul 2022 06:28:37 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id x7-20020a05640225c700b0043ac761db43sm12220687edb.55.2022.07.20.06.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:28:36 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@linux.ie, daniel@ffwll.ch, mripard@kernel.org,
        christian.koenig@amd.com, emma@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND 03/10] drm: use idr_init_base() to initialize master->magic_map
Date:   Wed, 20 Jul 2022 15:28:23 +0200
Message-Id: <20220720132830.193747-4-dakr@redhat.com>
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
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/drm_auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
index 6e433d465f41..63395bebaa6b 100644
--- a/drivers/gpu/drm/drm_auth.c
+++ b/drivers/gpu/drm/drm_auth.c
@@ -140,7 +140,7 @@ struct drm_master *drm_master_create(struct drm_device *dev)
 
 	kref_init(&master->refcount);
 	drm_master_legacy_init(master);
-	idr_init(&master->magic_map);
+	idr_init_base(&master->magic_map, 1);
 	master->dev = dev;
 
 	/* initialize the tree of output resource lessees */
-- 
2.36.1

