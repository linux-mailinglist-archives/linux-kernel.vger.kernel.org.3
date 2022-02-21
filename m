Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06BA4BDD2E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347216AbiBUJHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 04:07:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346966AbiBUJA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:00:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA0A24BD5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:55:35 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A83C7210F7;
        Mon, 21 Feb 2022 08:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645433712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LUrIgAk+aJhrM5t+S1YG62SjatqnJIxam/q/SPE6sz0=;
        b=GZXQc3KC7uHsZNDNR5bIuR62yqjIJHx3BcEpZsaDbSHrvOHd8yfqWRFcIV14cTqHQJ5VfF
        +lfbfTsw4UbBU4dVCx+8TGogei6sAbpYL4pKxshnxjOAyKEWnzmRKJ7q5BoL+2j4Vfvpxs
        9xWQzgLLdjtg9xvgaz0CguJxMq4AUSU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 73090A3B81;
        Mon, 21 Feb 2022 08:55:12 +0000 (UTC)
Date:   Mon, 21 Feb 2022 09:55:12 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        peterz@infradead.org, guro@fb.com, shakeelb@google.com,
        minchan@kernel.org, timmurray@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/1] mm: count time in drain_all_pages during direct
 reclaim as memory pressure
Message-ID: <YhNTcM9XtqA1zUUi@dhcp22.suse.cz>
References: <20220219174940.2570901-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220219174940.2570901-1-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 19-02-22 09:49:40, Suren Baghdasaryan wrote:
> When page allocation in direct reclaim path fails, the system will
> make one attempt to shrink per-cpu page lists and free pages from
> high alloc reserves. Draining per-cpu pages into buddy allocator can
> be a very slow operation because it's done using workqueues and the
> task in direct reclaim waits for all of them to finish before
> proceeding. Currently this time is not accounted as psi memory stall.
> 
> While testing mobile devices under extreme memory pressure, when
> allocations are failing during direct reclaim, we notices that psi
> events which would be expected in such conditions were not triggered.
> After profiling these cases it was determined that the reason for
> missing psi events was that a big chunk of time spent in direct
> reclaim is not accounted as memory stall, therefore psi would not
> reach the levels at which an event is generated. Further investigation
> revealed that the bulk of that unaccounted time was spent inside
> drain_all_pages call.

It would be cool to have some numbers here.

> Annotate drain_all_pages and unreserve_highatomic_pageblock during
> page allocation failure in the direct reclaim path so that delays
> caused by these calls are accounted as memory stall.

If the draining is too slow and dependent on the current CPU/WQ
contention then we should address that. The original intention was that
having a dedicated WQ with WQ_MEM_RECLAIM would help to isolate the
operation from the rest of WQ activity. Maybe we need to fine tune
mm_percpu_wq. If that doesn't help then we should revise the WQ model
and use something else. Memory reclaim shouldn't really get stuck behind
other unrelated work.
-- 
Michal Hocko
SUSE Labs
