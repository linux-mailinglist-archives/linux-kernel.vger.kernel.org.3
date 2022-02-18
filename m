Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551584BAF1B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 02:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiBRBPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 20:15:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiBRBPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 20:15:52 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2481DE0DF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 17:15:36 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id i11so11072099eda.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 17:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zXsV9Jyymt/nwWGz9uZH/Iyco0WvTORuBxKnSlfp7oI=;
        b=fU7BSnpLXBWOmmJoPAQivNE61esLhIPWkcQSJN442i6y0CnA8vPWiCBUOhyZVVrFcl
         /3ClDPpjDOV7nMrns2LdUOmMxzUjucYb9djwOGt5LJ084myH9UndfcSzwBWlAOgVYhZK
         4mnTuH275zrnEqc46QD/M3WvlknwEAuoGrQtKOzAbhBPTWSDYMibuSuHmk6Qv4KIP8I1
         OsiFgTd4xpGRECf9h3k2YIsqNJRft1rvoBtR2OyM+NwFSxT5+4UnCoDNbujuFDIAs9lG
         9R0/G9+ONnZ3vMhxa8oAjjSVj+u15vZHga6QQKy2Q9W6OdyQy5R1Q6WanC3mJ4kLBdyb
         Tl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXsV9Jyymt/nwWGz9uZH/Iyco0WvTORuBxKnSlfp7oI=;
        b=mD5FiQFPHYBS56vFxA2vn+/joMqeQ5k0oBETmIkZb4kDLzWupC3m1J7Z4xUydU7HZ2
         MB9tHuGaGoC7/GpzKNl75g9Qy61+cJ5tJg3kmzfohB1OtRpM12MBwyKixfYj4e4dMfjj
         E6a8Aw9qEkG/b3SSBVta2wZ9TQvHTlxfbJBpCiaIR+WgZ/cIaxLxYAf/HpK98LUdl5Cg
         azRozaV4smfqlVI8d4e6Ev3kAgUB0RPdDvrUdYI7/RQ2xy4umDAzPxFk8jJGsw2OYs2o
         pDzIcigk2cCf7ZZrG62m6Hgh6Z5NUJkz/Z98w5cMEhGYD2YzwIrairEkCjZJw+xat0f6
         2h3Q==
X-Gm-Message-State: AOAM5314nf881CBwUWPvcwrlXWh/FXfN1XrPOeLvNudbK8Gz4RLwkqrN
        SJn8/mfq09BovxA6yVtF/GIs9h1Yh3eyxUc+XUgzzA==
X-Google-Smtp-Source: ABdhPJzqSlqqE671jWYBd/RfHL4WSjO11rG3Hna0rwlH1kjD+XEZ8FoFQSZah7KJ2HbJk8lrYSzXW026FUjvKZjO0Jk=
X-Received: by 2002:a50:c446:0:b0:40f:612b:e294 with SMTP id
 w6-20020a50c446000000b0040f612be294mr5572359edf.240.1645146934306; Thu, 17
 Feb 2022 17:15:34 -0800 (PST)
MIME-Version: 1.0
References: <20220211023008.3197397-1-wonchung@google.com> <CAJZ5v0gD4zs3uBAYv6M4_1gNpkZ-g9XKOywJnf5007e6GwoGVA@mail.gmail.com>
 <CAOvb9yjpruiHxkZyZ8BOT0Hi_iV7xMOnBCr59BZX3eah_Zcy_w@mail.gmail.com>
 <CAOvb9yh7jo27NH32tbAOtkJrnC9LwUFgFbHRbdbArwiU+YSmdw@mail.gmail.com>
 <Ygt9B6+0b1hIBr5a@kuha.fi.intel.com> <CAJZ5v0hVZ1a9krnfW=ogdi+bpOpGDPvT12NxdstRRWjhNi+v3g@mail.gmail.com>
 <YgzhRgPD/eBw6UU3@kuha.fi.intel.com> <CAJZ5v0gQnbYv15EKXhicwHM5+Kp9sjv1QyscxagiC7isn-p1WA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gQnbYv15EKXhicwHM5+Kp9sjv1QyscxagiC7isn-p1WA@mail.gmail.com>
From:   Won Chung <wonchung@google.com>
Date:   Thu, 17 Feb 2022 17:15:23 -0800
Message-ID: <CAOvb9yhGMtA2+jzQ5KxBRDDtASQfA3BPxnHhCrgd_8E4umtiig@mail.gmail.com>
Subject: Re: [PATCH v6] ACPI: device_sysfs: Add sysfs support for _PLD
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <greg@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 8:39 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Feb 16, 2022 at 12:34 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Tue, Feb 15, 2022 at 02:54:11PM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Feb 15, 2022 at 11:14 AM Heikki Krogerus
> > > <heikki.krogerus@linux.intel.com> wrote:
> > > >
> > > > On Mon, Feb 14, 2022 at 02:58:44PM -0800, Won Chung wrote:
> > > > > On Mon, Feb 14, 2022 at 12:30 PM Won Chung <wonchung@google.com> wrote:
> > > > > >
> > > > > > On Mon, Feb 14, 2022 at 11:12 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > > >
> > > > > > > On Fri, Feb 11, 2022 at 3:30 AM Won Chung <wonchung@google.com> wrote:
> > > > > > > >
> > > > > > > > When ACPI table includes _PLD fields for a device, create a new
> > > > > > > > directory (pld) in sysfs to share _PLD fields.
> > > > > > >
> > > > > > > This version of the patch loos better to me, but I'm not sure if it
> > > > > > > goes into the right direction overall.
> > > > > > >
> > > > > > > > Currently without PLD information, when there are multiple of same
> > > > > > > > devices, it is hard to distinguish which device corresponds to which
> > > > > > > > physical device in which location. For example, when there are two Type
> > > > > > > > C connectors, it is hard to find out which connector corresponds to the
> > > > > > > > Type C port on the left panel versus the Type C port on the right panel.
> > > > > > >
> > > > > > > So I think that this is your primary use case and I'm wondering if
> > > > > > > this is the best way to address it.
> > > > > > >
> > > > > > > Namely, by exposing _PLD information under the ACPI device object,
> > > > > > > you'll make user space wanting to use that information depend on this
> > > > > > > interface, but the problem is not ACPI-specific (inevitably, it will
> > > > > > > appear on systems using DT, sooner or later) and making the user space
> > > > > > > interface related to it depend on ACPI doesn't look like a perfect
> > > > > > > choice.
> > > > > > >
> > > > > > > IOW, why don't you create a proper ABI for this in the Type C
> > > > > > > subsystem and expose the information needed by user space in a generic
> > > > > > > way that can be based on the _PLD information on systems with ACPI?
> > > > > >
> > > > > > Hi Rafael,
> > > > > >
> > > > > > Thank you for the review.
> > > > > >
> > > > > > I was thinking that _PLD info is specific to ACPI since it is part of
> > > > > > the ACPI table. Could you explain a little bit more on why you think
> > > > > > exposing _PLD fields is not an ACPI-specific problem?
> > > > >
> > > > > Hi Rafael again,
> > > > >
> > > > > Sorry for the silly question here. I misunderstood your comment a bit,
> > > > > but I talked to Benson and Prashant for clarification. I understand
> > > > > now what you mean by it is not an ACPI-specific problem and exposing
> > > > > PLD would depend on ACPI.
> > > > >
> > > > > >
> > > > > > I gave an example of how _PLD fields can be used for specifying Type C
> > > > > > connectors, but it is not Type C specific. For Chrome OS, we plan to
> > > > > > initially add PLD to not only Type C connectors but also USB port
> > > > > > devices (including Type C and Type A). Also, PLD can be used in the
> > > > > > future for describing other types of ports too like HDMI. (Benson and
> > > > > > Prashant, please correct or add if I am wrong or missing some
> > > > > > information) Maybe my commit message was not detailed enough..
> > > > > >
> > > > > > I am also curious what Heikki thinks about this. Heikki, can you take
> > > > > > a look and share your thoughts?
> > > > >
> > > > > I am still curious what you and Heikki think about this since it may
> > > > > not be a Type C specific issue. We can start from adding generic
> > > > > location info to Type C subsystem first, as you suggested, then
> > > > > consider how to do the same for USB devices and Type A ports
> > > > > afterwards. I would appreciate sharing any thoughts or feedback. Thank
> > > > > you very much!
> > > >
> > > > Like you said, _PLD is not Type-C specific. We can't limit it to any
> > > > specific device class. For example, I'm pretty sure that sooner or
> > > > later we want to get this information in user space also with camera
> > > > sensors, and probable with a few other things as well.
> > > >
> > > > I think the question here is, can we create a some kind of an
> > > > abstraction layer for the user space that exposes the device location
> > > > details in generic Linux specific way - so with ACPI it would utilise
> > > > the _PLD, and with DT something else (today AFAIK DT does not have
> > > > any way to describe locations of the devices). Maybe I'm wrong?
> > >
> > > No, you aren't.
> > >
> > > > But if that is the question, then IMO the answer is: maybe one day,
> > > > but not today,
> > >
> > > Why not?
> > >
> > > > and even if we one day can come up with something like
> > > > that, we still should expose the _PLD as ACPI specific information to
> > > > the user space as is.
> > >
> > > Why would it need that information in this particular format?
> > >
> > > > Even if one day we have common sysfs attributes for all the devices
> > > > that contain the location of the device in some form, those attributes
> > > > will almost certainly have only a sub-set of the _PLD details, a
> > > > sub-set that works also with DT.
> > >
> > > That doesn't have to be the case.
> > >
> > > However, things linke cpuidle have been invented to provide user space
> > > interfaces for features that previously were only available on systems
> > > with ACPI.  Why is _PLD different?
> > >
> > > > IMO the user space should always have access to all the necessary _PLD
> > > > details in their raw form if needed, even if those common device
> > > > location attributes exist - duplicated information or not.
> > >
> > > Again, why would it need that information?
> >
> > We don't know if we'll need that in the future, and that's the point.
>
> Well, for me that would be a good enough reason for avoiding to expose it.
>
> If there is no particular reason for exposing any information to user
> space, I don't see why it should be exposed at all.
>
> There is some cost of exposing things to user space, so why pay it for
> no benefit?
>
> > > > And debugfs
> > > > unfortunately is also not OK for that, because the user space needs to
> > > > be able to also rely on access to the additional details if needed.
> > >
> > > What additional details do you mean?
> > >
> > > > We can limit the _PLD fields that we expose to the ones that we know
> > > > we need today (and probable should limit them to those), and we can of
> > > > course have a Kconfig option for the _PLD sysfs information if we want
> > > > to, but let's not start this by trying to figure out what kind of
> > > > abstraction we want for this. Right now we simply can not do that.
> > >
> > > Why can't we?
> >
> > Right now we can't say for sure if DT can even supply the details that
> > we need from _PLD. I don't think we can at the moment even say are the
> > DT guys willing to support this at all.
> >
> > To play it safe, I would just supply the needed _PLD fields as part of
> > the ACPI device nodes (under /sys/bus/acpi).
>
> That would be suboptimal for a few reasons:
>
> 1. The interface is potentially confusing.  User space would first
> need to locate the ACPI device interface corresponding to the given
> "real" device in order to use that information.
> 2. It doesn't scale beyond ACPI.
> 3. From the ACPI subsystem's perspective the choice of the "relevant"
> _PLD fields is arbitrary and exposing all of them is overkill for any
> use cases known to me.
> 4. The ACPI subsystem doesn't know the devices for which _PLD
> information should be exposed and there are some devices for which it
> is just not useful.
>
> > There we can guarantee
> > that we'll always be able to supply all the information in the _PDL if
> > needed. Since we would add these to the ACPI nodes, it would be
> > crystal clear to the userspace that this information is only available
> > on ACPI platforms.
>
> I'm not considering this as a feature.
>
> > Then if, and only if, we know that DT can supply the same information
> > (at least to some of it) I would start thinking about the alternative
> > interface to this information that we make part of the actual devices.
> > Since at this point we have already the primary ACPI specific
> > interface to this same information that guarantees that it can supply
> > all the details if necessary, we don't have to worry about having to
> > be able to do the same with this new interface. This interface can
> > just expose the common details that we know for sure that both ACPI
> > and DT can always supply.
>
> Well, there is another possible approach: Expose the information
> needed to address a particular use case in a way that doesn't strictly
> depend on ACPI and make this use ACPI as a backend.  Don't worry about
> the DT side of things.  If the generic interface is there and it is
> suitable enough, DT will be in the receiving end position with much
> less of a freedom to introduce a new interface for the same purpose.
>
> On the other hand, if _PLD information is exposed in an ACPI-specific
> way, it is almost guaranteed that there will be a DT-specific
> interface for the same thing and utilities wanting to be generic will
> need to support both of them which will be extra pain.  Some of them
> will choose to support the DT-specific interface only and we'll end up
> with utilities that can't be used on ACPI-based systems because of
> incompatible interfaces.  Been there already.  Thanks, but no thanks!

Hi Rafael,

Thank you for the feedback. If we add a generic location to type c
connector, would you suggest we do something similar to other devices
that would use PLD information? (like USB devices, HDMI ports, and so
on) Also, I am curious what you think about how to add generic
locations for Type A ports which I believe do not have connectors like
Type C. I would appreciate it if anyone can share any ideas. Thank you
very much!

Won
