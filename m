Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DF74B4519
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242652AbiBNJBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:01:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242635AbiBNJA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:00:57 -0500
X-Greylist: delayed 414 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 01:00:48 PST
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8725FF0B;
        Mon, 14 Feb 2022 01:00:48 -0800 (PST)
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 20549E80485;
        Mon, 14 Feb 2022 09:53:50 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 72E3916010E; Mon, 14 Feb 2022 09:53:49 +0100 (CET)
Date:   Mon, 14 Feb 2022 09:53:49 +0100
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH RFC v0] random: block in /dev/urandom
Message-ID: <YgoYnX97imub7KEB@gardel-login>
References: <20220211210757.612595-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211210757.612595-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 11.02.22 22:07, Jason A. Donenfeld (Jason@zx2c4.com) wrote:

> So, given that the kernel has grown this mechanism for seeding itself
> from nothing, and that this procedure happens pretty fast, maybe there's
> no point any longer in having /dev/urandom give insecure bytes. In the
> past we didn't want the boot process to deadlock, which was
> understandable. But now, in the worst case, a second goes by, and the
> problem is resolved. It seems like maybe we're finally at a point when
> we can get rid of the infamous "urandom read hole".

So, systemd uses (potentially half-initialized) /dev/urandom for
seeding its hash tables. For that its kinda OK if the random values
have low entropy initially, as we'll automatically reseed when too
many hash collisions happen, and then use a newer (and thus hopefully
better) seed, again acquired through /dev/urandom. i.e. if the seeds
are initially not good enough to thwart hash collision attacks, once
the hash table are actually attacked we'll replace the seeds with
someting better. For that all we need is that the random pool
eventually gets better, that's all.

So for that usecase /dev/urandom behaving the way it so far does is
kinda nice. We need lots of hash tables, from earliest initialization
on, hence the ability to get some seed there reasonably fast is really
good, even if its entropy is initially not as high as we'd want. It's
a good middle ground for us to be able to boot up quickly and not
having to block until the entropy pool is fully initialized, but still
thwart hash table collision attacks.

If you make /dev/urandom block for initialization then this would mean
systemd and its components would start waiting for initialization
(simply because we need hash tables all over the place), i.e you'd
effectively add a second to the boot process of each affected system.

What about AT_RANDOM and /proc/sys/kernel/random/uuid btw, do you
intend to block for that too? If you block for the former it doesn't
really matter what systemd does I guess, given that you already have
to delay invoking PID 1 until you get a good AT_RANDOM.

Lennart

--
Lennart Poettering, Berlin
