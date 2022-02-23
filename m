Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B52F4C1840
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242343AbiBWQLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbiBWQLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:11:49 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E20C4B67
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:11:21 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id c6so42059685edk.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5qKegv6oI4JVSPI+80dtUnPmB566v0hDmN9wDy+qXo=;
        b=EC69yM62vfAYpURzcMUxXa9SJ1iNma+rnpEiEhk72v8bKiT7ZaCFOrNcA03N7P3oBj
         +6dc+2+xM7b+6Chp9hLL5RxKTgH1qd5Pn2JxdsdYKlxQowGwLeFjw6VQ2ONzFOa42Muy
         k+IhVJZUlX4VYSTdzGTYXdl3L1BBEmefJP8k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5qKegv6oI4JVSPI+80dtUnPmB566v0hDmN9wDy+qXo=;
        b=pI7L+LDevcFZVCl8juMjKtWCaeCxGzpckLrO5FM2iPGmXBjY1BF06uN4tth3jlQ8UV
         Z0+zQzH9ynTgvL8HKkIMZYVlU1DPj6BS4X4VLnkrYAH39/CUM8cZN09jPzve3OC8SlWs
         uzY397Ida1iVp5WBdJijqzLAglgO+5QvtMgPK1tLw4GyNvaEmYk6YysCSilXBqQnWeIO
         Ej8ShnoZ84X0vuk36T3Soj3lm/AUl4+RQAdYk6K7OEkMOSXxZ4OEw9e3CoYsz6TGGrib
         epnPs+n1QU7/v34AluucSf0nwlWRmz8NCTiu8B4lgAQY5Bxk1mwBH5mBK+4kR3GLFjBD
         G8CA==
X-Gm-Message-State: AOAM53277dRnevfPFGreLOZx/VIb1t2MRV24jV90wQyLc2IZn74Kjmpk
        laGVVUr1eKVTNxg82G0dndRHtPSz5JmJ8htyCZA=
X-Google-Smtp-Source: ABdhPJzlSYOraJXBJbnL+iCT0GvvCKAGTgyPb8/NAjz6BlVLqSIJyvS163hgwFUNplPIEaX2gXe6Kw==
X-Received: by 2002:a05:6402:350e:b0:412:d02f:9004 with SMTP id b14-20020a056402350e00b00412d02f9004mr125208edd.59.1645632679717;
        Wed, 23 Feb 2022 08:11:19 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id o9sm45180ejn.16.2022.02.23.08.11.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 08:11:19 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id o4so3668895wrf.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:11:19 -0800 (PST)
X-Received: by 2002:a5d:64a6:0:b0:1ea:80f8:a14e with SMTP id
 m6-20020a5d64a6000000b001ea80f8a14emr241220wrp.513.1645632678590; Wed, 23 Feb
 2022 08:11:18 -0800 (PST)
MIME-Version: 1.0
References: <20220203093922.20754-1-tzimmermann@suse.de> <CAMuHMdWykWR4oKahC2GYF5jG4przRQ+MxNNm1BK7o62OhhGYwA@mail.gmail.com>
 <CAMuHMdXcRRgn4EMXn9qonnjTTp7EEfwP4F8FeVpLkQMNvB-6mg@mail.gmail.com>
In-Reply-To: <CAMuHMdXcRRgn4EMXn9qonnjTTp7EEfwP4F8FeVpLkQMNvB-6mg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 23 Feb 2022 08:11:04 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UbiXx4RBQNFp1htCYsM1YzAgES+mcA6KOJ7ZmydkHnBg@mail.gmail.com>
Message-ID: <CAD=FV=UbiXx4RBQNFp1htCYsM1YzAgES+mcA6KOJ7ZmydkHnBg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: Select DRM_DP_HELPER for DRM_PANEL_EDP
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 22, 2022 at 1:31 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Tue, Feb 8, 2022 at 10:39 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, Feb 7, 2022 at 12:31 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > > As reported in [1], DRM_PANEL_EDP depends on DRM_DP_HELPER. Select
> > > the option to fix the build failure. The error message is shown
> > > below.
> > >
> > >   arm-linux-gnueabihf-ld: drivers/gpu/drm/panel/panel-edp.o: in function
> > >     `panel_edp_probe': panel-edp.c:(.text+0xb74): undefined reference to
> > >     `drm_panel_dp_aux_backlight'
> > >   make[1]: *** [/builds/linux/Makefile:1222: vmlinux] Error 1
> > >
> > > The issue has been reported before, when DisplayPort helpers were
> > > hidden behind the option CONFIG_DRM_KMS_HELPER. [2]
> > >
> > > v2:
> > >         * fix and expand commit description (Arnd)
> > >
> > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> >
> > Thanks for your patch!
> >
> > This fixes the build errors I'm seeing, so
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Is this planned to be queued? This is still failing in drm-next.
> Thanks!

Looks like this has been in drm-misc-next since Feb 4:

---

commit eea89dff4c39a106f98d1cb5e4d626f8c63908b9
Author:     Thomas Zimmermann <tzimmermann@suse.de>
AuthorDate: Thu Feb 3 10:39:22 2022 +0100
Commit:     Thomas Zimmermann <tzimmermann@suse.de>
CommitDate: Fri Feb 4 09:38:47 2022 +0100

    drm/panel: Select DRM_DP_HELPER for DRM_PANEL_EDP

---

Maybe it needed to land elsewhere, though?

-Doug
