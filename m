Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6884644B7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 03:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241068AbhLACGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 21:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhLACGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 21:06:31 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821EAC061574;
        Tue, 30 Nov 2021 18:03:11 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o20so94296359eds.10;
        Tue, 30 Nov 2021 18:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hES9gSI2h5+HcFFnkzuuC76K+k6KUuP/8mebJNJ/D8M=;
        b=oGwRhekbHIns8PudvJ6py7lKsEJLjCHae4d7iX9I5XdSDYv1AGpX6NAQb6VPsOfTC6
         AbBooUm6Gi/oqOD77tI2DJTdTkBijDYSuyeRlqpgR+jzLe7lgrfyFb1YbASHRtB55FQe
         6iGMFl8MPorTa1wNoMMUgRtauQEhY51jcJneZUPtw8HGvCIYICL76/rQpqj3YQ6wAqwm
         EP82IEOOukvPM83aWQePwnAzZq60ItOkWc7nrGGx/I2OVfJ+ES89iBW34xkSa6D7PlC3
         Z32j7z5inZTPOlmsmgBzJ2QmFWJiMcLUhbn1/oIeUlTlxYUXkv3UCSe1sb8TZfgyricc
         4VxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hES9gSI2h5+HcFFnkzuuC76K+k6KUuP/8mebJNJ/D8M=;
        b=rl+JNOwffgMoM/NE/CaN/OJFJjeD/ak9NW6jELRKWwZnF+RVz3Lhs+Nfcf9/Xyx5z4
         nmQgXNde7Y8gPW+mM9r9+l4jI7jzTMN7Gs3xRd/UH7g7F4Rb4rcq3imDFEQSZH6Ci6wC
         18eBS08da7uBz66Cy6iOYtQoDhRq+BHBwS3jiV5nzE6rwCR3FPNyJOb/Ak8VVA1mi0Ft
         dusyMyF+PAeNGMsD5KJPItXZttGBeXMoNsoWMwIbYSAdJoD2oCAjvXAdC0ZGXwhLesE7
         hpfBYBy9oeitAxBxtg9hKBFJxtz1hPFVR6BGgcAzVrLxd4nFLPTK+MYk9xNq7052YNYD
         TxAw==
X-Gm-Message-State: AOAM531FwtJ6bBZpbn7N8pTNqgCAcgsxaZEMnmXfROW/o7yja1EKGwFd
        JftazwvnDArq6o/EvPewFLf0qW77eOFlA44Fqtwx5jbf+cI=
X-Google-Smtp-Source: ABdhPJyGj/w78E7tRHzbzg7n98LMsQD5FQAldn+z75VXFXhhTwz15kmvRA8lmkfc8qywo7j4kfN8scGkYzp79/VLScc=
X-Received: by 2002:a17:906:3a9b:: with SMTP id y27mr3414366ejd.563.1638324189997;
 Tue, 30 Nov 2021 18:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20211130143526.1820249-1-mudongliangabcd@gmail.com> <20211130145056.GZ18178@kadam>
In-Reply-To: <20211130145056.GZ18178@kadam>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Wed, 1 Dec 2021 10:02:44 +0800
Message-ID: <CAD-N9QVt-5NepnmG-9ywo+JsO4PWOO1jLQ-_=cL=PFNKHYR=CQ@mail.gmail.com>
Subject: Re: [PATCH] driver: pmc_atom: free pmc->regmap in pmc_setup_dev
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 10:51 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Nov 30, 2021 at 10:35:25PM +0800, Dongliang Mu wrote:
> > Smatch reports:
> >
> > drivers/platform/x86/pmc_atom.c:496
> > pmc_setup_dev() warn: 'pmc->regmap' not released on lines: 496.
> >
> > Fix this by deallocating pm->regmap.
> >
> > CC: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/platform/x86/pmc_atom.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
> > index a9d2a4b98e57..95ba108ed716 100644
> > --- a/drivers/platform/x86/pmc_atom.c
> > +++ b/drivers/platform/x86/pmc_atom.c
> > @@ -492,6 +492,7 @@ static int pmc_setup_dev(struct pci_dev *pdev, const struct pci_device_id *ent)
> >               dev_warn(&pdev->dev, "platform clocks register failed: %d\n",
> >                        ret);
> >
> > +     iounmap(pmc->regmap);
>
> This releases it on the success path so it will break the driver.

Yes. I should only deallocate it in the failure handling of
pm_setup_clks. Will modify it in the v2 version.


>
> regards,
> dan carpenter
>
> >       pmc->init = true;
> >       return ret;
> >  }
> > --
> > 2.25.1
