Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B11508D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380478AbiDTQVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380464AbiDTQVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:21:19 -0400
X-Greylist: delayed 151 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Apr 2022 09:18:31 PDT
Received: from wrqvvpks.outbound-mail.sendgrid.net (wrqvvpks.outbound-mail.sendgrid.net [149.72.131.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87A933A38
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=catern.com;
        h=from:subject:mime-version:to:cc:content-type:
        content-transfer-encoding;
        s=s1; bh=EN7Luo3GMJhLlC/mt0FKildypLmFmFvGR+/jZZeUY2M=;
        b=EcdnZSj7lNJoGFfgBQilz8IIPticWslnmuBGep9/d4808no+vTtdNiky2KJpIIZaavIC
        U4ZiRyvQakk9udPetuRNRqBYxfDBDwc2b99xyilG0G4KdQJNPtZDoyUcMzlea54kl1iTib
        6g5PDbW5sn6GcJgBsGzteOjoMZc8xQNBPLt+oKFNSNgtbWoVyyNr5KDFnXZMedX7NMbbTw
        Yznd41KVBTTN653B6TxItdAxoZtom2v5loCB4YtaJtytYPZcRTUk9jeua616C/yTqSOdQf
        p5h0PqTYwIxoTZ860QhZApnAsmjLoxq+YHjWBXTdRg9cT5xHpoOlbHQfmyDzRAVA==
Received: by filterdrecv-5645d9c87f-64zxs with SMTP id filterdrecv-5645d9c87f-64zxs-1-6260319D-10
        2022-04-20 16:15:25.060658459 +0000 UTC m=+1189873.688363729
Received: from earth.catern.com (unknown)
        by geopod-ismtpd-2-4 (SG)
        with ESMTP
        id L1cDp85IRLmtZoiFwzAtDw
        Wed, 20 Apr 2022 16:15:24.846 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=::1; helo=localhost; envelope-from=sbaugh@catern.com; receiver=<UNKNOWN> 
Received: from localhost (localhost [IPv6:::1])
        by earth.catern.com (Postfix) with ESMTPSA id CCFDA60089;
        Wed, 20 Apr 2022 12:15:23 -0400 (EDT)
From:   Spencer Baugh <sbaugh@catern.com>
Subject: Explicitly defining the userspace API
Date:   Wed, 20 Apr 2022 16:15:25 +0000 (UTC)
Message-ID: <874k2nhgtg.fsf@catern.com>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?GW3oCMoYnalRiojMOuLzE6x2H5kORXvlCdz1UwQVRMVT4fbh9ODEfCogOe74cO?=
 =?us-ascii?Q?rI4e0V+MFZgakz9Re5a6=2FCgjy6GEoSnTxOKF1gT?=
 =?us-ascii?Q?uAnWM1KA27DMMvzzFj1a2HW2qEPwCq35ELHWGOl?=
 =?us-ascii?Q?r89xiFPwn5z+9peKu0xUU7I0rd7zYU7TMF2PBzZ?=
 =?us-ascii?Q?=2FaPMWPmCESZwP9joS44IpIu5vTz=2Fy9cnefJLIWD?=
 =?us-ascii?Q?vk+dL8lPnz9P5Pp4ni22pLlTUq0pBbWr+rlUT+?=
To:     linux-api@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, marcin@juszkiewicz.com.pl,
        torvalds@linux-foundation.org, arnd@arndb.de
X-Entity-ID: d/0VcHixlS0t7iB1YKCv4Q==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linux guarantees the stability of its userspace API, but the API
itself is only informally described, primarily with English prose.  I
want to add an explicit, authoritative machine-readable definition of
the Linux userspace API.

As background, in a conventional libc like glibc, read(2) calls the
Linux system call read, passing arguments in an architecture-specific
way according to the specific details of read.

The details of these syscalls are at best documented in manpages, and
often defined only by the implementation.  Anyone else who wants to
work with a syscall, in any way, needs to duplicate all those details.

So the most basic definition of the API would just represent the
information already present in SYSCALL_DEFINE macros: the C types of
arguments and return values.  More usefully, it would describe the
formats of those arguments and return values: that the first argument
to read is a file descriptor rather than an arbitrary integer, and
what flags are valid in the flags argument of openat, and that open
returns a file descriptor.  A step beyond that would be describing, in
some limited way, the effects of syscalls; for example, that read
writes into the passed buffer the number of bytes that it returned.

Even a basic machine-readable definition of the Linux userspace API
would have numerous benefits:

* Debugging tools which need to understand the format of syscalls and
 their arguments in great detail, such as strace, are currently
 primarily hand-written with great duplication of effort.  Even a
 basic description of syscalls would allow much of this code to be
 generated instead.

* It often takes a long time for newly-added syscalls to be usable in
 userspace.  With an explicit definition of the Linux userspace API,
 it would be easy to automatically generate functions for new
 syscalls, which could be deployed quickly either as part of libc or
 in a separate syscall library.

* Implementers of new languages currently almost always make syscalls
 by going through libc.  Supporting interoperability with C in this
 way is a major burden, and the resulting interfaces are typically
 highly unidiomatic for the new language.  With a explicit definition
 of the Linux API, it would be much easier for new languages to make
 syscalls directly (rather than through libc) by automatically
 generating syscall functions which are idiomatic to the new language;
 for example, functions which preserve memory-safety and type-safety
 in Rust.

* Reimplementers of the Linux API, such as Linuxulator, WSL1, and
 gVisor, would be able to generate stubs for the interfaces they need
 to implement automatically, reducing duplicated code and making them
 conform better to the Linux API.

* Changes to Linux behavior that require a change in the API
 definition would deserve greater scrutiny by maintainers, since such
 a change might break userspace.  This certainly could never catch all
 possible API breaks, but it would be one more way to prevent
 regressions.

* Any other tool which needs to understand the Linux API would
 benefit, such as more esoteric projects to batch syscalls, intercept
 and rewrite syscalls, forward syscalls to remote hosts, or any other
 syscall manipulations.

To write this definition, a new Linux-specific format for the
definition might need to be created.  At a minimum, it will need to be
able to describe bit-level data formats, complex pointer-based
data structures, tagged unions, "overloaded" syscalls such as ioctl,
and architecture-specific divergences.  Most existing formats and
languages for describing interfaces like this unfortunately lack these
capabilities.

Whatever the format of the definition, the most important feature is
that it must be maintainable by existing Linux developers.  One way to
achieve that might be to integrate it into the C code in some way,
building on top of SYSCALL_DEFINE.  The API description can then be
automatically extracted from the C code into a more-easily-reusable
format, which can be used as input for other tools.

One step in this direction is Documentation/ABI, which specifies the
stability guarantees for different userspace APIs in a semi-formal
way.  But it doesn't specify the actual content of those APIs, and it
doesn't cover individual syscalls at all.

Another related project is system call tables like
https://marcin.juszkiewicz.com.pl/download/tables/syscalls.html which
don't contain any more information than already in SYSCALL_DEFINE.

Hopefully this sounds like a reasonable thing to do.  I'm looking for
any comments or suggestions, or related projects I don't know about.
