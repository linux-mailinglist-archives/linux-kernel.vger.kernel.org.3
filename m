Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754A4470A61
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343603AbhLJTgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245684AbhLJTgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:36:32 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1329C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 11:32:56 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b40so19830324lfv.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 11:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=16vBrnrnLm/KrdSkDqkkNxS0xymKNayV9NN0QHH9Fsc=;
        b=Fc16dXw7QrcrWym6s0uO3FUlkAd4uNZUZrWupNfe7G2/CR/8Yl570W2sz91fC34oEo
         A7iSCYIityuJlPftUpYO1kCLgwJpyP8uR0AoZdJxVM1AUwsAuQB2fZii12OInz4H5e+X
         soS/WQ6Pfl6KwacAVi9hiM9vJsOBiheOBKkNBFz3hpIQSpYRqz7a2Kt65q6oxfcFFmFo
         dIitB01qrAc1hS4i5DJuLYgrRIBlNg7c6POSBsYCTGByiarvRQEEJccD3c901j+vS4wA
         ffF/lNG9tDuAPV9taCSFHXSUnkuRHSNpDotI+gbNd2ruK02Vax+OLd6B7mzg22FyN1hD
         StAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=16vBrnrnLm/KrdSkDqkkNxS0xymKNayV9NN0QHH9Fsc=;
        b=bui5WiVECKhSfNVlQY1WzXepdj3hSItCYCwTlVnPKP96eWBwXEkyfnf7d9idtrl4uA
         ZuNcbfKVqE5TMHyyAsyc9mIdY+GuK6q5MeFAEeOWFGGCv0lf2ySH4J3FHIq4FHJDO88k
         Yy7MXDBK2nXYs0l7DCla+JpQ5xDyd73n0VXLsR0oyOAsB7INIGzhrSkBbYl83LZ3jCoj
         vXxu6QQTUTtGeaATv3/wMBG6aiG9IYfWuuwiEF9aCeTPmRSsoQ98EOPoUIN1gU+4A5ak
         9A5A1bHMon0Xmzo+yljt+P37LMjBTcjvMPqU1C+vxfl0z+6t5F5MMYx1d1UHO8EQJ/og
         awFA==
X-Gm-Message-State: AOAM531VphXbHvGqLbKMyPE4ylv4gv8ddmyYxMthnCcIZFMK+Wq489m7
        26fGDrCOWhoFNk9alL/h+wdq7Ybjdp3YDUIblc20aQ==
X-Google-Smtp-Source: ABdhPJxF3+fnmbuK2XdBNyM0bI0+qKHJ0qxHxOEv72SG10GFXigVk57qhPNNilvsV+RXMaejOkWh09XKp2X17SEkv20=
X-Received: by 2002:ac2:4d19:: with SMTP id r25mr13865559lfi.82.1639164774486;
 Fri, 10 Dec 2021 11:32:54 -0800 (PST)
MIME-Version: 1.0
References: <20211209195141.1165233-1-nathan@kernel.org>
In-Reply-To: <20211209195141.1165233-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 10 Dec 2021 11:32:42 -0800
Message-ID: <CAKwvOdmKUsQc7UoxzqPvsH+FqxvxHGd43N9dDiYn1T31gZ94Sg@mail.gmail.com>
Subject: Re: [PATCH v2] staging: greybus: fix stack size warning with UBSAN
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 11:52 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang warns about excessive stack usage in this driver when
> UBSAN is enabled:
>
> drivers/staging/greybus/audio_topology.c:977:12: error: stack frame size of 1836 bytes in function 'gbaudio_tplg_create_widget' [-Werror,-Wframe-larger-than=]
>
> Rework this code to no longer use compound literals for
> initializing the structure in each case, but instead keep
> the common bits in a preallocated constant array and copy
> them as needed.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1535
> Link: https://lore.kernel.org/r/20210103223541.2790855-1-arnd@kernel.org/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [nathan: Address review comments from v1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for helping to get this across the finish line.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> v1 -> v2: https://lore.kernel.org/r/20210103223541.2790855-1-arnd@kernel.org/
>
> * Use NULL for name field in SND_DOC_DAPM_* in gbaudio_widgets (Alex).
>
> * Do not eliminate *dw assignment within the switch cases, as invalid
>   enum values in-between valid enum values (such as snd_soc_dapm_demux)
>   would not be handled properly by the "if value is greater than the
>   array size" check (Alex). This addresses a few other comments by Alex
>   and Dan because w->type is not checked against the array's size.
>
> Arnd, if you disagree with this approach, please let me know so that we
> can get this fixed in a way that everyone is happy with.
>
>  drivers/staging/greybus/audio_topology.c | 92 ++++++++++++------------
>  1 file changed, 45 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
> index 1e613d42d823..7f7d558b76d0 100644
> --- a/drivers/staging/greybus/audio_topology.c
> +++ b/drivers/staging/greybus/audio_topology.c
> @@ -974,6 +974,44 @@ static int gbaudio_widget_event(struct snd_soc_dapm_widget *w,
>         return ret;
>  }
>
> +static const struct snd_soc_dapm_widget gbaudio_widgets[] = {
> +       [snd_soc_dapm_spk]      = SND_SOC_DAPM_SPK(NULL, gbcodec_event_spk),
> +       [snd_soc_dapm_hp]       = SND_SOC_DAPM_HP(NULL, gbcodec_event_hp),
> +       [snd_soc_dapm_mic]      = SND_SOC_DAPM_MIC(NULL, gbcodec_event_int_mic),
> +       [snd_soc_dapm_output]   = SND_SOC_DAPM_OUTPUT(NULL),
> +       [snd_soc_dapm_input]    = SND_SOC_DAPM_INPUT(NULL),
> +       [snd_soc_dapm_switch]   = SND_SOC_DAPM_SWITCH_E(NULL, SND_SOC_NOPM,
> +                                       0, 0, NULL,
> +                                       gbaudio_widget_event,
> +                                       SND_SOC_DAPM_PRE_PMU |
> +                                       SND_SOC_DAPM_POST_PMD),
> +       [snd_soc_dapm_pga]      = SND_SOC_DAPM_PGA_E(NULL, SND_SOC_NOPM,
> +                                       0, 0, NULL, 0,
> +                                       gbaudio_widget_event,
> +                                       SND_SOC_DAPM_PRE_PMU |
> +                                       SND_SOC_DAPM_POST_PMD),
> +       [snd_soc_dapm_mixer]    = SND_SOC_DAPM_MIXER_E(NULL, SND_SOC_NOPM,
> +                                       0, 0, NULL, 0,
> +                                       gbaudio_widget_event,
> +                                       SND_SOC_DAPM_PRE_PMU |
> +                                       SND_SOC_DAPM_POST_PMD),
> +       [snd_soc_dapm_mux]      = SND_SOC_DAPM_MUX_E(NULL, SND_SOC_NOPM,
> +                                       0, 0, NULL,
> +                                       gbaudio_widget_event,
> +                                       SND_SOC_DAPM_PRE_PMU |
> +                                       SND_SOC_DAPM_POST_PMD),
> +       [snd_soc_dapm_aif_in]   = SND_SOC_DAPM_AIF_IN_E(NULL, NULL, 0,
> +                                       SND_SOC_NOPM, 0, 0,
> +                                       gbaudio_widget_event,
> +                                       SND_SOC_DAPM_PRE_PMU |
> +                                       SND_SOC_DAPM_POST_PMD),
> +       [snd_soc_dapm_aif_out]  = SND_SOC_DAPM_AIF_OUT_E(NULL, NULL, 0,
> +                                       SND_SOC_NOPM, 0, 0,
> +                                       gbaudio_widget_event,
> +                                       SND_SOC_DAPM_PRE_PMU |
> +                                       SND_SOC_DAPM_POST_PMD),
> +};
> +
>  static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
>                                       struct snd_soc_dapm_widget *dw,
>                                       struct gb_audio_widget *w, int *w_size)
> @@ -1052,77 +1090,37 @@ static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
>
>         switch (w->type) {
>         case snd_soc_dapm_spk:
> -               *dw = (struct snd_soc_dapm_widget)
> -                       SND_SOC_DAPM_SPK(w->name, gbcodec_event_spk);
> +               *dw = gbaudio_widgets[w->type];
>                 module->op_devices |= GBAUDIO_DEVICE_OUT_SPEAKER;
>                 break;
>         case snd_soc_dapm_hp:
> -               *dw = (struct snd_soc_dapm_widget)
> -                       SND_SOC_DAPM_HP(w->name, gbcodec_event_hp);
> +               *dw = gbaudio_widgets[w->type];
>                 module->op_devices |= (GBAUDIO_DEVICE_OUT_WIRED_HEADSET
>                                         | GBAUDIO_DEVICE_OUT_WIRED_HEADPHONE);
>                 module->ip_devices |= GBAUDIO_DEVICE_IN_WIRED_HEADSET;
>                 break;
>         case snd_soc_dapm_mic:
> -               *dw = (struct snd_soc_dapm_widget)
> -                       SND_SOC_DAPM_MIC(w->name, gbcodec_event_int_mic);
> +               *dw = gbaudio_widgets[w->type];
>                 module->ip_devices |= GBAUDIO_DEVICE_IN_BUILTIN_MIC;
>                 break;
>         case snd_soc_dapm_output:
> -               *dw = (struct snd_soc_dapm_widget)SND_SOC_DAPM_OUTPUT(w->name);
> -               break;
>         case snd_soc_dapm_input:
> -               *dw = (struct snd_soc_dapm_widget)SND_SOC_DAPM_INPUT(w->name);
> -               break;
>         case snd_soc_dapm_switch:
> -               *dw = (struct snd_soc_dapm_widget)
> -                       SND_SOC_DAPM_SWITCH_E(w->name, SND_SOC_NOPM, 0, 0,
> -                                             widget_kctls,
> -                                             gbaudio_widget_event,
> -                                             SND_SOC_DAPM_PRE_PMU |
> -                                             SND_SOC_DAPM_POST_PMD);
> -               break;
>         case snd_soc_dapm_pga:
> -               *dw = (struct snd_soc_dapm_widget)
> -                       SND_SOC_DAPM_PGA_E(w->name, SND_SOC_NOPM, 0, 0, NULL, 0,
> -                                          gbaudio_widget_event,
> -                                          SND_SOC_DAPM_PRE_PMU |
> -                                          SND_SOC_DAPM_POST_PMD);
> -               break;
>         case snd_soc_dapm_mixer:
> -               *dw = (struct snd_soc_dapm_widget)
> -                       SND_SOC_DAPM_MIXER_E(w->name, SND_SOC_NOPM, 0, 0, NULL,
> -                                            0, gbaudio_widget_event,
> -                                            SND_SOC_DAPM_PRE_PMU |
> -                                            SND_SOC_DAPM_POST_PMD);
> -               break;
>         case snd_soc_dapm_mux:
> -               *dw = (struct snd_soc_dapm_widget)
> -                       SND_SOC_DAPM_MUX_E(w->name, SND_SOC_NOPM, 0, 0,
> -                                          widget_kctls, gbaudio_widget_event,
> -                                          SND_SOC_DAPM_PRE_PMU |
> -                                          SND_SOC_DAPM_POST_PMD);
> +               *dw = gbaudio_widgets[w->type];
>                 break;
>         case snd_soc_dapm_aif_in:
> -               *dw = (struct snd_soc_dapm_widget)
> -                       SND_SOC_DAPM_AIF_IN_E(w->name, w->sname, 0,
> -                                             SND_SOC_NOPM,
> -                                             0, 0, gbaudio_widget_event,
> -                                             SND_SOC_DAPM_PRE_PMU |
> -                                             SND_SOC_DAPM_POST_PMD);
> -               break;
>         case snd_soc_dapm_aif_out:
> -               *dw = (struct snd_soc_dapm_widget)
> -                       SND_SOC_DAPM_AIF_OUT_E(w->name, w->sname, 0,
> -                                              SND_SOC_NOPM,
> -                                              0, 0, gbaudio_widget_event,
> -                                              SND_SOC_DAPM_PRE_PMU |
> -                                              SND_SOC_DAPM_POST_PMD);
> +               *dw = gbaudio_widgets[w->type];
> +               dw->sname = w->sname;
>                 break;
>         default:
>                 ret = -EINVAL;
>                 goto error;
>         }
> +       dw->name = w->name;
>
>         dev_dbg(module->dev, "%s: widget of type %d created\n", dw->name,
>                 dw->id);
>
> base-commit: 42eb8fdac2fc5d62392dcfcf0253753e821a97b0
> --
> 2.34.1
>
>


-- 
Thanks,
~Nick Desaulniers
