Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A97B489D47
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbiAJQOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237138AbiAJQOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:14:46 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5BAC06173F;
        Mon, 10 Jan 2022 08:14:45 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id m6so29028733ybc.9;
        Mon, 10 Jan 2022 08:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfameUlI3NFh/eiKlVIDlcLQ1LgxydYWfgkxIKQRh5o=;
        b=PPwLgLihBu75oNCWTPz+GduJZam/VEGHjtYHz+0uIGEqYKAZr4m2zYRtMuieVGkmyn
         /1jdQxVtEoLkrJ+mYPIPKEWeWoHyNQYSScXtzY+TFNBDUFJO59/WC1pO8Oq9YF+4vAFH
         nDhHpfhxfFW+Y/uIsBl5ZM03bAzp7aWVcPx6qUYJYUh9MKBtiFAt5XnZOWqbcj/5NX2H
         NIrnQgBxkUQfCkx/zwSgW23rH9jGxC0Loxr+1SGEjca3aQPa0YTHn/8jsauqZ84kfwsg
         /5qUNfD7awWHxtbiea2tXYqR2ALlhz6K6rvBwNdaI37OZmP9RwzNhtA396ix/qJKZhf+
         YLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfameUlI3NFh/eiKlVIDlcLQ1LgxydYWfgkxIKQRh5o=;
        b=zfjv5Ee0YDGqVUjmlO7fmvhBGJ3vy4fO8XB2CLI6c4y86Xm6w2qymW0JwOmeT4Tq4I
         mjKy/mCritaKXtMKlG2nC+BAZLGNJe3QcOL6QqPYXFpnJSFyb0fHewb8sUeGBs2Ot789
         JPWUzsDYAFo2UFy2/Ag+xKhKYUzd4s3HTiCIkZ3v1f4GANgolQh9Rt+EA8k9nfP+GoGG
         rXNV3qyVKFdDeqozujSRVJFhCQwpbIsL8CDkFnvzWhc0opU7pcHh4UqdBHmg4XDLYLWd
         WEXq4CbgH/HS6TEZextbV66DuqVindQJPCZxWQzx7bzTjXyuIRtUXGkkWchAS+qFIK4U
         2JfQ==
X-Gm-Message-State: AOAM532dJnabUeDpStVwzxkJr2v2vAqYCRqM38I4dDgq237KiHMNFLxt
        k+oFgZm5EtfyTLC474uljM+6oAsND5dQD3kIiL/DgQg6uMg=
X-Google-Smtp-Source: ABdhPJyKfH/4O1OUHcYGewLnhey7GOxbVTJRPNmaBEICFXi3X1R7yyrGCU9Yb05npdXjQdg7GiCtybY5Ce/CDrz5FD0=
X-Received: by 2002:a25:254d:: with SMTP id l74mr313553ybl.669.1641831284833;
 Mon, 10 Jan 2022 08:14:44 -0800 (PST)
MIME-Version: 1.0
References: <20220110094711.8574-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220110094711.8574-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <YdxMT02wvvWw85Bn@sirena.org.uk>
In-Reply-To: <YdxMT02wvvWw85Bn@sirena.org.uk>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 10 Jan 2022 16:14:19 +0000
Message-ID: <CA+V-a8svCAMm_zsujMEzyZ2gdWu4y_DumRsQNK6sL9re_rGurw@mail.gmail.com>
Subject: Re: [PATCH 5/5] ASoC: sh: rz-ssi: Add functions to get/set substream pointer
To:     Mark Brown <broonie@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Pavel Machek <pavel@denx.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thank you for the review.

On Mon, Jan 10, 2022 at 3:10 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jan 10, 2022 at 09:47:11AM +0000, Lad Prabhakar wrote:
>
> > +static struct snd_pcm_substream *rz_ssi_get_substream(struct rz_ssi_stream *strm)
> > +{
> > +     struct rz_ssi_priv *ssi = strm->priv;
> > +     struct snd_pcm_substream *substream;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&ssi->lock, flags);
> > +     substream = strm->substream;
> > +     spin_unlock_irqrestore(&ssi->lock, flags);
>
> This locking doesn't seem useful, we just take a copy of the lock and
> then immediately return so the lock isn't protecting anything in
> particular - the caller can happily continue using the substream after
> the variable has been updated.
>
Ok will drop the locking from get function.

Cheers,
Prabhakar
