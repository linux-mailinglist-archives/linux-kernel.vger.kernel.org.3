Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6425C46D637
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbhLHPAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:00:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229677AbhLHPAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638975395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aUQBozpU4Y1KYDGIdgsjepFLOb8OgoY8mq/2uMsvGYc=;
        b=cUdo6wa3+ZDrBLvBF2o1SCiHsmjAdT/lfFFA7kdq26LSuq5micAsldEq8/7aVImDxecgZY
        qWSuRNI4Ek+g0j5WrJy4VFApBK6gCgXPV06U/8Z4Bidu6NJDYAyPeqKbyZPsVkPPzwkD1R
        D903efyEnZUOUA8FU+Mt/LMMcoBU3dA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-WukQSCBGO0q-jnQw_6C-Ew-1; Wed, 08 Dec 2021 09:56:34 -0500
X-MC-Unique: WukQSCBGO0q-jnQw_6C-Ew-1
Received: by mail-pj1-f70.google.com with SMTP id g14-20020a17090a578e00b001a79264411cso1755638pji.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 06:56:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUQBozpU4Y1KYDGIdgsjepFLOb8OgoY8mq/2uMsvGYc=;
        b=W9PWZSNM1MI3ENr28sLLYQ0WQEbg2FEaC2BO7q2evwlWAhAJRn7C3TXmpdladWtQia
         ob/JtZlU0I9kAc+ojJDOUnQQf88XBzTJqp7jhKLWefDGreBDZsbGNR7ofnn/fhF50qhk
         TN7R0Pza7WzE9kJU62LUqHaPJxi1PIwBh9IpA/QdaxQSlX2lQr1cH112+3hiCuwSaASB
         ReGknj3Yfp3iR27Z1m2mk2LtMTwsa9gVB/ZEg3jCluObMtaS2VW1JHMUk849rGSP7Rvw
         0UbQm0ThF75oqnC3ByIGq2pq+uOpEJtmUVeEiErx/dXGl6T+t/9fWB4Mya6CPnMUcVlZ
         N9aQ==
X-Gm-Message-State: AOAM531lHqkjvjwG6OWilEtg72dM/5UA8Iwq8/IINE6BD1OEfytzvhYW
        ZvZydEnmmMo03HpZHNttQ1BfBnbyHbE0R5+bIVXPkHV4QX1teimsklOpF25m+5FIEcxUUtqr7cw
        aHMseo51EVX9Tkx1RxpVMWApcGyD7hilbYrtpLdkh
X-Received: by 2002:a17:90b:1648:: with SMTP id il8mr7719683pjb.246.1638975393247;
        Wed, 08 Dec 2021 06:56:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNWqUQECE85jaWpXQ0jpgu5hGh9MP0rynZaapLa7L6Spt5hemRU4LdKrcN7YWSjhYHRuFjkTVs9C2DZ7fv4ks=
X-Received: by 2002:a17:90b:1648:: with SMTP id il8mr7719650pjb.246.1638975392832;
 Wed, 08 Dec 2021 06:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20211126130141.1811848-1-tero.kristo@linux.intel.com>
 <CAO-hwJLq6Jnvos=CR_-D6FD-7W56q2eYRVyRMbmE5NFaXLHrng@mail.gmail.com> <4c87f439-f6d0-97e7-156e-90e9baab4b01@linux.intel.com>
In-Reply-To: <4c87f439-f6d0-97e7-156e-90e9baab4b01@linux.intel.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 8 Dec 2021 15:56:21 +0100
Message-ID: <CAO-hwJ+Vt81ZKR0Ywa5ffDW1R586dDcPQgOoe8awUOdYWV0Y7Q@mail.gmail.com>
Subject: Re: [RFCv2 0/8] USI stylus support series
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tero,

On Tue, Nov 30, 2021 at 5:13 PM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>
> Hi Benjamin,
>
> On 30/11/2021 16:44, Benjamin Tissoires wrote:
> > Hi Tero,
> >
> > On Fri, Nov 26, 2021 at 2:02 PM Tero Kristo <tero.kristo@linux.intel.com> wrote:
> >> Hi,
> >>
> >> This series is an update based on comments from Benjamin. What is done
> >> is this series is to ditch the separate hid-driver for USI, and add the
> >> generic support to core layers. This part basically brings the support
> >> for providing USI events, without programmability (patches 1-6).
> > That part seems to be almost good for now. I have a few things to check:
> > - patch2: "HID: hid-input: Add suffix also for HID_DG_PEN" I need to
> > ensure there are no touchscreens affected by this (there used to be a
> > mess with some vendors where they would not declare things properly)
> > - patch5: "HID: core: map USI pen style reports directly" this one
> > feels plain wrong. I would need to have a look at the report
> > descriptor but this is too specific in a very generic code
>
> Relevant part of the report descriptor is here:
>
>      Field(8)
>        Physical(Digitizers.Stylus)
>        Logical(Digitizers.Preferred Line Style)
>        Application(Digitizers.Pen)
>        Usage(6)
>          Digitizers.Ink
>          Digitizers.Pencil
>          Digitizers.Highlighter
>          Digitizers.Chisel Marker
>          Digitizers.Brush
>          Digitizers.No Preference
>        Logical Minimum(1)
>        Logical Maximum(6)
>        Physical Minimum(0)
>        Physical Maximum(255)
>        Unit Exponent(-1)
>        Unit(SI Linear : Centimeter)
>        Report Size(8)
>        Report Count(1)
>        Report Offset(88)
>        Flags( Variable Absolute NoPreferredState )
>
> To me, it looks almost like it is a bug in the report descriptor itself;
> as you see there are 6 usage values but the report size / count is 1
> byte. The fact that there are 6 usage values in the field confuses
> hid-core. Basically the usage values are used as encoded content for the
> field.

It took me a few days but I finally understand that this report
descriptor is actually correct.

The descriptor gives an array of 1 element of size 8, which is enough
to give an index within the available values being [Digitizers.Ink,
Digitizers.Pencil, Digitizers.Highlighter, Digitizers.Chisel Marker,
Digitizers.Brush, Digitizers.No Preference]

Given that logical min is 1, this index is 1-based.

So the job of the kernel is to provide the event
Digitizers.Highlighter whenever the value here is 3. The mapping 3 <->
Digitizers.Highlighter is specific to this report descriptor and
should not be forwarded to user space.

>
> Alternatively I think this could be patched up in the BPF program, as I
> am modifying the content of the raw hid report already; I could just as
> well modify this one also. Or, maybe I could fix the report descriptor
> itself to act as a sane variable, as I am parsing the report descriptor
> already?

I couldn't understand the fix you did in the BPF program. Can you
explain it by also giving me an example of raw event from the device
and the outputs (fixed and not fixed) of the kernel?


Talking about that, I realized that you gave me the report descriptor
of the Acer panel in an other version of this RFC. Could you give me:
- the bus used (USB or I2C)?
- the vendor ID?
- the product ID?
- and the same for the other panel, with its report descriptor?

This way I can add them in the testsuite, and start playing with them.

>
> >
> >> Additionally, a HID-BPF based sample is provided which can be used to
> >> program / query pen parameters in comparison to the old driver level
> >> implementation (patches 7-8, patch #8 is an incremental change on top of
> >> patch #7 which just converts the fifo to socket so that the client can
> >> also get results back from the server.)
> > After a few more thoughts, I wondered what your input is on this. We
> > should be able to do the very same with plain hidraw... However, you
> > added a `hid/raw_event` processing that will still be kept in the
> > kernel, so maybe bpf would be useful for that at least.
>
> Yes, plain hidraw can be sort of used to program the values, however the
> interface is kind of annoying to use for the USI pens. You need to be
> touching the display with the pen before anything is accepted. Maybe
> writing some support code to the libevdev would help.
>
> The hidraw hook is needed for processing the cached values also, USI
> pens report their parameters with a delay of some few hundred ms
> depending on controller vendor. And in some cases they don't report
> anything back before forcibly querying the value from the controller,
> and also the write mechanism acts differently; some controllers report
> the programmed value back, others keep reporting the old value until the
> pen leaves the screen and touches it again.

Hmm, not sure I follow this entirely. I guess I would need to have one
of such devices in my hands :(

>
>
> >
> >> The whole series is based on top of Benjamin's hid-bpf support work, and
> >> I've pushed a branch at [1] with a series that works and brings in
> >> the dependency. There are also a few separate patches in this series to
> >> fix the problems I found from Benjamin's initial work for hid-bpf; I
> >> wasn't able to get things working without those. The branch is also
> >> based on top of 5.16-rc2 which required some extra changes to the
> >> patches from Benjamin.
> > Yeah, I also rebased on top of 5.16 shortly after sharing that branch
> > and got roughly the same last fix (HID: bpf: compile fix for
> > bpf_hid_foreach_rdesc_item). I am *very* interested in your "HID: bpf:
> > execute BPF programs in proper context" because that is something that
> > was bothering me a lot :)
>
> Right, I think I have plenty of lockdep / scheduler checks enabled in my
> kernel. They generate plenty of spam with i2c-hid without that patch.
> The same issue may not be visible with some other low level hid devices
> though, I don't have testing capability for anything but the i2c-hid
> right now. I2C is quite notorious for the locking aspects as it is slow
> and is used to control some pretty low level stuff like power management
> etc.

As a rule of thumb, hid_hw_raw_request() can not and should not be
called in IRQ.
I tested your patch with a USB device, and got plenty of complaints too.

I know bpf now has the ability to defer a function call with timers,
so maybe that's what we need here.

>
> >
> > "HID: bpf: add expected_attach_type to bpf prog during detach" is
> > something I'll need to bring in too
> >
> > but "HID: bpf: fix file mapping" is actually wrong. I initially wanted
> > to attach BPF programs to hidraw, but shortly realized that this is
> > not working because the `hid/rdesc_fixup` kills the hidraw node and so
> > releases the BPF programs. The way I am now attaching it is to use the
> > fd associated with the modalias in the sysfs file (for instance: `sudo
> > ./hid_surface_dial /sys/bus/hid/devices/0005:045E:091B.*/modalias`).
> > This way, the reference to the struct hid_device is kept even if we
> > disconnect the device and reprobe it.
> Ok I can check this out if it works me also. The samples lead me to
> /dev/hidraw usage.
> >
> > Thanks again for your work, and I'd be curious to have your thoughts
> > on hid-bpf and if you think it is better than hidraw/evdev write/new
> > ioctls for your use case.
>
> The new driver was 777 lines diff, the BPF one is 496 lines so it
> appears smaller. The driver did support two different vendors though
> (ELAN+Goodix, with their specific quirks in place), the BPF only a
> single one right now (ELAN).
>
> The vendor specific quirks are a question, do we want to support that
> somehow in a single BPF binary, or should we attach vendor specific BPF
> programs?

Good question.
The plan I had was to basically pre-compile BPF programs for the
various devices, but having them separated into generic + vendor
specifics seems interesting too.

I don't have a good answer right now.

>
> Chromium-os devices are one of the main customers for USI pens right
> now, and I am not sure how well they will take the BPF concept. :) I did
> ask their feedback though, and I'll come back on this once I have something.

Cool thanks.

>
> Personally, I don't have much preference either way at this moment, both
> seem like feasible options. I might lean a bit towards evdev/ioctl as it
> seems a cleaner implementation as of now. The write mechanism I
> implemented for the USI-BPF is a bit hacky, as it just directly writes
> to a shared memory buffer and the buffer gets parsed by the kernel part
> when it processes hidraw event. Anyways, do you have any feedback on
> that part? BPF is completely new to me again so would love to get some
> feedback.

Yeah, this feels wrong to me too.
I guess what we want is to run a BPF call initiated from the
userspace. I am not sure if this is doable. I'll need to dig further
too (I am relatively new to BPF too as a matter of facts).

Cheers,
Benjamin

>
> One option is of course to push the write portion of the code to
> userspace and just use hidraw, but we still need to filter out the bogus
> events somehow, and do that in vendor specific manner. I don't think
> this can be done on userspace, as plenty of information that would be
> needed to do this properly has been lost at the input-event level.
>
> -Tero
>
> >
> > Cheers,
> > Benjamin
> >
> >> -Tero
> >>
> >> [1] https://github.com/t-kristo/linux/tree/usi-5.16-rfc-v2-bpf
> >>
> >>
>

