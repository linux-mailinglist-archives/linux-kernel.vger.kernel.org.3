Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F16492D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348032AbiARS1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348025AbiARS1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:27:13 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7923C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:27:12 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p18so6912wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 10:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WgQNd9jvDGSha0ZOEMYIqms6ohSARrZSwqDxbZSH43Y=;
        b=kBaY/RYbdbEQuVsoV59cdNSiYYEv/9+RmudEw6xW7hlLv4mFdmtVkuKSNLjmFUvOzc
         LhMS9vPI5BvRCSoKCUaHMQied6UDI80sIe2M+NMvfM5rVsCBmt4+sF7c0HqZq/t32L8b
         SVd4BOlZthBeWJS7STMIFEPM7BttCoyc71zKfXqB84igRKImCXDZsaiQ4uBvK7t/KXiH
         qzv2PcAYYTILng7EK+AMn/GGN6XX0TiiIP0fods4ChIYz3Toa29XEv/07uJy+4Ht8hQH
         MD+IQEhFDi/MVApmFBMCev09BdH3OiDDxE7JchRS8Vd9cXZdz0wM9v7qd4snLFKtmtO/
         orDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WgQNd9jvDGSha0ZOEMYIqms6ohSARrZSwqDxbZSH43Y=;
        b=qOVliS3xh6xu9BP5js/biyDKRAEZJzBcRYd1R55JNUuCWqNW5Vb3q/FBomP7Va2vin
         EmdzCfsi+nEP2HqNG01TdB4b2Ff3nCSNUipA+Esc9Obew4wmdf7HBIMX6S7n7zEBdd1h
         THteE62KwUxkGCbbKHICz69ShleZV1xv8nwA8ovOppLZmR4D9d5ktkYjR5GqOWrGTyLR
         fQVOcl6nbnFR0FYxce3h12Bgqyn7qKg3SGIEoGbrG+dEWwXvDZUDjy3pThgi2G02Ks2R
         DRKrBALxUTfGL+bjWHxSzkQl4nXuGZa7lJK+RFF/zkN6jtmz3p3bpvQ39yTYRa/FnS1Z
         eLyA==
X-Gm-Message-State: AOAM5313qGNC/VZqSCnIWzAQL+cvTTo8/MUggVGbKXMgagnK1tG9n/JZ
        Ebpv0xMpPWJj+1+VJ32mDCEC88kfjZ7hzUcawbyH9xnk
X-Google-Smtp-Source: ABdhPJz+Qq6Hg8o9CGDBWKWvXnZqajzRt83pZwriF9mRbH7PQHVCmjFwWz39UQqiwfmkprJbnih58o5swmprfBfSNyU=
X-Received: by 2002:adf:d4c8:: with SMTP id w8mr25603273wrk.137.1642530430846;
 Tue, 18 Jan 2022 10:27:10 -0800 (PST)
MIME-Version: 1.0
References: <20220113161341.371345-1-daniel.baluta@oss.nxp.com> <9b3d28f3-aa2b-ade9-4160-752b349bdeab@linux.intel.com>
In-Reply-To: <9b3d28f3-aa2b-ade9-4160-752b349bdeab@linux.intel.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 18 Jan 2022 20:26:58 +0200
Message-ID: <CAEnQRZBsJbcdx_H9ChcPTGEbe+Ok8mVGG+1wVYe2pDF+9RqbQA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: SOF: compr: Add compress ops implementation
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pierre for comments.

On Sat, Jan 15, 2022 at 1:01 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> Thanks for starting this work Daniel.
>
> > +int sof_compr_get_params(struct snd_soc_component *component,
> > +                      struct snd_compr_stream *cstream, struct snd_codec *params)
> > +{
> > +     return 0;
> > +}
>
> You should probably add a statement along the lines of:
>
> /* TODO: we don't query the supported codecs for now, if the application
> asks for an unsupported codec the set_params() will fail
> */
>
> .get_codec_caps is also missing, it should be documented as something we
> want to add.

Will do.

>
> > +static int sof_compr_pointer(struct snd_soc_component *component,
> > +                          struct snd_compr_stream *cstream,
> > +                          struct snd_compr_tstamp *tstamp)
> > +{
> > +     struct snd_compr_runtime *runtime = cstream->runtime;
> > +     struct sof_compr_stream *sstream = runtime->private_data;
> > +
> > +     tstamp->sampling_rate = sstream->sample_rate;
> > +     tstamp->copied_total = sstream->copied_total;
>
> Humm, this doesn't return any information on how many PCM samples were
> generated (pcm_frames) or rendered (pcm_io_frames).

This is on my TODO list. I think there is some more work needed to be
done in FW.

>
> I don't think the existing SOF firmware has this level of detail for
> now, you should at least document it as to be added in the future.
>
> In addition, the .pointer callback can be used at different times, and
> for added precision the information should be queried from the firmware
> via IPC or by looking up counters in the SRAM windows.
>
> I don't think it's good enough to update the information on a fragment
> elapsed event. It will work for sure in terms of reporting compressed
> data transfers, but it's not good enough for an application to report
> time elapsed.

Very good observations here.

>
> > +struct sof_compr_stream {
> > +     unsigned int copied_total;
> > +     unsigned int sample_rate;
> > +     size_t posn_offset;
> > +};
>
> do you need an SOF-specific definition? This looks awfully similar to
> snd_compr_tstamp:
>
> struct snd_compr_tstamp {
>         __u32 byte_offset;
>         __u32 copied_total;
>         __u32 pcm_frames;
>         __u32 pcm_io_frames;
>         __u32 sampling_rate;
> }

There is no need for a SOF specific definition. I think we can use
that for now. We can change it later if we
need new fields.
