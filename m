Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2EE53BD0A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 19:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbiFBRNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 13:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiFBRNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 13:13:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC3B170F3B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 10:13:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e29so1521756wra.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 10:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9egMonS4xdxOgQS+ajnqcSmFBqc/f2gRBFWF00OFM2A=;
        b=VS+hCyb8GERzrt1YCfMxAWT1BrmEOBGdq/wx9c743zw1S3rBLQmESyUGUFuDCOdOSj
         xbQ6yJ0HGQkXdrXUcxAQu7kN64j8QHzz40+HpIPiO+HXiRWkbyci2VNATlEccSQL4iNs
         psDfdXjuDFS0rda3Yxx6uMr9HjD3Ms3BKUSwRVVFvS2jveh1gdfOBtrHIvL2ibA9CoGx
         IJgSqtcpKrARebanmkwEQOb0ItKkAfxRtA7VgeCGw94p3xuBvICJU9NqigNA+LdXqPJe
         yg3Ufk/MjDnALdn2iugRTXtDVrSImkiRQOiZhWzSh8PG6UcpyxJUH63dSNKPUDqR1MKD
         aJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9egMonS4xdxOgQS+ajnqcSmFBqc/f2gRBFWF00OFM2A=;
        b=vwz4f2XHTVaIsqML7QPP5i4b7QAYxfzZGjatLo+b3gvbqRienxy0bsB5hrq1+DynsU
         uNEs2VjnhUwB1frSBL8wuaKGdWfBCiDy2qcVgNnQuhnggp/EJKi8VlajCZ5NsLajqo/C
         xdzFG/fmLjf6zSb4fKdTlTgGxza5ytpLf6LNm7Lo+4V2KNMIfIPEUFqmdOTQsVSr1Nte
         dsJxnLdPYqQo6W4mMbUe2bjaROlC8+IQYGOHYWeRjdlx6gF7qUwmBj+l+mPgZkOtJgPS
         KtOlTZfixL4VGLjbX6M5MB6ie7BL+0OyxJ5b6f6GmrXnWSSJAzc5gC0WSsbVdegepfkO
         fZcg==
X-Gm-Message-State: AOAM530PUqoCWJsL/s00ZHLQK97b0UHVzTiBgLKorU04C+2R+ydElCB4
        dx16x1V2R4fyeoWlZdEUllW/S4Up80hhF+VBI+tUVg==
X-Google-Smtp-Source: ABdhPJyL+zyrsEy15NdGDty2PYwxMW5pJ1fKsxgJdy/31Gjp6X8ESejObvQ7wTcQDse03Voa21IcVYg7Dv+DFKdgyCM=
X-Received: by 2002:a5d:5342:0:b0:210:c508:956d with SMTP id
 t2-20020a5d5342000000b00210c508956dmr4584749wrv.205.1654189990220; Thu, 02
 Jun 2022 10:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220530102017.471865-1-jose.exposito89@gmail.com>
 <20220530102017.471865-2-jose.exposito89@gmail.com> <20220530131158.kqq2mohxoh52xpeg@penduick>
 <20220530162903.GA6546@elementary>
In-Reply-To: <20220530162903.GA6546@elementary>
From:   David Gow <davidgow@google.com>
Date:   Thu, 2 Jun 2022 10:12:59 -0700
Message-ID: <CABVgOSn8i=LO5p7830h2XU1Jgg0KrN0qTnxkOMhf1oTgxjaKKw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb332()
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
>
> Hi Maxime,
>
> On Mon, May 30, 2022 at 03:11:58PM +0200, Maxime Ripard wrote:
> >
> > Hi,
> >
> > On Mon, May 30, 2022 at 12:20:17PM +0200, Jos=C3=A9 Exp=C3=B3sito wrote=
:
> > > Test the conversion from XRGB8888 to RGB332.
> > >
> > > What is tested?
> > >
> > >  - Different values for the X in XRGB8888 to make sure it is ignored
> > >  - Different clip values: Single pixel and full and partial buffer
> > >  - Well know colors: White, black, red, green, blue, magenta, yellow
> > >    and cyan
> > >  - Other colors: Randomly picked
> > >  - Destination pitch
> > >
> > > Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
> > > Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> >
> > It looks mostly good to me, but I think we should Cc
> > kunit-dev@googlegroups.com to have their feedback.
>
> Thanks a lot for the quick feedback.
>
> I just cc'ed kunit-dev@googlegroups.com. For anyone joining the
> conversation, here is the link to the patch and the cover letter with
> some questions:
>
> https://lore.kernel.org/dri-devel/20220530102017.471865-1-jose.exposito89=
@gmail.com/T/
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
> > > +   default KUNIT_ALL_TESTS
> > > +   help
> > > +     KUnit tests for the drm_format_helper APIs. This option is not
> > > +     useful for distributions or general kernels, but only for kerne=
l
> > > +     developers working on DRM and associated drivers.
> > > +
> > > +     If in doubt, say "N".
> > > +
> >
> > AFAIK, kunit test cases are supposed to have a .kunitconfig too to
> > enable the kunit tests easily.
> >
> > Maxime
>
> A .kuniconfig example is present in the cover letter. (...)

FYI: it's also possible to run these tests under UML with the extra options=
:
CONFIG_VIRTIO_UML=3Dy
CONFIG_UML_PCI_OVER_VIRTIO=3Dy

I suspect it's probably better not to add those to your .kunitconfig,
as they're UML-specific and will therefore break other architectures,
but it does mean the tests can be run with, for example:

./tools/testing/kunit/kunit.py run --kunitconfig
drivers/gpu/drm/.kunitconfig --kconfig_add CONFIG_VIRTIO_UML=3Dy
--kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=3Dy

Or, without the .kunitconfig:
./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_DRM=3Dy
--kconfig_add CONFIG_DRM_FORMAR_HELPER_TEST=3Dy --kconfig_add
CONFIG_VIRTIO_UML=3Dy  --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=3Dy
'drm-*'

Cheers,
-- David
