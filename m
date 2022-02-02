Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371934A74BE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 16:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243575AbiBBPiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbiBBPiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:38:02 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D86AC06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 07:38:02 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id 15so17352872ilg.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 07:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LXZjdBVUtQGV4jUy/sSg/c0o5bKUeLjM4SJrys+RBDA=;
        b=EwQJWxpGepkosxid+haDZbAtfhCXdkymdOi2U11KFVv5IkJFH9hjEIv9LmMM22rxv5
         v0I/0YeesBXynB/GV98KKdIvjPbMkrre483WJBHQ2pSjJusq75/gVpwWfVoYpwOw7lC6
         VWBPjYC3pu+IRCuYMYnjuZXTTX3frS9b+Vdqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LXZjdBVUtQGV4jUy/sSg/c0o5bKUeLjM4SJrys+RBDA=;
        b=XKYZ4KqwPf7b1HDe/BgAZpbKUYQmyH7OPlUJwPjSZzb4FRxmFPmBxke0V8ZiQ2pV0A
         fdHYvx7G+Mh1w8saY4Mudjrq0/2s2tb25WhYF/0ijxK98YH7VngR5Hul8W5kZuJk5pPM
         AoEymL2KYa8wo/Ih/XTTWgPDfjdmaYM1t/MAoD+n050Pa9qWHcdSxZBxOiRsMkYvoWeO
         DkovshRkyCheroGEG9kjeJt3IXUZMv1bVeXTiwiNAt+y3kUvpLkYNergP6u2xaHLUkJp
         o4etJ/15f5MIZBoTr59w9exqKnFlFItj7FjwJ8eiZ2Qj96vCdMLaZQL/RBDDu7/kdY/6
         VVfg==
X-Gm-Message-State: AOAM533DqLa+2/tkuEX+VyeIQ6Nzl8ofoMqzTly5vnS0s9SFdt8GAUYB
        c5W5Muz0/9SOlYl4JBFXT0cyX+oWgE4OCw==
X-Google-Smtp-Source: ABdhPJwfiWKpXveDzSNYkiR3H023Pib40kGyvlwMsW+DNk0pJwntUJqORfSqg/OKLw6ndSNPpjpj6g==
X-Received: by 2002:a05:6e02:1bab:: with SMTP id n11mr18892902ili.213.1643816281468;
        Wed, 02 Feb 2022 07:38:01 -0800 (PST)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id g19sm10021640ilk.30.2022.02.02.07.37.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 07:37:59 -0800 (PST)
Received: by mail-il1-f181.google.com with SMTP id s1so17347413ilj.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 07:37:59 -0800 (PST)
X-Received: by 2002:a92:c011:: with SMTP id q17mr16748310ild.165.1643816278744;
 Wed, 02 Feb 2022 07:37:58 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvN0NyaVkRQmA1O6rX7H8PPaZrUAD7=RDy33QY9rUU-9g@mail.gmail.com>
 <76ff2848-3af4-6758-6e98-91a4c9ad26d8@suse.de> <CAMj1kXE6Q9uW45Q5A-TuPDiXTPOGrGjUn_8FUBKNGQ1g9bd3Rg@mail.gmail.com>
 <a1dd9d31-3ad0-b58f-c67b-5896048281ed@suse.de>
In-Reply-To: <a1dd9d31-3ad0-b58f-c67b-5896048281ed@suse.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 2 Feb 2022 07:37:47 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UzVczyMKiCt9tkMBveGqWFbACMF_Z1GRWypz+awSO06Q@mail.gmail.com>
Message-ID: <CAD=FV=UzVczyMKiCt9tkMBveGqWFbACMF_Z1GRWypz+awSO06Q@mail.gmail.com>
Subject: Re: [next] arm: panel-edp.c:(.text+0xb74): undefined reference to `drm_panel_dp_aux_backlight'
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Marek Vasut <marex@denx.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        regressions@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        David Airlie <airlied@linux.ie>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        lkft-triage@lists.linaro.org,
        Grace Mi <grace.mi@ecs.corp-partner.google.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 2, 2022 at 2:25 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 02.02.22 um 10:28 schrieb Ard Biesheuvel:
> > On Wed, 2 Feb 2022 at 10:08, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >>
> >> Hi
> >>
> >> Am 02.02.22 um 10:02 schrieb Naresh Kamboju:
> >>> Following builds failed on Linux next 20220202 arm architecture.
> >>>     - arm-gcc-10-omap2plus_defconfig
> >>>     - arm-clang-nightly-shmobile_defconfig
> >>>     - arm-gcc-8-lpc32xx_defconfig
> >>>     - arm-clang-13-shmobile_defconfig
> >>>     - arm-gcc-10-shmobile_defconfig
> >>>     - arm-clang-11-shmobile_defconfig
> >>>     - arm-clang-11-omap2plus_defconfig
> >>>     - arm-clang-13-omap2plus_defconfig
> >>>     - arm-clang-11-lpc32xx_defconfig
> >>>     - arm-gcc-8-omap2plus_defconfig
> >>>     - arm-gcc-9-vexpress_defconfig
> >>>     - arm-clang-nightly-lpc32xx_defconfig
> >>>     - arm-gcc-9-shmobile_defconfig
> >>>     - arm-clang-13-lpc32xx_defconfig
> >>>     - arm-gcc-10-sama5_defconfig
> >>>     - arm-clang-11-vexpress_defconfig
> >>>     - arm-clang-11-sama5_defconfig
> >>>     - arm-gcc-9-omap2plus_defconfig
> >>>     - arm-clang-nightly-sama5_defconfig
> >>>     - arm-clang-13-vexpress_defconfig
> >>>     - arm-clang-nightly-vexpress_defconfig
> >>>     - arm-gcc-9-lpc32xx_defconfig
> >>>     - arm-clang-12-vexpress_defconfig
> >>>     - arm-gcc-10-vexpress_defconfig
> >>>     - arm-clang-12-shmobile_defconfig
> >>>     - arm-gcc-11-omap2plus_defconfig
> >>>     - arm-gcc-9-sama5_defconfig
> >>>     - arm-gcc-8-shmobile_defconfig
> >>>     - arm-gcc-10-lpc32xx_defconfig
> >>>     - arm-clang-12-omap2plus_defconfig
> >>>     - arm-gcc-8-vexpress_defconfig
> >>>     - arm-clang-12-sama5_defconfig
> >>>     - arm-clang-nightly-omap2plus_defconfig
> >>>     - arm-gcc-11-lpc32xx_defconfig
> >>>     - arm-gcc-11-sama5_defconfig
> >>>     - arm-gcc-11-shmobile_defconfig
> >>>     - arm-gcc-11-vexpress_defconfig
> >>>     - arm-gcc-8-sama5_defconfig
> >>>     - arm-clang-13-sama5_defconfig
> >>>     - arm-clang-12-lpc32xx_defconfig
> >>>
> >>>
> >>> make --silent --keep-going --jobs=8  ARCH=arm
> >>> CROSS_COMPILE=arm-linux-gnueabihf- 'CC=sccache
> >>> arm-linux-gnueabihf-gcc' 'HOSTCC=sccache gcc' vexpress_defconfig
> >>> make --silent --keep-going --jobs=8  ARCH=arm
> >>> CROSS_COMPILE=arm-linux-gnueabihf- 'CC=sccache
> >>> arm-linux-gnueabihf-gcc' 'HOSTCC=sccache gcc'
> >>> arm-linux-gnueabihf-ld: drivers/gpu/drm/panel/panel-edp.o: in function
> >>> `panel_edp_probe':
> >>> panel-edp.c:(.text+0xb74): undefined reference to `drm_panel_dp_aux_backlight'
> >>> make[1]: *** [/builds/linux/Makefile:1222: vmlinux] Error 1
> >>>
> >>>
> >>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >>>
> >>> meta data:
> >>> -----------
> >>>       git describe: next-20220202
> >>>       git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> >>>       target_arch: arm
> >>>       kconfig: vexpress_defconfig
> >>>       toolchain: gcc-11
> >>>
> >>> Build log:
> >>> -------------
> >>> https://builds.tuxbuild.com/24XRim72vFXix6l6MdAJNENy6je/
> >>>
> >>> Steps to reproduce:
> >>> --------------------
> >>> # To install tuxmake on your system globally:
> >>> # sudo pip3 install -U tuxmake
> >>> #
> >>> # See https://docs.tuxmake.org/ for complete documentation.
> >>> # Original tuxmake command with fragments listed below.
> >>>
> >>> tuxmake --runtime podman --target-arch arm --toolchain gcc-11
> >>> --kconfig vexpress_defconfig
> >>>
> >>> tuxmake --runtime podman --target-arch arm --toolchain gcc-11
> >>> --kconfig https://builds.tuxbuild.com/24XRim72vFXix6l6MdAJNENy6je/config
> >>
> >> You'll now need
> >>
> >>     CONFIG_DRM_DP_HELPER=y
> >>
> >> in your config.
> >>
> >
> > That should never be the solution for linker errors such as this one.
> >
> > If CONFIG_DRM_PANEL_EDP relies on something provided by
> > CONFIG_DRM_DP_HELPER, it should select it or depend on it in Kconfig.
>
> Of course, we'll provide a patch for the Kconfig files.

There was discussion about this last November but I guess nothing came of it?

https://lore.kernel.org/r/20211117062704.14671-1-rdunlap@infradead.org/

In there Arnd provided a proposed patch. If everyone likes that and it
fixes things then we can apply it...

-Doug
