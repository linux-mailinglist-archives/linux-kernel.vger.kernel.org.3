Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8496359268E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239698AbiHNVWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240465AbiHNVU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:20:57 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C814B1C8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:20:50 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660512048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lYid45vDrsfGp3/xPEZDgzeMTFMxEVq5nDuDoli1D2U=;
        b=YFv+rmH1oFhY4ybgP1LhjEX8xQEBPX+Rb8QJenVULTRnrO8GiokbD4yKEAOm3LNifn8M8y
        dGDA8oniqHZBKrhfxZZQpGg0DxOnjpKeeDhVdU1Q/YvelvTuaDzv38qj3S3qWJdRs+CV2+
        X3WzNCjkG293rRYrAO74gMHAdEdmh2E=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 11/32] test_printf: Drop requirement that sprintf not write past nul
Date:   Sun, 14 Aug 2022 17:19:50 -0400
Message-Id: <20220814212011.1727798-12-kent.overstreet@linux.dev>
In-Reply-To: <20220814212011.1727798-1-kent.overstreet@linux.dev>
References: <20220814212011.1727798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

The current test code checks that sprintf never writes past the
terminating nul. This is a rather strange requirement, completely
separate from writing past the end of the buffer, which of course we
can't do: writing anywhere to the buffer passed to snprintf, within size
of course, should be perfectly fine.

Since this check has no documentation as to where it comes from or what
depends on it, and it's getting in the way of further refactoring
(printf_spec handling is right now scattered massively throughout the
code, and we'd like to consolidate it) - delete it.

Also, many current pretty-printers building up their output on the
stack, and then copy it to the actual output buffer - by eliminating
this requirement we can kill those extra buffers.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/test_printf.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 4bd15a593f..da91301eae 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -84,12 +84,6 @@ do_test(int bufsize, const char *expect, int elen,
 		return 1;
 	}
 
-	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, bufsize - (written + 1))) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
-			bufsize, fmt);
-		return 1;
-	}
-
 	if (memchr_inv(test_buffer + bufsize, FILL_CHAR, BUF_SIZE + PAD_SIZE - bufsize)) {
 		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond buffer\n", bufsize, fmt);
 		return 1;
-- 
2.36.1

