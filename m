Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E64347F07C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 19:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353387AbhLXSCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 13:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239382AbhLXSCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 13:02:00 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE43C061401;
        Fri, 24 Dec 2021 10:02:00 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id j83so6297961ybg.2;
        Fri, 24 Dec 2021 10:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BasdlpcaREt0yk8cVYkIRc8znOmDIx2/XzTO3EflF3s=;
        b=Q9Mo6Yps7qihN8C8A8P1z9ZHuQ5bH2qhiqVqquIEEZF/KWfLV/YL0P76lBggkN9H+D
         99Z+qlis+y3romjB0zUqgmf5cxa6Ybonusan1J1/CQD67tMpuYwNOhwxFqOKnYeQl8/n
         xQmfkNCCJ0UkeoccTEFWRfmII4IT+oCfRmsD2OT/iRInYmMAq3O+ZWLko+YaKJh3iaKn
         gQ6JSRStK2d1dharaaTl3GpWjy+bEv6A0fUfTqXdlVG/zgAVK+I09FJcjmXzZ048sYH5
         Ul+iYsNDZ8cfyvBzrsnWLqvqJg9st9pZOq3bvPqRyBZ+VnsjM1JNMawvyr8U5ItPb29s
         mdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BasdlpcaREt0yk8cVYkIRc8znOmDIx2/XzTO3EflF3s=;
        b=D7o9hqgaXVUo23XU81TZfetLAPGA5X5nLcFqTTaoPsh++QgRcXrZrHv7TZucnmkOuI
         qb2+8kW/PB72lpc0N2+u/pqSPbmjcMJe2L/N0K4UlHAoqYAoc+uoard6YOi5q12l8Znt
         Dbw7js7kPd2PUfNtPDh/Ywc688SvoSM4zhCJ50ivPllQGSfHx2mPQoTq7UMo214TfLQq
         qP37EwNYNf5hZsoal794Q22Vcawj3zpJ4oLl70SrgSuFLTz3ukGdIMYoCBFqxWE1He0P
         9biesZwhdO425OgLVTWqR3+obWKFcv8Upecb5AbHwSe8yGWtGHjZbx8vPCwkSmZLSmtV
         uFyw==
X-Gm-Message-State: AOAM533DCwtqgLGTSIa66xusgfXOi6pkDLkBbo9okM21l+ZKLyEdUr1H
        WpQRd7j8b3RyME1STScuSzlRpgSd23Om/xI3j+N9BQdgDUtgtQ==
X-Google-Smtp-Source: ABdhPJxBk+0eggN5vooiZ+oQ9QwWZQ9Qu8ipRLeuZMScmH2omKbGabpM1UYYtqfTDQkdfRxzEZQlPojoCcaKM/uMtJI=
X-Received: by 2002:a25:3b06:: with SMTP id i6mr6447062yba.41.1640368919263;
 Fri, 24 Dec 2021 10:01:59 -0800 (PST)
MIME-Version: 1.0
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224131300.18198-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <b2bb45db-d0ab-a816-a50c-cdef0c125761@omp.ru>
In-Reply-To: <b2bb45db-d0ab-a816-a50c-cdef0c125761@omp.ru>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 24 Dec 2021 18:01:33 +0000
Message-ID: <CA+V-a8tXgWAV2v2-DJh7TMzmNp0W-33=OJf1PTC5KDqZODtLdw@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] ata: pata_platform: Make use of platform_get_mem_or_io()
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

Thank you for the review.

On Fri, Dec 24, 2021 at 5:56 PM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> On 12/24/21 4:12 PM, Lad Prabhakar wrote:
>
> > Make use of platform_get_mem_or_io() to simplify the code.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
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
>    You don't have to keep unlikely() here -- the first *if* doesn't have it anyway,
> only the 2nd one does...
>
Agreed the first if doesn't have it, ie unlikely() will only be hit
when resource 0 isn't mem/IO, So with my patch introduced if mem/io is
NULL  unlikely() will be called. So there is "NO" behavioral change.

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
>    Ditto.
>
Ditto.

Cheers,
Prabhakar
