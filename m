Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC3D468D18
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 20:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbhLETyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 14:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbhLETyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 14:54:43 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154B0C061714;
        Sun,  5 Dec 2021 11:51:16 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x15so34602352edv.1;
        Sun, 05 Dec 2021 11:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aYk6tlltAWxz+Lc9ZOG1gq6DUYS4v1JgEkLR93QjrjA=;
        b=PqmsZO7Oa5OdJ5RdHyIN/q2FCcc53sI5u2qfvkDWMqXurPU3LNwhVQN4G6xy83UnqB
         JaUfqIkPDW/nW+Go0fZylKEnnxsnDgLlkVg9Z9avDDvYU0rwHSy0EGhgguW0eevFK7lh
         2nKN5LZ14iiMhAneUPO9hEz5vbJsy24x8yV2IC0sn5bmBWkCb/AS/rv5o1Nu4DYZIavv
         zYL40hCA5e3XujdHXuTIP0C0IxrUpOnOSlAWjicHrFC2cdz33zl//LF3eDVRlAhvqrxV
         066KjqjrGsxe/4sze3saD72bxIZ3RfcqchiHUgV5i7BbLqnpXQ5uJtSwZu7lseL+P1Ql
         SC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aYk6tlltAWxz+Lc9ZOG1gq6DUYS4v1JgEkLR93QjrjA=;
        b=CMZts4hlkEyLki8UPLPrRVzPTVAv4IsgLLZKei1v0+9+KuBUg/oEoHIxe8+VnCJv+Q
         zDa2EC0+YMgrCk7zSPsiU4RebdRuqWBLqeCijtS75vACykk/ZEg9clT/JzzHwNfEqwYO
         KhZXROKhsLjUwd5HQb+Ab1V7nE68cpRUDy7L1cyqHbAvq188rtDzxvYqp6MDDKK6KLll
         4lB6rm63Ltzh9tEwHrMId0qSVRNflDOOJxMcdml5SMw9KBTbD50H69pzlvTpOdP6FDLM
         u+lrkPUlOoH8TlJBs41N4s1Or6ZmCnjGzMfu5RsdSe4bPGynz9Z24fKySFRQYdXKrMQ+
         eK9g==
X-Gm-Message-State: AOAM533e7jedUH2ypaAPWX+0iuBp63BQxlR/w+/A4LKazdwbyPIl+Xes
        G3Vki2GcZyp4Y6bsFEErkhFh7rHsDLMuvPuMPjXNav1YgwY=
X-Google-Smtp-Source: ABdhPJxEEYXAtlNDIHxi+vMyv1lC0gCFxrGSQ2h/mDcSyIsJ/yDhiCAw5OsZ2QHMzxz0RC6SAm2D12hmp3o0fp/mzn0=
X-Received: by 2002:aa7:d288:: with SMTP id w8mr49063653edq.404.1638733874161;
 Sun, 05 Dec 2021 11:51:14 -0800 (PST)
MIME-Version: 1.0
References: <20211205181618.1041699-1-aford173@gmail.com>
In-Reply-To: <20211205181618.1041699-1-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 5 Dec 2021 13:51:02 -0600
Message-ID: <CAHCN7xL3PSbHKZK_4NKRwhNGOZYM+i54CoKCq01a6kdbCLc2KA@mail.gmail.com>
Subject: Re: [RFC 0/5] Split iMX8MQ Hantro VPU into G1 and G2 with blk-ctrl support
To:     linux-media@vger.kernel.org
Cc:     benjamin.gaignard@collabora.com, cphealy@gmail.com,
        nicolas@ndufresne.ca, Rob Herring <robh+dt@kernel.org>,
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
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 5, 2021 at 12:16 PM Adam Ford <aford173@gmail.com> wrote:
>
> Currently, the VPU in the i.MQ8MQ is appearing as one codec, but in reali=
ty, it's
> two IP blocks called G1 and G2.  There is initialization code in VPU code=
 to
> pull some clocks, resets and other features which has been integrated int=
o
> the vpu-blk-ctrl for the i.MX8M Mini and a similar method can be used to =
make
> the VPU codec's operate as stand-alone cores without having to know the d=
etails
> of each other or the quirks unique to the i.MX8MQ, so the remaining code =
can be
> left more generic.
>
> This series was started by Lucas Stach, and picked up by me so some patch=
es have
> his s-o-b and mine where I might have changed a few minor items.  It's in=
 an RFC state
> because the G2 VP9 operations appear to hang, but the parent code from wh=
ich I started doesn't
> appear to show VP9 support, and it looks like it should.
>
> since the g-streamer and media trees are in a constant state of change, t=
his series is based on
> git://linuxtv.org/hverkuil/media_tree.git for-v5.17e
>

I forgot to post Fluster results.

Before the patches to this branch:

2gst-main] root@localhost:~/gstreamer/fluster# ./fluster.py list -c |grep -=
i v4l

    GStreamer-H.264-V4L2-Gst1.0: GStreamer H.264 V4L2 decoder for
GStreamer 1.0... =E2=9D=8C
    GStreamer-H.264-V4L2SL-Gst1.0: GStreamer H.264 V4L2SL decoder for
GStreamer 1.0... =E2=9C=94=EF=B8=8F
    GStreamer-H.265-V4L2-Gst1.0: GStreamer H.265 V4L2 decoder for
GStreamer 1.0... =E2=9D=8C
    GStreamer-H.265-V4L2SL-Gst1.0: GStreamer H.265 V4L2SL decoder for
GStreamer 1.0... =E2=9D=8C
    GStreamer-VP8-V4L2-Gst1.0: GStreamer VP8 V4L2 decoder for GStreamer 1.0=
... =E2=9D=8C
    GStreamer-VP8-V4L2SL-Gst1.0: GStreamer VP8 V4L2SL decoder for
GStreamer 1.0... =E2=9C=94=EF=B8=8F
    GStreamer-VP9-V4L2SL-Gst1.0: GStreamer VP9 V4L2SL decoder for
GStreamer 1.0... =E2=9D=8C
    GStreamer-AV1-V4L2SL-Gst1.0: GStreamer AV1 V4L2SL decoder for
GStreamer 1.0... =E2=9D=8C
[gst-main] root@localhost:~/gstreamer/fluster#

There was no VP9 support.

./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
GStreamer-H.264-V4L2SL-Gst1.0
Ran 90/135 tests successfully               in 58.787 secs

AFTER this series, two decoders appear:

[   15.919137] hantro-vpu 38300000.video-codec: registered
nxp,imx8mq-vpu-g1-dec as /dev/video0
[   15.983579] hantro-vpu 38310000.video-codec: registered
nxp,imx8mq-vpu-g2-dec as /dev/video1

VP9 was listed:

    GStreamer-H.264-V4L2-Gst1.0: GStreamer H.264 V4L2 decoder for
GStreamer 1.0... =E2=9D=8C
    GStreamer-H.264-V4L2SL-Gst1.0: GStreamer H.264 V4L2SL decoder for
GStreamer 1.0... =E2=9C=94=EF=B8=8F
    GStreamer-H.265-V4L2-Gst1.0: GStreamer H.265 V4L2 decoder for
GStreamer 1.0... =E2=9D=8C
    GStreamer-H.265-V4L2SL-Gst1.0: GStreamer H.265 V4L2SL decoder for
GStreamer 1.0... =E2=9D=8C
    GStreamer-VP8-V4L2-Gst1.0: GStreamer VP8 V4L2 decoder for GStreamer 1.0=
... =E2=9D=8C
    GStreamer-VP8-V4L2SL-Gst1.0: GStreamer VP8 V4L2SL decoder for
GStreamer 1.0... =E2=9C=94=EF=B8=8F
    GStreamer-VP9-V4L2SL-Gst1.0: GStreamer VP9 V4L2SL decoder for
GStreamer 1.0... =E2=9C=94=EF=B8=8F
    GStreamer-AV1-V4L2SL-Gst1.0: GStreamer AV1 V4L2SL decoder for
GStreamer 1.0... =E2=9D=8C

./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
Ran 55/61 tests successfully               in 8.565 secs


./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
Ran 90/135 tests successfully               in 60.269 secs

Same results for H.264

VP9 Hangs, where it didn't even appear as available before:

./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
***************************************************************************=
*************************
Running test suite VP9-TEST-VECTORS with decoder GStreamer-VP9-V4L2SL-Gst1.=
0
Using 4 parallel job(s)
***************************************************************************=
*************************

[TEST SUITE      ] (DECODER                    ) TEST VECTOR
                          ... RESULT
----------------------------------------------------------------------
[VP9-TEST-VECTORS] (GStreamer-VP9-V4L2SL-Gst1.0)
vp90-2-00-quantizer-00.webm                     ... Success
[VP9-TEST-VECTORS] (GStreamer-VP9-V4L2SL-Gst1.0)
vp90-2-00-quantizer-01.webm                     ... Success
[VP9-TEST-VECTORS] (GStreamer-VP9-V4L2SL-Gst1.0)
vp90-2-00-quantizer-02.webm                     ... Succes

<hang > - and yes, 'Success' didnt' finish writing to the serial port.



> Adam Ford (2):
>   media: hantro: split i.MX8MQ G1 and G2 code
>   arm64: dts: imx8mq: Split i.MX8MQ G1 and G2 with vpu-blk-ctrl
>
> Lucas Stach (3):
>   dt-bindings: power: imx8mq: add defines for VPU blk-ctrl domains
>   dt-bindings: soc: add binding for i.MX8MQ VPU blk-ctrl
>   soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl
>
>  .../soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml      |  71 +++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  69 ++++++----
>  drivers/soc/imx/imx8m-blk-ctrl.c              |  67 ++++++++++
>  drivers/staging/media/hantro/hantro_drv.c     |   4 +-
>  drivers/staging/media/hantro/hantro_hw.h      |   2 +-
>  drivers/staging/media/hantro/imx8m_vpu_hw.c   | 119 +++---------------
>  include/dt-bindings/power/imx8mq-power.h      |   3 +
>  7 files changed, 205 insertions(+), 130 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-=
vpu-blk-ctrl.yaml
>
> --
> 2.32.0
>
