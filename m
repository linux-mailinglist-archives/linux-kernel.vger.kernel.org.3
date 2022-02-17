Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4104B96FB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiBQDtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:49:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbiBQDtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:49:02 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC99C5DB1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:48:49 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id d7so1365078ilf.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eZXNUqubAB8NNsFmaxywjAoPOWysBIvPMcZdY6L3itE=;
        b=AwrxFJhmF4G+MvuDdELRdQNvbWui/ZmZm5aRVhg7QpY32AwSFVlNWa7zOXHeQ0e+cH
         wtknls6AXe3/sQ615mZwc3LxxjbFp5vdYoENvncru8NXiKtvRjVHDHOcc1czRzm11p/d
         5gMpGvKHvpvTD5QXZ7+3u0PE5bimGbjnxkwavRK/JEbo5dFnfHPVsji4YrIJWXz9uBRO
         0Lp/qC0XJyvGgMXBUJNhtBQzXfDabdhJ0aiT0Xn/+2m7taSwrj79YKTaGPXihjNwuE6y
         l5mZvDvxxG7gI/At8IpBjPFc32pigevpyz8mtnKwBqem5o0q5ZZ/unnFLYHjoX5mUiqL
         5kIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eZXNUqubAB8NNsFmaxywjAoPOWysBIvPMcZdY6L3itE=;
        b=GRQ7gd6tB+x8t09DE5yd++i7FazwCWMYb8dR4n1Evx4L8yitRuE6+i/JxpX8Ja1Ro1
         wnEjCliYJwF9mdt0GJ+U6G8s20DUES/sxxC+C/Fup0Ke84KyHATuIG8qjxfSqAuz/S+8
         bhzmqvAPehJDm8jL/BUmDq8bFHDJmqH1tgSk2m4SEl0zWbnYmm+ch5miIsgRCVwiiMyk
         0CDPJVTKQCqISy51F4vEoI4YChca8bt1RkK2X8356IOao81Fs4GkW1Qn4OVncDZTKFmX
         YjEkX0bm7DFdqFrdfy2CMzBC2cfAqLGjqeVKXPxw+BtCfxmOwAf3VyEDykktyKSms7co
         K6pg==
X-Gm-Message-State: AOAM5330r+JDvaQqw+jkXGvmsdWIUH7cMYOvFtB2EdYesIAt9wXEPzr4
        sG005zpMpTOfS0az1FJASDo=
X-Google-Smtp-Source: ABdhPJy1Fv4risoix7swzSlE1sOKWWdc6gcHljvdxt8ZU2IPf0XZA3hS8LpNHrUIAPX2AlZXkOxl1A==
X-Received: by 2002:a05:6e02:1a0d:b0:2bf:58c2:97af with SMTP id s13-20020a056e021a0d00b002bf58c297afmr770183ild.85.1645069728378;
        Wed, 16 Feb 2022 19:48:48 -0800 (PST)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::1b19])
        by smtp.googlemail.com with ESMTPSA id l16sm1127874ilc.54.2022.02.16.19.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 19:48:48 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 07/13] drm_print: condense enum drm_debug_category
Date:   Wed, 16 Feb 2022 20:48:23 -0700
Message-Id: <20220217034829.64395-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217034829.64395-1-jim.cromie@gmail.com>
References: <20220217034829.64395-1-jim.cromie@gmail.com>
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

enum drm_debug_category has 10 "classes", explicitly initialized with
0x-bitmasks which could be simplified as BIT(X)s.  But lets go
further: use natural enumeration (int, starting at 0), and do the
BIT(cat) in drm_debug_enabled(cat) at runtime.

While this slightly pessimizes the bit-test, the category now fits in
4 bits, allowing it in struct _ddebug.class_id:4.  This sets us up to
adapt drm to use dyndbg with JUMP_LABEL, thus avoiding all those
bit-tests anyway.

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
2.35.1

