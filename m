Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CED59F907
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbiHXMII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237166AbiHXMHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:07:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273AD5C378
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661342832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AeYGphsYaVysqdpNVQxIko5rHJ03NgytZ1v+ZAbY3jI=;
        b=S045hfGWHeZt5jFxr8bSWHsfnS7CkAC8V9YTS69Q3e2P7vDW/D7ZdxF4mD5FHrUBYkymYd
        o6540/LsVvCp7DknNg6PPjps6qdsnT03KPXL4qH8yBXnBhY+mssWL1i5n2mNbdmWPyY771
        Up1tbxtlmtvHkspACLiAoxEHn64kb/U=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-346-qxsm8BgdMfuJR8qE8wzVWg-1; Wed, 24 Aug 2022 08:07:11 -0400
X-MC-Unique: qxsm8BgdMfuJR8qE8wzVWg-1
Received: by mail-qk1-f200.google.com with SMTP id bs43-20020a05620a472b00b006bb56276c94so14612518qkb.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=AeYGphsYaVysqdpNVQxIko5rHJ03NgytZ1v+ZAbY3jI=;
        b=6LxQU0mzfLbzZyG+m6b0S8+hbrDW/CLUiIbudl2QUeXhzIxGAcewCPmTOnLLx3/0il
         ZELGTKBKc7IGNg8pGFSRAZkepkIxhdql+rQMoMyIK8nXwlPBmhfazPQrq3woQS/KZJ8s
         QQLn8EpPk9KHgrkLLPQR4Wmg7OVCWT2O77Sc5Oywi6SZIiMqdJmw2eiv4uHMyefO7wcD
         SY1rHKphYRyslZuDd+oMAaTRbtYkl4ttelPKiw8vVbOWHsFDhFiZ/5pLN8rj38GnB+hv
         FI13aRxofVetuCVYleey4tVPImEKMA8zUR+HEMSYH1UZIAkgZpRid/13zKDCYD+H783y
         yfjg==
X-Gm-Message-State: ACgBeo1lxPeVUN3brJzKZW+rXaGX8nSexSF2jKZ5nRUnYfe9IAWx+dqy
        KSuANvQVAhugFVMQe0A8yBusr22hSwhfZCrDYQmOsCVfmUr6Ml/wqIRlrPuyGCpHJ1bHZiwLCsO
        jGvsxaHuGaWv40EzhAL7BLLdH/fr++JRCK2qKaR0g
X-Received: by 2002:a05:6214:226e:b0:496:eb01:9f94 with SMTP id gs14-20020a056214226e00b00496eb019f94mr10889449qvb.39.1661342830801;
        Wed, 24 Aug 2022 05:07:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4d2wBhwjC2bIl7Bhe3ejTHEdDlN2gNBDztY37D0ut3PrpAYVa6lZ3/LJBCgsAqsf9mj5/AE7icrYIIp8ZkiwI=
X-Received: by 2002:a05:6214:226e:b0:496:eb01:9f94 with SMTP id
 gs14-20020a056214226e00b00496eb019f94mr10889428qvb.39.1661342830536; Wed, 24
 Aug 2022 05:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220823174158.45579-1-cmirabil@redhat.com> <fc54a7a3-c67b-79ab-5e87-d468695e5553@i2se.com>
In-Reply-To: <fc54a7a3-c67b-79ab-5e87-d468695e5553@i2se.com>
From:   Charles Mirabile <cmirabil@redhat.com>
Date:   Wed, 24 Aug 2022 08:06:59 -0400
Message-ID: <CABe3_aFJ0gkLDFB9k5FEn1SmupbLEKxAn8y=WTt-Rc0xUEK4Dw@mail.gmail.com>
Subject: Re: [PATCH v10 0/6] Raspberry Pi Sense HAT driver
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Nicolas Saenz Julienne <nicolassaenzj@gmail.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        rh-kdlp@googlegroups.com, Joel Slebodnick <jslebodn@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 5:30 PM Stefan Wahren <stefan.wahren@i2se.com> wrot=
e:
>
> Hi Charles,
>
> + Maxime & Noralf
>
> Am 23.08.22 um 19:41 schrieb Charles Mirabile:
> > This patch series adds a set of drivers for operating the Sense HAT
> > peripheral device. This board is an add on for the Raspberry Pi that is
> > designed to connect using the GPIO connector and communicate via I2C.
> thanks for sending a new version of this series.
> >
> > It features:
> >       - a joystick
> >       - an 8x8 RGB LED matrix display
> >       - a whole bunch of environmental sensors with their own drivers
> >         (those are already in upstream Linux)
> >
> > This is a refactor of the work of Serge Schneider, the author of a
> > version of this driver that is currently in the Raspberry Pi downstream
> > kernel. We modified his code to make it suitable for upstream Linux.
> >
> > A couple of tests are available for the driver in the test folder in
> > this repo: https://github.com/underground-software/sensehat.git
> >       - sensehat_joystick_test logs the input events from the
> >         joystick to the console
> >       - sensehat_display_test displays various solid colors on
> >         the LED panel.
> >       - full_sensehat_test displays a single lit cell that can be
> >         moved with the joystick. Pressing the joystick ends the
> >         program.
> >
> > For more information about the Sense HAT, visit:
> > https://www.raspberrypi.org/products/sense-hat/
> >
> > Changes since v9:
> >       - The driver for the sensehat joystick was accepted upstream so
> >         it is no longer included in this patchset.
> >       - Some of the people involved in the development of earlier
> >         versions of these patches are no longer involved in the project
> >         so they have been removed from the list of maintainers and the
> >         patches.
> >       - The code is completely unchanged and so based on the discussion=
s
> >         from version 9 of the patches, it should be ready to be merged.
> >
> > My appologies for the long delay between v9 and v10 especially given th=
e
> > fact that there are no changes to the code. We appreciate the maintaine=
rs'
> > patience and guidance throughout all 10 versions of this sensehat patch=
set,
> > and we are excited for this driver to hopefully be fully accepted.
> >
> > Best - Charlie
> >
> > Co-developed-by: Joel Slebodnick <jslebodn@redhat.com>
> > Signed-off-by: Joel Slebodnick <jslebodn@redhat.com>
> > Co-developed-by: Joel Savitz <jsavitz@redhat.com>
> > Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> > Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> >
> > Charles Mirabile (5):
> >    drivers/mfd: sensehat: Add Raspberry Pi Sense HAT to simple_mfd_i2c
> AFAIK Lee Jones has a new kernel.org address the old linaro address
> shouldn't be used anymore. We don't get any further without him.
oops - my bad. Copied the old one from the previous CC list, but I see
the new one was being output properly by get_maintainer.pl, I just
wasn't paying enough attention
> >    drivers/auxdisplay: sensehat: Raspberry Pi Sense HAT display driver
> We don't have an Ack for this display driver. Maybe we should ask Maxime
> Ripard and Noralf Tr=C3=B8nnes especially Pavel Machek had concerns about=
 the
> right subsystem?
I just looked back at the comments from Pavel on v9. I had meant to
reply to him, and I actually drafted something but it got lost in the
shuffle and I never sent it (also my bad).
The driver is an fbdev in the raspberry pi tree, and that is where we
started when upstreaming, but right from the outset we were told that
it couldn't be an fbdev since that subsystem is being deprecated
the replacement is the DRM subsystem, but (as Matthias Brugger
suggests) that is probably overkill for an 8x8 display. Does that
settle the subsystem question?
Also, Is Matthias's review acceptable, or do we need someone else's
ack? It was my understanding based on his comments on v9 that Miguel
Ojeda was also basically ready to ack it, but I don't want to speak
for him.
> >    dt-bindings: mfd: sensehat: Add Raspberry Pi Sense HAT schema
> >    MAINTAINERS: Add sensehat driver authors to MAINTAINERS
> >    DO NOT MERGE: full sensehat device tree overlay for raspberry pi 4
>
> In case you want to send a new version it would be nice to enable the
> driver in bcm2835_defconfig for better test coverage. But this is not a
> show stopper.
Since I am going to have to send a v11 to fix Lee's email address I
will look into this. Is it as simple as adding another patch that puts
CONFIG_SENSEHAT_DISPLAY=3Dy into the next version?
Presumably I would also want to enable CONFIG_JOYSTICK_SENSEHAT right?
Do I have to do anything special since both of those options have
decencies (namely CONFIG_I2C for both and CONFIG_INPUT for the latter,
and both select MFD_SIMPLE_MFD_I2C)?
>
> Best regards
>
> >
> >   .../raspberrypi,sensehat-display.yaml         |  26 +++
> >   .../input/raspberrypi,sensehat-joystick.yaml  |  31 +++
> >   .../bindings/mfd/raspberrypi,sensehat.yaml    |  57 +++++
> >   MAINTAINERS                                   |  10 +
> >   drivers/auxdisplay/Kconfig                    |   8 +
> >   drivers/auxdisplay/Makefile                   |   1 +
> >   drivers/auxdisplay/sensehat-display.c         | 205 +++++++++++++++++=
+
> >   drivers/mfd/simple-mfd-i2c.c                  |   1 +
> >   sensehat.dtbs                                 |  52 +++++
> >   9 files changed, 391 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/auxdisplay/raspb=
errypi,sensehat-display.yaml
> >   create mode 100644 Documentation/devicetree/bindings/input/raspberryp=
i,sensehat-joystick.yaml
> >   create mode 100644 Documentation/devicetree/bindings/mfd/raspberrypi,=
sensehat.yaml
> >   create mode 100644 drivers/auxdisplay/sensehat-display.c
> >   create mode 100644 sensehat.dtbs
> >
>

