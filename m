Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CE6505D54
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbiDRRP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346824AbiDRRPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:15:09 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8513A205C8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:12:30 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so17760787pjn.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yE8pw+h1dbaWzikUW2j6kxY7g+BVeorFYlS2p9BBfy0=;
        b=V4Ms/p6T9fIF9M+z+F7Ig2d2qAol+38t5VnQThFXYaaTIfKGNXQKXT5Gym1bzxOV33
         zaIBs7A9zDaFemq4bznhY+tpalEbiiWP5LPHk77zDbg/oKZt6fsqNTQKJEhrAgKSKWk0
         thxj2QEKGhU25vtMznhS6w9aua+JglwQm8s3MaPg/qdL50KNUbFQfKwsZuxwfqtZFdrl
         PuTuJYIACAnUu8JtoCOo0mEyUXnqyoF31csh/wPCvjAq7A9H6pOVx11E7iKF6nCP8Wdj
         KWerdW8StFSGAP1tAmEoSgQb6yGxpXnhWaK3hF9e7EbqloSnOHYc/O3VgiAFVGSH/uAa
         HMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yE8pw+h1dbaWzikUW2j6kxY7g+BVeorFYlS2p9BBfy0=;
        b=17AUjaRArfzsTkaeFMJRMebE7DVZoHyNypn3neuZ5EKlziF9fhJptfzL3UTbuLVB9K
         45BCO45Owa+YyTtj2PbXAeG8OudDgilGO22dRZOOpU2yN5Bx2D5hlNjAiwUevI72p93C
         QTIYoH9OYHtU9DikylhErY6oNQrVRl4diuHpEXbcMaMmPKQ/tGw3lZ61kkfYLsyKkXVg
         a6wykGEtQ0KogiFB488153AV1OSbg7QzKkwHC4UEQC9jwejztsRQshtIzUKu3j8uQc6J
         +AEUYTsPUPsI8owUeZSSRnOycKdLoYzjNgUwwlmBVgpfWoP/TOw9jXhBIaX55EaUmXat
         FBOg==
X-Gm-Message-State: AOAM532E74yw3FVDYnyD7SV86rjKghc6QFq4YOYTAT4AZzf88znskdgV
        vGHsITGEMEAcKi1A4REfhL8=
X-Google-Smtp-Source: ABdhPJxJEM7LGNW6eMwgM+JKh1lmLC5UPUAiX4iHCmiOn4l4E357qChHpu2WrbnuzOZHin4mqxNJnQ==
X-Received: by 2002:a17:90b:3889:b0:1c7:a31f:2a50 with SMTP id mu9-20020a17090b388900b001c7a31f2a50mr19482679pjb.193.1650301950107;
        Mon, 18 Apr 2022 10:12:30 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:3f09:380c:8f11:5a8a])
        by smtp.gmail.com with ESMTPSA id e16-20020a63ee10000000b0039d1c7e80bcsm13637138pgi.75.2022.04.18.10.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:12:29 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4/5] xtensa: enable context tracking
Date:   Mon, 18 Apr 2022 10:12:04 -0700
Message-Id: <20220418171205.2413168-5-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220418171205.2413168-1-jcmvbkbc@gmail.com>
References: <20220418171205.2413168-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put user exit context tracking call on the common kernel entry/exit path
(function calls are impossible at earlier kernel entry stages because
PS.EXCM is not cleared yet). Put user entry context tracking call on the
user exit path. Syscalls go through this common code too, so nothing
specific needs to be done for them.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 .../features/time/context-tracking/arch-support.txt      | 2 +-
 arch/xtensa/Kconfig                                      | 1 +
 arch/xtensa/kernel/entry.S                               | 9 +++++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/features/time/context-tracking/arch-support.txt b/Documentation/features/time/context-tracking/arch-support.txt
index bb1c1801553e..72e7aadeda7e 100644
--- a/Documentation/features/time/context-tracking/arch-support.txt
+++ b/Documentation/features/time/context-tracking/arch-support.txt
@@ -27,5 +27,5 @@
     |       sparc: |  ok  |
     |          um: | TODO |
     |         x86: |  ok  |
-    |      xtensa: | TODO |
+    |      xtensa: |  ok  |
     -----------------------
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index e3ffd4564009..6134808a633d 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -31,6 +31,7 @@ config XTENSA
 	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_CONTEXT_TRACKING
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_EXIT_THREAD
diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index d09f2c38ba84..f2c789a5a92a 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -456,6 +456,12 @@ KABI_W	or	a3, a3, a2
 	beqz		abi_tmp0, 1f
 	abi_call	trace_hardirqs_off
 1:
+#endif
+#ifdef CONFIG_CONTEXT_TRACKING
+	l32i		abi_tmp0, a1, PT_PS
+	bbci.l		abi_tmp0, PS_UM_BIT, 1f
+	abi_call	context_tracking_user_exit
+1:
 #endif
 
 	/* Go to second-level dispatcher. Set up parameters to pass to the
@@ -540,6 +546,9 @@ common_exception_return:
 	j		.Lrestore_state
 
 .Lexit_tif_loop_user:
+#ifdef CONFIG_CONTEXT_TRACKING
+	abi_call	context_tracking_user_enter
+#endif
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 	_bbci.l		abi_saved0, TIF_DB_DISABLED, 1f
 	abi_call	restore_dbreak
-- 
2.30.2

