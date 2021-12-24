Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A0047F07E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 19:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353395AbhLXSDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 13:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239382AbhLXSC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 13:02:59 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2BFC061401;
        Fri, 24 Dec 2021 10:02:59 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id d1so4538942ybh.6;
        Fri, 24 Dec 2021 10:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVvqox+iTlfHhecgB/rTm7k1ORQ021fA0GYCwmZyBIo=;
        b=nKzA/ixguPxYzYcM2t4Fzb+Pwj0QNIKul/jnq9y0/BGE/fbF4Yeoopud/eoAtqu9vj
         7MV3uD3raZTD0P+JlDfiz3mArG7PkS6OqZSSHiNjXAX4UkPMzv8i/56J7DLUCyKtq12U
         DNZnN/PM7yZ00fL5se3JmW6X/k9ISSRohYi2dGLhCCVhjvj0byFN1Wibsb/yHET8xcR1
         chS6Iu1KKfzklSqTZHgpV4LW6HzIUOT2n2SAeAjv9PGIhu97uBHCoD+eF+sevN0U7UOk
         ITbby1h6XXNZeIJjG4rPhGV775VIpCmL2BZTflMlqt82uvKLKvK0Y93vfemoxwUG3uQN
         eF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVvqox+iTlfHhecgB/rTm7k1ORQ021fA0GYCwmZyBIo=;
        b=gL6/LWXRWViPZtcxqeQ3sPn4DX7JWPBm27PGypwTq7nu/QutkFlSMuFYgzOLV8fRK6
         mqvUPaTH7jgyNlcz2YrMBBHcGRirDzpBR2d4v9hmMf+7bgXgNnCES+LVx0mwuV1Yk3TW
         rWoVFoErh/JKSZh1/KHM7Wc2owRD+WP8hEaM9J8FaGoT5kkn+0fxONLFbzYxM10eWMUc
         FbheA2LpHk+D6KG6xbOFf4UPguXIlEbKDptMF1gf+XsGaP021f0OihmXpX+VaIdyqe1E
         uz7+3BKZaoIRfpszxej/DYvTZPSwGDQu0d85zb119qCP0yQWDAA9aua2SjL9Pxkqk7c1
         PwJw==
X-Gm-Message-State: AOAM5331+vftNNQ6HkQCZJrk7YUUs3VF0SX1jYfr+veGHVhL/kZcBBDD
        3ECyVqfuJTqnhgsQntabZW15hbsaCgFZ+1TPgrvFG4eyDQw=
X-Google-Smtp-Source: ABdhPJwSqUegg5Cp1Ylxxl7fYbYaIR2Wew5uZGWAWobv2FxosvuLfo0h59Cbkm7N8oOxD/f2KtK13JH9wMqlTkk3Ij0=
X-Received: by 2002:a25:dc4d:: with SMTP id y74mr10168315ybe.422.1640368978402;
 Fri, 24 Dec 2021 10:02:58 -0800 (PST)
MIME-Version: 1.0
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224131300.18198-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <a0a158e2-d77c-e3a4-5858-020674b22d92@omp.ru>
In-Reply-To: <a0a158e2-d77c-e3a4-5858-020674b22d92@omp.ru>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 24 Dec 2021 18:02:32 +0000
Message-ID: <CA+V-a8voiYxB+s2rW9s7OhSsasvVzLO6KscO354+kaQFPO6Zsg@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] ata: pata_platform: Drop use of unlikely() in pata_platform_probe
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

On Fri, Dec 24, 2021 at 5:54 PM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> On 12/24/21 4:12 PM, Lad Prabhakar wrote:
>
> > pata_platform_probe() isn't a hotpath, which makes it's questionable to
> > use unlikely(). Therefore let's simply drop it.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v2-->v3
> > * New patch
> > ---
> >  drivers/ata/pata_platform.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
> > index cb3134bf88eb..29902001e223 100644
> > --- a/drivers/ata/pata_platform.c
> > +++ b/drivers/ata/pata_platform.c
> > @@ -199,14 +199,14 @@ static int pata_platform_probe(struct platform_device *pdev)
> >        * Get the I/O base first
> >        */
> >       io_res = platform_get_mem_or_io(pdev, 0);
> > -     if (unlikely(!io_res))
> > +     if (!io_res)
> >               return -EINVAL;
> >
> >       /*
> >        * Then the CTL base
> >        */
> >       ctl_res = platform_get_mem_or_io(pdev, 1);
> > -     if (unlikely(!ctl_res))
> > +     if (!ctl_res)
> >               return -EINVAL;
>
>    I think you should combine this with patch #1.
>
I'd like to keep the changes separate from patch #1, as it's unrelated.

Cheers,
Prabhakar
