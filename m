Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E87448B196
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349797AbiAKQHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:07:01 -0500
Received: from slate.cs.rochester.edu ([128.151.167.14]:60622 "EHLO
        slate.cs.rochester.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240042AbiAKQHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:07:00 -0500
Received: from node1x10a.cs.rochester.edu (node1x10a.cs.rochester.edu [192.5.53.74])
        by slate.cs.rochester.edu (8.14.7/8.14.7) with ESMTP id 20BG55iO020545
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Jan 2022 11:05:05 -0500
Received: from node1x10a.cs.rochester.edu (localhost [127.0.0.1])
        by node1x10a.cs.rochester.edu (8.15.2/8.15.1) with ESMTP id 20BG55J9002813;
        Tue, 11 Jan 2022 11:05:05 -0500
Received: (from szhai2@localhost)
        by node1x10a.cs.rochester.edu (8.15.2/8.15.1/Submit) id 20BG4vuZ002812;
        Tue, 11 Jan 2022 11:04:57 -0500
From:   Shuang Zhai <szhai2@cs.rochester.edu>
To:     yuzhao@google.com
Cc:     Michael@michaellarabel.com, ak@linux.intel.com,
        akpm@linux-foundation.org, axboe@kernel.dk, bgeffon@google.com,
        catalin.marinas@arm.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, djbyrne@mtu.edu, hannes@cmpxchg.org,
        hdanton@sina.com, heftig@archlinux.org,
        holger@applied-asynchrony.com, jsbarnes@google.com,
        kernel@xanmod.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@suse.de, mhocko@kernel.org,
        page-reclaim@google.com, riel@surriel.com, sofia.trinh@edi.works,
        steven@liquorix.net, suleiman@google.com, szhai2@cs.rochester.edu,
        torvalds@linux-foundation.org, vbabka@suse.cz, will@kernel.org,
        willy@infradead.org, x86@kernel.org, ying.huang@intel.com
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
Date:   Tue, 11 Jan 2022 11:04:55 -0500
Message-Id: <20220111160455.2773-1-szhai2@cs.rochester.edu>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <Yd1Css8+jsspeZHh@google.com>
References: <Yd1Css8+jsspeZHh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao wrote:
> On Tue, Jan 04, 2022 at 01:30:00PM -0700, Yu Zhao wrote:
>> On Tue, Jan 04, 2022 at 01:22:19PM -0700, Yu Zhao wrote:
>>> TLDR
>>> ====
>>> The current page reclaim is too expensive in terms of CPU usage and it
>>> often makes poor choices about what to evict. This patchset offers an
>>> alternative solution that is performant, versatile and
>>> straightforward.
>>
>> <snipped>
>>
>>> Summery
>>> =======
>>> The facts are:
>>> 1. The independent lab results and the real-world applications
>>>     indicate substantial improvements; there are no known regressions.
>>> 2. Thrashing prevention, working set estimation and proactive reclaim
>>>     work out of the box; there are no equivalent solutions.
>>> 3. There is a lot of new code; nobody has demonstrated smaller changes
>>>     with similar effects.
>>>
>>> Our options, accordingly, are:
>>> 1. Given the amount of evidence, the reported improvements will likely
>>>     materialize for a wide range of workloads.
>>> 2. Gauging the interest from the past discussions [14][15][16], the
>>>     new features will likely be put to use for both personal computers
>>>     and data centers.
>>> 3. Based on Google's track record, the new code will likely be well
>>>     maintained in the long term. It'd be more difficult if not
>>>     impossible to achieve similar effects on top of the existing
>>>     design.
>>
>> Hi Andrew, Linus,
>>
>> Can you please take a look at this patchset and let me know if it's
>> 5.17 material?
>>
>> My goal is to get it merged asap so that users can reap the benefits
>> and I can push the sequels. Please examine the data provided -- I
>> think the unprecedented coverage and the magnitude of the improvements
>> warrant a green light.
> 
> Downstream kernel maintainers who have been carrying MGLRU for more than
> 3 versions, can you please provide your Acked-by tags?
> 
> Having this patchset in the mainline will make your job easier :)
> 
>     Alexandre - the XanMod Kernel maintainer
>                 https://xanmod.org
>     
>     Brian     - the Chrome OS kernel memory maintainer
>                 https://www.chromium.org
>     
>     Jan       - the Arch Linux Zen kernel maintainer
>                 https://archlinux.org
>     
>     Steven    - the Liquorix kernel maintainer
>                 https://liquorix.net
>     
>     Suleiman  - the ARCVM (Android downstream) kernel memory maintainer
>                 https://chromium.googlesource.com/chromiumos/third_party/kernel
> 
> Also my gratitude to those who have helped test MGLRU:
> 
>     Daniel - researcher at Michigan Tech
>              benchmarked memcached
>     
>     Holger - who has been testing/patching/contributing to various
>              subsystems since ~2008
>     
>     Shuang - researcher at University of Rochester
>              benchmarked fio and provided a report
>     
>     Sofia  - EDI https://www.edi.works
>              benchmarked the top eight memory hogs and provided reports
> 
> Can you please provide your Tested-by tags? This will ensure the credit
> for your contributions.
> 
> Thanks!

I have tested MGLRU using fio [1]. The performance improvement is fabulous.
I hope this patchset could eventually get merged to enable large scale test
and let more users talk about their experience.

Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>

[1] https://lore.kernel.org/lkml/20220105024423.26409-1-szhai2@cs.rochester.edu/
