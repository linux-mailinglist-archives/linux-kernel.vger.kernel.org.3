Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C764536E5F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 22:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiE1Ubw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 16:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiE1Ubt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 16:31:49 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDAE4093C
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 13:31:47 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h19so1026375edj.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 13:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L1kBeURXP1GB/kHBU8GORq7J0BLUBtbdZ3DIpYlBaTc=;
        b=DjAdbu7azasbs7NwcB/7SaHAszgGECqjn47oqs1k4xlPedT4RzvCX0QqPq7lBkKL8h
         kCDd8EbrgSMsdYPGW3kd71I2wnB1fj5aTc/XMHG5vhBWAJyMC5IrsfUpAp0qTXGDSYTv
         IHcvWUBdT5BZzPhVuRmnJn+4dngxb6cwXB33Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1kBeURXP1GB/kHBU8GORq7J0BLUBtbdZ3DIpYlBaTc=;
        b=6QbGGwVtHPZxij79QmaBEBVxyC/LUAfMqt/Jty4SIaeSBMNCAFBw52g4nhCmFdbzfc
         ct6BiQP1Ez3CaUHchyTTzkSpQSFfJ7DPHDX0EidXqsu562X196KxwurcLI3dBM7QUdgt
         NiTAQoHb68Jst7zZEuChspRoxa4dcYtC1aDDl2pyr8O3BMaTZIvrSY+P07D68yM2ZL6G
         MdXKoGaFMraDO7X9KJl2qyl1whqvZdx8ObIRuMudbIsHF7mbFLwP0vnJroiCD+6Sz8lW
         8bPEMORrRL7inZB3BlfXKbOv/M59WLu1gdySezqeiJt2VoLYfiyDKwYZG2viL/zJbJna
         Btxg==
X-Gm-Message-State: AOAM533NX44WJ/CTKsFgi9yfJAgEpVAZQqYteBaUOTd6gz5IrurwSB3z
        hesdZ5AGR7xZCl2FUQRivNWFBA0DoDBU1HdDfYA=
X-Google-Smtp-Source: ABdhPJy3mlvQI7xUWhspJL2qndBj9MC9+q0y9E9U/bV1+FlOCP15U8NT9EdXSOz2y+X6Rgs8yIhQgA==
X-Received: by 2002:a05:6402:845:b0:42b:303f:1ef8 with SMTP id b5-20020a056402084500b0042b303f1ef8mr42689678edz.49.1653769905909;
        Sat, 28 May 2022 13:31:45 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id ia15-20020a170907a06f00b006fee2c743b6sm2603378ejc.159.2022.05.28.13.31.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 13:31:42 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id c9-20020a7bc009000000b0039750ec5774so4465887wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 13:31:41 -0700 (PDT)
X-Received: by 2002:a1c:7207:0:b0:397:66ee:9d71 with SMTP id
 n7-20020a1c7207000000b0039766ee9d71mr12380873wmc.8.1653769900324; Sat, 28 May
 2022 13:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <YpCUzStDnSgQLNFN@debian> <CAHk-=wg0uGAX5DYZq+tY2KeUAR8DtR91YE1y9CkPMKkKOyE4jg@mail.gmail.com>
 <CADVatmNGPbSdRNQuwJEWAaPtqb3vBYRjvsuBpoRUnhEHj=X5GQ@mail.gmail.com>
 <CAHk-=wisQd8yiPX=SsK3eFiakKo713hq4SyqPWsJ-oyAmLFefQ@mail.gmail.com>
 <YpIR67FMtTGCwARZ@debian> <CAHk-=wjuyHE=1wLgHncub8FfgeyYqfWYsy4-YrhAvq9991h_Aw@mail.gmail.com>
 <CAHk-=wi_hJV0V=Ecg2dzbe2P_H1XKTu6VP_AtCH6u=tis31ayg@mail.gmail.com> <CAK8P3a0-QyOQiieEvM0yQb43XbCtPmeao8UvoAsdFnjCxYPz7Q@mail.gmail.com>
In-Reply-To: <CAK8P3a0-QyOQiieEvM0yQb43XbCtPmeao8UvoAsdFnjCxYPz7Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 28 May 2022 13:31:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfmwzjF4eBPYS6pHFqHVzJF3m=2h=gRWSRyHks8V=ABA@mail.gmail.com>
Message-ID: <CAHk-=whfmwzjF4eBPYS6pHFqHVzJF3m=2h=gRWSRyHks8V=ABA@mail.gmail.com>
Subject: Re: mainline build failure due to f1e4c916f97f ("drm/edid: add EDID
 block count and size helpers")
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 11:59 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> It's CONFIG_ARM_AEABI, which is normally set everywhere. Without this
> option, you the kernel is built for the old 'OABI' that forces all non-packed
> struct members to be at least 16-bit aligned.

Looks like forced word (32 bit) alignment to me.

I wonder how many other structures that messes up, but I committed the
EDID fix for now.

This has presumably been broken for a long time, but maybe the
affected targets don't typically use EDID and kernel modesetting, and
only use some fixed display setup instead.

Those structure definitions go back a _loong_ time (from a quick 'git
blame' I see November 2008).

But despite that, I did not mark my fix 'cc:stable' because I don't
know if any of those machines affected by this bad arm ABI issue could
possibly care.

At least my tree hopefully now builds on them, with the BUILD_BUG_ON()
that uncovered this.

                   Linus
