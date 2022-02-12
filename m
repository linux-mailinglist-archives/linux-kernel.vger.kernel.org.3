Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6254B3885
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 00:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiBLXNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 18:13:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiBLXNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 18:13:39 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 969255F8CE
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 15:13:34 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 5036892009C; Sun, 13 Feb 2022 00:13:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 4182F92009B;
        Sat, 12 Feb 2022 23:13:33 +0000 (GMT)
Date:   Sat, 12 Feb 2022 23:13:33 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Joshua Kinard <kumba@gentoo.org>
cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
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
        Theodore Ts'o <tytso@mit.edu>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH RFC v0] random: block in /dev/urandom
In-Reply-To: <fcab986b-d0bd-c798-de17-266abcdc7da2@gentoo.org>
Message-ID: <alpine.DEB.2.21.2202122309560.34636@angie.orcam.me.uk>
References: <20220211210757.612595-1-Jason@zx2c4.com> <fcab986b-d0bd-c798-de17-266abcdc7da2@gentoo.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Feb 2022, Joshua Kinard wrote:

> # grep -r "PRID_IMP_R6000" *
> arch/mips/include/asm/cpu.h:70:#define PRID_IMP_R6000           0x0300
>     /* Same as R3000A  */
> arch/mips/include/asm/cpu.h:72:#define PRID_IMP_R6000A          0x0600
> arch/mips/include/asm/timex.h:94:       else if (likely(imp !=
> PRID_IMP_R6000 && imp != PRID_IMP_R6000A))
> 
> I'd say it's better to remove the check and simplify the conditional to
> eliminate this corner case.  Maybe keep the #defines around for
> documentation, but even that may not be necessary for CPUs that likely don't
> exist anymore.

 IIRC Ralf used to have a working R6k machine, but I have no idea what has 
happened to it.  No port of Linux has been made for that system though, 
that's for sure.

  Maciej
