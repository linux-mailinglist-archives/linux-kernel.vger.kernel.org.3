Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78728492CE0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347305AbiARR7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbiARR7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:59:49 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED964C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 09:59:48 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n8so2792049wmk.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 09:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4NNb0iIvZBgGyZQ4UOGRTomYdHNCz/kJcx5v8bWpRIE=;
        b=YnOSAqTE/k+dKD+eCBKsQqpyCz6FWqm/6qUnScINkpLr/olE6LbtfBSnGaIBak++fe
         6Aq3juSfmV9rjd/qhrPHAp+80r/9ltZ3byANKVGBpyIno3gTGF1AxvoUogboc0TVP4bJ
         XL19UT47yU4iRbZBGXKDCgcA3mskKukNZF0mVp9X65O7oUw1lwWy67X8QU41J3I2ted9
         NEAzpClayKAtPGJkKow+/O9l/jCD2KnTdVjydy9QVkW8bc9/nDBKSYcR3X0TKw8f2JX/
         CU5iY7OKoTCd5kjtWlv/r92+JlKaVpdsuSQtJO/AkZ3kxNYbhV6nQKcBk4ymPtdq3wUC
         y8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4NNb0iIvZBgGyZQ4UOGRTomYdHNCz/kJcx5v8bWpRIE=;
        b=yfWXbqDX9Bzu0MoLt3YEGvaQd6rnvwKmpfC/hAWJHa+nNkdxujMlfSiq8r6+5VKtzt
         phKRGK9LKMeoMg6tQy37E0Z7cbEsz+Bcid8aEhqC1E1fiTcR9YDGtiGktlzD97U50MDQ
         K06CP1ARAs7q/dXHpl0ozrDABqDb1EM9jsSdAvF3GK157WL9W+8XkHqK8GFcqfEt0Mkj
         nlELJFP4r8HtQEEWuDcCwMyWnCqY77pxNI63G0hEodIZ8tCVuw9DDHQCKy+bf3tPkdCR
         BX6upnv47NN5XBbgTJPDnhxWFrXcwwlQHDszFGT5u+P8EHeyimDXR8M42lxEknZgQ5xR
         im5Q==
X-Gm-Message-State: AOAM531DWGQNAMZcklvNIp9Q2zws1WOxyIOdaT0SYxyaOBLSKOeLvKWd
        9kfTepN+e2znDsNkpFIzNIuUHo+zwVM4gfU/Zrs=
X-Google-Smtp-Source: ABdhPJx8nfmvZPRwW8qJMS4nMvvBthcZW9GL5M0SrVXLSQ0BrwQ9gFiQoujOW6gPj79Orkntp2Eur2pSBFnUaOFrvnQ=
X-Received: by 2002:a05:600c:3d12:: with SMTP id bh18mr15919791wmb.177.1642528787353;
 Tue, 18 Jan 2022 09:59:47 -0800 (PST)
MIME-Version: 1.0
References: <20220113161341.371345-1-daniel.baluta@oss.nxp.com> <d7e63f52-a98e-0c99-906b-6c03b25da572@intel.com>
In-Reply-To: <d7e63f52-a98e-0c99-906b-6c03b25da572@intel.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 18 Jan 2022 19:59:35 +0200
Message-ID: <CAEnQRZA0YLFQWgPfwF2VPEPUYcLFXtUU88MozgbN_aqtodGnMA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: SOF: compr: Add compress ops implementation
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 12:43 AM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> On 2022-01-13 5:13 PM, Daniel Baluta wrote:
> > From: Daniel Baluta <daniel.baluta@nxp.com>
> >
> > Implement snd_compress_ops. There are a lot of similarities with
> > PCM implementation.
> >
> > For now we use sof_ipc_pcm_params to transfer compress parameters to SOF
> > firmware.
> >
> > This will be changed in the future once we either add new compress
> > parameters to SOF or enhance existing sof_ipc_pcm_params structure
> > to support all native compress params.
> >
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>
> ...
>
> > +static int create_page_table(struct snd_soc_component *component,
> > +                          struct snd_compr_stream *cstream,
> > +                          unsigned char *dma_area, size_t size)
> > +{
> > +     struct snd_soc_pcm_runtime *rtd = cstream->private_data;
> > +     struct snd_dma_buffer *dmab = cstream->runtime->dma_buffer_p;
> > +     int dir = cstream->direction;
> > +     struct snd_sof_pcm *spcm;
>
> The layout of this declaration block is weird - it's neither a
> reversed-christmas-tree nor higher->lower complexity (e.g. structs ->
> primitives). Could you explain why it is shaped as is?

You are right, never put too much thought for this. Looking at SOF anyhow,
it doesn't seem that all kind of styles are used including just random order.

Will fix it :).

>
> > +
> > +     spcm = snd_sof_find_spcm_dai(component, rtd);
> > +     if (!spcm)
> > +             return -EINVAL;
> > +
> > +     return snd_sof_create_page_table(component->dev, dmab,
> > +                                      spcm->stream[dir].page_table.area, size);
> > +}
> > +
> > +int sof_compr_open(struct snd_soc_component *component,
> > +                struct snd_compr_stream *cstream)
> > +{
> > +     struct snd_soc_pcm_runtime *rtd = cstream->private_data;
> > +     struct snd_compr_runtime *runtime = cstream->runtime;
>
> Making use of 'rtd' and 'runtime' simultaneously within a function make
> it less readable.

I see. I will use rtd for snd_soc_pcm_runtime as usual and crtd for
snd_compr_runtime.
Naming is hard.

>
> > +     struct sof_compr_stream *sstream;
> > +     struct snd_sof_pcm *spcm;
> > +     int dir;
> > +
> > +     sstream = kzalloc(sizeof(*sstream), GFP_KERNEL);
> > +     if (!sstream)
> > +             return -ENOMEM;
> > +
> > +     spcm = snd_sof_find_spcm_dai(component, rtd);
> > +     if (!spcm) {
> > +             kfree(sstream);
> > +             return -EINVAL;
> > +     }
> > +
> > +     dir = cstream->direction;
> > +
> > +     if (spcm->stream[dir].cstream) {
> > +             kfree(sstream);
> > +             return -EBUSY;
> > +     }
>
> Could you explain why this check is needed? i.e. Is is possible for
> compress stream to be opened "twice"?

This is needed because compress upper layers do not forbid opening the
device twice
but also it doesn't make much sense to open it twice.

So, I just have exclusive access to Compr device and the rest of the
calls to return
-EBUSY.

Same approach as in sound/soc/uniphier/aio-compress.c
>
> > +
> > +     spcm->stream[dir].cstream = cstream;
> > +     spcm->stream[dir].posn.host_posn = 0;
> > +     spcm->stream[dir].posn.dai_posn = 0;
> > +     spcm->prepared[dir] = false;
> > +
> > +     runtime->private_data = sstream;
> > +
> > +     return 0;
> > +}
> > +
> > +int sof_compr_free(struct snd_soc_component *component,
> > +                struct snd_compr_stream *cstream)
> > +{
> > +     struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
> > +     struct snd_soc_pcm_runtime *rtd = cstream->private_data;
> > +     struct snd_compr_runtime *runtime = cstream->runtime;
>
> Ditto.

Thanks. Will fix.

>
> > +     struct sof_compr_stream *sstream = runtime->private_data;
> > +     struct sof_ipc_stream stream;
> > +     struct sof_ipc_reply reply;
> > +     struct snd_sof_pcm *spcm;
> > +     int ret = 0;
> > +
> > +     spcm = snd_sof_find_spcm_dai(component, rtd);
> > +     if (!spcm)
> > +             return -EINVAL;
> > +
> > +     stream.hdr.size = sizeof(stream);
> > +     stream.hdr.cmd = SOF_IPC_GLB_STREAM_MSG | SOF_IPC_STREAM_PCM_FREE;
> > +     stream.comp_id = spcm->stream[cstream->direction].comp_id;
> > +
> > +     if (spcm->prepared[cstream->direction]) {
> > +             ret = sof_ipc_tx_message(sdev->ipc, stream.hdr.cmd,
> > +                                      &stream, sizeof(stream),
> > +                                      &reply, sizeof(reply));
> > +             if (!ret)
> > +                     spcm->prepared[cstream->direction] = false;
>
> Why is the assignment conditional? If IPC fails, is the ->prepared flag
> respected and addressed later on? It does not seem to happen here.
>

If this call fails it mean that freeing the pipeline has failed and we
return an error
to the upper layer.

I dont think it makes sense to mark the stream as freed (prepared =
false) if the IPC has failed
we just return an error to the upper layers.

I'm not sure if we can do anything useful with respect to failures in
sof_compr_free other then
report it to upper layers and keep internal error.

If the upper layers decide to call again compr_open() the prepare will
be set at that point to false.

> > +     }
> > +
> > +     cancel_work_sync(&spcm->stream[cstream->direction].period_elapsed_work);
> > +     spcm->stream[cstream->direction].cstream = NULL;
> > +     kfree(sstream);
> > +
> > +     return ret;
> > +}
> > +
> > +int sof_compr_set_params(struct snd_soc_component *component,
> > +                      struct snd_compr_stream *cstream, struct snd_compr_params *params)
> > +{
> > +     struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
> > +     struct snd_soc_pcm_runtime *rtd_pcm = cstream->private_data;
> > +     struct snd_compr_runtime *rtd = cstream->runtime;
> > +     struct sof_compr_stream *sstream = rtd->private_data;
> > +     struct sof_ipc_pcm_params_reply ipc_params_reply;
> > +     struct sof_ipc_pcm_params pcm;
> > +     struct snd_sof_pcm *spcm;
> > +     int ret;
> > +
> > +     spcm = snd_sof_find_spcm_dai(component, rtd_pcm);
> > +     if (!spcm)
> > +             return -EINVAL;
> > +
> > +     cstream->dma_buffer.dev.type = SNDRV_DMA_TYPE_DEV_SG;
> > +     cstream->dma_buffer.dev.dev = sdev->dev;
> > +     ret = snd_compr_malloc_pages(cstream, rtd->buffer_size);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     create_page_table(component, cstream, rtd->dma_area, rtd->dma_bytes);
>
> Shouldn't the result of create_page_table() be tested before moving on?

You are right. Will fix.

>
>
> ...
>
> > +int sof_compr_trigger(struct snd_soc_component *component,
> > +                   struct snd_compr_stream *cstream, int cmd)
> > +{
> > +     struct sof_ipc_stream stream;
> > +     struct sof_ipc_reply reply;
> > +     struct snd_soc_pcm_runtime *rtd = cstream->private_data;
> > +     struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
> > +     struct snd_sof_pcm *spcm;
>
> Similarly to create_page_table() case, layout of this declaration block
> is weird. Perhaps I'm just unaware of the convention used within this
> directory.

True. I just added the fields at random points while they were used. If you look
at the sof directory this happens all over the place.

>
>
> ...
>
> > +static int sof_compr_pointer(struct snd_soc_component *component,
> > +                          struct snd_compr_stream *cstream,
> > +                          struct snd_compr_tstamp *tstamp)
> > +{
> > +     struct snd_compr_runtime *runtime = cstream->runtime;
> > +     struct sof_compr_stream *sstream = runtime->private_data;
>
> I'd suggest declaring single local variable instead. The 'runtime' one
> is unused except for the initial 'sstream' assignemnt.

Will do.
>
> > +
> > +     tstamp->sampling_rate = sstream->sample_rate;
> > +     tstamp->copied_total = sstream->copied_total;
> > +
> > +     return 0;
> > +}
>
> ...
>
> > diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
> > index 087935192ce8..d001a762a866 100644
> > --- a/sound/soc/sof/sof-priv.h
> > +++ b/sound/soc/sof/sof-priv.h
> > @@ -108,6 +108,12 @@ enum sof_debugfs_access_type {
> >       SOF_DEBUGFS_ACCESS_D0_ONLY,
> >   };
> >
> > +struct sof_compr_stream {
> > +     unsigned int copied_total;
> > +     unsigned int sample_rate;
> > +     size_t posn_offset;
> > +};
>
> Some streaming-related PCM structs follow snd_sof_xxx naming pattern
> instead, e.g.: snd_sof_pcm. Is the naming convention for compress
> streams seen here intentional?

Hmm, again naming is hard. I will think about it.
>
> > +
> >   struct snd_sof_dev;
> >   struct snd_sof_ipc_msg;
> >   struct snd_sof_ipc;
> >
