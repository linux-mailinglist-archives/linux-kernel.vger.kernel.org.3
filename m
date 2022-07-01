Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D83563983
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiGATCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 15:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiGATCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 15:02:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05E8537AB7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 12:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656702163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YteOKhi7iNsOx5ZA+OArdj5sj8Ut6l24ccYKF/bIe0s=;
        b=GqSdi61o6t1B+ywiPCNaj2MA4de4hVgL5EdFHEuyMBGnrKj/ZvhvIfjd6ebNPdQu1Ktfth
        i3yTIHdQEucUj5ySMzYChdTIC4yrDDy65GA4g7CimeNd7CCWHqGWOZeq7KmtzxkHpOjqgk
        pspT2eLyeOYeeUM+8J+mG2Ghm/E+qAw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-T2Q3LSJJPOuyN2TunXSfVg-1; Fri, 01 Jul 2022 15:02:42 -0400
X-MC-Unique: T2Q3LSJJPOuyN2TunXSfVg-1
Received: by mail-wr1-f72.google.com with SMTP id g10-20020adfa58a000000b0021d419f7751so554246wrc.23
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 12:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YteOKhi7iNsOx5ZA+OArdj5sj8Ut6l24ccYKF/bIe0s=;
        b=kgA+C9Wrny83HZ17bvF6d2oGI2fb1DT690YMcetbpVexokyB3TfCn3ARwUnXODob50
         IU245TViny6mbdsLPdAJMiHDc/YqinxbenRPF70B2UwzFWD8MnhbE3iXMSrZaO/LKSld
         FZzLIfzhhO0Rk14/CeQHtbp3tBNy3GzKg1m1E9M+MWrULBowAongqkWrfm5zUZbAPjMR
         4L9jWDjxsneIE+jyKzCGhlAHj1qviXAvF5Aj6K+SuJg2EJo17LnD/mnz9wJO0183C1RG
         xa0wVSePFiLiIE3C/lkTPAWzp7S58Ivr6fskGUPKEdvm3mg9zIP0lnQQ7o1nhAZO2k6W
         /W7A==
X-Gm-Message-State: AJIora9vqJiMMrgtOUY7HhgAywNL7cIhtIRmXLQ8GcbUTocY/2KlOSfA
        3nykPCdQlXzuipYbk6cvgRez4SqGu+muOaR1sNsAgVfU8EwPAH/xg4BYK9QZY3VZQ9iSnfMw8yo
        UtMeT17b1YpZX2nNXfQc4566G
X-Received: by 2002:a05:600c:b51:b0:3a1:71b0:a115 with SMTP id k17-20020a05600c0b5100b003a171b0a115mr16121967wmr.41.1656702160941;
        Fri, 01 Jul 2022 12:02:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uM3icFRTP2WMGCU6/6wGy4YIyCDDU2SZS7oL9gjBlUFUHGDew/1gHUbRgopnBmk7qSWOngag==
X-Received: by 2002:a05:600c:b51:b0:3a1:71b0:a115 with SMTP id k17-20020a05600c0b5100b003a171b0a115mr16121946wmr.41.1656702160728;
        Fri, 01 Jul 2022 12:02:40 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b0039c5642e430sm12535470wmq.20.2022.07.01.12.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 12:02:40 -0700 (PDT)
From:   dakr@redhat.com
To:     airlied@linux.ie, daniel@ffwll.ch, christian.koenig@amd.com,
        emma@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 10/10] drm/todo: remove task for idr_init_base()
Date:   Fri,  1 Jul 2022 21:02:27 +0200
Message-Id: <20220701190227.284783-3-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220701190227.284783-1-dakr@redhat.com>
References: <20220701185303.284082-1-dakr@redhat.com>
 <20220701190227.284783-1-dakr@redhat.com>
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

All IDRs in the DRM core and drivers which are applicable for using
idr_init_base() over idr_init() should be set up to use a proper base in
order to avoid unnecessary tree walks.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 Documentation/gpu/todo.rst | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 10bfb50908d1..de226ccc2c54 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -322,18 +322,6 @@ Contact: Daniel Vetter, Noralf Tronnes
 
 Level: Advanced
 
-idr_init_base()
----------------
-
-DRM core&drivers uses a lot of idr (integer lookup directories) for mapping
-userspace IDs to internal objects, and in most places ID=0 means NULL and hence
-is never used. Switching to idr_init_base() for these would make the idr more
-efficient.
-
-Contact: Daniel Vetter
-
-Level: Starter
-
 struct drm_gem_object_funcs
 ---------------------------
 
-- 
2.36.1

