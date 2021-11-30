Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C50463F58
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343732AbhK3Ugf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbhK3Uge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:36:34 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EC4C061574;
        Tue, 30 Nov 2021 12:33:14 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v1so91865335edx.2;
        Tue, 30 Nov 2021 12:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QL8DqFydqkudTGF7sjhwJVPIEnBVZi3tgb6essVoleM=;
        b=SYR2TPwPktxnARv+4Z9kwPwvGJL8aSJExbGbryXoR0BepFW1t9weWka5qmU65imtyB
         jAoeZC6xvLoh+Pk3Hleeni2IIfFyZ13XHOs5bqUylOoVccWa+rMdH1zVEA8WXzgWqTdy
         jCGATVD3paH+JEUVUYRTjsS9CwJqJaz2wamMDGzFBoI7iHHVSO9TJRG3x5aB4/HlF65o
         FWrgmCeS9sQLa5qqDoUoLkh6Jg2/5IXeTCcPIco3sgUTcHeIRKgCExJ5CKJR0itg3/z2
         jEwxObCG0NPqqAG7qgdDDWzdq1WwbJ8tfIOMGQbutFFa7zrC1ltRKnwpRHjOLaztD5Wg
         itYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QL8DqFydqkudTGF7sjhwJVPIEnBVZi3tgb6essVoleM=;
        b=Pa5OMqAXUKxVr3LTpW1oiLP9nQFmV4bLHAA1u2wXdYjbUhZZ1LtKE1OQPA7qfUdScu
         0Y2yLHBZ4CFC3baZLQZcVcQ7vl+8fDwdaOkFnm0iZncgfmDAttVGeMh1oIlzd0gL+ngn
         8q4G0z6Y6Zs3tVGASbdamhz5Ifhbrvmfipp8HegDnwUF5edNc4AQksr048xMoIw8i4Cj
         jWs0K64ucOWejReWTeNGJVjxeflfDsV0urLUrTnhXjNqizsjVbkHEx+nCYnW9tv1xZT8
         xre/elf6c9YdFYKTu8E+n5jWbmHNs0h1/B/Unzofo26gKwGxAkEYYtv7QWVjLizhHRuD
         BV7Q==
X-Gm-Message-State: AOAM530mvn+oYeAat/rqeXAtX5Pd7rWzTNEGk7eMcuk2yMfdXGWHjNeQ
        2SPZ5ERHABnKj08/a4B1hnUkGfmrb5PvBuaXARg=
X-Google-Smtp-Source: ABdhPJx4A3V2IClmWmon6iqmMct+HZGlddaCwC482u4atVSL6VP4eK/GlAi2CF3042YpYPmqpXke/4NKObXgE7caLaE=
X-Received: by 2002:a17:907:160b:: with SMTP id hb11mr1660951ejc.336.1638304393019;
 Tue, 30 Nov 2021 12:33:13 -0800 (PST)
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
 <CAHCN7x+UMMP6RXsNm0=OC=UTQzh=RKqQo6B7FD5e4eoJAEfmpg@mail.gmail.com>
 <CAJ+vNU1epi9SwPMHkuDmKcb68RLemYF=bsp7AVnzz06zKc2efw@mail.gmail.com>
 <CAAEAJfCpjk5nWWkJYjjDT-YEpJi4pTZqZbzp_if9OGC0HKspzw@mail.gmail.com> <CAJ+vNU2we5mGXgYsR6CfimvFXZsc0zktR3fDa-h6RRa02jTT0g@mail.gmail.com>
In-Reply-To: <CAJ+vNU2we5mGXgYsR6CfimvFXZsc0zktR3fDa-h6RRa02jTT0g@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 30 Nov 2021 14:33:01 -0600
Message-ID: <CAHCN7xJrM9uZUnmx65uTxWEo6HAkjozd3kD3UoEv-pYd5DV4QA@mail.gmail.com>
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

On Tue, Nov 30, 2021 at 1:28 PM Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Tue, Nov 30, 2021 at 6:00 AM Ezequiel Garcia
> <ezequiel@vanguardiasur.com.ar> wrote:
> >
> > Hi Tim,
> >
> > On Mon, 29 Nov 2021 at 16:36, Tim Harvey <tharvey@gateworks.com> wrote:
> > >
> > > On Mon, Nov 29, 2021 at 10:59 AM Adam Ford <aford173@gmail.com> wrote=
:
> > ..
> > > >
> > >
> > > Adam,
> > >
> > > What deps did you install in order to get v4l2codecs building? I
> > > installed libgudev-1.0-dev based on Nicolas' suggestion and rebuilt
> > > (not sure if I needed to re-configure somehow) but there is still
> > > nothing in build/subprojects/gst-plugins-bad/sys/v4l2codecs/. A 'meso=
n
> > > configure' tells me that v4l2codecs is set to 'auto' but I'm not sure
> > > how to find out what dependencies are needed or what may be missing.
> > >
> >
> > At least in my case (Centps-derivative), this is what I've done:
> >
> > ...
> > gst-plugins-bad| Run-time dependency gudev-1.0 found: NO (tried
> > pkgconfig and cmake)
> >
> > Installed gudev ... and then:
> >
> > ...
> > gst-plugins-bad| Dependency gudev-1.0 found: YES 232 (cached)
> > ...
> > gst-plugins-bad 1.19.3.1
> >
> >     Plugins               : accurip, adpcmdec, adpcmenc, aiff, asfmux,
> > audiobuffersplit, audiofxbad, audiomixmatrix, audiolatency,
> > audiovisualizers, autoconvert, bayer,
> >                             camerabin, codecalpha, coloreffects,
> > debugutilsbad, dvbsubenc, dvbsuboverlay, dvdspu, faceoverlay,
> > festival, fieldanalysis, freeverb, frei0r,
> >                             gaudieffects, gdp, geometrictransform,
> > id3tag, inter, interlace, ivfparse, ivtc, jp2kdecimator, jpegformat,
> > rfbsrc, midi, mpegpsdemux,
> >                             mpegpsmux, mpegtsdemux, mpegtsmux, mxf,
> > netsim, rtponvif, pcapparse, pnm, proxy, legacyrawparse,
> > removesilence, rist, rtmp2, rtpmanagerbad,
> >                             sdpelem, segmentclip, siren, smooth,
> > speed, subenc, switchbin, timecode, transcode, videofiltersbad,
> > videoframe_audiolevel, videoparsersbad,
> >                             videosignal, vmnc, y4mdec, decklink, dvb,
> > fbdevsink, ipcpipeline, nvcodec, shm, v4l2codecs, hls, sctp
> >
> > GStreamer current master build fails. It's a known issue which will be
> > fixed today:
> >
> > [...]
> > [8/9] Compiling C object
> > subprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.p/gstv4l=
2codecvp9dec.c.o
> > FAILED: subprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.=
p/gstv4l2codecvp9dec.c.o
> > cc -Isubprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.p
> > -Isubprojects/gst-plugins-bad/sys/v4l2codecs
> > -I../subprojects/gst-plugins-bad/sys/v4l2codecs
> > -Isubprojects/gst-plugins-bad -I../subprojects/gst-plugins-bad
> > -Isubprojects/gstreamer/libs -I../subprojects/gstreamer/libs
> > -Isubprojects/gstreamer -I../subprojects/gstreamer
> > -Isubprojects/gst-plugins-bad/gst-libs
> > -I../subprojects/gst-plugins-bad/gst-libs
> > -Isubprojects/gst-plugins-base/gst-libs
> > -I../subprojects/gst-plugins-base/gst-libs -Isubprojects/orc
> > -I../subprojects/orc -Isubprojects/gstreamer/gst
> > -Isubprojects/gst-plugins-base/gst-libs/gst/video
> > -Isubprojects/gst-plugins-base/gst-libs/gst/pbutils
> > -Isubprojects/gst-plugins-base/gst-libs/gst/audio
> > -Isubprojects/gst-plugins-base/gst-libs/gst/tag
> > -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include
> > -I/usr/include/gudev-1.0 -fdiagnostics-color=3Dalways
> > -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -O2 -g -fvisibility=3Dhidd=
en
> > -fno-strict-aliasing -DG_DISABLE_DEPRECATED -Wmissing-prototypes
> > -Wdeclaration-after-statement -Wold-style-definition
> > -Wmissing-declarations -Wredundant-decls -Wwrite-strings -Wformat
> > -Wformat-security -Winit-self -Wmissing-include-dirs -Waddress
> > -Wno-multichar -Wvla -Wpointer-arith -fPIC -pthread -DHAVE_CONFIG_H
> > -MD -MQ subprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.=
p/gstv4l2codecvp9dec.c.o
> > -MF subprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.p/gs=
tv4l2codecvp9dec.c.o.d
> > -o subprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.p/gst=
v4l2codecvp9dec.c.o
> > -c ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c
> > ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c:92:3=
:
> > error: unknown type name =E2=80=98grefcount=E2=80=99
> >    grefcount ref_count;
> >    ^~~~~~~~~
> > ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c: In
> > function =E2=80=98gst_v4l2_codec_vp9_dec_picture_data_new=E2=80=99:
> > ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c:106:=
3:
> > warning: implicit declaration of function =E2=80=98g_ref_count_init=E2=
=80=99; did you
> > mean =E2=80=98g_cond_init=E2=80=99? [-Wimplicit-function-declaration]
> >    g_ref_count_init (&pic_data->ref_count);
> >    ^~~~~~~~~~~~~~~~
> >    g_cond_init
> > ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c: In
> > function =E2=80=98gst_v4l2_codec_vp9_dec_picture_data_ref=E2=80=99:
> > ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c:118:=
3:
> > warning: implicit declaration of function =E2=80=98g_ref_count_inc=E2=
=80=99; did you
> > mean =E2=80=98g_strv_contains=E2=80=99? [-Wimplicit-function-declaratio=
n]
> >    g_ref_count_inc (&data->ref_count);
> >    ^~~~~~~~~~~~~~~
> >    g_strv_contains
> > ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c: In
> > function =E2=80=98gst_v4l2_codec_vp9_dec_picture_data_unref=E2=80=99:
> > ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c:125:=
7:
> > warning: implicit declaration of function =E2=80=98g_ref_count_dec=E2=
=80=99
> > [-Wimplicit-function-declaration]
> >    if (g_ref_count_dec (&data->ref_count)) {
> >        ^~~~~~~~~~~~~~~
> > ninja: build stopped: subcommand failed.
> >
> > Hope this helps get you started!
> > Ezequiel
>
> Ezequiel and Nicolas,
>
> Thanks - I did manage to get gstreamer 1.19.3 built successfully with
> v4l2codecs finally by getting the correct dependencies. I've attempted
> to software encode from another system and decode/display on the IMX8M
> Mini but thus far have not been successful.

I will post a V2 last today with the Mini's post-processing removed.
Someone, I apologize that I forget who, mentioned it was fused out of
the Mini, so the testing I've been doing was with that removed and I
removed the H1 encoder since the Mini doesn't support JPEG encoding.

I don't understand the YAML very well, and I'm struggling with the
dt-bindings which is the main reason I havne't submitted a formal
patch yet.

To date, I have only tested with v4l2-compliance and with the fluster
app that was recommended.

>
> I see that v4l2codecs plugin v4l2slh264dec/v4l2slmpeg2dec/v4l2slvp8dec
> and these all can output video/x-raw NV12/YUY2 which kmssink should
> accept so I'm attempting the following :
>
> # vp8 encode from x86
> gst-launch-1.0 -v videotestsrc ! video/x-raw,width=3D800,height=3D480 !
> vp8enc ! rtpvp8pay ! udpsink host=3D172.24.33.15 port=3D9001
> # vp8 decode on imx8mm@172.24.33.15 which has a 800x480 display
> [gst-main] root@focal-venice:~/gstreamer/build# gst-launch-1.0 -v
> udpsrc port=3D9001 caps =3D "application/x-rtp, media=3D(string)video,
> clock-rate=3D(int)90000, encoding-name=3D(string)VP8, payload=3D(int)96,
> ssrc=3D(uint)2745262155, timestamp-offset=3D(uint)2515032683,
> seqnum-offset=3D(uint)19579, a-framerate=3D(string)30" ! rtpvp8depay !
> v4l2slvp8dec ! kmssink
> Setting pipeline to PAUSED ...
> Pipeline is live and does not need PREROLL ...
> /GstPipeline:pipeline0/GstKMSSink:kmssink0: display-width =3D 800
> /GstPipeline:pipeline0/GstKMSSink:kmssink0: display-height =3D 480
> Pipeline is PREROLLED ...
> Setting pipeline to PLAYING ...
> /GstPipeline:pipeline0/GstUDPSrc:udpsrc0.GstPad:src: caps =3D
> application/x-rtp, media=3D(string)video, clock-rate=3D(int)90000,
> encoding-name=3D(string)VP8, payload=3D(int)96, ssrc=3D(uint)2745262155,
> timestamp-offset=3D(uint)2515032683, seqnum-offset=3D(uint)19579,
> a-framerate=3D(string)30
> New clock: GstSystemClock
> /GstPipeline:pipeline0/GstRtpVP8Depay:rtpvp8depay0.GstPad:sink: caps =3D
> application/x-rtp, media=3D(string)video, clock-rate=3D(int)90000,
> encoding-name=3D(string)VP8, payload=3D(int)96, ssrc=3D(uint)2745262155,
> timestamp-offset=3D(uint)2515032683, seqnum-offset=3D(uint)19579,
> a-framerate=3D(string)30
> /GstPipeline:pipeline0/GstRtpVP8Depay:rtpvp8depay0.GstPad:src: caps =3D
> video/x-vp8, framerate=3D(fraction)0/1, height=3D(int)480, width=3D(int)8=
00,
> profile=3D(string)0
> ERROR: from element /GstPipeline:pipeline0/GstUDPSrc:udpsrc0: Internal
> data stream error.
> Additional debug info:
> ../subprojects/gstreamer/libs/gst/base/gstbasesrc.c(3127):
> gst_base_src_loop (): /GstPipeline:pipeline0/GstUDPSrc:udpsrc0:
> streaming stopped, reason not-negotiated (-4)
> Execution ended after 0:00:02.076839644
> Setting pipeline to NULL ...
> Freeing pipeline ...
>
> I'm getting the same thing when trying to use h264.
>
> I've never quite been able to grasp how to debug GStreamer's
> negotiation issues. If I end with fakesink it appears to decode so it
> must be the v4l2slvp8dec to kmssink. I tried forcing the pixel format
> using 'v4l2slvp8dec ! "video/x-raw,format=3D(string)NV12" ! kmssink' but
> I still get the negotiation error.
>
> What interrupts should I be seeing in /proc/interrupts? I don't see
> anything vpu/hantro related there.

I don't have my Mini with me right now, but with my current patch set
that I mentioned above, I am able to see the interrupts for the
video-codec@38300000 increase each time I run a test with fluster.


>
> I also want to make sure I have a basic understanding of the vpu
> drivers and usersapce on the IMX8M Mini. The IMX6Q/DL that I'm more
> familiar with has a vpu that is supported by the GStreamer video4linux
> plugin which shows the following (on GStreamer 1.16.2):
>   v4l2jpegenc: V4L2 JPEG Encoder
>   v4l2jpegdec: V4L2 JPEG Decoder
>   v4l2h264enc: V4L2 H.264 Encoder
>   v4l2mpeg4enc: V4L2 MPEG4 Encoder
>   v4l2mpeg4dec: V4L2 MPEG4 Decoder
>   v4l2mpeg2dec: V4L2 MPEG2 Decoder
>   v4l2h264dec: V4L2 H264 Decoder
> The IMX6Q/DL also has an IPU that has an M2M driver that provides the
> following for scaling/colorspace conversion:
>   v4l2convert: V4L2 Video Converter
>
> I believe what I'm reading is that the IMX8M Mini Hantro codecs are
> 'stateful' where more software is required to drive them and is
> supported by the newer v4l2codecs plugin. I haven't been able to
> understand what kernel version/requirements the v4l2codecs plugin
> users/requires.
>
> I'm also trying to understand how we can get scaling/colorspace
> conversion on the IMX8M Mini. The IMX8M lacks an IPU... is there some
> way to utilize scaling/colorspace conversion from the 2D GPU bound to
> the etnaviv driver?
>
> Best regards,
>
> Tim
