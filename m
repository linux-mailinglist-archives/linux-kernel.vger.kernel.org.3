Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6313959F999
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbiHXMTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237364AbiHXMSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:18:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4EF76957
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661343473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x0oQbAJQx0RYA6YfmxA0+KWyM1KLvCU7j/P0WaiG5YQ=;
        b=WM6txYUHyDruoOhXXt39KZR0RM0v/btNXTuQJ0YsAXqda0bVA3ueAlA6Q9uF0yYbZoBL+9
        C0AYhgbYLLYBdvuzdgZmgSHvfb6VzRMG+Q1mES4YZ6b/SnW2VvhjN2UnZu+HKZl2k0sV0N
        cto2aTshnAHbcNc1/fp4tPq+ELYEPPQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-zfLTVWHBOzy280SNpityOw-1; Wed, 24 Aug 2022 08:17:52 -0400
X-MC-Unique: zfLTVWHBOzy280SNpityOw-1
Received: by mail-qt1-f200.google.com with SMTP id h13-20020ac87d4d000000b00342f6c363afso12666566qtb.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=x0oQbAJQx0RYA6YfmxA0+KWyM1KLvCU7j/P0WaiG5YQ=;
        b=IDg3BvGcFIUe+53X13r8pgja5izyjzl1LAbeOcnPLf1hQEG+zPR/xXz+XdGo3jfcQ5
         58gRVSPp9jCk5APM4rHcdoBr9EVK2fvNeHb6dxKhtHSP5Nn8BTcgsm8cTMLiHKwmfEi+
         SOke9q616aVK8JMHxiaTH9g2e8XAFxDltqu95IMUUiBqEPQB6sD8YH8LUiq/OSYiP7Jc
         nbpxFMqOH4pGB2Rja4orLsjpps8HhhdfAjTgKiB67/GeIMErJKlYo3XFE7BFNApqv9ij
         LCbIrioTWRq7L8J6kaIyU7tY0ki1iU3evJ/zX2UsorhbopR2jlzzueagQ9Z1PswEcA7x
         M4vQ==
X-Gm-Message-State: ACgBeo2TzO24iUZYoq27HIBJlxwF2Gb2RKnOBAZo/3+b2s1K78gD5Sl4
        6I90CY43IZx/yrQm0UuLcaV+5+g33lEzKm5OhA/NileUEXIP2B9U9kOizOCwBhGxgfRLe0XFNnf
        cKe/E0Ip1dhOQN9sd64AkMX/1T9KPsJunkAGInjU/
X-Received: by 2002:ae9:c112:0:b0:6bb:e7de:1bdd with SMTP id z18-20020ae9c112000000b006bbe7de1bddmr15045986qki.338.1661343471580;
        Wed, 24 Aug 2022 05:17:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4/j5bjT2lx+R+LJ0ANV21z5SfJ3ABV+8JW42PuqWkY35gR/ji+qKoXZ0N2DMh5g2KHlgvGk7je1zagW1Nz2tE=
X-Received: by 2002:ae9:c112:0:b0:6bb:e7de:1bdd with SMTP id
 z18-20020ae9c112000000b006bbe7de1bddmr15045959qki.338.1661343471291; Wed, 24
 Aug 2022 05:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220823174158.45579-1-cmirabil@redhat.com> <369a74dd-e357-a352-fb17-fa5aa3726e0e@suse.com>
In-Reply-To: <369a74dd-e357-a352-fb17-fa5aa3726e0e@suse.com>
From:   Charles Mirabile <cmirabil@redhat.com>
Date:   Wed, 24 Aug 2022 08:17:40 -0400
Message-ID: <CABe3_aGqn1PZCq1xZuK059EK=AtB1umHAxtMPzbFepQBvq2d1w@mail.gmail.com>
Subject: Re: [PATCH v10 0/6] Raspberry Pi Sense HAT driver
To:     Matthias Brugger <mbrugger@suse.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nicolassaenzj@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        rh-kdlp@googlegroups.com, Joel Slebodnick <jslebodn@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 7:28 AM Matthias Brugger <mbrugger@suse.com> wrote:
>
>
>
> On 23/08/2022 19:41, Charles Mirabile wrote:
> > This patch series adds a set of drivers for operating the Sense HAT
> > peripheral device. This board is an add on for the Raspberry Pi that is
> > designed to connect using the GPIO connector and communicate via I2C.
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
>
> I'd would expect the patches to honor their involvement in the past, but if they
> are fine from being dropped, I will not object...
Since I am sending a v11 I will try to get in touch with them and see
if they want
to be involved and find proper emails (they no longer work at Red Hat).
I will also look into how much / to which parts of the code they
contributed and see
where it is appropriate to include them if they do want to be
included. I should have
done this before sending v10, but I didn't have the proper emails and
wasn't sure
about the correct etiquette.
>
> Regards,
> Matthias
>
> >       - The code is completely unchanged and so based on the discussions
> >         from version 9 of the patches, it should be ready to be merged.
> >
> > My appologies for the long delay between v9 and v10 especially given the
> > fact that there are no changes to the code. We appreciate the maintainers'
> > patience and guidance throughout all 10 versions of this sensehat patchset,
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
> >    drivers/auxdisplay: sensehat: Raspberry Pi Sense HAT display driver
> >    dt-bindings: mfd: sensehat: Add Raspberry Pi Sense HAT schema
> >    MAINTAINERS: Add sensehat driver authors to MAINTAINERS
> >    DO NOT MERGE: full sensehat device tree overlay for raspberry pi 4
> >
> >   .../raspberrypi,sensehat-display.yaml         |  26 +++
> >   .../input/raspberrypi,sensehat-joystick.yaml  |  31 +++
> >   .../bindings/mfd/raspberrypi,sensehat.yaml    |  57 +++++
> >   MAINTAINERS                                   |  10 +
> >   drivers/auxdisplay/Kconfig                    |   8 +
> >   drivers/auxdisplay/Makefile                   |   1 +
> >   drivers/auxdisplay/sensehat-display.c         | 205 ++++++++++++++++++
> >   drivers/mfd/simple-mfd-i2c.c                  |   1 +
> >   sensehat.dtbs                                 |  52 +++++
> >   9 files changed, 391 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml
> >   create mode 100644 Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml
> >   create mode 100644 Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
> >   create mode 100644 drivers/auxdisplay/sensehat-display.c
> >   create mode 100644 sensehat.dtbs
> >
>

