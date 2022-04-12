Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C874FCC0D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 03:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbiDLB6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 21:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiDLB56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 21:57:58 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F922182D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 18:55:42 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y6so15455428plg.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 18:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zt2MCLsUynrF58WLZPge4c4aYr44Eqz2dZhYMmOS5Gs=;
        b=Zb4vAoTaQFmVRhNdwWW84ug07JoZNN/P11BIhmGxgU4EhfhHWHTZA1BQrrSL4t+H46
         +nANdwyZaWhFm7NkgHzFekxWn/wOiKqinjl4Th7KsSQpJTKtLI9xH+QKGq7SVqjRSsU4
         UTOm/lUNRH7AtJwCKhzsAkduSh50I5G06J1SxKDWghLBsl9ocz6EQX6+qSXh2clqL8R2
         bcECBZxaMHu9T3gDLTpo5an3lPR1shYfv6IJgsgV5hiySTpO6hAhrHyx7iVIMVNU8/ij
         EaBaCn7f+64QjjHjJDGzsEdc8uRqBomlgdNWs3nwpmSvEVvPCe9xBmc69PpnkJLlQl43
         jjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zt2MCLsUynrF58WLZPge4c4aYr44Eqz2dZhYMmOS5Gs=;
        b=3MSzkoWlEjQkRfQ71OdzBJLFn8GK+uCH2me/6tkZUBZFecx/aVlGxf4+lFV6TrIMKy
         W9mZ80pRuIZc6PJQv9jWybtMKNq6yuaGdIz7LoLudmqqtsrLSIOJc3bNjJKdUWdUq4A0
         wCHzRbAPutgExD3FXS8udGYXBwK2C42anu+m9j3xLhIzjoWj8NAQAWDzvUQJqLWBulYm
         leV1XbqSqRuGZzzfJZIHoYYXyQJtC6T8wyzGsxuaRdU3m8NCfmEUJ3WnWJMaVrRKeJX8
         oWqYnJvMTBYV6spdFu1g1Du1o/jt3ep41c/pTrUcn/nnSdEKr0tFxnx4g1PIPzm84/2y
         JXSg==
X-Gm-Message-State: AOAM531ZtzlqTfL//DQnAgwhxjdJCCY9cIFr7Osjx5HKs8LG8y7cFFpY
        h6G8xNZTn0+ohb1L762Tm//Uzj1KPa6xcs7L9ZFl0GiKf1E5
X-Google-Smtp-Source: ABdhPJw9JYxc9NsIoABpsHXytZeNM/RqLxmGvsIscLga/fao6CUd8ma4W2HTLy9D3XzNyhJwCLiWYgWp4gCEXTimDbs=
X-Received: by 2002:a17:903:18e:b0:158:6be6:fbb2 with SMTP id
 z14-20020a170903018e00b001586be6fbb2mr6555570plg.161.1649728542088; Mon, 11
 Apr 2022 18:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220409143950.2570186-1-zheyuma97@gmail.com> <18cb711a-de2a-69e3-d753-7012a67bf2a7@linux.intel.com>
In-Reply-To: <18cb711a-de2a-69e3-d753-7012a67bf2a7@linux.intel.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Tue, 12 Apr 2022 09:55:30 +0800
Message-ID: <CAMhUBjnQO1vtGWc-RjGUE0_PAN7RGp_J7VZbMim1DeTvukS4-Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: Check the bar size before remapping
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     lgirdwood@gmail.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, peter.ujfalusi@linux.intel.com,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 12:23 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 4/9/22 09:39, Zheyu Ma wrote:
> > The driver should use the pci_resource_len() to get the actual length of
> > pci bar, and compare it with the expect value. If the bar size is too
> > small (such as a broken device), the driver should return an error.
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > ---
> >  sound/soc/sof/intel/pci-tng.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/sof/intel/pci-tng.c b/sound/soc/sof/intel/pci-tng.c
> > index 6efef225973f..7d502cc3ca80 100644
> > --- a/sound/soc/sof/intel/pci-tng.c
> > +++ b/sound/soc/sof/intel/pci-tng.c
> > @@ -75,7 +75,11 @@ static int tangier_pci_probe(struct snd_sof_dev *sdev)
> >
> >       /* LPE base */
> >       base = pci_resource_start(pci, desc->resindex_lpe_base) - IRAM_OFFSET;
> > -     size = PCI_BAR_SIZE;
> > +     size = pci_resource_len(pci, desc->resindex_lpe_base);
> > +     if (size < PCI_BAR_SIZE) {
> > +             dev_err(sdev->dev, "error: I/O region is too small.\n");
> > +             return -ENODEV;
> > +     }
>
> May I ask how you found this issue?

Actually, I tested this driver via fuzzing in a simulated environment
and got a crash. Hence, I try to propose a patch and ask for the help
of maintainers to determine whether this is an issue.

Thanks,
Zheyu Ma
