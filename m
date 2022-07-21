Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211E057D159
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbiGUQT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbiGUQTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:19:14 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9BD691E8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:18:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m13so2781647edc.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y7Sgywf3E5lnHflxXetoxFDIr/4IQhhtYrLjSpg3prA=;
        b=zrvA2ZDk5alHLAzK3+XsnSX1ypJ7izkkIYVWjsxKjnKJtJsYJa7B3yNL8qPXrScfdj
         hD7nuPlkWAuObYnHBieSn81xjt/FStU3maDbsst4tD8/EdgkpH3MFFZAILn5jpLfDYln
         Yu5ubkVe555N8z+bf+nUd/Ll2l7aoADPK1AC5TWo0z4lYtymkuqerUm6ZNckLXODZqdd
         2epvm8TS60m3LE7NYaWnBXrSwPWAbo4SgmB2bZzIhd06xVRKTZZIdJWFf1EG3r1XQe+C
         012+UvnPxzTAkvJggqky1dAYyL2U/gFymhuehRupChupQz1/0WckVwc73Nmc3RjAltR+
         8BuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y7Sgywf3E5lnHflxXetoxFDIr/4IQhhtYrLjSpg3prA=;
        b=K2NveLUpU+rKYHpuF17qU5DlrOoBwItqatAbEpzYPDxR+Q62BQQoxo/P+NzV60BVl0
         vxWZVYrSctIJTgBo+96++YjKi6i8xTUS0YCF+7o5AGSKUXv330jJoQzk2UBW89mC0Rbt
         KB1RWs1ygbsb15xJm9mx0VluNO5ZErCx/LaLCpiqg/0EQd5eyYpp5/6bW+3gQ3sYNe0p
         m28Axe2eKCD+gsmunXTCSO7qYbjnAfdd0Kkj10G8vAqieXqfOdWn+BZz5NR0INR7xmZu
         Ta3wcBJQ5wAjGxUXw6WfGa4s3TDsNkmMwG7YqTryf3YMGsa0cA6x6s1Y82Xob081WLxD
         YR8g==
X-Gm-Message-State: AJIora+OMrr6fZyk4VaK8RPIb15pjiUHADlq4TtWNFPfdouf6AJjvECt
        G2uQcspvI6EsZRlDT+7vObhNJYdTGj24eluyyLunOA==
X-Google-Smtp-Source: AGRyM1s1NYSSPKZaycGflP/aF1QNGYR/Y9xz3FhNnWzw98xiIKwh3mRVWCLFiLeh/KNHrKgM56Ch6e+wV8LWRQsp7Hc=
X-Received: by 2002:a05:6402:4381:b0:43b:cb55:ae3c with SMTP id
 o1-20020a056402438100b0043bcb55ae3cmr519701edc.45.1658420310851; Thu, 21 Jul
 2022 09:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220713162449.133738-1-sebastian.fricke@collabora.com>
 <7be996ee-9977-129b-08e2-12bde7ac9cd7@arm.com> <f05896551f8545af3c7352a6bd38248e038b61d2.camel@collabora.com>
 <20220721161609.zyhhg3smbusl6koz@basti-XPS-13-9310>
In-Reply-To: <20220721161609.zyhhg3smbusl6koz@basti-XPS-13-9310>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Thu, 21 Jul 2022 13:18:19 -0300
Message-ID: <CAAEAJfB1JCrVTVBMs_kFnuM1NrUi=j5+N9WAi6N5PUH5L6tHfw@mail.gmail.com>
Subject: Re: [PATCH 0/6] RkVDEC HEVC driver
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-media <linux-media@vger.kernel.org>,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Alex Bee <knaerzche@gmail.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 1:16 PM Sebastian Fricke
<sebastian.fricke@collabora.com> wrote:
>
> Hey Nicolas & Robin,
>
> Thanks for the feedback.
>
> On 15.07.2022 11:36, Nicolas Dufresne wrote:
> >Le vendredi 15 juillet 2022 =C3=A0 12:04 +0100, Robin Murphy a =C3=A9cri=
t :
> >> On 2022-07-13 17:24, Sebastian Fricke wrote:
> >> > Implement the HEVC codec variation for the RkVDEC driver. Currently =
only
> >> > the RK3399 is supported, but it is possible to enable the RK3288 as =
it
> >> > also supports this codec.
> >> >
> >> > Based on top of the media tree @ef7fcbbb9eabbe86d2287484bf366dd1821c=
c6b8
> >> > and the HEVC uABI MR by Benjamin Gaignard.
> >> > (https://patchwork.linuxtv.org/project/linux-media/list/?series=3D83=
60)
> >> >
> >> > Tested with the GStreamer V4L2 HEVC plugin:
> >> > (https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests=
/1079)
> >> >
> >> > Current Fluster score:
> >> > `Ran 131/147 tests successfully               in 278.568 secs`
> >> > with
> >> > `python3 fluster.py run -d GStreamer-H.265-V4L2SL-Gst1.0 -ts JCT-VC-=
HEVC_V1 -j1`
> >> >
> >> > failed conformance tests:
> >> > - DBLK_D_VIXS_2 (Success on Hantro G2)
> >> > - DSLICE_A_HHI_5 (Success on Hantro G2)
> >> > - EXT_A_ericsson_4 (Success on Hantro G2)
> >> > - PICSIZE_A_Bossen_1 (Hardware limitation)
> >> > - PICSIZE_B_Bossen_1 (Hardware limitation)
> >> > - PICSIZE_C_Bossen_1 (Hardware limitation)
> >> > - PICSIZE_D_Bossen_1 (Hardware limitation)
> >> > - PPS_A_qualcomm_7 (Success on Hantro G2)
> >> > - SAODBLK_A_MainConcept_4 (Success on Hantro G2)
> >> > - SAODBLK_B_MainConcept_4 (Success on Hantro G2)
> >> > - SLIST_B_Sony_9 (Success on Hantro G2)
> >> > - SLIST_D_Sony_9 (Success on Hantro G2)
> >> > - TSUNEQBD_A_MAIN10_Technicolor_2 (Success on Hantro G2)
> >> > - VPSSPSPPS_A_MainConcept_1 (Success on Hantro G2)
> >> > - WPP_D_ericsson_MAIN10_2 (Fail on Hantro G2)
> >> > - WPP_D_ericsson_MAIN_2 (Fail on Hantro G2)
> >> >
> >> > Not tested with FFMpeg so far.
> >> >
> >> > Known issues:
> >> > - Unable to reliably decode multiple videos concurrently
> >> > - The SAODBLK_* tests timeout if the timeout time in fluster is lowe=
r than 120
> >> > - Currently the uv_virstride is calculated in a manner that is hardc=
oded
> >> > for the two available formats NV12 and NV15. (@config_registers)
> >> >
> >> > Notable design decisions:
> >> > - I opted for a bitfield to represent the PPS memory blob as it is t=
he
> >> > perfect tool for that job. It describes the memory layout with any
> >> > additional required documentation, is easy to read and a native lang=
uage
> >> > tool for that job
> >>
> >> Can I point out how terrible an idea this is? The C language gives
> >> virtually zero guarantee about how bitfields are actually represented =
in
> >> memory. Platform ABIs (e.g. [1]) might nail things down a bit more, bu=
t
> >> different platforms are free to make completely different choices so
> >> portability still goes out the window. Even for a single platform,
> >> different compilers (or at worst even different version of one compile=
r)
> >> can still make incompatible choices e.g. WRT alignment of packed
> >> members. Even if you narrow the scope as far as a specific version of
> >> AArch64 GCC, I think this is still totally broken for big-endian.
> >>
> >> The fact that you've had to use nonsensical types to trick a compiler
> >> into meeting your expectations should already be a clue to how fragile
> >> this is in general.
> >>
> >> > - The RPS memory blob is created using a bitmap implementation, whic=
h
> >> > uses a common Kernel API to avoid reinventing the wheel and to keep =
the
> >> > code clean.
> >>
> >> Similarly, Linux bitmaps are designed for use as, well, bitmaps. Abusi=
ng
> >> them as a data interchange format for bit-aligned numerical values is
> >> far from "clean" semantically. And I'm pretty sure it's also broken fo=
r
> >> big-endian.
> >>
> >> This kind of stuff may be standard practice in embedded development
> >> where you're targeting a specific MCU with a specific toolchain, but I
> >> don't believe it's suitable for upstream Linux. It would take pretty
> >> much the same number of lines to use GENMASK definitions and bitfield.=
h
> >> helpers to pack values into words which can then be written to memory =
in
> >> a guaranteed format and endianness (certainly for the PPS; for the RPS
> >> it may well end up a bit longer, but would be self-documenting and
> >> certainly more readable than those loops). It mostly just means that f=
or
> >> any field which crosses a word boundary you'll end up with 2 definitio=
ns
> >> and 2 assignments, which is hardly a problem (and in some ways more
> >> honest about what's actually going on).
> >
> >Thanks for the feedback, in multimedia (unlike register programming), we=
 don't
> >really consider bitstreams as bitmap or bitfield. What we do really expe=
ct is to
> >use bit writer helpers (and sometimes a bit reader though we try and avo=
id the
> >second one in the  kernel). Its more of less a cursor (a bit position) i=
nto a
> >memory that advance while writing. A bit writer should help protect agai=
nst
> >overflow too.
> >
> >When writing lets say a chain of 8 bits from a char, a proper helper is =
expected
> >to be very explicit on the ordering (write_u8_le/be or something better =
worded).
> >I would rather like to see all these blobs written this way personally t=
hen
> >having a cleared buffer and writing using bit offsets.
> >
> >Perhaps I may suggest to start with implementing just that inside this d=
river?
> >It isn't very hard, and then the implementation can be reduced later and=
 shared
> >later, with whatever exists without deviating from the intent of the exi=
sting
> >API ? I do believe that having this in linux-media can be useful in the =
future.
> >We will notably need to extend such a helper with multimedia specific co=
ding
> >technique (golomb, boolean coding, etc.) for use in stateless encoder dr=
ivers.
>
> I currently design a general bit-writer API to handle the mentioned
> issues correctly. I'll post it as part of V2, due to my current workload
> this will happen in 3 weeks at the earliest.
>

I wonder if this is really the correct approach.

Introducing a new API and adding HEVC support at the same time,
sounds like scope creep to me.

How about you first introduce HEVC and then we move to the new API?
A generic bit-writer API might really take a long time to get mainlined.

Thanks!
Ezequiel

> >
> >Nicolas
> >
> >>
> >> Thanks,
> >> Robin.
>
> Greetings,
> Sebastian
>
> >>
> >> [1]
> >> https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#b=
it-fields
> >>
> >> > - I deliberatly opted against the macro solution used in H264, which
> >> > declares Macros in mid function and declares the fields of the memor=
y
> >> > blob as macros as well. And I would be glad to refactor the H264 cod=
e if
> >> > desired by the maintainer to use common Kernel APIs and native langu=
age
> >> > elements.
> >> > - The giant static array of cabac values is moved to a separate c fi=
le,
> >> > I did so because a separate .h file would be incorrect as it doesn't
> >> > expose anything of any value for any other file than the rkvdec-hevc=
.c
> >> > file. Other options were:
> >> >    - Calculating the values instead of storing the results (doesn't =
seem
> >> >    to be worth it)
> >> >    - Supply them via firmware (Adding firmware makes the whole softw=
are
> >> >    way more complicated and the usage of the driver less obvious)
> >> >
> >> > Ignored Checkpatch warnings (as it fits to the current style of the =
file):
> >> > ```
> >> > WARNING: line length of 162 exceeds 100 columns
> >> > #115: FILE: drivers/media/v4l2-core/v4l2-common.c:265:
> >> > +               { .format =3D V4L2_PIX_FMT_NV15,    .pixel_enc =3D V=
4L2_PIXEL_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 5, 5, =
0, 0 }, .hdiv =3D 2, .vdiv =3D 2,
> >> >
> >> > ERROR: trailing statements should be on next line
> >> > #128: FILE: drivers/media/v4l2-core/v4l2-ioctl.c:1305:
> >> > +       case V4L2_PIX_FMT_NV15:         descr =3D "10-bit Y/CbCr 4:2=
:0 (Packed)"; break;
> >> > ```
> >> >
> >> > v4l2-compliance test:
> >> > ```
> >> > Total for rkvdec device /dev/video3: 46, Succeeded: 46, Failed: 0, W=
arnings: 0
> >> > ```
> >> >
> >> > kselftest module run for the bitmap changes:
> >> > ```
> >> > $ sudo insmod /usr/lib/modules/5.19.0-rc3-finalseries/kernel/lib/tes=
t_bitmap.ko
> >> > [   71.751716] test_bitmap: parselist: 14: input is '0-2047:128/256'=
 OK, Time: 1750
> >> > [   71.751787] test_bitmap: bitmap_print_to_pagebuf: input is '0-327=
67
> >> > [   71.751787] ', Time: 6708
> >> > [   71.760373] test_bitmap: set_value: 6/6 tests correct
> >> > ```
> >> >
> >> > Jonas Karlman (2):
> >> >    media: v4l2: Add NV15 pixel format
> >> >    media: v4l2-common: Add helpers to calculate bytesperline and
> >> >      sizeimage
> >> >
> >> > Sebastian Fricke (4):
> >> >    bitops: bitmap helper to set variable length values
> >> >    staging: media: rkvdec: Add valid pixel format check
> >> >    staging: media: rkvdec: Enable S_CTRL IOCTL
> >> >    staging: media: rkvdec: Add HEVC backend
> >> >
> >> >   .../media/v4l/pixfmt-yuv-planar.rst           |   53 +
> >> >   drivers/media/v4l2-core/v4l2-common.c         |   79 +-
> >> >   drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
> >> >   drivers/staging/media/rkvdec/Makefile         |    2 +-
> >> >   drivers/staging/media/rkvdec/TODO             |   22 +-
> >> >   .../staging/media/rkvdec/rkvdec-hevc-data.c   | 1844 +++++++++++++=
++++
> >> >   drivers/staging/media/rkvdec/rkvdec-hevc.c    |  859 ++++++++
> >> >   drivers/staging/media/rkvdec/rkvdec-regs.h    |    1 +
> >> >   drivers/staging/media/rkvdec/rkvdec.c         |  182 +-
> >> >   drivers/staging/media/rkvdec/rkvdec.h         |    3 +
> >> >   include/linux/bitmap.h                        |   39 +
> >> >   include/uapi/linux/videodev2.h                |    1 +
> >> >   lib/test_bitmap.c                             |   47 +
> >> >   13 files changed, 3066 insertions(+), 67 deletions(-)
> >> >   create mode 100644 drivers/staging/media/rkvdec/rkvdec-hevc-data.c
> >> >   create mode 100644 drivers/staging/media/rkvdec/rkvdec-hevc.c
> >> >
> >>
> >
