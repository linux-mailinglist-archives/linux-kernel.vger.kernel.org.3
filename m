Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0EA48E375
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 06:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiANFAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 00:00:31 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30278 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiANFAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 00:00:30 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JZpxv5P0bzbjvy;
        Fri, 14 Jan 2022 12:59:47 +0800 (CST)
Received: from dggpemm500003.china.huawei.com (7.185.36.56) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 13:00:28 +0800
Received: from [10.174.185.129] (10.174.185.129) by
 dggpemm500003.china.huawei.com (7.185.36.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 13:00:28 +0800
Message-ID: <a93988da-80fb-dd32-4717-a6a0bae9e4ee@huawei.com>
Date:   Fri, 14 Jan 2022 13:00:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <wangzhigang17@huawei.com>, Matthew Wilcox <willy@infradead.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org>
 <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
 <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com>
From:   "zhangliang (AG)" <zhangliang5@huawei.com>
In-Reply-To: <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.129]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500003.china.huawei.com (7.185.36.56)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/1/14 0:48, David Hildenbrand wrote:
> On 13.01.22 17:37, Linus Torvalds wrote:
>> On Thu, Jan 13, 2022 at 6:39 AM Matthew Wilcox <willy@infradead.org> wrote:
>>>
>>> Let's bring Linus in on this, but I think this reintroduces all of the
>>> mapcount problems that we've been discussing recently.
>>>
>>> How about this as an alternative?
>>
>> No, at that point reuse_swap_page() is the better thing to do.
>>
>> Don't play games with page_count() (or even worse games with
>> swap_count). The page count is only stable if it's 1. Any other value
>> means that it can fluctuate due to concurrent lookups, some of which
>> can be done locklessly under RCU.
> 
> I'm pretty sure the patch as is will reintroduce the CVE. So I think in

Actually, I wonder how reuse_swap_page() in this patch can reintroduce CVE,
I think the invoking logic here is as same as that in do_swap_page(). 
So, could you give me some hint about this? Thanks :)

> addition to the reuse_swap_page() check we need more.
> 
> I'm wondering if we can get rid of the mapcount checks in
> reuse_swap_page() and instead check for page_count() and swapcount only.
> 
> We don't care if it's unstable in a sense than it will be bigger than
> what we expect. In that case we COW as we would already do.
> 
> Thoughts?
> 

-- 
Best Regards,
Liang Zhang
