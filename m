Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4E4508AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379690AbiDTOUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380122AbiDTOSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:18:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FB843EC1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:13:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40FF0B81D61
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E93C385A0;
        Wed, 20 Apr 2022 14:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650463978;
        bh=iULM7A9fCQ7Zxmf8Gc24aApToUhdP1WhjkyXL/nyKwY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=etV8oUqfv9dE6yVfXu40FtLwMs0AHRaSfiXSrVnw5u5E3gykqT9hC9jVunWEhQtKr
         vXaeK9dvE1i/ycJLZWRdUYwANww1DspDiyGKMikswRlVgs6LM/9MxEFKPanorWx2Hf
         5dpya0CVEygSSR049gjUdt+vWOohBUZPzXpHs8fKl3AXDmdYBIK4KbgP0vICxggBNj
         DpMShLr5MSDo5STVL1WeCTeBxDXWCHJFSrkJuMxdf+gHN7ODIywGvZrCpR7KN55EaP
         fvgZ3Eyj8pYDXQx4wrpWRGX35Nff9p0j/ghgMSzfnT4of+/oeivp4RH3zAOUt1eoT2
         Ubnb2CTQeVPYQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 807475C0269; Wed, 20 Apr 2022 07:12:58 -0700 (PDT)
Date:   Wed, 20 Apr 2022 07:12:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH rcu 04/11] kernel/smp: Provide boot-time timeout for CSD
 lock diagnostics
Message-ID: <20220420141258.GB4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
 <20220419085607.2014-1-hdanton@sina.com>
 <20220419134616.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <CACT4Y+Y8Az3_gi-UX-KCfQ1dxARJtL1NhB1AGLv9o_5gNtkWOg@mail.gmail.com>
 <20220419164908.GM4285@paulmck-ThinkPad-P17-Gen-1>
 <20220419231820.2089-1-hdanton@sina.com>
 <CACT4Y+YwP0Vvupn3QmQj9Ks4NV4hkBcc6gDQ7ro3_Dzy-benCg@mail.gmail.com>
 <20220420134149.GX4285@paulmck-ThinkPad-P17-Gen-1>
 <CACT4Y+ZNXT1HHDT3aBzMtSouTYbetHcbFz-bVscj=5sbVdsaew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZNXT1HHDT3aBzMtSouTYbetHcbFz-bVscj=5sbVdsaew@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 04:00:07PM +0200, Dmitry Vyukov wrote:
> On Wed, 20 Apr 2022 at 15:41, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > > > > Debugging of problems involving insanely long-running SMI handlers
> > > > > > > > > proceeds better if the CSD-lock timeout can be adjusted.  This commit
> > > > > > > > > therefore provides a new smp.csd_lock_timeout kernel boot parameter
> > > > > > > > > that specifies the timeout in milliseconds.  The default remains at the
> > > > > > > > > previously hard-coded value of five seconds.
> > > > > > > > >
> > > > > > > > > Cc: Rik van Riel <riel@surriel.com>
> > > > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > > > > Cc: Ingo Molnar <mingo@kernel.org>
> > > > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > > > > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > > > > > > > Cc: Juergen Gross <jgross@suse.com>
> > > > > > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > > > > > ---
> > > > > > > > >  Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
> > > > > > > > >  kernel/smp.c                                    |  7 +++++--
> > > > > > > > >  2 files changed, 16 insertions(+), 2 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > > > > > > index 3f1cc5e317ed..645c4c001b16 100644
> > > > > > > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > > > > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > > > > > > @@ -5377,6 +5377,17 @@
> > > > > > > > >     smart2=         [HW]
> > > > > > > > >                     Format: <io1>[,<io2>[,...,<io8>]]
> > > > > > > > >
> > > > > > > > > +   smp.csd_lock_timeout= [KNL]
> > > > > > > > > +                   Specify the period of time in milliseconds
> > > > > > > > > +                   that smp_call_function() and friends will wait
> > > > > > > > > +                   for a CPU to release the CSD lock.  This is
> > > > > > > > > +                   useful when diagnosing bugs involving CPUs
> > > > > > > > > +                   disabling interrupts for extended periods
> > > > > > > > > +                   of time.  Defaults to 5,000 milliseconds, and
> > > > > > > > > +                   setting a value of zero disables this feature.
> > > > > > > > > +                   This feature may be more efficiently disabled
> > > > > > > > > +                   using the csdlock_debug- kernel parameter.
> > > > > > > > > +
> > > > > > > >
> > > > > > > > Can non-responsive CSD lock detected trigger syzbot (warning) report?
> > > > > > >
> > > > > > > If they enable it by building with CONFIG_CSD_LOCK_WAIT_DEBUG=y, yes.
> > > > > >
> > > > > > +syzkaller mailing list
> > > > > >
> > > > > > Currently we don't enable CONFIG_CSD_LOCK_WAIT_DEBUG in syzbot configs.
> > > > > > Is it a generally useful debugging feature recommended to be enabled
> > > > > > in kernel testing systems?
> > > > >
> > > > > With the default value for smp.csd_lock_timeout, it detects CPUs that have
> > > > > had interrupts disabled for more than five seconds, which can be useful
> > > > > for detecting what would otherwise be silent response-time failures.
> > > >
> > > > The five seconds take precedence over the 143s in reports [1] IMO.
> > > > The shorter timeout helps select reproducers which in turn help find answer
> > > > to questions there.
> > >
> > > I've sent https://github.com/google/syzkaller/pull/3090 to enable the config.
> > > 5 seconds won't be reliable, I've set it to 100s to match CPU stall timeout.
> >
> > Thank you, Dmitry!
> >
> > Is there something I should be doing to enable the RCU CPU stall timeout
> > to be reduced?
> 
> No.
> We just bumped it to a high enough value to not cause false positives.
> If it's stalled, it's stalled.

Ah, your goal is to find perma-stalls.  Got it, thank you!

                                                        Thanx, Paul

> > > > [1] https://lore.kernel.org/lkml/20220321210140.GK4285@paulmck-ThinkPad-P17-Gen-1/
> > > >
> > > > >
> > > > > > If we enabled it, we also need to figure out where it fits into the
> > > > > > timeout hierarchy and adjust smp.csd_lock_timeout:
> > > > > > https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/x86_64.yml#L15-L40
> > > > >
> > > > > On this, I must defer to you guys.  I can say that the larger the value
> > > > > that you choose for smp.csd_lock_timeout, the nearer the beginnning of
> > > > > that group it should go, but you guys knew that already.  ;-)
> > > > >
> > > > >                                                         Thanx, Paul
> > > >
> > > > --
> > > > You received this message because you are subscribed to the Google Groups "syzkaller" group.
> > > > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> > > > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller/20220419231820.2089-1-hdanton%40sina.com.
