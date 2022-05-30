Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1A75384E2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240356AbiE3P1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241402AbiE3P1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:27:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A14113B78;
        Mon, 30 May 2022 07:30:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B164B80E23;
        Mon, 30 May 2022 14:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08943C385B8;
        Mon, 30 May 2022 14:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653921003;
        bh=OFwDldeLq6VK5vNQssnp+LuPob86xk+/cjvgoNLQoGU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Y4GM3MP5RuPDaWkZHgc4qqGl+aTGH7H+4a0dfyVxQuoN5Zw+c94fGBwLgyvfr8YQP
         v6xQ6qNbMHOvK66DcfQZnvV1wLwHAsVgEZKlTI+3Ys0mS+OIzmAONzkCppysiLn+UH
         F+982SYqwke8va6Mwq/KjrYa9SDVjywbo4cm3DVHNbE4yzaZb5Rs/sxB0lzhmmuI6o
         Jby84/PfuO37HR7CpCFsse7R75bPo6eIUC4+alaQHvPMjoHv/IFqH/sPM6h8HbYFvX
         WkQ+RLnZTh64sbbEhcqOfwAgfySe0zcYXHLn+zYaSUuvwXCiA/7t8/TmO+AWDS4vJl
         xtmgTFdea+5HQ==
Message-ID: <e3010471ee43e7e134f882f320fc4643fe4e4810.camel@kernel.org>
Subject: Re: [RFC PATCH 4/4] cpuset: Support RCU-NOCB toggle on v2 root
 partitions
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        rcu@vger.kernel.org
Date:   Mon, 30 May 2022 16:29:56 +0200
In-Reply-To: <20220530004049.GA1251147@lothringen>
References: <20220525221055.1152307-1-frederic@kernel.org>
         <20220525221055.1152307-5-frederic@kernel.org>
         <Yo/FGcG+uiBh88sT@slm.duckdns.org> <20220526225141.GA1214445@lothringen>
         <YpAHEt0j30vBw9au@slm.duckdns.org>
         <9e44bb00-955a-dbc6-a863-be649e0c701f@redhat.com>
         <YpAdSW8JXVPOoNJl@slm.duckdns.org>
         <20220527083018.n43nc73vuuzm5ixo@localhost.localdomain>
         <YpIwsiaY2IPK96WO@hirez.programming.kicks-ass.net>
         <20220530004049.GA1251147@lothringen>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-30 at 02:40 +0200, Frederic Weisbecker wrote:
> On Sat, May 28, 2022 at 04:24:50PM +0200, Peter Zijlstra wrote:
> > On Fri, May 27, 2022 at 10:30:18AM +0200, Juri Lelli wrote:
> > > Hi,
> > >=20
> > > On 26/05/22 14:37, Tejun Heo wrote:
> > > > On Thu, May 26, 2022 at 08:28:43PM -0400, Waiman Long wrote:
> > > > > I am thinking along the line that it will not be hierarchical. Ho=
wever,
> > > > > cpuset can be useful if we want to have multiple isolated partiti=
ons
> > > > > underneath the top cpuset with different isolation attributes, bu=
t no more
> > > > > sub-isolated partition with sub-attributes underneath them. IOW, =
we can only
> > > > > set them at the first level under top_cpuset. Will that be useful=
?
> > > >=20
> > > > At that point, I'd just prefer to have it under /proc or /sys.
> > >=20
> > > FWIW, I was under the impression that this would nicely fit along the
> > > side of other feaures towards implenting dynamic isolation of CPUs (s=
ay
> > > https://lore.kernel.org/lkml/20220510153413.400020-1-longman@redhat.c=
om/
> > > for example). Wouldn't be awkward to have to poke different places to
> > > achieve isolation at runtime?
> >=20
> > This, that's what I was thinking.
> >=20
> > My main objection to the whole thing is that it's an RCU_NOCB specific
> > interface. *That* I think is daft.
> >=20
> > I was thinking a partition would be able to designate a house-keeping
> > sub-partition/mask, but who cares about all the various different
> > housekeeping parties.
>=20
> It's time for the isolation users to step up here! I very rarely hear fro=
m them
> and I just can't figure out by myself all the variants of uses for each o=
f the
> isolation features. May be some people are only interested in nocb for so=
me
> specific uses, or may be it never makes sense without nohz full and all t=
he rest
> of the isolation features. So for now I take the very cautious path to sp=
lit the
> interface.

OK, my 2 cents. I personally deal with virtualisation setups that involve R=
T
and CPU isolation on both host and guests.

The main use-case ATM is running DPDK-like workloads. We want to achieve
latencies in the order of tens of microseconds, so it's essential to avoid
entering the kernel at all cost. So, no HW interrupts, sched tick, RCU
callbacks, clocksource watchdogs, softlockup, intel_pstate, timers, etc...
Everything is deferred onto housekeeping CPUs or disabled.

Then we have setups that need to deal with HW on the host, exposed to the g=
uest
through emulation or VirtIO. The same rules apply really, except for some I=
RQ
affinity tweaks and sched priority magic.

I find it hard to see how running RCU callback locally could be useful to a=
ny
latency sensitive workload.

Frederic, out of curiosity, do you have a use-case in mind that might benef=
it
from nohz_full but not rcu_nocb? Maybe HPC?

Regards,
Nicolas
