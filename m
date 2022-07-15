Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4248A576482
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 17:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbiGOPgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 11:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiGOPgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 11:36:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BF855092;
        Fri, 15 Jul 2022 08:36:14 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 285B266015B6;
        Fri, 15 Jul 2022 16:36:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657899372;
        bh=mjl2CHsK8OJyoPzlMniTRyLaHQrcz06eR01e4ukasMA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Yk0A4u7Xj3cGMN8T/r+L7HisSLtpW7ddZ73RI8AXjN0Dnh0J1A2VbzsneevyWcrAR
         rVa5L9lCVmk1N7IM1U6AntDgxFaB6+sRTQWE1hTL6nHmAqhP4dsH9IcvM+xjC9+8iQ
         QkRUFGNJvqMG8gRkwJQD3dfKohS2E0eCObj0t8yNRiEAeIUKdfGrAo+r8Gpsrbljy5
         IaRdmstcB3UR5jS1KYJgDIaPQlFyuqDdVSjYAKHibshlfphso9/68NAZ0rSub/al/H
         eX+QM5X4Opw/Z723mSkReDkMjUk/Es5rH5EkqUcBuXBCtFtE4EizfDkonVydgC8cOm
         rIrpXGCe0T5qA==
Message-ID: <f05896551f8545af3c7352a6bd38248e038b61d2.camel@collabora.com>
Subject: Re: [PATCH 0/6] RkVDEC HEVC driver
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org
Cc:     jernej.skrabec@gmail.com, knaerzche@gmail.com,
        kernel@collabora.com, bob.beckett@collabora.com,
        ezequiel@vanguardiasur.com.ar, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date:   Fri, 15 Jul 2022 11:36:01 -0400
In-Reply-To: <7be996ee-9977-129b-08e2-12bde7ac9cd7@arm.com>
References: <20220713162449.133738-1-sebastian.fricke@collabora.com>
         <7be996ee-9977-129b-08e2-12bde7ac9cd7@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 15 juillet 2022 =C3=A0 12:04 +0100, Robin Murphy a =C3=A9crit=
=C2=A0:
> On 2022-07-13 17:24, Sebastian Fricke wrote:
> > Implement the HEVC codec variation for the RkVDEC driver. Currently onl=
y
> > the RK3399 is supported, but it is possible to enable the RK3288 as it
> > also supports this codec.
> >=20
> > Based on top of the media tree @ef7fcbbb9eabbe86d2287484bf366dd1821cc6b=
8
> > and the HEVC uABI MR by Benjamin Gaignard.
> > (https://patchwork.linuxtv.org/project/linux-media/list/?series=3D8360)
> >=20
> > Tested with the GStreamer V4L2 HEVC plugin:
> > (https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/10=
79)
> >=20
> > Current Fluster score:
> > `Ran 131/147 tests successfully               in 278.568 secs`
> > with
> > `python3 fluster.py run -d GStreamer-H.265-V4L2SL-Gst1.0 -ts JCT-VC-HEV=
C_V1 -j1`
> >=20
> > failed conformance tests:
> > - DBLK_D_VIXS_2 (Success on Hantro G2)
> > - DSLICE_A_HHI_5 (Success on Hantro G2)
> > - EXT_A_ericsson_4 (Success on Hantro G2)
> > - PICSIZE_A_Bossen_1 (Hardware limitation)
> > - PICSIZE_B_Bossen_1 (Hardware limitation)
> > - PICSIZE_C_Bossen_1 (Hardware limitation)
> > - PICSIZE_D_Bossen_1 (Hardware limitation)
> > - PPS_A_qualcomm_7 (Success on Hantro G2)
> > - SAODBLK_A_MainConcept_4 (Success on Hantro G2)
> > - SAODBLK_B_MainConcept_4 (Success on Hantro G2)
> > - SLIST_B_Sony_9 (Success on Hantro G2)
> > - SLIST_D_Sony_9 (Success on Hantro G2)
> > - TSUNEQBD_A_MAIN10_Technicolor_2 (Success on Hantro G2)
> > - VPSSPSPPS_A_MainConcept_1 (Success on Hantro G2)
> > - WPP_D_ericsson_MAIN10_2 (Fail on Hantro G2)
> > - WPP_D_ericsson_MAIN_2 (Fail on Hantro G2)
> >=20
> > Not tested with FFMpeg so far.
> >=20
> > Known issues:
> > - Unable to reliably decode multiple videos concurrently
> > - The SAODBLK_* tests timeout if the timeout time in fluster is lower t=
han 120
> > - Currently the uv_virstride is calculated in a manner that is hardcode=
d
> > for the two available formats NV12 and NV15. (@config_registers)
> >=20
> > Notable design decisions:
> > - I opted for a bitfield to represent the PPS memory blob as it is the
> > perfect tool for that job. It describes the memory layout with any
> > additional required documentation, is easy to read and a native languag=
e
> > tool for that job
>=20
> Can I point out how terrible an idea this is? The C language gives=20
> virtually zero guarantee about how bitfields are actually represented in=
=20
> memory. Platform ABIs (e.g. [1]) might nail things down a bit more, but=
=20
> different platforms are free to make completely different choices so=20
> portability still goes out the window. Even for a single platform,=20
> different compilers (or at worst even different version of one compiler)=
=20
> can still make incompatible choices e.g. WRT alignment of packed=20
> members. Even if you narrow the scope as far as a specific version of=20
> AArch64 GCC, I think this is still totally broken for big-endian.
>=20
> The fact that you've had to use nonsensical types to trick a compiler=20
> into meeting your expectations should already be a clue to how fragile=
=20
> this is in general.
>=20
> > - The RPS memory blob is created using a bitmap implementation, which
> > uses a common Kernel API to avoid reinventing the wheel and to keep the
> > code clean.
>=20
> Similarly, Linux bitmaps are designed for use as, well, bitmaps. Abusing=
=20
> them as a data interchange format for bit-aligned numerical values is=20
> far from "clean" semantically. And I'm pretty sure it's also broken for=
=20
> big-endian.
>=20
> This kind of stuff may be standard practice in embedded development=20
> where you're targeting a specific MCU with a specific toolchain, but I=
=20
> don't believe it's suitable for upstream Linux. It would take pretty=20
> much the same number of lines to use GENMASK definitions and bitfield.h=
=20
> helpers to pack values into words which can then be written to memory in=
=20
> a guaranteed format and endianness (certainly for the PPS; for the RPS=
=20
> it may well end up a bit longer, but would be self-documenting and=20
> certainly more readable than those loops). It mostly just means that for=
=20
> any field which crosses a word boundary you'll end up with 2 definitions=
=20
> and 2 assignments, which is hardly a problem (and in some ways more=20
> honest about what's actually going on).

Thanks for the feedback, in multimedia (unlike register programming), we do=
n't
really consider bitstreams as bitmap or bitfield. What we do really expect =
is to
use bit writer helpers (and sometimes a bit reader though we try and avoid =
the
second one in the  kernel). Its more of less a cursor (a bit position) into=
 a
memory that advance while writing. A bit writer should help protect against
overflow too.

When writing lets say a chain of 8 bits from a char, a proper helper is exp=
ected
to be very explicit on the ordering (write_u8_le/be or something better wor=
ded).
I would rather like to see all these blobs written this way personally then
having a cleared buffer and writing using bit offsets.

Perhaps I may suggest to start with implementing just that inside this driv=
er?
It isn't very hard, and then the implementation can be reduced later and sh=
ared
later, with whatever exists without deviating from the intent of the existi=
ng
API ? I do believe that having this in linux-media can be useful in the fut=
ure.
We will notably need to extend such a helper with multimedia specific codin=
g
technique (golomb, boolean coding, etc.) for use in stateless encoder drive=
rs.

Nicolas

>=20
> Thanks,
> Robin.
>=20
> [1]=20
> https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#bit-=
fields
>=20
> > - I deliberatly opted against the macro solution used in H264, which
> > declares Macros in mid function and declares the fields of the memory
> > blob as macros as well. And I would be glad to refactor the H264 code i=
f
> > desired by the maintainer to use common Kernel APIs and native language
> > elements.
> > - The giant static array of cabac values is moved to a separate c file,
> > I did so because a separate .h file would be incorrect as it doesn't
> > expose anything of any value for any other file than the rkvdec-hevc.c
> > file. Other options were:
> >    - Calculating the values instead of storing the results (doesn't see=
m
> >    to be worth it)
> >    - Supply them via firmware (Adding firmware makes the whole software
> >    way more complicated and the usage of the driver less obvious)
> >=20
> > Ignored Checkpatch warnings (as it fits to the current style of the fil=
e):
> > ```
> > WARNING: line length of 162 exceeds 100 columns
> > #115: FILE: drivers/media/v4l2-core/v4l2-common.c:265:
> > +               { .format =3D V4L2_PIX_FMT_NV15,    .pixel_enc =3D V4L2=
_PIXEL_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 5, 5, 0, =
0 }, .hdiv =3D 2, .vdiv =3D 2,
> >=20
> > ERROR: trailing statements should be on next line
> > #128: FILE: drivers/media/v4l2-core/v4l2-ioctl.c:1305:
> > +       case V4L2_PIX_FMT_NV15:         descr =3D "10-bit Y/CbCr 4:2:0 =
(Packed)"; break;
> > ```
> >=20
> > v4l2-compliance test:
> > ```
> > Total for rkvdec device /dev/video3: 46, Succeeded: 46, Failed: 0, Warn=
ings: 0
> > ```
> >=20
> > kselftest module run for the bitmap changes:
> > ```
> > $ sudo insmod /usr/lib/modules/5.19.0-rc3-finalseries/kernel/lib/test_b=
itmap.ko
> > [   71.751716] test_bitmap: parselist: 14: input is '0-2047:128/256' OK=
, Time: 1750
> > [   71.751787] test_bitmap: bitmap_print_to_pagebuf: input is '0-32767
> > [   71.751787] ', Time: 6708
> > [   71.760373] test_bitmap: set_value: 6/6 tests correct
> > ```
> >=20
> > Jonas Karlman (2):
> >    media: v4l2: Add NV15 pixel format
> >    media: v4l2-common: Add helpers to calculate bytesperline and
> >      sizeimage
> >=20
> > Sebastian Fricke (4):
> >    bitops: bitmap helper to set variable length values
> >    staging: media: rkvdec: Add valid pixel format check
> >    staging: media: rkvdec: Enable S_CTRL IOCTL
> >    staging: media: rkvdec: Add HEVC backend
> >=20
> >   .../media/v4l/pixfmt-yuv-planar.rst           |   53 +
> >   drivers/media/v4l2-core/v4l2-common.c         |   79 +-
> >   drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
> >   drivers/staging/media/rkvdec/Makefile         |    2 +-
> >   drivers/staging/media/rkvdec/TODO             |   22 +-
> >   .../staging/media/rkvdec/rkvdec-hevc-data.c   | 1844 ++++++++++++++++=
+
> >   drivers/staging/media/rkvdec/rkvdec-hevc.c    |  859 ++++++++
> >   drivers/staging/media/rkvdec/rkvdec-regs.h    |    1 +
> >   drivers/staging/media/rkvdec/rkvdec.c         |  182 +-
> >   drivers/staging/media/rkvdec/rkvdec.h         |    3 +
> >   include/linux/bitmap.h                        |   39 +
> >   include/uapi/linux/videodev2.h                |    1 +
> >   lib/test_bitmap.c                             |   47 +
> >   13 files changed, 3066 insertions(+), 67 deletions(-)
> >   create mode 100644 drivers/staging/media/rkvdec/rkvdec-hevc-data.c
> >   create mode 100644 drivers/staging/media/rkvdec/rkvdec-hevc.c
> >=20
>=20

