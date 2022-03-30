Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94734EC979
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348712AbiC3QTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348693AbiC3QS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:18:58 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2831FDEFF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:17:13 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id d15-20020a9d72cf000000b005cda54187c3so15243510otk.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=vuEnLJ19vsPpEYtmhA/N2c2iE3FXZJsfXS8pCpbwyeI=;
        b=SVvmOryWc6YP1SQQ2Cc7u/n53zTpzKfv0zGLTzX0DPPxYurtAzkwMQYY0oSCbW9Oq8
         payS0h5OWpfEZ5+g8dK0xmZc3Vlao1aj8hus9HyYx9/5t6oS+xgmZyl8jIn6oLLhbIUn
         TZeHBnUfAZVXBAWLRzphGz7eA+oy5BXW+P+fHHUbctjgKxZsL3jhBcnaG6w3A7vQaFjv
         2kPIgch506HGxpevQX/cvJ0I4YFmJjy307H1aFKYBmK+iW8vEnjIFnRk85XU4GE+KsNx
         gWMHSBtiJxVMLxKr08bQeaU7dkqZq1dQss2L8eV0GpMI5ptvpZkQwPG5Rf/v2i6+rik0
         OhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vuEnLJ19vsPpEYtmhA/N2c2iE3FXZJsfXS8pCpbwyeI=;
        b=JuAAwo10pUSTDq/KnGlTP3faoMuUAbomCy8iRrwPoULpDvsL27YArVttGLeKdlZ1Zb
         8wv045buFNriVYPeTwtckooD25IE/rlQ5bJNINuSymKlx4MYtp8esuA5v5ZQTllw/tc9
         dZT1uy4k5Bl4OCl0jutxNyTjR/AsXXQ2hgizdzt3PiXCUwNutcvhHIl7BknPuyPkgsJZ
         g0Uggqn8gem7h1STGHMFw4hVZE4BoYTz3iwR9DEGNFNCwYmaXuPvfiUl551TS6B6PnVT
         ClO14Cr8RtGZXeXLLou7dQAf5YIodKLtcM0Q64G6vL/JzRzVK8ZPLKXI5VZpJkBORAPw
         xI7g==
X-Gm-Message-State: AOAM531f0CQx32Wdu/n9RxM2tZVktIV5fu0FGOrzg+tLORMlSHow6lhz
        T1hgBUODhUzV6YWlP9qNIN5Nw/czGpI=
X-Google-Smtp-Source: ABdhPJyQT7UGu+atLDZeY+jfTEIPxsW25O3gOlcaWjwvDX6k0nbakXM6rZgkIMjFnKONnWTP7dK4aA==
X-Received: by 2002:a9d:62d2:0:b0:5b2:4662:f466 with SMTP id z18-20020a9d62d2000000b005b24662f466mr3517433otk.304.1648657032411;
        Wed, 30 Mar 2022 09:17:12 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.19.239.165])
        by smtp.gmail.com with ESMTPSA id m15-20020a9d644f000000b005ce0a146bfcsm836404otl.59.2022.03.30.09.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 09:17:11 -0700 (PDT)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8D63A40407; Wed, 30 Mar 2022 13:17:08 -0300 (-03)
Date:   Wed, 30 Mar 2022 13:17:08 -0300
To:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Matthew Auld <matthew.auld@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH FYI] tools headers UAPI: Sync drm/i915_drm.h with the kernel
 sources
Message-ID: <YkSChHqaOApscFQ0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

---

To pick up the changes in:

  caa574ffc4aaf4f2 ("drm/i915/uapi: document behaviour for DG2 64K support")

That don't add any new ioctl, so no changes in tooling.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Link: http://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/i915_drm.h | 45 +++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 914ebd9290e5192d..05c3642aaece4429 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -1118,10 +1118,16 @@ struct drm_i915_gem_exec_object2 {
 	/**
 	 * When the EXEC_OBJECT_PINNED flag is specified this is populated by
 	 * the user with the GTT offset at which this object will be pinned.
+	 *
 	 * When the I915_EXEC_NO_RELOC flag is specified this must contain the
 	 * presumed_offset of the object.
+	 *
 	 * During execbuffer2 the kernel populates it with the value of the
 	 * current GTT offset of the object, for future presumed_offset writes.
+	 *
+	 * See struct drm_i915_gem_create_ext for the rules when dealing with
+	 * alignment restrictions with I915_MEMORY_CLASS_DEVICE, on devices with
+	 * minimum page sizes, like DG2.
 	 */
 	__u64 offset;
 
@@ -3144,11 +3150,40 @@ struct drm_i915_gem_create_ext {
 	 *
 	 * The (page-aligned) allocated size for the object will be returned.
 	 *
-	 * Note that for some devices we have might have further minimum
-	 * page-size restrictions(larger than 4K), like for device local-memory.
-	 * However in general the final size here should always reflect any
-	 * rounding up, if for example using the I915_GEM_CREATE_EXT_MEMORY_REGIONS
-	 * extension to place the object in device local-memory.
+	 *
+	 * DG2 64K min page size implications:
+	 *
+	 * On discrete platforms, starting from DG2, we have to contend with GTT
+	 * page size restrictions when dealing with I915_MEMORY_CLASS_DEVICE
+	 * objects.  Specifically the hardware only supports 64K or larger GTT
+	 * page sizes for such memory. The kernel will already ensure that all
+	 * I915_MEMORY_CLASS_DEVICE memory is allocated using 64K or larger page
+	 * sizes underneath.
+	 *
+	 * Note that the returned size here will always reflect any required
+	 * rounding up done by the kernel, i.e 4K will now become 64K on devices
+	 * such as DG2.
+	 *
+	 * Special DG2 GTT address alignment requirement:
+	 *
+	 * The GTT alignment will also need to be at least 2M for such objects.
+	 *
+	 * Note that due to how the hardware implements 64K GTT page support, we
+	 * have some further complications:
+	 *
+	 *   1) The entire PDE (which covers a 2MB virtual address range), must
+	 *   contain only 64K PTEs, i.e mixing 4K and 64K PTEs in the same
+	 *   PDE is forbidden by the hardware.
+	 *
+	 *   2) We still need to support 4K PTEs for I915_MEMORY_CLASS_SYSTEM
+	 *   objects.
+	 *
+	 * To keep things simple for userland, we mandate that any GTT mappings
+	 * must be aligned to and rounded up to 2MB. The kernel will internally
+	 * pad them out to the next 2MB boundary. As this only wastes virtual
+	 * address space and avoids userland having to copy any needlessly
+	 * complicated PDE sharing scheme (coloring) and only affects DG2, this
+	 * is deemed to be a good compromise.
 	 */
 	__u64 size;
 	/**
-- 
2.35.1

