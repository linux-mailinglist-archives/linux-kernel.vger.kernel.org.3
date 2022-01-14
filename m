Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6994F48EFE3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 19:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239065AbiANSbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 13:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236305AbiANSbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 13:31:42 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE59C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 10:31:41 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id o12so16279798lfu.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 10:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:references
         :mime-version:content-disposition:in-reply-to;
        bh=0QoMS9tW+FujbuAvwpX64y12Q6x1wpjN/ARJKsGQ958=;
        b=RTsqqX8PvMOztDxaNDcdDU1pO8eta9X4w+YyBwKqTLjYQGdTfwiazHVEjJNBF6BZPO
         sfujMT8JKv78tLu3B1uEuHkJSCOVYkPp8hAcn0+kiSsfe+B7ZLmP/e4/sLHZzvbkBNlP
         YDJaXSHOeRTNKr94l5gk+XCz3gwiL7Qw3TeebK+FyXaFrhNV/ynCQ9A6EVYUGF3J02sk
         zAZjEWfFL9YPImddE3po5Maa8Z2TKh9r6vtzLkbl8iZMS7/rSLtzybqSDWg0aageQQmz
         H2qwVasI8sr0WUOHw7TBkhBvv1pDMQEdmyNGRoqp9ig/+uvpsZirKPFdUX7cbjNiWUXi
         Us1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :references:mime-version:content-disposition:in-reply-to;
        bh=0QoMS9tW+FujbuAvwpX64y12Q6x1wpjN/ARJKsGQ958=;
        b=aXtiakl/7Ldo170M+ngoXXaYp+5q2TjuqR5axYKNYO2BooXL3YRJPNKEEdKy5A769F
         KQQhOjxDWI4oSJO6xcPoBkYquorAOXC8GYqcw4hEEZ/vSKJNdXrsBBaSzAyNS7x12iSF
         B2qm2pw/T++eEC+a9B3un90orjB3HajEWD5ZJQuma7pD9DDrEFjzwhyTZRINrS7h4ev1
         iC4YcSmQW+L4dciIpmI+PO01gDGyDo9p6Qb2VevJzpBi4QZiUtDGBXFSZAKyZ7fSo0mq
         k6Whv14Cks42oDck93v5o/xNquBPGmovneKuDOTe4jQktNq3HGau6NBeqKfYue1MMYyF
         CuSw==
X-Gm-Message-State: AOAM530uHXMgfZeuMaF0cHMExgEldHUV5Etx4IAGfMuJOtUAgFeBCm3i
        igL3NJhs2EUouRJXsksuUFU=
X-Google-Smtp-Source: ABdhPJyEKAfJfJEbAwR6p75nS+3fcsqesPn/gPeHmm5NpF9OkZ2jlOTSBmqydTpPa/OVQEatvwt11A==
X-Received: by 2002:a05:651c:11d0:: with SMTP id z16mr161948ljo.13.1642185100240;
        Fri, 14 Jan 2022 10:31:40 -0800 (PST)
Received: from localhost.localdomain (ntd06459.static.corbina.ru. [95.31.14.149])
        by smtp.gmail.com with ESMTPSA id c9sm652951lfv.180.2022.01.14.10.31.39
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 14 Jan 2022 10:31:39 -0800 (PST)
Date:   Fri, 14 Jan 2022 21:37:20 +0300
From:   Alexander Sergeyev <sergeev917@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jeremy Szu <jeremy.szu@canonical.com>, tiwai@suse.com,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Kailang Yang <kailang@realtek.com>,
        open list <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Hui Wang <hui.wang@canonical.com>,
        PeiSen Hou <pshou@realtek.com>
Subject: Re: [PATCH 1/4] ALSA: hda/realtek: fix mute/micmute LEDs for HP 855
 G8
Message-ID: <20220114183720.n46wealclg6spxkp@localhost.localdomain>
User-Agent: mtt
References: <20210519170357.58410-1-jeremy.szu@canonical.com>
 <20220111195229.a77wrpjclqwrx4bx@localhost.localdomain>
 <s5ho84h9tit.wl-tiwai@suse.de>
 <20220112101249.ya73jvpmqmeh4ggg@localhost.localdomain>
 <s5hilup9s87.wl-tiwai@suse.de>
 <20220112104827.4aymoth7ua65nwge@localhost.localdomain>
 <20220112201824.qmphnz2hx4frda6e@localhost.localdomain>
 <s5h8rvk85uy.wl-tiwai@suse.de>
 <20220113183141.kla37mbqmo4x6wxp@localhost.localdomain>
 <s5ha6fy46jt.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5ha6fy46jt.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 05:37:42PM +0100, Takashi Iwai wrote:
> > I assume that the referred repository is the one at [1]. I've tried
> > 081c73701ef0 "ALSA: hda: intel-dsp-config: reorder the config
> > table". It crashed with nearly identical logs.
>
> OK, then it's still something to do with the led cdev
> unregisteration.
>
> Could you try the patch below?

This patch solved the BUG problem. But after unbind/bind micmute LED stopped 
working. Speakers and mute LED are fine though.

Dmesg:
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff800 flags=0x0020]
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff800 flags=0x0020]
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff800 flags=0x0020]
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff800 flags=0x0020]
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff820 flags=0x0020]
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff820 flags=0x0020]
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff820 flags=0x0020]
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff820 flags=0x0020]
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff840 flags=0x0020]
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff840 flags=0x0020]
...
snd_hda_codec_realtek hdaudioC1D0: out of range cmd 0:20:400:90170118
snd_hda_codec_realtek hdaudioC1D0: out of range cmd 0:20:400:411111f0
snd_hda_codec_realtek hdaudioC1D0: out of range cmd 0:20:400:270300
...
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffffb80 flags=0x0020]
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffffb80 flags=0x0020]
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffffba0 flags=0x0020]
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffffba0 flags=0x0020]
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffffba0 flags=0x0020]
snd_hda_codec_realtek hdaudioC1D0: out of range cmd 0:20:400:80000000
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffffba0 flags=0x0020]
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffffbc0 flags=0x0020]
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffffbc0 flags=0x0020]
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffffbc0 flags=0x0020]
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffffbc0 flags=0x0020]
snd_hda_codec_realtek hdaudioC1D0: out of range cmd 0:20:400:20010b

> > I got some time to poke the internal microphone. It works, but
> > oddities are there as well. Initially I get "Mic Boost", "Capture" and
> > "Internal Mic Boost" controls in alsamixer. When I run arecord,
> > "Digital" control appears, but it cannot be changed until arecord is
> > stopped. Subsequent arecord calls do not lock "Digital" control. This
> > control affects sensitivity of the microphone and seems useful.
>
> That's presumably an alsa-lib softvol stuff.  It's created
> dynamically.  So not really a kernel problem.

Okay, that's good to know.
