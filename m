Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8678855E71D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346814AbiF1NrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346043AbiF1NrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:47:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED252A948
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:47:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68A9D61981
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2654C3411D;
        Tue, 28 Jun 2022 13:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656424019;
        bh=QUu2aLIsAEuzpPDL8ZQeilgnfmY0TkzTRUtegNT7pIE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=d3pZnEAuLHpUaosc38q+nESJobsO4X25MJ15fCFlznVxY2DudkQMaEV3Oc7QLbaLH
         0f7JLIXAJuhfTiUyc3uLNjsqM1RUVkHev2h1MDfkFh6RaThgxuttgVRCvcnZVV4m1U
         wghkmd2pIDAMty3Vnf4NU1+FDRzJIVSM95UpcA2rpl4h0byawzYmVBRrtxiY7eaoyf
         50YwYNxWwZGmBVH7O1zlC+gmHh0OlzwJ0WgdYRZpRm45+IhY0/mvzZVY4Jo/AK2PGi
         M6aq6AfCYhqV059Vt9vh/v3GH+54oxg4kKXbepebnxI3duCOa+KMypxG0gFylfim/z
         NRCFi6DrE270w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 259625C0458; Tue, 28 Jun 2022 06:46:59 -0700 (PDT)
Date:   Tue, 28 Jun 2022 06:46:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Neeraj Upadhyay <quic_neeraju@quicinc.com>, frederic@kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        zhangfei.gao@foxmail.com, boqun.feng@gmail.com, urezki@gmail.com,
        shameerali.kolothum.thodi@huawei.com, pbonzini@redhat.com,
        mtosatti@redhat.com, eric.auger@redhat.com,
        chenxiang66@hisilicon.com
Subject: Re: [PATCH] srcu: Reduce blocking agressiveness of expedited grace
 periods further
Message-ID: <20220628134659.GY1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220627123706.20187-1-quic_neeraju@quicinc.com>
 <875ykl2mb2.wl-maz@kernel.org>
 <dc24db89-05ae-c113-6728-de797e041123@quicinc.com>
 <874k052kxh.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874k052kxh.wl-maz@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:31:54AM +0100, Marc Zyngier wrote:
> On Tue, 28 Jun 2022 10:17:24 +0100,
> Neeraj Upadhyay <quic_neeraju@quicinc.com> wrote:
> > 
> > 
> > 
> > On 6/28/2022 2:32 PM, Marc Zyngier wrote:
> > > On Mon, 27 Jun 2022 13:37:06 +0100,
> > > Neeraj Upadhyay <quic_neeraju@quicinc.com> wrote:
> > >> 
> > >> Commit 640a7d37c3f4 ("srcu: Block less aggressively for expedited
> > >> grace periods") highlights a problem where aggressively blocking
> > >> SRCU expedited grace periods, as was introduced in commit
> > >> 282d8998e997 ("srcu: Prevent expedited GPs and blocking readers
> > >> from consuming CPU"), introduces ~2 minutes delay to the overall
> > >> ~3.5 minutes boot time, when starting VMs with "-bios QEMU_EFI.fd"
> > >> cmdline on qemu, which results in very high rate of memslots
> > >> add/remove, which causes > ~6000 synchronize_srcu() calls for
> > >> kvm->srcu SRCU instance.
> > >> 
> > >> Below table captures the experiments done by Zhangfei Gao, Shameer,
> > >> to measure the boottime impact with various values of non-sleeping
> > >> per phase counts, with HZ_250 and preemption enabled:
> > >> 
> > >> +──────────────────────────+────────────────+
> > >> | SRCU_MAX_NODELAY_PHASE   | Boot time (s)  |
> > >> +──────────────────────────+────────────────+
> > >> | 100                      | 30.053         |
> > >> | 150                      | 25.151         |
> > >> | 200                      | 20.704         |
> > >> | 250                      | 15.748         |
> > >> | 500                      | 11.401         |
> > >> | 1000                     | 11.443         |
> > >> | 10000                    | 11.258         |
> > >> | 1000000                  | 11.154         |
> > >> +──────────────────────────+────────────────+
> > >> 
> > >> Analysis on the experiment results showed improved boot time
> > >> with non blocking delays close to one jiffy duration. This
> > >> was also seen when number of per-phase iterations were scaled
> > >> to one jiffy.
> > >> 
> > >> So, this change scales per-grace-period phase number of non-sleeping
> > >> polls, soiuch that, non-sleeping polls are done for one jiffy. In addition
> > >> to this, srcu_get_delay() call in srcu_gp_end(), which is used to calculate
> > >> the delay used for scheduling callbacks, is replaced with the check for
> > >> expedited grace period. This is done, to schedule cbs for completed expedited
> > >> grace periods immediately, which results in improved boot time seen in
> > >> experiments.
> > >> 
> > >> In addition to the changes to default per phase delays, this change
> > >> adds 3 new kernel parameters - srcutree.srcu_max_nodelay,
> > >> srcutree.srcu_max_nodelay_phase, srcutree.srcu_retry_check_delay.
> > >> This allows users to configure the srcu grace period scanning delays,
> > >> depending on their system configuration requirements.
> > >> 
> > >> Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > > 
> > > I've given this a go on one of my test platforms (the one I noticed
> > > the issue on the first place), and found that the initial part of the
> > > EFI boot under KVM (pointlessly wiping the emulated flash) went down
> > > to 1m7s from 3m50s (HZ=250).
> > > 
> > > Clearly a massive improvement, but still a far cry from the original
> > > ~40s (yes, this box is utter crap -- which is why I use it).
> > 
> > Do you see any improvement by using "srcutree.srcu_max_nodelay=1000"
> > bootarg, on top of this patch?
> 
> Yup, this brings it back to 43s on a quick test run, which is close
> enough to what I had before.
> 
> How does a random user come up with such a value though?

There was some talk of moving from synchronize_srcu_expedited() to
call_srcu() with the occasional srcu_barrier() to avoid OOM.  If that
proves to be practical, that should get decent performance with little
tuning.  But in the meantime, we need to avoid hangs due to CPU-bound
tasks in one workload while still avoiding massive boot-time slowdowns
in your workload.

Right now, Neeraj's carefully  tuned approach is the one way we know to
square this particular circle.

							Thanx, Paul
