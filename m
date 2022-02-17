Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BAE4BA052
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240517AbiBQMrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:47:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240512AbiBQMrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:47:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBECD2A82D9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 04:47:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B4A761A5C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 12:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096F2C340E8;
        Thu, 17 Feb 2022 12:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645102052;
        bh=wA4TA6YrIQbtLFi/OT33hqNlirr/i2Jv1hJ6PQ0u86s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AuIJ0amGpgBfYTZr1CLfAhxR2BMIvMN57lnrgx+MmlxUdbKfLcvrNb9SNhYa2XoBr
         /btsI3/KNoDsi//mijxsgQ1LlPITenNf8vwoO3DgHtWDstzoIienp0rT3iu3a08jBP
         GjCSxQRj7hrlmbbp1wwqFHKVbTwHbla1DVe1JLVbGx2TJPCc7I6jDF1IHrSDHTym/D
         hVJl8nxnXKcL8hfVKIXRNuh2WEBy7awoIQS+cUHKKdkgoAXLHhlcNicf4iUrUcz4eH
         4wR5TWQGig6cv1SbXsaWDxW/MKky0GfjJqKAm5fSSCEnS68mWy8PhMi/X7m3vnGr6W
         8BIAOhc8vaSUQ==
Date:   Thu, 17 Feb 2022 13:47:29 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Christoph Lameter <cl@linux.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, atomlin@atomlin.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH] tick/sched: Ensure quiet_vmstat() is called when the
 idle tick was stopped too
Message-ID: <20220217124729.GA743618@lothringen>
References: <20220203214339.1889971-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203214339.1889971-1-atomlin@redhat.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

I fear my blood-brain barrier doesn't let much of mm/ code in, so I'm adding a
few interested people in Cc. Meanwhile a few comments below:


On Thu, Feb 03, 2022 at 09:43:39PM +0000, Aaron Tomlin wrote:
> Hi Frederic,
> 
> If I understand correctly, in the context of the idle task and a nohz_full
> CPU, quiet_vmstat() can be called: before stopping the idle tick, entering
> an idle state and on exit. In particular, for the latter case, when the
> idle task is required to reschedule, the idle tick can remain stopped and
> the timer expiration time endless i.e., KTIME_MAX. Now, indeed before a
> nohz_full CPU enters an idle state, CPU-specific vmstat counters should
> be processed to ensure the respective values have been reset and folded
> into the zone specific vm_stat[]. That being said, it can only occur when:
> the idle tick was previously stopped, and reprogramming of the timer is not
> required.

So, to make sure I understand, the issue is that with nohz_full, we may
well enter into the idle loop with the tick already stopped. We may also
exit from idle without restarting the tick (again only with nohz_full). And
so this can cause the vmstat to not be flushed upon idle entry. Right?

> 
> A customer provided some evidence which indicates that the idle tick was
> stopped; albeit, CPU-specific vmstat counters still remained populated.
> Thus one can only assume quiet_vmstat() was not invoked on return to the
> idle loop.
> 
> Unfortunately, I suspect this divergence might erroneously prevent a
> reclaim attempt by kswapd. If the number of zone specific free pages are
> below their per-cpu drift value then zone_page_state_snapshot() is used to
> compute a more accurate view of the aforementioned statistic.
> Thus any task blocked on the NUMA node specific pfmemalloc_wait queue will
> be unable to make significant progress via direct reclaim unless it is
> killed after being woken up by kswapd (see throttle_direct_reclaim()).
> That being said, eventually reclaim should give up if the conditions are
> correct, no?

Now if quiet_vmstat() isn't called, the vmstat_work should fix this later,
right? Or does that happen too late perhaps?

Thanks!
