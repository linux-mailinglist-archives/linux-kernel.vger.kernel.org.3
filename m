Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E304AB307
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 02:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243429AbiBGBJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 20:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiBGBJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 20:09:00 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876FAC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 17:08:59 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id u25so6945472vkk.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 17:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=whkTZkcAuDcbJGPrqh9THCNcAMDNTLraM2IbA6AXLYc=;
        b=oBewaa1QShgxYy27YhJG+92yI2DIfnJBbv5gd+PrfKKmdc+ojdYxFlHCBMYuWnfMrQ
         CiSNHIdLKvzykI7Q8+8N7em9GX1v+TJWS1/5UwyqpkmK89y7gIX5XJac94YGlN7oFAc5
         01lgQ0wEZQ3edSycB8PIgov/BZIpvSbDczU50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=whkTZkcAuDcbJGPrqh9THCNcAMDNTLraM2IbA6AXLYc=;
        b=uSwVL/W7E0+Icl54hfN3PyBTvKFCFpfDCfN8waksM+0vW0xYKqFzrx+jjHsX1pudJz
         BXN+9HVQvOUx43ppna2OJV1oataTghQs2M5NQSQIrRYzxqxMBAMx2fQmVJk0O9jZUnJn
         basd4CRchGDecMz7NQXuSVFIgTCFGcC6hLN7oXLl5g3jbEYJ1S9jEw4zr82ZOONNWHip
         ds01ZabuevAIRQMTqwI0Q+e1e72kMqWZfaQYbJ4y0OfVTmC8O/jR8gPVIO3YlF+I3mUQ
         L1+ZTAeuD0TkV1Z3wxrK0gfcx5jBS4aEt74HN5hpk47t0NmuH5lBq4HH+M4dytKNF1YR
         8UKw==
X-Gm-Message-State: AOAM530IKG+1T/Fq9sG8J00/bbkFOjiea01Mbsihp5nigj8qgHZ8JboN
        pmjt4g8y1tPeg69BsJETlIrdAwpe+tJTPm0MjL0zhQ==
X-Google-Smtp-Source: ABdhPJzsI7bx22ICoQGYcUMKZTZZ60CfAzh2mwl5ohTsIW4o8Lo/dMD+YU7RykI+C3iFjqijhOzcBPe6kuVxUK7xzEI=
X-Received: by 2002:a05:6122:c98:: with SMTP id ba24mr4024910vkb.8.1644196137727;
 Sun, 06 Feb 2022 17:08:57 -0800 (PST)
MIME-Version: 1.0
References: <20220202044937.3187603-1-skyostil@chromium.org>
 <20220202044937.3187603-2-skyostil@chromium.org> <Yf1FySKp9bdbVNah@kroah.com>
In-Reply-To: <Yf1FySKp9bdbVNah@kroah.com>
From:   Sami Kyostila <skyostil@chromium.org>
Date:   Mon, 7 Feb 2022 12:08:46 +1100
Message-ID: <CAPuLczu1pfhhg6-=5cKbea1ZVrPoYS+W2BcPsgHoz-6jhV0iYA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drivers/misc: add a driver for HPS
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, dtor@chromium.org,
        arnd@arndb.de, evanbenn@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

la 5. helmik. 2022 klo 2.27 Greg KH (gregkh@linuxfoundation.org) kirjoitti:
>
> On Wed, Feb 02, 2022 at 03:49:37PM +1100, Sami Ky=C3=B6stil=C3=A4 wrote:
> > This patch introduces a driver for the ChromeOS screen privacy
> > sensor (aka. HPS). The driver supports a sensor connected to the I2C bu=
s
> > and identified as "GOOG0020" in the ACPI tables.
> >
> > When loaded, the driver exports the sensor to userspace through a
> > character device. This device only supports power management, i.e.,
> > communication with the sensor must be done through regular I2C
> > transmissions from userspace.
> >
> > Power management is implemented by enabling the respective power GPIO
> > while at least one userspace process holds an open fd on the character
> > device. By default, the device is powered down if there are no active
> > clients.
> >
> > Note that the driver makes no effort to preserve the state of the senso=
r
> > between power down and power up events. Userspace is responsible for
> > reinitializing any needed state once power has been restored.
> >
> > The device firmware, I2C protocol and other documentation is available
> > at https://chromium.googlesource.com/chromiumos/platform/hps-firmware.
> >
> > Signed-off-by: Sami Ky=C3=B6stil=C3=A4 <skyostil@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Removed custom ioctl interface.
> > - Reworked to use miscdev.
> >
> >  MAINTAINERS            |   6 ++
> >  drivers/misc/Kconfig   |  10 +++
> >  drivers/misc/Makefile  |   1 +
> >  drivers/misc/hps-i2c.c | 184 +++++++++++++++++++++++++++++++++++++++++
>
> Why isn't this in drivers/platform/chrome/ instead?

Only because I didn't realize that was a thing :) Will move it there instea=
d.

> And what can you do with this hardware when it is enabled?  What
> userspace tool uses it?

The hardware is basically an isolated computer vision sensor that
computes a high level inference result (e.g., whether there is a
person in the image) while making sure the raw sensor data (e.g.,
camera images) aren't accessible to the host. It's driven by a
userspace daemon (hpsd) which exposes this functionality to other
ChromeOS components through dbus. There are also some more
developer-oriented userspace tools for updating firmware, reading
debug registers, etc.

Source code for the userspace tools is available at
https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/hps, and
the sensor firmware is at
https://chromium.googlesource.com/chromiumos/platform/hps-firmware.

- Sami

>
> thanks,
>
> greg k-h
