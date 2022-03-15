Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BEA4D96E3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346286AbiCOI6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345206AbiCOI6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:58:48 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CF74D9CC;
        Tue, 15 Mar 2022 01:57:36 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id i8so3370328qtx.6;
        Tue, 15 Mar 2022 01:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KjOC8Zibv/SRA6kDsfG5ElzdjTjKZX71C0L03h7ZueQ=;
        b=YKi3Rq97mFx2y2pS6hjHrRjqR56lYLbclrBRBPlg4eqTq2OcR1kGWHHSzJD846XtvA
         swz3l+9R2dULXhhMJ4yg2NcyDYNxtWXbXLvDs2TLiXDx1cz+lIjlNg0kkwul/7uzSEuE
         8PiF+jTg890y7O7R6yAe+l3+pwzKfd5OSEejV/3vKjqARA0eEmaFno+PMZFU2Wb2KmZy
         j8sdIZ7Qatc/kFhnsgkVbW7nis2JR/mcsjzvGiH0QODqZtts+oHvn3lLwooaY4SIlg3t
         Xc8PjQi1GG8UzBuPGPjfQ9pATfKNUO0Qne4y2A3V5wYxtgXsVCPNMZybdmZmBSh+Dv7r
         H6UA==
X-Gm-Message-State: AOAM530NE2MhzAS7Y6l9WkpK1R6qPjgxOtnGedW5p3CLi+SQINcV0g3U
        P7rxkR0e/7vgex0zR0pEZmujBKqFfiaQ4g==
X-Google-Smtp-Source: ABdhPJxrm2isq4Y5Cl9Gm3wyy6l4LhC6+A+5JSxql02QHsRzcu+N/hqjiFKUH/Il1e9UhhRgblcIKw==
X-Received: by 2002:ac8:7e85:0:b0:2e1:ce0f:4624 with SMTP id w5-20020ac87e85000000b002e1ce0f4624mr8677684qtj.277.1647334655386;
        Tue, 15 Mar 2022 01:57:35 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id c27-20020a05620a165b00b0067d32238bc8sm8928767qko.125.2022.03.15.01.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 01:57:35 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2e580bb920aso23957857b3.10;
        Tue, 15 Mar 2022 01:57:34 -0700 (PDT)
X-Received: by 2002:a81:c703:0:b0:2d0:cc6b:3092 with SMTP id
 m3-20020a81c703000000b002d0cc6b3092mr22671079ywi.449.1647334654603; Tue, 15
 Mar 2022 01:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1646683502.git.geert@linux-m68k.org> <8d3c0cc370b0214244b01a64c588e5e506531716.1646683502.git.geert@linux-m68k.org>
 <CAMuHMdVq19wpA_7nKKTm-G2EmK3cMxxP6nbR_u=vkazqCZ=KhQ@mail.gmail.com>
 <20220314170539.17400f93@eldfell> <CAMuHMdVj8wxAVbcov1wFsgt_knMkcySBH8nMoKjyr=G+mLQmjQ@mail.gmail.com>
 <1f915fcc-1d95-99d1-c7b7-dc4e3b49e09f@linux-m68k.org> <20220315093250.71352a56@eldfell>
 <CAMuHMdVU=JKwEn-=Wf3CYObtaLt2T7NmWrXUwdPHdvNsbgge=g@mail.gmail.com> <20220315104554.1961d62d@eldfell>
In-Reply-To: <20220315104554.1961d62d@eldfell>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Mar 2022 09:57:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUK2T4HzN6+ShVgbBUjh6S6oTFD_G79k-QMUwo32COJjQ@mail.gmail.com>
Message-ID: <CAMuHMdUK2T4HzN6+ShVgbBUjh6S6oTFD_G79k-QMUwo32COJjQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] drm/fourcc: Add DRM_FORMAT_C[124]
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Finn Thain <fthain@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
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

Hi Pekka,

On Tue, Mar 15, 2022 at 9:46 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> On Tue, 15 Mar 2022 08:51:31 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Mar 15, 2022 at 8:33 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> > > On Tue, 15 Mar 2022 09:15:08 +1100 (AEDT)
> > > Finn Thain <fthain@linux-m68k.org> wrote:
> > > > On Mon, 14 Mar 2022, Geert Uytterhoeven wrote:
> > > > > On Mon, Mar 14, 2022 at 4:05 PM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> > > > > > On Mon, 14 Mar 2022 14:30:18 +0100
> > > > > > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > On Mon, Mar 7, 2022 at 9:53 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > > Introduce fourcc codes for color-indexed frame buffer formats with
> > > > > > > > two, four, and sixteen colors, and provide a mapping from bit per
> > > > > > > > pixel and depth to fourcc codes.
> > > > > > > >
> > > > > > > > As the number of bits per pixel is less than eight, these rely on
> > > > > > > > proper block handling for the calculation of bits per pixel and
> > > > > > > > pitch.
> > > > > > > >
> > > > > > > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > >
> > > > > > > > --- a/include/uapi/drm/drm_fourcc.h
> > > > > > > > +++ b/include/uapi/drm/drm_fourcc.h
> > > > > > > > @@ -99,7 +99,10 @@ extern "C" {
> > > > > > > >  #define DRM_FORMAT_INVALID     0
> > > > > > > >
> > > > > > > >  /* color index */
> > > > > > > > -#define DRM_FORMAT_C8          fourcc_code('C', '8', ' ', ' ') /* [7:0] C */
> > > > > > > > +#define DRM_FORMAT_C1          fourcc_code('C', '1', ' ', ' ') /* [7:0] C0:C1:C2:C3:C4:C5:C6:C7 1:1:1:1:1:1:1:1 eight pixels/byte */
> > > > > > > > +#define DRM_FORMAT_C2          fourcc_code('C', '2', ' ', ' ') /* [7:0] C0:C1:C2:C3 2:2:2:2 four pixels/byte */
> > > > > > > > +#define DRM_FORMAT_C4          fourcc_code('C', '4', ' ', ' ') /* [7:0] C0:C1 4:4 two pixels/byte */
> > > > > > > > +#define DRM_FORMAT_C8          fourcc_code('C', '8', ' ', ' ') /* [7:0] C 8 one pixel/byte */
> > > > > > > >
> > > > > > > >  /* 8 bpp Red */
> > > > > > > >  #define DRM_FORMAT_R8          fourcc_code('R', '8', ' ', ' ') /* [7:0] R */
> > > > > > >
> > > > > > > After replying to Ilia's comment[1], I realized the CFB drawing
> > > > > > > operations use native byte and bit ordering, unless
> > > > > > > FBINFO_FOREIGN_ENDIAN is set.
> > > > > > > While Amiga, Atari, and Sun-3 use big-endian bit ordering,
> > > > > > > e.g. Acorn VIDC[2] uses little endian, and SH7760[3] is configurable
> > > > > > > (sh7760fb configures ordering to match host order).
> > > > > > > BTW, ssd130{7fb,x}_update_rect() both assume little-endian, so I
> > > > > > > guess they are broken on big-endian.
> > > > > > > Fbtest uses big-endian bit ordering, so < 8 bpp is probably broken
> > > > > > > on little-endian.
> > > > > > >
> > > > > > > Hence the above should become:
> > > > > > >
> > > > > > >     #define DRM_FORMAT_C1          fourcc_code('C', '1', ' ', ' ') /*
> > > > > > > [7:0] C7:C6:C5:C4:C3:C2:C1:C0 1:1:1:1:1:1:1:1 eight pixels/byte */
> > > > > > >     #define DRM_FORMAT_C2          fourcc_code('C', '2', ' ', ' ') /*
> > > > > > > [7:0] C3:C2:C1:C0 2:2:2:2 four pixels/byte */
> > > > > > >     #define DRM_FORMAT_C4          fourcc_code('C', '4', ' ', ' ') /*
> > > > > > > [7:0] C1:C0 4:4 two pixels/byte */
> > > > > > >
> > > > > > > The same changes should be made for DRM_FORMAT_[RD][124].
> > > > > > >
> > > > > > > The fbdev emulation code should gain support for these with and without
> > > > > > > DRM_FORMAT_BIG_ENDIAN, the latter perhaps only on big-endian platforms?
> > > > > > >
> > > > > > > [1] https://lore.kernel.org/r/CAKb7UvgEdm9U=+RyRwL0TGRfA_Qc7NbhCWoZOft2DKdXggtKYw@mail.gmail.com/
> > > > > > > [2] See p.30 of the VIDC datasheet
> > > > > > >     http://chrisacorns.computinghistory.org.uk/docs/Acorn/Misc/Acorn_VIDC_Datasheet.pdf
> > > > > > > [3] See p.1178 of the SH7660 datasheet
> > > > > > >     https://datasheet.octopart.com/HD6417760BL200AV-Renesas-datasheet-14105759.pdf
> > > > > >
> > > > > > why would CPU endianess affect the order of bits in a byte?
> > > > >
> > > > > It doesn't, but see below.
> > > > >
> > > > > > Do you mean that bit 0 one machine is (1 << 0), and on another machine
> > > > > > bit 0 is (1 << 7)?
> > > > >
> > > > > No, I mean that in case of multiple pixels per byte, the display
> > > > > hardware pumps out pixels to the CRTC starting from either the MSB
> > > > > or the LSB of the first display byte.  Which order depends on the
> > > > > display hardware, not on the CPU.
> > > > >
> > > > > > In C, we have only one way to address bits of a byte and that is with
> > > > > > arithmetic. You cannot take the address of a bit any other way, can you?
> > > > > >
> > > > > > Can we standardise on "bit n of a byte is addressed as (1 << n)"?
> > > > >
> > > > > BIT(n) in Linux works the same for little- and big-endian CPUs.
> > > > > But display hardware may use a different bit order.
> > > >
> > > > Perhaps some of this confusion could be avoided if you describe the
> > > > problem in terms of the sequence of scan-out of pixels, rather than in
> > > > terms of the serialization of bits. The significance of bits within each
> > > > pixel and the ordering of pixels within each memory word are independent,
> > > > right?
> > >
> > > Yes, that might help.
> >
> > Display:
> >
> >      P0  P1  P2  P3  P4  P5  P6  P7  P8  P9 P10 P11 P12 P13 P14 P15
> >
> >     P15 P14 P13 P12 P11 P10  P9  P8  P7  P6  P5  P4  P3  P2  P1  P0
>
> Hi Geert,
>
> does this mean the display hardware emits even rows from left to right
> and odd rows from right to left?

No, it means I should have my morning coffee first, and remove all
temporary cruft before pressing send :-(

The above paragraph should have read:

    Display (16 pixels):

        P0  P1  P2  P3  P4  P5  P6  P7  P8  P9 P10 P11 P12 P13 P14 P15

> I'm guessing P stands for "pixel".

Exactly.

> > Memory:
> >
> >   1 bpp (MSB first):
> >
> >               bit7 bit6 bit5 bit4 bit3 bit2 bit1 bit0
> >               ---- ---- ---- ---- ---- ---- ---- ----
> >       byte 0:   P0   P1   P2   P3   P4   P5   P6   P7
> >       byte 1:   P8   P9  P10  P11  P12  P13  P14  P15
> >
> >   1 bpp (LSB first):
> >
> >               bit7 bit6 bit5 bit4 bit3 bit2 bit1 bit0
> >               ---- ---- ---- ---- ---- ---- ---- ----
> >       byte 0:   P7   P6   P5   P4   P3   P2   P1   P0
> >       byte 1:  P15  P14  P13  P12  P11  P10   P9   P8
> >
> >   2 bpp (MSB first):
> >
> >               bits7-6 bits5-4 bits3-2 bits1-0
> >               ------- ------- ------- -------
> >       byte 0:    P0      P1      P2      P3
> >       byte 1:    P4      P5      P6      P7
> >       byte 2:    P8      P9     P10     P11
> >       byte 3:   P12     P13     P14     P15
> >
> >   2 bpp (LSB first):
> >
> >               bits7-6 bits5-4 bits3-2 bits1-0
> >               ------- ------- ------- -------
> >       byte 0:    P3      P2      P1      P0
> >       byte 1:    P7      P6      P5      P4
> >       byte 2:   P11     P10      P9      P8
> >       byte 3:   P15     P14     P13     P12
> >
> >   4 bpp (MSB first):
> >
> >               bits7-4 bits3-0
> >               ------- -------
> >       byte 0:    P0      P1
> >       byte 1:    P2      P3
> >       byte 2:    P4      P5
> >       byte 3:    P6      P7
> >       byte 4:    P8      P9
> >       byte 5:   P10     P11
> >       byte 6:   P12     P13
> >       byte 7:   P14     P15
> >
> >   4 bpp (LSB first):
> >
> >               bits7-4 bits3-0
> >               ------- -------
> >       byte 0:    P1      P0
> >       byte 1:    P3      P2
> >       byte 2:    P5      P4
> >       byte 3:    P7      P6
> >       byte 4:    P9      P8
> >       byte 5:   P11     P10
> >       byte 6:   P13     P12
> >       byte 7:   P15     P14
>
> I think I can guess what you meant there, and it looks understandable
> to me. These tables are actually very clear, and leave only one thing
> undefined: when multiple bits form a pixel, in which order do the bits
> form the value. I recall you said fbdev allows for both orderings but
> only one order is ever used if I understood right.

Indeed.  The third ordering is the ordering of the bits in a pixel.
As fb_bitfield.msb_right is always false, no hardware ever supported by
fbdev used the other ordering, so we only have to care about:

   1 bpp: P = [ bitN ]
   2 bpp: P = [ bitN bitN-1 ]
   4 bpp: P = [ bitN bitN-1 bitN-2 bitN-3 ]

> > > Also, when drm_fourcc.h is describing pixel formats, it needs to
> > > consider only how a little-endian CPU accesses them. That's how pixel
> > > data in memory is described. Display hardware plays no part in that.
> > > It is the driver's job to expose the pixel formats that match display
> > > hardware behaviour.
> >
> > But if the "CPU format" does not match the "display support",
> > all pixel data must be converted?
>
> Of course. If the driver author does not want to convert pixel data in
> flight, then the author should not let the driver expose a format that
> needs conversion.

... in which case we need a DRM fourcc code for the format?

BTW, Atari and Amiga use bitplanes for bpp <= 8, so they need
conversion anyway.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
