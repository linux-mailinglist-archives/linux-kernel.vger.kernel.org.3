Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F604BC936
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 16:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242568AbiBSPqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 10:46:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbiBSPqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 10:46:38 -0500
Received: from p3plsmtpa09-10.prod.phx3.secureserver.net (p3plsmtpa09-10.prod.phx3.secureserver.net [173.201.193.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AA8606DB
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 07:46:19 -0800 (PST)
Received: from localhost ([82.17.115.212])
        by :SMTPAUTH: with ESMTPA
        id LRw8nR7WZApSlLRwAn6492; Sat, 19 Feb 2022 08:46:18 -0700
X-CMAE-Analysis: v=2.4 cv=G8PZr/o5 c=1 sm=1 tr=0 ts=621110ca
 a=9gipVNR6X1CoIeAWHwLoWw==:117 a=9gipVNR6X1CoIeAWHwLoWw==:17
 a=IkcTkHD0fZMA:10 a=V1cTPmE0SeOrMctsYS0A:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: atomlin@atomlin.com
Date:   Sat, 19 Feb 2022 15:46:16 +0000
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Christoph Lameter <cl@linux.com>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH] tick/sched: Ensure quiet_vmstat() is called when the
 idle tick was stopped too
Message-ID: <20220219154616.pwsvh445x3vn7ltf@ava.usersys.com>
References: <20220203214339.1889971-1-atomlin@redhat.com>
 <20220217124729.GA743618@lothringen>
 <20220217142615.xqtiydixvnumyvei@ava.usersys.com>
 <20220217163205.GA748087@lothringen>
 <20220218125454.utlgmuhijklzr3if@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220218125454.utlgmuhijklzr3if@ava.usersys.com>
X-CMAE-Envelope: MS4xfJiroNaFnsTHoDSgz04xohdorYU5pddO2sPbxqT4ITyLgdyy5IFvHOrHlitlbz0hwwl7PQdOvX+hYOtqnYPM4kr2sBWlZ2rISf7/uBPMIgCNnrElmoVX
 KZvcNo2PkKknj2nxbIAtCVlF/dWr1OfA5usQMp4nwcvwx8eyVhXJK9J8kYuhp60sGqoWI8+2WMobfClrk0htSx8AaZ8+KwlpW5QW9ao/w6PKuwRGJL0NK6Ag
 wgd5PvfUv1JVoYQjGiVPfhCyxHfbVsSS/bd88wGCNvXkTwAK+TrWPpURq1/WCrI2EfvujU4t28wDExhx/nnkfdZBnONWh5Z3lNBpdq60frL0TPXS5XeCL73p
 uI7SqyqSHs4pcRG7Q4K4m/zCD8YesVcL3X/NoEzQgWF6S820sXsqbL2NH9RM/mo/IwjA4THH
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-02-18 12:54 +0000, Aaron Tomlin wrote:
> On Thu 2022-02-17 17:32 +0100, Frederic Weisbecker wrote:
> > > If I understand correctly, in the context of nohz_full, since such work is
> > > deferred, it will only be handled in a scenario when the periodic/or
> > > scheduling-clock tick is enabled i.e. the timer was reprogrammed on exit
> > > from idle.
> > 
> > Oh I see, it's a deferrable delayed work...
> > Then I can see two other issues:
> > 
> > 1) Can an interrupt in idle modify the vmstat and thus trigger the need to
> >    flush it? I believe it's the case and then the problem goes beyond nohz_full
> >    because if the idle interrupt fired while the tick is stopped and didn't set
> >    TIF_RESCHED, we go back to sleep without calling quiet_vmstat().
> 
> Yes: e.g. a nohz_full CPU, in idle code, could indeed receive a reschedule
> IPI; re-enable local IRQs and generic idle code sees the TIF_NEED_RESCHED
> flag against the idle task. Additionally, the selected task could
> indirectly released a few pages [to satisfy a low-memory condition] and
> modify CPU-specific vmstat data i.e. vm_stat_diff[NR_FREE_PAGES].
> 
> 
> > 2) What if we are running task A in kernel mode while the tick is stopped
> >    (nohz_full). Task A modifies the vmstat and goes to userspace for a long
> >    while.
> > Your patch fixes case 1) but not case 2). The problem is that TIMER_DEFERRABLE
> > should really be about dynticks-idle only and not dynticks-full. I've always
> > been afraid about enforcing that rule though because that would break old
> > noise-free setups. But perhaps I should...
> 
> If I understand correctly, I agree. For the latter case, nothing can be
> done unfortunately since the scheduling-clock tick is stopped.

Hi Frederic,

As far as I understand, in the context of nohz_full, options are indeed
limited; albeit, if we can ensure CPU-specific vmstat data is folded on
return to idle [when required] then this should be good enough.


Kind regards,

-- 
Aaron Tomlin
