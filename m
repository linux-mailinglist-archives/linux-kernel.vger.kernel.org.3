Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1594E459F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbiCVSAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239994AbiCVR7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:59:55 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8B191277A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:58:25 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22MHwGov011795;
        Tue, 22 Mar 2022 18:58:16 +0100
Date:   Tue, 22 Mar 2022 18:58:16 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        llvm@lists.linux.dev
Subject: Re: [RFC PATCH v2 2/8] tools/nolibc: Remove .global _start from the
 entry point code
Message-ID: <20220322175816.GN10306@1wt.eu>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322102115.186179-3-ammarfaizi2@gnuweeb.org>
 <CAKwvOdkEwkzT0uf9a5SokCScDTY4gbhNFZ+fLxsti9innaEZRQ@mail.gmail.com>
 <20220322172550.GL10306@1wt.eu>
 <CAKwvOdmr6u-zNynUDAg4pmwerQFUkG+eD0QhpzDED9eg+U2pfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmr6u-zNynUDAg4pmwerQFUkG+eD0QhpzDED9eg+U2pfA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 10:30:53AM -0700, Nick Desaulniers wrote:
> (Moving folks to bcc; check the lists if you're interested)

Yes, agreed :-)

> On Tue, Mar 22, 2022 at 10:25 AM Willy Tarreau <w@1wt.eu> wrote:
> > The purpose is clearly *not* to implement a libc, but to have
> > something very lightweight that allows to compile trivial programs. A good
> > example of this is tools/testing/selftests/rcutorture/bin/mkinitrd.sh. I'm
> > personally using a tiny pre-init shell that I always package with my
> > kernels and that builds with them [1]. It will never do big things but
> > the balance between ease of use and coding effort is pretty good in my
> > experience. And I'm also careful not to make it complicated to use nor
> > to maintain, pragmatism is important and the effort should remain on the
> > program developer if some arbitration is needed.
> 
> Neat, I bet that helps generate very small initrd! Got any quick size
> measurements?

Yep:

First, the usual static printf("hello world!\n"):

  $ ll hello-*libc
  -rwxrwxr-x 1 willy dev 719232 Mar 22 18:50 hello-glibc*
  -rwxrwxr-x 1 willy dev   1248 Mar 22 18:51 hello-nolibc*

  $ objdump -h hello-nolibc 
  hello-nolibc:     file format elf64-x86-64

  Sections:
  Idx Name          Size      VMA               LMA               File off  Algn
    0 .text         00000300  00000000004000b0  00000000004000b0  000000b0  2**0
                    CONTENTS, ALLOC, LOAD, READONLY, CODE
    1 .rodata       00000015  00000000004003b0  00000000004003b0  000003b0  2**0
                    CONTENTS, ALLOC, LOAD, READONLY, DATA

Then the preinit stuff:

  $ ll initramfs/init 
  -rwxr-xr-x 1 willy users 13936 Mar 22 18:40 initramfs/init*

  $ xz -c9 < initramfs/init | wc -c
  8392

  $ size initramfs/init 
     text    data     bss     dec     hex filename
    13348       0   23016   36364    8e0c init

  $ objdump -h initramfs/init
  initramfs/init:     file format elf64-x86-64
  Sections:
  Idx Name          Size      VMA               LMA               File off  Algn
    0 .text         00002b74  00000000004000e8  00000000004000e8  000000e8  2**0
                    CONTENTS, ALLOC, LOAD, READONLY, CODE
    1 .rodata       000008b0  0000000000402c60  0000000000402c60  00002c60  2**5
                    CONTENTS, ALLOC, LOAD, READONLY, DATA
    2 .bss          000059e8  0000000000404520  0000000000404520  00003520  2**5
                    ALLOC

This one supports ~30-40 simple commands (mount/unmount, mknod, ls, ln),
a tar extractor, multi-level braces, and boolean expression evaluation,
variable expansion, and a config file parser to script all this. The code
is 20 years old and is really ugly (even uglier than you think). But that
gives an idea. 20 years ago the init was much simpler and 800 bytes (my
constraint was for single floppies containing kernel+rootfs) and strings
were manually merged by tails and put in .text to drop .rodata.

You'll also note that there's 0 data segment above. That used to be
convenient to further shrink programs, but these days given how linkers
arrange segments by permissions that doesn't save as much as it used to,
and it's likely that at some points I'll assume that there must be some
variables by default (errno, environ, etc) and that we'll accept to invest
a few extra tens of bytes by default for more convenience.

Cheers,
Willy
