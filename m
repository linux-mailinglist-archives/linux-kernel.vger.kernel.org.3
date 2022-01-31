Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74D44A47F9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378669AbiAaNXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:23:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59279 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378616AbiAaNXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:23:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643635394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9KAyT9rBVY+T+dfrdXo9p7KiG3uUpwYacibY8D080RQ=;
        b=XFxtmLloDBNstPBY9hAiny7T+MAu0aBRVi2kfgjYXHBhDxPmNpwOvvwZ4I0/Sk/kBBzl3S
        WOo+mKWXYkiL8jZFVF3PsqY006BZlFd8eeE173IYYq+l5+/3c4EkpwKg9eTqJEqTD92hzQ
        0Xi8XVs2jfpFfpAn1/e8wweC5Czqepk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-xXf8-2sBOg6nQFVsI0Gyvg-1; Mon, 31 Jan 2022 08:23:12 -0500
X-MC-Unique: xXf8-2sBOg6nQFVsI0Gyvg-1
Received: by mail-ed1-f70.google.com with SMTP id w23-20020a50d797000000b00406d33c039dso6927353edi.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:23:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9KAyT9rBVY+T+dfrdXo9p7KiG3uUpwYacibY8D080RQ=;
        b=A4nr5xIosdfLIQ2M58iHzu8V78Xn8iJYvNapKQWya3zEdXuT25bM3cSk+q3DwYl+wI
         zrONT/+NbYW05I5kcG2aIcNPD4ZvL6CKWSPfRLk4ciKcxJBzhHC0JkVgBGobhbizPT/n
         CbDWVb7Ox7wFY0GOvJrqN4UKfrpbVMCSgXY3Nu1V2/AswCpVE/q+RJeNyhEmlVxSkyOu
         V0xiH0MPCEHcS4VFO5kMKgG9QG8haJ0JSbbaCy8b735/1ZJYC5OAbryc0mxD9FPWkmaZ
         et3zopQgqUDDmWE4MJQ2VLQBSE7nwykSntg7VAcogqbv3mtwQ2mE4bbiDweiL+rGRNqx
         Y6fg==
X-Gm-Message-State: AOAM530IFDS/iGamSENdmIDTvA5Et07KdAqXRTF+Ce11wRqeqF+zMZ+E
        u8xFWAt+7KCvvQPMeaVMAk31sXy4QXASBYtF7FsCGcPUy5bwYX1VwdPPQ6wtzweqGcimsS2vY6s
        /hbpQjLgxFI8EmrFf0pB0ccggJPiX8XuRJyhcMX2X
X-Received: by 2002:a17:907:7215:: with SMTP id dr21mr16888736ejc.205.1643635391440;
        Mon, 31 Jan 2022 05:23:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVhHivHRPtNJZPlnaUFUN2LqTF3Kv/MxIn/+ozkQARm7ix/MOw/YseOo8lcsRT/+7AnsqD3YtAzozBgjPg1Ug=
X-Received: by 2002:a17:907:7215:: with SMTP id dr21mr16888719ejc.205.1643635391226;
 Mon, 31 Jan 2022 05:23:11 -0800 (PST)
MIME-Version: 1.0
References: <YfMpk7DM9zA7NfmI@debian> <CAAq0SUnNtS8b3419egw-WVH8ic+MxH8oQELm1K0s4iqt8pYKnQ@mail.gmail.com>
 <CADVatmM5=sZLaT8SWcvmFtcMhVJsuVCu66nCnhL6i2p062ZhXA@mail.gmail.com>
In-Reply-To: <CADVatmM5=sZLaT8SWcvmFtcMhVJsuVCu66nCnhL6i2p062ZhXA@mail.gmail.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Mon, 31 Jan 2022 10:22:59 -0300
Message-ID: <CAAq0SUnJVhmo_-o=UBcKbr1OzHkvcWJt_b-TAvcOanQmHaCZ2g@mail.gmail.com>
Subject: Re: Regression with 5021d709b31b ("tty: serial: Use fifo in 8250
 console driver")
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 9:59 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi Wander,
>
> On Fri, Jan 28, 2022 at 12:31 PM Wander Costa <wcosta@redhat.com> wrote:
> >
> > On Thu, Jan 27, 2022 at 8:24 PM Sudip Mukherjee
> > <sudipm.mukherjee@gmail.com> wrote:
> > >
> > > Hi Wander,
> > >
>
> <snip>
>
> >
> > Thanks for the report. As Greg said, the patch has been reverted. In
> > the meantime, could you please apply this patch and report if the
> > problem still happens:
>
> Thanks for the patch, and I can confirm after applying the patch the
> problem is not there any more.
> Log at https://lava.qa.codethink.co.uk/scheduler/job/602
>

Thanks for testing!

>
> --
> Regards
> Sudip
>

