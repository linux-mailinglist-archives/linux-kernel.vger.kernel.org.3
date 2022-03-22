Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23564E4686
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 20:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiCVTQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 15:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiCVTQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 15:16:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88940B87D;
        Tue, 22 Mar 2022 12:15:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C94FB81D59;
        Tue, 22 Mar 2022 19:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF40C340EC;
        Tue, 22 Mar 2022 19:14:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ayNjLncA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1647976496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=i/U5LyvFIKyE1xMxL9o+v3ZqxPzAfBijQuHujE0+oF8=;
        b=ayNjLncAbSXIHKGoSRZt2lzsl4IKwOpfI0CHuEFRLd58tJC3pCQKgTb3YV766sf0uSJ8tL
        vbfl7eoejf2RDXytvp1K7Uaomnb7PR0h2dXz0HuJQ/8CepsnqfPcdER+8WZKD4I1o0yxOT
        tgidsdVAY2g+AhnePuD2pscPNSud2IU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 600c7da9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 22 Mar 2022 19:14:55 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Theodore Ts'o <tytso@mit.edu>, Jann Horn <jannh@google.com>
Subject: [PATCH] random: allow writes to /dev/urandom to influence fast init
Date:   Tue, 22 Mar 2022 13:14:36 -0600
Message-Id: <20220322191436.110963-1-Jason@zx2c4.com>
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

For as far back as I can tell, writing to /dev/urandom or /dev/random
will put entropy into the pool, but won't immediately use it, and won't
credit it either. Instead, crediting is controlled by the ioctls
RNDADDTOENTCNT and RNDADDENTROPY. If, however, this happens during early
boot before the input pool is ready, we have a dangerous situation with
seed files as commonly used by shell scripts:

  dd if=seedfile of=/dev/urandom # write seed into pool
  dd if=/dev/urandom of=seedfile count=1 bs=32 # read new seed for next boot

Since the entropy in seedfile isn't credited there, this won't cause the
RNG to transition from crng_init=0 to crng_init=2, and so when we make a
new seedfile for next boot, we'll still be getting crng_init=0-quality
randomness, which may well regress from the original seedfile.

I fixed a related issue in systemd with
<https://github.com/systemd/systemd/commit/da2862ef06f22fc8d31dafced6d2d6dc14f2ee0b>,
which is a clean way of doing it, but it doesn't really help with
existing shell scripts. And the behavior here remains bad and
surprising.

So this patch fixes the issue by including /dev/urandom writes as part
of the "fast init", but not crediting it as part of the fast init
counter. This is more or less exactly what's already done for
kernel-sourced entropy whose quality we don't know, when we use
add_device_randomness(), which both contributes to the input pool and to
the fast init key.

There is one caveat to consider, which is what happens if the user
additionally calls RNDADDTOENTCNT after having written to /dev/urandom,
expecting to credit that write. That might give way to this pathological
pattern:

   - write(urandom_fd, &single_byte, 1);
   - ioctl(urandom_fd, RNDADDTOENTCNT, 8);
   - attacker brute forces that single byte.
   - write(urandom_fd, &single_byte, 1);
   - ioctl(urandom_fd, RNDADDTOENTCNT, 8);
   - attacker brute forces that single byte.
   - write(urandom_fd, &single_byte, 1);
   - ioctl(urandom_fd, RNDADDTOENTCNT, 8);
   - attacker brute forces that single byte.
   - write(urandom_fd, &single_byte, 1);
   - ioctl(urandom_fd, RNDADDTOENTCNT, 8);
   - attacker brute forces that single byte.
   - write(urandom_fd, &single_byte, 1);
   - ioctl(urandom_fd, RNDADDTOENTCNT, 8);
   - attacker brute forces that single byte.
   - ...

After this goes 32 times, the crng has now initialized, except an
attacker was able to bruteforce the whole state, making for a sort of
boot time "premature next" problem.

This is bad, but the case above is pretty pathological. Part of this
stems from the fact that /dev/urandom write + RNDADDTOENTCNT is a poor
interface, because it's unclear whether the crediting will follow the
writing, whereas we know in the add_device_randomness() case that we
_won't_ credit it, so we don't have to worry about that.

The better interface for userspace is RNDADDENTROPY, which takes the
input buffer and the entropy credit all at once, so we can make the
right decision. For the RNDADDENTROPY, we do not take part in fast init
if entropy is being credited.

And perhaps we might consider attempting to deprecate RNDADDTOENTCNT at
some point in the future.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
This isn't a "perfect" solution, and the of entropy accounting sort of
points both to problems there and to how the "fast init" phase fits in
to the overall design. So I'll think this over a bit for a few days, and
maybe it might lead to more improvements in fast init handling later.

 drivers/char/random.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 706f08edf0dc..7b7f5e6596c2 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1493,7 +1493,7 @@ static __poll_t random_poll(struct file *file, poll_table *wait)
 	return mask;
 }
 
-static int write_pool(const char __user *ubuf, size_t count)
+static int write_pool(const char __user *ubuf, size_t count, bool will_credit)
 {
 	size_t len;
 	int ret = 0;
@@ -1507,6 +1507,8 @@ static int write_pool(const char __user *ubuf, size_t count)
 		}
 		count -= len;
 		ubuf += len;
+		if (unlikely(crng_init == 0 && !will_credit))
+			crng_pre_init_inject(block, len, false);
 		mix_pool_bytes(block, len);
 		cond_resched();
 	}
@@ -1521,7 +1523,13 @@ static ssize_t random_write(struct file *file, const char __user *buffer,
 {
 	int ret;
 
-	ret = write_pool(buffer, count);
+	/*
+	 * We set "will_credit" to false here, which might be wrong if the
+	 * user subsequently calls RNDADDTOENTCNT. But it accounts for the
+	 * more common case of shell scripts writing to /dev/urandom and
+	 * then immediately reading back a seed file.
+	 */
+	ret = write_pool(buffer, count, false);
 	if (ret)
 		return ret;
 
@@ -1584,7 +1592,7 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 			return -EINVAL;
 		if (get_user(size, p++))
 			return -EFAULT;
-		retval = write_pool((const char __user *)p, size);
+		retval = write_pool((const char __user *)p, size, ent_count > 0);
 		if (retval < 0)
 			return retval;
 		credit_entropy_bits(ent_count);
-- 
2.35.1

