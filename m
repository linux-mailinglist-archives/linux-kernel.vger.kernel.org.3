Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC194B4DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350402AbiBNLUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:20:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350774AbiBNLTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:19:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3205E75E47
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644836045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KyJ6SogPF87irN4VD630By2JCZI7Ntev91wcNjIl8tE=;
        b=XxYlQ4COBM/9YhYBw83qSWP+7thqADM4xlw7RacK9ccJnqjGz1p97rOtdj6hlcsksRWF6j
        BXheSnh8qRnS9043dwqEyiJfMdmgJ23WrcRvxU9HebEFu7UetSAae0seR1gPcfFP0pTiaq
        qYE6IHwbsVlzUV2gg86H2ddGNuAvgyo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-R_vnLa_QN4aLV7AUjWL_9w-1; Mon, 14 Feb 2022 05:54:03 -0500
X-MC-Unique: R_vnLa_QN4aLV7AUjWL_9w-1
Received: by mail-pj1-f70.google.com with SMTP id s10-20020a17090a948a00b001b96be201f6so6655574pjo.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KyJ6SogPF87irN4VD630By2JCZI7Ntev91wcNjIl8tE=;
        b=adi+6AtPfWOhRKoXMBPSK8efnesy0DV0MXKOky9yYcd0E54qfF+ZFtAwnFXaJQR1eo
         OvP1ncYV2EWQy9EXHVtDs2J/Lw/BX16RW4EGEt/X7XRIBCUa8D33iLOCAOms+ROreei0
         EhiBrqU/7UIz2B4A7esAC+Ss1cikUWl+8daOREyQkcXch/aFP9HiHMAGuBEpNLIs7+c8
         0F5bayv/XosJ+cOC6fXtDKa/RrDVNh8UrmdSJTx5C5W9SRJvghthEk18Q+GDeyPPiFWy
         qYJOZ/dcjL3Gjqhr3B7kRhiWL9eUmaqyZqxbZp9h3T3z+Rw0SQhl4415UQUgt3p+0Tin
         olLg==
X-Gm-Message-State: AOAM530znXwGnhTGNHDySjrKuFBHw6cG1+QdijjcewP1SQlppNEyVUrE
        SgufRozzxdcrrNr261RSh3ND/p0vGqVhfzrP4m0qB4Ni6a5ghv1wnOpGDM0cJIaL6xwZtSvu9pr
        XGE2Dk3hnHX4uHQ7HQzugBWKjuhFvaSz5bcYrVqQ4
X-Received: by 2002:a17:903:2410:: with SMTP id e16mr13313985plo.67.1644836042836;
        Mon, 14 Feb 2022 02:54:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOWDe+jUVcN3DfU15/34UlcTis+SsEQrBK6s9+ZeNeQy4y0em6tIrn7gIPhQO+zHxPXJ2vQeXVQjPQgNemSTU=
X-Received: by 2002:a17:903:2410:: with SMTP id e16mr13313964plo.67.1644836042554;
 Mon, 14 Feb 2022 02:54:02 -0800 (PST)
MIME-Version: 1.0
References: <20220126161832.3193805-1-benjamin.tissoires@redhat.com> <CAB4aORW_b+6=a-fXCL-MJoM9uNvjeYL01W85Rb=6rMP-Nm11QQ@mail.gmail.com>
In-Reply-To: <CAB4aORW_b+6=a-fXCL-MJoM9uNvjeYL01W85Rb=6rMP-Nm11QQ@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 14 Feb 2022 11:53:51 +0100
Message-ID: <CAO-hwJKL-pLfASSs4YfEvG8eeOsCaeepCTfwzxn0sMh2NCu+7Q@mail.gmail.com>
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

On Tue, Feb 8, 2022 at 8:20 PM Angela Czubak <acz@semihalf.com> wrote:
>
> Hi Benjamin,
>
> On Wed, Jan 26, 2022 at 5:18 PM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > Hi,
> >
> > This is a followup of the discussion we had between Wacom and
> > the maintainers, and a followup of those 2 patch series:
> >
> > https://lore.kernel.org/r/20211022232837.18988-1-ping.cheng@wacom.com/
> > https://lore.kernel.org/r/2ca91ac7cf92e3048a236db3cd519f04e12c1e61.1615224800.git.nabijaczleweli@nabijaczleweli.xyz/
> >
> > It took me a while to get it right, but I finally can submit the
> > series:
> >
> > - the first 8 patches are some cleanup in the hid-input.c and
> >   hid-core.c code. They also create a list of input fields that
> >   is then used to process the event, in the priority we think
> >   is good.
> >
> >   For instance, on multitouch devices, it is better to have
> >   Contact Count before processing all touches, and in each
> >   touch, having Contact ID first is better. This series doesn't
> >   cover hid-multitouch, but I have a series on top of this one that
> >   does cover it.
> >
> >   Anyway, in our case, here, we need to process Invert before
> >   In Range for tablets so we can make a decision whether the user
> >   has the intend to erase or not.
> >
> > - patch 9 enforces the invert usage before In Range as mentioned
> >   above
> >
> > - patch 10 is the actual bulk of processing that should fix the
> >   generic tablet handling. Now that we have a reliable ordering
> >   of the fields, we can compute the state of the tool in a reliable
> >   way, and be kinder to userspace by not sending to it 2 tools at
> >   the same time.
> >
> >   This patch has been extensively tested by hid-tools with the new
> >   MR I submitted that add tests for tablets [0].
> >
> > - patch 11 is a nice to have that I need for my second series regarding
> >   hid-multitouch. It is not mandatory with that series, but given
> >   that it changes the format of the priorities in hid-input.c I thought
> >   it would be best to send it as part of this series.
> >
> >   Note that now we are tagging the *reports* and the individual fields
> >   when they are part of a multitouch collection, which should help
> >   the drivers that implement this processing (hid-multitouch and wacom).
> >
> > - last, patch 12 is an attempt at fixing the documentation regarding
> >   BTN_TOOL_* (requested by Peter).
> >
> >   Dmitry, feel free to take this one through your tree if you prefer
> >   to do so (and if you are happy with it), otherwise we can take it
> >   through the hid tree.
> >
> > As mentioned above, I have a followup series not entirely tidied up
> > that implements the processing of Win8 mutltiouch devices in
> > hid-input.c.
> > There are several benefits for that: we should be able to drop the
> > multitouch code in wacom.ko, we can simplify part of hid-multitouch,
> > and we will be able to quirk a particular device in a separate module,
> > without touching at the generic code (in hid-multitouch or hid-input).
> >
> > Anyway, I am missing a few bits for that so that's coming in later.
> >
>
> Is there any timeline for the followup series? I am wondering how that
> would affect haptic support implementation.

Sorry, no timeline on when we will be able to merge this. I was
enjoying some time off last week, but now I need to check whether the
comments I received need a v3 or not.

>
> > Cheers,
> > Benjamin
> >
> >
> > [0] https://gitlab.freedesktop.org/libevdev/hid-tools/-/merge_requests/127
> >
> > Benjamin Tissoires (12):
> >   HID: core: statically allocate read buffers
> >   HID: core: de-duplicate some code in hid_input_field()
> >   HID: core: split data fetching from processing in hid_input_field()
> >   HID: input: tag touchscreens as such if the physical is not there
> >   HID: input: rework spaghetti code with switch statements
> >   HID: input: move up out-of-range processing of input values
> >   HID: compute an ordered list of input fields to process
> >   HID: core: for input reports, process the usages by priority list
> >   HID: input: enforce Invert usage to be processed before InRange
> >   HID: input: remove the need for HID_QUIRK_INVERT
> >   HID: input: accommodate priorities for slotted devices
> >   Input: docs: add more details on the use of BTN_TOOL
> >
> >  Documentation/input/event-codes.rst |   5 +-
> >  drivers/hid/hid-core.c              | 280 ++++++++++++++++++++---
> >  drivers/hid/hid-input.c             | 330 ++++++++++++++++++++++------
> >  include/linux/hid.h                 |  23 +-
> >  4 files changed, 533 insertions(+), 105 deletions(-)
> >
> > --
> > 2.33.1
> >
>
> Does this patch series introduce the leaf driver support you mentioned
> in the haptic review?
>

As mentioned above, no, this patch series does not have the multitouch
support in it.

Let me answer your other email you sent while I am typing this one :)

Cheers,
Benjamin

