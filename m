Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8296748BE7F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 07:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350953AbiALGHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 01:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348112AbiALGHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 01:07:32 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922A0C061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 22:07:31 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id k15so5386261edk.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 22:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edi.works; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Uim4PQO9GRX6Ml1nDaTb+DvyJmBeJ+eZYwrgMJj3yI=;
        b=1LNNzA/ve9YQhIzt6mswt+L1KOC7ztP+uZRonN3zpQtMe8zsMGUM76zV3r09+Y4RDv
         TCs/ixX6b8fHXxQWGqNp1NkolJFZ1dW/YUwuOpBQBnEgl+Mq/UP31vw5LgqtwuygtItT
         jItgFp2TVagFEfu1tEUBVZMjK2qXEsOyob2zweFygDPXCEnB14Vd3M+QvPy4A2jvHfW0
         mghcntQKfhuX8jClj88njP798Shb9uY70Zrz9uZoS9XhStHeqw5E5Vl4+zlbmPiCZuYD
         05yGJ+4GOPENbEW3Ma6B4PMLMH0BUoJkXGvqtejqQGkq6/FBQftP3qz+axHBcUCvenL3
         uw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Uim4PQO9GRX6Ml1nDaTb+DvyJmBeJ+eZYwrgMJj3yI=;
        b=joKetaVyGDVHFntOpRNQWapFM7VKCRbweJg5O5x6mO00ioU7bsAWuOgkx8vBKX/lmt
         iZwXzXopfxs88QcSVvZGN5eJcbY/6Oqj2bxYQOcLe6rnRiC6tlfXyIVMTBcLrWfJDkin
         pKn6614A53cFN18fVjnknaQxeGOjFyr0f/VhINwwleaLjhv9X4cc+ec4cXrSiTBfzZeb
         c16h0DmIEFLQAWyox+CHHxOe/jDIB4eQdrfjVXIbXi51iaJPvjEgBsy+ei1I7rJhR0Uv
         37jhhgLI9V3azOxa53HmjM1wmqc5T0rXIGATSfki3TElBlXSoQx45WW+ai46GBO+S1qx
         1B9A==
X-Gm-Message-State: AOAM530MN0vCUkvhl4ljoWaUNJM5XlBg8/MyX70XCPjGEQrf/0v7XiWd
        AGw8owrUwoWeg2fgldAIotBjqgMVOD9uDHa9mIVZ2Q==
X-Google-Smtp-Source: ABdhPJw5cTsO1kWiUiVqpgI3OeCcBg5JTs4BMkeLBxLQDWWc+i6xh5tf47WN9LuD12xfZNO/D9j9J7A3wl/25P/c31s=
X-Received: by 2002:aa7:c7cf:: with SMTP id o15mr7598673eds.176.1641967650078;
 Tue, 11 Jan 2022 22:07:30 -0800 (PST)
MIME-Version: 1.0
References: <20220104202227.2903605-1-yuzhao@google.com> <YdSuSHa/Vjl6bPkg@google.com>
 <Yd1Css8+jsspeZHh@google.com>
In-Reply-To: <Yd1Css8+jsspeZHh@google.com>
From:   Sofia Trinh <sofia.trinh@edi.works>
Date:   Tue, 11 Jan 2022 22:07:19 -0800
Message-ID: <CAMwLHrZi0ZGFsuc74Yj3DErT1zyG2DEudS3ZgPEsexj0XfZJyA@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
To:     Yu Zhao <yuzhao@google.com>
Cc:     Alexandre Frade <kernel@xanmod.org>,
        Brian Geffon <bgeffon@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 12:41 AM Yu Zhao <yuzhao@google.com> wrote:
>
> On Tue, Jan 04, 2022 at 01:30:00PM -0700, Yu Zhao wrote:
> > On Tue, Jan 04, 2022 at 01:22:19PM -0700, Yu Zhao wrote:
> > > TLDR
> > > ====
> > > The current page reclaim is too expensive in terms of CPU usage and it
> > > often makes poor choices about what to evict. This patchset offers an
> > > alternative solution that is performant, versatile and
> > > straightforward.
> >
> > <snipped>
> >
> > > Summery
> > > =======
> > > The facts are:
> > > 1. The independent lab results and the real-world applications
> > >    indicate substantial improvements; there are no known regressions.
> > > 2. Thrashing prevention, working set estimation and proactive reclaim
> > >    work out of the box; there are no equivalent solutions.
> > > 3. There is a lot of new code; nobody has demonstrated smaller changes
> > >    with similar effects.
> > >
> > > Our options, accordingly, are:
> > > 1. Given the amount of evidence, the reported improvements will likely
> > >    materialize for a wide range of workloads.
> > > 2. Gauging the interest from the past discussions [14][15][16], the
> > >    new features will likely be put to use for both personal computers
> > >    and data centers.
> > > 3. Based on Google's track record, the new code will likely be well
> > >    maintained in the long term. It'd be more difficult if not
> > >    impossible to achieve similar effects on top of the existing
> > >    design.
> >
> > Hi Andrew, Linus,
> >
> > Can you please take a look at this patchset and let me know if it's
> > 5.17 material?
> >
> > My goal is to get it merged asap so that users can reap the benefits
> > and I can push the sequels. Please examine the data provided -- I
> > think the unprecedented coverage and the magnitude of the improvements
> > warrant a green light.
>
> Downstream kernel maintainers who have been carrying MGLRU for more than
> 3 versions, can you please provide your Acked-by tags?
>
> Having this patchset in the mainline will make your job easier :)
>
>    Alexandre - the XanMod Kernel maintainer
>                https://xanmod.org
>
>    Brian     - the Chrome OS kernel memory maintainer
>                https://www.chromium.org
>
>    Jan       - the Arch Linux Zen kernel maintainer
>                https://archlinux.org
>
>    Steven    - the Liquorix kernel maintainer
>                https://liquorix.net
>
>    Suleiman  - the ARCVM (Android downstream) kernel memory maintainer
>                https://chromium.googlesource.com/chromiumos/third_party/kernel
>
> Also my gratitude to those who have helped test MGLRU:
>
>    Daniel - researcher at Michigan Tech
>             benchmarked memcached
>
>    Holger - who has been testing/patching/contributing to various
>             subsystems since ~2008
>
>    Shuang - researcher at University of Rochester
>             benchmarked fio and provided a report
>
>    Sofia  - EDI https://www.edi.works
>             benchmarked the top eight memory hogs and provided reports

Tested-by: Sofia Trinh <sofia.trinh@edi.works>
