Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AED46FC87
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbhLJIWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:22:41 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:34322 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhLJIWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:22:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 97926CE2997
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48197C00446;
        Fri, 10 Dec 2021 08:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639124342;
        bh=bjObNgj4Nu4UfmjzJWW93lpqo6GTGtFbMeFqZRgFtVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=nG+FimgdAXraTKzVFWBvGloNqYyYm5/af2oO2jKqieA1f8/WCR2PVzL2mju307LvP
         w2dqYLOMr9D6to90a6vby+toq2cbvmcskhaYQ3nKmeF1YKnrnCfWuUtfYffi6g8ls6
         ilyxUGK05Z8LTINHgfo5xN20++EGWuCY1Ts1XfAKTgZ34MwQ5Autkhg9yrRfGm7fb8
         iSObEYuvxCsub9rMmMF3SnHD8aFu2KdobQfLilaZAnkuBWuopXgdbPpvAPAgVvtxje
         H6I2R53OrpkSEsOCQjLdtAgswMM83W4TXnz8nikKC7F5+5MTtMhQ0TJW8i6zZCE3WJ
         OW+TyaeIgoxsQ==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 2/2] mm/damon: Modify the display form of damon tracepoint
Date:   Fri, 10 Dec 2021 08:18:59 +0000
Message-Id: <20211210081859.33599-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <b6142e6f-266d-1dec-a3b6-83e622280462@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

On Fri, 10 Dec 2021 11:36:23 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> [-- Attachment #1: Type: text/plain, Size: 4038 bytes --]
> 
> Hi SeongJae：
> 
> On 12/10/21 12:46 AM, SeongJae Park wrote:
> > On Fri, 10 Dec 2021 00:33:17 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
> >
> >> When I use the perf command to record damon monitor data, like below.
> >>      # perf record -e damon:damon_aggregated
> >>      # perf script
> >>      ...target_id=18446462667479739520 nr_regions=13 281472805928960-281472942936064...
> >>      ...target_id=18446462667479739520 nr_regions=13 281472942936064-281473080008704...
> >>      ...target_id=18446462667479739520 nr_regions=13 281473080008704-281473216634880...
> >>
> >>  From a user's point of view, the 'target_id' and 'damon_region' which displays in decimal
> >> are not very friendly, So there do some changes, keep the 'target_id' display consistent
> >> with 'dbgfs/target_ids' interface and 'damon_region' is displayed in hexadecimal, just like
> >> below.
> >>      # perf record -e damon:damon_aggregated
> >>      # perf script
> >>      ...target_id=5522 nr_regions=14 ffff716a3000-ffff79893000...
> >>      ...target_id=5522 nr_regions=14 ffff79893000-ffff819dc000...
> >>      ...target_id=5522 nr_regions=14 ffff819dc000-ffff89bd9000...
> >>
> >> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> >> ---
> >>   include/trace/events/damon.h | 6 +++---
> >>   1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
> >> index 99ffa601e351..67de51814f4c 100644
> >> --- a/include/trace/events/damon.h
> >> +++ b/include/trace/events/damon.h
[...]
> >>   	TP_fast_assign(
> >> -		__entry->target_id = t->id;
> >> +		__entry->target_id = (int)pid_vnr((struct pid *)t->id);
> > I think this would break physical address space monitoring.  Have you tested
> > this change for that?
> 
> Yes, you are right,  But I encountered some problems while testing 
> physical address, it seems that my operation did not work
> 
> I did some test like this:
> 
>      # echo "42 0x0000000840000000 0x000000103fffffff" > init_regions
> 
>      # echo paddr > target_ids
> 
>      # echo on > monitor_on
> 
> i get the physical address from my kernel startup log.
> 
> 15 [ 0.000000] Early memory node ranges
> 16 [ 0.000000] node 0: [mem 0x0000000040000000-0x000000083bc7ffff]
> 17 [ 0.000000] node 0: [mem 0x000000083bc80000-0x000000083bffffff]
> 18 [ 0.000000] node 0: [mem 0x000000083c000000-0x000000083c03ffff]
> 19 [ 0.000000] node 0: [mem 0x000000083c040000-0x000000083c0fffff]
> 20 [ 0.000000] node 0: [mem 0x000000083c100000-0x000000083f3dffff]
> 21 [ 0.000000] node 0: [mem 0x000000083f3e0000-0x000000083f46ffff]
> 22 [ 0.000000] node 0: [mem 0x000000083f470000-0x000000083f47ffff]
> 23 [ 0.000000] node 0: [mem 0x000000083f480000-0x000000083f59ffff]
> 24 [ 0.000000] node 0: [mem 0x000000083f5a0000-0x000000083fffffff]
> 25 [ 0.000000] node 1: [mem 0x0000000840000000-0x000000103fffffff]
> 26 [ 0.000000] node 2: [mem 0x0000001040000000-0x000000183fffffff]
> 27 [ 0.000000] node 3: [mem 0x0000001840000000-0x000000203fffffff]
> 28 [ 0.000000] Initmem setup node 0 [mem 
> 0x0000000040000000-0x000000083fffffff]
> 29 [ 0.000000] On node 0 totalpages: 8388608
> 
> Is there anything wrong ?

"The target id should already in target_ids file"[1].

For proper use of DAMON, I'd like to recommend you to refer to, or use the
official DAMON user space tool[2] instead of the debugfs interface.  As the
document[3] says "DAMON user space tool. This is for privileged people such as
system administrators who want a just-working human-friendly interface".

Also, some of your patches including this break the user space tool.  As it is
an important part of DAMON echosystem, it would be great if you could consider
taking care in keeping it unbroken, too.

[1] https://docs.kernel.org/admin-guide/mm/damon/usage.html#initial-monitoring-target-regions
[2] https://github.com/awslabs/damo
[3] https://docs.kernel.org/admin-guide/mm/damon/usage.html#detailed-usages


Thanks,
SJ

[...]
