Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A18585AF0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 17:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbiG3PQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 11:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiG3PQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 11:16:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3D41056F
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 08:16:09 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e15so8893418edj.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 08:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=6d+ycc7qXtxhS4npbdEsrK/vN/0sRNEBBmbeqlyXufg=;
        b=P0TMiqwDhd8by8yvDd/Sz0r/VhC0ZH8Y7nekdOikJIUt5rZ35AI/5G630+FHsxqYYF
         QzBQZhoUz8e9bkiAyH0Xf8bRv6nFXkr+J+t1tn9GvfLwEr4cWnu7oER/0YRDdipJVb1N
         FA/p1e1wgCdtkNB8XQUb9jyCURnPtMvviYCqixNurn/hgeqbC/Io2nJ1ivku8H7mBART
         Y5DnrIeCY67iMVU6IrN6dlMfrfoeORiveTDSzzS5YXwhM4L/Q6F2iC/mDrz5gYPLMMTQ
         Faa/3clEgsMvYGw5+54tjh/6btSBroakweciOGlM+/aPu9gIg2IpPZ29YiLE2CmGsTm2
         Nmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=6d+ycc7qXtxhS4npbdEsrK/vN/0sRNEBBmbeqlyXufg=;
        b=2ZyheXLkL+Pmlai1NezSYMAC5ejPrArEgHx4DRz9jEHUvUDUEaV3RCp4GqQTrEvqDv
         wnJ41ozbkr/YPecm86AoFMhZ8/LFcJCZ073U6JWbsoB7f0omtzw3cRPqcoHE6ME8O/O+
         9U1Sku/n9IsKV6VjoQEdO1IVUrwmnCqf6e7NQxTTLJEO4KvlTUqPn/xVDV5Fswb9KYFa
         XTk5M3+GQeJsykih7PZbhHSjiAMLZE6foFE/HOq1SUN1KioRkAh5YgfZvGeYaCLkke3E
         Ayr6S7D8eiz0UJBUkl65fziH+WA0HoazH7aXZiQzicgNIqC/OvDZOiMg6eIi8mfVZhi2
         BrTQ==
X-Gm-Message-State: ACgBeo0yhCZ/HP7moLJsWPHitK0GCSgvicVwp7FS+uqUKiLuXe9FLYJ4
        KKKySnkOIpNzz1/xlasodiaxcgDKIIyWSO6cO58=
X-Google-Smtp-Source: AA6agR50m5cLcwmzWZnTHbOke5eloAsFvg2RgpkIwddRz5csGWEmG2tLSCO8on2mbiFS79VU6AJxZ/XSFQeuSoyker8=
X-Received: by 2002:a50:bace:0:b0:43d:370a:e1c1 with SMTP id
 x72-20020a50bace000000b0043d370ae1c1mr5244948ede.193.1659194167564; Sat, 30
 Jul 2022 08:16:07 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 30 Jul 2022 10:15:56 -0500
Message-ID: <CAHCN7xJ=N1vWVTBjArskJ59fyaLzmAGWfc0E=_iGizrDNR_Udw@mail.gmail.com>
Subject: imx8mm lcdif->dsi->adv7535 no video, no errors
To:     dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

I am trying to test Jagan's patch series [1] to add support for the
samsung dsim bridge which is used on the imx8mm to output DSI video.
The DSIM gets the video from the mxsfb, and in my case, the DSI is
sent to the adv7535 for connecting to HDMI.

I have been able to get the device tree setup and I don't get any
errors.  The Linux system appears to think the video is connected as
determined by modetest:

trying to open device 'mxsfb-drm'...done
Encoders:
id crtc type possible crtcs possible clones
34 33 none 0x00000001 0x00000001

Connectors:
id encoder status name size (mm) modes encoders
35 34 connected HDMI-A-1        620x340 29 34
  modes:
index name refresh (Hz) hdisp hss hse htot vdisp vss vse vtot
  #0 1920x1080 60.00 1920 2008 2052 2200 1080 1084 1089 1125 148500
flags: nhsync, nvsync; type: driver
  #1 1920x1080 60.00 1920 2008 2052 2200 1080 1084 1089 1125 148500
flags: phsync, pvsync; type: driver
  #2 1920x1080 59.94 1920 2008 2052 2200 1080 1084 1089 1125 148352
flags: phsync, pvsync; type: driver
  #3 1920x1080 50.00 1920 2448 2492 2640 1080 1084 1089 1125 148500
flags: phsync, pvsync; type: driver
  #4 1680x1050 59.88 1680 1728 1760 1840 1050 1053 1059 1080 119000
flags: phsync, nvsync; type: driver
  #5 1280x1024 75.02 1280 1296 1440 1688 1024 1025 1028 1066 135000
flags: phsync, pvsync; type: driver
  #6 1280x1024 60.02 1280 1328 1440 1688 1024 1025 1028 1066 108000
flags: phsync, pvsync; type: driver
  #7 1440x900 59.90 1440 1488 1520 1600 900 903 909 926 88750 flags:
phsync, nvsync; type: driver
  #8 1280x960 60.00 1280 1376 1488 1800 960 961 964 1000 108000 flags:
phsync, pvsync; type: driver
  #9 1280x720 60.00 1280 1390 1430 1650 720 725 730 750 74250 flags:
phsync, pvsync; type: driver
  #10 1280x720 59.94 1280 1390 1430 1650 720 725 730 750 74176 flags:
phsync, pvsync; type: driver
  #11 1280x720 50.00 1280 1720 1760 1980 720 725 730 750 74250 flags:
phsync, pvsync; type: driver
  #12 1024x768 75.03 1024 1040 1136 1312 768 769 772 800 78750 flags:
phsync, pvsync; type: driver
  #13 1024x768 70.07 1024 1048 1184 1328 768 771 777 806 75000 flags:
nhsync, nvsync; type: driver
  #14 1024x768 60.00 1024 1048 1184 1344 768 771 777 806 65000 flags:
nhsync, nvsync; type: driver
  #15 832x624 74.55 832 864 928 1152 624 625 628 667 57284 flags:
nhsync, nvsync; type: driver
  #16 800x600 75.00 800 816 896 1056 600 601 604 625 49500 flags:
phsync, pvsync; type: driver
  #17 800x600 72.19 800 856 976 1040 600 637 643 666 50000 flags:
phsync, pvsync; type: driver
  #18 800x600 60.32 800 840 968 1056 600 601 605 628 40000 flags:
phsync, pvsync; type: driver
  #19 800x600 56.25 800 824 896 1024 600 601 603 625 36000 flags:
phsync, pvsync; type: driver
  #20 720x576 50.00 720 732 796 864 576 581 586 625 27000 flags:
nhsync, nvsync; type: driver
  #21 720x480 60.00 720 736 798 858 480 489 495 525 27027 flags:
nhsync, nvsync; type: driver
  #22 720x480 59.94 720 736 798 858 480 489 495 525 27000 flags:
nhsync, nvsync; type: driver
  #23 640x480 75.00 640 656 720 840 480 481 484 500 31500 flags:
nhsync, nvsync; type: driver
  #24 640x480 72.81 640 664 704 832 480 489 492 520 31500 flags:
nhsync, nvsync; type: driver
  #25 640x480 66.67 640 704 768 864 480 483 486 525 30240 flags:
nhsync, nvsync; type: driver
  #26 640x480 60.00 640 656 752 800 480 490 492 525 25200 flags:
nhsync, nvsync; type: driver
  #27 640x480 59.94 640 656 752 800 480 490 492 525 25175 flags:
nhsync, nvsync; type: driver
  #28 720x400 70.08 720 738 846 900 400 412 414 449 28320 flags:
nhsync, pvsync; type: driver
  props:
1 EDID:
flags: immutable blob
blobs:

value:
00ffffffffffff0005e37928b1000000
2b190103803e22782a08a5a2574fa228
0f5054bfef00d1c0b300950081808140
81c0010101014dd000a0f0703e803020
35006d552100001aa36600a0f0701f80
302035006d552100001a000000fc0055
3238373947360a2020202020000000fd
0017501e8c3c000a2020202020200114
020333f14c9004031f1301125d5e5f60
6123090707830100006d030c00100039
7820006001020367d85dc401788003e3
0f000c011d007251d01e206e2855006d
552100001e8c0ad08a20e02d10103e96
006d55210000184d6c80a070703e8030
203a006d552100001aa36600a0f0701f
80302035006d552100001a00000000ea
2 DPMS:
flags: enum
enums: On=0 Standby=1 Suspend=2 Off=3
value: 0
5 link-status:
flags: enum
enums: Good=0 Bad=1
value: 0
6 non-desktop:
flags: immutable range
values: 0 1
value: 0
4 TILE:
flags: immutable blob
blobs:

value:

CRTCs:
id fb pos size
33 37 (0,0) (1920x1080)
  #0 1920x1080 60.00 1920 2008 2052 2200 1080 1084 1089 1125 148500
flags: nhsync, nvsync; type: driver
  props:
24 VRR_ENABLED:
flags: range
values: 0 1
value: 0

Planes:
id crtc fb CRTC x,y x,y gamma size possible crtcs
31 33 37 0,0 0,0 0        0x00000001
  formats: RG16 XR24
  props:
8 type:

flags: immutable enum
enums: Overlay=0 Primary=1 Cursor=2
value: 1
30 IN_FORMATS:
flags: immutable blob
blobs:

value:
01000000000000000200000018000000
01000000200000005247313658523234
03000000000000000000000000000000
0000000000000000
in_formats blob decoded:
RG16:  LINEAR
XR24:  LINEAR

Frame buffers:
id size pitch

Unfortunately, there is no video in my monitor, and my monitor states
there is no signal.

If I use NXP's downstream kernel, this same hardware configuration
works fine and I can see the video.

I have checked the clk_summary, and the working and non-working
conditions both have clock rates that are the same for DSI, LCDIF and
related items.  The power domains connected to the lcdif and the dsi
show they are active.

Since I go no errors, and  Linux looks like it's happy, I was hoping
someone from who better understands the interconnections between all
these bridge layers might be able to offer a suggestion of something
to investigate and/or try.

The kernel repo I am using is from Jagan located here:

[1] - https://github.com/openedev/kernel

I am not convinced it's a device tree issue since I get no errors when
the drivers enumerate, but I can provide my device tree updates if
that helps.

adam
