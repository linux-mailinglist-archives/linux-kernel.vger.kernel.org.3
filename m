Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6334A5726
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 07:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiBAGSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 01:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiBAGSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 01:18:35 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E7CC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 22:18:35 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id z4so31675212lft.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 22:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3hEUlQM4dFF1likJfgdhXv9CdGZyb6v9vnQiScxWZYk=;
        b=O4r1+Q879TfID7W4pIrexC8RQMXkBxxu+F/YAH8K9FEd3od9Bzv9tqiX8tgZ/NfcoC
         7uW0L6V6cvdDuSsTkSkfJdN48CS5hpwPx9qu/Pei5/DXraHRrWpXABRF94DUS4P78CHk
         yKK0zn9USS9Lz2MJ5IpKyFwUWeajiClL3aO6zWtuO8aKJ1X1XCNVzBUvYaTWO+1uoqm4
         bsStkB8MyDFU/t3BRiwHKwMD5s994q9O6mYuO0u4QwURHgz5C95v8eW05U35Rq6oY/dp
         6dP08uzq1ZsVWGkPkhn5DpHP41ZYV4iZ/d6Ee0ydOXslOLk8q2E9SuH5mJ5ZXuQBATej
         CTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3hEUlQM4dFF1likJfgdhXv9CdGZyb6v9vnQiScxWZYk=;
        b=2ZEE6OBZYLmt93LG37icW4tPlYF4Ob8FzgPXbFZleXlc6t+YXP9oR4VwngussjbV6P
         T4vJBB+gNuja6CqNqMh76vAmmu2809PPjDcybK2/jY+XfPQpOhdK5wz6ggev8IluJP4E
         6cMZj7v0sA0qFup7rxctpeGqHWwvS8JiTtKMkV1nygVNSQwDIYPDcOzf9Ez4v/lHUnwP
         RdRfBetsGnD4mCPe5goGo9w0J58ZsJT/lAwiZpmW3OnRgXiYuKxqIb85E3BVVIEhPi1z
         jzeyw/x6Cc75kh6eEImWnk/HVM1nY03XFWALI3fEb/uCHYLDwTUn3kHIEpl4wtIVy+lX
         zLqA==
X-Gm-Message-State: AOAM530fX6hrOavTRZZj8HzeYcZGGFmgnvSnCjhyZSUXER3pWOw6THWh
        wSer3ONs2LEoOFUmolqfKmiyE5xckWp1Yw==
X-Google-Smtp-Source: ABdhPJy4cvPuaA49UPaY0FS++P0BTprKhbVEwMfU32bszgFhgOJem/kTjzhvtFuPCoya41vVl61YZw==
X-Received: by 2002:a05:6512:4014:: with SMTP id br20mr13309465lfb.217.1643696313584;
        Mon, 31 Jan 2022 22:18:33 -0800 (PST)
Received: from localhost ([146.66.199.134])
        by smtp.gmail.com with ESMTPSA id bj13sm892449ljb.140.2022.01.31.22.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 22:18:33 -0800 (PST)
Date:   Tue, 1 Feb 2022 09:18:32 +0300
From:   Azat Khuzhin <a3at.mail@gmail.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>
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
Subject: Re: [PATCH] fs/binfmt_elf: use ELF_ET_DYN_BASE for PIE (ET_DYN with
 INTERP) binaries
Message-ID: <20220201061832.yatgwglxvi7ho4yr@carbon.azat>
References: <20220131201716.5198-1-a3at.mail@gmail.com>
 <CAMe9rOqoPy6jsWrodnc41M4+b2onwkfbfr=pZ9qRWzOU2Uisgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMe9rOqoPy6jsWrodnc41M4+b2onwkfbfr=pZ9qRWzOU2Uisgg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 01:30:38PM -0800, H.J. Lu wrote:
> On Mon, Jan 31, 2022 at 12:17 PM Azat Khuzhin <a3at.mail@gmail.com> wrote:
> >
> > Since 9630f0d60fec ELF_ET_DYN_BASE is not used as a load_bias anymore
> > and this breaks PIE binaries, since after this change data segment
> > became too nearby the stack:
> >
> > Before 9630f0d60fec:
> >
> >     $ strace -febrk /tmp/test-stack |& head
> >     brk(NULL)                               = 0x555555559000
> >     $ /tmp/test-stack
> >     bottom_of_stack = 0x7fffffffc5c0
> >     recursion depth: 1 (stack diff: 32)
> >     ...
> >     recursion depth: 7690 (stack diff: 8365664)
> >     Segmentation fault (core dumped)
> >
> > After 9630f0d60fec:
> >
> >     $ strace -ebrk /tmp/test-stack  |& head
> >     brk(NULL)                               = 0x7ffff7fff000
> >
> >     $ /tmp/test-stack
> >     bottom_of_stack = 0x7fffffffc640
> >     recursion depth: 1 (stack diff: 32)
> >     ...
> >     recursion depth: 146 (stack diff: 157792)
> >     Segmentation fault (core dumped)
> >
> > Found this during compiling with clang, that started to randomly
> > SIGSEGV when it eats some heap.
> 
> How do I reproduce it on x86-64?

It fails for me for pretty big C++ unit, so I don't have a simple
reproducer with clang, but the attached reproducer below should show the
problem.

> > Reproducer:
> >
> >     #include <stdio.h>
> >     #include <stddef.h>
> >     #include <stdlib.h>
> >
> >     static int depth = 0;
> >     static void* bottom_of_stack;
> >
> >     int inner()
> >     {
> >         char buffer[1024];
> >         ptrdiff_t diff;
> >         int ret;
> >
> >         ++depth;
> >         diff = bottom_of_stack - __builtin_frame_address(0);
> >
> >         fprintf(stderr,
> >                 "recursion depth: %i (stack diff: %zu)\n",
> >                 depth, (size_t)diff);
> >
> >         for (size_t i = 0; i < 1024; ++i)
> >                 ret += buffer[i];
> >
> >         ret += inner();
> >
> >         return ret;
> >     }
> >
> >     int main()
> >     {
> >         for (size_t size = 0; size < 128<<20; size += 16<<10)
> >                 malloc(16<<10);
> >
> >         bottom_of_stack = __builtin_frame_address(0);
> >         fprintf(stderr, "bottom_of_stack = %p\n", bottom_of_stack);
> >         inner();
> >     }
