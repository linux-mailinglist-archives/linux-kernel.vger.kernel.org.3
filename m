Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4544157B723
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiGTNQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiGTNQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:16:00 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7B02AB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:15:58 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id z3so2570324plb.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lRJzGTSvek7GJtqjVxkMPUXoL7u0ATvi3E1mmuy/3CU=;
        b=NDFCsQeOJ/AVUlPdU66yqPvBBfdC098ZJOUY2vdeSSV87HzuDcrHny9IiKqYJSiBOK
         PDe59Hlm++/a6H0ZXfzDDznnepCs0jd2CYRXHThMCPro3NB+jQusN6cGcAhrigGA0MfP
         LsmdMyFHQPxBvoiDQfdkhxIr17xbBo73a8bwE0i+3X9CR7HHlcNNGIX3M/NTF1XBTkOY
         zoTconFuiKZBgKTmDdm4XKy5HFwtCpy8yCMGsAAu9hTdKa5XxeWFNRkfcZhjKmk6pOGY
         tqGCHbhXky68/cm4y/btYpMjE03B4EtBBcP9DwkmKfnLgHC6cVW+Jvr5nYTAKjtoj1ya
         4C1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lRJzGTSvek7GJtqjVxkMPUXoL7u0ATvi3E1mmuy/3CU=;
        b=KYSk1yGcJw9o4+MHJS0qLez4KKmtnSOisa4zZO4dev6ht7bn8+058vL8sPni52oS+l
         r/dPInmUb9rspTUlnbiTkwfo9k+e7SVfdP/Trm0pTnbb5WnwXJUnAUOu2mbcF4wn/psQ
         Gbi5FK08QAdUHDxYkgyQDT6oio+G9gMR9XZLu6tXEu3qvL+oiHtPt8b3lHFkYPHYBjsH
         uwFjmvpFPpNMeIQfGAa4w41dcs6j22DGI+oIH63CIbUfxf+JDDzUn5xPGnVCiDCMVH9u
         5wMayPXSBbZXrma5vUxlPWRelqdiX3M4ocFmBdZekemvzxCEYk5YptSnWEieSqOR1NGa
         qRng==
X-Gm-Message-State: AJIora9/gMvLfUnJhwahr0R9Yq0PDZhvIxBOAol9ujkhk1T+8Q8E/8Ei
        hx2uaDurFjl94SKq1HD9eNju/YC66uba3htsgaV4nQ==
X-Google-Smtp-Source: AGRyM1sXpFAFNacWkhLEpkPvcyT2szo8ybUzxnY+mhcIJN1snIgeXra8sHiN97Kgr7nTponT8K8oaVcVzopirG9hgWM=
X-Received: by 2002:a17:902:da89:b0:16c:49ee:9e71 with SMTP id
 j9-20020a170902da8900b0016c49ee9e71mr38184677plx.71.1658322958318; Wed, 20
 Jul 2022 06:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220707125329.378277-1-jaz@semihalf.com> <20220707125329.378277-2-jaz@semihalf.com>
 <CAJZ5v0gdCN3P52ko44LQMqWJvDArHxZ7p4aSiQamML7aG_kRAA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gdCN3P52ko44LQMqWJvDArHxZ7p4aSiQamML7aG_kRAA@mail.gmail.com>
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
Date:   Wed, 20 Jul 2022 15:15:47 +0200
Message-ID: <CAH76GKO9sxnuLM--x6sg7m3bC_NgvLA94N6jHA-+5gW741-ByQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] suspend: extend S2Idle ops by new notify handler
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmytro Maluka <dmy@semihalf.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Dominik Behr <dbehr@google.com>, upstream@semihalf.com,
        Zide Chen <zide.chen@intel.corp-partner.google.com>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sachi King <nakato@nakato.io>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:HIBERNATION (aka Software Suspend, aka swsusp)" 
        <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 19 lip 2022 o 20:09 Rafael J. Wysocki <rafael@kernel.org> napisa=C5=82=
(a):
>
> On Thu, Jul 7, 2022 at 2:56 PM Grzegorz Jaszczyk <jaz@semihalf.com> wrote=
:
> >
> > Currently the LPS0 prepare_late callback is aimed to run as the very
> > last thing before entering the S2Idle state from LPS0 perspective,
> > nevertheless between this call and the system actually entering the
> > S2Idle state there are several places where the suspension process coul=
d
> > be canceled.
>
> And why is this a problem?
>
> The cancellation will occur only if there is a wakeup signal that
> would otherwise cause one of the CPUs to exit the idle state.  Such a
> wakeup signal can appear after calling the new notifier as well, so
> why does it make a difference?

It could also occur due to suspend_test. Additionally with new
notifier we could get notification when the system wakes up from
s2idle_loop and immediately goes to sleep again (due to e.g.
acpi_s2idle_wake condition not being met) - in this case relying on
prepare_late callback is not possible since it is not called in this
path.

>
> > In order to notify VMM about guest entering suspend, extend the S2Idle
> > ops by new notify callback, which will be really invoked as a very last
> > thing before guest actually enters S2Idle state.
>
> It is not guaranteed that "suspend" (defined as all CPUs entering idle
> states) will be actually entered even after this "last step".

Since this whole patchset is aimed at notifying the host about a guest
entering s2idle state, reaching this step can be considered as a
suspend "entry point" for VM IMO. It is because we are talking about
the vCPU not the real CPU. Therefore it seems to me, that even if some
other vCPUs could still get some wakeup signal they will not be able
to kick (through s2idle_wake->swake_up_one(&s2idle_wait_head);) the
original vCPU which entered s2idle_loop, triggered the new notifier
and is halted due to handling vCPU exit (and was about to trigger
swait_event_exclusive). So it will prevent the VM's resume process
from being started.

>
> > Additionally extend the acpi_s2idle_dev_ops by notify() callback so
> > any driver can hook into it and allow to implement its own notification=
.
> >
> > Taking advantage of e.g. existing acpi_s2idle_dev_ops's prepare/restore
> > hooks is not an option since it will not allow to prevent race
> > conditions:
> > - VM0 enters s2idle
> > - host notes about VM0 is in s2idle
> > - host continues with system suspension but in the meantime VM0 exits
> > s2idle and sends notification but it is already too late (VM could not
> > even send notification on time).
>
> Too late for what?

Too late to cancel the host suspend process, which thinks that the VM
is in s2idle state while it isn't.

>
> > Introducing notify() as a very last step before the system enters S2Idl=
e
> > together with an assumption that the VMM has control over guest
> > resumption allows preventing mentioned races.
>
> How does it do that?

At the moment when VM triggers this new notifier we trap on MMIO
access and the VMM handles vCPU exit (so the vCPU is "halted").
Therefore the VMM could control when it finishes such handling and
releases the vCPU again.

Maybe adding some more context will be helpful. This patchset was
aimed for two different scenarios actually:
1) Host is about to enter the suspend state and needs first to suspend
VM with all pass-through devices. In this case the host waits for
s2idle notification from the guest and when it receives it, it
continues with its own suspend process.
2) Guest could be a "privileged" one (in terms of VMM) and when the
guest enters s2idle state it notifies the host, which in turn triggers
the suspend process of the host.

>
> It looks like you want suspend-to-idle to behave like S3 and it won't.

In a way, yes, we compensate for the lack of something like PM1_CNT to
trap on for detecting that the guest is suspending.
We could instead force the guest to use S3 but IMO it is undesirable,
since it generally does make a difference which suspend mode is used
in the guest, s2idle or S3, e.g some drivers check which suspend type
is used and based on that behaves differently during suspend. One of
the example is:
https://elixir.bootlin.com/linux/v5.18.12/source/drivers/gpu/drm/amd/amdgpu=
/amdgpu_drv.c#L2323
https://elixir.bootlin.com/linux/v5.18.12/source/drivers/gpu/drm/amd/amdgpu=
/amdgpu_acpi.c#L1069
https://elixir.bootlin.com/linux/v5.18.12/source/drivers/gpu/drm/amd/amdgpu=
/amdgpu_gfx.c#L583

Thank you,
Grzegorz








>
> > Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> > ---
> >  drivers/acpi/x86/s2idle.c | 11 +++++++++++
> >  include/linux/acpi.h      |  1 +
> >  include/linux/suspend.h   |  1 +
> >  kernel/power/suspend.c    |  4 ++++
> >  4 files changed, 17 insertions(+)
> >
> > diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> > index 2963229062f8..d5aff194c736 100644
> > --- a/drivers/acpi/x86/s2idle.c
> > +++ b/drivers/acpi/x86/s2idle.c
> > @@ -520,10 +520,21 @@ void acpi_s2idle_restore_early(void)
> >                                         lps0_dsm_func_mask, lps0_dsm_gu=
id);
> >  }
> >
> > +static void acpi_s2idle_notify(void)
> > +{
> > +       struct acpi_s2idle_dev_ops *handler;
> > +
> > +       list_for_each_entry(handler, &lps0_s2idle_devops_head, list_nod=
e) {
> > +               if (handler->notify)
> > +                       handler->notify();
> > +       }
> > +}
> > +
> >  static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 =3D {
> >         .begin =3D acpi_s2idle_begin,
> >         .prepare =3D acpi_s2idle_prepare,
> >         .prepare_late =3D acpi_s2idle_prepare_late,
> > +       .notify =3D acpi_s2idle_notify,
> >         .wake =3D acpi_s2idle_wake,
> >         .restore_early =3D acpi_s2idle_restore_early,
> >         .restore =3D acpi_s2idle_restore,
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 4f82a5bc6d98..b32c4baed99b 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -1068,6 +1068,7 @@ struct acpi_s2idle_dev_ops {
> >         struct list_head list_node;
> >         void (*prepare)(void);
> >         void (*restore)(void);
> > +       void (*notify)(void);
> >  };
> >  int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
> >  void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
> > diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> > index 70f2921e2e70..16ef7f9d9a03 100644
> > --- a/include/linux/suspend.h
> > +++ b/include/linux/suspend.h
> > @@ -191,6 +191,7 @@ struct platform_s2idle_ops {
> >         int (*begin)(void);
> >         int (*prepare)(void);
> >         int (*prepare_late)(void);
> > +       void (*notify)(void);
> >         bool (*wake)(void);
> >         void (*restore_early)(void);
> >         void (*restore)(void);
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index 827075944d28..6ba211b94ed1 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -100,6 +100,10 @@ static void s2idle_enter(void)
> >
> >         /* Push all the CPUs into the idle loop. */
> >         wake_up_all_idle_cpus();
> > +
> > +       if (s2idle_ops && s2idle_ops->notify)
> > +               s2idle_ops->notify();
> > +
> >         /* Make the current CPU wait so it can enter the idle loop too.=
 */
> >         swait_event_exclusive(s2idle_wait_head,
> >                     s2idle_state =3D=3D S2IDLE_STATE_WAKE);
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
> >
