Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D78D56C2F3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbiGHUJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239224AbiGHUJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:09:17 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388965FD5;
        Fri,  8 Jul 2022 13:09:16 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id z13so28955788qts.12;
        Fri, 08 Jul 2022 13:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g4cN28gLKvnxOr4BZ0S05ExiGP3ONr1wnsZDOx3J0h4=;
        b=fy0pERHibIWuVogxks19K+OvPgNDgPuVnVUXP/dGxP4CCAbXiBu8sXBgoTKAHOlUAh
         /0qWzh6e53YIK+yWTUsuLv5mnAM0P/N5QS9XZSvCSZCaJ3dhMWu1mfdNtajW+s8YE8uH
         0ANX8JK3nsJRFU1rxO3X2MnfHAlVE0SiIPRwXnLNxSdpsu0T+n03bEUSs0cdBF2RInE/
         MNtBq25AEVgw9YVkQcrDF2H66ZgQBkVkC6pQBrgEOi4NTDLc75gXG5d8xjdEQKun3FF9
         7gwW+tVrcDuSmNLKd/sJN9aAG8FY2/GpL68pfQZO5Hn61ebAyxJXdq5D8hIZ1ykY4+GD
         dVFw==
X-Gm-Message-State: AJIora9jIRu1kPfBPKmpgEIPjfPocWjWMnBKNetqpItPeS66nvA5mH1V
        x+GWFaeqOHTojln3se+PoPAmi3bte6ztBg==
X-Google-Smtp-Source: AGRyM1s1qza4+zDp16FWevRs8BRlL8Squ2Gb62GtQsKIVbV9ILmtTCtE9U0HspRiBFoyTRm+Ut8aGQ==
X-Received: by 2002:a05:622a:38f:b0:305:1ea5:4a7 with SMTP id j15-20020a05622a038f00b003051ea504a7mr4592763qtx.291.1657310954977;
        Fri, 08 Jul 2022 13:09:14 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id s12-20020a05620a29cc00b006a36b0d7f27sm39620509qkp.76.2022.07.08.13.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 13:09:14 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-3137316bb69so207968357b3.10;
        Fri, 08 Jul 2022 13:09:13 -0700 (PDT)
X-Received: by 2002:a0d:dd09:0:b0:31c:e3b9:7442 with SMTP id
 g9-20020a0ddd09000000b0031ce3b97442mr5915415ywe.47.1657310953183; Fri, 08 Jul
 2022 13:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657301107.git.geert@linux-m68k.org> <64e2e9b14c26df28908789374253fd12072c26c2.1657301107.git.geert@linux-m68k.org>
 <b7d937bc-d7c3-6f7a-047c-fc6e5756a5a0@redhat.com> <CAMuHMdWCz4j5bxKBY-W3zWiCLRc9QP+OKco-haGH_9YUhaROgA@mail.gmail.com>
In-Reply-To: <CAMuHMdWCz4j5bxKBY-W3zWiCLRc9QP+OKco-haGH_9YUhaROgA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Jul 2022 22:09:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWmBsakEndNi0+r3NZ2xLkVt6ZhAoJGS2eWhcc1Bi20HQ@mail.gmail.com>
Message-ID: <CAMuHMdWmBsakEndNi0+r3NZ2xLkVt6ZhAoJGS2eWhcc1Bi20HQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/modes: parse_cmdline: Handle empty mode name part
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Fri, Jul 8, 2022 at 10:06 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, Jul 8, 2022 at 9:28 PM Hans de Goede <hdegoede@redhat.com> wrote:
> > On 7/8/22 20:21, Geert Uytterhoeven wrote:
> > > If no mode name part was specified, mode_end is zero, and the "ret ==
> > > mode_end" check does the wrong thing.
> > >
> > > Fix this by checking for a non-zero return value instead.
> >
> > Which is wrong to do, since now if you have e.g. a mode list
> > with:
> >
> > "dblntsc",
> > "dblntsc-ff"
> >
> > in there and the cmdline contains "dblntsc-ff" then you
> > will already stop with a (wrong!) match at "dblntsc".
>
> It indeed behaves that way, and did so before, as str_has_prefix()
> checks for a matching prefix, and thus may never get to the full
> match.  However, can we change that to an exact match, without
> introducing regressions?
> This can be avoided by reverse-sorting the modelist (or iterating
> backwards through a sorted modelist), though.
>
> > > While at it, skip all named mode handling when mode_end is zero, as it
> > > is futile.
> >
> > AFAICT, this is actually what needs to be done to fix this, while keeping
> > the ret == mode_end check.
>
> "ret == mode_end" or "ret" doesn't matter (except for the special
> case of mode_end is zero), as str_has_prefix() returns either zero or
> the length of the prefix.  Hence it never returns a non-zero value
> smaller than the length of the prefix.

Ignore that.  I finally saw what's really happening.
And I do agree with your comment.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
