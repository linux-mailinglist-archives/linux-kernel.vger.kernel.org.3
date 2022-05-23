Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A13531246
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbiEWOA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbiEWOA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:00:26 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B51657143
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:00:22 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-d39f741ba0so18504501fac.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EHMcsEmvvJZ5YK4UB7JWYPJGU7GAR4VtM9LZecjaIGM=;
        b=11twM4BMmaOPhFAaXF/uaQnE1kug/8X8jA6QhynRe0XODvM8jdj11tEDBvAGtXCDL9
         7qZLKTDRy7CyFvVnRq0C2ydmN5RKk+Vkhku4NVlKnchmFt7ZfXCUsLqnfjagoY1ffCjH
         oPF0qL/RyrCVmp/VRdaTvf1zVsHRScgVlftwAa6qI2MkWGf2x2ts7QjIclVMzgKBNjys
         acC1ScNwKzgsyEHY9Th2z41PCfetEJHPLKluwZy1WuS48APoq82b0Qr/+5h7fPM/szz/
         6DWWglnJv5WmOYrtW37c2VCAwKMw7iMSBTA3Whr1xl0z13AvVjDUHxqaZ3ZkZpGtm0Wh
         +pfA==
X-Gm-Message-State: AOAM532vTBAsGbM1qUaRP4pMpc1+X0rNvTC0WDbGnTuhhG0MZPe99Pgf
        3pcD1/EANlz6ubl90nCDM2IPJG0vjTSevg==
X-Google-Smtp-Source: ABdhPJye//7SNjkYO5SOP/qMnpB89GgsP7Yh4W378RqS8lRstSPiu1nUrvAx1w9mqPnyjlnv1WaFpw==
X-Received: by 2002:a05:6870:ecac:b0:f1:a98e:f2ed with SMTP id eo44-20020a056870ecac00b000f1a98ef2edmr11706747oab.159.1653314420091;
        Mon, 23 May 2022 07:00:20 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id y199-20020a4a45d0000000b0040e699e8d8asm3556397ooa.45.2022.05.23.07.00.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 07:00:19 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id c15-20020a9d684f000000b0060b097c71ecso3238053oto.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:00:19 -0700 (PDT)
X-Received: by 2002:a81:2143:0:b0:2fb:1274:247e with SMTP id
 h64-20020a812143000000b002fb1274247emr23349727ywh.384.1653313941447; Mon, 23
 May 2022 06:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220523132353.1767614-1-Vsujithkumar.Reddy@amd.com> <20220523132353.1767614-2-Vsujithkumar.Reddy@amd.com>
In-Reply-To: <20220523132353.1767614-2-Vsujithkumar.Reddy@amd.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 May 2022 15:52:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUY1MPGT4QO0aL1m+NHrs0eQ357YEOcjKpt0fQ4KSekWg@mail.gmail.com>
Message-ID: <CAMuHMdUY1MPGT4QO0aL1m+NHrs0eQ357YEOcjKpt0fQ4KSekWg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ASoC: amd: acp: Add support for nau8825 and
 max98360 card
To:     V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
Cc:     Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, ajitkumar.pandey@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Bard Liao <bard.liao@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sujith,

On Mon, May 23, 2022 at 3:24 PM V sujith kumar Reddy
<Vsujithkumar.Reddy@amd.com> wrote:
> We have new platform with nau8825 as a primary codec and max98360 as an
> amp codec. Add machine struct to register sof audio based sound card
> on such Chrome machine.
>
> Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>

Thanks for your patch!

> --- a/sound/soc/amd/acp-config.c
> +++ b/sound/soc/amd/acp-config.c
> @@ -130,4 +130,25 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_sof_machines[] = {
>  };
>  EXPORT_SYMBOL(snd_soc_acpi_amd_sof_machines);
>
> +struct snd_soc_acpi_mach snd_soc_acpi_amd_rmb_sof_machines[] = {
> +       {
> +               .id = "AMDI1019",
> +               .drv_name = "rmb-dsp",
> +               .pdata = (void *)&acp_quirk_data,

You can assign an arbitrary pointer type to "void *" without casting.
In fact the cast makes the code less safe, as it prevents the compiler
from informing you in case a future patch changes types.

The same applies to below, and to the existing casts.

> +               .fw_filename = "sof-rmb.ri",
> +               .sof_tplg_filename = "sof-acp-rmb.tplg",
> +       },
> +       {
> +               .id = "10508825",
> +               .drv_name = "nau8825-max",
> +               .pdata = (void *)&acp_quirk_data,
> +               .machine_quirk = snd_soc_acpi_codec_list,
> +               .quirk_data = &amp_max,
> +               .fw_filename = "sof-rmb.ri",
> +               .sof_tplg_filename = "sof-acp-rmb.tplg",
> +       },
> +       {},
> +};

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
