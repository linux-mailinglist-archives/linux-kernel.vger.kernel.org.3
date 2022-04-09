Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9FC4FA235
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 06:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbiDIEJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 00:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiDIEJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 00:09:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAF5C0B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 21:07:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BE7860A1B
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 04:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EE7C385A4;
        Sat,  9 Apr 2022 04:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649477230;
        bh=9rN5m4lI0oo91HwX0H51G1AD32a+RVoqZlgugsuLU+0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UTG2Lg/6h6VFTMDPuqpCHxzHxyi5l4Vk+mpCUhFbROzj6kMB+yTxkHo0/ONCSUjQq
         v9EIUpHkK/Tm5ptyU7CcDzYsflLTl6MBjwm3PcKVQLB/9MT8GRnzlDU9S2v6uBWK16
         s27ZdxG4Qy+CVYjn/n1BW+MJEKNNtEy3HbG1Wr3w=
Date:   Fri, 8 Apr 2022 21:07:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Zhong Jiang <zhongjiang-ali@linux.alibaba.com>
Subject: Re: [PATCH 0/3] memory tiering: hot page selection
Message-Id: <20220408210709.ce4ede3a9c778700dda0a292@linux-foundation.org>
In-Reply-To: <20220408071222.219689-1-ying.huang@intel.com>
References: <20220408071222.219689-1-ying.huang@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Apr 2022 15:12:19 +0800 Huang Ying <ying.huang@intel.com> wrote:

> To optimize page placement in a memory tiering system with NUMA
> balancing, the hot pages in the slow memory node need to be
> identified.  Essentially, the original NUMA balancing implementation
> selects and promote the mostly recently accessed (MRU) pages.  But the
> recently accessed pages may be cold.

Wait.  What.  How on earth could the most recently accessed page be
considered "cold"?

Changelog needs work, please.

> So in this patchset, we
> implement a new hot page identification algorithm based on the latency
> between NUMA balancing page table scanning and hint page fault.

That sounds reasonable.

> And the hot page promotion can incur some overhead in the system.  To
> control the overhead a simple promotion rate limit mechanism is
> implemented.

That sounds like a hack to fix a problem you just added?  Maybe a
reasonable one..

> The hot threshold used to identify the hot pages is workload dependent
> usually.  So we also implemented a hot threshold automatic adjustment
> algorithm.  The basic idea is to increase/decrease the hot threshold
> to make the number of pages that pass the hot threshold (promote
> candidate) near the rate limit.

hot threshold is tweakable via debugfs.  So it's an unstable interface,
undocumented, may be withdrawn at any time, etc.

Please justify this.  Is it intended that this interface be removed? 
If yes, please describe the plan for this in the changelog.  If no then
this interface should be in sysfs, it should be fully documented in the
kernel tree and it should be fully changelogged (preferably with usage
examples) so that reviewers can best understand what is a permanent
extension to the kernel API which we must maintain for all time.



Does this code build correctly if !LAST_CPUPID_NOT_IN_PAGE_FLAGS?


> TODO: Add ABI document for new sysctl knob.

um, yes.


check_cpupid() is a poor function name.  Check for what?  Liver damage?
A better identifier would be cpupid_valid(), perhaps.  And perhaps it
should be implemented in mm.h.  And even documented.


Oddly, the proposed changes do a decent job of documenting
intra-function changes but a poor job of documenting newly added
functions.  Please review every new function and decide whether it is
so simple and obvious that it can be added to Linux without any inline
description at all.  

pgdat_free_space_enough() and  numa_hint_fault_latency().

numa_migration_check_rate_limit() particularly.  There's that "check"
word again.  Check for what?



The numa_balancing_rate_limit_mbps sysctl.  I assume "b" means "bytes".
That's better than "pages", but still.  Machines vary a lot in how
many bytes they have and in the speed at which they process those
bytes.  Is there some metric which we can use here which at least
partially insulates us from this variability?  So that sysadmins don't
need to set all their machines differently, based upon their size and
speed?


numa_threshold_ts is apparently in units of jiffies.  This was not
documented at the definition site, and it should be.  But jiffies can
vary between machines and configs.  Why add this inter-machine and
inter-config uncertainty/variability when we have include/linux/ktime.h?



