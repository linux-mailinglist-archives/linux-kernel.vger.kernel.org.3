Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A98654E4C9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377990AbiFPOgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377978AbiFPOgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:36:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D4240925;
        Thu, 16 Jun 2022 07:36:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 713EE61DDC;
        Thu, 16 Jun 2022 14:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE632C385A2;
        Thu, 16 Jun 2022 14:36:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DaikPer8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655390186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HPAtaIeUzFGETtepNlx7oLoJv5QwPzhpAP3HikjfJM0=;
        b=DaikPer8ueIhZk7aIyzyf4bBdHkIGHkDbS3F2CMbp3CIOT/Y0wncEunWvGF9PHmAdP33A8
        Wqe2Q441lhxPeQfjd1rTGZn//lhaslF6PN3tH+PDw6TpGE3JsxljsAK46KV7qWlp1/RDt9
        T+4KQ1Y8Uu/3HsYuXYgY6xnjS8IfrMw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8198e951 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 16 Jun 2022 14:36:26 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Matthew Wilcox <willy@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>
Subject: [PATCH] usercopy: use unsigned long instead of uintptr_t
Date:   Thu, 16 Jun 2022 16:36:17 +0200
Message-Id: <20220616143617.449094-1-Jason@zx2c4.com>
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

A recent commit factored out a series of annoying (unsigned long) casts
into a single variable declaration, but made the pointer type a
`uintptr_t` rather than the usual `unsigned long`. This patch changes it
to be the integer type more typically used by the kernel to represent
addresses.

Fixes: 35fb9ae4aa2e ("usercopy: Cast pointer to an integer once")
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 mm/usercopy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index 4e1da708699b..c1ee15a98633 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -161,7 +161,7 @@ static inline void check_bogus_address(const unsigned long ptr, unsigned long n,
 static inline void check_heap_object(const void *ptr, unsigned long n,
 				     bool to_user)
 {
-	uintptr_t addr = (uintptr_t)ptr;
+	unsigned long addr = (unsigned long)ptr;
 	unsigned long offset;
 	struct folio *folio;
 
-- 
2.35.1

