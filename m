Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2E048CCEB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357644AbiALUM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357535AbiALUMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:12:47 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4311C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 12:12:46 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id x6so12125003lfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 12:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:references
         :mime-version:content-disposition:in-reply-to;
        bh=/MdyQCuTcmQZqE+0791YYCUS0LB/aIHQflB+8ipEfxo=;
        b=NZQo87j8v1cftqxrl7HiCR/QllRlXw4Uk5Y0ApjkKFb0iLItW0Gx/KAnUfwtvf2aYZ
         qCZaZj3R6UieyUO5dgVB49pMo8+FthMtnSWFPn4Mp6xbEzDlADS49gFCaK0vzAjQ9SJv
         Ox212NFV6UTsmEflWWtNXTU3sERfa9to570JDBpsm7VWUcBZQuJzJW5YSi9vjEpP1GcO
         Okn3N9zAugZUtQZv5VSnWNM615w1CCdjsIIcYaUZG6MuFuL6V1QWSkUBRa6RayRGYoMM
         xEnHq+GWA8cMmpAV5KCYokFWbR6Mfp/b+TZdTH7Zks2SprfBDFmK0E9n8+q1HnpDN4RO
         125A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :references:mime-version:content-disposition:in-reply-to;
        bh=/MdyQCuTcmQZqE+0791YYCUS0LB/aIHQflB+8ipEfxo=;
        b=P3lRlkZ9TXqD/IrTfUTNxNYktCWwW62ohUgO3L6hhYKGMjxDPcOqao9OdH9mu7qrZZ
         QPZ3afrWnt2RlfN7WC9WQxGePf4M8gjlAa0I3DcQp9oOfNpYQ9y1db+1782pJgaoIeY7
         EfMFr4nMzV7z3ykaZYwLjFfLjjo7UFSENss3e0pgP6Kb9K3xjLPtns1bfmuOp4gHYWHn
         bygGd7xjo9pyXS/Rd7yIVF/GpPGDfofQnvZgm7SvdiRMTO20sjf6FXNMU08F7IgIYBD5
         7OYTE2IHCXZxr9C+LxgbFGUQLdLiX4nApdhdEzc6zN7kexyhzAHbYkzr1b5ve/kmeukx
         XJ5Q==
X-Gm-Message-State: AOAM530P21YSQBf9i0YHdnndF+GR1W4oT/6aV+/PdpS0B5oveO1JdrvR
        HXpeFrC7KOnmfwKRxRe+S6gvSIGHIQg=
X-Google-Smtp-Source: ABdhPJzKoQfmV2bZQgn2DZP7YIOnZOnGVNw6kQnxHv2k/FkobKc1KUeXLk/jjzfy0Yi9kdRlc6zI9A==
X-Received: by 2002:a05:6512:1395:: with SMTP id p21mr953097lfa.403.1642018364958;
        Wed, 12 Jan 2022 12:12:44 -0800 (PST)
Received: from localhost.localdomain (ntd06459.static.corbina.ru. [95.31.14.149])
        by smtp.gmail.com with ESMTPSA id g22sm80465lfr.126.2022.01.12.12.12.44
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 12 Jan 2022 12:12:44 -0800 (PST)
Date:   Wed, 12 Jan 2022 23:18:24 +0300
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
Message-ID: <20220112201824.qmphnz2hx4frda6e@localhost.localdomain>
User-Agent: mtt
References: <20210519170357.58410-1-jeremy.szu@canonical.com>
 <20220111195229.a77wrpjclqwrx4bx@localhost.localdomain>
 <s5ho84h9tit.wl-tiwai@suse.de>
 <20220112101249.ya73jvpmqmeh4ggg@localhost.localdomain>
 <s5hilup9s87.wl-tiwai@suse.de>
 <20220112104827.4aymoth7ua65nwge@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220112104827.4aymoth7ua65nwge@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 01:48:28PM +0300, Alexander Sergeyev wrote:
>On Wed, Jan 12, 2022 at 11:13:44AM +0100, Takashi Iwai wrote:
>>You may try to get the codec proc dump with COEF by passing 
>>snd_hda_codec.dump_coef=1 module option for both working and non-working 
>>cases.
>>You can unbind and re-bind the PCI (HD-audio controller) device via sysfs.
>
>I'll try both options later today when able, thank you!

First, about unbind and bind via sysfs -- attempts to unbind the HD-audio 
controller immediately trigger BUGs:

05:00.6 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] Family 17h 
(Models 10h-1fh) HD Audio Controller [1022:15e3]

echo -n '0000:05:00.6' > /sys/bus/pci/drivers/snd_hda_intel/unbind

BUG: unable to handle page fault for address 000000000000173c
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP NOPTI
CPU: 2 PID: 167 Comm: kworker/2:3 Tainted: G  T 5.16.0-dirty #3
Workqueue: events set_brightness_delayed
RIP: 0010:coef_micmute_led_set+0xf/0x60
...
Call Trace:
   <TASK>
   set_brightness_delayed+0x6f/0xb0
   process_one_work+0x1e1/0x380
   worker_thread+0x4b/0x3b0
   ? rescuer_thread+0x370/0x370
   kthread+0x142/0x160
   ? set_kthread_struct+0x50/0x50
   ret_from_work+0x22/0x30
   </TASK>

Is it normal/expected?


Second, about dump_coef. I've collected a bunch of samples from 
/proc/asound/Generic_1/codec#0. Overall, there are 6 different versions across 
196 samples, two versions are with working sound (and micmute LED).


Differences between _non-working_ versions:

Node 0x02 [Audio Output] wcaps 0x41d: Stereo Amp-Out
Amp-Out vals:  [0x3c 0x3c] // (!) OR [0x53 0x53]
Converter: stream=5, channel=0 // (!) OR stream=0, channel=0

Node 0x03 [Audio Output] wcaps 0x41d: Stereo Amp-Out
Amp-Out vals:  [0x3c 0x3c] // (!) OR [0x53 0x53]
Converter: stream=5, channel=0 // (!) OR stream=0, channel=0

Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
Processing caps: benign=0, ncoeff=142
Coeff 0x0b: 0x8003 // (!) OR 0x7770
Coeff 0x19: 0x01e3 // (!) OR 0x21e3

Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
Amp-In vals:  [0x27 0x27] // (!) OR [0xa7 0xa7]


Differences between _working_ versions:

Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
Processing caps: benign=0, ncoeff=142
Coeff 0x0b: 0x8003 // (!) OR 0x7770


Differences between _non_working_ and _working_ versions:

Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
Processing caps: benign=0, ncoeff=142
Coeff 0x19: 0x01e3 OR 0x21e3 // (!) 0x8e11 for working versions


In short:
1) Coeff 0x0b is flapping between 0x8003 and 0x7770 and does not seem to have 
any effect in both non-working and working versions. Not sure about this, maybe 
microphone is not operational since I haven't checked it yet.
2) Coeff 0x19 with 0x8e11 value makes speakers work. Non-working values are 
0x01e3 and 0x21e3.

Running the following commands makes speakers and micmute LED work (0x20 is the 
node id, which is mentioned in the snippets above):

hda-verb /dev/snd/hwC1D0 0x20 SET_COEF_INDEX 0x19
hda-verb /dev/snd/hwC1D0 0x20 SET_PROC_COEF 0x8e11

Is it possible to somehow trace this particular coefficient to hunt the timing 
issue? It would be great to have a proper fix.
