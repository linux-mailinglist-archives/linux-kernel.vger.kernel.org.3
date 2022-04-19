Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFB8507707
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356162AbiDSSHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbiDSSH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:07:29 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47563B57A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:04:45 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id fu34so4147379qtb.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a/JL7/pjikA+XyKdI/ESojFkMMvIJUPcrl8vIy/eNz8=;
        b=hWDyUOTZs07b7hLjIDA0sMUBTpmOkYjS4SXw3s/8ZD8SNF+AhU+MKys9j2oZ/9KwIL
         UZE+VQEbY62NjBxRjIgpuI1rF+Gxw2NWpW4kWnEJPS3OgNtCZ++QD20JJHRxK5zqp3qI
         4TpqkFYammH2W+KMw2Pn6l5Y8xu18BmFh8OHhb3UDv/RdcNcINF57sFv+9cqxhVP3GVB
         TYNwugDTz8qJM5xvabRHaRbt5BurNU89JJn+1A8aFRbwj2+/0e+E+CDh47TdCeok6BUD
         xIe/bS2SGtGIYXpkwVWVYjrSPGXJtYCmwt1yzvk/MYhYPYW8jZZs+bYujBbRo0CVKVs+
         5KvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a/JL7/pjikA+XyKdI/ESojFkMMvIJUPcrl8vIy/eNz8=;
        b=VUqVIkhF3iC9AANgO8GETO1HeMeJCF5zZyz8b1KQR7a+ZTCic3M/I8ALGiz6N+5oEC
         G/DU29XUZCLdRtp72d2ybrOuN9GUZguuengJt9GcQfPXySFCU9wJzsTWvrA9I3LlykMT
         8b40zruF5qdcgSiUQllZdR63ZYQ2z1VE0S2JcqBydTA3gAMg1WukKnPj/8Tmzf8/DTbn
         EgBjwofwMjm8PMPli61wgZ6CLX6nJopEthxqPVqYVCrGLrfugIbt8RJR0ebeRb3pClNM
         HCeVVHGO5OMG0X5naZqi3hKRJgUSzFaJr9ftNreEZHpq9XIPtWBO6UZh6o76ng+1nH/x
         W8zA==
X-Gm-Message-State: AOAM532wLTuzINzY5E4jqAO0E9jtrcmd7TAQJiPgGTgXt5WRzUSQ6DTU
        auwu/Y4xvDmxSBVFzBQkUJ3OWMgwf2VyEsOeIvU9CA==
X-Google-Smtp-Source: ABdhPJwZu/d0HJoxwLRVkwLcus8VLtTp4n+usBSoFaOPwpM/jNzw4GXWEQ6UtytsxuN82+RWG9dzDOn4poGVK6C97iw=
X-Received: by 2002:a05:622a:181:b0:2e1:e70a:ec2a with SMTP id
 s1-20020a05622a018100b002e1e70aec2amr11290673qtw.42.1650391484606; Tue, 19
 Apr 2022 11:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <Ylk5o3EC/hyX5UQ0@google.com> <8eeb08ec-4836-cf7d-2285-8ed74ccfc1cb@linux.intel.com>
 <8986a1c6-b546-7a66-a778-048487624c95@linux.intel.com> <e31ff7c4-7cdc-fdaf-b12c-fc1e51798a1b@linux.intel.com>
In-Reply-To: <e31ff7c4-7cdc-fdaf-b12c-fc1e51798a1b@linux.intel.com>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Tue, 19 Apr 2022 11:04:33 -0700
Message-ID: <CAOReqxgRXbO3s4BgmZjoXmfKyr2MRWLE7jaTEwqh1ovgs_dUMA@mail.gmail.com>
Subject: Re: [Sound-open-firmware] out-of-bounds access in sound/soc/sof/topology.c
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaska Uimonen <jaska.uimonen@linux.intel.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sound Open Firmware <sound-open-firmware@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 10:55 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 4/19/22 06:50, P=C3=A9ter Ujfalusi wrote:
> > Hi Sergey, Pierre,
> >
> > On 15/04/2022 19:00, Pierre-Louis Bossart wrote:
> >> Thanks Sergey for this email.
> >>
> >> On 4/15/22 04:23, Sergey Senozhatsky wrote:
> >>> Hi,
> >>>
> >>> I'm running 5.10.111 LTS, so if this has been fixed already then we d=
efinitely
> >>> want to cherry pick the fix for -stable.
> >
> > I'm afraid, that this is still valid as of today, but in real life I
> > don't think it can happen.
> >
> >>> Anonymous union in this struct is of zero size
> >>>
> >>> /* generic control data */
> >>> struct sof_ipc_ctrl_data {
> >>>         struct sof_ipc_reply rhdr;
> >>>         uint32_t comp_id;
> >>>
> >>>         /* control access and data type */
> >>>         uint32_t type;          /**< enum sof_ipc_ctrl_type */
> >>>         uint32_t cmd;           /**< enum sof_ipc_ctrl_cmd */
> >>>         uint32_t index;         /**< control index for comps > 1 cont=
rol */
> >>>
> >>>         /* control data - can either be appended or DMAed from host *=
/
> >>>         struct sof_ipc_host_buffer buffer;
> >>>         uint32_t num_elems;     /**< in array elems or bytes for data=
 type */
> >>>         uint32_t elems_remaining;       /**< elems remaining if sent =
in parts */
> >>>
> >>>         uint32_t msg_index;     /**< for large messages sent in parts=
 */
> >>>
> >>>         /* reserved for future use */
> >>>         uint32_t reserved[6];
> >>>
> >>>         /* control data - add new types if needed */
> >>>         union {
> >>>                 /* channel values can be used by volume type controls=
 */
> >>>                 struct sof_ipc_ctrl_value_chan chanv[0];
> >>>                 /* component values used by routing controls like mux=
, mixer */
> >>>                 struct sof_ipc_ctrl_value_comp compv[0];
> >>>                 /* data can be used by binary controls */
> >>>                 struct sof_abi_hdr data[0];
> >>>         };
> >>> } __packed;
> >>>
> >>> sof_ipc_ctrl_value_chan and sof_ipc_ctrl_value_comp are of the same
> >>> size - 8 bytes, while sof_abi_hdr is much larger - _at least_ 32 byte=
s
> >>> (`__u32 data[0]` in sof_abi_hdr suggest that there should be more
> >>> payload after header). But they all contribute 0 to sizeof(sof_ipc_ct=
rl_data).
> >>>
> >>> Now control data allocations looks as follows
> >>>
> >>>     scontrol->size =3D struct_size(scontrol->control_data, chanv,
> >>>                                  le32_to_cpu(mc->num_channels));
> >>>     scontrol->control_data =3D kzalloc(scontrol->size, GFP_KERNEL);
> >>>
> >>> Which is sizeof(sof_ipc_ctrl_data) + mc->num_channels * sizeof(sof_ip=
c_ctrl_value_chan)
> >>>
> >>> For some reason it uses sizeof(sof_ipc_ctrl_value_chan), which is not
> >>> the largest member of the union.
> >>>
> >>> And this is where the problem is: in order to make control->data.FOO =
loads
> >>> and stores legal we need mc->num_channels to be of at least 4. So tha=
t
> >>>
> >>>    sizeof(sof_ipc_ctrl_data) + mc->num_channels * sizeof(sof_ipc_ctrl=
_value_chan)
> >>>
> >>>                 92           +        4         *            8
> >>>
> >>> will be the same as
> >>>
> >>>    sizeof(sof_ipc_ctrl_data) + sizeof(sof_abi_hdr).
> >>>
> >>>                 92           +           32
> >>>
> >>> Otherwise scontrol->control_data->data.FOO will access nearby/foreign
> >>> slab object.
> >>>
> >>> And there is at least one such memory access. In sof_get_control_data=
().
> >>>
> >>>     wdata[i].pdata =3D wdata[i].control->control_data->data;
> >>>     *size +=3D wdata[i].pdata->size;
> >>>
> >>>
> >>> pdata->size is at offset 8, but if, say, mc->num_channels =3D=3D 1 th=
en
> >>> we allocate only 8 bytes for pdata, so pdata->size is 4 bytes outside
> >>> of allocated slab object.
> >>>
> >>> Thoughts?
> >
> > Your analyzes are spot on, unfortunately. But...
> >
> > As of today, the sof_get_control_data() is in the call path of
> > (ipc3-topology.c):
> >
> > sof_widget_update_ipc_comp_process() -> sof_process_load() ->
> > sof_get_control_data()
> >
> > sof_widget_update_ipc_comp_process() is the ipc_setup callback for
> > snd_soc_dapm_effect. If I'm not mistaken these only carries bin payload
> > and never MIXER/ENUM/SWITCH/VOLUME.
> > This means that the sof_get_control_data() is only called with
> > SND_SOC_TPLG_TYPE_BYTES and for that the allocated data area is correct=
.
> >
> > This can explain why we have not seen any issues so far. This does not
> > renders the code right, as how it is written atm is wrong.
>
>
> Sergey's results with KASAN show that there's a real-life problem though.=
 I also don't understand how that might happen.
>
> Could it be that these results are with a specific topology where our ass=
umptions are incorrect?
>

That would align with our testing as we are seeing the failing on
exactly once device with a custom topology with a bytes payload. See
sof-jsl-rt5682.m4 with -DWAVES configured for
sof-jsl-rt5682-rt1015.tplg
