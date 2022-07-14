Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F846575739
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbiGNVvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiGNVvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:51:41 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D9F419A6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:51:39 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-31cac89d8d6so30714647b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Is95C/L9u8P2TPO36yk8p8lfgnPVB5nyDTTX5guyjaU=;
        b=XIkoxh/9JOyfuHjAx7KJIMcBXGxB9e2PCqXf7smuLG4iFkGU8wl0JKd5uqPjcZ0lmu
         MddxyS6x/VAQ+Py6fvej3tqqwuvp5zS5bWwzGtDD/xM+ptQwgRk2Ft45f6Pp+xmxEy00
         LBj9LxTHOeAtk+QcHPKEwGYfaODCTflH7xTVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Is95C/L9u8P2TPO36yk8p8lfgnPVB5nyDTTX5guyjaU=;
        b=j8+TjISbLdwnFZ4YFN8l+gyDqEJfOkP7AaD9r0fvDjVBOaPpup5Xmpj9tTfij1ZcH/
         UfpDkq9OvapfI1t9DlamS0e0Wq1zYJEvMt0WAE2vSiJYNffKa1j4mY09hcprEp99zCpQ
         34TC92qfaTy6zPg6SKL/0SjByNdePAerI/N3uE2ctMVbIv6KFZwr6nYZDAIobQoPpmW6
         6wrLt9+/wSYM8setwClb2UUsAOm8ko1i6Ks9sNVUF2+hCvbfGIrM4mr80dnTIaIvvrLM
         j9AomlqQ+3qOBr25cUaymG1+Pp0BBd19aEchJohrdfDqaAazNHUfo+d7YQm4gjH4Ue9y
         B/QQ==
X-Gm-Message-State: AJIora87okuyvoNi5gsJt/Pj9G+qMi7fCo+oS69ncA48nftrYExSRDke
        3o33RQFLbn1oIRqQUzYaEmiAvs8aQVO4RvVCSakf1Q==
X-Google-Smtp-Source: AGRyM1tCouO8shQx1D4/D7nmNdE9NSDbKg9yUp3w4dmDoXPXkBMBkN9F0iCrn/FEgA5dgZfulBxSjmA3qMyupeKRcKo=
X-Received: by 2002:a81:6054:0:b0:31c:97f4:b5c with SMTP id
 u81-20020a816054000000b0031c97f40b5cmr12384788ywb.432.1657835499055; Thu, 14
 Jul 2022 14:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220706205136.v2.1.Ic7a7c81f880ab31533652e0928aa6e687bb268b5@changeid>
 <CACeCKadV=k5J1ZSG+p8M5iBnX5nXrn-XnK62Nq_op2kJ68+-9w@mail.gmail.com> <CANkg5ewRc5zhBtxLhazo8Wsfa3Srj32AwZD9mD=W=Qqpqi7zJQ@mail.gmail.com>
In-Reply-To: <CANkg5ewRc5zhBtxLhazo8Wsfa3Srj32AwZD9mD=W=Qqpqi7zJQ@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 14 Jul 2022 14:51:28 -0700
Message-ID: <CACeCKaer_hacWmLDDMJSK-KFjxqiXV8S1-ydCWGT3mkQVeN-rg@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec: Send host event for prepare/complete
To:     Tim Van Patten <timvp@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, rrangel@chromium.org,
        robbarnes@google.com, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On Thu, Jul 14, 2022 at 1:55 PM Tim Van Patten <timvp@google.com> wrote:
>
> Hi,

Please avoid top-posting [1]

>
> We had issues measuring overall suspend and resume times, which this
> patch attempts to help resolve.   As stated in the description, the EC
> host command logs couldn't be used reliably, since they weren't
> generated at the start of suspend/end of resume, but instead at some
> point in the middle of the procedures.   This CL moves when the
> commands are sent from the AP to the EC to as early/late as possible
> in an attempt to deterministically capture as much of each process as
> possible.

If the timing of the EC host command logs is unreliable, why not add
new host commands specifically for this, and then call those at the moment(s)
you deem is more appropriate, instead of moving the suspend/resume itself
(which may be introducing its own timing ramifications)?

Calling such a theoretical new EC host command from the userspace power manager
would probably accomplish the same thing.

From the kernel documentation[2], "The prepare phase is meant to
prevent races by preventing new devices from being registered; the PM core
would never know that all the children of a device had been suspended if new
children could be registered at will." and "The method may also prepare the
device or driver in some way for the upcoming system power transition, but
it should not put the device into a low-power state."

So it seems like an incorrect usage of this callback.

>
> While this patch could potentially be split, both the logging and PM
> changes are means to the same end: improving logging behavior to make
> it easier for developers to measure suspend/resume time and aid in
> debugging.

That alone is not sufficient cause to combine 2 different changes into
a single patch.
The flip side is: the patch to move the suspend/resume host commands into
prepare/complete() can itself introduce regressions. We should be able to
revert that without touching the patch adding the logging (assuming concerns
regarding that are addressed).

BR,

-Prashant

[1] See "Top-posting" in https://people.kernel.org/tglx/
[2] https://kernel.org/doc/html/latest/driver-api/pm/devices.html#entering-system-suspend




> This will make it easier to bisect CLs in the event of
> regressions, as well as more deterministically verify optimizations
> and improvements.
>
> @Rob Barnes Please fill in any other gaps you think are relevant.
>
>
> On Thu, Jul 14, 2022 at 12:34 PM Prashant Malani <pmalani@chromium.org> wrote:
> >
> > HI Tim,
> >
> > On Wed, Jul 6, 2022 at 7:51 PM Tim Van Patten <timvp@google.com> wrote:
> > >
> > > Update cros_ec_lpc_pm_ops to call cros_ec_lpc_suspend() during PM
> > > .prepare() and cros_ec_lpc_resume() during .complete. This allows the
> > > EC to log entry/exit of AP's suspend/resume more accurately.
> > >
> > > Signed-off-by: Tim Van Patten <timvp@google.com>
> > > ---
> > >
> > > Changes in v2:
> > > - Include cros_ec_resume() return value in dev_info() output.
> > > - Guard setting .prepare/.complete with #ifdef CONFIG_PM_SLEEP.
> > >
> > >  drivers/platform/chrome/cros_ec_lpc.c | 14 +++++++++++---
> > >  1 file changed, 11 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> > > index 7677ab3c0ead9..ce49fbc4ed2e1 100644
> > > --- a/drivers/platform/chrome/cros_ec_lpc.c
> > > +++ b/drivers/platform/chrome/cros_ec_lpc.c
> > > @@ -534,19 +534,27 @@ static int cros_ec_lpc_suspend(struct device *dev)
> > >  {
> > >         struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
> > >
> > > +       dev_info(dev, "Prepare EC suspend\n");
> >
> > This patch is doing 2 things:
> > 1. Changing the timing of cros_ec_lpc_suspend()/resume() invocation.
> > 2. Adding print logs for these callbacks.
> >
> > Whether 2.) is necessary is already being discussed, so I won't
> > comment on that, but it sounds
> > like this should be 2 different patches.
> >
> > Also, please explain what is wrong with "Previously, those events were sent when
> > suspend/resume were already in progress." IOW, what issue is this
> > solving, besides
> > better ordering of EC logs.
> >
> > BR,
> >
> > -Prashant
>
>
>
> --
>
> Tim Van Patten | ChromeOS | timvp@google.com | (720) 432-0997
