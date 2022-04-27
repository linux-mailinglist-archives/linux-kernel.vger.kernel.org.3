Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEB1511922
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbiD0OCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236931AbiD0OCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:02:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3212945503;
        Wed, 27 Apr 2022 06:59:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB4BCB82794;
        Wed, 27 Apr 2022 13:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02255C385AC;
        Wed, 27 Apr 2022 13:58:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YPfVYPFf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651067935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=PkGTsxRJlFtt9ULahCauBVNzw0pkNDHGTuGCtNBsayE=;
        b=YPfVYPFfxjJRC+Gz5Wg58j517Q3i9/QNwGVpWWZ7SxqownhngZs5eDt2O8lSoQtHvRSjpA
        VkZvu/WkilP/8nSOvWbfQIXNh/fA7Of8718yiewD9gTiy2dK6vbQRt2Qmzi0aEnIbjkOj3
        FobG9yGO6YkyXPb5v5bv3dMdw2JXDwA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8f40a0ab (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 27 Apr 2022 13:58:54 +0000 (UTC)
Date:   Wed, 27 Apr 2022 15:58:51 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     nadiah@cs.ucsd.edu, noahsd@gmail.com, dodis@cs.nyu.edu,
        tessaro@cs.washington.edu, torvalds@linux-foundation.org,
        djb@cr.yp.to, tytso@mit.edu, jeanphilippe.aumasson@gmail.com,
        jann@thejh.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        peter@cryptojedi.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: is "premature next" a real world rng concern, or just an academic
 exercise?
Message-ID: <YmlMGx6+uigkGiZ0@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

The Linux kernel RNG currently pretends to care about the "premature
next" RNG threat model. I'm wondering whether this is sensible and
corresponds to anything real.

"Premature next" is the scenario in which:
- Attacker compromises the current state of a fully initialized RNG with
  a wild 'n crazy kernel infoleak.
- New bits of entropy are added directly to the key used to generate the
  /dev/urandom stream, without any buffering or pooling.
- Attacker then, somehow having read access to /dev/urandom, samples RNG
  output and brute forces the individual new bits that were added.
- Result: the RNG never "recovers" from the initial compromise, a
  so-called violation of what academics term "post-compromise security".

(Note that this is a different scenario from "premature first", which
relates to boot-time concerns; this email isn't about "premature
first".)

There are other varied scenarios to this, usually involving some
combination of:
a) Attacker has access to /dev/urandom output continuously or at some
   interesting interval.
b) Attacker controls one or more entropy sources providing some subset
   of varying size of those new bits of entropy.

The Linux kernel currently pretends to mitigate this for scenario (a) at
least, using "entropy estimation". The idea is that it waits until 256
estimated "bits" of new entropy are pooled before mixing them into the
key used to generate the /dev/urandom stream. Never mind the fact that
entropy estimation is an impossible proposition and thus flawed, it
certainly does nothing in the way of (b), since there's just one pool.

The NT kernel is a bit more robust, by way of their Fortuna RNG, in
which there are several pools, and entropy sources round-robin into
those pools. When it's time to reseed, the first pool is used every
time, the second pool is used every other time, the third pool is used
every third time, the forth pool is used every forth time, and so on. In
theory this should handle both (a) and (b) without needing entropy
estimation, and this sort of scheduler prompts interesting questions for
academics with regards to different types of scheduling (a random walk
instead of round-robin? sounds like a paper topic.) and trying to
characterize the rate of inputs (continuous? sporadic? modelable?).

While the above "problem" maps pretty clearly to things academics are
interested in -- post-compromise security for a system with a clear
model and various creative solutions -- I'm wondering whether any of
this matters in the real world. From conversations over the last several
months with various security experts and cryptographers, including those
who work on the "premature next" problem, the impression I get is that
nobody actually thinks this matters back on planet Earth, even from
people who write papers on it.

So the purpose of this email is to solicit feedback on whether anybody
can think of a plausible scenario in which it does matter. If it does
matter, the next step will be to determine how much it matters exactly,
in order for me to gauge the cost-benefit ratio of mitigating the issue
more robustly in the kernel (e.g. Fortuna requires non-zero code
complexity; does the benefit outweigh the cost of such complexity?). On
the other hand, if nobody can think of any reason why this matters, then
there are some nice improvements that I'm eager to make in a different
direction.

To review, this attack model concerns:
- An attacker who compromises the RNG at one point in time via a kernel
  infoleak.
- After that infoleak, the attacker somehow no longer has access to the
  system, but can prevent the RNG from recovering from the compromise by
  having pretty rapid access to /dev/urandom (and possibly also having
  compromised zero or more entropy sources).

The questions are thus:

1) When does an attacker with a kernel infoleak exercise it just once,
   and then attempt to maintain the leak with some sort of network access
   to lots of /dev/urandom output (from, e.g., large nonces)?

2) Or, if it's a local user attacker, when does that attacker infoleak
   once, but rather than just running the exploit again, cats /dev/urandom
   continuously?

3) More broadly speaking, what kernel infoleak is actually acceptable to
   the degree that anybody would feel okay in the first place about the
   system continuing to run after it's been compromised?

Looking forward to hearing opinions on this. There's certainly a lot to
split hairs about above -- incomplete/inaccurate description of the
"premature next" model, what Fortuna actually achieves, my entropy
estimation remark, and so forth -- but hopefully this at least throws
enough things at the board to begin the discussion.

Is "premature next" just an academic exercise, rather than a real world
RNG concern?

Regards,
Jason
