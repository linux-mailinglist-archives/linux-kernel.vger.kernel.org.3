Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFC455DE1F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241389AbiF0Vnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 17:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238871AbiF0Vnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:43:41 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CFBC4A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:43:40 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id fd6so14934428edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H1XknEnfRCFWWO1LXEJmw/yXLZDBD0z0CO+bXSUF3KY=;
        b=VfraCNxL3WGDCeRLxpsTD6VREJ07+yuuUDSzFON46Edw6+tXSXffSdDoF7eoQ4xdo1
         4/eFKWb/m/jURAq8eVhrhAlrtNryoFQE2LZ3kwNC9xh1AnWbkoXeNGSkBzm9CH070RKQ
         tuGscuRmNWmyMAHr96xKdTXJFwtva3l5WPDSbeHDADaYA7AvpiboY0DY/e5hg8Nk8hfr
         4o8P+8tiL4EoS+5WZ3J1KZ+QYcFKspqN5KVoUYaem4dhZhdUScy3tEoj9quq09ZkPKdA
         oEDh77ToBPLW+T7NoWX3X1k2GZNNRRO9//n2moFcOYbiy6e9MfRz5Iys81hsJ81gj20Y
         xRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H1XknEnfRCFWWO1LXEJmw/yXLZDBD0z0CO+bXSUF3KY=;
        b=n+iCuXxlxFvaRtiyncxqDbJgf/k4J7S4TUXKZoKPeFJFg6epeRz9JwgdaabSrxHI/I
         0IAy4TKL/SAtrmLUD0L1IlhIzV5Vb8My/iT4KISZr2hsCCd6IEvk5OaKrQjTXHUkcdsX
         oxLELKVUZ69ennWiaMSm8Jp10zCMs06LgiEhQgdQR5uMtdTzfaOWw8BOBmfmom+eNDVH
         UZiZz3/QzLCa02WTGuUps0UD0Hwf8mBPu9zpbwhtzWAVmYbQixreW4VrPtA3gcQsTfKA
         0rpk0eNLYaskeusEKfrG2IwmUldC1L7JUHj1O1MyYeg61F0a9inWD3oSBahbV9rmJtbJ
         yGbg==
X-Gm-Message-State: AJIora+0X0k8WV8Lknv3ITo7EOvYtQXdQwQyUJ2hpRmjcLuEDFwsdV/h
        RmhYeJxYHJgG0oGw8yWHsgiB41pbSkpUk9wzFZk=
X-Google-Smtp-Source: AGRyM1ty/F1vTKJ4iSXafpmMdgGebsJxkxtMH0H5oixaFzda6xrN+UoEjNyjWvXW0aPqdyRCXLmG71/0bvD9Z4sYB2c=
X-Received: by 2002:a05:6402:158e:b0:435:7d0f:ac85 with SMTP id
 c14-20020a056402158e00b004357d0fac85mr19127349edv.93.1656366219396; Mon, 27
 Jun 2022 14:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220626144615.2227149-1-trix@redhat.com> <34b5c26c-bf3f-4b7c-3dd8-9e1317968c28@amd.com>
In-Reply-To: <34b5c26c-bf3f-4b7c-3dd8-9e1317968c28@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 27 Jun 2022 17:43:27 -0400
Message-ID: <CADnq5_P8J12C-QZL7U9x6rs2RV44o-rvmESd7_R9b9qZuD_XhA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: change to_dal_irq_source_dnc32() storage
 class specifier to static
To:     Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     Tom Rix <trix@redhat.com>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Alex

On Mon, Jun 27, 2022 at 9:20 AM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
>
>
> On 2022-06-26 10:46, Tom Rix wrote:
> > sparse reports
> > drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn32/irq_service_dcn32.c:39:20: warning: symbol 'to_dal_irq_source_dcn32' was not declared. Should it be static?
> >
> > to_dal_irq_source_dnc32() is only referenced in irq_service_dnc32.c, so change its
> > storage class specifier to static.
> >
> > Fixes: 0efd4374f6b4 ("drm/amd/display: add dcn32 IRQ changes")
> > Signed-off-by: Tom Rix <trix@redhat.com>
> > ---
> >   drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
> > index 3a213ca2f077..b1012fa1977b 100644
> > --- a/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
> > +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn32/irq_service_dcn32.c
> > @@ -36,7 +36,7 @@
> >
> >   #define DCN_BASE__INST0_SEG2                       0x000034C0
> >
> > -enum dc_irq_source to_dal_irq_source_dcn32(
> > +static enum dc_irq_source to_dal_irq_source_dcn32(
> >               struct irq_service *irq_service,
> >               uint32_t src_id,
> >               uint32_t ext_id)
>
> Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
