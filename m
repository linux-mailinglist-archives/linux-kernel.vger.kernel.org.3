Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6BC4A6736
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 22:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiBAVn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 16:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbiBAVnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 16:43:50 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AE7C06173D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 13:43:50 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id b12so17254253qvz.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 13:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D+mAcFAcbyBszsXN3/NgIUpqHIBliIiifG7mp3GXGbE=;
        b=b9BgcXMSncv17JHEDhnOzkHw0nRL2RywNKVr2K0qJei+Zb8LTy9UiNrKnprc0mwvx/
         BPDZxGjhCDDV19HEwJwT/poVjkdjeoqOOx3ceF4gHbQkjZ7qHI0IqJU/WUvedmxMbQfO
         CIbCGB8JqYUKZjwSCb+TcNpW3TAt6ufT0h5oQvEjWAsHl7njwQftTZ6ue44y8/cOVu+l
         RgNxYi+5Jf74hRxvf+MGnOiGOOMafaQyBr+5lUTHXWcYtVfXt7QEuDCzxIOahYQKDbTh
         riCPBtDoNpKwA8asxVHEbRHdWSLH9kBpQXGjLw8MKavkD0O66u8RP2WpyVx+U4wC1HGP
         ogSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+mAcFAcbyBszsXN3/NgIUpqHIBliIiifG7mp3GXGbE=;
        b=wfnAG9vp7l02OD73/E4ZfrQYsPESU1hH0xA7nDdTVqlu7qH5uOZZaLHJ12DjXY8FtX
         tmllrnj/bvaBImomKpHjJn9nEhVEM04rVmLQOxYHINJQcw09ysm42z5Y5gwrFzbMq0Qe
         KcUhvGmCgMp/tyVB4ikhbx+eh2usj4g/0GJ3cZ49S1p0dLbd3Z+X75Od731n/9OcG95T
         4p69gRoQVvtLDa9dAVTLSI0FlOwGu9sxCxFAkO4mFmORa0yOor/P9qzu3ht3XMi0o/Xs
         ov1Dhj8PFvu+EJtnsNnnUQ5rDQhpV1diBcWeahyu+UKWrIWohYM+CQh1xNYHxSUpHYm+
         TP8g==
X-Gm-Message-State: AOAM5300gUnXHn3jnpdm7XzMpqpqCz7ojwx+kVxQfCYzCdbTKapFgNtt
        aAkVPli76nyefismc3t5zMFYKacVaWu5o+myaBHUFQ==
X-Google-Smtp-Source: ABdhPJzy4KEvuEJ0e35E06ab4IJotqMmxZ09tClGNfNzICcszftHhCxs33z02NpnF9dVL6VePfg5x3WK/kvf3K9ijKM=
X-Received: by 2002:a05:6214:da2:: with SMTP id h2mr24368654qvh.49.1643751829350;
 Tue, 01 Feb 2022 13:43:49 -0800 (PST)
MIME-Version: 1.0
References: <20220131203225.1418648-1-vsujithkumar.reddy@amd.com> <YfmCWuD88sT8YxfG@sirena.org.uk>
In-Reply-To: <YfmCWuD88sT8YxfG@sirena.org.uk>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Tue, 1 Feb 2022 13:43:38 -0800
Message-ID: <CAOReqxiGW+8BR5VRVHDJuBXxkpB_oQ_4TTNBqm1tuK6shUKLpg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: amd: acp: Set gpio_spkr_en to None for max speaker
 amplifer in machine driver
To:     Mark Brown <broonie@kernel.org>
Cc:     V sujith kumar Reddy <vsujithkumar.reddy@amd.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        Vijendar.Mukunda@amd.com,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
        "Pandey, Ajit Kumar" <ajitkumar.pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 10:56 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Feb 01, 2022 at 02:02:15AM +0530, V sujith kumar Reddy wrote:
>
> > Maxim codec driver already enabling/disabling spk_en_gpio in form of sd_mode gpio
> > hence remove such gpio access control from machine driver to avoid conflict
>
>
> > -     .gpio_spkr_en = EN_SPKR_GPIO_NK,
> > +     .gpio_spkr_en = EN_SPKR_GPIO_NONE,
> >  };
> >
> >  static struct acp_card_drvdata sof_rt5682s_rt1019_data = {
> > @@ -56,7 +56,7 @@ static struct acp_card_drvdata sof_rt5682s_max_data = {
> >       .hs_codec_id = RT5682S,
> >       .amp_codec_id = MAX98360A,
> >       .dmic_codec_id = DMIC,
> > -     .gpio_spkr_en = EN_SPKR_GPIO_NK,
> > +     .gpio_spkr_en = EN_SPKR_GPIO_NONE,
> >  };
>
> This looks like a good fix for the immediate issue which fixes the
> MAX9360A systems without breaking the RT1019 ones, however as I said in
> the thread about Curtis' revert it's not clear what the ideal thing is
> here.  There's no documentation about the RT1019 that I can find so it's
> not clear to me what exactly the GPIO is controlling, if it's part of
> the RT1019 or something else.  That influences where the most tasteful
> place to control this GPIO is.  Curtis noted that the RT1019 driver
> includes gpiolib headers but that could just as easily be cut'n'paste as
> intentional.  What's the story here?
>
> I do also note that the current code just turns the GPIO on and leaves
> it on which presumably isn't great from a power management point of
> view.

Yes that is correct, this is the quick fix that will alleviate the
gpio contention issue. But I think there is a better solution here.
According to the sheet I have, the pin for the alc1019 is the same as
the max98357a and its a shutdown pin for the amp.
