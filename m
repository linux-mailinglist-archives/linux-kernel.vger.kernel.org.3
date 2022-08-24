Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA92659FF3D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239177AbiHXQOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238435AbiHXQNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:13:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC9499B4C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661357626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xeNvcv3iZHDY3QjzCkS4zy97GwENP8IMr7bik18mtU0=;
        b=OE753bvREchCGXSV92GquwE+8NQUTYzbOmwERLqhiKKpWdx7GBuUtwtM7HV1yhj/GJmeou
        dcpR/ei8DbtPCaW6Ya3oAEj8iXRaJYzVjCC6UWLG9bMPxH1NfSQ299ep77rabjkkYWESVX
        ZsCqz5bHGQVk4HninwwYY5Ouud5xEXg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-26-UxMvuoD4M7asxuymNvxCfQ-1; Wed, 24 Aug 2022 12:13:45 -0400
X-MC-Unique: UxMvuoD4M7asxuymNvxCfQ-1
Received: by mail-ed1-f72.google.com with SMTP id z6-20020a05640240c600b0043e1d52fd98so11408714edb.22
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xeNvcv3iZHDY3QjzCkS4zy97GwENP8IMr7bik18mtU0=;
        b=LsVv1L2YiMCqe9+jL/MtVNuxiAKKuGgKZ9u/aV8/2L7ojAS61+uAKEDk8oVVvb/9D/
         sA7izdBWOW++mYzTXlUJ6fuL1BKlGV2EZwRhdYMWfkYqOgj3VsqeDBAIiG734RYhaQdv
         llvZS+EpqqfzuV3dqb2fvObQEQoQgBSWSHf9u2QGG+vCR3sFzzUZey3LPsO2Gpil/hvN
         ZZeXNw5jCnlqC1SgCGRi2mhu61TnIHuAnaypUstAmkvvoUO71ZHkHhHpP1g9lZCMuBr6
         AwT42VOs86zjruu6IsI+LEz6fdjTLpETRR7OAYIepnLyKV+Z1+EKcB5x3fVjjQT1+FJe
         xpIg==
X-Gm-Message-State: ACgBeo2m4ioYkDUWz7V9/eS6oq7tj9bz4hLH8r7djY/qSvfli9zPruM+
        KZUHyw2hZrbFEEtaW2UHFNkXx0apoJHRAFyfVUkFAR5UXykP4GBzstEPEkR/NQNh385XCZEDT8Q
        p7C6sDReSjrFpv6uR7h21sIGY
X-Received: by 2002:a17:907:75f9:b0:73d:6285:4c94 with SMTP id jz25-20020a17090775f900b0073d62854c94mr3284821ejc.698.1661357624193;
        Wed, 24 Aug 2022 09:13:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR42pUAoJZIfv+Mz3pexbh+1Dso9JV7rlJIRNC0EIEP7SQm5xsOetB8XyvkV6EeX7//wS1zU/g==
X-Received: by 2002:a17:907:75f9:b0:73d:6285:4c94 with SMTP id jz25-20020a17090775f900b0073d62854c94mr3284812ejc.698.1661357624000;
        Wed, 24 Aug 2022 09:13:44 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id b9-20020a1709063f8900b0072aa009aa68sm1350511ejj.36.2022.08.24.09.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 09:13:43 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v3 4/4] drm/vc4: hvs: protect drm_print_regset32()
Date:   Wed, 24 Aug 2022 18:13:27 +0200
Message-Id: <20220824161327.330627-5-dakr@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220824161327.330627-1-dakr@redhat.com>
References: <20220824161327.330627-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vc4_hvs_dump_state() potentially freed resources are protected from
being accessed with drm_dev_enter()/drm_dev_exit().

Also include drm_print_regset32() in the protected section, since
drm_print_regset32() does access memory that is typically mapped via
devm_* calls.

Fixes: 969cfae1f01d ("drm/vc4: hvs: Protect device resources after removal")
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 9e823e0de197..4ac9f5a2d5f9 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -71,11 +71,11 @@ void vc4_hvs_dump_state(struct vc4_hvs *hvs)
 	struct drm_printer p = drm_info_printer(&hvs->pdev->dev);
 	int idx, i;
 
-	drm_print_regset32(&p, &hvs->regset);
-
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
+	drm_print_regset32(&p, &hvs->regset);
+
 	DRM_INFO("HVS ctx:\n");
 	for (i = 0; i < 64; i += 4) {
 		DRM_INFO("0x%08x (%s): 0x%08x 0x%08x 0x%08x 0x%08x\n",
-- 
2.37.2

