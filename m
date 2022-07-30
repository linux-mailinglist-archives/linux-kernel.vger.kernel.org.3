Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD293585A5A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 14:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiG3MAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 08:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbiG3MAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 08:00:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B0613EAB;
        Sat, 30 Jul 2022 05:00:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2A4AB80E05;
        Sat, 30 Jul 2022 12:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC21C433C1;
        Sat, 30 Jul 2022 12:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659182429;
        bh=g0xyjqQPMC6JiTcqLBVlrILQwBUFyXz8xSHhDNEJgIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LKK7ipEBEPJnvmDQ801tH/Axl5jnuwKZA2DrRuIOPfngpoWMd9c3WIyjizkj/+Oh0
         6FMz7OIBdbFZ+adxKLso0OBCLfAfxaGopigcyicmgYQO/LbwmWGLm+AytFFFqOkqw3
         dTLW2EUrfBvYCaY3U+XjE6UDC8fkvOriIjGzWkb4=
Date:   Sat, 30 Jul 2022 14:00:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Xingrui Yi <yixingrui@linux.alibaba.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt: remove old FONT ioctls definitions in uapi
Message-ID: <YuUdWoa7UFHmkNu9@kroah.com>
References: <20220722061133.7765-1-yixingrui@linux.alibaba.com>
 <YuJIIl/LwGwuYdib@kroah.com>
 <YuRPZX4S3DHsLeDs@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YuRPZX4S3DHsLeDs@angband.pl>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 11:21:41PM +0200, Adam Borowski wrote:
> On Thu, Jul 28, 2022 at 10:26:10AM +0200, Greg KH wrote:
> > On Fri, Jul 22, 2022 at 02:11:33PM +0800, Xingrui Yi wrote:
> > > As was demonstrated by commit ff2047fb755d ("vt: drop old FONT ioctls"),
> > > old font ioctls like PIO_FONT have been deleted and KDFONTOP ioctl is used
> > > for years instead.
> > > 
> > > However, unused definitions of these ioctl numbers and "strut
> > > consolefontdesc" still exist in a uapi header. They could have been removed
> > > since no userspace was using them. Otherwise they will become a
> > > misleading for users, and users will fail with ENOTTY with wrong call.
> 
> > > -#define GIO_FONT	0x4B60	/* gets font in expanded form */
> > > -#define PIO_FONT	0x4B61	/* use font in expanded form */
> > > -#define GIO_FONTX	0x4B6B	/* get font using struct consolefontdesc */
> > > -#define PIO_FONTX	0x4B6C	/* set font using struct consolefontdesc */
> > > -struct consolefontdesc {
> > > -#define PIO_FONTRESET   0x4B6D	/* reset to default font */
> 
> > Did you rebuild a distribution like Debian to verify that these values
> > and structure are not used anywhere?
> 
> I just did.  https://codesearch.debian.net lists packages to check:
> aalib
> busybox
> cde
> console-cyrillic
> dietlibc
> doclifter
> emscripten
> fpc
> gargoyle-free
> gcc-10
> gcc-11
> gcc-12
> gcc-9
> gcc-arm-none-eabi
> gcc-avr
> gcc-riscv64-unknown-elf
> gcc-snapshot
> hurd
> kbd
> kfreebsd-10
> lazarus
> libabigail
> libexplain
> linux
> llvm-toolchain-11
> llvm-toolchain-12
> llvm-toolchain-13
> llvm-toolchain-14
> llvm-toolchain-9
> llvm-toolchain-snapshot
> lynx
> manpages-l10n
> sequeler
> strace
> stress-ng
> systemd
> trinity
> vala
> valgrind
> 
> Of these, I've ignored the kernels, and built only the latest released
> version of a compiler.
> 
> .--====[ aalib ]
> aalinux.c: In function ‘linux_init’:
> aalinux.c:106:34: error: storage size of ‘desc’ isn’t known
>   106 |           struct consolefontdesc desc;
>       |                                  ^~~~
> aalinux.c:109:26: error: ‘GIO_FONTX’ undeclared (first use in this function)
>   109 |           i = ioctl (fd, GIO_FONTX, &desc);
>       |                          ^~~~~~~~~
> `----
> 
> .--====[ kbd ]
> kdfontop.c: In function ‘kfont_restore_font’:
> kdfontop.c:27:23: error: ‘PIO_FONTRESET’ undeclared (first use in this function)
>    27 |         if (ioctl(fd, PIO_FONTRESET, 0)) {
>       |                       ^~~~~~~~~~~~~
> kdfontop.c: In function ‘get_font_giofontx’:
> kdfontop.c:89:32: error: storage size of ‘cfd’ isn’t known
> kdfontop.c:102:30: error: ‘GIO_FONTX’ undeclared
> kdfontop.c: In function ‘get_font_giofont’:
> kdfontop.c:137:30: error: ‘GIO_FONT’ undeclared
> kdfontop.c: In function ‘put_font_piofontx’:
> kdfontop.c:242:32: error: storage size of ‘cfd’ isn’t known
> kdfontop.c:262:31: error: ‘PIO_FONTX’ undeclared
> kdfontop.c: In function ‘put_font_piofont’:
> kdfontop.c:299:31: error: ‘PIO_FONT’ undeclared
> `----
> 
> .--====[ gcc-12 ]
> ../../../../src/libsanitizer/sanitizer_common/sanitizer_platform_limits_posix.cpp:850:29: error: 'GIO_FONT' was not declared in this scope
>   850 |   unsigned IOCTL_GIO_FONT = GIO_FONT;
>       |                             ^~~~~~~~
> `----
> 
> .--====[ llvm-toolchain-14 ]
> /<<PKGBUILDDIR>>/compiler-rt/lib/sanitizer_common/sanitizer_platform_limits_posix.cpp:865:29: error: use of undeclared identifier 'GIO_FONT'
>   unsigned IOCTL_GIO_FONT = GIO_FONT;
>                             ^
> /<<PKGBUILDDIR>>/compiler-rt/lib/sanitizer_common/sanitizer_platform_limits_posix.cpp:898:29: error: use of undeclared identifier 'PIO_FONT'
>   unsigned IOCTL_PIO_FONT = PIO_FONT;
>                             ^
> `----
> 
> .--====[ libexplain ]
> libexplain/buffer/consolefontdesc.c: In function ‘explain_buffer_consolefontdesc’:
> libexplain/buffer/consolefontdesc.c:34:48: error: invalid application of ‘sizeof’ to incomplete type ‘c
> onst struct consolefontdesc’
>    34 |     if (explain_is_efault_pointer(value, sizeof(*value)))
>       |                                                ^
> libexplain/buffer/consolefontdesc.c:43:14: error: invalid use of undefined type ‘const struct consolefo
> ntdesc’
>    43 |         value->charcount,
>       |              ^~
> `----
> 
> .--====[ trinity ]
> In file included from ioctls/vt.c:8:
> ioctls/vt.c:48:15: error: ‘GIO_FONT’ undeclared here (not in a function)
>    48 |         IOCTL(GIO_FONT),
>       |               ^~~~~~~~
> include/ioctls.h:53:22: note: in definition of macro ‘IOCTL’
>    53 |         { .request = _request, .name = #_request, }
>       |                      ^~~~~~~~
> ioctls/vt.c:49:15: error: ‘PIO_FONT’ undeclared here (not in a function)
>    49 |         IOCTL(PIO_FONT),
>       |               ^~~~~~~~
> ioctls/vt.c:50:15: error: ‘GIO_FONTX’ undeclared here (not in a function)
> ioctls/vt.c:51:15: error: ‘PIO_FONTX’ undeclared here (not in a function)
> ioctls/vt.c:52:15: error: ‘PIO_FONTRESET’ undeclared here (not in a function)
> `----
> 
> 
> So there _are_ failures in userspace.
> But let's take a look at them:
> 
> * aalib: dead upstream since 2001, this code is broken
> * kbd: uses KDFONTOP, falls back if unsupported
> * libsanitizer (bundled in gcc, llvm-toolchain): can drop
> * libexplain: can drop
> * trinity: can drop
> 
> So we have one real failure, one fallback, and a few "lists all ioctls".
> I'd say that's acceptable.  Especially because presence of code that list
> all ioctls means we would never done any clean-up otherwise.

Nope, we can't break exiting tools, especially for things like gcc or
llvm which do get built often.  We've been down this path before, and
had to revert things in the past.  We can only remove stuff like this
when all users are gone.

Please work with the gcc and llvm developers to remove those usages,
along with the other packages and maybe we can revisit this in 5 years
or so.

thanks,

greg k-h
