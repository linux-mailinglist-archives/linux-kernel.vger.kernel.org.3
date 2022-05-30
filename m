Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA1253890D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 00:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239285AbiE3W6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 18:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiE3W6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 18:58:10 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25224515A6
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 15:58:09 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id q1so6839663ejz.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 15:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=93b76ZHbZcuHCfscxd3Lk2d9Wx/yBWaIajc4fFNKsBY=;
        b=KCNnBbaZtRLRoY3MVGmEaI+oOj68q4mGW3ulnyBw04EH4w9DzxWhvCRj6surNXd8CS
         fuvEHexXKjIqHTvvN3ZoulQQHSq0xCM25YCFhkqcpATO3cfAwJ9XdmOp8vsbSk60rIoX
         ACOTcJFXi+Q02vZwlN1nc1GvU+Pltqyfxs1CgDWE2hPQIviYaGqdCf9SlYUaIFhfV99R
         RhOBpWVW63h2VJb5hnKPSFw5j5S10V2knTtJ+PMQykdhK07awXOOzPvcINh6JfX4ckUS
         X4TMdYwN9Vsz2tgWnocs8Lp1qj5oEloCgZNB1xE/VKtK1vrkCexEQHTRRQ6OELY89TS0
         NZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=93b76ZHbZcuHCfscxd3Lk2d9Wx/yBWaIajc4fFNKsBY=;
        b=UVFtvi3JJQv9pHKxGt6zrSUWq0v3d0c/ZSUg/7/CVa/DJZb+7vynx9xF6uBTZzXysn
         3yXVJ7MCU29vEk79VeTG11Hn1z0G9I/0/Kz8P2DUTQlYnWWDYyNxbfxWwBZZL0+w4qpO
         Xx33e/st1vKHJ9qEyZLjTddyCIUVV2rIvHTiO42PdGXQ9ytZ+E1XAFzkffMM2zIuDlMJ
         PxdeFkM5NQRkKdZ9o3TCL+/zovFmxJB7hyLt1ikBCw/cv2qsUq+kxn8z557Tib+zzwuo
         aUP+uB0LMvE1C/1eyaCILs3FfBzikJ1/50jDESc3y+/26NON/838d21Yd5iX4fvU7uCr
         lD4w==
X-Gm-Message-State: AOAM533wNqq5Z2tAshqzyv6xMUYUaP9bNWLLd1XUQwwuytdN5P9MTxLO
        3sSslO12vbCqzJ94j0hvvS+bsJ7pGhH86jWRk8SlXw==
X-Google-Smtp-Source: ABdhPJwZ6vkc2aa9sZyVGj16xAXXu9l6zE8Gc+5vtwdxy87CFX8L2LO8+BmGDLTdugZNPYrKkOn+f1cBxRdBcQ97f4s=
X-Received: by 2002:a17:907:2cc7:b0:6fa:7356:f411 with SMTP id
 hg7-20020a1709072cc700b006fa7356f411mr49703826ejc.369.1653951487392; Mon, 30
 May 2022 15:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220530102017.471865-1-jose.exposito89@gmail.com>
 <20220530102017.471865-2-jose.exposito89@gmail.com> <20220530131158.kqq2mohxoh52xpeg@penduick>
 <20220530162903.GA6546@elementary>
In-Reply-To: <20220530162903.GA6546@elementary>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 30 May 2022 15:57:56 -0700
Message-ID: <CAGS_qxpV2SsihEdgXZ6+7N0dxLmdRANq+qE4iUZ2aNrf6vuLYg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb332()
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, kunit-dev@googlegroups.com,
        javierm@redhat.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 9:29 AM Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gm=
ail.com> wrote:
> I just cc'ed kunit-dev@googlegroups.com. For anyone joining the
> conversation, here is the link to the patch and the cover letter with
> some questions:
>
> https://lore.kernel.org/dri-devel/20220530102017.471865-1-jose.exposito89=
@gmail.com/T/

Thanks for the link.
A few initial notes:
a) normally, `select`ing other kconfigs is discouraged. It's not
explicitly called out in
https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html#test-kcon=
fig-entries
but this was the conclusion after  some debate on the mailing lists
earlier.
b) I see `dst` is allocated with kzalloc but not freed. Should we use
`kunit_kzalloc()` instead so it does get automatically freed?

>
> >
> > > ---
> > >  drivers/gpu/drm/Kconfig                  |  12 ++
> > >  drivers/gpu/drm/Makefile                 |   3 +
> > >  drivers/gpu/drm/drm_format_helper_test.c | 166 +++++++++++++++++++++=
++
> > >  3 files changed, 181 insertions(+)
> > >  create mode 100644 drivers/gpu/drm/drm_format_helper_test.c
> > >
> > > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > > index e88c497fa010..d92be6faef15 100644
> > > --- a/drivers/gpu/drm/Kconfig
> > > +++ b/drivers/gpu/drm/Kconfig
> > > @@ -76,6 +76,18 @@ config DRM_KMS_HELPER
> > >     help
> > >       CRTC helpers for KMS drivers.
> > >
> > > +config DRM_FORMAR_HELPER_TEST
> > > +   bool "drm_format_helper tests" if !KUNIT_ALL_TESTS
> > > +   depends on DRM && KUNIT=3Dy
> > > +   select DRM_KMS_HELPER

From above, a)
Specifically here, it'd be encouraged to instead do
  depends on DRM && KUNIT=3Dy && DRM_KMS_HELPER

Ideally, using a .kunitconfig file would make it so having to select
DRM_KMS_HELPER manually isn't that annoying.

> > AFAIK, kunit test cases are supposed to have a .kunitconfig too to
> > enable the kunit tests easily.
> >
> > Maxime
>
> A .kuniconfig example is present in the cover letter. My understanding
> from the docs:
>
> https://docs.kernel.org/dev-tools/kunit/run_wrapper.html#create-a-kunitco=
nfig-file

The bit of the documentation you're looking for is
https://www.kernel.org/doc/html/latest/dev-tools/kunit/running_tips.html#de=
fining-a-set-of-tests
You can create a drivers/gpu/drm/.kunitconfig file and run with
$ ./tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/gpu/drm --arch=
=3Dx86_86

The contents of that file would be just like
  CONFIG_KUNIT=3Dy
  CONFIG_DRM=3Dy
  CONFIG_DRM_KMS_HELPER=3Dy  # if no `select`
  CONFIG_DRM_FORMAR_HELPER_TEST=3Dy

Re "kunit test cases are supposed to have a .kunitconfig too"
As I noted in the docs:
  This is a relatively new feature (5.12+) so we don=E2=80=99t have any
conventions yet about on what files should be checked in versus just
kept around locally. It=E2=80=99s up to you and your maintainer to decide i=
f a
config is useful enough to submit (and therefore have to maintain).

So it's up to whatever people think works best/is worth it.
I think in this case, it makes sense to add the file.

> Is that, like the .config file, the .kunitconfig file is not meant to
> be included in git, but I'm sure someone else will clarify this point.

That bit of the docs needs to be rewritten.
You're recommended to check in a drivers/gpu/drm/.kunitconfig file into git=
.

Context: `kunit.py` used to use the "<root>/.kunitconfig" file.
Anytime you wanted to run more tests, you'd append to that file.
So we agreed that no one should check in that file specifically.

Now kunit.py
* uses "<build-dir>/.kunitconfig", by default: ".kunit/.kunitconfig"
* has the --kunitconfig flag so you can use different files
so it's no longer as relevant.

Hope that helps,
Daniel
