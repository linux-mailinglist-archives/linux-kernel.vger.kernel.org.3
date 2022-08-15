Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE9A592ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbiHOHzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiHOHze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:55:34 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000B195AA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:55:31 -0700 (PDT)
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5B3B83F13D
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 07:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660550130;
        bh=ule+HDSKgvtTqS232O7dmuPtdYvAd/9M7yxVUXUSf3w=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=t/lskzEqkXLYu4o06EAh7EeDmP41keThMuMOCqpJVQSKZ+Kjfpb0l5T1w34DzhAYy
         GbCJw718sfRVGF/caJ0iPSQ2m8HjN8aa3N2ZkeyppRCKsw1/zsB+v6lPAQ7/Xq8/uC
         g2bDZEa/x2Vy8RIs5ngOCzIwGoWdT+iPOvvQ5a7SpN/SyHWEjJ4rW/c2Xa9ImlW/5F
         Mfij5rf7FQ6xByFCK4leQ71WyLr5I+pH7NFSMR9pC5v2mM3V+vEj2o79rKjYHId9ed
         DZcLBULM4o6OtnY9atjiy/NcsYUf3bjtEYyutsfYCjImZXlEjUmJCXtAlBHsjKpTvh
         yc4VPAXVV7V+w==
Received: by mail-ot1-f72.google.com with SMTP id f40-20020a9d03ab000000b00636a9fee9d3so3336649otf.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ule+HDSKgvtTqS232O7dmuPtdYvAd/9M7yxVUXUSf3w=;
        b=dVPqqzavO3f2A346Sq/2ahPizx+U8/8+lZm+Ft/8YHpOQthgROpCqM3Q7MC+WgTmhn
         3dCJWyGTz+59e93W+IFTbOizHYHLt3GCvdo+NYCVYBBDqOnPRs0SoRDZBf0gN0f7dIzC
         gU+o290sXksyRxsZqVuO+t/xqyF7MMt2eLHI1GYG9HhJlrF6sA+YglJzIGlCfxkwPyug
         w3a+wU+r0dLzXf5zR5u1m5VuVzXy3z9gQkwHZhIjRsg9p5xg4235oM5XwJDtrKi1R2Fw
         +b0FmChampbqCmhdSPvPPtY/ejimUF38eYBmFlwG7uTxJq4MBbQqpG07hyf5Yp4rhJ5b
         DUCg==
X-Gm-Message-State: ACgBeo1EMw7jJ9ZRy46W7ZAapuiJHj5MKip8AA8BpRK0Z4A/9O2V2JS+
        9+QAj5jLgJjPIlGLxVSieW0hbvz6wEGMBing0elev3qxQUGkv76oG15Ig8bkK6LRSKzubP4t/wp
        QyBVZ1KlXmZJ1RYkg29bXnKEETQCpY0RMHd9J0SHXaRMWD2LLv8bsidmSpg==
X-Received: by 2002:a05:6871:28c:b0:10e:a56a:1c47 with SMTP id i12-20020a056871028c00b0010ea56a1c47mr10209691oae.176.1660550129148;
        Mon, 15 Aug 2022 00:55:29 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4TVTe8GJVrtR00Jw4z959FyKcd/IqG6uzD4AiPZSXT/nQQVih8xFWt5R0sEtNsHG+38tGvgQkfhf0KgSfPz9c=
X-Received: by 2002:a05:6871:28c:b0:10e:a56a:1c47 with SMTP id
 i12-20020a056871028c00b0010ea56a1c47mr10209684oae.176.1660550128857; Mon, 15
 Aug 2022 00:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220719144753.252231-1-kai.heng.feng@canonical.com>
 <bd59b06a-de49-2a1a-d2a2-351957fec6d0@perex.cz> <CAAd53p6ru7CJ=pJ2knCL5pgU_Y+nA=yTPscKk225zTD-fv4qQg@mail.gmail.com>
 <34bddb2f-dc57-c08c-358e-26cf7824c203@perex.cz> <514f0fda-9475-e163-fd64-0bc675dd3447@linux.intel.com>
In-Reply-To: <514f0fda-9475-e163-fd64-0bc675dd3447@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 15 Aug 2022 15:55:16 +0800
Message-ID: <CAAd53p5xkjKkpvZu2nNu5EaJC9d060g5GAhV_gRD2ouGjKY9AQ@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda: Skip creating captures in SOF context
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, tiwai@suse.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 9:31 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 7/20/22 02:52, Jaroslav Kysela wrote:
> > Dne 20. 07. 22 v 3:45 Kai-Heng Feng napsal(a):
> >> On Tue, Jul 19, 2022 at 11:41 PM Jaroslav Kysela <perex@perex.cz> wrote:
> >>>
> >>> Dne 19. 07. 22 v 16:47 Kai-Heng Feng napsal(a):
> >>>> On HP laptops that use SOF driver for DMIC, the micmute LED doesn't
> >>>> light up when mic is muted after commit 9b014266ef8a ("ASoC: SOF:
> >>>> topology: use new sound control LED layer").
> >>>>
> >>>> The micmute LED itself is still working via sysfs, but it doesn't follow
> >>>> mute anymore. That's because unlike vendors like Dell and Lenovo, HP
> >>>> laptops use HDA codec to control mute LEDs instead of ACPI. So on HP
> >>>> laptops, both SOF and HDA create captures with
> >>>> SNDRV_CTL_ELEM_ACCESS_MIC_LED access, snd_ctl_led_set_state() considers
> >>>> there are two different kcontrols and one of them is not muted.
> >>>
> >>> It does not mean that it's a wrong behavior. When both controls are muted, the
> >>> LED should be turned on. It just requires that all inputs are off (and it may
> >>> be the default - probably we can set in UCM or so). If you turn the "Capture
> >>> Switch" off in amixer / alsamixer, do things work as expected ?
> >>
> >> Yes. When all captures are muted the micmute LED is on.
> >>
> >>>
> >>>> So skip creating captures for HDA when it's called from SOF, the
> >>>> captures are already handled by SOF.
> >>>
> >>> The capture controls are for other inputs like external analog microphone. If
> >>> it is required to suppress the MIC LED for some hardware, just skip the
> >>> "spec->mic_mute_led = 1" assignment in hda_generic.c . Also, the check
> >>> "codec->core.type != HDA_DEV_ASOC" is not sufficient, because you don't know,
> >>> if the topology really sets the MIC LED flag.
> >>
> >> AFAIK the external analog microphone on DMIC laptop is driven by SOF driver too.
> >> If those capture controls are indeed needed for external analog mics,
> >> use UCM to mute them by default won't work either.
> >
> > Could you describe this ? I though that only DMIC is handled by SOF when HDA
> > codec is in the system. There is a separate analog codec for external analog
> > microphone or the HDA codec is somehow connected to SOF/DSP ? If so, how ?
>
> The HDA codec is connected in the same way in all cases, there's no
> hardware/electrical/routing difference.
>
> When used, the SOF driver will handle ALL links, be they DMIC or
> HDAudio. The difference for HDaudio is that instead of a single DMA
> transfer (DDR->FIFO), we have a first 'Host' DMA into the DSP SRAM, some
> processing and a second 'Link' DMA from DSP SRAM to the HDaudio FIFO
> (reversed flow for capture).

So is this approach sufficient for this issue? Or should I explore
other possibilities?

Kai-Heng

>
