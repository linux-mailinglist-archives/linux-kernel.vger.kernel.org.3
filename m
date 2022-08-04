Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C1B589891
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239217AbiHDHkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239199AbiHDHkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:40:35 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CF92A70A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 00:40:33 -0700 (PDT)
Date:   Thu, 4 Aug 2022 16:40:25 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1659598832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aKocoFOHQjUWCKVWggVJ2diOKUCvDqNI0lkZdeg2bgA=;
        b=i9z7N0lExHqwmkveUOibcw3zZZk0YbJ90WJB3O858Gpqzft3a0kkWOFQj8zmJvOzvcIDtE
        mbvuw/O43psDK87O1qnOBvSsdZ5tUncP0EDzG5ZdtSFBurwyXRbknQQBWGZiLGsZZXFptI
        8wpOloER93fRmvRiOZyL/P1FmU5mwss=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [bug report] mm, hwpoison: memory_failure races with
 alloc_fresh_huge_page/free_huge_page
Message-ID: <20220804074025.GA2551573@ik1-406-35019.vs.sakura.ne.jp>
References: <3c542543-0965-ef60-4627-1a4116077a5b@huawei.com>
 <Yuii5FnAXe/q7fx/@FVFYT0MHHV2J>
 <f2ad010b-b3bf-77c9-2256-701114b5d57e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f2ad010b-b3bf-77c9-2256-701114b5d57e@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 02:27:36PM +0800, Miaohe Lin wrote:
> On 2022/8/2 12:07, Muchun Song wrote:
> > On Tue, Aug 02, 2022 at 10:00:50AM +0800, Miaohe Lin wrote:
> >> Hi all:
> >>     When I investigate the mm/memory-failure.c code again, I found there's a possible race window
> >> between memory_failure and alloc_fresh_huge_page/free_huge_page. Thank about the below scene:
> >>
> >> CPU 1							CPU 2
> >> alloc_fresh_huge_page -- page refcnt > 0		memory_failure
> >>   prep_new_huge_page					  get_huge_page_for_hwpoison
> >> 							    !PageHeadHuge -- so 2(not a hugepage) is returned
> >>     hugetlb_vmemmap_optimize -- subpages is read-only
> >>     set_compound_page_dtor -- PageHuge is true now, but too late!!!
> >> 							  TestSetPageHWPoison(p)
> >> 							    -- We might write to read-only subpages here!!!
> >>
> >> Another similar scene:
> >>
> >> CPU 1							CPU 2
> >> free_huge_page -- page refcnt == 0 and not PageHuge	memory_failure
> >> 							  get_huge_page_for_hwpoison
> >> 							    !PageHeadHuge -- so 2(not a hugepage) is returned
> >> 							  TestSetPageHWPoison(p)
> >> 							    -- We might write to read-only subpages here!!!
> >>   hugetlb_vmemmap_restore -- subpages can be written to now, but too late!!!
> >>
> > 
> > I agree this race is possible, I have proposed this race in thread [1].

Thank you for reminding this, and I agree that we need some solution.

> 
> Oh, I remember I see the race proposed in [1] but I did not look into that carefully at that time. Sorry.
> 
> > But I didn't think more how to solve it.
> I hope this thread can find a good solution. :)

Both of the races show that __get_huge_page_for_hwpoison() fails to
capture the case of generic compound page during turning into hugetlb,
What makes things complicated is that no one knows to which state
such a compound page finally turns into. So I think that if the page
to be handled is an unknown compound page, we need to wait until it
becomes some known page state to avoid misjudging.

If we need a quick small fix, we may replace the check "!PageHeadHuge()"
in __get_huge_page_for_hwpoison() with "!PageCompound()", and add another
retry path in get_huge_page_for_hwpoison() for non-hugetlb compound pages.

Thanks,
Naoya Horiguchi

> 
> > 
> > [1] https://lore.kernel.org/linux-mm/20220623235153.2623702-1-naoya.horiguchi@linux.dev/T/#ma094a7cea7df8fd9a77a91551bf39077d89e23bd
> > 
> >> I think the above scenes are possible. But I can't found a stable solution to fix it. Any suggestions?
> >> Or is it not worth to fix it as it's too rare? Or am I miss something?
> >>
> > 
> > Luckily, the system will panic at once, which encountering this race. However,
> > we don't see any bug report. If we have an easy way to fix it, I think it is worth.
> 
> Agree. But I can't find a easy way to fix it yet.
> 
> > Just a quick reply, no suggestion/solutions from me.
> 
> Many thanks for your quick reply.
> 
> > 
> > Thanks.
> > 
> >> Any response would be appreciated!
> >>
> >> Thanks!
> >>
> > .
> > 
> 
