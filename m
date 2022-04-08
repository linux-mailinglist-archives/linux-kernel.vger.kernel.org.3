Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AE54F8F2A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiDHGyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiDHGx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:53:56 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76D9132EB9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 23:51:41 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t4so7022517pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 23:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=axIk4sRsZmz9Ds2aqjezf85KoZ6ixUKA3EwO8pD59vU=;
        b=ijhLupIQpnidgLc83d8QQ39+RPWApgpJu7MaPnHWG+GvfRXiewh/tiPaVhe3a6302l
         j6cRCw6VrzLH5HvFfvQeISka2O/2VyMeXvhptqF3ZCRt5qg7Xyqa/RZWEzLH9TsRX+k4
         5UaH0VAxNsbj6UNbNro5Sn4hEXl+xfY5CM7BtMNCW/GSR0TmUMnaNTNeZWEaQ1tuA2h6
         Ajlve7tP/H+C2CFl1fKAreVFfJsUQ2blQsAxmQH+40kOgr1RfjYLXGvFfjNwrZ1FR/0J
         ee8LeBTc7cPK2Hs81a31Bne6dm6bzulzeGIaqoLR8eAUBjevC2X6qswsm+UdgVwRGThb
         spYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=axIk4sRsZmz9Ds2aqjezf85KoZ6ixUKA3EwO8pD59vU=;
        b=iH+/cBwYdv90WL9eHkPhmsj6Z+MmrW2VSy9dQRjXtmFO3tDhiW93bVAqYucloG8dq7
         BnPEJM94CnAUqqfP2ll0/9i7XrIFsLWGig8TdQXCtomJMarjIXQmd7WpGxG0/u4AaCwN
         HeD+BcByC1fOwzs7ScjwbXJjL2QwPzijDWlCwhpiymoMP8CXtiXu3Iz2JrcrVM9HUWYl
         41iptMuX6ojQNKJs4k/O6goTyP+13vzzRDuZAYPbLUFBG2E+93EuE8xf5QXlhRb6j07A
         /fYcOY/gYZq9IDhK9UygG1yfB1nF4CMd1Opodd0pDmfhBjS1PpcxqJdiHQTvPRu4gcbB
         pMsA==
X-Gm-Message-State: AOAM533N/768RKJ7JKjZUsCJuc+5AjXcODXautCzDAoPMGRqOnsMajeK
        L3cP+XkcOkgX64CcH/0tL3FtotaHAfPFPrY3lcM0Hw==
X-Google-Smtp-Source: ABdhPJzp9E5Qi2v2sAJ4CxWJfE3qgLrahviQyPIpuWgeVHninRfK5JaGbKGAfTEWoiBe5Xvr+MI9TlsZNh4jU8tk3h4=
X-Received: by 2002:a05:6a00:228f:b0:4fa:e4c9:7b3b with SMTP id
 f15-20020a056a00228f00b004fae4c97b3bmr17744889pfe.61.1649400701144; Thu, 07
 Apr 2022 23:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <159009507306.847224.8502634072429766747.stgit@dwillia2-desk3.amr.corp.intel.com>
 <202005211950.D56130B81@keescook> <202204061243.FB134CA4B1@keescook>
 <CAPcyv4htK6Ur4-B=cfkQeOD__9s7ZfxMTo+uCCPVDLG=_WNy7A@mail.gmail.com>
 <CAPcyv4hFxVAKgUqt-mua5_1NZkfyKKFL-3F0tSWuSmD=4Z1sBw@mail.gmail.com> <202204072030.43D5BFDB@keescook>
In-Reply-To: <202204072030.43D5BFDB@keescook>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 7 Apr 2022 23:51:30 -0700
Message-ID: <CAPcyv4iVt=peUAk1qx_EfKn7aGJM=XwRUpJftBhkUgQEti2bJA@mail.gmail.com>
Subject: Re: [PATCH v4] /dev/mem: Revoke mappings when a driver claims the region
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 8:35 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Apr 07, 2022 at 04:43:10PM -0700, Dan Williams wrote:
> > On Thu, Apr 7, 2022 at 11:47 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Wed, Apr 6, 2022 at 12:46 PM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > *thread necromancy*
> > >
> > > It's alive!
> > >
> > > >
> > > > Hi Dan,
> > > >
> > > > I'm doing a KSPP bug scrub and am reviewing
> > > > https://github.com/KSPP/linux/issues/74 again.
> > > >
> > > > Do you have a chance to look at this? I'd love a way to make mmap()
> > > > behave the same way as read() for the first meg of /dev/mem.
> > >
> > > You want 0-reads or SIGBUS when attempting to access the first 1MB?
> > >
> > > Because it sounds like what you want is instead of loudly failing with
> > > -EPERM in drivers/char/mem.c::mmap_mem() you want it to silently
> > > succeed but swap in the zero page, right? Otherwise if it's SIGBUS
> > > then IO_STRICT_DEVMEM=y + marking that span as IORESOURCE_BUSY will
> > > "Do the Right Thing (TM).".
> >
> > In other words, if IO_STRICT_DEVMEM is enabled then the enforcement is
> > already there at least for anything marked IORESOURCE_BUSY. So if
> > tools are ok with that protection today, maybe there is no need to do
> > the zero page dance. I.e. legacy tools the read(2) /dev/mem below 1MB
> > get zeroes, and apparently no tools were mmap'ing below 1MB otherwise
> > they would have complained by now? At least Fedora is shipping
> > IO_STRICT_DEVMEM these days:
> >
> > https://src.fedoraproject.org/rpms/kernel/blob/rawhide/f/kernel-x86_64-fedora.config#_2799
>
> When I try to mmap a RAM area <1MiB, mmap succeeds (range_is_allowed()
> is non-zero), so I don't think IO_STRICT_DEVMEM would trip anything
> using mmap on /dev/mem there.
>
> I am only reading 0s from there, though, but I don't see what's all
> happening. I thought maybe it was just literally unused, but even with
> CONFIG_PAGE_POISONING=y booted with page_poison=1, I still read 0s (not
> 0xaa), but I'd like to understand _why_ (i.e. I can't tell if it is
> accidentally safe, intentionally safe, or my test is bad.)
>
> For example:
>
> # cat /proc/iomem
> 00000000-00000fff : Reserved
> 00001000-0009fbff : System RAM
> 0009fc00-0009ffff : Reserved
> 000a0000-000bffff : PCI Bus 0000:00
> 000c0000-000c99ff : Video ROM
> ...
>
> If I mmap page 0, it's rejected (non-RAM). If I mmap page 1, it works,
> but it's all 0s. (Which is what I'd like, but I don't see where this is
> happening.)

I'm worried it's all zero's by luck and that the logic in
devmem_is_allowed() to return 2 is actually allowing the mmap() case
to successfully bypass STRICT_DEVMEM where read(2) would have had the
buffer cleared by the kernel.

mmap_mem() would need to walk the range and map the zero_page pfn for
all of the intersections with system-ram, but if the mapping is
writable it would need to allocate memory to prevent the zero page
from being written. If you can write to it and still see your data on
the next attempt then STRICT_DEVMEM is being bypassed.
