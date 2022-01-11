Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE5C48AA0F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349128AbiAKJBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbiAKJBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:01:16 -0500
X-Greylist: delayed 457 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Jan 2022 01:01:16 PST
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1A4C06173F;
        Tue, 11 Jan 2022 01:01:16 -0800 (PST)
Received: from tux.applied-asynchrony.com (p5b07ee01.dip0.t-ipconnect.de [91.7.238.1])
        by mail.itouring.de (Postfix) with ESMTPSA id E4900103765;
        Tue, 11 Jan 2022 09:53:36 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 75FA3F01624;
        Tue, 11 Jan 2022 09:53:36 +0100 (CET)
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
To:     Yu Zhao <yuzhao@google.com>, Alexandre Frade <kernel@xanmod.org>,
        Brian Geffon <bgeffon@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
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
References: <20220104202227.2903605-1-yuzhao@google.com>
 <YdSuSHa/Vjl6bPkg@google.com> <Yd1Css8+jsspeZHh@google.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <ca3a7d27-150d-ed06-c8f8-0c74c4f00667@applied-asynchrony.com>
Date:   Tue, 11 Jan 2022 09:53:36 +0100
MIME-Version: 1.0
In-Reply-To: <Yd1Css8+jsspeZHh@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-11 09:41, Yu Zhao wrote:
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
> 

Have been pounding on this "in production" on several different machines
(server, desktop, laptop) and 5.15.x without any issues, so:

Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>

Looking forward to seeing this in mainline!

cheers,
Holger
