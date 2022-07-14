Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F265745D5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 09:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbiGNHXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 03:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236299AbiGNHXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 03:23:30 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E646630F4A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 00:23:28 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id g9so854925qvq.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 00:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmlXtnA3cC4Ik7QOf/RIurG9dJCZvwzcFfVviIGb20U=;
        b=ZN5LpblNbgg6tJqbb/F//QzCV3lZMxJCCuX8ZJPsArIRVM8HX9AtAZ1WlhRyW5rL4c
         Uxo6SyWi4TFtBl9og7+wC3y7AbyF14izxFGBU8VSssexcjrtpKawkkcJEW7Y5yNBl0S6
         RY5DsLBY3QPdFDF0tthGTJUOOg8KW/yOzGjs2D0Ucbg1ci0JgibKizhXFgaCzd1o2qZv
         5O3QNWwXa6fdkTHPzmhkLmhg68XPXT2Ck6sebrw1di9rZoeCMnvTjVXH3po6ME60/AvM
         yGduwgMXQzhf2IYwCSNZjQnvGp+7oOn1DSKJSkHeHEUea7ry59Ao7uBn2ZOWZ+lXxU9B
         6gxQ==
X-Gm-Message-State: AJIora/K/Pqe++5l0sQs6pPl1gTY2keT+qgcamJdDkbm9TchFGp/aZ8/
        HXT6g5dZ32o9fMNnpbgzZ6LQ6brhIv4uEA==
X-Google-Smtp-Source: AGRyM1sxdoIURgttjaKLkPUe60nscpROMW8BZ1KZaKSiTWRMjnqtYtG7V9f47Buwf5nLsQ87qjcddQ==
X-Received: by 2002:a0c:e10d:0:b0:473:1d:d6ce with SMTP id w13-20020a0ce10d000000b00473001dd6cemr6342694qvk.36.1657783407834;
        Thu, 14 Jul 2022 00:23:27 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id t13-20020a37ea0d000000b006af147d4876sm782558qkj.30.2022.07.14.00.23.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 00:23:26 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id y195so1864450yby.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 00:23:26 -0700 (PDT)
X-Received: by 2002:a5b:6c1:0:b0:669:a7c3:4c33 with SMTP id
 r1-20020a5b06c1000000b00669a7c34c33mr7180560ybq.543.1657783405770; Thu, 14
 Jul 2022 00:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net> <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net> <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
 <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Jul 2022 09:23:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV9Pj9V-ZPpu=BMSkPt1uA_eCvU4+bxF8ZfHjteRk2CAg@mail.gmail.com>
Message-ID: <CAMuHMdV9Pj9V-ZPpu=BMSkPt1uA_eCvU4+bxF8ZfHjteRk2CAg@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wed, Jul 13, 2022 at 11:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Jul 13, 2022 at 2:01 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> > If you want to apply Guenter's patch original patch:
> > https://patchwork.freedesktop.org/patch/490184/
> > That's fine with me.
>
> Honestly, by this time I feel that it's too little, too late.

[...]

> So considering that the ppc people ignored this whole issue since the
> merge window, I think it's entirely unreasonable to then apply a
> ppc-specific patch for this at this time, when people literally asked
> "why is this needed", and there was no reply from the powerpc side.

Oh, it's not just this one. The lists of build regressions between v5.18
and v5.19-rc1 [1] resp. v5.19-rc6 [2] look surprisingly similar :-(

[1] https://lore.kernel.org/all/20220606082201.2792145-1-geert@linux-m68k.org
[2] https://lore.kernel.org/all/20220711064425.3084093-1-geert@linux-m68k.org

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
