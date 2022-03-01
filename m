Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FAA4C90B5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbiCAQr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbiCAQrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:47:36 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA2043AD6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 08:46:55 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id h28so1056416ila.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 08:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eZXNUqubAB8NNsFmaxywjAoPOWysBIvPMcZdY6L3itE=;
        b=cBscgP41htfLiQ2OxXZNjPjNT9epnka4RNeYhMMNLhyziuaJKqWOTub2OdKwwH+Odg
         J81R3HY12eJs4g9jm8hFhikPRdw6qltg4xzra8tbEs3CjKMzN6in5GunPnNjmfjsjaiG
         t4ebdJlrUqEuN3pXln5duyqK4vRfkT1DYJJNirI9i9zrekSiuqB8QcqS8UDKyEZFRPqU
         nDmtvEHpFBOZGze2PwgXG69dTSUgVZGOPFnpm019TLO/CRtkIX9DmS76vLmXKfstiTCe
         efQB6kpsKZ3f/wz++gAVH2/IqK9MFU0Mh3mzGpPrY0n7uWiHaMmfqE00x6Ppn5EtM/op
         Us5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eZXNUqubAB8NNsFmaxywjAoPOWysBIvPMcZdY6L3itE=;
        b=h40ZZkgsA8xbfLZq1+mTgmNM3pSLLq00aQkv+pgCiiRIfNZ4qdeTWcJNdkwCFRQEUo
         T66h2rnNdcT36AJ2e1JQnC0Ws+T+SdLkdoipbQSLPgfUB16O1khRj8o88b6pUR2uGSP0
         BtBLHXEczcwHp/19zAjpX0WytNBj8yOzD1YZQdJuY9nP6Lawb7id34OBTW4CS6fskWno
         C2wu4spstch7Rz/5ux+yxaMyj8CLy90ExPGv6qyEuhZEwmSMpKmkOY7UD0qEbnKf2SSn
         k8trEjegi+EnY6hBpXZRpl795Mo5s1/lirVX11SyuADi53+QR3meHckmoEeFtb52XBjm
         Erww==
X-Gm-Message-State: AOAM533OcpkJkERGPJcv8YPQM+NMg3d0TCFyP/o2c9PEyJwt8eVx8PPH
        caDIP0MhDa8yilYxgX5qYBg=
X-Google-Smtp-Source: ABdhPJwoqnkXIbxFZaZCJRvZ08M8RqoA/qmhVFDfhpmycRS1WR6s4XCCJA+9fPCrhqrKWS3Wy3AylQ==
X-Received: by 2002:a92:c26b:0:b0:2c2:9037:a788 with SMTP id h11-20020a92c26b000000b002c29037a788mr23790624ild.95.1646153215064;
        Tue, 01 Mar 2022 08:46:55 -0800 (PST)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::f10e])
        by smtp.googlemail.com with ESMTPSA id o3-20020a6b5a03000000b00640a33c5b0dsm7272411iob.17.2022.03.01.08.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 08:46:54 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 07/13] drm_print: condense enum drm_debug_category
Date:   Tue,  1 Mar 2022 09:46:23 -0700
Message-Id: <20220301164629.3814634-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301164629.3814634-1-jim.cromie@gmail.com>
References: <20220301164629.3814634-1-jim.cromie@gmail.com>
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

