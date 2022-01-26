Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC7549CAB5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbiAZNYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:24:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36825 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239018AbiAZNYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643203452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ANJWRqaJOsHeBahCZP1aUBPvVHukSwmTjnJxwO3XFi8=;
        b=WbuT+vav1kmOTiJiwG1miDNaJErcSMnNou8PpCYixVhynNpbuqOL3OU/WK6r5dCFWgS8FA
        6loDZJbfuC1ur3RPEYoINVFr10EuW+JJWIZNYHirFUcvTiabQ0l1gxjhOZ9DR/wZNmGPsm
        vxo7L2Qxdi5uLZPoBEnhesPvMKq/Q0s=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-U6YrKpCCMfic1SgogjZY-g-1; Wed, 26 Jan 2022 08:24:10 -0500
X-MC-Unique: U6YrKpCCMfic1SgogjZY-g-1
Received: by mail-ed1-f71.google.com with SMTP id a18-20020aa7d752000000b00403d18712beso16682898eds.17
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:24:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ANJWRqaJOsHeBahCZP1aUBPvVHukSwmTjnJxwO3XFi8=;
        b=2NCeTrIIR3n8P01oVb0FfV/1WslSi/T3/YYARtbwyDEcX1jsw8U48KcDTHee7MLY3p
         B+fQCQiEYO2lu6qWbKMexKqWJ3uhCV2/5G1cdTmSJE5SyVpyOM3N5XwnBR1/wcfdGdQG
         xqWXEhpfIhI9J+iqig375N5QML7Va/yVrkA9Ywy5IYgnQI1nocez8CzAljb8qpniIwgB
         sqJkr5m2wvLrrNDijjqJMF6RDtizExejtzSEp9oJC0zxaNj3975vVDsiHqshj7fNwm2B
         u6uRT2sxomFSTiwfOtyfB+8rDjszMhudVeOAQ0CVGM5NNZhOrXmQciJoEmfCkZablt4F
         uz6g==
X-Gm-Message-State: AOAM533bx46HZrySxHDJZG6xYq7K358n1lbNjZ3GCAawQowahbSYhDym
        UoYjHvNcVPFnLZa6lrzBLPEXaNJziO3orKJSkyI9BKb3B+AzOGZKBhBecCP/1rqFUtfzeqvk2Wp
        DVURwYI4765a6lPAVKu0OFSwbOtgvj8T/6DJkfstN
X-Received: by 2002:aa7:d916:: with SMTP id a22mr25322808edr.316.1643203448928;
        Wed, 26 Jan 2022 05:24:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWwMrft4WxUun1ndbSR3lYX4QMq5cL7NVmEXsJv8NqcvjuTwDeS2EsnamlOpKPh8HCYWa/s4tUCv06avVPlVA=
X-Received: by 2002:aa7:d916:: with SMTP id a22mr25322789edr.316.1643203448749;
 Wed, 26 Jan 2022 05:24:08 -0800 (PST)
MIME-Version: 1.0
References: <a1ac6254-f79e-d131-fa2a-c7ad714c6d4a@nvidia.com>
 <f451e67d-adb9-01e8-bd11-bf7804863b4b@kernel.org> <8e57400f-d6a8-bd42-6214-fca1fe37a972@kernel.org>
 <11ec4350-b890-4949-cf8f-bc62d530d64f@nvidia.com> <CAAq0SU=9R3Y_SAdM+HaqavzWBRd1Li-b5bnZZLd5Opfgd0vnkQ@mail.gmail.com>
 <fa42a60c-954a-acc0-3962-f00427153f78@nvidia.com> <YfArHDfrVHw7ApDx@smile.fi.intel.com>
 <YfArWaKJ13+OC/7w@smile.fi.intel.com> <CAAq0SU=U3UY+DUdd1fjj25Yt_QZriShZTSFTsq5B4tPnOYhQvQ@mail.gmail.com>
 <YfELyq5AmxiZxjme@kroah.com> <YfE6AiIgXrd+5qvk@smile.fi.intel.com>
In-Reply-To: <YfE6AiIgXrd+5qvk@smile.fi.intel.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Wed, 26 Jan 2022 10:23:57 -0300
Message-ID: <CAAq0SU=ivwiGPZoD=BsD67A4A4pvuh0S02L2Udhg8vmjnmCAAw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: Use fifo in 8250 console driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 9:10 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jan 26, 2022 at 09:52:26AM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Jan 25, 2022 at 03:40:36PM -0300, Wander Costa wrote:
> > > On Tue, Jan 25, 2022 at 1:56 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > On Tue, Jan 25, 2022 at 06:53:48PM +0200, Andy Shevchenko wrote:
> > > > > On Tue, Jan 25, 2022 at 12:40:27PM +0000, Jon Hunter wrote:
> > > > > > On 25/01/2022 10:29, Wander Costa wrote:
> > > >
> > > > ...
> > > >
> > > > > > Andy, does this work for X86?
> > > > >
> > > > > Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > >
> > > > > No, it does NOT fix an issue (I see it on a handful x86) with the legacy UART
> > > > > (means the 8250_pnp is in use). And I believe the same will be the case on LPSS
> > > > > ones (8250_dw / 8250_lpss) and HSU (8250_mid), because the patch influences on
> > > > > all of them.
> > > >
> > > > Shall I send a revert and we can continue with a new approach later on?
> > > >
> > >
> > > Tomorrow (or maybe after tomorrow) I am going to post the fixes I
> > > already have, and an additional patch adding a build option
> > > (disabled to default) so people maybe if they want to use the FIFO on
> > > console write. But I understand if people decide to go
> > > ahead and revert the patch.
> >
> > Let me revert this for now.  And no new config options please, this
> > should "just work".
>
> Thanks!
>
> Wander, if you need a test for something new, I may help to perform on
> our (sub)set of x86 machines.
>

Thanks, Andy. I will let you know when I have new patches.

