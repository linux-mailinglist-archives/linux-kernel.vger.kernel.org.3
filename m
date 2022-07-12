Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E185714ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiGLInu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGLInq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:43:46 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA4D24BE9;
        Tue, 12 Jul 2022 01:43:44 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id o26so5734655qkl.6;
        Tue, 12 Jul 2022 01:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nIOsMFmyfqmDsFlj2kK4zCMOMz4/ro5ji3cUAa947/A=;
        b=SRvR+9u3aXIvCDfNlkPnceQWo7fFBdEEyxI61KaP20bbV6b8tJUMZstE+86zDdTxUw
         szC9R5cqKYfnsOI4Gi+ANufhl19aVjBECEdzqSA82JIGOq1GQCCkh835uJEsuYlrXScR
         v6OokCKKmgLWfdFidwr/tkhPzRJ4WGVCXGTUYxK5bsH/tkXGtnRgbLBh/w8WyvweF57R
         emspji9BJcVZw0Ot9QcDQL6LBmMnRhcJJFhpXTkr14Vac5ko76xzKXIx9C+DliHXobfM
         ZooEzJfEvOFR9WPmShk5wrA6rNMrI0Jbt/9A4IV/987ia4XhMmRBxGgxPHdHOQOuNqEJ
         jvNA==
X-Gm-Message-State: AJIora9lFShCowVJAogZFyFfbemYFlDY9UwGBELMKjaO7gLSPK3GBTU9
        IJpIqP2wPiSRN6lDW1n00M817LCUYTYQuw==
X-Google-Smtp-Source: AGRyM1usyet0a2SMnzg2Fap1mTVdOBaiWONW7DbLPa8pRwT4dAPjvGkcPc9oKdO9suXHSuMe/Qaxtw==
X-Received: by 2002:a05:620a:44c6:b0:6b5:6b78:cc0a with SMTP id y6-20020a05620a44c600b006b56b78cc0amr12721169qkp.607.1657615423879;
        Tue, 12 Jul 2022 01:43:43 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id m12-20020ac8444c000000b0031ea9aa916bsm6925429qtn.95.2022.07.12.01.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 01:43:36 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id e69so12813851ybh.2;
        Tue, 12 Jul 2022 01:43:29 -0700 (PDT)
X-Received: by 2002:a05:6902:a:b0:65c:b38e:6d9f with SMTP id
 l10-20020a056902000a00b0065cb38e6d9fmr21692729ybh.36.1657615408662; Tue, 12
 Jul 2022 01:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657300532.git.geert@linux-m68k.org> <0744671ac096a12f0d538906bd324efa71b11400.1657300532.git.geert@linux-m68k.org>
 <96a87833-d878-dde9-e335-9ea51a4ba406@mailbox.org> <CAMuHMdUgdbZeoFLFL8+Hm-6fG9cg5Wzq++JED3KR5P9YZtRQ4A@mail.gmail.com>
 <20220712074715.kopstlvz4q6npaye@sirius.home.kraxel.org> <CAMuHMdVrf7fgzumcSnZJ3OMGqA34YExXcF3O15YXYpA1ykgKyQ@mail.gmail.com>
 <20220712083907.3ic7bltstaskz72n@sirius.home.kraxel.org>
In-Reply-To: <20220712083907.3ic7bltstaskz72n@sirius.home.kraxel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Jul 2022 10:43:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVhxE9aayG8qRMwUuBryiR_ng08m63_+GY8htFCSmUiWg@mail.gmail.com>
Message-ID: <CAMuHMdVhxE9aayG8qRMwUuBryiR_ng08m63_+GY8htFCSmUiWg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/fourcc: Add missing big-endian XRGB1555 and
 RGB565 formats
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Gerd,

On Tue, Jul 12, 2022 at 10:39 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Tue, Jul 12, 2022 at 10:01:15AM +0200, Geert Uytterhoeven wrote:
> > > It IMHO is not applicable to any physical hardware.  It's used by
> > > virtio-gpu where the supported format depends on the byte order
> > > (it is argb8888 in native byte order).  Only virtual hardware can
> > > have that kind of behavior.
> > >
> > > And we can probably drop the DRM_FORMAT_HOST_* variants for 1555 and
> > > 565, they are not used anywhere.
> >
> > Atari DRM supports (big-endian) RGB565, so it uses
> > DRM_FORMAT_HOST_RGB565.
>
> Fixed big endian should use 'DRM_FORMAT_RGB565 | DRM_FORMAT_BIG_ENDIAN'.

True.

> As described above DRM_FORMAT_HOST_RGB565 means bigendian on bigendian
> hosts and little endian on little endian hosts.  Which is not correct
> when your hardware does big endian no matter what.

But (a) drm_driver_legacy_fb_format() uses DRM_FORMAT_HOST_RGB565
if quirk_addfb_prefer_host_byte_order is set, and (b)
quirk_addfb_prefer_host_byte_order must be set on big-endian as
per commit eae06120f1974e1a ("drm: refuse ADDFB2 ioctl for broken
bigendian drivers").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
