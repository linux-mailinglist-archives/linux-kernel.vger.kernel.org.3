Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734C3525FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379509AbiEMKe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379442AbiEMKev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:34:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF981ACFB2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 03:34:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B4B1B82D74
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D464C34100;
        Fri, 13 May 2022 10:34:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CVGBQ4r8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652438086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jgCALduODQNoXZ2GjV92Rd/XeDog7JIdZbU+zai/u+Q=;
        b=CVGBQ4r8Y83G9YM/tr/GN8N8Ub5TIgJxOqrQGd18/xuq8akbazLIk2b4tPa+cV6wCR94pB
        Hc/M/iZ54rDk+OsnEEjUtdpTr1KnoxW5bPHFDxIdfx14cc6aTFUgJMkjrTPIfZ/I0Ka+zT
        rirNaxI26yFgPpZmOBJkXuccc66dzks=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 430e8ad9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 13 May 2022 10:34:46 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux@dominikbrodowski.net, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 2/2] random: use proper return types on get_random_{int,long}_wait()
Date:   Fri, 13 May 2022 12:34:34 +0200
Message-Id: <20220513103434.287137-2-Jason@zx2c4.com>
In-Reply-To: <20220513103434.287137-1-Jason@zx2c4.com>
References: <20220513103434.287137-1-Jason@zx2c4.com>
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

Before these were returning signed values, but the API is intended to be
used with unsigned values.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 include/linux/random.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index 97f879ea78a5..883bf9a23d84 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -90,18 +90,18 @@ static inline int get_random_bytes_wait(void *buf, size_t nbytes)
 	return ret;
 }
 
-#define declare_get_random_var_wait(var) \
-	static inline int get_random_ ## var ## _wait(var *out) { \
+#define declare_get_random_var_wait(name, ret_type) \
+	static inline int get_random_ ## name ## _wait(ret_type *out) { \
 		int ret = wait_for_random_bytes(); \
 		if (unlikely(ret)) \
 			return ret; \
-		*out = get_random_ ## var(); \
+		*out = get_random_ ## name(); \
 		return 0; \
 	}
-declare_get_random_var_wait(u32)
-declare_get_random_var_wait(u64)
-declare_get_random_var_wait(int)
-declare_get_random_var_wait(long)
+declare_get_random_var_wait(u32, u32)
+declare_get_random_var_wait(u64, u32)
+declare_get_random_var_wait(int, unsigned int)
+declare_get_random_var_wait(long, unsigned long)
 #undef declare_get_random_var
 
 /*
-- 
2.35.1

