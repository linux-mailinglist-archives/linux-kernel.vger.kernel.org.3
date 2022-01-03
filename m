Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B060F48347A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiACQA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:00:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36324 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiACQAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:00:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7389DB8100B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 16:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBC6C36AEB;
        Mon,  3 Jan 2022 16:00:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Ind/g1B5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641225620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qx7aU6bTBZDcx6Qr9I6iDbUH1sytCqJlxzi6Spl3Hf8=;
        b=Ind/g1B5FOEeHbSq2WgTK3Dtm7eLvTGJWgjzP1sml3w0Mr7XCsF6eaYoboWPSZqj8wEnuQ
        m932SLp6r0VlHFgo9lGOoZ+w7iwum+//ZuaRGJ5U6RG3jkzKaJFQbf1EJkuW5j6fJD1aC+
        lRsbvq9gli/Mtp5Q7t7O9cwOxZImwU4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0f724d62 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 3 Jan 2022 16:00:20 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: [PATCH] random: reseed in RNDRESEEDCRNG for the !crng_ready() case
Date:   Mon,  3 Jan 2022 17:00:02 +0100
Message-Id: <20220103160002.1068356-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace often wants to seed the RNG from disk, without knowing how
much entropy is really in that file. In that case, userspace says
there's no entropy, so none is credited. If this happens in the
crng_init==1 state -- common at early boot time when such seed files are
used -- then that seed file will be written into the pool, but it won't
actually help the quality of /dev/urandom reads. Instead, it'll sit
around until something does credit sufficient amounts of entropy, at
which point, the RNG is seeded and initialized.

Rather than let those seed file bits sit around unused until "sometime
later", userspaces that call RNDRESEEDCRNG can expect, with this commit,
for those seed bits to be put to use *somehow*. This is accomplished by
extracting from the input pool on RNDRESEEDCRNG, xoring 32 bytes into
the current crng state.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Jann - this is the change I think you were requesting when we discussed
this. Please let me know if it matches what you had in mind.

 drivers/char/random.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 17ec60948795..805e509d9c30 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1961,8 +1961,17 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 	case RNDRESEEDCRNG:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		if (crng_init < 2)
+		if (!crng_ready()) {
+			unsigned long flags, i;
+			u32 new_key[8];
+			_extract_entropy(&input_pool, new_key, sizeof(new_key), 0);
+			spin_lock_irqsave(&primary_crng.lock, flags);
+			for (i = 0; i < ARRAY_SIZE(new_key); ++i)
+				primary_crng.state[4 + i] ^= new_key[i];
+			spin_unlock_irqrestore(&primary_crng.lock, flags);
+			memzero_explicit(new_key, sizeof(new_key));
 			return -ENODATA;
+		}
 		crng_reseed(&primary_crng, &input_pool);
 		WRITE_ONCE(crng_global_init_time, jiffies - 1);
 		return 0;
-- 
2.34.1

