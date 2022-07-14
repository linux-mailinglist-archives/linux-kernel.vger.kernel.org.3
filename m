Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131CE57502D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbiGNN6q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Jul 2022 09:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiGNN6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:58:23 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0948B63905
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:57:00 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id l15so1452737qvo.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VAkD3iZBMP+yVm34poCQsaJsrow+jcIzp7CvvJFKyqQ=;
        b=QnFemX0NUQ3Oo8JyEEZ+tlvmMG4PNIXWTfg9UBmvk0bEiI1l2X5akOVrTAkIXjI4G7
         Bu5SCqBSA/PQeo78djjK4eRZdBIrIbGa1inuYET8R2z432q33dZLVJGBUuS09bjs2vnO
         1qMDoWosq+VTH/xe0coz/29nRiXFm4LKv76K1zx0/swckImKuawPKMkUsUQtiPnUP+b5
         ab6eyvY2GZKY+jNFcd9iiGyGmvrA/KkrOe7xzQevUm1gcp6mNi8nqaw/oZxm2XO0ogXu
         4ipAxYPR/cSRq3b/hF2tQZnXqoBPjI67oVUUifLpx7cJ0zIw95p5VaGlh+Sqsw+73qS5
         Gf1Q==
X-Gm-Message-State: AJIora8ttv3Eu78EPG3QwIvHYRhNELruledvviVLgP7qnfmSXvPleIRb
        RoNG9GL4rSU27dMzL8VXlaY1UK/bYdR6bg==
X-Google-Smtp-Source: AGRyM1vPLAT4JITCkurQI+2srpmSb7kOMqJDae6+dUVcYklWn++uAhnCIRdk7Q017az8BbGdnecaGg==
X-Received: by 2002:a05:6214:2465:b0:472:ffd8:93e9 with SMTP id im5-20020a056214246500b00472ffd893e9mr7816148qvb.47.1657807018983;
        Thu, 14 Jul 2022 06:56:58 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id m1-20020a05620a24c100b006a6d7c3a82esm451053qkn.15.2022.07.14.06.56.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 06:56:58 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-31caffa4a45so17841347b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:56:57 -0700 (PDT)
X-Received: by 2002:a81:af27:0:b0:31c:833f:eda5 with SMTP id
 n39-20020a81af27000000b0031c833feda5mr10022492ywh.358.1657807017454; Thu, 14
 Jul 2022 06:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net> <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net> <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
 <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
 <CAMuHMdV9Pj9V-ZPpu=BMSkPt1uA_eCvU4+bxF8ZfHjteRk2CAg@mail.gmail.com> <2cac3590-3e9c-bdf3-4211-8559e581d44d@roeck-us.net>
In-Reply-To: <2cac3590-3e9c-bdf3-4211-8559e581d44d@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Jul 2022 15:56:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUSMk5ghxi_AvqYOha7EPa7o+2pKCmreNoB9BfD=BEHRA@mail.gmail.com>
Message-ID: <CAMuHMdUSMk5ghxi_AvqYOha7EPa7o+2pKCmreNoB9BfD=BEHRA@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Günter,

On Thu, Jul 14, 2022 at 3:20 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On 7/14/22 00:23, Geert Uytterhoeven wrote:
> > On Wed, Jul 13, 2022 at 11:51 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >> On Wed, Jul 13, 2022 at 2:01 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >>> If you want to apply Guenter's patch original patch:
> >>> https://patchwork.freedesktop.org/patch/490184/
> >>> That's fine with me.
> >>
> >> Honestly, by this time I feel that it's too little, too late.
> >
> > [...]
> >
> >> So considering that the ppc people ignored this whole issue since the
> >> merge window, I think it's entirely unreasonable to then apply a
> >> ppc-specific patch for this at this time, when people literally asked
> >> "why is this needed", and there was no reply from the powerpc side.
> >
> > Oh, it's not just this one. The lists of build regressions between v5.18
> > and v5.19-rc1 [1] resp. v5.19-rc6 [2] look surprisingly similar :-(
> >
> > [1] https://lore.kernel.org/all/20220606082201.2792145-1-geert@linux-m68k.org
> > [2] https://lore.kernel.org/all/20220711064425.3084093-1-geert@linux-m68k.org
> >
>
> How do you build your images ? I don't see many of the problems you report,
> even if I build the files with W=1. It is odd, since reports such as

I rely on the kisskb build service, and just parse their build logs.

> drivers/mfd/asic3.c:941:23: error: unused variable 'asic'
>
> are real, but I just don't see that. If I build that file, I see that
> it builds with -Wno-unused-but-set-variable, due to
>
> Makefile:KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
>
> The override in scripts/Makefile.extrawarn doesn't seem to work even though
> it adds "-Wunused-but-set-variable" to the compile flags. And if I remove
> "-Wno-unused-but-set-variable" from Makefile I still don't get the error/warning.
> Confused. I must be missing something, but what ?

That particular error is seen in the sh4-gcc11/sh-allmodconfig
build[3].  I assume it is fixed by now (see commit d684e0a52d36f893
("sh: convert nommu io{re,un}map() to static inline functions")).

[3] http://kisskb.ellerman.id.au/kisskb/buildresult/14767627/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
