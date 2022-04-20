Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F9850897A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378764AbiDTNoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378648AbiDTNog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:44:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752E03ED11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:41:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1238660AAD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 13:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F1EC385A1;
        Wed, 20 Apr 2022 13:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650462109;
        bh=36fRYaj1vIlQQTjrNBaTcAurb9Qy0gzdy/h9DgbC63Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TAOTNdRBOBDSs6GDbK3A66w68QKVv/QlLNODGlTTwsjhuBq6+4SIhqkVDuykAjDH1
         bne6vROksJOSbSn8tnUPp0PE6cHw1jWGm2WjFQzScN5NpNaON/zUh6dL95rIzOIukt
         a64XnEJAFKsVOREVJNVvHPWG93CUuoj8TsnmRVhC36zl3KhzLnteVeCWztkE2wepjc
         WIjLoDy+VcfAq5DyaB24HbQEfQel+e7/nIxr/lrUpCG8r6+cREujU8An4nEWv+T5nF
         bmGYWLJU7TMyxXmC8YGFkRpOl/O4383aKPKCUfWahQCh8s5GhMz05qO62CKRD5KCDI
         oqJJ6Lo5rVuzg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0FD315C0269; Wed, 20 Apr 2022 06:41:49 -0700 (PDT)
Date:   Wed, 20 Apr 2022 06:41:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH rcu 04/11] kernel/smp: Provide boot-time timeout for CSD
 lock diagnostics
Message-ID: <20220420134149.GX4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
 <20220419085607.2014-1-hdanton@sina.com>
 <20220419134616.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <CACT4Y+Y8Az3_gi-UX-KCfQ1dxARJtL1NhB1AGLv9o_5gNtkWOg@mail.gmail.com>
 <20220419164908.GM4285@paulmck-ThinkPad-P17-Gen-1>
 <20220419231820.2089-1-hdanton@sina.com>
 <CACT4Y+YwP0Vvupn3QmQj9Ks4NV4hkBcc6gDQ7ro3_Dzy-benCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YwP0Vvupn3QmQj9Ks4NV4hkBcc6gDQ7ro3_Dzy-benCg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 02:17:21PM +0200, Dmitry Vyukov wrote:
> On Wed, 20 Apr 2022 at 01:18, Hillf Danton <hdanton@sina.com> wrote:
> > On Tue, 19 Apr 2022 09:49:08 -0700 Paul E. McKenney wrote:
> > > On Tue, Apr 19, 2022 at 04:11:36PM +0200, Dmitry Vyukov wrote:
> > > > On Tue, 19 Apr 2022 at 15:46, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > On Tue, Apr 19, 2022 at 04:56:07PM +0800, Hillf Danton wrote:
> > > > > > On Mon, 18 Apr 2022 15:53:52 -0700 Paul E. McKenney wrote:
> > > > > > > Debugging of problems involving insanely long-running SMI handlers
> > > > > > > proceeds better if the CSD-lock timeout can be adjusted.  This commit
> > > > > > > therefore provides a new smp.csd_lock_timeout kernel boot parameter
> > > > > > > that specifies the timeout in milliseconds.  The default remains at the
> > > > > > > previously hard-coded value of five seconds.
> > > > > > >
> > > > > > > Cc: Rik van Riel <riel@surriel.com>
> > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > > Cc: Ingo Molnar <mingo@kernel.org>
> > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > > > > > Cc: Juergen Gross <jgross@suse.com>
> > > > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > > > ---
> > > > > > >  Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
> > > > > > >  kernel/smp.c                                    |  7 +++++--
> > > > > > >  2 files changed, 16 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > > > > index 3f1cc5e317ed..645c4c001b16 100644
> > > > > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > > > > @@ -5377,6 +5377,17 @@
> > > > > > >     smart2=         [HW]
> > > > > > >                     Format: <io1>[,<io2>[,...,<io8>]]
> > > > > > >
> > > > > > > +   smp.csd_lock_timeout= [KNL]
> > > > > > > +                   Specify the period of time in milliseconds
> > > > > > > +                   that smp_call_function() and friends will wait
> > > > > > > +                   for a CPU to release the CSD lock.  This is
> > > > > > > +                   useful when diagnosing bugs involving CPUs
> > > > > > > +                   disabling interrupts for extended periods
> > > > > > > +                   of time.  Defaults to 5,000 milliseconds, and
> > > > > > > +                   setting a value of zero disables this feature.
> > > > > > > +                   This feature may be more efficiently disabled
> > > > > > > +                   using the csdlock_debug- kernel parameter.
> > > > > > > +
> > > > > >
> > > > > > Can non-responsive CSD lock detected trigger syzbot (warning) report?
> > > > >
> > > > > If they enable it by building with CONFIG_CSD_LOCK_WAIT_DEBUG=y, yes.
> > > >
> > > > +syzkaller mailing list
> > > >
> > > > Currently we don't enable CONFIG_CSD_LOCK_WAIT_DEBUG in syzbot configs.
> > > > Is it a generally useful debugging feature recommended to be enabled
> > > > in kernel testing systems?
> > >
> > > With the default value for smp.csd_lock_timeout, it detects CPUs that have
> > > had interrupts disabled for more than five seconds, which can be useful
> > > for detecting what would otherwise be silent response-time failures.
> >
> > The five seconds take precedence over the 143s in reports [1] IMO.
> > The shorter timeout helps select reproducers which in turn help find answer
> > to questions there.
> 
> I've sent https://github.com/google/syzkaller/pull/3090 to enable the config.
> 5 seconds won't be reliable, I've set it to 100s to match CPU stall timeout.

Thank you, Dmitry!

Is there something I should be doing to enable the RCU CPU stall timeout
to be reduced?

							Thanx, Paul

> > [1] https://lore.kernel.org/lkml/20220321210140.GK4285@paulmck-ThinkPad-P17-Gen-1/
> >
> > >
> > > > If we enabled it, we also need to figure out where it fits into the
> > > > timeout hierarchy and adjust smp.csd_lock_timeout:
> > > > https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/x86_64.yml#L15-L40
> > >
> > > On this, I must defer to you guys.  I can say that the larger the value
> > > that you choose for smp.csd_lock_timeout, the nearer the beginnning of
> > > that group it should go, but you guys knew that already.  ;-)
> > >
> > >                                                         Thanx, Paul
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller/20220419231820.2089-1-hdanton%40sina.com.
