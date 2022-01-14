Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D82448E321
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 05:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbiANEGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 23:06:46 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47096 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231851AbiANEGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 23:06:45 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20E463MO017760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 23:06:03 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1DCEB15C40F6; Thu, 13 Jan 2022 23:06:03 -0500 (EST)
Date:   Thu, 13 Jan 2022 23:06:03 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: Remove a.out support
Message-ID: <YeD2q77KmaD8k87Q@mit.edu>
References: <20220113160115.5375-1-bp@alien8.de>
 <YeBzxuO0wLn/B2Ew@mit.edu>
 <YeCuNapJLK4M5sat@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeCuNapJLK4M5sat@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 11:56:53PM +0100, Borislav Petkov wrote:
> On Thu, Jan 13, 2022 at 01:47:34PM -0500, Theodore Ts'o wrote:
> > Let's pour one out for being able to run Minix binaries on Linux.  :-)
> 
> https://en.wikipedia.org/wiki/Minix_3:
> 
> "2013-02-21 ... Dropped support for a.out binaries"
> 
> They themselves killed that support a lot earlier. :-)

Well, Minix 3 is a very different beast than the Minix 1.x that Linus
used when he was boot-strapping Linux back in 1991.  :-)

Among other things Minux 1.x is system call compatible with the
original V7 Unix from AT&T, whereas Minux 2.x and higher switch to
having system calls that were Posix comaptible --- and Minix 2, being
at teaching OS, wouldn't have kept any backwards compatibility when
Prof. Tannenbaum released the 2nd edition of his Operating Systems
Design and Implementation book in 1997.

> > Speaking of which, if we're doing this, are there some old system
> > calls that we could remove at the same time?
> 
> Good question.
> 
> Unfortunately, I'm just the janitor removing this and a.out is waaay
> before my time. :-)
> 
> But I'm open to suggestions on how to determine which are those obsolete
> syscalls.

Historically there were a couple of different C libraries
which x86 binaries for Linux could use:

A) minix's libc -- used by binaries compiled using the Minix 1 toolchain
B) Libc 4 -- a fork of GNU Libc version 1, for a.out execuables
C) Libc 5 -- a fork of GNU Libc version 1, for ELF execuables
D) Libc 6 -- GNU Libc version 2, for ELF executables

So I think what this would boil down to is finding those system calls
that were used by (A) and (B), but not referenced in (C) and (D).  I
guess we'd also have to check to make sure that some of these ancient
system calls might still be used by some of the micro libc's, such as
dietlibc, musl, etc.

Is it worth doing?  Perhaps; perhaps not.  It probably wouldn't reduce
the size of the kernel by all *that* much, but getting rid of cruft is
kind of a good thing for its own sake.

Cheers.

						- Ted
