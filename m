Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A325E4CBD0E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiCCLqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiCCLqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:46:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC1BE338D;
        Thu,  3 Mar 2022 03:45:53 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7A1E21F381;
        Thu,  3 Mar 2022 11:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646307952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pquBnsbxpVaSTX7gQj4O/UJ7qdLMfPFk/a+htdK7mOg=;
        b=uulOFw0gfnY8HAvmBKvG7Qm+K70G4pDxO00DcUyip3QrpEgn0zw91GeHcRWJw+qwEgSGiN
        cr/zX3Dfu9EYAgYUrTwIdKYmc8NAf14CNUxqOg2xYueGmYfowXg44QUhxsLuonLHCk20sy
        CqFUlFq+etk2JGnYaiqGhi40oa/sVxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646307952;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pquBnsbxpVaSTX7gQj4O/UJ7qdLMfPFk/a+htdK7mOg=;
        b=eA8mGhdnM7QfMyJhroeNVDAQTfOiot4lMAt/mOxhBfe6DgT5p6gH9I7wbjv3y80yVXJg+W
        Bdm82kWyM6TQ/HBA==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F1A39A3B81;
        Thu,  3 Mar 2022 11:45:51 +0000 (UTC)
Date:   Thu, 3 Mar 2022 11:45:50 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, frederic@kernel.org, tglx@linutronix.de,
        mtosatti@redhat.com, linux-rt-users@vger.kernel.org,
        vbabka@suse.cz, cl@linux.com, paulmck@kernel.org,
        willy@infradead.org
Subject: Re: [PATCH 0/2] mm/page_alloc: Remote per-cpu lists drain support
Message-ID: <20220303114550.GE4363@suse.de>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220208100750.1189808-1-nsaenzju@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 11:07:48AM +0100, Nicolas Saenz Julienne wrote:
> This series replaces mm/page_alloc's per-cpu page lists drain mechanism with
> one that allows accessing the lists remotely. Currently, only a local CPU is
> permitted to change its per-cpu lists, and it's expected to do so, on-demand,
> whenever a process demands it by means of queueing a drain task on the local
> CPU. This causes problems for NOHZ_FULL CPUs and real-time systems that can't
> take any sort of interruption and to some lesser extent inconveniences idle and
> virtualised systems.
> 

I know this has been sitting here for a long while. Last few weeks have
not been fun.

> Note that this is not the first attempt at fixing this per-cpu page lists:
>  - The first attempt[1] tried to conditionally change the pagesets locking
>    scheme based the NOHZ_FULL config. It was deemed hard to maintain as the
>    NOHZ_FULL code path would be rarely tested. Also, this only solves the issue
>    for NOHZ_FULL setups, which isn't ideal.
>  - The second[2] unanimously switched the local_locks to per-cpu spinlocks. The
>    performance degradation was too big.
> 

For unrelated reasons I looked at using llist to avoid locks entirely. It
turns out it's not possible and needs a lock. We know "local_locks to
per-cpu spinlocks" took a large penalty so I considered alternatives on
how a lock could be used.  I found it's possible to both remote drain
the lists and avoid the disable/enable of IRQs entirely as long as a
preempting IRQ is willing to take the zone lock instead (should be very
rare). The IRQ part is a bit hairy though as softirqs are also a problem
and preempt-rt needs different rules and the llist has to sort PCP
refills which might be a loss in total. However, the remote draining may
still be interesting. The full series is at
https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git/ mm-pcpllist-v1r2

It's still waiting on tests to complete and not all the changelogs are
complete which is why it's not posted.

This is a comparison of vanilla vs "local_locks to per-cpu spinlocks"
versus the git series up to "mm/page_alloc: Remotely drain per-cpu lists"
for the page faulting microbench I originally complained about.  The test
machine is a 2-socket CascadeLake machine.

pft timings
                                 5.17.0-rc5             5.17.0-rc5             5.17.0-rc5
                                    vanilla    mm-remotedrain-v2r1       mm-pcpdrain-v1r1
Amean     elapsed-1        32.54 (   0.00%)       33.08 *  -1.66%*       32.82 *  -0.86%*
Amean     elapsed-4         8.66 (   0.00%)        9.24 *  -6.72%*        8.69 *  -0.38%*
Amean     elapsed-7         5.02 (   0.00%)        5.43 *  -8.16%*        5.05 *  -0.55%*
Amean     elapsed-12        3.07 (   0.00%)        3.38 * -10.00%*        3.09 *  -0.72%*
Amean     elapsed-21        2.36 (   0.00%)        2.38 *  -0.89%*        2.19 *   7.39%*
Amean     elapsed-30        1.75 (   0.00%)        1.87 *  -6.50%*        1.62 *   7.59%*
Amean     elapsed-48        1.71 (   0.00%)        2.00 * -17.32%*        1.71 (  -0.08%)
Amean     elapsed-79        1.56 (   0.00%)        1.62 *  -3.84%*        1.56 (  -0.02%)
Amean     elapsed-80        1.57 (   0.00%)        1.65 *  -5.31%*        1.57 (  -0.04%)

Note the local_lock conversion took 1 1-17% penalty while the git tree
takes a negligile penalty while still allowing remote drains. It might
have some potential while being less complex than the RCU approach.

-- 
Mel Gorman
SUSE Labs
