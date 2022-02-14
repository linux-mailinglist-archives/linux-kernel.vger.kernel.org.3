Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177CD4B4E55
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239962AbiBNL1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:27:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351280AbiBNL1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:27:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06A39606DC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644836603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hWhbGGGKn+bDX+rmVqjerjVIp4FoCEokyN680ikvwEs=;
        b=IgPRyc42bJh6PRxRTxXu1ncoNpntuNRYNVoQysqz0mKHeS1A/u2ALKg0V6XtJsJn3RROZE
        nx4t1uAUc7dZCNusC+XsTTWaS1V2XfV6d5AsOBKDBUWw0N5/+97RNjQ8VmvBo5IGe0nyd9
        Cz773Zod+eyjB4cLt+fPLiflLPqJps0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-CZVJmjI5O0qrQRRtsscYBw-1; Mon, 14 Feb 2022 06:03:22 -0500
X-MC-Unique: CZVJmjI5O0qrQRRtsscYBw-1
Received: by mail-pf1-f200.google.com with SMTP id j204-20020a6280d5000000b004e107ad3488so2483690pfd.15
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:03:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hWhbGGGKn+bDX+rmVqjerjVIp4FoCEokyN680ikvwEs=;
        b=oU/sZC9AfO6hPKmugJxTJC/kWLBVgqSRRM/nPCVr9rLDF1Hd3b7ZQbmAcWRLop2YiW
         qsYJqyLtHkyulQgYUYNSz8kX/SbVTNqLGaU+D2JCJlu/laEXx/C9z03nIMlGL+w2LL5R
         guG9WuY1Dzls73Ffa9FY1enqvE+xqzDH3qYu2yHYizGnUDK6dvalAUw5HzBsKqpFrWCn
         RNeR//BOvTSYetNf7c8bijHeEL9Qyd6pdhC3mnQ5yzqQXbCok1k0QaTnY8GVrBtHSR9J
         fEyOT8DIL0Hqp3+RDf+Bg+ms5S8GV2WsxRGyf1HlJx7gu9mCSBe2UE7m3hay7LCEpOJX
         wAPQ==
X-Gm-Message-State: AOAM530haZrASC5a5Ac+hWoC0sPRsYTgNvH38jbrnapy6sIZjBWwK8AS
        VqcOfL6Ob2XmUbfTQcNnhVIHe3qaH+2XPPtCQRo6u0hYBAT3lHnmXeyhR/B6v7jStJAw/xHG/eR
        NPEmmNcyQ16qQhXOYBcRkgKW8BSGXiJrqAZQ3CwD4
X-Received: by 2002:a17:90b:4a48:: with SMTP id lb8mr13869252pjb.246.1644836600822;
        Mon, 14 Feb 2022 03:03:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIgNSaQv0Pdi+0OuVv8zJKJEtv8+8VYc4ndU71icI1bcO5ov9up72ABZDSMDeRdlcnA4BrimL8T+lEFfAhVto=
X-Received: by 2002:a17:90b:4a48:: with SMTP id lb8mr13869208pjb.246.1644836600472;
 Mon, 14 Feb 2022 03:03:20 -0800 (PST)
MIME-Version: 1.0
References: <20220126161832.3193805-1-benjamin.tissoires@redhat.com>
 <CAB4aORW_b+6=a-fXCL-MJoM9uNvjeYL01W85Rb=6rMP-Nm11QQ@mail.gmail.com> <CAB4aORU51aZc7BHdTfrXanYVvFG4wxQRqfsrs6mdttYCB+LY8A@mail.gmail.com>
In-Reply-To: <CAB4aORU51aZc7BHdTfrXanYVvFG4wxQRqfsrs6mdttYCB+LY8A@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 14 Feb 2022 12:03:09 +0100
Message-ID: <CAO-hwJKfDtq-397R8A59tvkNQ18AF-0FbHzTqNiErADYNQMHGw@mail.gmail.com>
Subject: Re: [PATCH 00/12] HID: fix for generic input processing
To:     Angela Czubak <acz@semihalf.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Ping Cheng <pinglinux@gmail.com>,
        Aaron Armstrong Skomra <skomra@gmail.com>,
        Jason Gerecke <killertofu@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 11:51 AM Angela Czubak <acz@semihalf.com> wrote:
>
> On Tue, Feb 8, 2022 at 8:19 PM Angela Czubak <acz@semihalf.com> wrote:
> >
> > Hi Benjamin,
> >
> > On Wed, Jan 26, 2022 at 5:18 PM Benjamin Tissoires
> > <benjamin.tissoires@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > This is a followup of the discussion we had between Wacom and
> > > the maintainers, and a followup of those 2 patch series:
> > >
> > > https://lore.kernel.org/r/20211022232837.18988-1-ping.cheng@wacom.com/
> > > https://lore.kernel.org/r/2ca91ac7cf92e3048a236db3cd519f04e12c1e61.1615224800.git.nabijaczleweli@nabijaczleweli.xyz/
> > >
> > > It took me a while to get it right, but I finally can submit the
> > > series:
> > >
> > > - the first 8 patches are some cleanup in the hid-input.c and
> > >   hid-core.c code. They also create a list of input fields that
> > >   is then used to process the event, in the priority we think
> > >   is good.
> > >
> > >   For instance, on multitouch devices, it is better to have
> > >   Contact Count before processing all touches, and in each
> > >   touch, having Contact ID first is better. This series doesn't
> > >   cover hid-multitouch, but I have a series on top of this one that
> > >   does cover it.
> > >
> > >   Anyway, in our case, here, we need to process Invert before
> > >   In Range for tablets so we can make a decision whether the user
> > >   has the intend to erase or not.
> > >
> > > - patch 9 enforces the invert usage before In Range as mentioned
> > >   above
> > >
> > > - patch 10 is the actual bulk of processing that should fix the
> > >   generic tablet handling. Now that we have a reliable ordering
> > >   of the fields, we can compute the state of the tool in a reliable
> > >   way, and be kinder to userspace by not sending to it 2 tools at
> > >   the same time.
> > >
> > >   This patch has been extensively tested by hid-tools with the new
> > >   MR I submitted that add tests for tablets [0].
> > >
> > > - patch 11 is a nice to have that I need for my second series regarding
> > >   hid-multitouch. It is not mandatory with that series, but given
> > >   that it changes the format of the priorities in hid-input.c I thought
> > >   it would be best to send it as part of this series.
> > >
> > >   Note that now we are tagging the *reports* and the individual fields
> > >   when they are part of a multitouch collection, which should help
> > >   the drivers that implement this processing (hid-multitouch and wacom).
> > >
> > > - last, patch 12 is an attempt at fixing the documentation regarding
> > >   BTN_TOOL_* (requested by Peter).
> > >
> > >   Dmitry, feel free to take this one through your tree if you prefer
> > >   to do so (and if you are happy with it), otherwise we can take it
> > >   through the hid tree.
> > >
> > > As mentioned above, I have a followup series not entirely tidied up
> > > that implements the processing of Win8 mutltiouch devices in
> > > hid-input.c.
> > > There are several benefits for that: we should be able to drop the
> > > multitouch code in wacom.ko, we can simplify part of hid-multitouch,
> > > and we will be able to quirk a particular device in a separate module,
> > > without touching at the generic code (in hid-multitouch or hid-input).
> > >
> > > Anyway, I am missing a few bits for that so that's coming in later.
> > >
> >
> > Is there any timeline for the followup series? I am wondering how that
> > would affect haptic support implementation.
>
> Hi Benjamin,
>
> just pinging in hope of receiving some answer :)
> I am thinking of preparing another version of haptic support patches
> (https://lore.kernel.org/all/20220114183152.1691659-1-acz@semihalf.com/T/)
> and if I could already start remodelling them based on your changes so that
> it is actually a haptic hid driver and not and API that would be great :)
> I am simply wondering when multitouch driver is going to be expressed simply
> by your changes.

Hi Angela,

FWIW, I got a public branch that has the multitouch changes at
https://gitlab.freedesktop.org/bentiss/hid/-/commits/wip/input-mt-v5

The logic in the multitouch processing is correct but it is missing a
few bits IIRC:
- suspend/resume doesn't unset/set the multitouch parameters (doesn't
seem to be an issue on my devel laptop though)
- scantime is not properly handled
- width/height is not using the same path than hid-multitouch (and
probably not reported at all)
- hid-multitouch needs to be cleaned up to use the new core changes
instead of re-doing stuffs itself

I think that you should be able to experiment your hid-haptic changes
already, and see if that is indeed easier to use than creating an API
driver.

Cheers,
Benjamin

>
> >
> > > Cheers,
> > > Benjamin
> > >
> > >
> > > [0] https://gitlab.freedesktop.org/libevdev/hid-tools/-/merge_requests/127
> > >
> > > Benjamin Tissoires (12):
> > >   HID: core: statically allocate read buffers
> > >   HID: core: de-duplicate some code in hid_input_field()
> > >   HID: core: split data fetching from processing in hid_input_field()
> > >   HID: input: tag touchscreens as such if the physical is not there
> > >   HID: input: rework spaghetti code with switch statements
> > >   HID: input: move up out-of-range processing of input values
> > >   HID: compute an ordered list of input fields to process
> > >   HID: core: for input reports, process the usages by priority list
> > >   HID: input: enforce Invert usage to be processed before InRange
> > >   HID: input: remove the need for HID_QUIRK_INVERT
> > >   HID: input: accommodate priorities for slotted devices
> > >   Input: docs: add more details on the use of BTN_TOOL
> > >
> > >  Documentation/input/event-codes.rst |   5 +-
> > >  drivers/hid/hid-core.c              | 280 ++++++++++++++++++++---
> > >  drivers/hid/hid-input.c             | 330 ++++++++++++++++++++++------
> > >  include/linux/hid.h                 |  23 +-
> > >  4 files changed, 533 insertions(+), 105 deletions(-)
> > >
> > > --
> > > 2.33.1
> > >
> >
> > Does this patch series introduce the leaf driver support you mentioned
> > in the haptic review?
>

