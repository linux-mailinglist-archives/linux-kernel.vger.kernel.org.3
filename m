Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D3848DDA1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbiAMS0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiAMS0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:26:03 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54167C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 10:26:03 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o12so5911964lfu.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 10:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:references
         :mime-version:content-disposition:in-reply-to;
        bh=B5TgjevVKySYpGG9iiTbPrO6S1lbtFaG1P8WhSMYH4c=;
        b=UzRFXjsLQqyBBJrZpn6riJa0F6IToDXEXWwsDdd0iKURLbdOw7f8L0+GWNZCQTn26A
         ZbI1FRb/JGmh0sMLsheiYLNVjajxsUWngD6tJ2l+yWy6Q58sVO6mGxu2KnBos7yRFkbB
         oJarzLK8mWpTPs6HqXiqYwPFjXnzGQQA+k6C1A1CQ6RGYCsZRFSaIPShe7btB/EJLqp8
         jjn4hvuYePMXnS4J2T5S2A4lu0QvwZZs/jsOUEK+Qz5MQ1rl69Hg3yDEY9T2N6ZeQjBL
         nDV/Dhv+w8HQ3D35QzDQEqZ3EcxReThKkqGXl/SvozsOb/hL6/GS3oCQ+67iPZc7O80g
         6Ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :references:mime-version:content-disposition:in-reply-to;
        bh=B5TgjevVKySYpGG9iiTbPrO6S1lbtFaG1P8WhSMYH4c=;
        b=5t7xpa2ptAvvTACFdcSCqD+1Ow1+xUthJYd8agw/keb16vVZffSztSiTbd6D0Z2j0y
         ZCzqi3Ggm2FtzvHcIyDR+dCJkZf5JUSeym0SNXnQli18NZYcjGvwkwBottGHbZkKmhbP
         cN21pRJ7BR/zrDoIisC9SpcEyx2ssp0v4/0fpbpf+uU+D6q3YV1xv4ai1ZondjPGxGhz
         s7aGh2Yp13TkF8SGKzPoXlNOLGMhT5+CaGq84PPBlkNRCridRJNX1l1GSOC1NCWKizQZ
         2NLU4+6SYLVMIdcug4lMv1th9zIDZm7EY4wzsDYOwB/n74Kgtq7tpNIeznKcJAvAdI+5
         +ADg==
X-Gm-Message-State: AOAM530UXE13jjMEvdAAULOW1XguHThY3KZWnJ9UaizkvRGmF9kkcoYm
        EUXYE7zXXGJxxX9wRt5tC/M=
X-Google-Smtp-Source: ABdhPJy27IUTBd+Z8Rh7lbHoBqnHWejZI2QSJ3yGabDrmkSjP71QVVenPekZHZMOk95hjmya4tSwTg==
X-Received: by 2002:a05:6512:1512:: with SMTP id bq18mr1275324lfb.13.1642098361725;
        Thu, 13 Jan 2022 10:26:01 -0800 (PST)
Received: from localhost.localdomain (broadband-95-84-228-163.ip.moscow.rt.ru. [95.84.228.163])
        by smtp.gmail.com with ESMTPSA id p9sm358906lfu.83.2022.01.13.10.26.00
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 13 Jan 2022 10:26:01 -0800 (PST)
Date:   Thu, 13 Jan 2022 21:31:41 +0300
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
Message-ID: <20220113183141.kla37mbqmo4x6wxp@localhost.localdomain>
User-Agent: mtt
References: <20210519170357.58410-1-jeremy.szu@canonical.com>
 <20220111195229.a77wrpjclqwrx4bx@localhost.localdomain>
 <s5ho84h9tit.wl-tiwai@suse.de>
 <20220112101249.ya73jvpmqmeh4ggg@localhost.localdomain>
 <s5hilup9s87.wl-tiwai@suse.de>
 <20220112104827.4aymoth7ua65nwge@localhost.localdomain>
 <20220112201824.qmphnz2hx4frda6e@localhost.localdomain>
 <s5h8rvk85uy.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <s5h8rvk85uy.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 08:14:29AM +0100, Takashi Iwai wrote:
>> First, about unbind and bind via sysfs -- attempts to unbind the
>> HD-audio controller immediately trigger BUGs:
>> Is it normal/expected?
>
>A sort of. The sysfs unbind is little tested and may be still buggy
>if done during the stream operation.
>
>To be sure, could you check with my latest sound.git tree for-linus
>branch?  There are a few fixes that harden the dynamic unbind.

I assume that the referred repository is the one at [1]. I've tried 
081c73701ef0 "ALSA: hda: intel-dsp-config: reorder the config table". It 
crashed with nearly identical logs.

>> 1) Coeff 0x0b is flapping between 0x8003 and 0x7770 and does not seem
>> to have any effect in both non-working and working versions. Not sure
>> about this, maybe microphone is not operational since I haven't
>> checked it yet.

I got some time to poke the internal microphone. It works, but oddities are 
there as well. Initially I get "Mic Boost", "Capture" and "Internal Mic Boost" 
controls in alsamixer. When I run arecord, "Digital" control appears, but it 
cannot be changed until arecord is stopped. Subsequent arecord calls do not 
lock "Digital" control. This control affects sensitivity of the microphone and 
seems useful.

/proc/asound/card1/codec#0:
  Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
    Control: name="Capture Volume", index=0, device=0
      ControlAmp: chs=3, dir=In, idx=0, ofs=0
    Control: name="Capture Switch", index=0, device=0
      ControlAmp: chs=3, dir=In, idx=0, ofs=0
    Device: name="ALC285 Analog", type="Audio", device=0
    Amp-In caps: ofs=0x17, nsteps=0x3f, stepsize=0x02, mute=1
    Amp-In vals:  [0x27 0x27]
-  Converter: stream=0, channel=0
+  Converter: stream=1, channel=0

This is the only change in /proc/asound after the first arecord run. Overall, 
seems like a small annoyance, but I'm curious -- is it how it's supposed to 
work?

[1]https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/?h=for-linus
