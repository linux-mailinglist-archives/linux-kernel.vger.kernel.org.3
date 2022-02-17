Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CE54BA2F2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbiBQO0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:26:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiBQO0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:26:33 -0500
Received: from p3plsmtpa07-02.prod.phx3.secureserver.net (p3plsmtpa07-02.prod.phx3.secureserver.net [173.201.192.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D752B1670
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:26:17 -0800 (PST)
Received: from localhost ([82.17.115.212])
        by :SMTPAUTH: with ESMTPA
        id Khjbnebuy0d8ZKhjcnszcD; Thu, 17 Feb 2022 07:26:17 -0700
X-CMAE-Analysis: v=2.4 cv=QJKt+iHL c=1 sm=1 tr=0 ts=620e5b09
 a=9gipVNR6X1CoIeAWHwLoWw==:117 a=9gipVNR6X1CoIeAWHwLoWw==:17
 a=IkcTkHD0fZMA:10 a=caFokCbLAISjWCXd3CkA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: atomlin@atomlin.com
Date:   Thu, 17 Feb 2022 14:26:15 +0000
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Christoph Lameter <cl@linux.com>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH] tick/sched: Ensure quiet_vmstat() is called when the
 idle tick was stopped too
Message-ID: <20220217142615.xqtiydixvnumyvei@ava.usersys.com>
References: <20220203214339.1889971-1-atomlin@redhat.com>
 <20220217124729.GA743618@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220217124729.GA743618@lothringen>
X-CMAE-Envelope: MS4xfALsXlmYPNYwRtA/HuOcvZPn1r7QNGWJmyaFB2jLdhKjMRjmXVEu06hr1Y1VTV7KVvhxQGvNTbhGxBT/b7GFnuZprsaNclwWnRjHGWXo7TdfeYlwDDCW
 n4gBJuOudrTF8//Q7rmQfKDDT9Jsr7iZHy3e0qwesX7ssS+kVI3gZpM/ICK69Fd8hXprls7dOo43pVMyYzlneeBMWsiYmV8ci1+zId7cR/0VTbtsXe+ui2kY
 v2HQbf1/TJW2mrIj+eFlfPdGPl892bHVAc0nVS2Vtf+PWA67YMJYwpUSTovtZsjnoKb6g3A81Kww0dYxL4xYIU/XPVUHwW3UWC9//hxIJgV8QFg2dFPQdFOj
 VezZNgRasbvUJPWTFysdMeizHDEl3cwhYqI1j1zUD80il+clWZMmCCriKQMjG3JJEPcGNze+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-17 13:47 +0100, Frederic Weisbecker wrote:
> So, to make sure I understand, the issue is that with nohz_full, we may
> well enter into the idle loop with the tick already stopped. We may also
> exit from idle without restarting the tick (again only with nohz_full). And
> so this can cause the vmstat to not be flushed upon idle entry. Right?

Hi Frederic,

Yes - this is exactly it.

> > A customer provided some evidence which indicates that the idle tick was
> > stopped; albeit, CPU-specific vmstat counters still remained populated.
> > Thus one can only assume quiet_vmstat() was not invoked on return to the
> > idle loop.
> > 
> > Unfortunately, I suspect this divergence might erroneously prevent a
> > reclaim attempt by kswapd. If the number of zone specific free pages are
> > below their per-cpu drift value then zone_page_state_snapshot() is used to
> > compute a more accurate view of the aforementioned statistic.
> > Thus any task blocked on the NUMA node specific pfmemalloc_wait queue will
> > be unable to make significant progress via direct reclaim unless it is
> > killed after being woken up by kswapd (see throttle_direct_reclaim()).
> > That being said, eventually reclaim should give up if the conditions are
> > correct, no?

> Now if quiet_vmstat() isn't called, the vmstat_work should fix this later,
> right? Or does that happen too late perhaps?

If I understand correctly, in the context of nohz_full, since such work is
deferred, it will only be handled in a scenario when the periodic/or
scheduling-clock tick is enabled i.e. the timer was reprogrammed on exit
from idle.


Kind regards,

-- 
Aaron Tomlin
