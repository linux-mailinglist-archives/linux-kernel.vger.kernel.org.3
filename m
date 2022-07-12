Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E24C571130
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 06:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiGLEXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 00:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiGLEXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 00:23:10 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A2C1EAED
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 21:23:08 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id s22-20020a056a001c5600b0052ad646de49so1421421pfw.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 21:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=VlO5TFuuspvYhdi2DpaxD3h20t2f4OEaq2DrHe4AmmQ=;
        b=DyQYKlDD/IcOA4P9vRQKupo+DLs43KFlBZqdk7RIEWnyIoKW37RMSah45C6eYEV0Pm
         g5nMaKhzXoAXgpIRbOs8Hvpwhql49X/a5gts8RYFTlQS8kHBr/jlT4CwXOkM7fWuC1Do
         IEN7vOiitvjjkShkA3h3tDyqbl9aQbQ+Inv4lILFKGh8aSpXTjAToRD1J6Z8JQzh+Uax
         3p6oOnn6FW98eCFH1+r4bBQKI1IXw0aPOdKVDqrlbp0FbuToLO9O8T807GajNjxIjR5p
         lE4dXi0YR8Qnit7OyH1aLsKgZnO6jRRqB4XbBqcQmu6jOAFslutRoNCSZxWWb8o/GInk
         ZhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=VlO5TFuuspvYhdi2DpaxD3h20t2f4OEaq2DrHe4AmmQ=;
        b=gEWG1c77PlAwGehy46PkmhsE20tya72x6ZMYBmBmK7yO5uPHqYi9T7/Wcs5VbaiAmc
         zmMcSdLfeugtjQR4PWbPfEqVBtq2Mx6HKsXmORf8Dclwi9fF0qiBlS+zGAkiGNLF8dIr
         5E1/QTdK9RFlZ5OsO+Fv0tsKNx3vlJwXjjPnCF5XEw3Q4jZxicF/XITqceN6oQd90TS5
         5YDvSWI7M/guHg2HY4m6KG95/mggXw6Jgzaosje5SRJ7zSV1T3b4qg1GO5ucLg6TkLMc
         saOp5ZSZ2JfpjPo+lNk3QiREpGuFkpago7415G2LpzWDKHI6SqAYmBIfklMoL+y0+dpe
         UWJQ==
X-Gm-Message-State: AJIora+CcaLt8r5WkRPt+zhR3kZk9LuGNmBkiMzVBk5xO3+uvsyRvGNO
        x6JNSQff7ALoIaXuz6sy5oZ7TdKFDofI1l9jxGGrCiaEQ69HoqWBzHC11Ep60JpOfkTDG7kjSac
        m2JZxmjP/O6sZAEQlyOS+zM3fLX8Cnm1hTG/e9O1K9VUl1KcUd3tp0Hx/BIVQ2qjhg9S95AQ=
X-Google-Smtp-Source: AGRyM1u5ruiHHM3S6bje5uDXHiDhsX9GPjl/iquz7U8+/miDVMM2oXhlDLLmW1rox8AgppVRKHsmFfeak9oU
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:16ca:b0:525:a5d5:d16f with SMTP
 id l10-20020a056a0016ca00b00525a5d5d16fmr22040610pfc.9.1657599788310; Mon, 11
 Jul 2022 21:23:08 -0700 (PDT)
Date:   Tue, 12 Jul 2022 04:22:56 +0000
Message-Id: <20220712042258.293010-1-jstultz@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [RFC][PATCH 1/3] drm: drm_syncobj: Add note in DOC about absolute
 timeout values
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

After having to debug down through the kernel to figure out
why my _WAIT calls were always timing out, I realized its
an absolute timeout value instead of the more common relative
timeouts.

This detail should be called out in the documentation, as while
the absolute value makes sense here, its not as common for timeout
values.

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
 drivers/gpu/drm/drm_syncobj.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 7e48dcd1bee4..b84d842a1c21 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -136,6 +136,10 @@
  * requirement is inherited from the wait-before-signal behavior required =
by
  * the Vulkan timeline semaphore API.
  *
+ * It should be noted, that both &DRM_IOCTL_SYNCOBJ_WAIT and
+ * &DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT takes an *absolute* CLOCK_MONOT=
ONIC
+ * nanosecond value for the timeout value. Accidentally passing relative t=
ime
+ * values will likely result in an immediate -ETIME return.
  *
  * Import/export of syncobjs
  * -------------------------
--=20
2.37.0.144.g8ac04bfd2-goog

