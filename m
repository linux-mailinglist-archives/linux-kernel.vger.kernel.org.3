Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A009C57B76C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiGTN2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiGTN2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:28:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E46032A41A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658323719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RapKFRgB4EzGxXQV5igUnFMX4O8hQnrKv2Yj7n/KS4Q=;
        b=A+ehU1db4loct4aSEnjtm8c94B+FhVhl+iVJTB1LQl6lmOaJFoxVRscmK9j5KkrtMN/2dz
        va0GFn309Fk6UoyGW4lGAF2Yj1LHx+fIFtjVM6uQh4dzKRdXbkCWvoGDvag3tX6FcJDeDm
        GOZh+a5l6aIxy7JSvgIpUn+8sv3jbbo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-381-jLkDzScmNi2QWksGcrHfFw-1; Wed, 20 Jul 2022 09:28:35 -0400
X-MC-Unique: jLkDzScmNi2QWksGcrHfFw-1
Received: by mail-ed1-f70.google.com with SMTP id f13-20020a0564021e8d00b00437a2acb543so11985020edf.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RapKFRgB4EzGxXQV5igUnFMX4O8hQnrKv2Yj7n/KS4Q=;
        b=nKwOiBY9gvR6ShlxN9zSTVBSrlM9v1f8g1GNiu3qwFZXvP5i+8xGYdX++QQKn1wZo0
         fN24u0Mo/53SrSt1uSC9JNxeYMgcMJKm8YLhKzJZ+V289Ol28yBoQKgLjoB+TlkhaAff
         41uO+/aarvSFrIGLe5NpMBDwKcT3XEwSnl/HnWVfq7IpVADy7AcdYXh8Z/fSPlHrhMFw
         PuOCoe2B2+ecXLVrdWuc8SSKhFmsbje0raNzWQ9HqZlifuEMN38R2OmS+HBcpLyDb7RZ
         WrxkIAxTVfUYDr44P5O2AaAL4ljO8ss8j+TsMUBT+rW298n8gBiRlJSYGkx+7YlQwJcP
         Rf5g==
X-Gm-Message-State: AJIora9F0Hgmk8rD2SFhwa7xhRjHOCAjSouKBLznJpA8WEdeYvCYfME/
        9tkKTKsGyOQB34PzcmAx1T417KLsy1Xx0iiv3Xh6eAUTEiRzJeClMR1M6L1F5BT33tfAuVXPw0/
        U/VMfIUnS7U43jSl1/P8yjp0E
X-Received: by 2002:a05:6402:3301:b0:43a:9ad4:633 with SMTP id e1-20020a056402330100b0043a9ad40633mr52855530eda.261.1658323713804;
        Wed, 20 Jul 2022 06:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tQq0kyj3KE44mUBEJcH3sju1Q79A1Wa0PoFJ7ZdXRKNvdRktSROjXwZ8IaoyiHd2Ux4Y6lfQ==
X-Received: by 2002:a05:6402:3301:b0:43a:9ad4:633 with SMTP id e1-20020a056402330100b0043a9ad40633mr52855504eda.261.1658323713593;
        Wed, 20 Jul 2022 06:28:33 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id x7-20020a05640225c700b0043ac761db43sm12220687edb.55.2022.07.20.06.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:28:33 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@linux.ie, daniel@ffwll.ch, mripard@kernel.org,
        christian.koenig@amd.com, emma@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND 00/10] drm: use idr_init_base() over idr_init() if applicable
Date:   Wed, 20 Jul 2022 15:28:20 +0200
Message-Id: <20220720132830.193747-1-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
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

This patch series initializes IDRs with idr_init_base(&idr, 1) rather than
idr_init(&idr) in case for the particular IDR no IDs < 1 are ever requested -
this avoids unnecessary tree walks.

Danilo Krummrich (10):
  drm/amdgpu: use idr_init_base() to initialize mgr->ctx_handles
  drm/amdgpu: use idr_init_base() to initialize fpriv->bo_list_handles
  drm: use idr_init_base() to initialize master->magic_map
  drm: use idr_init_base() to initialize master->lessee_idr
  drm: use idr_init_base() to initialize mode_config.object_idr
  drm: use idr_init_base() to initialize mode_config.tile_idr
  drm/sis: use idr_init_base() to initialize dev_priv->object_idr
  drm/v3d: use idr_init_base() to initialize v3d_priv->perfmon.idr
  drm/via: use idr_init_base() to initialize dev_priv->object_idr
  drm/todo: remove task for idr_init_base()

 Documentation/gpu/todo.rst              | 12 ------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  2 +-
 drivers/gpu/drm/drm_auth.c              |  4 ++--
 drivers/gpu/drm/drm_mode_config.c       |  4 ++--
 drivers/gpu/drm/sis/sis_drv.c           |  2 +-
 drivers/gpu/drm/v3d/v3d_perfmon.c       |  2 +-
 drivers/gpu/drm/via/via_map.c           |  2 +-
 8 files changed, 9 insertions(+), 21 deletions(-)

-- 
2.36.1

