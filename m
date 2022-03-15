Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122054D95A4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345671AbiCOHxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345691AbiCOHw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:52:59 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A11612AD8;
        Tue, 15 Mar 2022 00:51:47 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id s16so14861955qks.4;
        Tue, 15 Mar 2022 00:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ObFdDEGPbS4cXSj2f1wbzT/S3dzkw4/ydKSbGaEoIE=;
        b=8GEgxFYmREmHsR8mgLYCgNYzrs77sxt/dxq/WI/AuXxnaiO78xdtASCVlpHGtLh8sB
         TyiabwkfYc6IDf59XQI+fXJ++T++TIoh447N1mBaWuYS8KOQs2ZqujUS27XTuIrqeYCx
         QTRay6yJWPtHhfpFOqjSu3hg0JvCFF7UOEniYnPaj7p4sEK8MtpDRqULg1Q4T0Ebwng/
         hiijS+M4UW7aeC733070DWRw/V/lhtSBITpvdrP9V43ldGaPvHy1RMHKgH0ufq81X6XC
         AksCjFVBpZdG0CTMJM8wEiH1HPoJ9bVroPfXaf5veaKSxY9eY+1x8oPF0HqUXLqQsyxA
         +TOQ==
X-Gm-Message-State: AOAM533oE4IhHsjpkHloDHGoWvTTerEq5L7GH9Vmy8bAOKh+CCJQL5yE
        y++ofeDtqvOo/R2n1ng/qqhduekNIxSjZg==
X-Google-Smtp-Source: ABdhPJwvpoOu3hFMtoiGWUV2dAsPfbimi03Fdg56B5kz0SitubIBilyUnVE7TAWk7rqnU3P+g9FzPw==
X-Received: by 2002:a05:620a:382:b0:67b:4a35:9bb1 with SMTP id q2-20020a05620a038200b0067b4a359bb1mr17050372qkm.589.1647330705386;
        Tue, 15 Mar 2022 00:51:45 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id e20-20020ac84e54000000b002e06753cf70sm13205649qtw.6.2022.03.15.00.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 00:51:44 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2e580bb920aso22439707b3.10;
        Tue, 15 Mar 2022 00:51:44 -0700 (PDT)
X-Received: by 2002:a81:6dd1:0:b0:2dc:56d1:1dae with SMTP id
 i200-20020a816dd1000000b002dc56d11daemr22488819ywc.479.1647330704238; Tue, 15
 Mar 2022 00:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1646683502.git.geert@linux-m68k.org> <8d3c0cc370b0214244b01a64c588e5e506531716.1646683502.git.geert@linux-m68k.org>
 <CAMuHMdVq19wpA_7nKKTm-G2EmK3cMxxP6nbR_u=vkazqCZ=KhQ@mail.gmail.com>
 <20220314170539.17400f93@eldfell> <CAMuHMdVj8wxAVbcov1wFsgt_knMkcySBH8nMoKjyr=G+mLQmjQ@mail.gmail.com>
 <1f915fcc-1d95-99d1-c7b7-dc4e3b49e09f@linux-m68k.org> <20220315093250.71352a56@eldfell>
In-Reply-To: <20220315093250.71352a56@eldfell>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Mar 2022 08:51:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVU=JKwEn-=Wf3CYObtaLt2T7NmWrXUwdPHdvNsbgge=g@mail.gmail.com>
Message-ID: <CAMuHMdVU=JKwEn-=Wf3CYObtaLt2T7NmWrXUwdPHdvNsbgge=g@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka,

On Tue, Mar 15, 2022 at 8:33 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> On Tue, 15 Mar 2022 09:15:08 +1100 (AEDT)
> Finn Thain <fthain@linux-m68k.org> wrote:
> > On Mon, 14 Mar 2022, Geert Uytterhoeven wrote:
> > > On Mon, Mar 14, 2022 at 4:05 PM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> > > > On Mon, 14 Mar 2022 14:30:18 +0100
> > > > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Mon, Mar 7, 2022 at 9:53 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > Introduce fourcc codes for color-indexed frame buffer formats with
> > > > > > two, four, and sixteen colors, and provide a mapping from bit per
> > > > > > pixel and depth to fourcc codes.
> > > > > >
> > > > > > As the number of bits per pixel is less than eight, these rely on
> > > > > > proper block handling for the calculation of bits per pixel and
> > > > > > pitch.
> > > > > >
> > > > > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > >
> > > > > > --- a/include/uapi/drm/drm_fourcc.h
> > > > > > +++ b/include/uapi/drm/drm_fourcc.h
> > > > > > @@ -99,7 +99,10 @@ extern "C" {
> > > > > >  #define DRM_FORMAT_INVALID     0
> > > > > >
> > > > > >  /* color index */
> > > > > > -#define DRM_FORMAT_C8          fourcc_code('C', '8', ' ', ' ') /* [7:0] C */
> > > > > > +#define DRM_FORMAT_C1          fourcc_code('C', '1', ' ', ' ') /* [7:0] C0:C1:C2:C3:C4:C5:C6:C7 1:1:1:1:1:1:1:1 eight pixels/byte */
> > > > > > +#define DRM_FORMAT_C2          fourcc_code('C', '2', ' ', ' ') /* [7:0] C0:C1:C2:C3 2:2:2:2 four pixels/byte */
> > > > > > +#define DRM_FORMAT_C4          fourcc_code('C', '4', ' ', ' ') /* [7:0] C0:C1 4:4 two pixels/byte */
> > > > > > +#define DRM_FORMAT_C8          fourcc_code('C', '8', ' ', ' ') /* [7:0] C 8 one pixel/byte */
> > > > > >
> > > > > >  /* 8 bpp Red */
> > > > > >  #define DRM_FORMAT_R8          fourcc_code('R', '8', ' ', ' ') /* [7:0] R */
> > > > >
> > > > > After replying to Ilia's comment[1], I realized the CFB drawing
> > > > > operations use native byte and bit ordering, unless
> > > > > FBINFO_FOREIGN_ENDIAN is set.
> > > > > While Amiga, Atari, and Sun-3 use big-endian bit ordering,
> > > > > e.g. Acorn VIDC[2] uses little endian, and SH7760[3] is configurable
> > > > > (sh7760fb configures ordering to match host order).
> > > > > BTW, ssd130{7fb,x}_update_rect() both assume little-endian, so I
> > > > > guess they are broken on big-endian.
> > > > > Fbtest uses big-endian bit ordering, so < 8 bpp is probably broken
> > > > > on little-endian.
> > > > >
> > > > > Hence the above should become:
> > > > >
> > > > >     #define DRM_FORMAT_C1          fourcc_code('C', '1', ' ', ' ') /*
> > > > > [7:0] C7:C6:C5:C4:C3:C2:C1:C0 1:1:1:1:1:1:1:1 eight pixels/byte */
> > > > >     #define DRM_FORMAT_C2          fourcc_code('C', '2', ' ', ' ') /*
> > > > > [7:0] C3:C2:C1:C0 2:2:2:2 four pixels/byte */
> > > > >     #define DRM_FORMAT_C4          fourcc_code('C', '4', ' ', ' ') /*
> > > > > [7:0] C1:C0 4:4 two pixels/byte */
> > > > >
> > > > > The same changes should be made for DRM_FORMAT_[RD][124].
> > > > >
> > > > > The fbdev emulation code should gain support for these with and without
> > > > > DRM_FORMAT_BIG_ENDIAN, the latter perhaps only on big-endian platforms?
> > > > >
> > > > > [1] https://lore.kernel.org/r/CAKb7UvgEdm9U=+RyRwL0TGRfA_Qc7NbhCWoZOft2DKdXggtKYw@mail.gmail.com/
> > > > > [2] See p.30 of the VIDC datasheet
> > > > >     http://chrisacorns.computinghistory.org.uk/docs/Acorn/Misc/Acorn_VIDC_Datasheet.pdf
> > > > > [3] See p.1178 of the SH7660 datasheet
> > > > >     https://datasheet.octopart.com/HD6417760BL200AV-Renesas-datasheet-14105759.pdf
> > > >
> > > > why would CPU endianess affect the order of bits in a byte?
> > >
> > > It doesn't, but see below.
> > >
> > > > Do you mean that bit 0 one machine is (1 << 0), and on another machine
> > > > bit 0 is (1 << 7)?
> > >
> > > No, I mean that in case of multiple pixels per byte, the display
> > > hardware pumps out pixels to the CRTC starting from either the MSB
> > > or the LSB of the first display byte.  Which order depends on the
> > > display hardware, not on the CPU.
> > >
> > > > In C, we have only one way to address bits of a byte and that is with
> > > > arithmetic. You cannot take the address of a bit any other way, can you?
> > > >
> > > > Can we standardise on "bit n of a byte is addressed as (1 << n)"?
> > >
> > > BIT(n) in Linux works the same for little- and big-endian CPUs.
> > > But display hardware may use a different bit order.
> >
> > Perhaps some of this confusion could be avoided if you describe the
> > problem in terms of the sequence of scan-out of pixels, rather than in
> > terms of the serialization of bits. The significance of bits within each
> > pixel and the ordering of pixels within each memory word are independent,
> > right?
>
> Yes, that might help.

Display:

     P0  P1  P2  P3  P4  P5  P6  P7  P8  P9 P10 P11 P12 P13 P14 P15

    P15 P14 P13 P12 P11 P10  P9  P8  P7  P6  P5  P4  P3  P2  P1  P0

Memory:

  1 bpp (MSB first):

              bit7 bit6 bit5 bit4 bit3 bit2 bit1 bit0
              ---- ---- ---- ---- ---- ---- ---- ----
      byte 0:   P0   P1   P2   P3   P4   P5   P6   P7
      byte 1:   P8   P9  P10  P11  P12  P13  P14  P15

  1 bpp (LSB first):

              bit7 bit6 bit5 bit4 bit3 bit2 bit1 bit0
              ---- ---- ---- ---- ---- ---- ---- ----
      byte 0:   P7   P6   P5   P4   P3   P2   P1   P0
      byte 1:  P15  P14  P13  P12  P11  P10   P9   P8

  2 bpp (MSB first):

              bits7-6 bits5-4 bits3-2 bits1-0
              ------- ------- ------- -------
      byte 0:    P0      P1      P2      P3
      byte 1:    P4      P5      P6      P7
      byte 2:    P8      P9     P10     P11
      byte 3:   P12     P13     P14     P15

  2 bpp (LSB first):

              bits7-6 bits5-4 bits3-2 bits1-0
              ------- ------- ------- -------
      byte 0:    P3      P2      P1      P0
      byte 1:    P7      P6      P5      P4
      byte 2:   P11     P10      P9      P8
      byte 3:   P15     P14     P13     P12

  4 bpp (MSB first):

              bits7-4 bits3-0
              ------- -------
      byte 0:    P0      P1
      byte 1:    P2      P3
      byte 2:    P4      P5
      byte 3:    P6      P7
      byte 4:    P8      P9
      byte 5:   P10     P11
      byte 6:   P12     P13
      byte 7:   P14     P15

  4 bpp (LSB first):

              bits7-4 bits3-0
              ------- -------
      byte 0:    P1      P0
      byte 1:    P3      P2
      byte 2:    P5      P4
      byte 3:    P7      P6
      byte 4:    P9      P8
      byte 5:   P11     P10
      byte 6:   P13     P12
      byte 7:   P15     P14

> Also, when drm_fourcc.h is describing pixel formats, it needs to
> consider only how a little-endian CPU accesses them. That's how pixel
> data in memory is described. Display hardware plays no part in that.
> It is the driver's job to expose the pixel formats that match display
> hardware behaviour.

But if the "CPU format" does not match the "display support",
all pixel data must be converted?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
