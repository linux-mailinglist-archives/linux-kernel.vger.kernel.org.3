Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE3E4AE441
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345324AbiBHW20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386193AbiBHTn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:43:27 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B519C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:43:25 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id a25so355905lji.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 11:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:references
         :mime-version:content-disposition:in-reply-to;
        bh=1tEJAxplWOdsST7VjAL8Y9Sw3P8bafgTU+Sinq81TpA=;
        b=qgIYmDi/ZeicFaofjllkpa+BrnvfUv4EOU+wxz9K63WiLaH5xS0CZFXk2kZgFuo8Mq
         g3NXYajQoNtsik4kRxCC7rtl9YSyG5jPbpFs3bjV8s0XW7PhyVR+Ns3Y+ETMrKmeRI7H
         Xdi9HF2KuPX5VHeRLrOrheb1zXHfPTtvAtoryglvLUUHsOCbU4KkCYo0/1UzIAHT5aKU
         xcWGY7P//34ib2u47l3dszXaLnD84GjUVRc5fvjRKeMYAJxocxB3vxrPy0iiamDFw+K8
         xRWuGX0cG6+//fzzHOKklg+gAdyHOE+/KAm7v/fwnIbh/z7FkI7mpG5sepn43VzK1K9W
         neEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :references:mime-version:content-disposition:in-reply-to;
        bh=1tEJAxplWOdsST7VjAL8Y9Sw3P8bafgTU+Sinq81TpA=;
        b=h6ClAI2swmxHKSww/Sfmm1wsxJ4mX/1qdwt6PBvgq1n/TvPgDoRZaO7eDoBs/JnE/2
         549W+VqZCjVJDH9qtwPofII4GhCmKusGnHzm4Gp4Me1mZMpXJyBW0c5BTKyVEbOdFX54
         psezIbXOUbOoZxEGiOcZrZC5yqrZYwNlwk29GRvii40NpVQCiXKzDifexXyLW4EiDx+t
         Ytg7X/kt1aSoaEaLt6nV1oNVEYX45kTl9ZCfbDgPCP0Zms4fTU/vQTaj8eSvZiSW/GHD
         gnlN3VAS4ZoBUqmJXydGsm/ky+Y4BY35a5ZgTN/+VXnbLeJAqJBprJUcUe8OCrUUIwLR
         hSwQ==
X-Gm-Message-State: AOAM530mc30lQIBONo9atUzn6bI/Gq4KooBZy8TZmKtbpl/vNuvWYDKd
        LbLoBRUNEQkR7SABmd4ubXua8vCZXtg=
X-Google-Smtp-Source: ABdhPJy2TPJeIGKofeUIN1Ki9KOHuEUkQIzaTDtyAX5L3UBuGUlxdnB00lMLWmvVS9I3SdVYp91G7Q==
X-Received: by 2002:a2e:2ac1:: with SMTP id q184mr3755627ljq.360.1644349403757;
        Tue, 08 Feb 2022 11:43:23 -0800 (PST)
Received: from localhost.localdomain (broadband-95-84-228-163.ip.moscow.rt.ru. [95.84.228.163])
        by smtp.gmail.com with ESMTPSA id t16sm352001lfp.137.2022.02.08.11.43.22
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 08 Feb 2022 11:43:23 -0800 (PST)
Date:   Tue, 8 Feb 2022 22:49:21 +0300
From:   Alexander Sergeyev <sergeev917@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Kailang Yang <kailang@realtek.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        open list <linux-kernel@vger.kernel.org>, tiwai@suse.com,
        Hui Wang <hui.wang@canonical.com>,
        PeiSen Hou <pshou@realtek.com>,
        Jian-Hong Pan <jhp@endlessos.org>
Subject: Re: [PATCH 1/4] ALSA: hda/realtek: fix mute/micmute LEDs for HP 855
 G8
Message-ID: <20220208194921.kqx4rguwe5i7rnvg@localhost.localdomain>
User-Agent: mtt
References: <20220119093249.eaxem33bjqjxcher@localhost.localdomain>
 <20220122190522.ycaygrqcen7d3hj2@localhost.localdomain>
 <20220122205637.7gzurdu7xl4sthxw@localhost.localdomain>
 <s5ho83yldu3.wl-tiwai@suse.de>
 <20220129144704.xlmeylllvy3b3fum@localhost.localdomain>
 <20220130111020.44gzrm5ckrakjta2@localhost.localdomain>
 <s5htudk9cn3.wl-tiwai@suse.de>
 <20220205150016.gvrst7ldvgjh7fra@localhost.localdomain>
 <20220205175132.ihwp5wlxga4efngl@localhost.localdomain>
 <s5hzgn2u589.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hzgn2u589.wl-tiwai@suse.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 03:21:58PM +0100, Takashi Iwai wrote:
> > In the last functions a circular buffer is used to write commands. The 
> > problem is that "bus->corb.buf[wp]" and "bus->rirb.res[addr]" are nowhere 
> > close to the IOMMU-reported address of the offending memory access. It's 
> > likely that I've missed other communication channels. But is it possible 
> > that IOMMU-reported address and buffers addresses are of different kinds 
> > (physical/virtual) or different regions mapped to the same physical pages?
> Hm, I'm not sure, either.  But let's try to avoid some possible
> confusion at first, e.g. a patch like below.

No changes with the patch applied. Also, I added logs for dma_type used:

snd_hdac_bus_alloc_stream_pages: dma_type = 2
snd_hdac_bus_alloc_stream_pages: dma_type = 2
snd_hdac_bus_alloc_stream_pages: dma_type = 2

Which matches SNDRV_DMA_TYPE_DEV, so the same behavior is expected.

I've noticed that the IO_PAGE_FAULT regularly comes shortly after the write 
position overflows and restarts from 0, while after the driver binding the wp 
starts from 1 and not 0. Correlation does not mean causation, through. A 
similar overflow happens during the initial kernel bootup with no error 
messages. An another way of looking on it -- the fault comes on wp=0x1, which 
corresponds to the first re-used address in the buffer.

bus->corb.buf[wp] = cpu_to_le32(val) // = 0x14ba000, wp=0xfe, &buf[wp]=000000005b92167d
snd_hdac_bus_get_response: reading result from 0000000096c36d67
bus->corb.buf[wp] = cpu_to_le32(val) // = 0x14b8000, wp=0xff, &buf[wp]=00000000a91a3679
snd_hdac_bus_get_response: reading result from 0000000096c36d67
bus->corb.buf[wp] = cpu_to_le32(val) // = 0x2ba000, wp=0x0, &buf[wp]=000000002fda9222
snd_hdac_bus_get_response: reading result from 0000000096c36d67
bus->corb.buf[wp] = cpu_to_le32(val) // = 0x2b8000, wp=0x1, &buf[wp]=000000009747a629
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff800 flags=0x0020]
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff800 flags=0x0020]

And I finally got "out of range cmd", but logging is limited to IO addresses.

bus->corb.buf[wp] = cpu_to_le32(val) // = 0x14ba000, wp=0xfe, &buf[wp]=0000000036a02eae
snd_hdac_bus_get_response: reading result from 0000000037aa0724
bus->corb.buf[wp] = cpu_to_le32(val) // = 0x14b8000, wp=0xff, &buf[wp]=00000000ce140303
snd_hdac_bus_get_response: reading result from 0000000037aa0724
bus->corb.buf[wp] = cpu_to_le32(val) // = 0x2ba000, wp=0x0, &buf[wp]=000000004c6aa283
snd_hdac_bus_get_response: reading result from 0000000037aa0724
bus->corb.buf[wp] = cpu_to_le32(val) // = 0x2b8000, wp=0x1, &buf[wp]=000000002a825cc8
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff800 flags=0x0020]
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff800 flags=0x0020]
snd_hdac_bus_get_response: reading result from 0000000037aa0724
bus->corb.buf[wp] = cpu_to_le32(val) // = 0x239000, wp=0x2, &buf[wp]=0000000078eca2cf
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff800 flags=0x0020]
snd_hdac_bus_get_response: reading result from 0000000037aa0724
bus->corb.buf[wp] = cpu_to_le32(val) // = 0x1970724, wp=0x3, &buf[wp]=00000000613071da
snd_hdac_bus_get_response: reading result from 0000000037aa0724
bus->corb.buf[wp] = cpu_to_le32(val) // = 0x1270720, wp=0x4, &buf[wp]=000000006db33d93
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff800 flags=0x0020]
snd_hdac_bus_get_response: reading result from 0000000037aa0724
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff820 flags=0x0020]
bus->corb.buf[wp] = cpu_to_le32(val) // = 0x8b2000, wp=0x5, &buf[wp]=000000002a3c7e90
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff820 flags=0x0020]
snd_hdac_bus_get_response: reading result from 0000000037aa0724
bus->corb.buf[wp] = cpu_to_le32(val) // = 0x836080, wp=0x6, &buf[wp]=00000000571d53bf
snd_hdac_bus_get_response: reading result from 0000000037aa0724
bus->corb.buf[wp] = cpu_to_le32(val) // = 0x8b0000, wp=0x7, &buf[wp]=000000000a52a2af
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff820 flags=0x0020]
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff820 flags=0x0020]
snd_hdac_bus_get_response: reading result from 0000000037aa0724
bus->corb.buf[wp] = cpu_to_le32(val) // = 0x835080, wp=0x8, &buf[wp]=00000000f139c302
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff840 flags=0x0020]
snd_hdac_bus_get_response: reading result from 0000000037aa0724
bus->corb.buf[wp] = cpu_to_le32(val) // = 0x23f000d, wp=0x9, &buf[wp]=000000003c565021
snd_hda_intel 0000:05:00.6: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0015 address=0x1fffff840 flags=0x0020]
snd_hdac_bus_get_response: reading result from 0000000037aa0724
...
bus->corb.buf[wp] = cpu_to_le32(val) // = 0x205000b, wp=0x3e, &buf[wp]=000000002ce016ac
snd_hdac_bus_get_response: reading result from 0000000037aa0724
bus->corb.buf[wp] = cpu_to_le32(val) // = 0x20c0000, wp=0x3f, &buf[wp]=000000003ad48d6f
snd_hdac_bus_get_response: reading result from 0000000037aa0724
bus->corb.buf[wp] = cpu_to_le32(val) // = 0x8350a7, wp=0x40, &buf[wp]=0000000098c2fb2d
snd_hdac_bus_get_response: reading result from 0000000037aa0724
bus->corb.buf[wp] = cpu_to_le32(val) // = 0x205000b, wp=0x41, &buf[wp]=000000006e281f5b
snd_hdac_bus_get_response: reading result from 0000000037aa0724
snd_hda_codec_realtek hdaudioC1D0: out of range cmd 0:20:400:40600001
