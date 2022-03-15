Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCB34D9558
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345473AbiCOHea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345499AbiCOHeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:34:25 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE584E68;
        Tue, 15 Mar 2022 00:33:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w7so31418480lfd.6;
        Tue, 15 Mar 2022 00:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=wUvXJkVzRf7uiYTXXhHFwsbeVUmmFqsvpsimZzyPA9g=;
        b=SSigJxLDv4rhWnbg41qyLZn9tsjJ/AVEbALDktvR/rDDWAv1vtsr5no7rWcdaZczyt
         /FSc9PerajzZxVHIOJRKvmpoNYXz/hlRAbpJ4mCgoxreXVIDXnXbWpUAk4KEtwLndtYA
         zPAk4N9TU9j1/0PvD/yS4hYXNNkVRNb9upL4lXoK08gcXpC1ItfSenBaQKbzemhGJSbI
         gtNlnUsR0ydB3q9bVCG2ADyjj6Fb2BZaF2pdERzclY6BFyu+KOo97rWBnCya98j3d4w7
         fe1P3Hf25I8J6lviGRukOVtv8sTxza4w3N7QoFggflEitnjVbOu3YUNmFxZhvp7LwJWm
         V9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=wUvXJkVzRf7uiYTXXhHFwsbeVUmmFqsvpsimZzyPA9g=;
        b=Pr1t1h2pG1KnOdXCKObchhiAnSExQOIRGYGQctuUAjgIlp56QenmCPTv909V6l1WYe
         uA8AV0ZR+SE/wKnRsVDe7/bA7/R5uzBP2K81gpTYXeuIHWUebsZcTNtLArLtIw+VnNwc
         4BBwJoGt2AKhHiDjccXxkHiBgra+hCMsvcExfsPqqbfeohRRLTEYZCDj2OOKlIQVO3Hw
         uwaVNKhr0eeBSus6uwaykV3NH36LtgyvtUbpoX+Co6bfL8Kw+nzcRPlHNrWvUxbWzmRU
         NA8c2fquLxWclttOzf621ud0HTuPucWFWKMHWIhX5bDzRjYOfb7mKS8Hcqy3Zwroo06c
         ke+Q==
X-Gm-Message-State: AOAM531dfUwc0TBf9Ls6jujINQiNqGF9mhlfIor4VbnJPr9CGH/JCdM9
        4F4JWGzCN9uwdVekkZmPoao=
X-Google-Smtp-Source: ABdhPJybvUA4sYux81g0rksKI0ZITXHxk0DnVHZuDaIQe/kSBcvm8BkyEnmjPI3SoGwyAiIclLV0wA==
X-Received: by 2002:a05:6512:b25:b0:448:98bb:efae with SMTP id w37-20020a0565120b2500b0044898bbefaemr4262623lfu.151.1647329581185;
        Tue, 15 Mar 2022 00:33:01 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id o4-20020a2eb444000000b00247f29888fcsm4281640ljm.124.2022.03.15.00.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 00:33:00 -0700 (PDT)
Date:   Tue, 15 Mar 2022 09:32:50 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/10] drm/fourcc: Add DRM_FORMAT_C[124]
Message-ID: <20220315093250.71352a56@eldfell>
In-Reply-To: <1f915fcc-1d95-99d1-c7b7-dc4e3b49e09f@linux-m68k.org>
References: <cover.1646683502.git.geert@linux-m68k.org>
        <8d3c0cc370b0214244b01a64c588e5e506531716.1646683502.git.geert@linux-m68k.org>
        <CAMuHMdVq19wpA_7nKKTm-G2EmK3cMxxP6nbR_u=vkazqCZ=KhQ@mail.gmail.com>
        <20220314170539.17400f93@eldfell>
        <CAMuHMdVj8wxAVbcov1wFsgt_knMkcySBH8nMoKjyr=G+mLQmjQ@mail.gmail.com>
        <1f915fcc-1d95-99d1-c7b7-dc4e3b49e09f@linux-m68k.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/98Z3rW3o3S.LMmex9/1NFgW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/98Z3rW3o3S.LMmex9/1NFgW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Mar 2022 09:15:08 +1100 (AEDT)
Finn Thain <fthain@linux-m68k.org> wrote:

> Hi Geert,
>=20
> On Mon, 14 Mar 2022, Geert Uytterhoeven wrote:
>=20
> > On Mon, Mar 14, 2022 at 4:05 PM Pekka Paalanen <ppaalanen@gmail.com> wr=
ote: =20
> > > On Mon, 14 Mar 2022 14:30:18 +0100
> > > Geert Uytterhoeven <geert@linux-m68k.org> wrote: =20
> > > > On Mon, Mar 7, 2022 at 9:53 PM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote: =20
> > > > > Introduce fourcc codes for color-indexed frame buffer formats wit=
h=20
> > > > > two, four, and sixteen colors, and provide a mapping from bit per=
=20
> > > > > pixel and depth to fourcc codes.
> > > > >
> > > > > As the number of bits per pixel is less than eight, these rely on=
=20
> > > > > proper block handling for the calculation of bits per pixel and=20
> > > > > pitch.
> > > > >
> > > > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org> =20
> > > > =20
> > > > > --- a/include/uapi/drm/drm_fourcc.h
> > > > > +++ b/include/uapi/drm/drm_fourcc.h
> > > > > @@ -99,7 +99,10 @@ extern "C" {
> > > > >  #define DRM_FORMAT_INVALID     0
> > > > >
> > > > >  /* color index */
> > > > > -#define DRM_FORMAT_C8          fourcc_code('C', '8', ' ', ' ') /=
* [7:0] C */
> > > > > +#define DRM_FORMAT_C1          fourcc_code('C', '1', ' ', ' ') /=
* [7:0] C0:C1:C2:C3:C4:C5:C6:C7 1:1:1:1:1:1:1:1 eight pixels/byte */
> > > > > +#define DRM_FORMAT_C2          fourcc_code('C', '2', ' ', ' ') /=
* [7:0] C0:C1:C2:C3 2:2:2:2 four pixels/byte */
> > > > > +#define DRM_FORMAT_C4          fourcc_code('C', '4', ' ', ' ') /=
* [7:0] C0:C1 4:4 two pixels/byte */
> > > > > +#define DRM_FORMAT_C8          fourcc_code('C', '8', ' ', ' ') /=
* [7:0] C 8 one pixel/byte */
> > > > >
> > > > >  /* 8 bpp Red */
> > > > >  #define DRM_FORMAT_R8          fourcc_code('R', '8', ' ', ' ') /=
* [7:0] R */ =20
> > > >
> > > > After replying to Ilia's comment[1], I realized the CFB drawing
> > > > operations use native byte and bit ordering, unless
> > > > FBINFO_FOREIGN_ENDIAN is set.
> > > > While Amiga, Atari, and Sun-3 use big-endian bit ordering,
> > > > e.g. Acorn VIDC[2] uses little endian, and SH7760[3] is configurable
> > > > (sh7760fb configures ordering to match host order).
> > > > BTW, ssd130{7fb,x}_update_rect() both assume little-endian, so I
> > > > guess they are broken on big-endian.
> > > > Fbtest uses big-endian bit ordering, so < 8 bpp is probably broken
> > > > on little-endian.
> > > >
> > > > Hence the above should become:
> > > >
> > > >     #define DRM_FORMAT_C1          fourcc_code('C', '1', ' ', ' ') =
/*
> > > > [7:0] C7:C6:C5:C4:C3:C2:C1:C0 1:1:1:1:1:1:1:1 eight pixels/byte */
> > > >     #define DRM_FORMAT_C2          fourcc_code('C', '2', ' ', ' ') =
/*
> > > > [7:0] C3:C2:C1:C0 2:2:2:2 four pixels/byte */
> > > >     #define DRM_FORMAT_C4          fourcc_code('C', '4', ' ', ' ') =
/*
> > > > [7:0] C1:C0 4:4 two pixels/byte */
> > > >
> > > > The same changes should be made for DRM_FORMAT_[RD][124].
> > > >
> > > > The fbdev emulation code should gain support for these with and wit=
hout
> > > > DRM_FORMAT_BIG_ENDIAN, the latter perhaps only on big-endian platfo=
rms?
> > > >
> > > > [1] https://lore.kernel.org/r/CAKb7UvgEdm9U=3D+RyRwL0TGRfA_Qc7NbhCW=
oZOft2DKdXggtKYw@mail.gmail.com/
> > > > [2] See p.30 of the VIDC datasheet
> > > >     http://chrisacorns.computinghistory.org.uk/docs/Acorn/Misc/Acor=
n_VIDC_Datasheet.pdf
> > > > [3] See p.1178 of the SH7660 datasheet
> > > >     https://datasheet.octopart.com/HD6417760BL200AV-Renesas-datashe=
et-14105759.pdf =20
> > >
> > > why would CPU endianess affect the order of bits in a byte? =20
> >=20
> > It doesn't, but see below.
> >  =20
> > > Do you mean that bit 0 one machine is (1 << 0), and on another machine
> > > bit 0 is (1 << 7)? =20
> >=20
> > No, I mean that in case of multiple pixels per byte, the display
> > hardware pumps out pixels to the CRTC starting from either the MSB
> > or the LSB of the first display byte.  Which order depends on the
> > display hardware, not on the CPU.
> >  =20
> > > In C, we have only one way to address bits of a byte and that is with
> > > arithmetic. You cannot take the address of a bit any other way, can y=
ou?
> > >
> > > Can we standardise on "bit n of a byte is addressed as (1 << n)"? =20
> >=20
> > BIT(n) in Linux works the same for little- and big-endian CPUs.
> > But display hardware may use a different bit order.
> >  =20
>=20
> Perhaps some of this confusion could be avoided if you describe the=20
> problem in terms of the sequence of scan-out of pixels, rather than in=20
> terms of the serialization of bits. The significance of bits within each=
=20
> pixel and the ordering of pixels within each memory word are independent,=
=20
> right?

Yes, that might help.

Also, when drm_fourcc.h is describing pixel formats, it needs to
consider only how a little-endian CPU accesses them. That's how pixel
data in memory is described. Display hardware plays no part in that.
It is the driver's job to expose the pixel formats that match display
hardware behaviour.


Thanks,
pq

--Sig_/98Z3rW3o3S.LMmex9/1NFgW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmIwQSIACgkQI1/ltBGq
qqdWYxAArFJHkgpQMmmEJF2XjJ7YkFz1RwOBneGVxoSiwu34NGvFYNI9RQrxIRMZ
6Veq3hEcMsi3IpHXBDklk6UeL/AuVkVK6mngFDczy4amGO4fonk3x6OsnJn2Hb3D
bW/We2Ua68RsJu7FGVjO4XW07h5gNKUsdDlK6Mp2ENoo5K3eabxaD9ZkOoPmeerh
JQ28LWf+xtk54sOR8uukwnJvogoEzo/0h1+9birqPnKBJlEW22CYzJrRSiaEhLfn
PE0ql688tq/KgH0Rhi769hauO/fmrj6oRAqQbwljfZvtKWx9L53T6OW7MvpK6AXw
FYsvXksK3IpOrhxm7ahZsW9Iis7GwNeU/NmKLb47SnKKIluMQTBFFkcvMX1mSjRC
nCq82HG1e0E/yOQZYs+Ug7JRIKveCgJFEhnHIGgSIdQANA+hCLMPZvXgtpinZAlD
t1hDpSfTTO8biGhvB2EhHPDZnqdJ1SmoAvQXb7vJYIgBK/CpKDAAWUAzel7T+mZt
BGJnQQN8eN8B+iKrgWYiQbCGaNODiL1PLXTt7LbqKB/pCXHlLRYpJY3ig1Ks/Xx7
JDx1vdAFXGeSBaerSL/gNx1Ltl2W6/4I8y1BkKMOUCLkhPUBCw8/bXrvFqNkyYKR
MuOOHqniK8XN77rE4x92pYoVTaR0vAKNPuLcJx7GyhY0JCYrlQ4=
=Lr2I
-----END PGP SIGNATURE-----

--Sig_/98Z3rW3o3S.LMmex9/1NFgW--
