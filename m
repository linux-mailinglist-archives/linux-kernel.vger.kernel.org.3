Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4D946AC0E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhLFWeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357223AbhLFWeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:34:07 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360D1C061746;
        Mon,  6 Dec 2021 14:30:38 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x15so49378713edv.1;
        Mon, 06 Dec 2021 14:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LF7apLKcpYb8fvK9WPsUiELxqz9ybSGMuibULs2XKcc=;
        b=dT6XdcapV8kcqziMl9wPK2OKcZFvPt0bTHJxhQhzZQE0PU6hzr0AslYrNsERmz+5Co
         xsn0aDOT/s9uIPXK9vmPx5nY4T31lziS8pBR8dAjlfaPxBayDDmiv9SbksZpuL4PbZO5
         0kpUPswMP7YLJg96MCSh4g0M/s9mz7Lj2gPVJpaboyMHzERlZOP75NAjn8u96KmDUj4A
         RusRu07SCaaooiz/HnO8JPNPAn0cTBcP28WhNn3y84HcU39qQcDKpg4n1lT8mJY7h+Rv
         ARS5ACHfc400zclKckhkYxZoUp0f4e7n92VJ9xHe/ve16cpfNxmU2bDFRA5lTqFvGHTQ
         prVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LF7apLKcpYb8fvK9WPsUiELxqz9ybSGMuibULs2XKcc=;
        b=jc6DG4De5DwGTzMjGqgxi+1x5B8HhMXy7KyOit8FidyXXXobTB5s6lPFTkYWaQlY0s
         774zxu3EUWjrZ5jVMyzY07Y/ce8T/kEpOCDBNNRUWlT6TZ0rCp5V9Ipy5H8SrLLIyJxK
         DQsPDLBzdCP7sDLCFuWltdqnwGZqhPpGkoohzmYb4uSaG6pim9Tr9O7uBCdfm8LhMHsJ
         mrxahqERu0ddvfKK0EFE8GlA+UcRihyZAclv//9D61flExkulHaayUIblVzRMOPzuxsx
         AzOrQWW+XCkMkuC80ffDx0MO9X+VHbrC8qNolzNDMyeEy0ATI5stjn+xseP7QB2s/1V+
         eY2Q==
X-Gm-Message-State: AOAM533LrBIWv4N8ytgFpL7vdiaEssOWlBIcd/zF9pYXIgFA/nDCz7xP
        FuQe+nn4bYVv8yP7Ql8ShnnBTmJYNGZJlcwZE6s=
X-Google-Smtp-Source: ABdhPJxCkbtcjS8pwF9zoc+/MtVMporrm7B4YAD2/6Hc2oTY++WO6h4cBYi8e7h7Xl9VNX1iXWr6pl3+6woOsAAkcHg=
X-Received: by 2002:a05:6402:3488:: with SMTP id v8mr3010156edc.398.1638829836588;
 Mon, 06 Dec 2021 14:30:36 -0800 (PST)
MIME-Version: 1.0
References: <20211205181618.1041699-1-aford173@gmail.com> <CAHCN7xL3PSbHKZK_4NKRwhNGOZYM+i54CoKCq01a6kdbCLc2KA@mail.gmail.com>
 <3b81a33d9bbadd10bc61c3daedecc5b73b99a435.camel@ndufresne.ca>
In-Reply-To: <3b81a33d9bbadd10bc61c3daedecc5b73b99a435.camel@ndufresne.ca>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 6 Dec 2021 16:30:25 -0600
Message-ID: <CAHCN7xKb4YhH83oOnbXtkAKWk-3QWNNxE8EhVJ=i7xKW0wjYXw@mail.gmail.com>
Subject: Re: [RFC 0/5] Split iMX8MQ Hantro VPU into G1 and G2 with blk-ctrl support
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 2:51 PM Nicolas Dufresne <nicolas@ndufresne.ca> wrot=
e:
>
> Le dimanche 05 d=C3=A9cembre 2021 =C3=A0 13:51 -0600, Adam Ford a =C3=A9c=
rit :
> > On Sun, Dec 5, 2021 at 12:16 PM Adam Ford <aford173@gmail.com> wrote:
> > >
> > > Currently, the VPU in the i.MQ8MQ is appearing as one codec, but in r=
eality, it's
> > > two IP blocks called G1 and G2.  There is initialization code in VPU =
code to
> > > pull some clocks, resets and other features which has been integrated=
 into
> > > the vpu-blk-ctrl for the i.MX8M Mini and a similar method can be used=
 to make
> > > the VPU codec's operate as stand-alone cores without having to know t=
he details
> > > of each other or the quirks unique to the i.MX8MQ, so the remaining c=
ode can be
> > > left more generic.
> > >
> > > This series was started by Lucas Stach, and picked up by me so some p=
atches have
> > > his s-o-b and mine where I might have changed a few minor items.  It'=
s in an RFC state
> > > because the G2 VP9 operations appear to hang, but the parent code fro=
m which I started doesn't
> > > appear to show VP9 support, and it looks like it should.
> > >
> > > since the g-streamer and media trees are in a constant state of chang=
e, this series is based on
> > > git://linuxtv.org/hverkuil/media_tree.git for-v5.17e
> > >
> >
> > I forgot to post Fluster results.
> >
> > Before the patches to this branch:
> >
> > 2gst-main] root@localhost:~/gstreamer/fluster# ./fluster.py list -c |gr=
ep -i v4l
> >
> >     GStreamer-H.264-V4L2-Gst1.0: GStreamer H.264 V4L2 decoder for
> > GStreamer 1.0... =E2=9D=8C
> >     GStreamer-H.264-V4L2SL-Gst1.0: GStreamer H.264 V4L2SL decoder for
> > GStreamer 1.0... =E2=9C=94=EF=B8=8F
> >     GStreamer-H.265-V4L2-Gst1.0: GStreamer H.265 V4L2 decoder for
> > GStreamer 1.0... =E2=9D=8C
> >     GStreamer-H.265-V4L2SL-Gst1.0: GStreamer H.265 V4L2SL decoder for
> > GStreamer 1.0... =E2=9D=8C
> >     GStreamer-VP8-V4L2-Gst1.0: GStreamer VP8 V4L2 decoder for GStreamer=
 1.0... =E2=9D=8C
> >     GStreamer-VP8-V4L2SL-Gst1.0: GStreamer VP8 V4L2SL decoder for
> > GStreamer 1.0... =E2=9C=94=EF=B8=8F
> >     GStreamer-VP9-V4L2SL-Gst1.0: GStreamer VP9 V4L2SL decoder for
> > GStreamer 1.0... =E2=9D=8C
> >     GStreamer-AV1-V4L2SL-Gst1.0: GStreamer AV1 V4L2SL decoder for
> > GStreamer 1.0... =E2=9D=8C
> > [gst-main] root@localhost:~/gstreamer/fluster#
> >
> > There was no VP9 support.
> >
> > ./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
> > GStreamer-H.264-V4L2SL-Gst1.0
> > Ran 90/135 tests successfully               in 58.787 secs
> >
> > AFTER this series, two decoders appear:
> >
> > [   15.919137] hantro-vpu 38300000.video-codec: registered
> > nxp,imx8mq-vpu-g1-dec as /dev/video0
> > [   15.983579] hantro-vpu 38310000.video-codec: registered
> > nxp,imx8mq-vpu-g2-dec as /dev/video1
> >
> > VP9 was listed:
> >
> >     GStreamer-H.264-V4L2-Gst1.0: GStreamer H.264 V4L2 decoder for
> > GStreamer 1.0... =E2=9D=8C
> >     GStreamer-H.264-V4L2SL-Gst1.0: GStreamer H.264 V4L2SL decoder for
> > GStreamer 1.0... =E2=9C=94=EF=B8=8F
> >     GStreamer-H.265-V4L2-Gst1.0: GStreamer H.265 V4L2 decoder for
> > GStreamer 1.0... =E2=9D=8C
> >     GStreamer-H.265-V4L2SL-Gst1.0: GStreamer H.265 V4L2SL decoder for
> > GStreamer 1.0... =E2=9D=8C
> >     GStreamer-VP8-V4L2-Gst1.0: GStreamer VP8 V4L2 decoder for GStreamer=
 1.0... =E2=9D=8C
> >     GStreamer-VP8-V4L2SL-Gst1.0: GStreamer VP8 V4L2SL decoder for
> > GStreamer 1.0... =E2=9C=94=EF=B8=8F
> >     GStreamer-VP9-V4L2SL-Gst1.0: GStreamer VP9 V4L2SL decoder for
> > GStreamer 1.0... =E2=9C=94=EF=B8=8F
> >     GStreamer-AV1-V4L2SL-Gst1.0: GStreamer AV1 V4L2SL decoder for
> > GStreamer 1.0... =E2=9D=8C
> >
> > ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
> > Ran 55/61 tests successfully               in 8.565 secs
> >
> >
> > ./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
> > Ran 90/135 tests successfully               in 60.269 secs
> >
> > Same results for H.264
> >
> > VP9 Hangs, where it didn't even appear as available before:
> >
> > ./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
> > ***********************************************************************=
*****************************
> > Running test suite VP9-TEST-VECTORS with decoder GStreamer-VP9-V4L2SL-G=
st1.0
> > Using 4 parallel job(s)
> > ***********************************************************************=
*****************************
> >
> > [TEST SUITE      ] (DECODER                    ) TEST VECTOR
> >                           ... RESULT
> > ----------------------------------------------------------------------
> > [VP9-TEST-VECTORS] (GStreamer-VP9-V4L2SL-Gst1.0)
> > vp90-2-00-quantizer-00.webm                     ... Success
> > [VP9-TEST-VECTORS] (GStreamer-VP9-V4L2SL-Gst1.0)
> > vp90-2-00-quantizer-01.webm                     ... Success
> > [VP9-TEST-VECTORS] (GStreamer-VP9-V4L2SL-Gst1.0)
> > vp90-2-00-quantizer-02.webm                     ... Succes
> >
> > <hang > - and yes, 'Success' didnt' finish writing to the serial port.
>
> Looks like hope to me ! Do you get further with -j 1 (one concurrent deco=
de) ?

Anything after the first attempt appears to fail.  I haven't figured
out if it's the G2 code or the power domain stuff.  Since VP9 didn't
work I migrated it to use the vpu-blk-ctrl, I can't really compare to
know if it was a regression or an improvement.

:-)

adam

>
> >
> >
> >
> > > Adam Ford (2):
> > >   media: hantro: split i.MX8MQ G1 and G2 code
> > >   arm64: dts: imx8mq: Split i.MX8MQ G1 and G2 with vpu-blk-ctrl
> > >
> > > Lucas Stach (3):
> > >   dt-bindings: power: imx8mq: add defines for VPU blk-ctrl domains
> > >   dt-bindings: soc: add binding for i.MX8MQ VPU blk-ctrl
> > >   soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl
> > >
> > >  .../soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml      |  71 +++++++++++
> > >  arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  69 ++++++----
> > >  drivers/soc/imx/imx8m-blk-ctrl.c              |  67 ++++++++++
> > >  drivers/staging/media/hantro/hantro_drv.c     |   4 +-
> > >  drivers/staging/media/hantro/hantro_hw.h      |   2 +-
> > >  drivers/staging/media/hantro/imx8m_vpu_hw.c   | 119 +++-------------=
--
> > >  include/dt-bindings/power/imx8mq-power.h      |   3 +
> > >  7 files changed, 205 insertions(+), 130 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx=
8mq-vpu-blk-ctrl.yaml
> > >
> > > --
> > > 2.32.0
> > >
>
