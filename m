Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CD55969FD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbiHQHCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiHQHCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:02:06 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 Aug 2022 00:02:05 PDT
Received: from us-smtp-delivery-110.mimecast.com (us-smtp-delivery-110.mimecast.com [170.10.129.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4D578BEB
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=globallogic.com;
        s=mimecast20210517; t=1660719723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pH7OvNNPsm5VQKGPpzNsRUdrZIopXa5V2ADSxMuiVQs=;
        b=mERMMUr1Y/Rh6Xobv06ZHhtldZSc5N6BoAeVJg5XDsam/5qR9wOpqwZTogDpLS0S5/Isl9
        ceshlDgJnUw7QRANYMvdabug0zbnBNnYYMG3EHo5M8fhGgxa9TpoOLRJX/X/BGl0T7f46a
        KyCSDg7SVyN8JlmGIrJjOWDKwHK4wljYNPHfdy8LZ0PvnLzqFAmik1MsK0cKPCVQ5hXcbU
        VhRcsVautFCtdRJxbu4dQfKEGv37v51qRq/sO4Ehj2ip5c5AQY5E056h/52zm3wz/dVXH7
        0fnC0RNNnEffh4SMwXDITlR/jpghNCFT9maNy53yt054t+OqI2zNU6scKcRifg==
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-267-vScHbiWYNuiILC-2SwC5GQ-1; Wed, 17 Aug 2022 03:00:58 -0400
X-MC-Unique: vScHbiWYNuiILC-2SwC5GQ-1
Received: by mail-lj1-f198.google.com with SMTP id w21-20020a2e9595000000b0025ec9280923so3827507ljh.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=1exQ5qdkhCvVq2PBAzpRU9G+dzwvsJeddbBUdhaFhX8=;
        b=WlkuI1Q5R1i/LHaTd9X2Xf7cMDuBE9mljfzP1RETFam/y7IO5nyNHK0/8ya/HVZyCF
         7Fa6qRo8YB+OTdriDuSnPhoudSSE5BDV7935c5h2rU7zG8KdYZNOCFKygXdKI+rmKl+g
         L0i6dmDHXfFMj8iu+GAVX/npiU+0C4e6hvENylxjpLi66ontvelkxuY2ZTdeXKR1H43w
         GyPBDFfl0rZVKBuQDOngz4TTHNg5zL+X4oxrz3UGHXV6KmsXAxPzd/8LN5j1z1z9QPY7
         QY8Q5Y5cufZrspDymbRPOqQjYvz9u8EGfzJyODkKhpKDfJbB0uxXzPul2hA0KDhcmjQ/
         f/ig==
X-Gm-Message-State: ACgBeo0qgBIgql4k9CGLXWyy7g5VB5r+vzLciooh5OtkK40+5h+4A5zA
        L17mlY63jSGcXQYU0Bbb7/rZUjMwp0YUtuf/si5QthDVxm3kdsnCiPPLuD4KrTZgvQywQb0pSUe
        gp1XQGS5i+Z0xjxqcFeyFtrM=
X-Received: by 2002:ac2:4562:0:b0:48b:2a91:e59 with SMTP id k2-20020ac24562000000b0048b2a910e59mr8050286lfm.91.1660719657145;
        Wed, 17 Aug 2022 00:00:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6a7nMNBiNK6k+E8U2fEcZfWVKJGSibaw9CkQYQp99t+6R5gMnJO2+WyETeLUoo4et3K4AZng==
X-Received: by 2002:ac2:4562:0:b0:48b:2a91:e59 with SMTP id k2-20020ac24562000000b0048b2a910e59mr8050281lfm.91.1660719656896;
        Wed, 17 Aug 2022 00:00:56 -0700 (PDT)
Received: from localhost.localdomain ([91.245.79.37])
        by smtp.googlemail.com with ESMTPSA id o18-20020a05651205d200b0048a91266268sm1592278lfo.232.2022.08.17.00.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 00:00:56 -0700 (PDT)
From:   Sviatoslav Peleshko <sviatoslav.peleshko@globallogic.com>
Cc:     Sviatoslav Peleshko <sviatoslav.peleshko@globallogic.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915: Fix random -ENOSPC eviction errors due to locked vma objects
Date:   Wed, 17 Aug 2022 09:55:41 +0300
Message-Id: <20220817065541.30101-1-sviatoslav.peleshko@globallogic.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: globallogic.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i915_gem_object_trylock we had in the grab_vma() makes it return false
when the vma->obj is already locked. In this case we'll skip this vma
during eviction, and eventually might be forced to return -ENOSPC even
though we could've evicted this vma if we waited for the lock a bit.

To fix this, replace the i915_gem_object_trylock with i915_gem_object_lock.
And because we have to worry about the potential deadlock now, bubble-up
the error code, so it will be correctly handled by the WW mechanism.

This fixes the issue https://gitlab.freedesktop.org/drm/intel/-/issues/6564

Fixes: 7e00897be8bf ("drm/i915: Add object locking to i915_gem_evict_for_no=
de and i915_gem_evict_something, v2.")
Signed-off-by: Sviatoslav Peleshko <sviatoslav.peleshko@globallogic.com>
---
 drivers/gpu/drm/i915/i915_gem_evict.c | 69 ++++++++++++++++++---------
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gem_evict.c b/drivers/gpu/drm/i915/i=
915_gem_evict.c
index f025ee4fa526..9d43f213f68f 100644
--- a/drivers/gpu/drm/i915/i915_gem_evict.c
+++ b/drivers/gpu/drm/i915/i915_gem_evict.c
@@ -55,49 +55,58 @@ static int ggtt_flush(struct intel_gt *gt)
 =09return intel_gt_wait_for_idle(gt, MAX_SCHEDULE_TIMEOUT);
 }
=20
-static bool grab_vma(struct i915_vma *vma, struct i915_gem_ww_ctx *ww)
+static int grab_vma(struct i915_vma *vma, struct i915_gem_ww_ctx *ww)
 {
+=09int ret =3D 0;
+
 =09/*
 =09 * We add the extra refcount so the object doesn't drop to zero until
 =09 * after ungrab_vma(), this way trylock is always paired with unlock.
 =09 */
 =09if (i915_gem_object_get_rcu(vma->obj)) {
-=09=09if (!i915_gem_object_trylock(vma->obj, ww)) {
+=09=09ret =3D i915_gem_object_lock(vma->obj, ww);
+=09=09if (ret)
 =09=09=09i915_gem_object_put(vma->obj);
-=09=09=09return false;
-=09=09}
 =09} else {
 =09=09/* Dead objects don't need pins */
 =09=09atomic_and(~I915_VMA_PIN_MASK, &vma->flags);
 =09}
=20
-=09return true;
+=09return ret;
 }
=20
-static void ungrab_vma(struct i915_vma *vma)
+static void ungrab_vma(struct i915_vma *vma, struct i915_gem_ww_ctx *ww)
 {
 =09if (dying_vma(vma))
 =09=09return;
=20
-=09i915_gem_object_unlock(vma->obj);
+=09if (!ww)
+=09=09i915_gem_object_unlock(vma->obj);
+
 =09i915_gem_object_put(vma->obj);
 }
=20
-static bool
+static int
 mark_free(struct drm_mm_scan *scan,
 =09  struct i915_gem_ww_ctx *ww,
 =09  struct i915_vma *vma,
 =09  unsigned int flags,
 =09  struct list_head *unwind)
 {
+=09int err;
+
 =09if (i915_vma_is_pinned(vma))
-=09=09return false;
+=09=09return -ENOSPC;
=20
-=09if (!grab_vma(vma, ww))
-=09=09return false;
+=09err =3D grab_vma(vma, ww);
+=09if (err)
+=09=09return err;
=20
 =09list_add(&vma->evict_link, unwind);
-=09return drm_mm_scan_add_block(scan, &vma->node);
+=09if (!drm_mm_scan_add_block(scan, &vma->node))
+=09=09return -ENOSPC;
+
+=09return 0;
 }
=20
 static bool defer_evict(struct i915_vma *vma)
@@ -150,6 +159,7 @@ i915_gem_evict_something(struct i915_address_space *vm,
 =09enum drm_mm_insert_mode mode;
 =09struct i915_vma *active;
 =09int ret;
+=09int err =3D 0;
=20
 =09lockdep_assert_held(&vm->mutex);
 =09trace_i915_gem_evict(vm, min_size, alignment, flags);
@@ -210,17 +220,23 @@ i915_gem_evict_something(struct i915_address_space *v=
m,
 =09=09=09continue;
 =09=09}
=20
-=09=09if (mark_free(&scan, ww, vma, flags, &eviction_list))
+=09=09err =3D mark_free(&scan, ww, vma, flags, &eviction_list);
+=09=09if (!err)
 =09=09=09goto found;
+=09=09if (err =3D=3D -EDEADLK)
+=09=09=09break;
 =09}
=20
 =09/* Nothing found, clean up and bail out! */
 =09list_for_each_entry_safe(vma, next, &eviction_list, evict_link) {
 =09=09ret =3D drm_mm_scan_remove_block(&scan, &vma->node);
 =09=09BUG_ON(ret);
-=09=09ungrab_vma(vma);
+=09=09ungrab_vma(vma, ww);
 =09}
=20
+=09if (err =3D=3D -EDEADLK)
+=09=09return err;
+
 =09/*
 =09 * Can we unpin some objects such as idle hw contents,
 =09 * or pending flips? But since only the GGTT has global entries
@@ -267,7 +283,7 @@ i915_gem_evict_something(struct i915_address_space *vm,
 =09=09=09__i915_vma_pin(vma);
 =09=09} else {
 =09=09=09list_del(&vma->evict_link);
-=09=09=09ungrab_vma(vma);
+=09=09=09ungrab_vma(vma, ww);
 =09=09}
 =09}
=20
@@ -277,17 +293,21 @@ i915_gem_evict_something(struct i915_address_space *v=
m,
 =09=09__i915_vma_unpin(vma);
 =09=09if (ret =3D=3D 0)
 =09=09=09ret =3D __i915_vma_unbind(vma);
-=09=09ungrab_vma(vma);
+=09=09ungrab_vma(vma, ww);
 =09}
=20
 =09while (ret =3D=3D 0 && (node =3D drm_mm_scan_color_evict(&scan))) {
 =09=09vma =3D container_of(node, struct i915_vma, node);
=20
 =09=09/* If we find any non-objects (!vma), we cannot evict them */
-=09=09if (vma->node.color !=3D I915_COLOR_UNEVICTABLE &&
-=09=09    grab_vma(vma, ww)) {
-=09=09=09ret =3D __i915_vma_unbind(vma);
-=09=09=09ungrab_vma(vma);
+=09=09if (vma->node.color !=3D I915_COLOR_UNEVICTABLE) {
+=09=09=09ret =3D grab_vma(vma, ww);
+=09=09=09if (!ret) {
+=09=09=09=09ret =3D __i915_vma_unbind(vma);
+=09=09=09=09ungrab_vma(vma, ww);
+=09=09=09} else if (ret !=3D -EDEADLK) {
+=09=09=09=09ret =3D -ENOSPC;
+=09=09=09}
 =09=09} else {
 =09=09=09ret =3D -ENOSPC;
 =09=09}
@@ -382,8 +402,11 @@ int i915_gem_evict_for_node(struct i915_address_space =
*vm,
 =09=09=09break;
 =09=09}
=20
-=09=09if (!grab_vma(vma, ww)) {
-=09=09=09ret =3D -ENOSPC;
+=09=09ret =3D grab_vma(vma, ww);
+=09=09if (ret) {
+=09=09=09if (ret !=3D -EDEADLK)
+=09=09=09=09ret =3D -ENOSPC;
+
 =09=09=09break;
 =09=09}
=20
@@ -405,7 +428,7 @@ int i915_gem_evict_for_node(struct i915_address_space *=
vm,
 =09=09if (ret =3D=3D 0)
 =09=09=09ret =3D __i915_vma_unbind(vma);
=20
-=09=09ungrab_vma(vma);
+=09=09ungrab_vma(vma, ww);
 =09}
=20
 =09return ret;
--=20
2.37.1

