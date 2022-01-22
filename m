Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E438C496D7A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 19:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiAVS7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 13:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiAVS7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 13:59:39 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400FAC06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 10:59:39 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id br17so40902952lfb.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 10:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:references
         :mime-version:content-disposition:in-reply-to;
        bh=YOgNAV2OE08/vjc+opwUwRLryzOXwD8P47Bv9at/big=;
        b=BrN0iYT7O7Y+6aoWx8nS5WV2HjFhqiY2ZbNcEdgBT6kpshWclEUbVo1GFMvY2WDc3G
         92KLGpYSmYIz1gWhfOskZa32QAoQKsSm5i+PE20YTzeLkkxWpFsWIRd3vsFnDp9xbKve
         KIz9QY/PIY8YxReA49bW3e4P6vKk3IXFhtDEaGDHZcAoPs0cATbLLp4gubpYZ42xMGGv
         tjNScbvoTRUJxGLD0qsl2m6f/iEQYkW01RHaPDfhAMblA+9809xADzfrSaFPczFx5/ob
         s0jCaF3Np+FHRKqsqaxAWH26VzAGa51haiSLPGQjCW36b2SnV0+3fgOA/eEwZJTUA2J1
         lRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :references:mime-version:content-disposition:in-reply-to;
        bh=YOgNAV2OE08/vjc+opwUwRLryzOXwD8P47Bv9at/big=;
        b=wDAnhRBeG/uQ19Ydh95a11qq2ZdXEJO4170opTxN0CkhC0ybk7tbd0N5MPpATXD/7G
         +LG5VSDomBC3NRsaViiCMukW69GAkqNIzcyq+Rv+WIqFkNMwMCC2hs/Iq1+0vIFzAchI
         oSoBRwzRU9hDaabBcBhkg8YAP8MTtb2UwY21uHSPVPgkTNeFbHVUT1m6weq5RcGzVZID
         2dF6zyMbRi8gaRCGYCiYvaGyw+j7sUS9Sx0d0TQAb6hKAp8XqQCtikrRxmChAHeagn5Z
         CYd6IMjMJT9A+zysgGFAG9AoMY3yjuj3jH5oaPowcQm5hZURvXgdNmCs/J5Od+tWSIhw
         aS3w==
X-Gm-Message-State: AOAM532O4doVE8ugwuQ2Viu73z3n46LXcnrqM+wXml87eYkhP6x72Yq/
        nD54h8gr9CIokuFh295MBDA=
X-Google-Smtp-Source: ABdhPJxVyiknMrU9F6cc2k0ezCqmOGxAvLdkfUtPO00Wv2a+9zS5aHuwTbjNAwcGhynvmwYfaHFHJw==
X-Received: by 2002:a05:6512:3fb:: with SMTP id n27mr907967lfq.287.1642877977527;
        Sat, 22 Jan 2022 10:59:37 -0800 (PST)
Received: from localhost.localdomain (ntd06459.static.corbina.ru. [95.31.14.149])
        by smtp.gmail.com with ESMTPSA id p16sm497979ljo.89.2022.01.22.10.59.36
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 22 Jan 2022 10:59:36 -0800 (PST)
Date:   Sat, 22 Jan 2022 22:05:22 +0300
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
Message-ID: <20220122190522.ycaygrqcen7d3hj2@localhost.localdomain>
User-Agent: mtt
References: <20220112104827.4aymoth7ua65nwge@localhost.localdomain>
 <20220112201824.qmphnz2hx4frda6e@localhost.localdomain>
 <s5h8rvk85uy.wl-tiwai@suse.de>
 <20220113183141.kla37mbqmo4x6wxp@localhost.localdomain>
 <s5ha6fy46jt.wl-tiwai@suse.de>
 <20220114183720.n46wealclg6spxkp@localhost.localdomain>
 <s5hsftp3027.wl-tiwai@suse.de>
 <20220115152215.kprws5nja2i43qax@localhost.localdomain>
 <s5hilugw0l0.wl-tiwai@suse.de>
 <20220119093249.eaxem33bjqjxcher@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119093249.eaxem33bjqjxcher@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 12:32:51PM +0300, Alexander Sergeyev wrote:
> No, I mean "IO_PAGE_FAULT" and "out of range cmd" don't appear on every 
> unbind & bind. Sometimes it works cleanly.

Unbind & bind generally works without error messages on the first attempt. The 
second unbind & bind tends to generate io page faults like "AMD-Vi: Event 
logged [IO_PAGE_FAULT ...]", but might work fine as well.

In some cases "snd_hda_codec_realtek: out of range cmd" errors are triggered in 
addition to io page faults.

> This seems to be a bogus COEF. But I have no idea from where this
> comes. The values look completely wrong.

In such cases unexpected COEF values are coming from COEF reads during 
read/write pairs that implement update operations.

For example (these traces are from added printk statements):

alc_update_coef_led(codec, led {.idx=0x19, .mask=0x2000, .on=0x2000, .off=0x0}, polarity=0, on=1)
alc_update_coefex_idx(codec, nid, coef_idx=0x19, mask=0x2000, bits_set=0x2000)
alc_update_coef_led(codec, led {.idx=0xb, .mask=0x8, .on=0x8, .off=0x0}, polarity=0, on=1)
alc_update_coefex_idx(codec, nid, coef_idx=0xb, mask=0x8, bits_set=0x8)
snd_hdac_codec_write(hdac, nid, flags=0, verb=0x500, parm=0x19) = 0x0
snd_hdac_codec_write(hdac, nid, flags=0, verb=0x500, parm=0xb) = 0x0
snd_hdac_codec_read(hdac, nid, flags=0, verb=0xc00, parm=0x0) = 0x90170110
alc_update_coefex_idx: alc_read_coefex_idx(codec, nid, coef_idx=0xb) returned 0x90170110
alc_update_coefex_idx: calling alc_write_coefex_idx(codec, nid, coef_idx=0xb, coef_val=0x90170118)
snd_hdac_codec_read(hdac, nid, flags=0, verb=0xc00, parm=0x0) = 0x0
alc_update_coefex_idx: alc_read_coefex_idx(codec, nid, coef_idx=0x19) returned 0x0
alc_update_coefex_idx: calling alc_write_coefex_idx(codec, nid, coef_idx=0x19, coef_val=0x2000)
snd_hdac_codec_write(hdac, nid, flags=0, verb=0x500, parm=0xb) = 0x0
snd_hda_codec_realtek hdaudioC1D0: out of range cmd 0:20:400:90170118
snd_hdac_codec_write(hdac, nid, flags=0, verb=0x400, parm=0x90170118) = 0xffffffff

Then I've specifically added printk on alc_update_coefex_idx entry and exit:

[4.036211] alc_update_coefex_idx(codec, nid, coef_idx=0x10, mask=0x200, bits_set=0x0): entering
[4.036503] alc_update_coefex_idx(codec, nid, coef_idx=0x10, mask=0x200, bits_set=0x0): exiting
[4.036543] alc_update_coefex_idx(codec, nid, coef_idx=0xb, mask=0x8, bits_set=0x0): entering
[4.036546] alc_update_coefex_idx(codec, nid, coef_idx=0x19, mask=0x2000, bits_set=0x0): entering
[4.037139] alc_update_coefex_idx(codec, nid, coef_idx=0xb, mask=0x8, bits_set=0x0): exiting
[4.037609] alc_update_coefex_idx(codec, nid, coef_idx=0x19, mask=0x2000, bits_set=0x0): exiting

I'm not sure about kernel log buffering or maybe the device support for 
pipelining, but is it okay that alc_update_coefex_idx() seem to overlap?
