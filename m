Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156E347F198
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 02:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhLYBAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 20:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhLYBAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 20:00:34 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BA4C061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 17:00:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CC7A7CE2345
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 01:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38D7C36AEA;
        Sat, 25 Dec 2021 01:00:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="IzUQPv+C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1640394028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hq8m6d/730E5cuUPQiSTXZEq/EnTJ9dNV6E7hz3q2hY=;
        b=IzUQPv+CzKnGZl9VFZ0FOSEmJD8ywH7f3IEsGnl2hemT5H4fveEcXxR3zOuK2JFT2Xv33f
        AyYolv6x+M1YT9/hJdt+9w2WsZJNlAv8WraxU26bGnnjyNiTVsQcVgUQz9YptXdvAstujv
        ZA5G/Ml3H3kJUlr9FuC718i4dKfIIxM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0b18722d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 25 Dec 2021 01:00:27 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     tytso@mit.edu, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: do not sign extend bytes for rotation when mixing
Date:   Sat, 25 Dec 2021 02:00:11 +0100
Message-Id: <20211225010011.1909938-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using `char` instead of `unsigned char`, certain platforms will sign
extend the byte when `w = rol32(*bytes++, input_rotate)` is called,
meaning that bit 7 is overrepresented when mixing. This isn't a real
problem (unless the mixer itself is already broken) since it's still
invertible, but it's not quite correct either. Fix this by using an
explicit unsigned type.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 99cce575a79c..82db125aaed7 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -546,7 +546,7 @@ static void _mix_pool_bytes(struct entropy_store *r, const void *in,
 	unsigned long i, tap1, tap2, tap3, tap4, tap5;
 	int input_rotate;
 	int wordmask = r->poolinfo->poolwords - 1;
-	const char *bytes = in;
+	const unsigned char *bytes = in;
 	__u32 w;
 
 	tap1 = r->poolinfo->tap1;
-- 
2.34.1

