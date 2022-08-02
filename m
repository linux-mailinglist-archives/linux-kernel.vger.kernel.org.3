Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A1F5874AA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 02:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbiHBAEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 20:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbiHBAEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 20:04:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC4DE47B9C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 17:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659398661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U6SzF5bzrdmxIOn5tTpulDRO8riGmWkL+mC1UkjRs+s=;
        b=Yt8B7K+fyeV/BhczjHZyTPri3ixicpIHFSYJCDbHEmXiVo4OJSPhOE1ix0P+8RVKlnVBSX
        3HnejyMbge2WD4DieEVi+LNE6aiNSungcI25NL7BoCDLw4pmu026c1tg8NH2n5KSqGjK4U
        xk7X1nERWAJ30X3wW4uR+0OxygU0qrk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-9L4Vq8-0MFGdO92WQauNyQ-1; Mon, 01 Aug 2022 20:04:20 -0400
X-MC-Unique: 9L4Vq8-0MFGdO92WQauNyQ-1
Received: by mail-ed1-f69.google.com with SMTP id y16-20020a056402359000b0043db5186943so2161199edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 17:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=U6SzF5bzrdmxIOn5tTpulDRO8riGmWkL+mC1UkjRs+s=;
        b=3tz7lc6hX3NeLyS/lz2EfX5CINdNFmsakY3Z/ZGUgtHRLRs5eYh9fWiaTxEnMKtswC
         Go/iJkF8u5Bmy7mVyoJ0H62GwbiIvu/UH/3j+sbc6eFeisSC7cAkCXJL3Fu7jUYlDplL
         +QnZxHVowV0G2GXCj+YtGrgKVg4/y8yj5vmOjy+IF1dsV0RtP7auZHAmGO3Dnl1v9Qig
         hEb4BBcTM9DKPKuiEXivujrHf67fIbaHjd1PqLwmedvexR19swGo7W+1FuRwLkUhc91t
         A6Q4EovlV0zCw2sXWO+dMwttbi/Bu/9KynDsxbHfRMh+WSEwfXwHqxVv6xiahyDUlOh0
         DzvA==
X-Gm-Message-State: ACgBeo0nDEjyctaeBkNI0/gjL//QZjfwElicGMZZoOFX8ZhZL5CYjySQ
        UOr49Mn4et6TO0npHlHLEXQJwPrzM1Td4l68Nd+P6aXJLG8pOKG1DHF9dIEWkXfTHPdQjUnDHT4
        DpyGhY5A/53FgHF8c+k6BZgl7
X-Received: by 2002:a17:907:3e20:b0:730:7528:d7d7 with SMTP id hp32-20020a1709073e2000b007307528d7d7mr6521268ejc.136.1659398659622;
        Mon, 01 Aug 2022 17:04:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6thFS7LA8ACR06UD7XqVrl7c5feAQorB6NJrtwmpPXzDw1vuirxz8o3tTHC8XQS8w9dnrsLg==
X-Received: by 2002:a17:907:3e20:b0:730:7528:d7d7 with SMTP id hp32-20020a1709073e2000b007307528d7d7mr6521253ejc.136.1659398659502;
        Mon, 01 Aug 2022 17:04:19 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id s4-20020a056402036400b0043cbdb16fbbsm7461686edw.24.2022.08.01.17.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 17:04:17 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, tzimmermann@suse.de, mripard@kernel.org,
        sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v7 5/5] drm/todo: remove task to rename CMA helpers
Date:   Tue,  2 Aug 2022 02:04:05 +0200
Message-Id: <20220802000405.949236-6-dakr@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220802000405.949236-1-dakr@redhat.com>
References: <20220802000405.949236-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both, GEM and FB, CMA helpers were renamed to "GEM DMA" and "FB DMA",
hence the task can be removed.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 Documentation/gpu/todo.rst | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index de226ccc2c54..7634c27ac562 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -331,19 +331,6 @@ converted, except for struct drm_driver.gem_prime_mmap.
 
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
2.37.1

