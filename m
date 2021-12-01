Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB514464B80
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348610AbhLAKYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:24:20 -0500
Received: from mail-ua1-f48.google.com ([209.85.222.48]:37813 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbhLAKYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:24:17 -0500
Received: by mail-ua1-f48.google.com with SMTP id o1so47787069uap.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 02:20:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=urLNBsFGliR6FhvwlQWsAIf0ZWR7LeLf64IUUPE+zmE=;
        b=1/l6fWX2V4FZ1HIMu9Se46py4R26Fye6dR5NuQPmXYBzj9j17lcrbOzYoZIM9nGg9Z
         6vzNp2TiS4eB4OrvTjsSVJlzMU7JJzatyNdhMfcoEKrNypMaAdlR4WY/MVIMJG6eCI+p
         A7o03+ZGxndsbrou47p7cxozejcKxSlw/xIEWRhZiHZBaIeX6Tf1doL6dxpWw0F5Q+SB
         IVDbGjGhCmfhjWgbuqXSkz5UmfmLSEHMTdATR3xlKzdvQ4wRwMECkKJjK7cLJcWIcG49
         7rk8kwmKQ26MwQY48dUZPDpIoyj+QGyju63Mz0tMlp7xL3YQaiFtyErmsU1MlpszgHzW
         ix9g==
X-Gm-Message-State: AOAM5333Dnpq7VVruBAy0t3xczPpjzeC7F+9035FMYsr8M/5fjmeF1gv
        6EuGN4FvSsom85Y9+JUxdjg5zhrUqz21sg==
X-Google-Smtp-Source: ABdhPJwebFZs7UTtgaEkCERZHKJYrQQV2TOJOnGlCWhbokECZRlNAZk1Xd5svuv7EE2eE+m+N7E+EQ==
X-Received: by 2002:ab0:74c1:: with SMTP id f1mr5876017uaq.109.1638354056477;
        Wed, 01 Dec 2021 02:20:56 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id 23sm11355787vkk.17.2021.12.01.02.20.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 02:20:55 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id s1so7290887vks.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 02:20:55 -0800 (PST)
X-Received: by 2002:a05:6122:2193:: with SMTP id j19mr5849899vkd.7.1638354055034;
 Wed, 01 Dec 2021 02:20:55 -0800 (PST)
MIME-Version: 1.0
References: <20211117093734.17407-1-daniel.baluta@oss.nxp.com>
 <20211117093734.17407-8-daniel.baluta@oss.nxp.com> <CAMuHMdVV6Os8Gzc9JVjD2CAtN38=7KFn9GqosnWvByQc-7uA=Q@mail.gmail.com>
 <bdbea252-09e4-eb60-acf8-4ea8a1d924c4@linux.intel.com> <YaZZzSPQDz0vHRQY@sirena.org.uk>
In-Reply-To: <YaZZzSPQDz0vHRQY@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 1 Dec 2021 11:20:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU5Lc9x4mnoKn2xUPku1tT1XM=ALY-vPtos=NBjcrzAWQ@mail.gmail.com>
Message-ID: <CAMuHMdU5Lc9x4mnoKn2xUPku1tT1XM=ALY-vPtos=NBjcrzAWQ@mail.gmail.com>
Subject: Re: [PATCH 07/21] ASoC: amd: Add module to determine ACP configuration
To:     Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Daniel Baluta <daniel.baluta@oss.nxp.com>,
        daniel.baluta@gmail.com,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        AjitKumar.Pandey@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Julian.Schroeder@amd.com, linux-mediatek@lists.infradead.org,
        Balakishore.pati@amd.com, yc.hung@mediatek.com,
        vishnuvardhanrao.ravulapati@amd.com, vsreddy@amd.com,
        daniel.baluta@nxp.com, Bard Liao <bard.liao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Nov 30, 2021 at 6:05 PM Mark Brown <broonie@kernel.org> wrote:
> On Tue, Nov 30, 2021 at 10:49:30AM -0600, Pierre-Louis Bossart wrote:
> > To Geert's point, there may be an additional need to add a
>
> > depends on SND_SOC_AMD_ACP
>
> > There are also a set of
>
> > SND_SOC_AMD_ACPyx options, not sure if any applies as a dependency here?
>
> Or put them in an if block (IIRC I thought they were which was why the
> dependency wasn't needed but I don't know what I was looking at if I did
> check that).

Probably you were looking at sound/soc/amd/acp/Kconfig, where all the
other ACP options live, and where you had applied my earlier patch
to wrap everything in a big "if".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
