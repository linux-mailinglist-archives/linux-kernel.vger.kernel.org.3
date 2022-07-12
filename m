Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7598571131
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 06:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiGLEXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 00:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiGLEXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 00:23:11 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CBC1F61A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 21:23:10 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id a127-20020a624d85000000b00525950b1feeso1722636pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 21:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=l0wfKFp1ChJwLpur4LprhadUuGsHQU0cjcxPkM3pYu4=;
        b=eydKoO5rr2LXznt/oww6+I4+oHMBcV+Dwp7kSgxo9xRjUefqx0WxWfSdeO3AxvGYYj
         hsbSG89K48k1wHNBwKqVXwB4ofsdmPYEfk7Tk86cLkHc+Ms3I405DLnGYDvAKbkNi4ex
         U3I3Einb3hgUR0L5bGLbAMK4OpK9znX82Cr5WUWNPlHXK4iGpg+y13GfASX6npa6IDRg
         v1YUro0KQNVjiENneup57QrtMLdxPCJZgx1WkoMYa61nJIGISoxF/UKZs4uBzEyuMdVV
         26/EMVsIfmf4m7JWn+Sc1AXe79CcmcNQPyvFhD4NgRUzPgcH4DmNRUZCmfcZ3zCGOQa8
         +mIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=l0wfKFp1ChJwLpur4LprhadUuGsHQU0cjcxPkM3pYu4=;
        b=YbHVi3B36tx5FJtolP0DLY9BxGQjD3UpcLQiPU0VUUQfIbvvsST+6t31AtQyQiqI16
         8oDDjvvaGp7APvyb2eoICQ4eiFJ7JZVEp9STmH1veG39upQvic9Tx8b8noysj7EomHVv
         BFgw7m27PIbCRKj+BeZu9GW1+2L8odUwGB9nCZIkkMWTpwKeK8NYQl+IniIE+1oaYrdg
         tMUgHtK7Y6nZEPl4qhPcSz75KsxtfPitFNPvybrfGdO+JtBgtzqo9G3SJhYt5I7oqleS
         HrhzeXna1MJFq1XmktZ55PNFKEInJpdp9Y9RA3MdKzHPgUi2zDeKJa9BNzk0SBWwWP3P
         DsuQ==
X-Gm-Message-State: AJIora8+AsDU6bBEcFBbazKmCt6jo4ZF2U8zzXouZU91tKRXdpRoUPiE
        LzuDWvQx9K3kTPWzqJbshlBVsMZ2D6YuX4Gq2cX76IbgcjRLDbM3jm0jas9ZVszmFxjS+uxP0EH
        L66XIjXdygz01SczbZW6uFD6BMUltk5Q0emH9fn8+Yl18sVT10f82OQI3Tsxn2SXJVVsI+fo=
X-Google-Smtp-Source: AGRyM1uSdSVTczuhdh9+VldYWcIPNC0HCxNLlu3dXeAxplL3jRHHA4OEjhvR03xbY4z9GwTDsOqdoWRnLtF/
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90a:de12:b0:1ef:ae83:d225 with SMTP id
 m18-20020a17090ade1200b001efae83d225mr2026908pjv.207.1657599790067; Mon, 11
 Jul 2022 21:23:10 -0700 (PDT)
Date:   Tue, 12 Jul 2022 04:22:57 +0000
In-Reply-To: <20220712042258.293010-1-jstultz@google.com>
Message-Id: <20220712042258.293010-2-jstultz@google.com>
Mime-Version: 1.0
References: <20220712042258.293010-1-jstultz@google.com>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [RFC][PATCH 2/3] drm: vgem: Enable SYNCOBJ and SYNCOBJ_TIMELINE on
 vgem driver
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jason Ekstrand <jason@jlekstrand.net>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Chunming Zhou <david1.zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows for basic SYNCOBJ api testing, in environments
like VMs where there may not be a supported drm driver.

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jason Ekstrand <jason@jlekstrand.net>
Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Cc: Chunming Zhou <david1.zhou@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: John Stultz <jstultz@google.com>
---
 drivers/gpu/drm/vgem/vgem_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_dr=
v.c
index c5e3e5457737..e5427d7399da 100644
--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -109,7 +109,8 @@ static struct drm_gem_object *vgem_gem_create_object(st=
ruct drm_device *dev, siz
 }
=20
 static const struct drm_driver vgem_driver =3D {
-	.driver_features		=3D DRIVER_GEM | DRIVER_RENDER,
+	.driver_features		=3D DRIVER_GEM | DRIVER_RENDER |
+					  DRIVER_SYNCOBJ | DRIVER_SYNCOBJ_TIMELINE,
 	.open				=3D vgem_open,
 	.postclose			=3D vgem_postclose,
 	.ioctls				=3D vgem_ioctls,
--=20
2.37.0.144.g8ac04bfd2-goog

