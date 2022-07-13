Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CCF5733A7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiGMKAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiGMKAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:00:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7FFEB017
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:00:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 503ACB81D89
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 10:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B261C34114;
        Wed, 13 Jul 2022 10:00:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="k9oNWpMV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657706434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lFRNshCYldrPF3aNOW7vz7FukysK89WspPfxLYVWLsw=;
        b=k9oNWpMVZ0EQNdkVpXfyWGIPHBAfRbxfy9D/4nrCXxsxJFgJkum0q3nBacTG4xndmbbcqG
        DMGLWm0xvwoslg6XYfZGJ1KJGSRULNueZXVOD1CUueMKOQq6BnEVSM8GVRXxrFuw4miZ6V
        JARYP0PsAYONCQ4yFdsfQ2rinxb6Fk8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1c0f8483 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 13 Jul 2022 10:00:34 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] um: include sys/types.h instead of stddef.h for size_t
Date:   Wed, 13 Jul 2022 12:00:29 +0200
Message-Id: <20220713100029.163083-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually size_t comes from sys/types.h, not stddef.h. This code likely
worked only because something else in its usage chain was pulling in
sys/types.h.

Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/um/include/shared/user.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index dd4badffdeb3..a0a8f0d19a85 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -13,21 +13,21 @@
  * fancier, type-safe, definition.  Using that one would require
  * copying too much infrastructure for my taste, so userspace files
  * get less checking than kernel files.
  */
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
 /* This is to get size_t */
 #ifndef __UM_HOST__
 #include <linux/types.h>
 #else
-#include <stddef.h>
+#include <sys/types.h>
 #endif
 
 extern void panic(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 
 /* Requires preincluding include/linux/kern_levels.h */
 #define UM_KERN_EMERG	KERN_EMERG
 #define UM_KERN_ALERT	KERN_ALERT
 #define UM_KERN_CRIT	KERN_CRIT
 #define UM_KERN_ERR	KERN_ERR
-- 
2.35.1

