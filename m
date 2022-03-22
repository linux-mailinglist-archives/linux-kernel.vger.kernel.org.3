Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E594E45F4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbiCVS1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240470AbiCVS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:27:02 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F27592D12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:24:58 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22MIOmmq011881;
        Tue, 22 Mar 2022 19:24:48 +0100
Date:   Tue, 22 Mar 2022 19:24:48 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        llvm@lists.linux.dev
Subject: Re: [RFC PATCH v2 2/8] tools/nolibc: Remove .global _start from the
 entry point code
Message-ID: <20220322182448.GQ10306@1wt.eu>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322102115.186179-3-ammarfaizi2@gnuweeb.org>
 <CAKwvOdkEwkzT0uf9a5SokCScDTY4gbhNFZ+fLxsti9innaEZRQ@mail.gmail.com>
 <20220322172550.GL10306@1wt.eu>
 <CAKwvOdmr6u-zNynUDAg4pmwerQFUkG+eD0QhpzDED9eg+U2pfA@mail.gmail.com>
 <20220322175816.GN10306@1wt.eu>
 <CAKwvOd=LvBL4NTUWMc0rJ-3K+MU5rv-p+j2pfbuseGdiA2ccJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=LvBL4NTUWMc0rJ-3K+MU5rv-p+j2pfbuseGdiA2ccJw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 11:07:17AM -0700, Nick Desaulniers wrote:
> > First, the usual static printf("hello world!\n"):
> >
> >   $ ll hello-*libc
> >   -rwxrwxr-x 1 willy dev 719232 Mar 22 18:50 hello-glibc*
> >   -rwxrwxr-x 1 willy dev   1248 Mar 22 18:51 hello-nolibc*
> 
> ! What! Are those both statically linked?

Yes:

  $ file hello-nolibc 
  hello-nolibc: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, stripped

  (rebuilding without stripping)
  $ nm --size hello-nolibc 
  000000000000000f T main
  0000000000000053 t u64toa_r
  0000000000000280 t printf.constprop.0
  $ nm hello-nolibc 
  00000000004013c5 R __bss_start
  00000000004013c5 R _edata
  00000000004013c8 R _end
  00000000004000bf W _start
  00000000004000b0 T main
  0000000000400130 t printf.constprop.0
  00000000004000dd t u64toa_r

> > This one supports ~30-40 simple commands (mount/unmount, mknod, ls, ln),
> > a tar extractor, multi-level braces, and boolean expression evaluation,
> > variable expansion, and a config file parser to script all this. The code
> > is 20 years old and is really ugly (even uglier than you think). But that
> > gives an idea. 20 years ago the init was much simpler and 800 bytes (my
> > constraint was for single floppies containing kernel+rootfs) and strings
> > were manually merged by tails and put in .text to drop .rodata.
> 
> Oh, so nolibc has been around for a while then?

Not exactly. Over time I collected some of my stuff out of preinit to
make more reusable code for other tools, and eventually created a separate
project for it 5 years ago [1]. I then changed my mind a few times on how
to arrange all this and over time it became a bit easier to use. One day
Paul asked how to make less invasive static binaries for rcutorture and I
found that it was the perfect match so we agreed to integrate it there. It
was still a single file by then. And as usual when some code starts to get
more exposure it receives more contribs and feature requests ;-)

> ld.lld will do string merging in that fashion at -O2 (the linker can
> accept and optimization level).  I did have a kernel patch for that
> somewhere, need to update it for CC_OPTIMIZE_FOR_SIZE...

Ah I didn't know, that's good to know!

> I guess the tradeoff with strings in .text is that now the strings
> themselves are r+x and not just r?

Yes but when you're writing a small shell to allow you to manually
mount your rootfs from the kernel, you don't really care if someone
might try to use some of your strings as code gadgets for ROP exploits :-)

I would really not want to see this used for general programs, but it
does fit well with hacking stuff for initramfs, and what lies in the
selftests directory in general I guess.

What I particularly like is that I don't need a full toolchain, so if
I can build a kernel with the bare-metal compilers from kernel.org then
I know I can also build my initramfs that's packaged in it using the
exact same compiler. This significantly simplifies the build process.

Willy

[1] https://github.com/wtarreau/nolibc
