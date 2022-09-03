Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE7D5ABD28
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 07:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiICFHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 01:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiICFHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 01:07:01 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F3EF4C85;
        Fri,  2 Sep 2022 22:06:58 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 145so3778704pfw.4;
        Fri, 02 Sep 2022 22:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=NwKC4kloq0c9pM7GuIGuE9jppd+OtPkgJw69prjYRz0=;
        b=HU/RF/GSy+GK+d1yXR+eWLwa8lPN9Usfv3zY93ZFn6uq/dWYoXUA0HRiF0YNP9estT
         nkttmahcAE/atXCfvy6bct4Hwa/EhiY9nV8BtDnncXuZsnwjwlz7YH1rG9aHgaKSSTLt
         WCV7TAvnsnTzd06eAY6g20vnsojjBa3Ne/EpKnXTC1Eu0ovQruF6zjx/NZBbXEwD7kCH
         29VosQXvAalJx2zXYGsuTj70rzwFtJHz9+qlQiF9tbU3C8JIE9KCDuezMGd4PdNdpDwO
         UEsYPPSuwZasV3ZzbIo1pWiX74JXq45oUBvmiX46WDiJuqA7AqYqgIU9P5Tivy598eRe
         pO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=NwKC4kloq0c9pM7GuIGuE9jppd+OtPkgJw69prjYRz0=;
        b=zZOvOHKRCw6rzGVJSq/L5oep0L092Ka3/qlxE/hSi2TBLUfAIA4SidP5wXNZvbHIW3
         kQws/jMrfniA7P1Z9xUe+19QJ74qPhk1fJ267GuHsdiHwn6YfoWgh/UEB+kx19bpsDZf
         IVzFtwAj0WgCnxOmwmeiYE0LR6xD6TnZvDRZj9cD8ZrP3O+7662SbWUUqHxYTUMfKvq6
         JHPJft1yszvhoAZBxDeZSchhK/2gz7RNT5zwlj502Do4JM+YBBjis1D8T33WFyhQD2Vn
         wsXL0Un5B78KA8bpJpNSBWS0arQoxktc33tGnXr9Tfpcq20VInXoXv5uRS5u3xJVOfeA
         TwaA==
X-Gm-Message-State: ACgBeo2PGa+USaM4zYWFBq9zBdMSx6ew+x7tuRPM3D3d6kRwxEODcxSL
        IAZThjIh8MVH9r4pWfXPfzI=
X-Google-Smtp-Source: AA6agR75iPyag9dLveUrxHRuF0KNfffiLVtoxZBTsOiuwDx9pjHfFnYTN/s2NMTQPKMP9pdw5lF0bQ==
X-Received: by 2002:a05:6a00:1889:b0:538:2efa:ff7a with SMTP id x9-20020a056a00188900b005382efaff7amr28574216pfh.2.1662181618136;
        Fri, 02 Sep 2022 22:06:58 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ea21:afd4:e65e:539c])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902784600b00172bf229dfdsm2583749pln.97.2022.09.02.22.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 22:06:57 -0700 (PDT)
Date:   Fri, 2 Sep 2022 22:06:54 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Raul Rangel <rrangel@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tim Van Patten <timvp@google.com>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/8] Input: elan_i2c - Use PM subsystem to manage wake irq
Message-ID: <YxLg7t2wyPajh/rY@google.com>
References: <20220830231541.1135813-1-rrangel@chromium.org>
 <20220830171332.1.Id022caf53d01112188308520915798f08a33cd3e@changeid>
 <CAJZ5v0h10wrurjYG50dA+pCfRtNDqN=c8odQ0p6HJRnOyJh7KA@mail.gmail.com>
 <Yw+yqbaTi04Ydgkq@google.com>
 <Yw+zo9eUQM+T1eYZ@google.com>
 <CAHQZ30C0Q39cSxTcfu3+6ZNj7iuRE6pJpc9aPdreFt4MNHqZRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQZ30C0Q39cSxTcfu3+6ZNj7iuRE6pJpc9aPdreFt4MNHqZRQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 08:17:23PM -0600, Raul Rangel wrote:
> On Wed, Aug 31, 2022 at 1:16 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Wed, Aug 31, 2022 at 12:12:41PM -0700, Dmitry Torokhov wrote:
> > > On Wed, Aug 31, 2022 at 08:01:12PM +0200, Rafael J. Wysocki wrote:
> > > > On Wed, Aug 31, 2022 at 1:16 AM Raul E Rangel <rrangel@chromium.org> wrote:
> > > > >
> > > > > The Elan I2C touchpad driver is currently manually managing the wake
> > > > > IRQ. This change removes the explicit enable_irq_wake/disable_irq_wake
> > > > > and instead relies on the PM subsystem. This is done by calling
> > > > > dev_pm_set_wake_irq.
> > > > >
> > > > > i2c_device_probe already calls dev_pm_set_wake_irq when using device
> > > > > tree, so it's only required when using ACPI. The net result is that this
> > > > > change should be a no-op. i2c_device_remove also already calls
> > > > > dev_pm_clear_wake_irq, so we don't need to do that in this driver.
> > > > >
> > > > > I tested this on an ACPI system where the touchpad doesn't have _PRW
> > > > > defined. I verified I can still wake the system and that the wake source
> > > > > was the touchpad IRQ GPIO.
> > > > >
> > > > > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > > >
> > > > I like this a lot [...]
> > >
> 
> > > I also like this a lot, but this assumes that firmware has correct
> > > settings for the interrupt... Unfortunately it is not always the case
> > > and I see that at least Chrome OS devices, such as glados line (cave, chell, sentry,
> > > ect) do not mark interrupt as wakeup:
> > >
> > > src/mainboard/google/glados/variants/chell/overridetree.cb
> > >
> > >                         chip drivers/i2c/generic
> > >                                 register "hid" = ""ELAN0000""
> > >                                 register "desc" = ""ELAN Touchpad""
> > >                                 register "irq" = "ACPI_IRQ_LEVEL_LOW(GPP_B3_IRQ)"
> > >                                 register "wake" = "GPE0_DW0_05"
> > >                                 device i2c 15 on end
> > >
> 
> So the above entry specifies the `wake` register. This generates an
> ACPI _PRW resource. The patch series will actually fix devices like
> this. Today without this patch series we get two wake events for a
> device. The ACPI wake GPE specified by the _PRW resource, and the
> erroneous GPIO wake event. But you bring up a good point.

Does this mean that the example that we currently have in coreboot
documentation (Documentation/acpi/devicetree.md) is not correct:

device pci 15.0 on
        chip drivers/i2c/generic
                register "hid" = ""ELAN0000""
                register "desc" = ""ELAN Touchpad""
                register "irq" = "ACPI_IRQ_WAKE_LEVEL_LOW(GPP_A21_IRQ)"
                register "wake" = "GPE0_DW0_21"
                device i2c 15 on end
        end
end # I2C #0

Doesn't in say that we have both GpioIrq and GPE wakeup methods defined
for the same device?

> 
> I wrote a quick and dirty script (https://0paste.com/391849) to parse
> the coreboot device tree entries. Open source firmware is great isn't
> it? ;)
> 
> $ find src/mainboard/google/ -iname '*.cb' | xargs awk -f touch.awk --
> src/mainboard/google/eve/devicetree.cb

...

> src/mainboard/google/sarien/variants/sarien/devicetree.cb
> 1
> chip drivers/i2c/generic
> register "hid" = ""ELAN0000""
> register "desc" = ""ELAN Touchpad""
> register "irq" = "ACPI_IRQ_EDGE_LOW(GPP_B3_IRQ)"
> register "probed" = "1"
> device i2c 2c on end
> end
> Total Touchpad: 202
> Total Wake: 195
> 
> Out of all the touchpads defined on ChromeOS it looks like only 4
> devices are missing a wake declaration. I omitted touchpanels because
> ChromeOS doesn't use those as a wake source. chromeos_laptop.c already
> defines some devices with i2c board_info and it sets the
> `I2C_CLIENT_WAKE` flag. I'm not sure if this is actually working as
> expected. `i2c_device_probe` requires a `wakeup` irq to be present in
> the device tree if the `I2C_CLIENT_WAKE` flag is set, but I'm assuming

No it does not. If there is no wakeup IRQ defined of_irq_get_byname()
will return an error and we'll take the "else if (client->irq > 0)"
branch and will set up client->irq as the wakeup irq.

> the device tree was missing wake attributes.

> 
> Anyway, patches 6, and 7 are the ones that drop the legacy behavior. I
> can figure out how to add the above boards to chromeos_laptop.c and
> get the wake attribute plumbed, or I can add something directly to the
> elan_i2c_core, etc so others can add overrides for their boards there.
> I'll also send out CLs to fix the device tree configs (not that we
> would run a FW qual just for this change).

My preference is to limit board-specific hacks in drivers if we can, so
adding missing properties to chromeos_laptop.c would be my preference.

Thanks.

-- 
Dmitry
