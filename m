Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5443647E23B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 12:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347921AbhLWLZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 06:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347935AbhLWLZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 06:25:35 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068BFC061757;
        Thu, 23 Dec 2021 03:25:35 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id y68so15511163ybe.1;
        Thu, 23 Dec 2021 03:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+EW6uTesENThTFc4s17fHHTkcAhWOBt2ggrMqULnXI=;
        b=iKMltosjyfu8lpZihmGV/S/+EDMzqMOQzrLJzgkNpYE9L9hA4DzqFWcnsL/jODtcEF
         iV/nZtTf0qMoFS88A/4T/WvfKv3/KDKiTf3ygKKNuw+86EvYPJSyrVPGcTo1EI/smIoO
         7oynHu8eP+aP2/cABr6B9cyTDjP/CEaJm+mdx6ZUxo/AW+A53RuynLzdsKdjtQn1o3/n
         SzvAqtISI+zM6E3MdubMysiVkeYakxQCHvz+sn77xWrrQB+sc0iWLRnEDYPWFcbCYwg8
         08O1H4N/vuOhzoH1zouU5B++vMSFSBLpAgZA0jWbo7x8BlfwSgTctZkqE03KCtdlzPY7
         VIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+EW6uTesENThTFc4s17fHHTkcAhWOBt2ggrMqULnXI=;
        b=hf+Ez9MNaIMqT3ZHm8/kFODYK7W7LfRFbLqkBbxcAelkanghbL3QlSD6D1XeVLFjI2
         hVrbQPMQgOaJ9aumaup+IyREnnVNbt4KGZQCLE3vavq2zrFkEUZnN2xzythVB1eG2dMm
         skU0P+GjJ0MgRhCBqlNTnG4lbINuAISmFzGELNpXwgRPV0u20UIZ/t9R8sgnLbhVTIgr
         l0ioW1Uuk6GX135Rz9sNrY/eBgef+RJADU6KoT+M8aL3b+iJ16tfaNTFODdjEbx2rbZZ
         cJWVCt5HWhEExIsjxgR5S4MXKwnyfzNn7utU4zZLGkhBGmdBCK7w5DOeNuiZpwN5HPZ+
         fmkg==
X-Gm-Message-State: AOAM5327d/8GhnUYaPriigNk4XbxbwbGvShDGPNYBdEGoVXhUwgZx67Q
        kbsrhwUaS4Sa/tF2VHTFXpCk7CjwOIv+lhCEQxxO79GdIn7kHA==
X-Google-Smtp-Source: ABdhPJwtJh6p7eaZtOiDVFeY1YorFdPrQq4NUjQ0nz2Yl1mkm2bzgCkeh74I6UNpA1uh6EQGdU4G2PCy5zC8I6oEHIw=
X-Received: by 2002:a25:abe3:: with SMTP id v90mr2564489ybi.315.1640258734255;
 Thu, 23 Dec 2021 03:25:34 -0800 (PST)
MIME-Version: 1.0
References: <20211221162614.25308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211221162614.25308-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <d851cdc5-78c6-ff35-979f-7aec71f3cb9b@opensource.wdc.com>
In-Reply-To: <d851cdc5-78c6-ff35-979f-7aec71f3cb9b@opensource.wdc.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 23 Dec 2021 11:25:08 +0000
Message-ID: <CA+V-a8vn_H4iyoosiTJTJaHXSM7OsgabiX6aG6dhhFPNJRwh9g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ata: pata_platform: make use of platform_get_mem_or_io()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Damien,

Thank you for the review.

On Thu, Dec 23, 2021 at 12:35 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 12/22/21 01:26, Lad Prabhakar wrote:
> > Make use of platform_get_mem_or_io() to simplify the code.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1-->v2
> > * No change
> > ---
> >  drivers/ata/pata_platform.c | 18 ++++++------------
> >  1 file changed, 6 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
> > index 028329428b75..cb3134bf88eb 100644
> > --- a/drivers/ata/pata_platform.c
> > +++ b/drivers/ata/pata_platform.c
> > @@ -198,22 +198,16 @@ static int pata_platform_probe(struct platform_device *pdev)
> >       /*
> >        * Get the I/O base first
> >        */
> > -     io_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> > -     if (io_res == NULL) {
> > -             io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -             if (unlikely(io_res == NULL))
> > -                     return -EINVAL;
> > -     }
> > +     io_res = platform_get_mem_or_io(pdev, 0);
> > +     if (unlikely(!io_res))
>
> This is not the hot path, so I do not think that the unlikely() is
> necessary here.
>
Ok will drop the unlikely() and just check for NULL instead.

> > +             return -EINVAL;
> >
> >       /*
> >        * Then the CTL base
> >        */
> > -     ctl_res = platform_get_resource(pdev, IORESOURCE_IO, 1);
> > -     if (ctl_res == NULL) {
> > -             ctl_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > -             if (unlikely(ctl_res == NULL))
> > -                     return -EINVAL;
> > -     }
> > +     ctl_res = platform_get_mem_or_io(pdev, 1);
> > +     if (unlikely(!ctl_res))
>
> Same comment here.
>
ditto.

Cheers,
Prabhakar

> > +             return -EINVAL;
> >
> >       /*
> >        * And the IRQ
>
>
> --
> Damien Le Moal
> Western Digital Research
