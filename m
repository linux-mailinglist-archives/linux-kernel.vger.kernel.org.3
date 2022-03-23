Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C894E4BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 05:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiCWEC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 00:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiCWECZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 00:02:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F36403EF;
        Tue, 22 Mar 2022 21:00:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FDB86152F;
        Wed, 23 Mar 2022 04:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB13C340E8;
        Wed, 23 Mar 2022 04:00:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="B8jjZXYB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648008052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rArObsGrIA+CZzY+aR2vyQPSwI1FLNZscc57zebd6IA=;
        b=B8jjZXYBZhomYifjoxrnHX0BOz4rDhGe68SOXLYYABff4xVw2pBFTu3S7+x6j5RjayefSL
        LHQ9qQlqfmM0AAM953ycgmzLda363Otc3cIEmN8WvYof5TIsi8zrKYwQQqRYGMbP89exwr
        LnU+Fh+VZbp5DHtSsZB1vn7sUbI45+g=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 19660a94 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 23 Mar 2022 04:00:52 +0000 (UTC)
Date:   Tue, 22 Mar 2022 22:00:49 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] random: allow writes to /dev/urandom to influence fast
 init
Message-ID: <YjqbcQbYHCOpgqGg@zx2c4.com>
References: <20220322191436.110963-1-Jason@zx2c4.com>
 <YjqVemCkZCU1pOzj@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YjqVemCkZCU1pOzj@mit.edu>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

On Tue, Mar 22, 2022 at 9:35 PM Theodore Ts'o <tytso@mit.edu> wrote:
> One of the big issues with /dev/urandom writes is that *anyone*,
> including malicious user space, can force specific bytes to be mixed
> in.  That's the source of the reluctance to immediate use inputs from
> writes into /dev/[u]random until there is a chance for it to be mixed
> in with other entropy which is hopefully not under the control of
> malicious userspace.

Right, sort of. Since we now always use a cryptographic hash function,
we can haphazardly mix whatever any user wants, without too much
concern. The issue is whether we _credit_ those bits. Were we to credit
those bits, a malicious unpriv'd user could credit 248 bits of known
input, and then bruteforce 8 bits of unknown input, and repeat, and in
that way destroy the security of the thing. So, yea, the current
reluctance does make sense.

> Now, I recognize that things are a bit special in early boot, and if
> we have a malicious script running in a systemd unit script, we might
> as well go home.  But something to consider is whether we want to do
> soemthing special if the process writing to /dev/[u]random has
> CAP_SYS_ADMIN, or some such.

Exactly. So one way of approaching this would be to simply credit writes
to /dev/urandom if it's CAP_SYS_ADMIN and maybe if also !crng_ready(),
and just skip the crng_pre_init_inject() part that this current patch
adds. I'll attach a sample patch of what this might look like at the end
of this email.

The problem with that approach, though, is that various userspaces might
already write garbage into /dev/urandom, not expecting them to be
credited -- for example, some userspace hardware configuration component
that writes some serial number there. So I'm sort of hesitant to
_change_ the behavior that we've had for so long.

Another variation on that would be to do what this current patch does,
but only crng_pre_init_inject() on CAP_SYS_ADMIN. But this has the same
pitfall of only working as intended at cnrg_init=0 but not crng_init=1.
That's better than nothing, but it's not perfect, and it introduces that
problem with RNDADDTOENTCNT.

Also, to echo the point I made in the email I just sent to David, this
has _always_ been broken, and those shell scripts have _always_ been
vulnerable. Maybe the kernel should fix that, but due to the ambiguity
of the /dev/urandom write interface, maybe the best fix is actually in
userspace itself, which means it'd work on old kernels too (which are
rather common for the embedded devices that tend to have those types of
shell scripts). Specifically, I'm talking about this fix I did for
systemd:

https://github.com/systemd/systemd/commit/da2862ef06f22fc8d31dafced6d2d6dc14f2ee0b

And then the same fix that I just submitted this evening for Buildroot:

https://lists.buildroot.org/pipermail/buildroot/2022-March/639359.html

It seems like hashing the old seed together with the new one ought to be
a good standard practice to mitigate against all sorts of bugs.

> Yeah, no one should ever ver ever be using RNDADDTOENTCNT.  It's an
> ioctl which requires root privilegs, and if it breaks, you get to keep
> both pieces.
>
> > And perhaps we might consider attempting to deprecate RNDADDTOENTCNT at
> > some point in the future.
>
> That would be a good idea.  :-)

Oh cool, I'm glad you agree. Let's do that then. Have a preferred path?
Maybe just a pr_once() saying not to use it?

Jason

--------8<-------------------------------------------

The CAP_SYS_ADMIN idea, maybe not so good, but here for illustration:

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 706f08edf0dc..d1dc46366647 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1493,12 +1493,16 @@ static __poll_t random_poll(struct file *file, poll_table *wait)
 	return mask;
 }
 
-static int write_pool(const char __user *ubuf, size_t count)
+static int write_pool(const char __user *ubuf, size_t count, bool credit_at_boot)
 {
-	size_t len;
+	size_t len, bits;
 	int ret = 0;
 	u8 block[BLAKE2S_BLOCK_SIZE];
 
+	if (count > SIZE_MAX / 8)
+		return -EINVAL;
+	bits = count * 8;
+
 	while (count) {
 		len = min(count, sizeof(block));
 		if (copy_from_user(block, ubuf, len)) {
@@ -1511,6 +1515,9 @@ static int write_pool(const char __user *ubuf, size_t count)
 		cond_resched();
 	}
 
+	if (credit_at_boot && !crng_ready() && capable(CAP_SYS_ADMIN))
+		credit_entropy_bits(bits);
+
 out:
 	memzero_explicit(block, sizeof(block));
 	return ret;
@@ -1521,7 +1528,7 @@ static ssize_t random_write(struct file *file, const char __user *buffer,
 {
 	int ret;
 
-	ret = write_pool(buffer, count);
+	ret = write_pool(buffer, count, true);
 	if (ret)
 		return ret;
 
@@ -1584,7 +1591,7 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 			return -EINVAL;
 		if (get_user(size, p++))
 			return -EFAULT;
-		retval = write_pool((const char __user *)p, size);
+		retval = write_pool((const char __user *)p, size, false);
 		if (retval < 0)
 			return retval;
 		credit_entropy_bits(ent_count);
