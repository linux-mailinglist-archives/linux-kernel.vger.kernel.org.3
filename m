Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3598746712E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 05:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbhLCEhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 23:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbhLCEhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 23:37:42 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200B4C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 20:34:19 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id t34so2087822qtc.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 20:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=f5FPXMmNWQSNkHslhmFSl8+L94/eTXKX7QLK03aXbv0=;
        b=ZVT4cXx/9oAOrN1nHiI6rOMvhMfE2QohSgyItFbBdjXlQneuS0RreMEltiyGtg+3sK
         HYdOV9aBhXQegrLoR6DiXoBJYEnrRb89MVH0xV13Ip4aT+s6twIOcCYnMBDTcDUdz5n1
         qS/DkTTfs7D6A78zTUCpQBxOdggq3WdoJMq+b5cfXZzU8GZecXEvBiurJ9ZAgzDP4OBl
         nvxTF1itHEqe59fxvNHLZ1877TiTwnpk6yDczKvwoszBxjho6y/I1L/2xD1hOnBYZrBU
         6/+DaCAnHe/NYaWzLtWrG4+eeRfkXRk18sikw0QcJzMGDRxk51M8E7Sobb0Pt5eBrost
         swXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=f5FPXMmNWQSNkHslhmFSl8+L94/eTXKX7QLK03aXbv0=;
        b=7uF1jDbEIry68bW4XDFsHPS5Fxo1Y1QaXhVe8JBuYUzXR5RZmVvYNBRiYduXk/Dj/N
         HShSrR2Bv6eb2PrQyYemzPzQZj38MKdYMIa/vwvVI5vjuEURk0i4PgvwQ4rcqqiq1K1/
         VvNZ8Ms8mL1uYYbDZ2PqhhWhwfex0yYJc1eFs/cJXyHL4dD1mqlnEREPqt+v//8okk68
         PBAirukshHQLay3JLY8rMZATScaCd/kxnvDaDxjdFui59KTzjJhxDw20dkHoRBYabbON
         gMV2XjjIaGUWu7PUAF4ldxLcaOSaGEgZej23yzIpCONukFT7FBLQvREaE4TgvJ5uPvQE
         uYHw==
X-Gm-Message-State: AOAM53304dr9ynyAqRtp7iA8TPef9lsygzfJzFKaezc6LyTzjzOv3NOi
        KDhtemXGI4VS/uX+pRLNvxCybkLYAkxM++sr
X-Google-Smtp-Source: ABdhPJwci2tahO/lU3NSxsL47u+jp7MuTx7LwPQXxnpbhbAntgkFwBt1y1mJ027+stSa4r5VhBhB8w==
X-Received: by 2002:a05:622a:1055:: with SMTP id f21mr18169392qte.421.1638506057944;
        Thu, 02 Dec 2021 20:34:17 -0800 (PST)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id k23sm1340321qtm.49.2021.12.02.20.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 20:34:17 -0800 (PST)
Message-ID: <1403b14061883f746bda2998b2bf4a2676f9f328.camel@ndufresne.ca>
Subject: Re: [RFC 0/5] arm64: imx8mm: Enable Hantro VPUs
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Tim Harvey <tharvey@gateworks.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Adam Ford <aford173@gmail.com>,
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
Date:   Thu, 02 Dec 2021 23:34:14 -0500
In-Reply-To: <CAJ+vNU2we5mGXgYsR6CfimvFXZsc0zktR3fDa-h6RRa02jTT0g@mail.gmail.com>
References: <20211106183802.893285-1-aford173@gmail.com>
         <718f7f6d6cd564d031c1963f1590c62d549ae725.camel@ndufresne.ca>
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
         <CAAEAJfCpjk5nWWkJYjjDT-YEpJi4pTZqZbzp_if9OGC0HKspzw@mail.gmail.com>
         <CAJ+vNU2we5mGXgYsR6CfimvFXZsc0zktR3fDa-h6RRa02jTT0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 30 novembre 2021 à 11:28 -0800, Tim Harvey a écrit :
> On Tue, Nov 30, 2021 at 6:00 AM Ezequiel Garcia
> <ezequiel@vanguardiasur.com.ar> wrote:
> > 
> > Hi Tim,
> > 
> > On Mon, 29 Nov 2021 at 16:36, Tim Harvey <tharvey@gateworks.com> wrote:
> > > 
> > > On Mon, Nov 29, 2021 at 10:59 AM Adam Ford <aford173@gmail.com> wrote:
> > ..
> > > > 
> > > 
> > > Adam,
> > > 
> > > What deps did you install in order to get v4l2codecs building? I
> > > installed libgudev-1.0-dev based on Nicolas' suggestion and rebuilt
> > > (not sure if I needed to re-configure somehow) but there is still
> > > nothing in build/subprojects/gst-plugins-bad/sys/v4l2codecs/. A 'meson
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
> > subprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.p/gstv4l2codecvp9dec.c.o
> > FAILED: subprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.p/gstv4l2codecvp9dec.c.o
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
> > -I/usr/include/gudev-1.0 -fdiagnostics-color=always
> > -D_FILE_OFFSET_BITS=64 -Wall -Winvalid-pch -O2 -g -fvisibility=hidden
> > -fno-strict-aliasing -DG_DISABLE_DEPRECATED -Wmissing-prototypes
> > -Wdeclaration-after-statement -Wold-style-definition
> > -Wmissing-declarations -Wredundant-decls -Wwrite-strings -Wformat
> > -Wformat-security -Winit-self -Wmissing-include-dirs -Waddress
> > -Wno-multichar -Wvla -Wpointer-arith -fPIC -pthread -DHAVE_CONFIG_H
> > -MD -MQ subprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.p/gstv4l2codecvp9dec.c.o
> > -MF subprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.p/gstv4l2codecvp9dec.c.o.d
> > -o subprojects/gst-plugins-bad/sys/v4l2codecs/libgstv4l2codecs.so.p/gstv4l2codecvp9dec.c.o
> > -c ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c
> > ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c:92:3:
> > error: unknown type name ‘grefcount’
> >    grefcount ref_count;
> >    ^~~~~~~~~
> > ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c: In
> > function ‘gst_v4l2_codec_vp9_dec_picture_data_new’:
> > ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c:106:3:
> > warning: implicit declaration of function ‘g_ref_count_init’; did you
> > mean ‘g_cond_init’? [-Wimplicit-function-declaration]
> >    g_ref_count_init (&pic_data->ref_count);
> >    ^~~~~~~~~~~~~~~~
> >    g_cond_init
> > ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c: In
> > function ‘gst_v4l2_codec_vp9_dec_picture_data_ref’:
> > ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c:118:3:
> > warning: implicit declaration of function ‘g_ref_count_inc’; did you
> > mean ‘g_strv_contains’? [-Wimplicit-function-declaration]
> >    g_ref_count_inc (&data->ref_count);
> >    ^~~~~~~~~~~~~~~
> >    g_strv_contains
> > ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c: In
> > function ‘gst_v4l2_codec_vp9_dec_picture_data_unref’:
> > ../subprojects/gst-plugins-bad/sys/v4l2codecs/gstv4l2codecvp9dec.c:125:7:
> > warning: implicit declaration of function ‘g_ref_count_dec’
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
> 
> I see that v4l2codecs plugin v4l2slh264dec/v4l2slmpeg2dec/v4l2slvp8dec
> and these all can output video/x-raw NV12/YUY2 which kmssink should
> accept so I'm attempting the following :
> 
> # vp8 encode from x86
> gst-launch-1.0 -v videotestsrc ! video/x-raw,width=800,height=480 !
> vp8enc ! rtpvp8pay ! udpsink host=172.24.33.15 port=9001
> # vp8 decode on imx8mm@172.24.33.15 which has a 800x480 display
> [gst-main] root@focal-venice:~/gstreamer/build# gst-launch-1.0 -v
> udpsrc port=9001 caps = "application/x-rtp, media=(string)video,
> clock-rate=(int)90000, encoding-name=(string)VP8, payload=(int)96,
> ssrc=(uint)2745262155, timestamp-offset=(uint)2515032683,
> seqnum-offset=(uint)19579, a-framerate=(string)30" ! rtpvp8depay !
> v4l2slvp8dec ! kmssink
> Setting pipeline to PAUSED ...
> Pipeline is live and does not need PREROLL ...
> /GstPipeline:pipeline0/GstKMSSink:kmssink0: display-width = 800
> /GstPipeline:pipeline0/GstKMSSink:kmssink0: display-height = 480
> Pipeline is PREROLLED ...
> Setting pipeline to PLAYING ...
> /GstPipeline:pipeline0/GstUDPSrc:udpsrc0.GstPad:src: caps =
> application/x-rtp, media=(string)video, clock-rate=(int)90000,
> encoding-name=(string)VP8, payload=(int)96, ssrc=(uint)2745262155,
> timestamp-offset=(uint)2515032683, seqnum-offset=(uint)19579,
> a-framerate=(string)30
> New clock: GstSystemClock
> /GstPipeline:pipeline0/GstRtpVP8Depay:rtpvp8depay0.GstPad:sink: caps =
> application/x-rtp, media=(string)video, clock-rate=(int)90000,
> encoding-name=(string)VP8, payload=(int)96, ssrc=(uint)2745262155,
> timestamp-offset=(uint)2515032683, seqnum-offset=(uint)19579,
> a-framerate=(string)30
> /GstPipeline:pipeline0/GstRtpVP8Depay:rtpvp8depay0.GstPad:src: caps =
> video/x-vp8, framerate=(fraction)0/1, height=(int)480, width=(int)800,
> profile=(string)0
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
> using 'v4l2slvp8dec ! "video/x-raw,format=(string)NV12" ! kmssink' but
> I still get the negotiation error.
> 
> What interrupts should I be seeing in /proc/interrupts? I don't see
> anything vpu/hantro related there.
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

'stateless'. the rest is right.

> supported by the newer v4l2codecs plugin. I haven't been able to
> understand what kernel version/requirements the v4l2codecs plugin
> users/requires.

After H264 debacle with 5.9, 5.10 and 5.11 API break and GStreamer not getting
enough release to support all of these we started merging support for CODECs
only when the stable uAPI land. I made an exception for VP9 as it is already
applied in the media tree and didn't want to miss 1.20 release.

So to answer you question, it depends on when the CODEC uAPI landed.

> 
> I'm also trying to understand how we can get scaling/colorspace
> conversion on the IMX8M Mini. The IMX8M lacks an IPU... is there some
> way to utilize scaling/colorspace conversion from the 2D GPU bound to
> the etnaviv driver?

The concept of the mini, is that you would be using th encoder for anything that
isn't going to the display. So they only integrated the Hantro PP on the
encoder. Unfortunately, you'll have to be patient for mainline stateless encoder
support, we barely scratch the surface of this subject, but its being worked on.
Unlike the IMX8MQ, you don't have the option to output YUYV (packed yuv 4:2:2)
which would satisfy the 2D GPU support hoold to the DMABuf import path.

When the display driver gets ready and upstream (it's been only 2-3 years now),
you'll get linear NV12 support along with G2 compression support (this one is
not supported by the GPU, so it will be tricky to expose in userland). I don't
think the display support 4L4 tiles, but you GPU most likely can do with the
right shared and texelFetch() or vulkan equivalent if that exist on that target.

> 
> Best regards,
> 
> Tim

regards,
Nicolas

