Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E1B5AC718
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbiIDVnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbiIDVmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:42:37 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D5B2F037
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:31 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id d68so5629002iof.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4JXdBl/0qOwV/A52QqNijcawUGjQl7evE5vQaPe8I/Q=;
        b=Q6wDNH7ni+pezhZQtqZpJ97lJZANkr1r1w8Q0HIYBSFAhwljRqOGh9Iv19Gf64+llB
         frZm5l9a2D6+RrKMDxtJrGMvuFtfct+nV7wpbjJBApGvgbR/UCdA+edFFEWQV3yW5xZt
         Abl341qIlvY+ti5hONgL6a+0BiJXwAUlG16pl8y98ByU4SwhFvt6k2mPawMY8CGIW+5o
         XyF4e1Ssr9Pgjhu7rCIp5wA50OjjlhqxJNYWrilP5bH59brlOnduXsjVgJiJlrcuk94w
         aC5b1ZZDeZyRlOAFIdmJz1af5ykZ0tqCvavdXbRILxmEHXgITfMxjOp5/9nTnIUykGr1
         jaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4JXdBl/0qOwV/A52QqNijcawUGjQl7evE5vQaPe8I/Q=;
        b=JKLl1Ttk93FmbBC5wViZamc4njy6xzYC0tXdhJgtkeOfr3PX116dh7gkW5pZ8XNULg
         KjroQWX/4n81viFAx5vTOWlECbMsKSe6ImPKHC2PqEXihe7UVQJeUGISgvYp7EKfzqOr
         dKGf6M4MT2IoJKeYQd8yAiQ5T8+3uGxfNMTAm6IQgtcaAKVK6yUG3z/eehVypBzg6TnU
         aVioFvgGvbsnB2JvImRo5mQwUxHZv1OtWHZPb6BpVPK8epHco+4q3kB1y/lWFRCAHXHY
         USIQTHcALULUmaDhAMcX5RruohIw7elpfT8Vco9EIzFUQZY2iqKvGoRHKJLOsOyl3Qu2
         mLgQ==
X-Gm-Message-State: ACgBeo2dXiVgLkMUIazxzbZ2KicDLVSPov37XhYVlSLhSXJmm6DJ5xdH
        rh+EIA8rqs+wk6smLhVsRX84z4+kx1M=
X-Google-Smtp-Source: AA6agR4RtFxm49IqbK2hc+ajeSg5bxr0q7Z7xZNKzxnPnzjA/QHoeK8+UuSlF8s2NBv4jPh+uCHATQ==
X-Received: by 2002:a02:9a16:0:b0:350:636f:af9a with SMTP id b22-20020a029a16000000b00350636faf9amr4392137jal.191.1662327751171;
        Sun, 04 Sep 2022 14:42:31 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:30 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 22/57] drm_print: condense enum drm_debug_category
Date:   Sun,  4 Sep 2022 15:40:59 -0600
Message-Id: <20220904214134.408619-23-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904214134.408619-1-jim.cromie@gmail.com>
References: <20220904214134.408619-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enum drm_debug_category has 10 categories, but is initialized with
bitmasks which require 10 bits of underlying storage.  By using
natural enumeration, and moving the BIT(cat) into drm_debug_enabled(),
the enum fits in 4 bits, allowing the category to be represented
directly in pr_debug callsites, via the ddebug.class_id field.

While this slightly pessimizes the bit-test in drm_debug_enabled(),
using dyndbg with JUMP_LABEL will avoid the function entirely.

NOTE: this change forecloses the possibility of doing:

  drm_dbg(DRM_UT_CORE|DRM_UT_KMS, "weird 2-cat experiment")

but thats already strongly implied by the use of the enum itself; its
not a normal enum if it can be 2 values simultaneously.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/drm/drm_print.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 22fabdeed297..b3b470440e46 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -279,49 +279,49 @@ enum drm_debug_category {
 	 * @DRM_UT_CORE: Used in the generic drm code: drm_ioctl.c, drm_mm.c,
 	 * drm_memory.c, ...
 	 */
-	DRM_UT_CORE		= 0x01,
+	DRM_UT_CORE,
 	/**
 	 * @DRM_UT_DRIVER: Used in the vendor specific part of the driver: i915,
 	 * radeon, ... macro.
 	 */
-	DRM_UT_DRIVER		= 0x02,
+	DRM_UT_DRIVER,
 	/**
 	 * @DRM_UT_KMS: Used in the modesetting code.
 	 */
-	DRM_UT_KMS		= 0x04,
+	DRM_UT_KMS,
 	/**
 	 * @DRM_UT_PRIME: Used in the prime code.
 	 */
-	DRM_UT_PRIME		= 0x08,
+	DRM_UT_PRIME,
 	/**
 	 * @DRM_UT_ATOMIC: Used in the atomic code.
 	 */
-	DRM_UT_ATOMIC		= 0x10,
+	DRM_UT_ATOMIC,
 	/**
 	 * @DRM_UT_VBL: Used for verbose debug message in the vblank code.
 	 */
-	DRM_UT_VBL		= 0x20,
+	DRM_UT_VBL,
 	/**
 	 * @DRM_UT_STATE: Used for verbose atomic state debugging.
 	 */
-	DRM_UT_STATE		= 0x40,
+	DRM_UT_STATE,
 	/**
 	 * @DRM_UT_LEASE: Used in the lease code.
 	 */
-	DRM_UT_LEASE		= 0x80,
+	DRM_UT_LEASE,
 	/**
 	 * @DRM_UT_DP: Used in the DP code.
 	 */
-	DRM_UT_DP		= 0x100,
+	DRM_UT_DP,
 	/**
 	 * @DRM_UT_DRMRES: Used in the drm managed resources code.
 	 */
-	DRM_UT_DRMRES		= 0x200,
+	DRM_UT_DRMRES
 };
 
 static inline bool drm_debug_enabled(enum drm_debug_category category)
 {
-	return unlikely(__drm_debug & category);
+	return unlikely(__drm_debug & BIT(category));
 }
 
 /*
-- 
2.37.2

