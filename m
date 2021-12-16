Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0862477662
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhLPPwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:52:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48695 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230358AbhLPPwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639669952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zu3j2FVXDiktdfEB46lEm/u6oaFAHWC3ABCIi1VCxYs=;
        b=UHgKGGDeWn+dss2dy6GJWmy1jhKz3g/GkHb7s+VRm8tTBUtp0zh05EerKHriGdiqhgYlvc
        58hB84nV1uOOEwoZMuk/xNaRqtdbc9mmTUIJyL3He6Lmhp6vH+O6kASzgTvKL+lC9y0nmP
        d/d34E19YYUVFdWb/I0o5yKulXg4kuM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-1ivgSxesMwm-YJpdUC6BTQ-1; Thu, 16 Dec 2021 10:52:31 -0500
X-MC-Unique: 1ivgSxesMwm-YJpdUC6BTQ-1
Received: by mail-pj1-f70.google.com with SMTP id t7-20020a17090a5d8700b001a7604b85f5so14144523pji.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:52:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zu3j2FVXDiktdfEB46lEm/u6oaFAHWC3ABCIi1VCxYs=;
        b=TIrUq4eULXO5i+cEpjkquAr4rhssaiCqyMz6CFLzhYqeyCcykyljyFL9GAAWEeAJl1
         bm6j17Jx5wL5Bsel+jb6zCF2D2ZQllgsHsPbBjFDaRUznDO3V1Q1auUysnwGIV9Wsq4v
         C1A+bKrxJEBOKFuhIiyEAu91FLa4xLh6FU5FhJfCaytFx9AIMjOz/4nHXxjsxKUtrVet
         FFa7te3ghuzlfwmJJEg9ljg+Y1+qvxxDnWklB/O4iZeglVw/0BUVzsQXrWw0A81jA4a9
         iJEGGQI1xJCn7uAFN6anyVW808qGWK0l6cABazouV35Cvz+IYi2zD4wmbQVABNwSjnwI
         qnpQ==
X-Gm-Message-State: AOAM533kn3m4wKuI7f3Gb6d1GDd8w075AgNDIoDX7TZPE3wCQMprHF0n
        QbDf5A3H/uuGAWuPdChPKXFwj15W1dV9xFLHLD2Y2VDZNgFXv44SChyvoaVumBMnUKPWH5gX6wF
        5l70hdupjJmJkaaeAvcL4/4+7Pm1KjUIftUEbW2bP
X-Received: by 2002:a17:902:ecc9:b0:142:f90:f4a1 with SMTP id a9-20020a170902ecc900b001420f90f4a1mr17076502plh.73.1639669950613;
        Thu, 16 Dec 2021 07:52:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyV4j9seQoEP2BunFy8c3hyFc0uA2irhDI3LAlmuY/AbAVtQ+EtNarfvZJIsK2kOFnt7tmirk0WgRvZF1ofTCY=
X-Received: by 2002:a17:902:ecc9:b0:142:f90:f4a1 with SMTP id
 a9-20020a170902ecc900b001420f90f4a1mr17076462plh.73.1639669950196; Thu, 16
 Dec 2021 07:52:30 -0800 (PST)
MIME-Version: 1.0
References: <20211215134220.1735144-1-tero.kristo@linux.intel.com>
 <CAO-hwJ+nm3jUo9znsROjc0=e_3aGOq-L43OVvUHwBewtwODJfA@mail.gmail.com> <813c7709-e8f8-85ce-9868-3e850f65d651@linux.intel.com>
In-Reply-To: <813c7709-e8f8-85ce-9868-3e850f65d651@linux.intel.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 16 Dec 2021 16:52:18 +0100
Message-ID: <CAO-hwJL6gj++gTz+pFyfxbRTB9ncVsBAyAcwyPrvC+=VYgj8BQ@mail.gmail.com>
Subject: Re: [RFCv5 0/2] HID: Add USI support
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 1:28 PM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>
> Hi Benjamin,
>
> On 16/12/2021 12:36, Benjamin Tissoires wrote:
> > Hi Tero,
> >
> > On Wed, Dec 15, 2021 at 2:42 PM Tero Kristo <tero.kristo@linux.intel.com> wrote:
> >> Hi,
> >>
> >> These two patches add the missing pieces for HID USI support. First one
> >> adds the HID core changes to support the new Misc events for pen ID,
> >> line color and line style. The second patch adds a BPF program on top of
> >> the HID-BPF driver which adds support for writing the Pen parameters
> >> from userspace, and to add filtering of HID low level events for ELAN
> >> USI controller. The BPF programs are not built by the kernel as of now
> >> (there are no Makefile changes), as there is a plan to most likely
> >> integrate these to a kernel external repository. I have tested these in
> >> my own external build setup though, and I can provide the makefile for
> >> that if needed. Also a sample client program is provided for
> >> communicating with the D-BUS server.
> > I had a deeper look at the recordings, and I am very worried in what I
> > am seeing:
> > - the USI parameters seems to be transmitted only after the touch
> Yes, they don't get updated before the pen touches the screen.

Looking at the logs you provided, and when you switch pens, it seems
the serial number in the Elan case is updated while hovering (but it
takes 3 seconds to get to that point).
Also, the first time you hovered the pen, the inrange slot was not
long enough to be 3 seconds, so maybe that's the time the controller
needs to manually update the information.

OTOH, on the Goodix one, if you initiated the GET_REPORT after the
first touch, the information came in a few ms.

So I wonder, what if you take the BPF program from the goodix and
start querying the information as soon as the pen is hovering in the
Elan case. Would that accelerate the time it fetches them?

> > - the USI parameters takes *a lot* of time to be transmitted (2 bytes
> > every 2 reports)
> Yes, there appears to be a very large latency when they are transmitted
> from the pen to controller. Apparently the controller queries each
> parameter from the pen individually and caches the received values
> internally, and then passes these out via input reports.

And of course, Goodix doesn't even bother with the serial number.

> > - the recording of the goodix one starts with a stylus touch without hovering
> This is a glitch I think, I'll capture a new log.
> > - the only "reliable" information we get when hovering seems to be the
> > transducer index
>
> Yes, however even this one is a static constant of "1" for the current
> controllers.

Ouch. Well, that also means that this is used as an index and if the
controller were to support more than a pen, the index would be 2 for
the second pen when the first is touching...
So this is not reliable for now, but is consistent with a multi-pen scenario.

>
>
> >
> > So I am wondering a few things:
> > - what happens when you switch between pens?
> >    * Do we immediately get a different transducer index?
> No, the transducer index gets re-allocated, effectively the first pen is
> going to use transducer index 1, and the second pen is going to re-use
> that and still report it as 1. This is a highly annoying feature.

Well, that also means that we can ignore this field until we see
controllers capable of handling more than one pen.

> >    * Are the values right there or do they also take time to be updated?
> They take time to update. If you are using the same pen, the values are
> retained in the cache and report correct values immediately, but if you
> switch pens, they start updating with the same latency as initial pen touch.

That is worrying. The serial number is also cached and we don't know
if we are using the same pen or not way too long after the pen touched
the surface.


> > - on the goodix one, do you still need to issue a get_report on the
> > feature to get the USI parameters, even when you change the pen?
>
> Yes, goodix reports 0xff,0xff,0x77 for the parameters until a GET_REPORT
> is issued, after which it notices the parameter that was queried has
> changed and updates its cached value. Also, see how it reports 0x77,
> instead of an index to the usages array.

The 0x77 doesn't bother me too much. This should not trigger an input
event because we are out of the usage range.

>
>
> >
> > Could you give me the following recording (with an updated hid-tools
> > master branch):
> > - on the Elan:
> >    * start the recording from a fresh boot (no BPF loaded)
> >    * hover for a few secs the first USI pen you have
> >    * touch it for a few secs
> >    * release, then out of proximity
> >    * approach the other pen
> >    * touch
> >    * release, out of prox
> >    * then once again with the first pen
> >    * then once again with the second pen
> >
> > - on the goodix: same thing
> >
> > - on the goodix: same thing but with a BPF program to trigger the
> > GET_REPORT if you can cook one quickly (not a big issue if you can
> > not).
> >
> > The reason I am asking about those recordings is because with the 2
> > logs you kindly provided, there is no way we can forward the raw
> > information to userspace. So I am slightly tempted to only rely on a
> > USI manager, in the form of the BPF program in 2/2 to transmit that
> > information to userspace.
> >
> > If this is bulky just for the first event, then the input events might
> > be OK, we can assume when the application needs those events they will
> > be there.
>
> See attached tarball. All three logs are in it, I crafted a BPF program
> for Goodix controller also. Wasn't that bad actually, a few line change
> so it might be possible to use the same program at least for these two
> controllers.

\o/

>
>
> >
> >> I have also a kernel testing branch available at [1], which contains a
> >> few fix patches on top of Benjamin's HID-BPF driver work, and is rebased
> >> on top of latest hid/for-next. The HID-BPF fixes have been cleaned up a
> >> bit compared to previous setup. There are also a couple of new patches
> >> for adding support for a delayed_work BPF program on top of the
> >> hid-bpf driver; this is used to execute the raw_requests in non-irq
> >> context.
> > Thanks for that. I had a very quick look. I thought we could directly
> > use the bpf_timer_* functions instead of having to cook another API.
> > I'll play around with this, but thanks for pushing forward :)
>
> Yeah, I am kicked by someone on this so want to proceed. ;)
>
> According to documentation, bpf_timer callbacks are executed in soft-irq
> context, so we can't use it at least for sending the raw_requests which
> is needed for USI.

I might be wrong, but I am not sure if soft IRQs are incompatible with
hid_hw_raw_request.
Anyway, I gave it a shot today and I am hitting the fact that we lose
the BPF context in the timer callback. So we might actually need a new
API :/

>
> >
> > IIRC you asked me when I was counting on submitting the HID BPF work.
> >
> > So my answer is that I wanted to submit it by the end of 2021, but it
> > looks like I have only one week to finalize this :/
> Ok, sounds like you want to submit it probably early next year then. I
> just wanted to have some sort of ballpark estimate, and this is good
> enough for me, thanks.

Yeah, sorry for the delay.

> >
> > The current missing points are:
> > - add selftests for all the new API introduced
> > - review the entire API to not have to deal with a mistake forever
> > - rebase against bpf-next
> If you need my help on any of these items, let me know.
> >
> > One part of the API I am wondering is whether it is good or not to
> > have bpf_hid_foreach_rdesc_item(). This function is complex and we
> > could in theory parse the report descriptor in userspace, even before
> > we load the program. So all the parameters you need in the various
> > raw_event functions could be computed in user space, leading to a much
> > smaller API. The other benefit would be that the API would only deal
> > with arrays of bytes, which is a small enough and versatile enough API
> > :)
>
> This might be a good idea. Assuming the BPF programs end up in the
> hid-tools repo, there could be a generic library for parsing the rdescs
> also which the userspace programs could use.

Oh. Glad to see that this is something you find interesting. Peter
Hutterer mentioned that idea and I am still not 100% sure about it,
but if you also think it'll make things easier, then why not :)

Cheers,
Benjamin

>
> -Tero
>
> >
> > Cheers,
> > Benjamin
> >
> >> -Tero
> >>
> >> [1] https://github.com/t-kristo/linux/tree/usi-5.16-v5-bpf
> >>
> >>

