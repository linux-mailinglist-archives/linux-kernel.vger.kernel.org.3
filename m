Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CDC4B8D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbiBPQPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:15:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbiBPQPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:15:18 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412E52AE05B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:15:05 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id n6so2763651qvk.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q23CfdzbhPWox0JYOK736ZR2bG/djtbOwYRKCHw0zlk=;
        b=LopeoWDdvn9uqBSsXHeUi7ZeY9e6UPgyvBoDVx2YrQXEIpaPMdmrkWvEQw6aABTfJW
         ImFgZuzf5zulYTNkzzJtqhti3Re6z5U7o0/K3synahcVew6GTvabsNXJOTyl7CDVPf9O
         6pmyUM9EnmgKaw9FmK4ewWkBOo1nlzxMfBCpPTEstX5pW3m7osLZquQorh3niRBt+jnn
         LB3s1+Z7KsTFzCJ4JVZGnSSnJP0uqXw/41TW/RwIQJTQHJbK5q/IzqjEF8K/esBZCseS
         4JhRAYn9JpE/QJrPHZs5yEd+tAafK65OVMg0Dle2bAhLN6bWz9z4rhp46GSXbNrI97yA
         6DfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q23CfdzbhPWox0JYOK736ZR2bG/djtbOwYRKCHw0zlk=;
        b=SqHOLKkXfvQOUfY9Tyg0FOROWDQDyvVGhXBkoXwd7kB2jOCpuTvBp2sFxcGyVfxHLh
         4JOmlqWEtawZfEo6XdjJ5N4sTfYrNKap/FLGHGtHGVzAFYQmFkdgQHiCJjS1qZBRZ5eG
         kjfrs9IBjVp2pd0KKLwRSRSLkir7xo0Ijles+hxgfsPa94edizdyPuWjoxhmML2LYjoo
         3Z+dVwHS3c1ainCkTbLdau7vdEEEOGSHUzsBmcE+GFr2H2LJsE9+5ESHeiN6ObkJOP2N
         YeuHBgwGobAsRm8oSa9TsYuEHS7BlWCN08uAQn3xy4ggxdMps2gsFyCWm44P3Gt6l8SE
         f4+g==
X-Gm-Message-State: AOAM5323uqIj4L8GjAhANhOUOBMBAYOYZzzqdCHh6EjP41bcoSspfxu6
        anFsS3G4BXQLcA7zXYwDzAFRPIPg8kNUxrDPWnRnfw==
X-Google-Smtp-Source: ABdhPJxXoOwGWXp2JWrOVnRMMkxe4hu+hBQgfsRS7meCUtiC4pVwji/lVlEzlcEQgPOFV4d33e3TJKmJ2OM+l47hPaA=
X-Received: by 2002:a05:622a:408:b0:2cb:f12e:688a with SMTP id
 n8-20020a05622a040800b002cbf12e688amr2488428qtx.662.1645028104194; Wed, 16
 Feb 2022 08:15:04 -0800 (PST)
MIME-Version: 1.0
References: <20220215171017.1247291-1-keescook@chromium.org> <c8328ab5-7ea2-b9ba-fa71-9f2348729ea8@mev.co.uk>
In-Reply-To: <c8328ab5-7ea2-b9ba-fa71-9f2348729ea8@mev.co.uk>
From:   Spencer Olson <olsonse@umich.edu>
Date:   Wed, 16 Feb 2022 09:15:47 -0700
Message-ID: <CAOx9PeifjdanUF6NCqxA3O9U1Oz33SqtNvZZBVsugGfU7ASRVw@mail.gmail.com>
Subject: Re: [PATCH] comedi: drivers: ni_routes: Use strcmp() instead of memcmp()
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        kernel test robot <oliver.sang@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 8:03 AM Ian Abbott <abbotti@mev.co.uk> wrote:
>
> On 15/02/2022 17:10, Kees Cook wrote:
> > The family and device comparisons were using memcmp(), but this could
> > lead to Out-of-bounds reads when the length was larger than the
> > buffers being compared. Since these appear to always be NUL-terminated
> > strings, just use strcmp() instead.
> >
> > This was found with Clang under LTO:
> >
> > [ 92.405851][    T1] kernel BUG at lib/string_helpers.c:980!
> > ...
> > [ 92.409141][ T1] RIP: 0010:fortify_panic (fbdev.c:?)
> > ...
> > [ 92.410056][ T1] ni_assign_device_routes (fbdev.c:?)
> > [ 92.410056][ T1] ? unittest_enter (fbdev.c:?)
> > [ 92.410056][ T1] ni_routes_unittest (ni_routes_test.c:?)
> > [ 92.410056][ T1] ? unittest_enter (fbdev.c:?)
> > [ 92.410056][ T1] __initstub__kmod_ni_routes_test__505_604_ni_routes_unittest6 (fbdev.c:?)
> > [ 92.410056][ T1] do_one_initcall (fbdev.c:?)
> >
> > Cc: Ian Abbott <abbotti@mev.co.uk>
> > Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> > Cc: Spencer E. Olson <olsonse@umich.edu>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Link: https://lore.kernel.org/lkml/20220210072821.GD4074@xsang-OptiPlex-9020
> > Fixes: 4bb90c87abbe ("staging: comedi: add interface to ni routing table information")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >   drivers/comedi/drivers/ni_routes.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/comedi/drivers/ni_routes.c b/drivers/comedi/drivers/ni_routes.c
> > index f24eeb464eba..295a3a9ee0c9 100644
> > --- a/drivers/comedi/drivers/ni_routes.c
> > +++ b/drivers/comedi/drivers/ni_routes.c
> > @@ -56,8 +56,7 @@ static const u8 *ni_find_route_values(const char *device_family)
> >       int i;
> >
> >       for (i = 0; ni_all_route_values[i]; ++i) {
> > -             if (memcmp(ni_all_route_values[i]->family, device_family,
> > -                        strnlen(device_family, 30)) == 0) {
> > +             if (!strcmp(ni_all_route_values[i]->family, device_family)) {
> >                       rv = &ni_all_route_values[i]->register_values[0][0];
> >                       break;
> >               }
> > @@ -75,8 +74,7 @@ ni_find_valid_routes(const char *board_name)
> >       int i;
> >
> >       for (i = 0; ni_device_routes_list[i]; ++i) {
> > -             if (memcmp(ni_device_routes_list[i]->device, board_name,
> > -                        strnlen(board_name, 30)) == 0) {
> > +             if (!strcmp(ni_device_routes_list[i]->device, board_name)) {
> >                       dr = ni_device_routes_list[i];
> >                       break;
> >               }
>
> Looks good, thanks!  I'm not sure why the tests used memcmp() like that.
> Indeed, all the strings are statically allocated and null-terminated.
>
> Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
>
> --
> -=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
> -=( registered in England & Wales.  Regd. number: 02862268.  )=-
> -=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
> -=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

I was probably just being paranoid when I wrote that.


Spencer
