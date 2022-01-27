Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AA049DFD7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiA0Kub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiA0Kua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:50:30 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED28DC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:50:29 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id w6so2121852qtk.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/F95RwYdMvK9HG/AU2XwA1QRoH8XyM9R4nwtANcJ5fk=;
        b=sPsDr1HwEupFrnPd7Svv7MqI5xNpx6ivirsj2+MIHfSf7r8EJ1QTIm3S0B52YFQzpm
         k6k7lX7aCuQtDxlKw8RVGdJAD5PeSO3jx36LqcD7hW2n86kkS9nd+6nnfMBD4oJ1x3wh
         u7F7ZpT7F6Omnjke06e5F4I312WXgYQX59Tn6jZYdxes7XHunXiP14xJD/HfhD/BUe91
         DYUDDLJPHd2v2fX5kkjY8IblJm5Qpqi1g56N8vU83e8gKViPb0GZKaAwXPKncyU/FV39
         xpD82pjVt1neEwyR+3k9nGH/w5r8mjn3ybJ8F1ZeQPWqWpGcw5eeTiVJ7i7PSLsgQGal
         O5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/F95RwYdMvK9HG/AU2XwA1QRoH8XyM9R4nwtANcJ5fk=;
        b=xjh3u6NCs7VodPvj7WahdXDB9BlksdAKEwP6bbXKjnSAf8iihlhbN1y506NJw1p07k
         1snT1c13fOJovM7/akliLL+MphIXdtgAnWxWKE7ZDhFehgboZUnK/FBpcmgo2YaE2iYI
         sVzk8gpsk3twqnyJ4C2OZ3nCJ8EIyQrkpUQzFesDxUaPdO4rjy6xoZkLqvtjdXXgncWV
         yA171iPjnAFqXD6RmAMb6tqiplcKf4a6U72g0qUlq1E5/Ib89SMPBhgCLoRK3+4+2zRp
         ASuV74RKfCE7ZAAXCfK6Z6wdW2J0ysuXLI7ySHF34kWbGfCL3mf4NypBTWRPRWmiGG8w
         7kLg==
X-Gm-Message-State: AOAM532EkbmXFMpH86J0s88Pu3+yWCkhow+uy/aCAN00TT+KsQf0mfFo
        NUxIsu1PUBih0/pdiXH0AyoxDRL+tp5gunrBizvrtA==
X-Google-Smtp-Source: ABdhPJy8xAU/Buo5U/A2RnAMl8repadRILhqBYLRMHVZsi0GK3WvvWhyxabZUBoN6ZrfrIACKHySCn+sPEUKG77AoUM=
X-Received: by 2002:ac8:5fcf:: with SMTP id k15mr2143983qta.73.1643280628944;
 Thu, 27 Jan 2022 02:50:28 -0800 (PST)
MIME-Version: 1.0
References: <20211123161038.48009-1-mlevitsk@redhat.com> <20220125150832.1570-1-mike@fireburn.co.uk>
 <6f0d9b07073ca6d3657500ec076edc1ad2a3e40a.camel@redhat.com>
 <CAHbf0-FJ0c1yAumKCnXLKKFN=tzeJxSd3HyP=dUOBgBTxVG5fw@mail.gmail.com>
 <7809c3253a997330102b9d779206312d6b3bcaf1.camel@redhat.com>
 <CAHbf0-F8Uemcu8FVcZvY0CPOf4kFXOcaCzWF1ZCwkpa3tyut3A@mail.gmail.com>
 <6cf58a4cd925726ef10481d38f9f4e8090f5023d.camel@redhat.com>
 <CAHbf0-EY9_27Tw3v-pfwXDaTuwpsuuFqrJDKZ8C_cW+-PwXwww@mail.gmail.com> <495878a237748e3652619e692706b9352969f435.camel@redhat.com>
In-Reply-To: <495878a237748e3652619e692706b9352969f435.camel@redhat.com>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Thu, 27 Jan 2022 10:50:18 +0000
Message-ID: <CAHbf0-Ew=LPpYx6MT_Gb8oM-4egTvXuz0H7cYKZxFjFeBz=9Tw@mail.gmail.com>
Subject: Re: [PATCH 0/5] iommu/amd: fixes for suspend/resume
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     dwmw@amazon.co.uk, iommu@lists.linux-foundation.org,
        joro@8bytes.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, tglx@linutronix.de, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 at 10:22, Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> On Thu, 2022-01-27 at 00:39 +0000, Mike Lothian wrote:
> > On Wed, 26 Jan 2022 at 10:12, Maxim Levitsky <mlevitsk@redhat.com> wrote:
> > > Great, your system does seem to support GA log
> > > (but a patch to check if, other that assume blindly that it is supported is
> > > something that should be done).
> > >
> > > So could you bump the LOOP_TIMEOUT like by 10x or so and see if the problem goes away?
> > >
> > > (that code should be rewritten to time based wait and not just blindly loop like that,
> > > I also can prepare a patch for that as well).
> > >
> > > Best regards,
> > >         Maxim Levitsky
> > >
> >
> > Hi
> >
> > I've done quite a few restarts with the LOOP_TIMEOUT increased and
> > I've not seen the issue since
>
> Great, so the problem is solved I guess.
> Thanks for the help!
>
>
> I'll send a patch for this in few days to replace this and other similiar timeouts
> with a proper udelay() wait.
>

Thanks for your help
