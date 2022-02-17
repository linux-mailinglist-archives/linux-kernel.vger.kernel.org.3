Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BCE4BA5FE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241940AbiBQQc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:32:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiBQQc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:32:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECFE80203
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:32:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83867B82373
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 16:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C56EC340E8;
        Thu, 17 Feb 2022 16:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645115528;
        bh=NqMULm1c4evCoSC3Y43MlpFu52DjIZpoMiHrQmzmVgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HQBFigvNbuCaaSAq8YongVPEWhC9BvwTNk+Jc+QNNrBHPxfCyKAXElmXJv12qInKQ
         JmCPMv5TOMKA7gHM1EJtDlru9KRg4Eebe6+ae/YUAs44A7tFkOxkNNXeZKbyoZFW+r
         vrFU40lmIi/DvuKhNEuf4zUB/2CJzwPzhPShjhzDccX7gU4Ufqb7zoH+RLMurlWemW
         tCzQJCpZFxI3TOgtVNt8tX1vsV666Jf9UNIkUwcVZa+qBd7CCvVEAMk9UdwLS+n5/P
         vgQg04RXal4WmRbOq7s8FyG8DPGAHVWSbiFIcAhVtjig3/rmKqpf2CMqJTiAadMZDw
         EI8aUcapgfVBA==
Date:   Thu, 17 Feb 2022 17:32:05 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Aaron Tomlin <atomlin@atomlin.com>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Christoph Lameter <cl@linux.com>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH] tick/sched: Ensure quiet_vmstat() is called when the
 idle tick was stopped too
Message-ID: <20220217163205.GA748087@lothringen>
References: <20220203214339.1889971-1-atomlin@redhat.com>
 <20220217124729.GA743618@lothringen>
 <20220217142615.xqtiydixvnumyvei@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217142615.xqtiydixvnumyvei@ava.usersys.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 02:26:15PM +0000, Aaron Tomlin wrote:
> On Thu 2022-02-17 13:47 +0100, Frederic Weisbecker wrote:
> > So, to make sure I understand, the issue is that with nohz_full, we may
> > well enter into the idle loop with the tick already stopped. We may also
> > exit from idle without restarting the tick (again only with nohz_full). And
> > so this can cause the vmstat to not be flushed upon idle entry. Right?
> 
> Hi Frederic,
> 
> Yes - this is exactly it.
> 
> > > A customer provided some evidence which indicates that the idle tick was
> > > stopped; albeit, CPU-specific vmstat counters still remained populated.
> > > Thus one can only assume quiet_vmstat() was not invoked on return to the
> > > idle loop.
> > > 
> > > Unfortunately, I suspect this divergence might erroneously prevent a
> > > reclaim attempt by kswapd. If the number of zone specific free pages are
> > > below their per-cpu drift value then zone_page_state_snapshot() is used to
> > > compute a more accurate view of the aforementioned statistic.
> > > Thus any task blocked on the NUMA node specific pfmemalloc_wait queue will
> > > be unable to make significant progress via direct reclaim unless it is
> > > killed after being woken up by kswapd (see throttle_direct_reclaim()).
> > > That being said, eventually reclaim should give up if the conditions are
> > > correct, no?
> 
> > Now if quiet_vmstat() isn't called, the vmstat_work should fix this later,
> > right? Or does that happen too late perhaps?
> 
> If I understand correctly, in the context of nohz_full, since such work is
> deferred, it will only be handled in a scenario when the periodic/or
> scheduling-clock tick is enabled i.e. the timer was reprogrammed on exit
> from idle.

Oh I see, it's a deferrable delayed work...
Then I can see two other issues:

1) Can an interrupt in idle modify the vmstat and thus trigger the need to
   flush it? I believe it's the case and then the problem goes beyond nohz_full
   because if the idle interrupt fired while the tick is stopped and didn't set
   TIF_RESCHED, we go back to sleep without calling quiet_vmstat().

2) What if we are running task A in kernel mode while the tick is stopped
   (nohz_full). Task A modifies the vmstat and goes to userspace for a long
   while.

Your patch fixes case 1) but not case 2). The problem is that TIMER_DEFERRABLE
should really be about dynticks-idle only and not dynticks-full. I've always
been afraid about enforcing that rule though because that would break old
noise-free setups. But perhaps I should...
