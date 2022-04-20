Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553A15087F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378466AbiDTMUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378446AbiDTMUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:20:19 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A31E27FDF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 05:17:33 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w194so1772330oiw.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 05:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OvXNnzhldfA8EMm89aCLf2S6AGeu3KV4PREPULcra9M=;
        b=mPWyX3T8tuEJEGOeR2ZYB6RImWUTcZqFn8HIsVOH9KS4pEXKaz4XX13Rq2pxGR19HQ
         AnVk+h1LWEuSilN+Q/gg9u0F7fdLBZ6K34kdz4id1Votfcnj2CL4WX8OdVkRx793nPcM
         PyEcD5zs5iFY88q5O6BaHM67Sat6vaiyQNpYr6m/sllmMorQ+J7hPrQ/aCA49rtl3anG
         WlmbQm48e7xiw8B0y54lz6iObqB/OI+FdPbJxrJPgUbHi7SVm6/e+bmFZKMEffR6KMyN
         ks2zfY/fUDvz6/0WHOtNOdquVFtW3ULwDCOVx2eXq8xCVtT7Wlkf/x4vE5rtNWERBWy4
         +JDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OvXNnzhldfA8EMm89aCLf2S6AGeu3KV4PREPULcra9M=;
        b=3Xzudios5ZSewnr5GcJrKS9U/j2z1Vn/s9sSZZLyKS2yT18AU/Psye+mIqbD1qBCEH
         RW8DAh/6OFtHbFyOIh91MHMu2NFTexSQ0Y3MsLpO5Yp9HL2ZMHU4ALmNYp/lr2qpooes
         +/cmijXEFmkssaw+/hSaMCPTOHXnWLnPUSSxrj2SpLq/gLHWkb1wK6cg8bqAliVeXC78
         CC6376eZWV7LExuSm5cQtGkjKSyY8fN/4nPa3zITlLWmgodB200iD9aiXF2dQUOT8vMm
         7y/gx5/bcL2wnBKqBzc4nyxqjFTd+nMt9eRDtcunq6dJjEF8MfKTCNMZ8BrGAdmN+VFf
         H/Yw==
X-Gm-Message-State: AOAM5301sTbYye+10vSzSqgCgvx48/REuCN/WJMSRPwQMf5kJNUArXfn
        wofYrcS6lEfQtmU+XgGnwo7ySU8GGmJUbTIFG/Wa52Ef8YVqvsRq
X-Google-Smtp-Source: ABdhPJzGwWzYlxzYYy7PfHkXTzIriVVI1u8ynxXOLjoX2S/1Q3H1qril5E5G1YPvAhZ/h2vfhxHbBRj2QfFHhvcMHv0=
X-Received: by 2002:a05:6808:16a4:b0:2f7:1fd1:f48 with SMTP id
 bb36-20020a05680816a400b002f71fd10f48mr1500412oib.163.1650457052371; Wed, 20
 Apr 2022 05:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
 <20220419085607.2014-1-hdanton@sina.com> <20220419134616.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <CACT4Y+Y8Az3_gi-UX-KCfQ1dxARJtL1NhB1AGLv9o_5gNtkWOg@mail.gmail.com>
 <20220419164908.GM4285@paulmck-ThinkPad-P17-Gen-1> <20220419231820.2089-1-hdanton@sina.com>
In-Reply-To: <20220419231820.2089-1-hdanton@sina.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Apr 2022 14:17:21 +0200
Message-ID: <CACT4Y+YwP0Vvupn3QmQj9Ks4NV4hkBcc6gDQ7ro3_Dzy-benCg@mail.gmail.com>
Subject: Re: [PATCH rcu 04/11] kernel/smp: Provide boot-time timeout for CSD
 lock diagnostics
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
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

On Wed, 20 Apr 2022 at 01:18, Hillf Danton <hdanton@sina.com> wrote:
>
> On Tue, 19 Apr 2022 09:49:08 -0700 Paul E. McKenney wrote:
> > On Tue, Apr 19, 2022 at 04:11:36PM +0200, Dmitry Vyukov wrote:
> > > On Tue, 19 Apr 2022 at 15:46, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > On Tue, Apr 19, 2022 at 04:56:07PM +0800, Hillf Danton wrote:
> > > > > On Mon, 18 Apr 2022 15:53:52 -0700 Paul E. McKenney wrote:
> > > > > > Debugging of problems involving insanely long-running SMI handlers
> > > > > > proceeds better if the CSD-lock timeout can be adjusted.  This commit
> > > > > > therefore provides a new smp.csd_lock_timeout kernel boot parameter
> > > > > > that specifies the timeout in milliseconds.  The default remains at the
> > > > > > previously hard-coded value of five seconds.
> > > > > >
> > > > > > Cc: Rik van Riel <riel@surriel.com>
> > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > Cc: Ingo Molnar <mingo@kernel.org>
> > > > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > > > > Cc: Juergen Gross <jgross@suse.com>
> > > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > > ---
> > > > > >  Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
> > > > > >  kernel/smp.c                                    |  7 +++++--
> > > > > >  2 files changed, 16 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > > > index 3f1cc5e317ed..645c4c001b16 100644
> > > > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > > > @@ -5377,6 +5377,17 @@
> > > > > >     smart2=         [HW]
> > > > > >                     Format: <io1>[,<io2>[,...,<io8>]]
> > > > > >
> > > > > > +   smp.csd_lock_timeout= [KNL]
> > > > > > +                   Specify the period of time in milliseconds
> > > > > > +                   that smp_call_function() and friends will wait
> > > > > > +                   for a CPU to release the CSD lock.  This is
> > > > > > +                   useful when diagnosing bugs involving CPUs
> > > > > > +                   disabling interrupts for extended periods
> > > > > > +                   of time.  Defaults to 5,000 milliseconds, and
> > > > > > +                   setting a value of zero disables this feature.
> > > > > > +                   This feature may be more efficiently disabled
> > > > > > +                   using the csdlock_debug- kernel parameter.
> > > > > > +
> > > > >
> > > > > Can non-responsive CSD lock detected trigger syzbot (warning) report?
> > > >
> > > > If they enable it by building with CONFIG_CSD_LOCK_WAIT_DEBUG=y, yes.
> > >
> > > +syzkaller mailing list
> > >
> > > Currently we don't enable CONFIG_CSD_LOCK_WAIT_DEBUG in syzbot configs.
> > > Is it a generally useful debugging feature recommended to be enabled
> > > in kernel testing systems?
> >
> > With the default value for smp.csd_lock_timeout, it detects CPUs that have
> > had interrupts disabled for more than five seconds, which can be useful
> > for detecting what would otherwise be silent response-time failures.
>
> The five seconds take precedence over the 143s in reports [1] IMO.
> The shorter timeout helps select reproducers which in turn help find answer
> to questions there.


I've sent https://github.com/google/syzkaller/pull/3090 to enable the config.
5 seconds won't be reliable, I've set it to 100s to match CPU stall timeout.



> Hillf
>
> [1] https://lore.kernel.org/lkml/20220321210140.GK4285@paulmck-ThinkPad-P17-Gen-1/
>
> >
> > > If we enabled it, we also need to figure out where it fits into the
> > > timeout hierarchy and adjust smp.csd_lock_timeout:
> > > https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/x86_64.yml#L15-L40
> >
> > On this, I must defer to you guys.  I can say that the larger the value
> > that you choose for smp.csd_lock_timeout, the nearer the beginnning of
> > that group it should go, but you guys knew that already.  ;-)
> >
> >                                                         Thanx, Paul
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller/20220419231820.2089-1-hdanton%40sina.com.
