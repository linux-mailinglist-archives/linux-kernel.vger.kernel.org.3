Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E15946221B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhK2UX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbhK2UT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:19:58 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679E0C06FD68
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 08:54:23 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y12so74626510eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 08:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UsyF/dWQQNrn0rwDgW+rSch0YemV0PivvOS2f76eXi0=;
        b=vjGZ/Jp2JJJGSplFrc0i7yjUrXuf25vecciBoV9m6tj0SLjfbzRZaEPTyZkj/Nlz0h
         Yw2fpFgKwIR1lJdTzyNqo/tr3oCCxSlMdYoUoQ0nARAMBNkk9kC/cwbBKp63pQ9rINwe
         LvDdcwvnqfiyDQPigro+4gdcbJ4VfCKPaXJKTVfDE9o738xXAsUYnfQHHAECx2yIqm4S
         r6tzuGUMhDqBCLhvCKrTyvRawiOzdLjfwqtdA8evXcxzPRR+VioW4QqzFKcd7uCwu0z+
         sCX7y/R3luybBydMB62Nx7Nr3tuVPtvspT5StKJ0h8V1wJt8wvCdnqjbAcN6SnjVYGFd
         lnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UsyF/dWQQNrn0rwDgW+rSch0YemV0PivvOS2f76eXi0=;
        b=L8sd5yKJYgHqqynibxtdVDwukzBKZvEHDniwcnwylZ+QQKJs1ejPQxYDdDyGCV+UUH
         4t+keUwipT36XPHUULeaJiB1Dj3cNNsfFmPm311FSpQh6k66qb3HbHZQc2bYvNl9NAqT
         anv+F/GEw0L0a9XoVkMSF7+DOXiRbxDZL0juz3Zu2K/RDPQDQlQUH+pKjhc2FWDB/7jD
         I8i57+wiZP04BM+NRZE9Ec1zSAI6STVU7htkUpOQPNogQiZF3DQBxfZBh+lmq5i0e7Rz
         eE5ZFwER4UabFWpxh5kITQBocID28NFLN3ySzz0n37qzqXWI/SMUP2wppzdJg/NpVXJx
         +Djw==
X-Gm-Message-State: AOAM531EwTY+eyLuO64NGCyA7b6PyYcTNrLHILfu5+kvRjDJ7LbPHhBU
        N7VcRf1oWK9G1VS7oo92Mr+oW1CnUDbkXmjpRVJP/g==
X-Google-Smtp-Source: ABdhPJxFQTeprjRnIKw/ySJAcM+Yoa3ZdxrVGjFqyzwScsybVOffDKzEHZT/8egB5EH9xyyyOefK5t2r/TIXeesucls=
X-Received: by 2002:aa7:d412:: with SMTP id z18mr77515624edq.315.1638204861875;
 Mon, 29 Nov 2021 08:54:21 -0800 (PST)
MIME-Version: 1.0
References: <20211106183802.893285-1-aford173@gmail.com> <718f7f6d6cd564d031c1963f1590c62d549ae725.camel@ndufresne.ca>
 <CAHCN7xKM9RUE7z-+ug1on+D=nDoEm589R4m03ofys92Aq75ZVQ@mail.gmail.com>
 <8db00a4b6faa99c940d9bc86e17161eb0db5efe3.camel@ndufresne.ca>
 <CAJ+vNU28UJffFv9jQ2KryJMudqYxvCaoVOVcU5dPqRA209iN6A@mail.gmail.com>
 <d91532c2c0772f9aa708ead36b2a97203727a7ea.camel@ndufresne.ca>
 <CAJ+vNU3H-V+bPoZ3qKead45h=W7AhQK6Lhjrx5ssdF4c_qfe=A@mail.gmail.com>
 <CAHCN7x+0LwwU_rEST+TZxGquswGKL19gnTy9WLofsXtGAtWqdw@mail.gmail.com>
 <7f94eaacfddb8c5434c17f1e069ea87a17657ce9.camel@ndufresne.ca>
 <CAHCN7xKRzxMBmPbDobWTuvNNSpTXk5XENvfBnfkhRY3eZKhn6w@mail.gmail.com>
 <CAHCN7xJFLNi_g+HX8PCy1Rkgf0jnWpO5QGYVz8nH19xrJkwHrA@mail.gmail.com>
 <CAJ+vNU3zFd=6k_Emc5aafxKkGwCPp4crgOFezQ-E_MbWsn1_EA@mail.gmail.com>
 <fed6c2fd7cf4971062c417ce41ed1e3812b900e0.camel@ndufresne.ca> <CAHCN7xK+wROHaqDcsY-3WYFQ82qX17L-LHNL3siSWnWvwFShzQ@mail.gmail.com>
In-Reply-To: <CAHCN7xK+wROHaqDcsY-3WYFQ82qX17L-LHNL3siSWnWvwFShzQ@mail.gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Mon, 29 Nov 2021 13:54:10 -0300
Message-ID: <CAAEAJfC1xXvemaFP+vTFVJ3S-SpYtrxyZgDamSOgLC1F3ua5xw@mail.gmail.com>
Subject: Re: [RFC 0/5] arm64: imx8mm: Enable Hantro VPUs
To:     Adam Ford <aford173@gmail.com>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-media <linux-media@vger.kernel.org>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        cstevens@beaconembedded.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 at 13:48, Adam Ford <aford173@gmail.com> wrote:
>
> On Tue, Nov 23, 2021 at 2:07 PM Nicolas Dufresne <nicolas@ndufresne.ca> w=
rote:
> >
> > Le lundi 22 novembre 2021 =C3=A0 09:25 -0800, Tim Harvey a =C3=A9crit :
> > > On Sat, Nov 20, 2021 at 7:36 AM Adam Ford <aford173@gmail.com> wrote:
> > > >
> > > > On Fri, Nov 19, 2021 at 5:37 PM Adam Ford <aford173@gmail.com> wrot=
e:
> > > > >
> > > > > On Fri, Nov 19, 2021 at 10:29 AM Nicolas Dufresne <nicolas@ndufre=
sne.ca> wrote:
> > > > > >
> > > > > > Hi Adam, Tim,
> > > > > >
> > > > > > [...]
> > > > > > > > > > Nicolas and Adam,
> > > > > > > > > >
> > > > > > > > > > For the H1 patches in this series: I've been able to te=
st the IMX8MM
> > > > > > > > > > H1 JPEG encode using GStreamer 1.18.5:
> > > > > > > > > > $ gst-inspect-1.0 | grep -e "v4l2.*enc"
> > > > > > > > > > video4linux2:  v4l2jpegenc: V4L2 JPEG Encoder
> > > > > > > > > > $ gst-launch-1.0 videotestsrc ! jpegenc ! rtpjpegpay ! =
udpsink
> > > > > > > > >                                   ^ v4l2jpegenc
> > > > > > > > >
> > > > > > > > > This is just a transcript error ?
> > > > > > > >
> > > > > > > > Nicolas,
> > > > > > > >
> > > > > > > > No! Thanks for catching my mistake. I was testing with soft=
ware encode... ooops!
> > > > > > > >
> > > > > > > > 'gst-launch-1.0 videotestsrc ! v4l2jpegenc ! fakesink' actu=
ally hangs
> > > > > > > > the board so likely a power-domain issue there?
> > > > > > >
> > > > > > > The v4l2-compliance tests fail on the h1 decoder with a hang,=
 but I
> > > > > > > think we're writing to registers which are not documented in =
the Mini
> > > > > > > TRM.  The Mini TRM doesn't explicitly show the JPEG encoding =
as a
> > > > > > > feature, but some of the registers state JPEG, but because so=
me of the
> > > > > > > registers written for the H1 are not documented in the TRM.  =
If those
> > > > > > > registers are restricted or not in this SoC, I am concerned t=
hat it
> > > > > > > might be related.  I'll try to run some more tests this weeke=
nd to
> > > > > > > check on the status of the power-domain stuff.
> > > > > >
> > > > > > To verify if the HW support JPEG encoding you can read SWREG63 =
bit 25. This is
> > > > > > in the TRM, just not labelled properly. To mimic the decoding s=
ide, would be "HW
> > > > > > synthesis config register X" with the bit labelled SW_ENC_JPEG_=
PROF (but
> > > > > > PROF/profile is on or off). If your board hang while reading th=
is, you likely
> > > > > > didn't get the power bit right.
> > > > > >
> > > > > > IMX8 has an undocumented control block thing that we have been =
fighting with in
> > > > > > imx8q,  perhaps that's your issue. Few driver was proposed, we =
are still pending
> > > > > > on NXP solution to be submitted (they asked us to wait, still w=
aiting =3D)).
> > > > >
> > > > > Nicolas,
> > > > >
> > > > > Thanks for the suggestion to read offset FC.  There was an attemp=
t
> > > > > made by Lucas Stach to develop a VPU blk-ctrl driver to coordinat=
e the
> > > > > power-domains with the GPC driver. Unfortunately, it does appear =
to
> > > > > hang, so it might not be operating correctly.
> > > > >
> > > > > Lucas,
> > > > >
> > > > > Do you have any idea of stuff I can try to see if the power domai=
n is
> > > > > coming online correctly?
> > > > >
> > > > > [   10.434727] imx-pgc imx-pgc-domain.6: request the vpumix domai=
n to power up
> > > > > [   10.463647] imx-pgc imx-pgc-domain.6: request the vpumix ADB40=
0 to power up
> > > > > [   10.517155] imx-pgc imx-pgc-domain.6: genpd vpumix success
> > > > > [   10.728927] vpu: set fuse bits to enable
> > > > > [   10.825500] imx8m-blk-ctrl 38330000.blk-ctrl: power vpublk-g1 =
GPC domain
> > > > > [   10.878986] imx-pgc imx-pgc-domain.7: request the vpu-g1 domai=
n to power up
> > > > > [   10.932429] imx-pgc imx-pgc-domain.7: genpd vpu-g1 success
> > > > > [   10.971988] imx8m-blk-ctrl 38330000.blk-ctrl: genpd vpublk-g1 =
success
> > > > > [   11.004726] hantro-vpu 38300000.video-codec: registered
> > > > > nxp,imx8mm-vpu-dec as /dev/video0
> > > > > [   11.040760] imx8m-blk-ctrl 38330000.blk-ctrl: power vpublk-g2 =
GPC domain
> > > > > [   11.066181] imx-pgc imx-pgc-domain.8: request the vpu-g2 domai=
n to power up
> > > > > [   11.087887] imx-pgc imx-pgc-domain.8: genpd vpu-g2 success
> > > > > [   11.113808] imx8m-blk-ctrl 38330000.blk-ctrl: genpd vpublk-g2 =
success
> > > > > [   11.139634] hantro-vpu 38310000.video-codec: registered
> > > > > nxp,imx8mm-vpu-g2-dec as /dev/video1
> > > > > [   11.156463] imx8m-blk-ctrl 38330000.blk-ctrl: power vpublk-h1 =
GPC domain
> > > > > [   11.170817] imx-pgc imx-pgc-domain.9: request the vpu-h1 domai=
n to power up
> > > > > [   11.232990] imx-pgc imx-pgc-domain.9: genpd vpu-h1 success
> > > > > [   11.252546] imx8m-blk-ctrl 38330000.blk-ctrl: genpd vpublk-h1 =
success
> > > > > [   11.266152] hantro-vpu 38320000.video-codec: Checking vpu->enc=
_base + 0xfc
> > > > >
> > > > > <hang>
> > > > >
> > > > > adam
> > > > >
> > > >
> > > > Nicolas, Tim, and Lucas,
> > > >
> > > > I think I have the hanging resolved in the power domains, and I'll =
be
> > > > pushing the fix to the GPCv2.
> > > >
> > > > For the H1 Encoder, I added some debugging code to read the offset
> > > > 0xfc and print some data based on the findings of that VPU-h1 offse=
t.
> > > > I basically check the various bits per the TRM to see if they are s=
et
> > > > and print some splat to indicate whether or not the function is
> > > > supported.
> > > >
> > > > [    8.861865] hantro-vpu 38320000.video-codec: Checking vpu->enc_b=
ase + 0xfc
> > > > [    8.870594] hantro-vpu 38320000.video-codec: Stabilization suppo=
rted by HW
> > > > [    8.889341] hantro-vpu 38320000.video-codec: VP8 encoding suppor=
ted by HW
> > > > [    8.899386] hantro-vpu 38320000.video-codec: H.264 encoding supp=
orted by HW
> > > > [    8.918171] hantro-vpu 38320000.video-codec: RGB to YUV conversi=
on
> > > > supported by HW
> > > > [    8.934067] hantro-vpu 38320000.video-codec: registered
> > > > nxp,imx8mm-vpu-h1-enc as /dev/video2
> > > >
> > > > Unfortunately, JPEG is not listed as supported.  :-(
> > >
> > > Adam,
> > >
> > > Well not having JPEG encode support is unfortunate, and unexpected. D=
o
> > > we not have hantro support yet for VP8/H264 encode?
> >
> > There is no mainline support yet. You can derive from RK3288 support us=
ing Google ChromeOS method (a v4l2 plugins that simulate in userspace a sta=
teful encoder):
> >
> > - libv4l plugins / https://chromium.googlesource.com/chromiumos/third_p=
arty/libv4lplugins/+/refs/heads/master
> > - Kernel Driver / https://chromium.googlesource.com/chromiumos/third_pa=
rty/kernel/+/chromeos-4.4/drivers/media/platform/rockchip-vpu/
> >
> > >
> > > I haven't quite figured out how to build a modern mono-repo gstreamer
> > > on the ubuntu 20.04 rootfs I'm using so I haven't been able to test
> > > VPU encode/decode properly. I'll keep working on it when I'm back in
> > > the office the following week.
> >
> > Did a quick test to make sure there isn't any ubuntu specific blockers,=
 here's a
> > dirty script that produce a minimal GStreamer, there was really nothing=
 special
> > compare to other meson projects. Note that I use --wrap-mode=3Dnofallba=
ck to avoid
> > letting GStreamer complete it's feature-set by downloading the planet. =
This
> > already build quite a lot and could likely be made smaller by avoid plu=
gins-good
> > build-dep call, but then you need to check for v4l2odecs and video4linu=
x devs
> > (mostly gudev a glib udev binding).
> >
> > # Install ubuntu
> > podman run -it --rm ubuntu:20.04
> > sed -i "s/# deb-src/deb-src/" /etc/apt/sources.list
> > apt update
> > apt build-dep gstreamer1.0-plugins-good
> > apt install git python3-pip flex bison
> >
> > # Need a newer meson
> > pip3 install --user meson
> > export PATH=3D$PATH:~/.local/bin
> >
> > # Build GStreamer
> > git clone https://gitlab.freedesktop.org/gstreamer/gstreamer.git
> > cd gstreamer
> > meson setup build --wrap-mode=3Dnofallback
> > ninja -C build
> >
> > # Run in-place
> > ./gst-env.py
> > gst-inspect-1.0 v4l2codecs
> > gst-inspect 1.0 video4linux2
> >
> Thanks for the suggestions.
>
> I downloaded what's in the master repo:
>
> [gst-main] root@localhost:~/gstreamer# gst-inspect-1.0 v4l2codecs
>
> ** (gst-plugin-scanner:7317): CRITICAL **: 10:29:51.847: can't find
> gi.repository.Gst
> Plugin Details:
>   Name                     v4l2codecs
>   Description              V4L2 CODEC Accelerators plugin
>   Filename
> /root/gstreamer/builddir/subprojects/gst-plugins-bad/sys/v4l2codecs/libgs=
tv4l2codecs.so
>   Version                  1.19.3.1
>   License                  LGPL
>   Source module            gst-plugins-bad
>   Binary package           GStreamer Bad Plug-ins git
>   Origin URL               Unknown package origin
>
>   v4l2slh264dec: V4L2 Stateless H.264 Video Decoder
>   v4l2slmpeg2dec: V4L2 Stateless Mpeg2 Video Decoder
>   v4l2slvp8alphadecodebin: VP8 Alpha Decoder
>   v4l2slvp8dec: V4L2 Stateless VP8 Video Decoder
>
>   4 features:
>   +-- 4 elements
>
> [gst-main] root@localhost:~/gstreamer# gst-inspect-1.0 video4linux2
> Plugin Details:
>   Name                     video4linux2
>   Description              elements for Video 4 Linux
>   Filename
> /root/gstreamer/builddir/subprojects/gst-plugins-good/sys/v4l2/libgstvide=
o4linux2.so
>   Version                  1.19.3.1
>   License                  LGPL
>   Source module            gst-plugins-good
>   Binary package           GStreamer Good Plug-ins git
>   Origin URL               Unknown package origin
>
>   v4l2deviceprovider: Video (video4linux2) Device Provider
>   v4l2jpegenc: V4L2 JPEG Encoder
>   v4l2radio: Radio (video4linux2) Tuner
>   v4l2sink: Video (video4linux2) Sink
>   v4l2src: Video (video4linux2) Source
>
>   5 features:
>   +-- 4 elements
>   +-- 1 device providers
>
> I still have the H1 encoder enabled, but I know JPEG isn't supported,
> so I'm going to attempt to do some decoding and pipe to fakesink since
> I don't have a functional display yet.
>
> gst-launch-1.0 -ev filesrc location=3Dtrailer_1080p_h264_mp3.avi !
> decodebin3  ! fakesink
>
> Redistribute latency...
> /GstPipeline:pipeline0/GstDecodebin3:decodebin3-0/v4l2slh264dec:v4l2slh26=
4dec0.GstPad:src:
> caps =3D video/x-raw, format=3D(string)NV12, width=3D(int)1920,
> height=3D(int)1080, interlace-mode=3D(string)progressive,
> multiview-mode=3D(string)mono,
> multiview-flags=3D(GstVideoMultiviewFlagsSet)0:ffffffff:/right-view-first=
/left-flipped/left-flopped/right-flipped/right-flopped/half-aspect/mixed-mo=
no,
> pixel-aspect-ratio=3D(fraction)1/1, framerate=3D(fraction)25/1
> /GstPipeline:pipeline0/GstDecodebin3:decodebin3-0.GstGhostPad:video_0:
> caps =3D video/x-raw, format=3D(string)NV12, width=3D(int)1920,
> height=3D(int)1080, interlace-mode=3D(string)progressive,
> multiview-mode=3D(string)mono,
> multiview-flags=3D(GstVideoMultiviewFlagsSet)0:ffffffff:/right-view-first=
/left-flipped/left-flopped/right-flipped/right-flopped/half-aspect/mixed-mo=
no,
> pixel-aspect-ratio=3D(fraction)1/1, framerate=3D(fraction)25/1
> /GstPipeline:pipeline0/GstDecodebin3:decodebin3-0.GstGhostPad:video_0.Gst=
ProxyPad:proxypad6:
> caps =3D video/x-raw, format=3D(string)NV12, width=3D(int)1920,
> height=3D(int)1080, interlace-mode=3D(string)progressive,
> multiview-mode=3D(string)mono,
> multiview-flags=3D(GstVideoMultiviewFlagsSet)0:ffffffff:/right-view-first=
/left-flipped/left-flopped/right-flipped/right-flopped/half-aspect/mixed-mo=
no,
> pixel-aspect-ratio=3D(fraction)1/1, framerate=3D(fraction)25/1
> /GstPipeline:pipeline0/GstDecodebin3:decodebin3-0/GstMultiQueue:multiqueu=
e0:
> min-interleave-time =3D 300000000
> Redistribute latency...
> /GstPipeline:pipeline0/GstDecodebin3:decodebin3-0/v4l2slh264dec:v4l2slh26=
4dec0.GstPad:sink:
> caps =3D video/x-h264, variant=3D(string)itu, framerate=3D(fraction)25/1,
> width=3D(int)1920, height=3D(int)1080, chroma-format=3D(string)4:2:0,
> bit-depth-luma=3D(uint)8, bit-depth-chroma=3D(uint)8,
> parsed=3D(boolean)true, stream-format=3D(string)avc, alignment=3D(string)=
au,
> profile=3D(string)high, level=3D(string)4,
> codec_data=3D(buffer)01640028ffe1001a67640028acd940780227e584000003000400=
000300c83c60c65801000668ebe3cb22c0
> New clock: GstSystemClock
>
> And it appears to stream, because the counter increases.  I haven't
> checked the CPU utilization, but the fact that it shows v4l2slh264dec
> is good.
>
> Is there a way to know if/how the decoder is using the proper VPU?  I
> assume if it wasn't using the proper one, it would fail, but was just
> curious.
>

A few ways. You can check /proc/interrupts, which should have
VPU activity.

Or enable debug messages for the module,
using the debug hantro parameter. V4L2 has debug messages
that you can enable, see /sys/class/video4linux/video0/dev_debug.

Instead of fakesink you can output to pngenc/jpegenc and check the output
is visually correct. If at all possible, the proper way is to use Fluster,
and report the score you get:

https://github.com/fluendo/fluster

It should be easy to use.

> I think I'll redo the patch without the RFC and without the H1 encoder
> unless anyone has any objections.  I know I need to rebase on
> linux-next anyway because the patches don't apply cleanly.  Is there a
> specific branch I should use?  I don't know if this goes through
> Shawn's IMX tree or the media tree (or a combination)
>

You should rebase on media's master branch:

https://git.linuxtv.org/media_tree.git/log/

Thanks,
Ezequiel
