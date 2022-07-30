Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A81D585AA3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 16:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbiG3N5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 09:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiG3N5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 09:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 987DA19C24
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 06:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659189434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1f70MssFhBYEHYXeD4+sKykEagtXma9/kZU4YNZRu5w=;
        b=cLJP0+93HFe3gkZZnOM8iRuyRS1myYmcmQ9slGlcKmszjmYfIC2adipz4CROMT+ojhIRo0
        6Sy0q2woONWYlThtfSlnraYIrpJLLe3QiEb7bLpm7UlqmoYQL5mhx3JsGkQhjDw1rPiEAk
        YqyAi2GhCd16SQ1m+/DOOs41nZFFESk=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-MBsJ03M_MayZkB0JCxlq8w-1; Sat, 30 Jul 2022 09:57:13 -0400
X-MC-Unique: MBsJ03M_MayZkB0JCxlq8w-1
Received: by mail-oo1-f69.google.com with SMTP id g24-20020a4a6b18000000b0042886f34138so3292462ooc.19
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 06:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1f70MssFhBYEHYXeD4+sKykEagtXma9/kZU4YNZRu5w=;
        b=HOtFwX5rOuasKv8u0uzB6m438p8f717fB53QYzTM/a4wlxhmiMyqBxJHDjgipevIHg
         bJO09AHH3UmJnv4ou3z5iR7gl8m1ynIudYa3RxbnwGP1k1HXVF43UyBQbnd4Sz/Jr+R4
         jw0XKAWLzkp8Vbtng73CwJrfXoHAHV1HneH2bN1U0GbgriOXDujVnVguviiqiGwKtnRs
         4WCFTJMuLkysoECAHWBZAHM0Y3PZB5q/jHEbYxP1lkM3xGucpCD2N767OId/sX7ZXajV
         iIc8ZvnC8t+Rf+O+SwZq+pcfFkCcGmuYEz9+q7m7gNrJAUaIxlRtGetCyZ5hcRaIY8GF
         bElQ==
X-Gm-Message-State: AJIora/b2XwTG8V90JPTDo6netQp7WTj0wQ5NKWIh1eyzppn058xfgQr
        Zi+g33VS14qFv84BTNhTJd6AXTFv75c0avfrOB/V6Bd6RQhbIdjcEAcNrk90oig7VUToUB+jbZb
        pIMx/RYmq+gx6Bs3JtRTbCt7c
X-Received: by 2002:a05:6808:ec6:b0:337:ae28:d6a4 with SMTP id q6-20020a0568080ec600b00337ae28d6a4mr3722925oiv.218.1659189431998;
        Sat, 30 Jul 2022 06:57:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tqYuNzkkPpQ1CwLa1Ls+3mSVLhrznsOlH7yFqnyWC40TTHuKs+AylpDa/QQqRafAqTOqWQ2g==
X-Received: by 2002:a05:6808:ec6:b0:337:ae28:d6a4 with SMTP id q6-20020a0568080ec600b00337ae28d6a4mr3722920oiv.218.1659189431690;
        Sat, 30 Jul 2022 06:57:11 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a40-20020a056870d62800b0010e00d6a1c0sm1919050oaq.51.2022.07.30.06.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 06:57:11 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     zackr@vmware.com, linux-graphics-maintainer@vmware.com,
        airlied@linux.ie, daniel@ffwll.ch, cai.huoqing@linux.dev
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/vmwgfx: cleanup comments
Date:   Sat, 30 Jul 2022 09:57:04 -0400
Message-Id: <20220730135704.2889434-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
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

Remove second 'should'

Spelling replacements
aqcuire     -> acquire
applcations -> applications
assumings   -> assumes
begining    -> beginning
commited    -> committed
contol      -> control
inbetween   -> in between
resorces    -> resources
succesful   -> successful
successfule -> successful

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/vmwgfx/device_include/vm_basic_types.h | 2 +-
 drivers/gpu/drm/vmwgfx/ttm_object.h                    | 4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                     | 2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c             | 8 ++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                    | 2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c               | 8 ++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c        | 2 +-
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/device_include/vm_basic_types.h b/drivers/gpu/drm/vmwgfx/device_include/vm_basic_types.h
index 1f6e3bbc6605..f84376718086 100644
--- a/drivers/gpu/drm/vmwgfx/device_include/vm_basic_types.h
+++ b/drivers/gpu/drm/vmwgfx/device_include/vm_basic_types.h
@@ -121,7 +121,7 @@ typedef __attribute__((aligned(32))) struct MKSGuestStatInfoEntry {
  *
  * Since the MKSGuestStatInfoEntry structures contain userlevel
  * pointers, the InstanceDescriptor also contains pointers to the
- * begining of these sections allowing the host side code to correctly
+ * beginning of these sections allowing the host side code to correctly
  * interpret the pointers.
  *
  * Because the host side code never acknowledges anything back to the
diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.h b/drivers/gpu/drm/vmwgfx/ttm_object.h
index 4c8700027c6d..1a2fa0f83f5f 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.h
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.h
@@ -96,7 +96,7 @@ struct ttm_object_device;
  *
  * This struct is intended to be used as a base struct for objects that
  * are visible to user-space. It provides a global name, race-safe
- * access and refcounting, minimal access contol and hooks for unref actions.
+ * access and refcounting, minimal access control and hooks for unref actions.
  */
 
 struct ttm_base_object {
@@ -138,7 +138,7 @@ struct ttm_prime_object {
  *
  * @tfile: Pointer to a struct ttm_object_file.
  * @base: The struct ttm_base_object to initialize.
- * @shareable: This object is shareable with other applcations.
+ * @shareable: This object is shareable with other applications.
  * (different @tfile pointers.)
  * @type: The object type.
  * @refcount_release: See the struct ttm_base_object description.
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 85a66014c2b6..58246471597c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -729,7 +729,7 @@ int vmw_user_bo_lookup(struct drm_file *filp,
  * Any persistent usage of the object requires a refcount to be taken using
  * ttm_bo_reference_unless_doomed(). Iff this function returns successfully it
  * needs to be paired with vmw_user_bo_noref_release() and no sleeping-
- * or scheduling functions may be called inbetween these function calls.
+ * or scheduling functions may be called in between these function calls.
  *
  * Return: A struct vmw_buffer_object pointer if successful or negative
  * error pointer on failure.
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
index 415774fde796..82ef58ccdd42 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c
@@ -36,7 +36,7 @@
  * @res: Refcounted pointer to a struct vmw_resource.
  * @hash: Hash entry for the manager hash table.
  * @head: List head used either by the staging list or the manager list
- * of commited resources.
+ * of committed resources.
  * @state: Staging state of this resource entry.
  * @man: Pointer to a resource manager for this entry.
  */
@@ -51,9 +51,9 @@ struct vmw_cmdbuf_res {
 /**
  * struct vmw_cmdbuf_res_manager - Command buffer resource manager.
  *
- * @resources: Hash table containing staged and commited command buffer
+ * @resources: Hash table containing staged and committed command buffer
  * resources
- * @list: List of commited command buffer resources.
+ * @list: List of committed command buffer resources.
  * @dev_priv: Pointer to a device private structure.
  *
  * @resources and @list are protected by the cmdbuf mutex for now.
@@ -118,7 +118,7 @@ static void vmw_cmdbuf_res_free(struct vmw_cmdbuf_res_manager *man,
  * This function commits a list of command buffer resource
  * additions or removals.
  * It is typically called when the execbuf ioctl call triggering these
- * actions has commited the fifo contents to the device.
+ * actions has committed the fifo contents to the device.
  */
 void vmw_cmdbuf_res_commit(struct list_head *list)
 {
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index 7046dfd0d1c6..85f86faa3243 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -70,7 +70,7 @@ struct vmw_du_update_plane {
 	 *
 	 * Some surface resource or buffer object need some extra cmd submission
 	 * like update GB image for proxy surface and define a GMRFB for screen
-	 * object. That should should be done here as this callback will be
+	 * object. That should be done here as this callback will be
 	 * called after FIFO allocation with the address of command buufer.
 	 *
 	 * This callback is optional.
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index a7d62a4eb47b..f66caa540e14 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -525,7 +525,7 @@ void vmw_resource_unreserve(struct vmw_resource *res,
  *                             for a resource and in that case, allocate
  *                             one, reserve and validate it.
  *
- * @ticket:         The ww aqcquire context to use, or NULL if trylocking.
+ * @ticket:         The ww acquire context to use, or NULL if trylocking.
  * @res:            The resource for which to allocate a backup buffer.
  * @interruptible:  Whether any sleeps during allocation should be
  *                  performed while interruptible.
@@ -686,7 +686,7 @@ static int vmw_resource_do_evict(struct ww_acquire_ctx *ticket,
  * @intr: Perform waits interruptible if possible.
  * @dirtying: Pending GPU operation will dirty the resource
  *
- * On succesful return, any backup DMA buffer pointed to by @res->backup will
+ * On successful return, any backup DMA buffer pointed to by @res->backup will
  * be reserved and validated.
  * On hardware resource shortage, this function will repeatedly evict
  * resources of the same type until the validation succeeds.
@@ -804,7 +804,7 @@ void vmw_resource_unbind_list(struct vmw_buffer_object *vbo)
  * @dx_query_mob: Buffer containing the DX query MOB
  *
  * Read back cached states from the device if they exist.  This function
- * assumings binding_mutex is held.
+ * assumes binding_mutex is held.
  */
 int vmw_query_readback_all(struct vmw_buffer_object *dx_query_mob)
 {
@@ -1125,7 +1125,7 @@ int vmw_resources_clean(struct vmw_buffer_object *vbo, pgoff_t start,
 	}
 
 	/*
-	 * In order of increasing backup_offset, clean dirty resorces
+	 * In order of increasing backup_offset, clean dirty resources
 	 * intersecting the range.
 	 */
 	while (found) {
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c
index 483ad544ea54..0d51b4542269 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_simple_resource.c
@@ -196,7 +196,7 @@ vmw_simple_resource_create_ioctl(struct drm_device *dev, void *data,
  * type.
  *
  * Returns: Refcounted pointer to the embedded struct vmw_resource if
- * successfule. Error pointer otherwise.
+ * successful. Error pointer otherwise.
  */
 struct vmw_resource *
 vmw_simple_resource_lookup(struct ttm_object_file *tfile,
-- 
2.27.0

