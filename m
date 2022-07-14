Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1715752C8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239374AbiGNQaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbiGNQ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:29:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DE733410
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:29:58 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eq6so3106175edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZI0YHVo/gtkOB8tgyDWcbFNn6KxRA45rOQ9nm1YXK/Q=;
        b=qDcqaSAhw+hlOV5MLaMQb3gYMlJSXY1JVhNzIBNLgXH/Azc2KW0WxR+hxUZcNtDxm6
         InWFK4mBuPj0hpBt3PvwutZW5wUJKMYCh0SPUqO4ZXY8DZB7dVBAr/e2/bq6FEbr7j8a
         igiR4rkthJIEYAAJHPMok4ww9tD869WwPg8aAOKwa0/tachtsAIUBYQNJu2lL7dSTuFm
         bFNhX6QVDJRJBWkwMrW/0pxO6DFhcWycipykiOhv48CW/jjT0SmOfSn2DaggW8swX/WL
         s/UNX/NjcUc71qQNPXWtJfbQPctemAAkIZMZhE6w1fxcaNdrj5q5UAAKsh+KhhdrYB29
         25Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZI0YHVo/gtkOB8tgyDWcbFNn6KxRA45rOQ9nm1YXK/Q=;
        b=Z2HlDNEZRG11NRTPrwcSzo1hTkI1a/UPV0qzWRIj310CsAzhjPJnZjOv98XYvgCEWB
         3wWJWUQrFQfcKcf+1CDcvHRLK33dA9Ai1VOcGV7h6uZjJBNmYljNCardB1Zs+SAd25uW
         TUBeoqwAbpAkJS+c7sENYmScE3p+P0iOhEo1WZ+pfKYyOg1Qu7ImiyLGQeCWkAxSh3Wp
         72zozVBlavwL0wdpr/EVfY8NKKO4e98Bp0sZ7hD5kYXSJ6K7JA/zGJApjrk1SqyJPkwy
         gYAfSIcvFWnVdHSmx4EiUZt1YCFzteA9G1HT6zpOfG+JYHY2zagv69W8XUvALwoe5bqa
         Q8AA==
X-Gm-Message-State: AJIora+WJM50dR33dvLXF7f2pTBbaLxfMeyv0gV/zXEzQMWmWwxv+Wal
        voHWbmEU1jImNTmw7i+y/NNstFD23gV8pnsa/P5uqyhm
X-Google-Smtp-Source: AGRyM1v1rUkvs34Q+Hk692TjKXzRoe56b59xLKpN80MV6b/Wor2PR/mwxiLwKJwHkkS8wmVStWlwlpJkBoau4i75WJc=
X-Received: by 2002:a05:6402:13:b0:439:ffe8:bec9 with SMTP id
 d19-20020a056402001300b00439ffe8bec9mr13648034edu.297.1657816196801; Thu, 14
 Jul 2022 09:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220712224247.1950273-1-linux@roeck-us.net> <98b656f3-e506-90be-ebcc-898813051e74@amd.com>
In-Reply-To: <98b656f3-e506-90be-ebcc-898813051e74@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jul 2022 12:29:45 -0400
Message-ID: <CADnq5_OMayFN52hr7ZWFqMHPaV5_q7Hi+4LEbNMgfTPqo3__=w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Enable building new display engine with
 KCOV enabled
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
        Leo Li <sunpeng.li@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Wed, Jul 13, 2022 at 4:03 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2022-07-12 18:42, Guenter Roeck wrote:
> > The new display engine uses floating point math, which is not supported
> > by KCOV. Commit 9d1d02ff3678 ("drm/amd/display: Don't build DCN1 when kcov
> > is enabled") tried to work around the problem by disabling
> > CONFIG_DRM_AMD_DC_DCN if KCOV_INSTRUMENT_ALL and KCOV_ENABLE_COMPARISONS
> > are enabled. The result is that KCOV can not be enabled on systems which
> > require this display engine. A much simpler and less invasive solution is
> > to disable KCOV selectively when compiling the display enagine while
> > keeping it enabled for the rest of the kernel.
> >
> > Fixes: 9d1d02ff3678 ("drm/amd/display: Don't build DCN1 when kcov is enabled")
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Leo Li <sunpeng.li@amd.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/Kconfig     | 2 +-
> >  drivers/gpu/drm/amd/display/dc/Makefile | 3 +++
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> > index b4029c0d5d8c..96cbc87f7b6b 100644
> > --- a/drivers/gpu/drm/amd/display/Kconfig
> > +++ b/drivers/gpu/drm/amd/display/Kconfig
> > @@ -6,7 +6,7 @@ config DRM_AMD_DC
> >       bool "AMD DC - Enable new display engine"
> >       default y
> >       select SND_HDA_COMPONENT if SND_HDA_CORE
> > -     select DRM_AMD_DC_DCN if (X86 || PPC64) && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
> > +     select DRM_AMD_DC_DCN if (X86 || PPC64)
> >       help
> >         Choose this option if you want to use the new display engine
> >         support for AMDGPU. This adds required support for Vega and
> > diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
> > index b4eca0236435..b801973749d2 100644
> > --- a/drivers/gpu/drm/amd/display/dc/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/Makefile
> > @@ -26,6 +26,9 @@
> >  DC_LIBS = basics bios dml clk_mgr dce gpio irq link virtual
> >
> >  ifdef CONFIG_DRM_AMD_DC_DCN
> > +
> > +KCOV_INSTRUMENT := n
> > +
> >  DC_LIBS += dcn20
> >  DC_LIBS += dsc
> >  DC_LIBS += dcn10
>
