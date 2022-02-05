Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF9F4AAAAE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 18:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380783AbiBERpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 12:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiBERpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:45:39 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED781C061348
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 09:45:37 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id e17so13350458ljk.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 09:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:references
         :mime-version:content-disposition:in-reply-to;
        bh=cRzVy8dQSyjDKFOJ91Sg7KEwkjk8USDTRteVjsR+Cio=;
        b=jXTEHu9pEoQcJaaekEcxkBtIE95TEMXUJrUo+supNsm02ZlbK4T4S2d6mnWsSDo6Qx
         PW71oDI8p5fVCZ1SI0nx65QMSNVxLgBjiZFWz/Q7KXPjcZvDI+kyWyLp9aUzzxVYtYTx
         cUgaIl1D0iHXIj70U5/sO0iI/y4ZCWTcXLpeTSDnjGgm5kXAQp60RnedcPoHJV+3z/o3
         bYqi0oa19O3rTp98HfHLSu1LlyPrTV06SaTubKhWUA+Msx+IFlGCzEGJj1DIoc0M9YmF
         LZwhsbAmG33dGdE8pQKmmZB3BzsdG5Xx9nL5r00CYr0PO6qhNx2ODvXrWdQOJDFXramU
         SeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :references:mime-version:content-disposition:in-reply-to;
        bh=cRzVy8dQSyjDKFOJ91Sg7KEwkjk8USDTRteVjsR+Cio=;
        b=cYh0q23Yw98rcwB61EXeVd7J093m3HybqRyx1aLoWFOXnLAe+ZRglg6qdF/evZ+aDH
         b0gespxoPEYYnIbtJ3oXKZWVez4/2UwOg2LzC0pR4/rh7yknUaiWNZ5/BpIvZ9jJXlTN
         SC1gGDs0zLll8THOHMdTMU7BUrMN79OwSEpiVQFFa6PkZNEPp4GbT0v7IcZQ3Kzd4fwW
         9WKlAkKeCThVR81RzhnSrAnAG0w/SU7GmwVbJCZVfQp4NpXePpKXCDpW30LWdzkR8yyo
         6L8ispD0TM2UJBH1vFmhqJvsQJcBfxJ9gQTC0Uq8cm4usy8nCZNbMWac1Q4ZXl+kr3fE
         7obA==
X-Gm-Message-State: AOAM533e+ctMcK5bRaWLSXSQoyrW9Jqh5eKIQG4re5hlVAJx9pJIH8+A
        h+Z4ZRDGOInCt/GOxgXDzuI=
X-Google-Smtp-Source: ABdhPJz7ogkncJjTXq48mAK0ycccQfH5qE/3wQx/QTci2lK6q525ctJYnswaNihtjmy80MkztqfS7w==
X-Received: by 2002:a2e:958d:: with SMTP id w13mr3401629ljh.113.1644083136084;
        Sat, 05 Feb 2022 09:45:36 -0800 (PST)
Received: from localhost.localdomain (broadband-95-84-228-163.ip.moscow.rt.ru. [95.84.228.163])
        by smtp.gmail.com with ESMTPSA id k14sm811589ljh.82.2022.02.05.09.45.34
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 05 Feb 2022 09:45:35 -0800 (PST)
Date:   Sat, 5 Feb 2022 20:51:32 +0300
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
Message-ID: <20220205175132.ihwp5wlxga4efngl@localhost.localdomain>
User-Agent: mtt
References: <20220115152215.kprws5nja2i43qax@localhost.localdomain>
 <s5hilugw0l0.wl-tiwai@suse.de>
 <20220119093249.eaxem33bjqjxcher@localhost.localdomain>
 <20220122190522.ycaygrqcen7d3hj2@localhost.localdomain>
 <20220122205637.7gzurdu7xl4sthxw@localhost.localdomain>
 <s5ho83yldu3.wl-tiwai@suse.de>
 <20220129144704.xlmeylllvy3b3fum@localhost.localdomain>
 <20220130111020.44gzrm5ckrakjta2@localhost.localdomain>
 <s5htudk9cn3.wl-tiwai@suse.de>
 <20220205150016.gvrst7ldvgjh7fra@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205150016.gvrst7ldvgjh7fra@localhost.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 03:57:04PM +0100, Takashi Iwai wrote:
> In anyway, we need to track down exactly which access triggers those 
> errors...

I went deeper into codec reads and writes:
- snd_hda_codec_write
- snd_hdac_codec_write
- codec_write
- snd_hdac_exec_verb
- codec_exec_verb
- snd_hdac_bus_exec_verb_unlocked
- azx_send_cmd / azx_get_response
- snd_hdac_bus_send_cmd / azx_rirb_get_response

In the last functions a circular buffer is used to write commands. The 
problem is that "bus->corb.buf[wp]" and "bus->rirb.res[addr]" are 
nowhere close to the IOMMU-reported address of the offending memory 
access. It's likely that I've missed other communication channels. But 
is it possible that IOMMU-reported address and buffers addresses are of 
different kinds (physical/virtual) or different regions mapped to the 
same physical pages?

Example:
snd_hdac_bus_send_cmd: bus->corb.buf[wp] = cpu_to_le32(val) // = 0x3b8000, wp=0xfb, &buf[wp]=00000000f1fd4592
snd_hdac_bus_get_response: reading result from 0000000059c4003d
snd_hdac_bus_send_cmd: bus->corb.buf[wp] = cpu_to_le32(val) // = 0x339000, wp=0xfc, &buf[wp]=000000007f14c128
snd_hdac_bus_get_response: reading result from 0000000059c4003d
snd_hdac_bus_send_cmd: bus->corb.buf[wp] = cpu_to_le32(val) // = 0x1470740, wp=0xfd, &buf[wp]=00000000a6b14901
snd_hdac_bus_get_response: reading result from 0000000059c4003d
snd_hdac_bus_send_cmd: bus->corb.buf[wp] = cpu_to_le32(val) // = 0x14ba000, wp=0xfe, &buf[wp]=00000000d8d1672a
snd_hdac_bus_get_response: reading result from 0000000059c4003d
snd_hdac_bus_send_cmd: bus->corb.buf[wp] = cpu_to_le32(val) // = 0x14b8000, wp=0xff, &buf[wp]=00000000b87b3287
snd_hdac_bus_get_response: reading result from 0000000059c4003d
snd_hdac_bus_send_cmd: bus->corb.buf[wp] = cpu_to_le32(val) // = 0x2ba000, wp=0x0, &buf[wp]=000000002162c728
snd_hdac_bus_get_response: reading result from 0000000059c4003d
snd_hdac_bus_send_cmd: bus->corb.buf[wp] = cpu_to_le32(val) // = 0x2b8000, wp=0x1, &buf[wp]=0000000095f61061
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff800 flags=0x0020]
