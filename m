Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7481493736
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353063AbiASJ1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352766AbiASJ1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:27:08 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17650C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 01:27:08 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id p27so6935198lfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 01:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:references
         :mime-version:content-disposition:in-reply-to;
        bh=u5lDwO+2XRK8rlP7NLgszztTGNGruOFaEDeVGg6XhHY=;
        b=lwP3af+Iz6VPA9+Q2nCdQo1sMq9nVMIsjYYH4vvuH5N01oYYSSdphao4uxw8RYQnsi
         0hfm7MEWrM3oNZw0xonaYTn+eTKdb0Z2e5yfNPreuU/YRUlzSwl/FQSv2r3d2MFuZnts
         SZIsamz3rJXmVJ5JHA/Ah4veRyDq2lcG0APCU2wz03RazM8dIvvZctP2h8cxw1/17qTT
         HDEZZCVWi/6HLw2k3Yqu1Wp88d4xsx/+Hxe5P4EQhz+znbzVWhOvnSF3h7WhqMnrqe3k
         c+kGEWLNwxr45+Uv5pmhvDN25jmmKjelXCK3PS7bkEjziE2nSk2YWnPUU72/UdtRXfUx
         8tKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :references:mime-version:content-disposition:in-reply-to;
        bh=u5lDwO+2XRK8rlP7NLgszztTGNGruOFaEDeVGg6XhHY=;
        b=zj6cwQTs9QoG9UqnEIWqn4FaB6alCqvHiDWv8xsOEkxEdAzVofP4xwpQThhsY55tlh
         t49vNQVgjwvbIETAJlVRdXzy3D8mZDug9K1jVBPRuIaNNEuz8fISS/GrIcpSDGdIOUdE
         lygeLlNMwxZXt5/yDlGOoqXue2Tod0ijEqwKvu06yc67swGtS5hvoJaAbeKsDnpRqi1E
         +XRjFj8m7u0HY8yWBo64CwZl385boJImFhxcJQYkuFTmHH4zlC/E8ZQb+CVy2m4agB7h
         UWxUZghPb25isRb6Ssp7vmdnEM2OdQXvtQenpFWFlxrlUYz9GmoKmbhXZy26QeEunxtf
         /vig==
X-Gm-Message-State: AOAM5313VDUtHlPZNO4CiuzigZE6yU4GBejciIk7t3wQklrRDEQPBrFO
        lLv6m/dbmzTzsz79dyI64xM=
X-Google-Smtp-Source: ABdhPJz6Y+KMD8wRBih5hOfbEX+rU5U9DrLD6Xu27YqUTuDMS2DMFoUWtMgNqemZSVK2kbNlM6559w==
X-Received: by 2002:a05:651c:10bb:: with SMTP id k27mr13004663ljn.310.1642584426348;
        Wed, 19 Jan 2022 01:27:06 -0800 (PST)
Received: from localhost.localdomain (broadband-95-84-228-163.ip.moscow.rt.ru. [95.84.228.163])
        by smtp.gmail.com with ESMTPSA id d5sm1230305lfs.26.2022.01.19.01.27.05
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 19 Jan 2022 01:27:05 -0800 (PST)
Date:   Wed, 19 Jan 2022 12:32:49 +0300
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
Message-ID: <20220119093249.eaxem33bjqjxcher@localhost.localdomain>
User-Agent: mtt
References: <s5hilup9s87.wl-tiwai@suse.de>
 <20220112104827.4aymoth7ua65nwge@localhost.localdomain>
 <20220112201824.qmphnz2hx4frda6e@localhost.localdomain>
 <s5h8rvk85uy.wl-tiwai@suse.de>
 <20220113183141.kla37mbqmo4x6wxp@localhost.localdomain>
 <s5ha6fy46jt.wl-tiwai@suse.de>
 <20220114183720.n46wealclg6spxkp@localhost.localdomain>
 <s5hsftp3027.wl-tiwai@suse.de>
 <20220115152215.kprws5nja2i43qax@localhost.localdomain>
 <s5hilugw0l0.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hilugw0l0.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 10:12:43AM +0100, Takashi Iwai wrote:
> > Actually, the timing issues are present here as well. Sometimes unbind & 
> > bind works fine. But fails on the second round.
>
> Here "fails" means the kernel Oops / crash?  If yes, the back trace
> would be helpful.

No, I mean "IO_PAGE_FAULT" and "out of range cmd" don't appear on every unbind 
& bind. Sometimes it works cleanly.

Backtraces for the source of "out of range cmd" messages:

--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -231,6 +231,7 @@ static unsigned int snd_hdac_make_cmd(struct hdac_device *codec, hda_nid_t nid,
            (verb & ~0xfff) || (parm & ~0xffff)) {
                dev_err(&codec->dev, "out of range cmd %x:%x:%x:%x\n",
                        addr, nid, verb, parm);
+               dump_stack();
                return -1;
        }

give me the following:

snd_hda_codec_realtek hdaudioC1D0: out of range cmd 0:20:400:90170118
Workqueue: events set_brightness_delayed
Call Trace:
 <TASK>
 dump_stack_lvl+0x34/0x4c
 snd_hdac_make_cmd.cold+0x17/0x2c
 snd_hdac_codec_write+0x16/0x60
 coef_mute_led_set+0x3a/0x60
 set_brightness_delayed+0x6f/0xb0
 process_one_work+0x1e1/0x380
 worker_thread+0x4e/0x3b0
 ? rescuer_thread+0x370/0x370
 kthread+0x145/0x170
 ? set_kthread_struct+0x50/0x50
 ret_from_fork+0x22/0x30
 </TASK>

I'll have more time to look into this deeper later this week.
