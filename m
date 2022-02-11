Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9274B2F1A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351122AbiBKVIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:08:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiBKVIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:08:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA03BB3E;
        Fri, 11 Feb 2022 13:08:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60E1DB82829;
        Fri, 11 Feb 2022 21:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5E2C340E9;
        Fri, 11 Feb 2022 21:08:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="j6V8Hglu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644613707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0qGm9Td4MsVqtPR0gKHAk3OilJ3zgQ8dy0sUDBICrcQ=;
        b=j6V8HgluD/S2K4fcc9nkFPdBmGZF8hWeElNMN1OOcjDewhNFSqluR/1xhfBmGRtahPo27O
        tfKdSNum7FxPBt2rpYlnbaUg8fpowFzBvAi8VFzsgaHZ4RvMKeiaMZ/K9LK4Gr5dTdz8/0
        eebtpAqlfS9d98ekAtCjqY3QJU1P1Cc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bab4ea69 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 11 Feb 2022 21:08:26 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH RFC v0] random: block in /dev/urandom
Date:   Fri, 11 Feb 2022 22:07:57 +0100
Message-Id: <20220211210757.612595-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is very much an RFC patch, or maybe even an RFG -- request for
grumbles. This topic has come up a million times, and usually doesn't go
anywhere. This time I thought I'd bring it up with a slightly narrower
focus. Before you read further, realize that I do not intend to merge
this without there being an appropriate amount of consensus for it and
discussion about it.

Ever since Linus' 50ee7529ec45 ("random: try to actively add entropy
rather than passively wait for it"), the RNG does a haveged-style jitter
dance around the scheduler, in order to produce entropy (and credit it)
for the case when we're stuck in wait_for_random_bytes(). How ever you
feel about the Linus Jitter Dance is beside the point: it's been there
for three years and usually gets the RNG initialized in a second or so.

As a matter of fact, this is what happens currently when people use
getrandom(2).

So, given that the kernel has grown this mechanism for seeding itself
from nothing, and that this procedure happens pretty fast, maybe there's
no point any longer in having /dev/urandom give insecure bytes. In the
past we didn't want the boot process to deadlock, which was
understandable. But now, in the worst case, a second goes by, and the
problem is resolved. It seems like maybe we're finally at a point when
we can get rid of the infamous "urandom read hole".

Maybe. And this is why this is a request for grumbles patch: the Linus
Jitter Dance relies on random_get_entropy() returning a cycle counter
value. The first lines of try_to_generate_entropy() are:

	stack.now = random_get_entropy();
	/* Slow counter - or none. Don't even bother */
	if (stack.now == random_get_entropy())
		return;

So it would appear that what seemed initially like a panacea does not in
fact work everywhere. Where doesn't it work?

On every platform, random_get_entropy() is connected to get_cycles(),
except for three: m68k, MIPS, and RISC-V.

On m68k, it looks like this:

        if (mach_random_get_entropy)
                return mach_random_get_entropy();
        return 0;

And mach_random_get_entropy seems to be set in amiga/config.c only.

On MIPS, it looks like this:

        if (can_use_mips_counter(prid))
                return read_c0_count();
        else if (likely(imp != PRID_IMP_R6000 && imp != PRID_IMP_R6000A))
                return read_c0_random();
        else
                return 0;

So it seems like we're okay except for R6000 and R6000A.

Finally on RISC-V, it looks like this:

        if (unlikely(clint_time_val == NULL))
                return 0;
        return get_cycles();

Where clint_time_val is eventually filled in later in boot with
clint_timer_init_dt(). So I assume that's a case where it _eventually_
works, which is probably good enough for our purposes.

I think what this adds up to is that this change would positively affect
everybody, except for _possibly_ negatively affecting poorly configured
non-Amiga m68k systems and the MIPS R6000 and R6000A. Does that analysis
seem correct to folks reading, or did I miss something?

Are there other cases where the cycle counter does exist but is simply
too slow? Perhaps some computer historians can chime in here.

If my general analysis is correct, are these ancient platforms really
worth holding this back? I halfway expect to receive a few thrown
tomatoes, an angry fist, and a "get off my lawn!", and if that's _all_ I
hear, I'll take a hint and we can forget I ever proposed this. As
mentioned, I do not intend to merge this unless there's broad consensus
about it. But on the off chance that people feel differently, perhaps
the Linus Jitter Dance is finally the solution to years of /dev/urandom
kvetching.

Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/mem.c          |  2 +-
 drivers/char/random.c       | 68 +++++++++----------------------------
 include/uapi/linux/random.h |  2 +-
 3 files changed, 18 insertions(+), 54 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index cc296f0823bd..9f586025dbe6 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -707,7 +707,7 @@ static const struct memdev {
 	 [5] = { "zero", 0666, &zero_fops, FMODE_NOWAIT },
 	 [7] = { "full", 0666, &full_fops, 0 },
 	 [8] = { "random", 0666, &random_fops, 0 },
-	 [9] = { "urandom", 0666, &urandom_fops, 0 },
+	 [9] = { "urandom", 0666, &random_fops, 0 },
 #ifdef CONFIG_PRINTK
 	[11] = { "kmsg", 0644, &kmsg_fops, 0 },
 #endif
diff --git a/drivers/char/random.c b/drivers/char/random.c
index c564f795f68c..868334ea0ce3 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -88,8 +88,6 @@ static LIST_HEAD(random_ready_list);
 /* Control how we warn userspace. */
 static struct ratelimit_state unseeded_warning =
 	RATELIMIT_STATE_INIT("warn_unseeded_randomness", HZ, 3);
-static struct ratelimit_state urandom_warning =
-	RATELIMIT_STATE_INIT("warn_urandom_randomness", HZ, 3);
 static int ratelimit_disable __read_mostly;
 module_param_named(ratelimit_disable, ratelimit_disable, int, 0644);
 MODULE_PARM_DESC(ratelimit_disable, "Disable random ratelimit suppression");
@@ -321,11 +319,6 @@ static void crng_reseed(void)
 				  unseeded_warning.missed);
 			unseeded_warning.missed = 0;
 		}
-		if (urandom_warning.missed) {
-			pr_notice("%d urandom warning(s) missed due to ratelimiting\n",
-				  urandom_warning.missed);
-			urandom_warning.missed = 0;
-		}
 	}
 }
 
@@ -978,10 +971,8 @@ int __init rand_initialize(void)
 		pr_notice("crng init done (trusting CPU's manufacturer)\n");
 	}
 
-	if (ratelimit_disable) {
-		urandom_warning.interval = 0;
+	if (ratelimit_disable)
 		unseeded_warning.interval = 0;
-	}
 	return 0;
 }
 
@@ -1363,20 +1354,17 @@ static void try_to_generate_entropy(void)
  * getrandom(2) is the primary modern interface into the RNG and should
  * be used in preference to anything else.
  *
- * Reading from /dev/random has the same functionality as calling
- * getrandom(2) with flags=0. In earlier versions, however, it had
- * vastly different semantics and should therefore be avoided, to
- * prevent backwards compatibility issues.
- *
- * Reading from /dev/urandom has the same functionality as calling
- * getrandom(2) with flags=GRND_INSECURE. Because it does not block
- * waiting for the RNG to be ready, it should not be used.
+ * Reading from /dev/random and /dev/urandom both the same effect as
+ * calling getrandom(2) with flags=0. In earlier versions, however,
+ * they each had vastly different semantics and should therefore be
+ * avoided to prevent backwards compatibility issues.
  *
  * Writing to either /dev/random or /dev/urandom adds entropy to
  * the input pool but does not credit it.
  *
- * Polling on /dev/random indicates when the RNG is initialized, on
- * the read side, and when it wants new entropy, on the write side.
+ * Polling on /dev/random or /dev/urandom indicates when the RNG
+ * is initialized, on the read side, and when it wants new entropy,
+ * on the write side.
  *
  * Both /dev/random and /dev/urandom have the same set of ioctls for
  * adding entropy, getting the entropy count, zeroing the count, and
@@ -1387,6 +1375,8 @@ static void try_to_generate_entropy(void)
 SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count, unsigned int,
 		flags)
 {
+	int ret;
+
 	if (flags & ~(GRND_NONBLOCK | GRND_RANDOM | GRND_INSECURE))
 		return -EINVAL;
 
@@ -1400,15 +1390,13 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count, unsigned int,
 	if (count > INT_MAX)
 		count = INT_MAX;
 
-	if (!(flags & GRND_INSECURE) && !crng_ready()) {
-		int ret;
+	if ((flags & GRND_NONBLOCK) && !crng_ready())
+		return -EAGAIN;
+
+	ret = wait_for_random_bytes();
+	if (ret != 0)
+		return ret;
 
-		if (flags & GRND_NONBLOCK)
-			return -EAGAIN;
-		ret = wait_for_random_bytes();
-		if (unlikely(ret))
-			return ret;
-	}
 	return get_random_bytes_user(buf, count);
 }
 
@@ -1461,21 +1449,6 @@ static ssize_t random_write(struct file *file, const char __user *buffer,
 	return (ssize_t)count;
 }
 
-static ssize_t urandom_read(struct file *file, char __user *buf, size_t nbytes,
-			    loff_t *ppos)
-{
-	static int maxwarn = 10;
-
-	if (!crng_ready() && maxwarn > 0) {
-		maxwarn--;
-		if (__ratelimit(&urandom_warning))
-			pr_notice("%s: uninitialized urandom read (%zd bytes read)\n",
-				  current->comm, nbytes);
-	}
-
-	return get_random_bytes_user(buf, nbytes);
-}
-
 static ssize_t random_read(struct file *file, char __user *buf, size_t nbytes,
 			   loff_t *ppos)
 {
@@ -1562,15 +1535,6 @@ const struct file_operations random_fops = {
 	.llseek = noop_llseek,
 };
 
-const struct file_operations urandom_fops = {
-	.read = urandom_read,
-	.write = random_write,
-	.unlocked_ioctl = random_ioctl,
-	.compat_ioctl = compat_ptr_ioctl,
-	.fasync = random_fasync,
-	.llseek = noop_llseek,
-};
-
 
 /********************************************************************
  *
diff --git a/include/uapi/linux/random.h b/include/uapi/linux/random.h
index dcc1b3e6106f..9ec1703f45ad 100644
--- a/include/uapi/linux/random.h
+++ b/include/uapi/linux/random.h
@@ -49,7 +49,7 @@ struct rand_pool_info {
  *
  * GRND_NONBLOCK	Don't block and return EAGAIN instead
  * GRND_RANDOM		No effect
- * GRND_INSECURE	Return non-cryptographic random bytes
+ * GRND_INSECURE	No effect
  */
 #define GRND_NONBLOCK	0x0001
 #define GRND_RANDOM	0x0002
-- 
2.35.0

