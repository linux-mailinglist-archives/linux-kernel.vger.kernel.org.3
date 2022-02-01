Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB12F4A5D8B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 14:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238813AbiBANkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 08:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbiBANke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:40:34 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFFDC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 05:40:34 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id g2so15311643pgo.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 05:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vx2vjMlyUXttsNTU/sc6P+/T6SMZYpnVRGM83+IEnII=;
        b=kirnkQeZkeipuwVGTmeRoiNmR+fw3OankYxS5AXzlx+jExadifRtb4y62bwOq4LB6V
         y8PiPkDAgmRFKIghZO0BwJeNgOTyssyULiwdMM3fiGw0Blsg68mfTtu7nnjjO1j5FDAT
         OSjaIUFD5rSOreQr5pD9PmRhz7DkhxEo8eyjBr/iRKwmPmgMhBv1Jk9ueJ3RztTmdYua
         ikw5I+VujZ9FGwJUpvolpOvvYB2GUarBH7o4ezJ6r6v8Wd1PHsQdhZxil5Gkk0e9qBGr
         3IqT+xh2/Cel2T+ucEmfGFbuC8DJ5IgG1T6UXE8ABGOyrQAd3PjjWhf5/VDU0LCM1wa+
         SFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vx2vjMlyUXttsNTU/sc6P+/T6SMZYpnVRGM83+IEnII=;
        b=YHAp5QhLfmISR/rtmA0VzCPXojuMHeQ8frlwbjY4VNjFfytcKwQBHM+zhmV6WQmacv
         8wK3GUZtV9I1TdnCrDhR4X4ZI7/QJ+2k1+0UIK7SxulbDTXFkgycjVFV3iCr1tbJSB4q
         5Xt4sZhVMj68NY2vw9ZKfoR/BdWq8kVznOHFrX7Se6h4Zb0fcw/FOVpTE3oStywk0kIW
         dVkZIUtryHwkoZ5ak8BCtfmoIy/dwWJyBV5MYKUXQnwn38liACHER9jd5Fy8xgWbzAwY
         /oI0LEf0jdppaocyi5GAP5CsKJinr46KzydTVW8/ds7Eyy7k3IOtIEzTG60KdkmTj6tC
         gKFg==
X-Gm-Message-State: AOAM5333d0NWUUM14CvpJL09dSjr2adWdr5jKPv0ohs68+cSJOzSfLaS
        DTF3WyLOTU5hrVYQn15SfWlDP/1sEEdBK2B2cIg=
X-Google-Smtp-Source: ABdhPJwq0sW0/6OaoNprXkKm7m4z7yfd02IU4Q/RV4jwOkWH0olc7S1kF/p1VLGHiwUeoVvMxUydMvbIwL8BNAC1VQU=
X-Received: by 2002:a63:3e8b:: with SMTP id l133mr20407349pga.210.1643722833675;
 Tue, 01 Feb 2022 05:40:33 -0800 (PST)
MIME-Version: 1.0
References: <20220131201716.5198-1-a3at.mail@gmail.com> <CAMe9rOqoPy6jsWrodnc41M4+b2onwkfbfr=pZ9qRWzOU2Uisgg@mail.gmail.com>
 <20220201061832.yatgwglxvi7ho4yr@carbon.azat> <CAMe9rOptn2vpY90yY3HuGmmMdj4Hpaba2PRhp4d033XBDgL_5w@mail.gmail.com>
 <20220201132807.m7xtogotjlg54pzl@carbon.azat>
In-Reply-To: <20220201132807.m7xtogotjlg54pzl@carbon.azat>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Tue, 1 Feb 2022 05:39:57 -0800
Message-ID: <CAMe9rOpkHm7juB6f_z+osG28dGxe=4SSVN+8SHsxatVnwGQ5xA@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf: use ELF_ET_DYN_BASE for PIE (ET_DYN with
 INTERP) binaries
To:     Azat Khuzhin <a3at.mail@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chris Kennelly <ckennelly@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 5:28 AM Azat Khuzhin <a3at.mail@gmail.com> wrote:
>
> On Tue, Feb 01, 2022 at 05:15:38AM -0800, H.J. Lu wrote:
> > On Mon, Jan 31, 2022 at 10:18 PM Azat Khuzhin <a3at.mail@gmail.com> wrote:
> > >
> > > On Mon, Jan 31, 2022 at 01:30:38PM -0800, H.J. Lu wrote:
> > > > On Mon, Jan 31, 2022 at 12:17 PM Azat Khuzhin <a3at.mail@gmail.com> wrote:
> > > > >
> > > > > Since 9630f0d60fec ELF_ET_DYN_BASE is not used as a load_bias anymore
> > > > > and this breaks PIE binaries, since after this change data segment
> > > > > became too nearby the stack:
> > > > >
> > > > > Before 9630f0d60fec:
> > > > >
> > > > >     $ strace -febrk /tmp/test-stack |& head
> > > > >     brk(NULL)                               = 0x555555559000
> > > > >     $ /tmp/test-stack
> > > > >     bottom_of_stack = 0x7fffffffc5c0
> > > > >     recursion depth: 1 (stack diff: 32)
> > > > >     ...
> > > > >     recursion depth: 7690 (stack diff: 8365664)
> > > > >     Segmentation fault (core dumped)
> > > > >
> > > > > After 9630f0d60fec:
> > > > >
> > > > >     $ strace -ebrk /tmp/test-stack  |& head
> > > > >     brk(NULL)                               = 0x7ffff7fff000
> > > > >
> > > > >     $ /tmp/test-stack
> > > > >     bottom_of_stack = 0x7fffffffc640
> > > > >     recursion depth: 1 (stack diff: 32)
> > > > >     ...
> > > > >     recursion depth: 146 (stack diff: 157792)
> > > > >     Segmentation fault (core dumped)
> > > > >
> > > > > Found this during compiling with clang, that started to randomly
> > > > > SIGSEGV when it eats some heap.
> > > >
> > > > How do I reproduce it on x86-64?
> > >
> > > It fails for me for pretty big C++ unit, so I don't have a simple
> > > reproducer with clang, but the attached reproducer below should show the
> > > problem.
> >
> > The reproducer doesn't fail for me under 5.17-rc2 on Fedora 35/x86-64
> > with 32GB RAM.  Did you turn off PF_RANDOMIZE?
>
> Oh, yep, forgot to mention that I have kernel.randomize_va_space=0.

PIE with interpreter and PIE with alignment > ELF_MIN_ALIGN
should always be loaded from ELF_ET_DYN_BASE.  Otherwise,
either PIE is loaded at an address which is too low or isn't properly
aligned.

-- 
H.J.
