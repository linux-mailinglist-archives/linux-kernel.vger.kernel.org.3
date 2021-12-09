Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B90246ED70
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241272AbhLIQtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237817AbhLIQtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:49:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794F7C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 08:46:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B160CCE2688
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 16:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7E3C004DD;
        Thu,  9 Dec 2021 16:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639068374;
        bh=mbbPFllg/MmeN5bhUQ1cObIukuqDFANrLK94XhhKWvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=tXRJ5r5Twyd87+VUaXbyzEr8htg+4+/yCkJ7MJKC++Rg8lhXLtHbzE11/p7xrE+Py
         du5Sxp+bYZ1ZDZJukrFKIbWXDq4MsruWzMF3JqdldW8/1LTuG62yDRwYWBLTordovU
         tdf3zhELBlr8Xyw79TWPn0US4EyXo4CWgXXSm2RWsfvz9iVSKQUl1hKjPdkvgJ9eNt
         4LuHfGM8G8yTU5Aq5MgUdy2yDwgTQEELpZ4vAeywL85vmg5/8/TAiPe8eWPFM1oSvh
         5jbtwtBKRcgL27Fc+HzjBL5VEyLCC8QahHK53BuF0eySm2zmFHeuhaZpGJSxJZOkDU
         4BKK6EYuNJMPw==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 2/2] mm/damon: Modify the display form of damon tracepoint
Date:   Thu,  9 Dec 2021 16:46:11 +0000
Message-Id: <20211209164611.32858-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1e019e8ffe8c040376ec59e918d301058cc58ade.1639066954.git.xhao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 00:33:17 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> When I use the perf command to record damon monitor data, like below.
>     # perf record -e damon:damon_aggregated
>     # perf script
>     ...target_id=18446462667479739520 nr_regions=13 281472805928960-281472942936064...
>     ...target_id=18446462667479739520 nr_regions=13 281472942936064-281473080008704...
>     ...target_id=18446462667479739520 nr_regions=13 281473080008704-281473216634880...
> 
> From a user's point of view, the 'target_id' and 'damon_region' which displays in decimal
> are not very friendly, So there do some changes, keep the 'target_id' display consistent
> with 'dbgfs/target_ids' interface and 'damon_region' is displayed in hexadecimal, just like
> below.
>     # perf record -e damon:damon_aggregated
>     # perf script
>     ...target_id=5522 nr_regions=14 ffff716a3000-ffff79893000...
>     ...target_id=5522 nr_regions=14 ffff79893000-ffff819dc000...
>     ...target_id=5522 nr_regions=14 ffff819dc000-ffff89bd9000...
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  include/trace/events/damon.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
> index 99ffa601e351..67de51814f4c 100644
> --- a/include/trace/events/damon.h
> +++ b/include/trace/events/damon.h
> @@ -17,7 +17,7 @@ TRACE_EVENT(damon_aggregated,
>  	TP_ARGS(t, r, nr_regions),
> 
>  	TP_STRUCT__entry(
> -		__field(unsigned long, target_id)
> +		__field(int, target_id)
>  		__field(unsigned int, nr_regions)
>  		__field(unsigned long, start)
>  		__field(unsigned long, end)
> @@ -26,7 +26,7 @@ TRACE_EVENT(damon_aggregated,
>  	),
> 
>  	TP_fast_assign(
> -		__entry->target_id = t->id;
> +		__entry->target_id = (int)pid_vnr((struct pid *)t->id);

I think this would break physical address space monitoring.  Have you tested
this change for that?


Thanks,
SJ

>  		__entry->nr_regions = nr_regions;
>  		__entry->start = r->ar.start;
>  		__entry->end = r->ar.end;
> @@ -34,7 +34,7 @@ TRACE_EVENT(damon_aggregated,
>  		__entry->age = r->age;
>  	),
> 
> -	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u %u",
> +	TP_printk("target_id=%u nr_regions=%u %lx-%lx: %u %u",
>  			__entry->target_id, __entry->nr_regions,
>  			__entry->start, __entry->end,
>  			__entry->nr_accesses, __entry->age)
> --
> 2.31.0
