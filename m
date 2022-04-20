Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504645089F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350325AbiDTODH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358948AbiDTODF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:03:05 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BC73ED0B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:00:19 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-e5ca5c580fso2028380fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pRUovkRnUG5rsqiSGYYciuRz6wxFzq+vPKuuxpFfXUo=;
        b=PQpStd3WB8blyRYPJjAKgJzVsAmx6hSfRMraO6TRBiu7Erv+6RnN4mquv4g39Mjilr
         PXcmuTB58z2m92XVWaWKFA0Jg62cy3mCBZFf1N9coaVhubq76RO8zKSnun9haCKFvWtz
         rjRNMTU4IaDNXm142k/1pNOZVO1tYKZA3mNaqo/RpWhiPh2OIYRLUFlUwNNe5eEp0ka4
         zmIncZ8YOf1yOw1hRZWWDefwroJObTn3GImIz6qlyZM8gPNeHF4rzEacNWy1kuAoB/f9
         ulb+qLAd3pOI0NuLnUKHwQ+ciRG0CRXZn278wuwBeOnchWvoh/P/4SNd4LYb0cx4HGVs
         22CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pRUovkRnUG5rsqiSGYYciuRz6wxFzq+vPKuuxpFfXUo=;
        b=sxdCf0ge/+9AP9YIVbT5vFdeqlor4v3qYrExWk7gye/y0Z80e0FwL3JpcdwcniHs4k
         DEUgVGGYA3zr23m3KzgaT6P3edV+pFSE9bPJHPBQYQbql3MdZjIJp+qurX5QggW4tHjC
         V1cO019i86o1p34eTkBCg9uyRwVnc8CC/vQe/MS97Bqrz61iq+95vF+vkmotL2CArwWX
         ukutPSIJYkAtxGrwK4+4hAAt8z+KZYBVMPTP8Vyfu0UY+iNMcoqHPtTaZXJCr9MEkry4
         FlkZwEj7ikMRGW7adabWG4f85+nR84bCZrlPVtrHLuuMGJIikkUmAcONgAdG2fquCf0+
         TYWA==
X-Gm-Message-State: AOAM531gc7/EUAqO3VWtglrqEO/1zCfpEHeKbV3VzAPRlduInSMw/53j
        ByCI97N8+cOfZ5OwhazirPKqoE30z3yqzzspLw8lsmpeMasNng==
X-Google-Smtp-Source: ABdhPJyH5eDMZ1icoGiWXmfcVrCjHAWGXbVirHYPtqz+ahHo7c+PHG38du6elkK9vWiAQ75WwpH8if614euWAUIKzAw=
X-Received: by 2002:a05:6870:d254:b0:db:12b5:da3 with SMTP id
 h20-20020a056870d25400b000db12b50da3mr1624205oac.211.1650463218336; Wed, 20
 Apr 2022 07:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
 <20220419085607.2014-1-hdanton@sina.com> <20220419134616.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <CACT4Y+Y8Az3_gi-UX-KCfQ1dxARJtL1NhB1AGLv9o_5gNtkWOg@mail.gmail.com>
 <20220419164908.GM4285@paulmck-ThinkPad-P17-Gen-1> <20220419231820.2089-1-hdanton@sina.com>
 <CACT4Y+YwP0Vvupn3QmQj9Ks4NV4hkBcc6gDQ7ro3_Dzy-benCg@mail.gmail.com> <20220420134149.GX4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220420134149.GX4285@paulmck-ThinkPad-P17-Gen-1>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Apr 2022 16:00:07 +0200
Message-ID: <CACT4Y+ZNXT1HHDT3aBzMtSouTYbetHcbFz-bVscj=5sbVdsaew@mail.gmail.com>
Subject: Re: [PATCH rcu 04/11] kernel/smp: Provide boot-time timeout for CSD
 lock diagnostics
To:     paulmck@kernel.org
Cc:     Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 at 15:41, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > > > Debugging of problems involving insanely long-running SMI handlers
> > > > > > > > proceeds better if the CSD-lock timeout can be adjusted.  This commit
> > > > > > > > therefore provides a new smp.csd_lock_timeout kernel boot parameter
> > > > > > > > that specifies the timeout in milliseconds.  The default remains at the
> > > > > > > > previously hard-coded value of five seconds.
> > > > > > > >
> > > > > > > > Cc: Rik van Riel <riel@surriel.com>
> > > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > > > Cc: Ingo Molnar <mingo@kernel.org>
> > > > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > > > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > > > > > > Cc: Juergen Gross <jgross@suse.com>
> > > > > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > > > > ---
> > > > > > > >  Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
> > > > > > > >  kernel/smp.c                                    |  7 +++++--
> > > > > > > >  2 files changed, 16 insertions(+), 2 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > > > > > index 3f1cc5e317ed..645c4c001b16 100644
> > > > > > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > > > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > > > > > @@ -5377,6 +5377,17 @@
> > > > > > > >     smart2=         [HW]
> > > > > > > >                     Format: <io1>[,<io2>[,...,<io8>]]
> > > > > > > >
> > > > > > > > +   smp.csd_lock_timeout= [KNL]
> > > > > > > > +                   Specify the period of time in milliseconds
> > > > > > > > +                   that smp_call_function() and friends will wait
> > > > > > > > +                   for a CPU to release the CSD lock.  This is
> > > > > > > > +                   useful when diagnosing bugs involving CPUs
> > > > > > > > +                   disabling interrupts for extended periods
> > > > > > > > +                   of time.  Defaults to 5,000 milliseconds, and
> > > > > > > > +                   setting a value of zero disables this feature.
> > > > > > > > +                   This feature may be more efficiently disabled
> > > > > > > > +                   using the csdlock_debug- kernel parameter.
> > > > > > > > +
> > > > > > >
> > > > > > > Can non-responsive CSD lock detected trigger syzbot (warning) report?
> > > > > >
> > > > > > If they enable it by building with CONFIG_CSD_LOCK_WAIT_DEBUG=y, yes.
> > > > >
> > > > > +syzkaller mailing list
> > > > >
> > > > > Currently we don't enable CONFIG_CSD_LOCK_WAIT_DEBUG in syzbot configs.
> > > > > Is it a generally useful debugging feature recommended to be enabled
> > > > > in kernel testing systems?
> > > >
> > > > With the default value for smp.csd_lock_timeout, it detects CPUs that have
> > > > had interrupts disabled for more than five seconds, which can be useful
> > > > for detecting what would otherwise be silent response-time failures.
> > >
> > > The five seconds take precedence over the 143s in reports [1] IMO.
> > > The shorter timeout helps select reproducers which in turn help find answer
> > > to questions there.
> >
> > I've sent https://github.com/google/syzkaller/pull/3090 to enable the config.
> > 5 seconds won't be reliable, I've set it to 100s to match CPU stall timeout.
>
> Thank you, Dmitry!
>
> Is there something I should be doing to enable the RCU CPU stall timeout
> to be reduced?

No.
We just bumped it to a high enough value to not cause false positives.
If it's stalled, it's stalled.


>                                                         Thanx, Paul
>
> > > [1] https://lore.kernel.org/lkml/20220321210140.GK4285@paulmck-ThinkPad-P17-Gen-1/
> > >
> > > >
> > > > > If we enabled it, we also need to figure out where it fits into the
> > > > > timeout hierarchy and adjust smp.csd_lock_timeout:
> > > > > https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/x86_64.yml#L15-L40
> > > >
> > > > On this, I must defer to you guys.  I can say that the larger the value
> > > > that you choose for smp.csd_lock_timeout, the nearer the beginnning of
> > > > that group it should go, but you guys knew that already.  ;-)
> > > >
> > > >                                                         Thanx, Paul
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "syzkaller" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller/20220419231820.2089-1-hdanton%40sina.com.
