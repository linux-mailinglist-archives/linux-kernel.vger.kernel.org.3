Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F37585F2E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 15:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbiGaNzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 09:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiGaNzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 09:55:20 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC12617C;
        Sun, 31 Jul 2022 06:55:18 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id h28so2022827pfq.11;
        Sun, 31 Jul 2022 06:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=xNPBWOC/I43u3bImxvqM+yXOk51ZAfr3ljqZNNUlsi8=;
        b=Mqicnhs+Neu29XxQM/6u6nW3nlCQlkJU5VqNkoqZtfhf1J8b0HIhIM6HN3MK0anGIk
         z+KeKPiLOuFd/tQPMM/shhlkpQyeRBRmG9yRPEgsQCb6wqzWEfp10rdWUJdah0Z8Y4+t
         7RNV87tZFcK0CzFpjlfhyANfQ06F0rfCKNyotPb5mrDR1cRxHSZaOUWF9etibS70oSb+
         i0ekvNd9gy62NbRnjjMzvb3la38g93luZL2iO+97fdGllq/jcO8vNyL6P1dUGqOlIQX8
         QX1UsIF8xBQX45dRPfYNlNlSH6FTRLgnd5zsoDT9nubgZTCAiF3lN0KWQZhHAZgmWdKZ
         f25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=xNPBWOC/I43u3bImxvqM+yXOk51ZAfr3ljqZNNUlsi8=;
        b=QD5F8U3q737lje3ag4/i/hB/lHD7z9JDyqN2dxcCxA3CvHKux3Ju/7NP6dOvEGPv/k
         6+AkjFegI9fKwhfzNP3piGA/KPVmulIh9udp0AQyJ+AKxVTkZRPTuK/WfIYDSkIaogva
         5HYspYkrB7HbMkqMrb6Wfdn2ns3hOtyCNwQgRCm5+pWHilPlD5Y5zkD3367gunpNiPAl
         g4a1sqX/9xgywohfaBLs4loQV2xpDIXu0/FHL1ycEMiDxy1pMKCka6ZcrCUXNx7itDkH
         j9aCLiFhqSwQEJM3pFJKp9Jepsb21XnRDh1wcSkeOoTer8TWgMQuP/ACuYsow+/JQwE0
         1uRg==
X-Gm-Message-State: AJIora+OqSsIPtS7tFsHbYP//sblrPUROh7ii76MYhGkvA6jIzyF8mDo
        5Pju660KAHzrSKnpcHJ+vi8=
X-Google-Smtp-Source: AGRyM1tGp667SkT01YAGydsW3pteT/piJaiF0LFUYELdzJRYw5O/AyDU2F6/fTwhdtD6eduEyU8QWw==
X-Received: by 2002:a63:6e82:0:b0:41a:1817:15d9 with SMTP id j124-20020a636e82000000b0041a181715d9mr10077049pgc.577.1659275718377;
        Sun, 31 Jul 2022 06:55:18 -0700 (PDT)
Received: from [192.168.0.110] ([103.159.189.149])
        by smtp.gmail.com with ESMTPSA id d23-20020a17090ad99700b001ef87123615sm6701473pjv.37.2022.07.31.06.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 06:55:17 -0700 (PDT)
Message-ID: <7973ec94-75ad-c133-032e-b83beeb2d397@gmail.com>
Date:   Sun, 31 Jul 2022 19:55:12 +0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Write in imageblit (2)
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>,
        syzbot <syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
References: <000000000000bbdd0405d120c155@google.com>
 <20220729065139.6529-1-khalid.masum.92@gmail.com>
 <eb4a26aa-da30-ceee-7d27-c1e902dd4218@gmx.de>
From:   Khalid Masum <khalid.masum.92@gmail.com>
In-Reply-To: <eb4a26aa-da30-ceee-7d27-c1e902dd4218@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/22 23:25, Helge Deller wrote:
> On 7/29/22 08:51, Khalid Masum wrote:
>> Here is a simplified reproducer for the issue:
>>
>> https://gist.githubusercontent.com/Labnann/923d6b9b3a19848fc129637b839b8a55/raw/a68271fcc724569735fe27f80817e561b3ff629a/reproducer.c
> 
> The reproducer does this:
> ioctl(3, TIOCLINUX, TIOCL_SETSEL, selection: xs:3  ys:0  xe:0 ye:0 mode:0)  = 0
> -> sets the text selection area
> ioctl(4, KDFONTOP)  with op=0 (con_font_set), charcount=512  width=8  height=32, 0x20000000) = 0
> -> changes the font size.
> 
> It does not crash with current Linus' head (v5.19-rc8).
> Kernel v5.16, which was used by this KASAN report, hasn't received backports
> since months, so I tried stable kernel v5.15.58 instead, and this
> kernel crashed with the reproducer.
> 
> The reproducer brings up two issues with current code:
> 1. The reproducer uses ioctl(TIOCLINUX, TIOCL_SETSEL) and hands over (invalid)
> zero-values for ys and ye for the starting lines.
> This is wrong, since the API seems to expect a "1" as the very first line for the selection.

Why do you think that API expects a 1?

> This can be easily fixed by adding checks for zero-values and return -EINVAL if found.
> 
> But this bug isn't critical itself and is not the reason for the kernel crash.
> Without the checks, the ioctl handler simply wraps the coordinate values and converts them
> from:
> input selection: xs:3  ys:0  xe:0   ye:0  mode:0    to the new:
> vc_selection =   xs:2  ys:23 xe:127 ye:23 mode:0
> which is the current maximum coordinates for the screen.
> 
> Those higher values now trigger issue #2:
> After the TIOCL_SETSEL the last line on the screen is now selected. The KDFONTOP ioctl
> then sets a 8x32 console font, and replaces the former 8x16 console font.
> With the bigger font the current screen selection is now outside the visible screen
> and this finally triggeres this backtrace, because vc_do_resize() calls clear_selection()
> to unhighlight the selection (which starts to render chars outside of the screen):
> 
>   drm_fb_helper_sys_imageblit drivers/gpu/drm/drm_fb_helper.c:794 [inline]
>   drm_fbdev_fb_imageblit+0x15c/0x350 drivers/gpu/drm/drm_fb_helper.c:2288
>   bit_putcs_unaligned drivers/video/fbdev/core/bitblit.c:124 [inline]
>   bit_putcs+0x6e1/0xd20 drivers/video/fbdev/core/bitblit.c:173
>   fbcon_putcs+0x353/0x440 drivers/video/fbdev/core/fbcon.c:1277
>   do_update_region+0x399/0x630 drivers/tty/vt/vt.c:676
>   invert_screen+0x1d4/0x600 drivers/tty/vt/vt.c:800
>   highlight drivers/tty/vt/selection.c:57 [inline]
>   clear_selection drivers/tty/vt/selection.c:84 [inline]
>   clear_selection+0x55/0x70 drivers/tty/vt/selection.c:80
>   vc_do_resize+0xe6e/0x1180 drivers/tty/vt/vt.c:1257
> 
> IMHO the easiest way to prevent this crash is to simply clear the
> selection before the various con_font_set() console handlers are called.
> Otherwise every console driver needs to add checks and verify if the current
> selection still fits with the selected font, which gets tricky because some
> of those drivers fiddle with the screen width&height before calling vc_do_resize().
> 
> I'll follow up to this mail with patches for both issues shortly.
> 
> Helge

Thanks,
   -- Khalid Masum

