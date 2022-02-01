Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135F74A5D6A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 14:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbiBAN2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 08:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237996AbiBAN2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:28:13 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802BAC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 05:28:13 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id e9so24150654ljq.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 05:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wy+jKI0ot+SWb8kO9biUJ6kV3sow7KY6Pggtc/YtNIE=;
        b=KEbERv05nwtglax7mpJ0JKWCn/qyFmnE17ipkIYkJo9/3pcNtrulivMua72RZB05/d
         EgRBrfT/t0xJJRXHA93negnCqWLze0Twe4SOdk6E7NlaO+Eipqb7qbMMcJb7EXQqeCjW
         Hco80kQNtRSgTJYbwZn3VBIYNkclyNqWhVWJJ+RwyIzR6Ld/Xit8lKkD1fkHiQqc8w8K
         a4LIzMHLRK8k49UuqXman8KyCQvXD7ge1/MrUpk3qHUXFW89y494KPx2qOk/JlUc/r6J
         dbJujgOMKAiSEA+eDYfIZwHNuqoFz7leKuN0DHuxY3/3ay7zI20blglmpoFbDJaWX4k+
         KO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wy+jKI0ot+SWb8kO9biUJ6kV3sow7KY6Pggtc/YtNIE=;
        b=76OcOMubT7Yz0jniFuh6TRq0G1G69tLPwUkrkbFjHtnmSuF9GYZOyg2PcOy9vioEvX
         PW53413o+QQ53lJz/c0d7MdpfMazZX01aNHZGjLj9E1MB0KRLOTFo82XoUrqg+Ujx4ri
         52uI3FGn9jlHTuFTF56khchBuNkb0queSz8OcPNCHNOu47vci/URXn5JkB03aojWQJEx
         2OLx/WDDlrK0jTHLt2TMwj8qQbgFyOEU6DZNjzpXa3OefQcinoReRkoWoMr/OgDl2yRO
         wCk4NhKl5d9Tdl8swnEOVnt38lRa5vbjoQXbYOC0Tz1K9GPa8EgrcZytOB0E7lc3UHbM
         9AfA==
X-Gm-Message-State: AOAM53133ezyIYez3MEVut+R2vkMy7ShiMiqUKN86YhA73Q6H5BCDeRA
        grBAbRh0nXqgPbD0MTJ7ZQo=
X-Google-Smtp-Source: ABdhPJzI0YSB3hUbBpZOPJUsNmtn2/VNCYO+ywQMITApODNdWFOCJFIFD0hNbMeiY5ZcILjbYRc0Jw==
X-Received: by 2002:a05:651c:897:: with SMTP id d23mr16778052ljq.522.1643722091179;
        Tue, 01 Feb 2022 05:28:11 -0800 (PST)
Received: from localhost ([146.66.199.134])
        by smtp.gmail.com with ESMTPSA id g26sm4075210lfj.176.2022.02.01.05.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 05:28:10 -0800 (PST)
Date:   Tue, 1 Feb 2022 16:28:07 +0300
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
Message-ID: <20220201132807.m7xtogotjlg54pzl@carbon.azat>
References: <20220131201716.5198-1-a3at.mail@gmail.com>
 <CAMe9rOqoPy6jsWrodnc41M4+b2onwkfbfr=pZ9qRWzOU2Uisgg@mail.gmail.com>
 <20220201061832.yatgwglxvi7ho4yr@carbon.azat>
 <CAMe9rOptn2vpY90yY3HuGmmMdj4Hpaba2PRhp4d033XBDgL_5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMe9rOptn2vpY90yY3HuGmmMdj4Hpaba2PRhp4d033XBDgL_5w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 05:15:38AM -0800, H.J. Lu wrote:
> On Mon, Jan 31, 2022 at 10:18 PM Azat Khuzhin <a3at.mail@gmail.com> wrote:
> >
> > On Mon, Jan 31, 2022 at 01:30:38PM -0800, H.J. Lu wrote:
> > > On Mon, Jan 31, 2022 at 12:17 PM Azat Khuzhin <a3at.mail@gmail.com> wrote:
> > > >
> > > > Since 9630f0d60fec ELF_ET_DYN_BASE is not used as a load_bias anymore
> > > > and this breaks PIE binaries, since after this change data segment
> > > > became too nearby the stack:
> > > >
> > > > Before 9630f0d60fec:
> > > >
> > > >     $ strace -febrk /tmp/test-stack |& head
> > > >     brk(NULL)                               = 0x555555559000
> > > >     $ /tmp/test-stack
> > > >     bottom_of_stack = 0x7fffffffc5c0
> > > >     recursion depth: 1 (stack diff: 32)
> > > >     ...
> > > >     recursion depth: 7690 (stack diff: 8365664)
> > > >     Segmentation fault (core dumped)
> > > >
> > > > After 9630f0d60fec:
> > > >
> > > >     $ strace -ebrk /tmp/test-stack  |& head
> > > >     brk(NULL)                               = 0x7ffff7fff000
> > > >
> > > >     $ /tmp/test-stack
> > > >     bottom_of_stack = 0x7fffffffc640
> > > >     recursion depth: 1 (stack diff: 32)
> > > >     ...
> > > >     recursion depth: 146 (stack diff: 157792)
> > > >     Segmentation fault (core dumped)
> > > >
> > > > Found this during compiling with clang, that started to randomly
> > > > SIGSEGV when it eats some heap.
> > >
> > > How do I reproduce it on x86-64?
> >
> > It fails for me for pretty big C++ unit, so I don't have a simple
> > reproducer with clang, but the attached reproducer below should show the
> > problem.
> 
> The reproducer doesn't fail for me under 5.17-rc2 on Fedora 35/x86-64
> with 32GB RAM.  Did you turn off PF_RANDOMIZE?

Oh, yep, forgot to mention that I have kernel.randomize_va_space=0.
