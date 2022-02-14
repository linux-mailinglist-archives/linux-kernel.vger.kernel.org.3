Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5394B53C9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355413AbiBNOx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:53:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242807AbiBNOxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:53:24 -0500
X-Greylist: delayed 21564 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 06:53:16 PST
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3ED42EE3;
        Mon, 14 Feb 2022 06:53:16 -0800 (PST)
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 2D1E0E8045A;
        Mon, 14 Feb 2022 15:53:14 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id BF6CC16010E; Mon, 14 Feb 2022 15:53:13 +0100 (CET)
Date:   Mon, 14 Feb 2022 15:53:13 +0100
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
Message-ID: <Ygps2W6MfxKkP5eD@gardel-login>
References: <20220211210757.612595-1-Jason@zx2c4.com>
 <YgoYnX97imub7KEB@gardel-login>
 <YgpjfncV+C9FEZDc@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgpjfncV+C9FEZDc@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 14.02.22 15:13, Jason A. Donenfeld (Jason@zx2c4.com) wrote:

> Hi Lennart,
>
> On Mon, Feb 14, 2022 at 9:53 AM Lennart Poettering <mzxreary@0pointer.de> wrote:
> > So, systemd uses (potentially half-initialized) /dev/urandom for
> > seeding its hash tables. For that its kinda OK if the random values
> > have low entropy initially, as we'll automatically reseed when too
> > many hash collisions happen, and then use a newer (and thus hopefully
> > better) seed, again acquired through /dev/urandom. i.e. if the seeds
> > are initially not good enough to thwart hash collision attacks, once
> > the hash table are actually attacked we'll replace the seeds with
> > someting better. For that all we need is that the random pool
> > eventually gets better, that's all.
> >
> > So for that usecase /dev/urandom behaving the way it so far does is
> > kinda nice.
>
> Oh that's an interesting point. But that sounds to me like the problem
> with this patch is not that it makes /dev/urandom block (its primary
> purpose) but that it also removes GRND_INSECURE (a distraction). So
> perhaps an improved patch would be something like the below, which
> changes /dev/urandom for new kernels but doesn't remove GRND_INSECURE.
> Then your hash tables could continue to use GRND_INSECURE and all would
> be well.  (And for kernels without getrandom(), they'd just fall back to
> /dev/urandom like normal which would have old semantics, so works.)

In fact, systemd already uses getrandom(GRND_INSECURE) for this, if it
is supported, and falls back to /dev/urandom only if it is not. So as
long as GRND_INSECURE remains available we are good.

Lennart

--
Lennart Poettering, Berlin
