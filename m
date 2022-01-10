Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB327489D07
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbiAJQDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiAJQDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:03:44 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAC1C06173F;
        Mon, 10 Jan 2022 08:03:44 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 127so23021851ybb.4;
        Mon, 10 Jan 2022 08:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iNiCbDbHCeiPxM6ovkMLFr7g6s8ppuv8iXRHsUZEvME=;
        b=qfg98qt32yG91fw8s7UPN9F3sFioZ8oUdRJHyJBA5pRV78LhF7a2X8j+H3A6SLii1V
         nUq0V2Zx7iD4KgzhR4yiCe/byQVGeWqoZ+BRfPu6jiUtTMGXfVyKECswCx10/wosZbay
         DPsTjQQKR0jewr4iEWe6OXN/mXAf+4tzdYsgB/ONq4P3BrF2atPN6uDMCJD4INIj0S7m
         8OWaFE2AH39kuVGr/zTgddR9pfLIrpjPnEZhakZqb3Brp4Nqjun2grw3zYNy5eOq9YKw
         rPWwjxLCKP1N4E6Sj6RXW/2KierivtTXrpLD7jK8eQQLEhVVEp/Ym+FHEB93Li4LCn4R
         8QuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iNiCbDbHCeiPxM6ovkMLFr7g6s8ppuv8iXRHsUZEvME=;
        b=V5/iWyQZxyI0VBceat++eTcv9lWaF7duByfUtRHB0+l2der2QuuQ4BgNMJkw++H+Hj
         YddigQfvmPR3/CUf6pMhRexFmOjGY+mcRoGbDVJE8xcrJCVNwvUrqQ61A06IIJ3Tdyh6
         7n7UmVXfkPAUb53rBJW0WzyUrio/OWbO4zDxG8tKa1cL1asSbTWoBxJ05lL2gnBGXPnk
         7QuDcrSvXgD5ju4oXKylU1Eg9/SosNOjVg/v9AeI/e13hGAZX2a/EKfFOSVNfpNwKKmK
         bcHB9Ia6rDc1cueTJQP3DI92pizVIOczyrPLaHWuzxSvauK/MONIGUM2SNeK7OHiNgZ4
         P67w==
X-Gm-Message-State: AOAM532ycLOyDJVJ4mcfD+s5MFyjZKafpBBMt2IO5uDzsIRfVWZ7f3XZ
        dx0jIhY1wCjMTZFTcbF8MZNyAO0/QQSWaArEwjM=
X-Google-Smtp-Source: ABdhPJzCMeCtb/Dbwxm9+cgpq4Flh/z7O0LjVZI4c1yWTSjd1phU0uJUpCUoEAPrDxgd4MxB/NIePuffqUN6WPw6Myo=
X-Received: by 2002:a25:874a:: with SMTP id e10mr320498ybn.422.1641830623591;
 Mon, 10 Jan 2022 08:03:43 -0800 (PST)
MIME-Version: 1.0
References: <20220110094711.8574-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220110094711.8574-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <2f338a37-f2ca-33e4-284e-5d263f7b93da@intel.com>
In-Reply-To: <2f338a37-f2ca-33e4-284e-5d263f7b93da@intel.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 10 Jan 2022 16:03:17 +0000
Message-ID: <CA+V-a8vz25B=cw_C4YMBRdDxeq7mi8Zc+noqpdHqfMP8eNHYFg@mail.gmail.com>
Subject: Re: [PATCH 1/5] ASoC: sh: rz-ssi: Drop calling rz_ssi_pio_recv() recursively
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Pavel Machek <pavel@denx.de>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cezary,

Thank you for the review.

On Mon, Jan 10, 2022 at 3:48 PM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> On 2022-01-10 10:47 AM, Lad Prabhakar wrote:
> > Instead of recursively calling rz_ssi_pio_recv() use a while loop
> > to read the samples from RX fifo.
>
> Recursion and loops are means for doing something repeatedly. Could you
> specify _why_ such change was made i.e. the conversion from one method
> into the other? I bet the code is not being changed for the sake of
> changing it, the reason is simply missing in the commit message.
>
I had feedback from Pavel "recursion is unwelcome in kernel due to
limited stack use." which I did agree with as a result I have come up
with this patch. Also to add this driver will later be used on Renesas
RZ/A2 SoC's which runs with limited memory.

> Please note that refactoring below function into while-loop has a side
> effect: everything had to be indented by additional tab. Generally,
> readability increases if function is shaped 'linearly'.
>
I do agree, my initial patch just added a jump back to the start of
the function if there are more samples, but Biju suggested to use a
while loop instead.

> > This also fixes an issue where the return value of rz_ssi_pio_recv()
> > was ignored when called recursively.
> >
> > Fixes: 03e786bd4341 ("ASoC: sh: Add RZ/G2L SSIF-2 driver")
> > Reported-by: Pavel Machek <pavel@denx.de>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >   sound/soc/sh/rz-ssi.c | 68 ++++++++++++++++++++++---------------------
> >   1 file changed, 35 insertions(+), 33 deletions(-)
> >
> > diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
> > index fa0cc08f70ec..37466f65c2b0 100644
> > --- a/sound/soc/sh/rz-ssi.c
> > +++ b/sound/soc/sh/rz-ssi.c
> > @@ -411,54 +411,56 @@ static int rz_ssi_pio_recv(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
> >   {
> >       struct snd_pcm_substream *substream = strm->substream;
> >       struct snd_pcm_runtime *runtime;
> > +     bool done = false;
> >       u16 *buf;
> >       int fifo_samples;
> >       int frames_left;
> > -     int samples = 0;
> > +     int samples;
> >       int i;
> >
> >       if (!rz_ssi_stream_is_valid(ssi, strm))
> >               return -EINVAL;
> >
> >       runtime = substream->runtime;
> > -     /* frames left in this period */
> > -     frames_left = runtime->period_size - (strm->buffer_pos %
> > -                                           runtime->period_size);
> > -     if (frames_left == 0)
> > -             frames_left = runtime->period_size;
> >
> > -     /* Samples in RX FIFO */
> > -     fifo_samples = (rz_ssi_reg_readl(ssi, SSIFSR) >>
> > -                     SSIFSR_RDC_SHIFT) & SSIFSR_RDC_MASK;
> > -
> > -     /* Only read full frames at a time */
> > -     while (frames_left && (fifo_samples >= runtime->channels)) {
> > -             samples += runtime->channels;
> > -             fifo_samples -= runtime->channels;
> > -             frames_left--;
> > -     }
> > +     while (!done) {
>
> I wonder if converting this into do-while isn't a better option. Maybe
> I'm missing something but 'done' flag seems to be changed only as an
> outcome of the last if-statement (last step) in this entire procedure.
> Perhaps condition from said if-statement could also be moved into
> 'while' portion of do-while loop.
>
Agreed.

> > +             /* frames left in this period */
> > +             frames_left = runtime->period_size -
> > +                           (strm->buffer_pos % runtime->period_size);
> > +             if (!frames_left)
> > +                     frames_left = runtime->period_size;
> > +
> > +             /* Samples in RX FIFO */
> > +             fifo_samples = (rz_ssi_reg_readl(ssi, SSIFSR) >>
> > +                             SSIFSR_RDC_SHIFT) & SSIFSR_RDC_MASK;
> > +
> > +             /* Only read full frames at a time */
> > +             samples = 0;
> > +             while (frames_left && (fifo_samples >= runtime->channels)) {
> > +                     samples += runtime->channels;
> > +                     fifo_samples -= runtime->channels;
> > +                     frames_left--;
> > +             }
> >
> > -     /* not enough samples yet */
> > -     if (samples == 0)
> > -             return 0;
> > +             /* not enough samples yet */
> > +             if (!samples)
> > +                     break;
> >
> > -     /* calculate new buffer index */
> > -     buf = (u16 *)(runtime->dma_area);
> > -     buf += strm->buffer_pos * runtime->channels;
> > +             /* calculate new buffer index */
> > +             buf = (u16 *)(runtime->dma_area);
>
> Is the second pair of brackets needed?
>
Nope can be dropped.

Cheers,
Prabhakar
