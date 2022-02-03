Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F6B4A8620
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351137AbiBCOXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:23:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235184AbiBCOXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643898181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KaIydMUtYXzd2SdOD8PDJArEvRtbHzDDweqUKY1MfnQ=;
        b=YTFXv0qwWtgFLiQ53Fo+D0LbUF7nNlPVLA6xA1FCZZEp3zWlskosiC02Od55AaV1uBZpOD
        lcTy6OXRng3bqxmo6LJCdyDuTPIGUu5uDx1Cofrq1HcyqpZbcPuCwZG8RmTv5BNAnS85yv
        yeHA4hEi+pZPah3dR+c3jYUKllr1K74=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-DUGw1u8XPvWtKckVhsXHNA-1; Thu, 03 Feb 2022 09:23:00 -0500
X-MC-Unique: DUGw1u8XPvWtKckVhsXHNA-1
Received: by mail-pl1-f198.google.com with SMTP id f9-20020a170902684900b0014cd6059ecdso1285201pln.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 06:23:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KaIydMUtYXzd2SdOD8PDJArEvRtbHzDDweqUKY1MfnQ=;
        b=wTPUNHHww+St4HHMmKO6vfxYsD2r6ncVE+U/bKaBRp8Yj4RdCcs8H9g31Vwt9BuGNd
         4q9nLqqxpFTnuQjeY9fM6nUN0V4eXrFhxNgdNNllyZyhz6tBOCIvqRrTYwWBYW+iPoju
         QTH+hnAheIP+u7TW36ebAtq1Rs0In2yXFScu/H32HiB+j3mYWdMT8VMDuH7aDZeo3uGn
         2KD5OvbWvqIW7mP4H5S5r+hwM3cNWiJXYNTSDBanwxuOpFtYCUycRicdBLc+o2QVsKJu
         QJsx6SzQLH56Bufklmuiz7yEm0IDdJS3PZWbswS55vBKo/29amHfsOig0ZvVSoOSbVdY
         zlXA==
X-Gm-Message-State: AOAM5305Pr8ppPj2vNHxnG8raQMS8A/+Hf8yJJ0wCspfP5Z57pIh4ysa
        y5oEdFoIZLumi6r8B/fVqPVHKdcDT4OhJBHGAcWQT667cMuNnmV3tlSsWVadeQ7GjfiWxWzuPPf
        0oXykXmNi/qJxCoXU828EkinSTL2GrMahx6VtWgGs
X-Received: by 2002:a05:6a00:1345:: with SMTP id k5mr34765648pfu.29.1643898179528;
        Thu, 03 Feb 2022 06:22:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZXxOdPymMvq1/lvAi1LJJClXBajE6Ea91PyTd6v6mwww44IhsHlYvPtJvqmSVUJmQnIxRjS4A+EFXsMLOvTc=
X-Received: by 2002:a05:6a00:1345:: with SMTP id k5mr34765625pfu.29.1643898179225;
 Thu, 03 Feb 2022 06:22:59 -0800 (PST)
MIME-Version: 1.0
References: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
 <nycvar.YFH.7.76.2202021456020.11721@cbobk.fhfr.pm> <CAO-hwJJ08vfMTEhU03VEef8Ejx=Ts+akUwGMKTUGqMWwOK3QoA@mail.gmail.com>
In-Reply-To: <CAO-hwJJ08vfMTEhU03VEef8Ejx=Ts+akUwGMKTUGqMWwOK3QoA@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 3 Feb 2022 15:22:47 +0100
Message-ID: <CAO-hwJK8O+yYMxCdx6DFd9cpF6McW4KC+uERQ6EsTY14JVr5-g@mail.gmail.com>
Subject: Re: [PATCH 00/12] i2c-hid: fixes for unnumbered reports and other improvements
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Angela Czubak <acz@semihalf.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 6:59 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Wed, Feb 2, 2022 at 2:56 PM Jiri Kosina <jikos@kernel.org> wrote:
> >
> > On Mon, 17 Jan 2022, Dmitry Torokhov wrote:
> >
> > > Hi,
> > >
> > > This series came about after I reviewed Angela's patch that fixed issues
> > > with incorrect handling of high-numbered reports (15 and above) in
> > > i2c-hid driver:
> > >
> > > - it appears to me that the driver did not handle unnumbered reports
> > >   correctly as the kernel internally expects unnumbered reports to be
> > >   still prepended with report number 0, but i2c_hid_get_raw_report() and
> > >   i2c_hid_output_raw_report() only expected report ID to be present for
> > >   numbered reports.
> > >
> > > - the driver tried to consolidate both command handling and sending
> > >   output reports in __i2c_hid_command() but the rules for different
> > >   commands vary significantly and because of that the logic was hard to
> > >   follow and it bled out from __i2c_hid_command() to callers. I decided
> > >   to introduce a few simple helpers and have the data encoding for
> > >   individual commands done at the call site. I believe this made it
> > >   easier to validate the rules and the logic and allowed to remove
> > >   special handling for the HID descriptor retrieval, among other things.
> > >
> > > - the driver does too many copying of data; encoding the data for
> > >   commands at the call site allowed to only copy data once into the
> > >   transfer buffers.
> > >
> > > I tested this on a couple of Chromebooks with i2c-hid touchscreens, but
> > > it would be great if other folks tried it out as well.
> >
> > Benjamin,
> >
> > is this something you could feed into your testing machinery as well? (not
> > sure whether it's handling i2c-hid specifics).
>
> Not really. I mean I have a sample touchpad connected on an USB to I2C
> bridge that I included in the automated tests (though it may be
> failing in the latest release because I need to update the patch that
> enables it), but it would probably not catch all the corner cases.
>
> I can add this series to my local tree and test on my XPS with both
> and Elan touchpad and a Wacom touchscreen/panel. It will still add a
> few more tests :)

OK, So I applied the series on my development laptop.
I had to apply it on top of v5.16 and then rebase on top of
hid.git/for-next because there is a minor conflict.

I changed the register as mentioned in 5/12, and gave it a try.
Both the Elan touchpad and the Wacom panel on my XPS-13 are behaving
properly, suspend/resume works also as expected.

Tested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I gave a quick look at the individual patches, they all seem sane to
me, but haven't dug into enough detail to be able to formally give my
reviewed-by.
Note that I have a small comment on patch 2, but if you want to apply
it nevertheless Jiri (with the change in 5/12) it should be fine.

Cheers,
Benjamin

> I'll try to report that tomorrow now that I think I fixed my tablet series.
>
> Cheers,
> Benjamin
>
> >
> > Thanks!
> >
> > --
> > Jiri Kosina
> > SUSE Labs
> >

