Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDCC46258C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbhK2Wk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbhK2WkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:40:23 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BA2C08EA6F;
        Mon, 29 Nov 2021 11:42:19 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id w1so76844777edc.6;
        Mon, 29 Nov 2021 11:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PR2kU2cxHPqVfx/VFj+jY8UQurWdyhxVbanqNvLQbnk=;
        b=achU+XvXvKlWwt5zaDusuabBguxac4L7KY/ZBA6XEP+/+RVud0anCiTKjLBhUGOMsX
         YfViqPkZx0HkS9FAauaSaWYGqqn6wkb9Ey7lfnBhLm1deEVD+NhyxGslrSMu5GjCPfsD
         2cKWS1C/lkwz73Saa4uyX55EqpywreEL5fC2KRNW1fcppY1EHJP/pCqD4UywDj+meGu9
         B5xln3JyKF1LF+MLAdlXganRn+EFwvvo2ZG4Pp312I0mr3yw4llHeTCr0XEpTQirD6Fe
         HP4cN6HLHcoNewENtW25rNpUZeWsMmEgYB54CPDY9Ye7KqYptY74z6pxaisdKqYPXkb+
         7oKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PR2kU2cxHPqVfx/VFj+jY8UQurWdyhxVbanqNvLQbnk=;
        b=3mWr2+kTJboFKDgM1jJB0rRuAF93hxLujkf8gT52nc4fPeLmx9Hjg0HQJVr7uOY8vb
         mpH8oeHBYAa3/yW8ByxtQdOeCmRSHhgibjPnFQ+AtYsQBzBbrcOzj/3wfyRimCkpDZKj
         O+Lw5kHFpEVznSam2xG6SDXROmWWHSOXhEmAkOA4BHA0k04+nkcl9Dea103qE1m3BhRM
         KuKt4LawIlqRz3ICrwnRc4ys7lVNucYByHFrM8dZfaKbyCk3tvA9iUe2jbAgApWctlEa
         FCI2AwJaL2UR/7DNIYqTfcs8RWOp+99FRgT8RxS7+BCurJPoliKLJQod1x7GNt/Uy36Z
         VSrg==
X-Gm-Message-State: AOAM533Alz5uutWCMSf+XUbxRH9Fc/es4FJTOr4GzgSWiHi93ARqqGDO
        ezIOCAflSHp/TWjHOo6opX90Ro/kKyenRF+N6Js=
X-Google-Smtp-Source: ABdhPJwhMm1j3MWvEwU7zxURQ3alCKZj/XIf39zPrOQLlZZyzvulsOaLOPNzSFBVFi4sOQ6TULun1CjJewDKJqtf50s=
X-Received: by 2002:a17:907:75f0:: with SMTP id jz16mr63599822ejc.77.1638214937203;
 Mon, 29 Nov 2021 11:42:17 -0800 (PST)
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
 <fed6c2fd7cf4971062c417ce41ed1e3812b900e0.camel@ndufresne.ca>
 <CAHCN7xK+wROHaqDcsY-3WYFQ82qX17L-LHNL3siSWnWvwFShzQ@mail.gmail.com>
 <CAAEAJfC1xXvemaFP+vTFVJ3S-SpYtrxyZgDamSOgLC1F3ua5xw@mail.gmail.com>
 <CAHCN7x+UMMP6RXsNm0=OC=UTQzh=RKqQo6B7FD5e4eoJAEfmpg@mail.gmail.com> <CAJ+vNU1epi9SwPMHkuDmKcb68RLemYF=bsp7AVnzz06zKc2efw@mail.gmail.com>
In-Reply-To: <CAJ+vNU1epi9SwPMHkuDmKcb68RLemYF=bsp7AVnzz06zKc2efw@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 29 Nov 2021 13:42:04 -0600
Message-ID: <CAHCN7xJACfiNHNfUrAsN82+TrOLS+_dDgvyQH3DutXA0u2sy6w@mail.gmail.com>
Subject: Re: [RFC 0/5] arm64: imx8mm: Enable Hantro VPUs
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
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

On Mon, Nov 29, 2021 at 1:36 PM Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Mon, Nov 29, 2021 at 10:59 AM Adam Ford <aford173@gmail.com> wrote:
> >
> > On Mon, Nov 29, 2021 at 10:54 AM Ezequiel Garcia
> > <ezequiel@vanguardiasur.com.ar> wrote:
> > >
> > > On Mon, 29 Nov 2021 at 13:48, Adam Ford <aford173@gmail.com> wrote:
> > > >
> > > > On Tue, Nov 23, 2021 at 2:07 PM Nicolas Dufresne <nicolas@ndufresne=
.ca> wrote:
> > > > >
> > > > > Le lundi 22 novembre 2021 =C3=A0 09:25 -0800, Tim Harvey a =C3=A9=
crit :
> > > > > > On Sat, Nov 20, 2021 at 7:36 AM Adam Ford <aford173@gmail.com> =
wrote:
> > > > > > >
> > > > > > > On Fri, Nov 19, 2021 at 5:37 PM Adam Ford <aford173@gmail.com=
> wrote:
> > > > > > > >
> > > > > > > > On Fri, Nov 19, 2021 at 10:29 AM Nicolas Dufresne <nicolas@=
ndufresne.ca> wrote:
> > > > > > > > >
> > > > > > > > > Hi Adam, Tim,
> > > > > > > > >
> > > > > > > > > [...]
> > > > > > > > > > > > > Nicolas and Adam,
> > > > > > > > > > > > >
> > > > > > > > > > > > > For the H1 patches in this series: I've been able=
 to test the IMX8MM
> > > > > > > > > > > > > H1 JPEG encode using GStreamer 1.18.5:
> > > > > > > > > > > > > $ gst-inspect-1.0 | grep -e "v4l2.*enc"
> > > > > > > > > > > > > video4linux2:  v4l2jpegenc: V4L2 JPEG Encoder
> > > > > > > > > > > > > $ gst-launch-1.0 videotestsrc ! jpegenc ! rtpjpeg=
pay ! udpsink
> > > > > > > > > > > >                                   ^ v4l2jpegenc
> > > > > > > > > > > >
> > > > > > > > > > > > This is just a transcript error ?
> > > > > > > > > > >
> > > > > > > > > > > Nicolas,
> > > > > > > > > > >
> > > > > > > > > > > No! Thanks for catching my mistake. I was testing wit=
h software encode... ooops!
> > > > > > > > > > >
> > > > > > > > > > > 'gst-launch-1.0 videotestsrc ! v4l2jpegenc ! fakesink=
' actually hangs
> > > > > > > > > > > the board so likely a power-domain issue there?
> > > > > > > > > >
> > > > > > > > > > The v4l2-compliance tests fail on the h1 decoder with a=
 hang, but I
> > > > > > > > > > think we're writing to registers which are not document=
ed in the Mini
> > > > > > > > > > TRM.  The Mini TRM doesn't explicitly show the JPEG enc=
oding as a
> > > > > > > > > > feature, but some of the registers state JPEG, but beca=
use some of the
> > > > > > > > > > registers written for the H1 are not documented in the =
TRM.  If those
> > > > > > > > > > registers are restricted or not in this SoC, I am conce=
rned that it
> > > > > > > > > > might be related.  I'll try to run some more tests this=
 weekend to
> > > > > > > > > > check on the status of the power-domain stuff.
> > > > > > > > >
> > > > > > > > > To verify if the HW support JPEG encoding you can read SW=
REG63 bit 25. This is
> > > > > > > > > in the TRM, just not labelled properly. To mimic the deco=
ding side, would be "HW
> > > > > > > > > synthesis config register X" with the bit labelled SW_ENC=
_JPEG_PROF (but
> > > > > > > > > PROF/profile is on or off). If your board hang while read=
ing this, you likely
> > > > > > > > > didn't get the power bit right.
> > > > > > > > >
> > > > > > > > > IMX8 has an undocumented control block thing that we have=
 been fighting with in
> > > > > > > > > imx8q,  perhaps that's your issue. Few driver was propose=
d, we are still pending
> > > > > > > > > on NXP solution to be submitted (they asked us to wait, s=
till waiting =3D)).
> > > > > > > >
> > > > > > > > Nicolas,
> > > > > > > >
> > > > > > > > Thanks for the suggestion to read offset FC.  There was an =
attempt
> > > > > > > > made by Lucas Stach to develop a VPU blk-ctrl driver to coo=
rdinate the
> > > > > > > > power-domains with the GPC driver. Unfortunately, it does a=
ppear to
> > > > > > > > hang, so it might not be operating correctly.
> > > > > > > >
> > > > > > > > Lucas,
> > > > > > > >
> > > > > > > > Do you have any idea of stuff I can try to see if the power=
 domain is
> > > > > > > > coming online correctly?
> > > > > > > >
> > > > > > > > [   10.434727] imx-pgc imx-pgc-domain.6: request the vpumix=
 domain to power up
> > > > > > > > [   10.463647] imx-pgc imx-pgc-domain.6: request the vpumix=
 ADB400 to power up
> > > > > > > > [   10.517155] imx-pgc imx-pgc-domain.6: genpd vpumix succe=
ss
> > > > > > > > [   10.728927] vpu: set fuse bits to enable
> > > > > > > > [   10.825500] imx8m-blk-ctrl 38330000.blk-ctrl: power vpub=
lk-g1 GPC domain
> > > > > > > > [   10.878986] imx-pgc imx-pgc-domain.7: request the vpu-g1=
 domain to power up
> > > > > > > > [   10.932429] imx-pgc imx-pgc-domain.7: genpd vpu-g1 succe=
ss
> > > > > > > > [   10.971988] imx8m-blk-ctrl 38330000.blk-ctrl: genpd vpub=
lk-g1 success
> > > > > > > > [   11.004726] hantro-vpu 38300000.video-codec: registered
> > > > > > > > nxp,imx8mm-vpu-dec as /dev/video0
> > > > > > > > [   11.040760] imx8m-blk-ctrl 38330000.blk-ctrl: power vpub=
lk-g2 GPC domain
> > > > > > > > [   11.066181] imx-pgc imx-pgc-domain.8: request the vpu-g2=
 domain to power up
> > > > > > > > [   11.087887] imx-pgc imx-pgc-domain.8: genpd vpu-g2 succe=
ss
> > > > > > > > [   11.113808] imx8m-blk-ctrl 38330000.blk-ctrl: genpd vpub=
lk-g2 success
> > > > > > > > [   11.139634] hantro-vpu 38310000.video-codec: registered
> > > > > > > > nxp,imx8mm-vpu-g2-dec as /dev/video1
> > > > > > > > [   11.156463] imx8m-blk-ctrl 38330000.blk-ctrl: power vpub=
lk-h1 GPC domain
> > > > > > > > [   11.170817] imx-pgc imx-pgc-domain.9: request the vpu-h1=
 domain to power up
> > > > > > > > [   11.232990] imx-pgc imx-pgc-domain.9: genpd vpu-h1 succe=
ss
> > > > > > > > [   11.252546] imx8m-blk-ctrl 38330000.blk-ctrl: genpd vpub=
lk-h1 success
> > > > > > > > [   11.266152] hantro-vpu 38320000.video-codec: Checking vp=
u->enc_base + 0xfc
> > > > > > > >
> > > > > > > > <hang>
> > > > > > > >
> > > > > > > > adam
> > > > > > > >
> > > > > > >
> > > > > > > Nicolas, Tim, and Lucas,
> > > > > > >
> > > > > > > I think I have the hanging resolved in the power domains, and=
 I'll be
> > > > > > > pushing the fix to the GPCv2.
> > > > > > >
> > > > > > > For the H1 Encoder, I added some debugging code to read the o=
ffset
> > > > > > > 0xfc and print some data based on the findings of that VPU-h1=
 offset.
> > > > > > > I basically check the various bits per the TRM to see if they=
 are set
> > > > > > > and print some splat to indicate whether or not the function =
is
> > > > > > > supported.
> > > > > > >
> > > > > > > [    8.861865] hantro-vpu 38320000.video-codec: Checking vpu-=
>enc_base + 0xfc
> > > > > > > [    8.870594] hantro-vpu 38320000.video-codec: Stabilization=
 supported by HW
> > > > > > > [    8.889341] hantro-vpu 38320000.video-codec: VP8 encoding =
supported by HW
> > > > > > > [    8.899386] hantro-vpu 38320000.video-codec: H.264 encodin=
g supported by HW
> > > > > > > [    8.918171] hantro-vpu 38320000.video-codec: RGB to YUV co=
nversion
> > > > > > > supported by HW
> > > > > > > [    8.934067] hantro-vpu 38320000.video-codec: registered
> > > > > > > nxp,imx8mm-vpu-h1-enc as /dev/video2
> > > > > > >
> > > > > > > Unfortunately, JPEG is not listed as supported.  :-(
> > > > > >
> > > > > > Adam,
> > > > > >
> > > > > > Well not having JPEG encode support is unfortunate, and unexpec=
ted. Do
> > > > > > we not have hantro support yet for VP8/H264 encode?
> > > > >
> > > > > There is no mainline support yet. You can derive from RK3288 supp=
ort using Google ChromeOS method (a v4l2 plugins that simulate in userspace=
 a stateful encoder):
> > > > >
> > > > > - libv4l plugins / https://chromium.googlesource.com/chromiumos/t=
hird_party/libv4lplugins/+/refs/heads/master
> > > > > - Kernel Driver / https://chromium.googlesource.com/chromiumos/th=
ird_party/kernel/+/chromeos-4.4/drivers/media/platform/rockchip-vpu/
> > > > >
> > > > > >
> > > > > > I haven't quite figured out how to build a modern mono-repo gst=
reamer
> > > > > > on the ubuntu 20.04 rootfs I'm using so I haven't been able to =
test
> > > > > > VPU encode/decode properly. I'll keep working on it when I'm ba=
ck in
> > > > > > the office the following week.
> > > > >
> > > > > Did a quick test to make sure there isn't any ubuntu specific blo=
ckers, here's a
> > > > > dirty script that produce a minimal GStreamer, there was really n=
othing special
> > > > > compare to other meson projects. Note that I use --wrap-mode=3Dno=
fallback to avoid
> > > > > letting GStreamer complete it's feature-set by downloading the pl=
anet. This
> > > > > already build quite a lot and could likely be made smaller by avo=
id plugins-good
> > > > > build-dep call, but then you need to check for v4l2odecs and vide=
o4linux devs
> > > > > (mostly gudev a glib udev binding).
> > > > >
> > > > > # Install ubuntu
> > > > > podman run -it --rm ubuntu:20.04
> > > > > sed -i "s/# deb-src/deb-src/" /etc/apt/sources.list
> > > > > apt update
> > > > > apt build-dep gstreamer1.0-plugins-good
> > > > > apt install git python3-pip flex bison
> > > > >
> > > > > # Need a newer meson
> > > > > pip3 install --user meson
> > > > > export PATH=3D$PATH:~/.local/bin
> > > > >
> > > > > # Build GStreamer
> > > > > git clone https://gitlab.freedesktop.org/gstreamer/gstreamer.git
> > > > > cd gstreamer
> > > > > meson setup build --wrap-mode=3Dnofallback
> > > > > ninja -C build
> > > > >
> > > > > # Run in-place
> > > > > ./gst-env.py
> > > > > gst-inspect-1.0 v4l2codecs
> > > > > gst-inspect 1.0 video4linux2
> > > > >
> > > > Thanks for the suggestions.
> > > >
> > > > I downloaded what's in the master repo:
> > > >
> > > > [gst-main] root@localhost:~/gstreamer# gst-inspect-1.0 v4l2codecs
> > > >
> > > > ** (gst-plugin-scanner:7317): CRITICAL **: 10:29:51.847: can't find
> > > > gi.repository.Gst
> > > > Plugin Details:
> > > >   Name                     v4l2codecs
> > > >   Description              V4L2 CODEC Accelerators plugin
> > > >   Filename
> > > > /root/gstreamer/builddir/subprojects/gst-plugins-bad/sys/v4l2codecs=
/libgstv4l2codecs.so
> > > >   Version                  1.19.3.1
> > > >   License                  LGPL
> > > >   Source module            gst-plugins-bad
> > > >   Binary package           GStreamer Bad Plug-ins git
> > > >   Origin URL               Unknown package origin
> > > >
> > > >   v4l2slh264dec: V4L2 Stateless H.264 Video Decoder
> > > >   v4l2slmpeg2dec: V4L2 Stateless Mpeg2 Video Decoder
> > > >   v4l2slvp8alphadecodebin: VP8 Alpha Decoder
> > > >   v4l2slvp8dec: V4L2 Stateless VP8 Video Decoder
> > > >
> > > >   4 features:
> > > >   +-- 4 elements
> > > >
> > > > [gst-main] root@localhost:~/gstreamer# gst-inspect-1.0 video4linux2
> > > > Plugin Details:
> > > >   Name                     video4linux2
> > > >   Description              elements for Video 4 Linux
> > > >   Filename
> > > > /root/gstreamer/builddir/subprojects/gst-plugins-good/sys/v4l2/libg=
stvideo4linux2.so
> > > >   Version                  1.19.3.1
> > > >   License                  LGPL
> > > >   Source module            gst-plugins-good
> > > >   Binary package           GStreamer Good Plug-ins git
> > > >   Origin URL               Unknown package origin
> > > >
> > > >   v4l2deviceprovider: Video (video4linux2) Device Provider
> > > >   v4l2jpegenc: V4L2 JPEG Encoder
> > > >   v4l2radio: Radio (video4linux2) Tuner
> > > >   v4l2sink: Video (video4linux2) Sink
> > > >   v4l2src: Video (video4linux2) Source
> > > >
> > > >   5 features:
> > > >   +-- 4 elements
> > > >   +-- 1 device providers
> > > >
> > > > I still have the H1 encoder enabled, but I know JPEG isn't supporte=
d,
> > > > so I'm going to attempt to do some decoding and pipe to fakesink si=
nce
> > > > I don't have a functional display yet.
> > > >
> > > > gst-launch-1.0 -ev filesrc location=3Dtrailer_1080p_h264_mp3.avi !
> > > > decodebin3  ! fakesink
> > > >
> > > > Redistribute latency...
> > > > /GstPipeline:pipeline0/GstDecodebin3:decodebin3-0/v4l2slh264dec:v4l=
2slh264dec0.GstPad:src:
> > > > caps =3D video/x-raw, format=3D(string)NV12, width=3D(int)1920,
> > > > height=3D(int)1080, interlace-mode=3D(string)progressive,
> > > > multiview-mode=3D(string)mono,
> > > > multiview-flags=3D(GstVideoMultiviewFlagsSet)0:ffffffff:/right-view=
-first/left-flipped/left-flopped/right-flipped/right-flopped/half-aspect/mi=
xed-mono,
> > > > pixel-aspect-ratio=3D(fraction)1/1, framerate=3D(fraction)25/1
> > > > /GstPipeline:pipeline0/GstDecodebin3:decodebin3-0.GstGhostPad:video=
_0:
> > > > caps =3D video/x-raw, format=3D(string)NV12, width=3D(int)1920,
> > > > height=3D(int)1080, interlace-mode=3D(string)progressive,
> > > > multiview-mode=3D(string)mono,
> > > > multiview-flags=3D(GstVideoMultiviewFlagsSet)0:ffffffff:/right-view=
-first/left-flipped/left-flopped/right-flipped/right-flopped/half-aspect/mi=
xed-mono,
> > > > pixel-aspect-ratio=3D(fraction)1/1, framerate=3D(fraction)25/1
> > > > /GstPipeline:pipeline0/GstDecodebin3:decodebin3-0.GstGhostPad:video=
_0.GstProxyPad:proxypad6:
> > > > caps =3D video/x-raw, format=3D(string)NV12, width=3D(int)1920,
> > > > height=3D(int)1080, interlace-mode=3D(string)progressive,
> > > > multiview-mode=3D(string)mono,
> > > > multiview-flags=3D(GstVideoMultiviewFlagsSet)0:ffffffff:/right-view=
-first/left-flipped/left-flopped/right-flipped/right-flopped/half-aspect/mi=
xed-mono,
> > > > pixel-aspect-ratio=3D(fraction)1/1, framerate=3D(fraction)25/1
> > > > /GstPipeline:pipeline0/GstDecodebin3:decodebin3-0/GstMultiQueue:mul=
tiqueue0:
> > > > min-interleave-time =3D 300000000
> > > > Redistribute latency...
> > > > /GstPipeline:pipeline0/GstDecodebin3:decodebin3-0/v4l2slh264dec:v4l=
2slh264dec0.GstPad:sink:
> > > > caps =3D video/x-h264, variant=3D(string)itu, framerate=3D(fraction=
)25/1,
> > > > width=3D(int)1920, height=3D(int)1080, chroma-format=3D(string)4:2:=
0,
> > > > bit-depth-luma=3D(uint)8, bit-depth-chroma=3D(uint)8,
> > > > parsed=3D(boolean)true, stream-format=3D(string)avc, alignment=3D(s=
tring)au,
> > > > profile=3D(string)high, level=3D(string)4,
> > > > codec_data=3D(buffer)01640028ffe1001a67640028acd940780227e584000003=
000400000300c83c60c65801000668ebe3cb22c0
> > > > New clock: GstSystemClock
> > > >
> > > > And it appears to stream, because the counter increases.  I haven't
> > > > checked the CPU utilization, but the fact that it shows v4l2slh264d=
ec
> > > > is good.
> > > >
> > > > Is there a way to know if/how the decoder is using the proper VPU? =
 I
> > > > assume if it wasn't using the proper one, it would fail, but was ju=
st
> > > > curious.
> > > >
> > >
> > > A few ways. You can check /proc/interrupts, which should have
> > > VPU activity.
> > >
> > > Or enable debug messages for the module,
> > > using the debug hantro parameter. V4L2 has debug messages
> > > that you can enable, see /sys/class/video4linux/video0/dev_debug.
> > >
> > > Instead of fakesink you can output to pngenc/jpegenc and check the ou=
tput
> > > is visually correct. If at all possible, the proper way is to use Flu=
ster,
> > > and report the score you get:
> > >
> > > https://github.com/fluendo/fluster
> > >
> >
> > I ran fluster on the VP8 decoder, but only 55/61 passed.
> >
> > ***********************************************************************=
*****************************
> > Running test suite VP8-TEST-VECTORS with decoder GStreamer-VP8-V4L2SL-G=
st1.0
> > Using 4 parallel job(s)
> > ***********************************************************************=
*****************************
> >
> > [TEST SUITE      ] (DECODER                    ) TEST VECTOR
> >     ... RESULT
> > ----------------------------------------------------------------------
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-00-comprehensive-004 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-00-comprehensive-001 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-00-comprehensive-002 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-00-comprehensive-003 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-00-comprehensive-005 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-00-comprehensive-006 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-00-comprehensive-007 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-00-comprehensive-008 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-00-comprehensive-011 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-00-comprehensive-009 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-00-comprehensive-012 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-00-comprehensive-013 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-00-comprehensive-014 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-00-comprehensive-010 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-00-comprehensive-016 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-00-comprehensive-017 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-00-comprehensive-018 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0) vp80-01-intra-1400
> >     ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0) vp80-01-intra-1416
> >     ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0) vp80-01-intra-1417
> >     ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0) vp80-01-intra-1411
> >     ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0) vp80-02-inter-1402
> >     ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0) vp80-02-inter-1412
> >     ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0) vp80-02-inter-1424
> >     ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-03-segmentation-01   ... Fail
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-03-segmentation-02   ... Fail
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-03-segmentation-03   ... Fail
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-03-segmentation-04   ... Fail
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-03-segmentation-1401 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0) vp80-02-inter-1418
> >     ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-03-segmentation-1403 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-03-segmentation-1407 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-03-segmentation-1408 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-03-segmentation-1409 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-03-segmentation-1413 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-03-segmentation-1415 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-03-segmentation-1425 ... Fail
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-03-segmentation-1426 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-03-segmentation-1427 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-03-segmentation-1432 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-03-segmentation-1435 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-03-segmentation-1436 ... Fail
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-00-comprehensive-015 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-03-segmentation-1441 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-03-segmentation-1437 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-04-partitions-1404   ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-03-segmentation-1442 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-04-partitions-1405   ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-04-partitions-1406   ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-05-sharpness-1428    ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-05-sharpness-1429    ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-05-sharpness-1431    ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-03-segmentation-1410 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-03-segmentation-1414 ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-05-sharpness-1430    ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-05-sharpness-1433    ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-05-sharpness-1438    ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-05-sharpness-1434    ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-05-sharpness-1439    ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-05-sharpness-1440    ... Success
> > [VP8-TEST-VECTORS] (GStreamer-VP8-V4L2SL-Gst1.0)
> > vp80-05-sharpness-1443    ... Success
> >
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > FAIL: vp80-03-segmentation-01 (GStreamer-VP8-V4L2SL-Gst1.0.VP8-TEST-VEC=
TORS)
> > ----------------------------------------------------------------------
> > Traceback (most recent call last):
> >   File "/root/gstreamer/fluster/fluster/test.py", line 104, in _test
> >     self.assertEqual(
> > AssertionError: 'db954c077b7a3f34a448ceaacf8f525c' !=3D
> > '8bbb396a9bdf8afa250d3b2e45e6b367'
> > - db954c077b7a3f34a448ceaacf8f525c
> > + 8bbb396a9bdf8afa250d3b2e45e6b367
> >  : vp80-03-segmentation-01
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > FAIL: vp80-03-segmentation-02 (GStreamer-VP8-V4L2SL-Gst1.0.VP8-TEST-VEC=
TORS)
> > ----------------------------------------------------------------------
> > Traceback (most recent call last):
> >   File "/root/gstreamer/fluster/fluster/test.py", line 104, in _test
> >     self.assertEqual(
> > AssertionError: '4d2d65efeee1c83772c33a13446bd1a4' !=3D
> > '1b2061d4a74549228769f8e292bcb15f'
> > - 4d2d65efeee1c83772c33a13446bd1a4
> > + 1b2061d4a74549228769f8e292bcb15f
> >  : vp80-03-segmentation-02
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > FAIL: vp80-03-segmentation-03 (GStreamer-VP8-V4L2SL-Gst1.0.VP8-TEST-VEC=
TORS)
> > ----------------------------------------------------------------------
> > Traceback (most recent call last):
> >   File "/root/gstreamer/fluster/fluster/test.py", line 104, in _test
> >     self.assertEqual(
> > AssertionError: '73d864433691f8db43257b88495ac8c3' !=3D
> > 'fd1eb6ebd7100995bad11042a9bea048'
> > - 73d864433691f8db43257b88495ac8c3
> > + fd1eb6ebd7100995bad11042a9bea048
> >  : vp80-03-segmentation-03
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > FAIL: vp80-03-segmentation-04 (GStreamer-VP8-V4L2SL-Gst1.0.VP8-TEST-VEC=
TORS)
> > ----------------------------------------------------------------------
> > Traceback (most recent call last):
> >   File "/root/gstreamer/fluster/fluster/test.py", line 104, in _test
> >     self.assertEqual(
> > AssertionError: '7f846c8bd7cdfe61f8542f382f9d8eeb' !=3D
> > '0c27a47c4fd8bbfce173d005bef8be6a'
> > - 7f846c8bd7cdfe61f8542f382f9d8eeb
> > + 0c27a47c4fd8bbfce173d005bef8be6a
> >  : vp80-03-segmentation-04
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > FAIL: vp80-03-segmentation-1425 (GStreamer-VP8-V4L2SL-Gst1.0.VP8-TEST-V=
ECTORS)
> > ----------------------------------------------------------------------
> > Traceback (most recent call last):
> >   File "/root/gstreamer/fluster/fluster/test.py", line 104, in _test
> >     self.assertEqual(
> > AssertionError: '96ffacf0c3eae59b58252be24a60e9b2' !=3D
> > '83e8a322e8ab23e60ba16430aacad827'
> > - 96ffacf0c3eae59b58252be24a60e9b2
> > + 83e8a322e8ab23e60ba16430aacad827
> >  : vp80-03-segmentation-1425
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > FAIL: vp80-03-segmentation-1436 (GStreamer-VP8-V4L2SL-Gst1.0.VP8-TEST-V=
ECTORS)
> > ----------------------------------------------------------------------
> > Traceback (most recent call last):
> >   File "/root/gstreamer/fluster/fluster/test.py", line 104, in _test
> >     self.assertEqual(
> > AssertionError: 'bfd17a557ee1ba347c755a18ce5a64a6' !=3D
> > '5bca61a733c1936205f82de1492a1b2b'
> > - bfd17a557ee1ba347c755a18ce5a64a6
> > + 5bca61a733c1936205f82de1492a1b2b
> >  : vp80-03-segmentation-1436
> >
> > Ran 55/61 tests successfully               in 12.104 secs
> >
> > I am not that familiar with this tool, but I assume failures are bad.
> > However these look like Python errors and not gst errors.
> >
> > The H264 decoder resulted in:
> >
> > Ran 85/135 tests successfully               in 57.821 secs
> >
> > I can provide the splat if you want. Those looked like gst errors,
> > because most of the error messages state the gst-launch-1.0 returned
> > non-zero exit status 1.
> >
> >
> > > It should be easy to use.
> >
> > It was.
> > >
> > > > I think I'll redo the patch without the RFC and without the H1 enco=
der
> > > > unless anyone has any objections.  I know I need to rebase on
> > > > linux-next anyway because the patches don't apply cleanly.  Is ther=
e a
> > > > specific branch I should use?  I don't know if this goes through
> > > > Shawn's IMX tree or the media tree (or a combination)
> > > >
> > >
> > > You should rebase on media's master branch:

> > >
> > > https://git.linuxtv.org/media_tree.git/log/
> >
> > I'll submit the patch with a cover letter with the results of the VP8
> > and H264 fluster test in the cover letter.  Is there a stateless
> > decoder for the VP9 decoder?  gst-inspect only shows the following
> > v4l2codecs.
> >
> >   v4l2slh264dec: V4L2 Stateless H.264 Video Decoder
> >   v4l2slmpeg2dec: V4L2 Stateless Mpeg2 Video Decoder
> >   v4l2slvp8alphadecodebin: VP8 Alpha Decoder
> >   v4l2slvp8dec: V4L2 Stateless VP8 Video Decoder
> >
> > thanks for all your help.  Hopefully we can get this integrated soon.
> >
>
> Adam,
>
> What deps did you install in order to get v4l2codecs building? I
> installed libgudev-1.0-dev based on Nicolas' suggestion and rebuilt
> (not sure if I needed to re-configure somehow) but there is still
> nothing in build/subprojects/gst-plugins-bad/sys/v4l2codecs/. A 'meson
> configure' tells me that v4l2codecs is set to 'auto' but I'm not sure
> how to find out what dependencies are needed or what may be missing.

Instead of building just a limited release of gstreamer, I had to
build the whole thing.

meson builddir
ninja -C builddir -j2

running with -j4 ran the imx8mm out of memory and slowed to a crawl to
the point where it didn't finish even after building overnight.

With that, I was able to execute gst-env.py to run streamer without
installing it.  In that environment, I was able to run fluster to get
the results I published.

adam
>
> Best regards,
>
> Tim
