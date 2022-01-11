Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1835148A9B7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbiAKIla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbiAKIl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:41:28 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A85C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 00:41:28 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id h30so3933591ila.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 00:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xX7Gq7dSe8DMwSIkCUtWe06zZqgHCLqeOiZuhAMOfEc=;
        b=PHzOcbVcszy2bKR29hJ+Af1iQ0dNN/t0YShcO6hJHZqdhd2UVBlgUg2b+8MITZ0nuG
         1OxEufbZHzGu0bbxMQxlgVPTBBSeotQWg+dWvMbDFGWzmWl/XODpOVfpIkLNk6Ocatua
         v4R7bGxy9QZnfB3VbYTb040eG0A93C3zJH2QjNj8QEvFNauLZT6mw2ulcyt9ON4c+0iW
         NYC4erM7bGdYS2696R2a6XuuFweQE9xWGkc/ef6DSImQqUt0UlqBevsEp9sTfEhd1EuU
         xql5vguuIdFZDn+Pn3UpVsu3iFkmmMPStJUnfpvDtEQzgBbO34+jAXj6i44zOMCy8uyS
         jIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xX7Gq7dSe8DMwSIkCUtWe06zZqgHCLqeOiZuhAMOfEc=;
        b=cZ7PJav8nABlF60LXRK4lefC4WQoAvnwCfGLfjpQsjJg8QOHy7EmQNQWnPzzfRPxuf
         C9rNMohcLzpd17ZPC451eIXREpkzqmMQp0EYEw1yzTzhLejFCzDIMwlP+W8zBPsRP5vu
         eYYBYRWuQiyKwYR/2Y7nuwgC9q0cRtjbDkYk4DyjJJYA/fNAbiJmjTBE1mU28+sx2emB
         tx+X4xW5avhvblrXV9dJFdn1KZtmnVdtEYtIWX8bCFPnu1e4sNDwG86BMJ4E8UVwp4YM
         CMuIpmExRz6JTJBtL9tiJCOxvHqadRTWzoj5Iqkep8tJdjS+d83AoaLBfyS58HeMFd8A
         GEhg==
X-Gm-Message-State: AOAM532mzoruyCyRaJn6QFq0A2OgVPwrZfTF4l/Zf93HXCO8T9huADGg
        VITN83F6IGjlvMgj+/ZBe386vQ==
X-Google-Smtp-Source: ABdhPJziZssrNELt1lJT+4x3MZrqM40ggyrOhKXbbZYK9sI5IPQui65L4eTgmTI9kYJPjSbNbJMG4w==
X-Received: by 2002:a92:d2cc:: with SMTP id w12mr1927157ilg.303.1641890487437;
        Tue, 11 Jan 2022 00:41:27 -0800 (PST)
Received: from google.com ([2620:15c:183:200:bdd9:6181:19a:9d62])
        by smtp.gmail.com with ESMTPSA id p16sm5977777iov.3.2022.01.11.00.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 00:41:26 -0800 (PST)
Date:   Tue, 11 Jan 2022 01:41:22 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Alexandre Frade <kernel@xanmod.org>,
        Brian Geffon <bgeffon@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
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
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
Message-ID: <Yd1Css8+jsspeZHh@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <YdSuSHa/Vjl6bPkg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdSuSHa/Vjl6bPkg@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 01:30:00PM -0700, Yu Zhao wrote:
> On Tue, Jan 04, 2022 at 01:22:19PM -0700, Yu Zhao wrote:
> > TLDR
> > ====
> > The current page reclaim is too expensive in terms of CPU usage and it
> > often makes poor choices about what to evict. This patchset offers an
> > alternative solution that is performant, versatile and
> > straightforward.
> 
> <snipped>
> 
> > Summery
> > =======
> > The facts are:
> > 1. The independent lab results and the real-world applications
> >    indicate substantial improvements; there are no known regressions.
> > 2. Thrashing prevention, working set estimation and proactive reclaim
> >    work out of the box; there are no equivalent solutions.
> > 3. There is a lot of new code; nobody has demonstrated smaller changes
> >    with similar effects.
> > 
> > Our options, accordingly, are:
> > 1. Given the amount of evidence, the reported improvements will likely
> >    materialize for a wide range of workloads.
> > 2. Gauging the interest from the past discussions [14][15][16], the
> >    new features will likely be put to use for both personal computers
> >    and data centers.
> > 3. Based on Google's track record, the new code will likely be well
> >    maintained in the long term. It'd be more difficult if not
> >    impossible to achieve similar effects on top of the existing
> >    design.
> 
> Hi Andrew, Linus,
> 
> Can you please take a look at this patchset and let me know if it's
> 5.17 material?
> 
> My goal is to get it merged asap so that users can reap the benefits
> and I can push the sequels. Please examine the data provided -- I
> think the unprecedented coverage and the magnitude of the improvements
> warrant a green light.

Downstream kernel maintainers who have been carrying MGLRU for more than
3 versions, can you please provide your Acked-by tags?

Having this patchset in the mainline will make your job easier :)

   Alexandre - the XanMod Kernel maintainer
               https://xanmod.org
   
   Brian     - the Chrome OS kernel memory maintainer
               https://www.chromium.org
   
   Jan       - the Arch Linux Zen kernel maintainer
               https://archlinux.org
   
   Steven    - the Liquorix kernel maintainer
               https://liquorix.net
   
   Suleiman  - the ARCVM (Android downstream) kernel memory maintainer
               https://chromium.googlesource.com/chromiumos/third_party/kernel

Also my gratitude to those who have helped test MGLRU:

   Daniel - researcher at Michigan Tech
            benchmarked memcached
   
   Holger - who has been testing/patching/contributing to various
            subsystems since ~2008
   
   Shuang - researcher at University of Rochester
            benchmarked fio and provided a report
   
   Sofia  - EDI https://www.edi.works
            benchmarked the top eight memory hogs and provided reports

Can you please provide your Tested-by tags? This will ensure the credit
for your contributions.

Thanks!
