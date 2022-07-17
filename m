Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BD8577528
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 11:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiGQIyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 04:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGQIyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 04:54:04 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B7DB7C0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 01:54:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1A9C2CE0EDB
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 08:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED485C3411E;
        Sun, 17 Jul 2022 08:53:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eDGS+NfF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1658048036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dkXr1iyL8WVr9J4FTnhIRaG1yM9efnbmEVUprmdLPQE=;
        b=eDGS+NfFFiel1+dGtKF0J2jt0O/XuV6tMotGE1wIEytkZ4V3lBLHcVHMQcwFJmUn1FTaxf
        Hgka7WaT6zQibGyxWvRDdSGqFaCU3qFRkyzTjyB5kDPKVx25Loqtw81gopUKR/9aP4ZUKQ
        fwWS+GnMgMeL7LOeDjOH8LgE1E5DPsk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2f82cec2 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 17 Jul 2022 08:53:56 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2] um: include sys/types.h for size_t
Date:   Sun, 17 Jul 2022 10:53:46 +0200
Message-Id: <20220717085346.1525754-1-Jason@zx2c4.com>
In-Reply-To: <20220713100029.163083-1-Jason@zx2c4.com>
References: <20220713100029.163083-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually size_t comes from sys/types.h, not stddef.h. This code likely
worked only because something else in its usage chain was pulling in
sys/types.h. stddef.h is still required for NULL, however, so note this.

Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/um/include/shared/user.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index dd4badffdeb3..bda66e5a9d4e 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -16,11 +16,12 @@
  */
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
-/* This is to get size_t */
+/* This is to get size_t and NULL */
 #ifndef __UM_HOST__
 #include <linux/types.h>
 #else
 #include <stddef.h>
+#include <sys/types.h>
 #endif
 
 extern void panic(const char *fmt, ...)
-- 
2.35.1

