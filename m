Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A655A5AF3D9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 20:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiIFSk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 14:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiIFSk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 14:40:56 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADFF844CE;
        Tue,  6 Sep 2022 11:40:53 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f24so12179595plr.1;
        Tue, 06 Sep 2022 11:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=tgHh2ph22Jv6rRWgNYXU0UHpDwq3vmbUOTv1DU4klCs=;
        b=WQolEIW04aKyuKAwsvbpfrsrEtkiXogj8xXOV7tRNr+SHRkJtbvkAO+AdIzXU639Sd
         q+Gof3EsntSuPIxMbo75HpzDxsuqf3ihlQmXhQfhGb8rT77Orjkz44pAQNDc0Yq8jvRv
         gMUHEDGVUgfDmPFd72Z0BeEi/qPjxebOTxvjw4Ib39TqeVO9Zi734y6hFB/YEp/2lDS8
         kNTf9/c5pqkttKHpkayiR4oLsOQfgtx8YEshb6xytC+1B1PWKKAs7/5t+7hcz8gdPGIk
         kC/JWFMEtsOBrh/udoaQGQZ6cyCpWT/UmJHJrXihAQ1h/SRMaQirUSKmG/lisqDE0QRi
         TZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=tgHh2ph22Jv6rRWgNYXU0UHpDwq3vmbUOTv1DU4klCs=;
        b=ANJcXArBZo/6NOmIT2XNiR8nKc4WiDH4KQn/WdjLfLdzyB/AJRI0vrlutSB7FXR7Fp
         lQJH9vheT55eIAyWrYTEkr8VASbTcRiMluPj8WYy7TfhS6UviF8pZS/WValXNhqLm8ot
         YfuKuim6ioLFh4YAHN0PQ0UCmCjJeU8YK0SXeyMWJVMQyNDBJzKlEVZtNRB8cQynb0jN
         8gt8Fd61jSVOydXjVE4xKKDFWPKPfxrSwyeQEsIxdVuReQrb8JMG4EF5vCOcuKTAp9v3
         qqHjzIIAjThz+wQ2Zo6OcY+t9HoAG2hZCDqIN8RTFJxTmKQ4BodSgXb7iQtMlkoffUIC
         msjw==
X-Gm-Message-State: ACgBeo33CWSTsN2547In20F3C7FV7cw7Z/pB3ds7kdzmWVW0mK0s+TKA
        EMP5aJV7O0zYosLiQPqoW/Q=
X-Google-Smtp-Source: AA6agR7fPfs0TGD27wNdb0Feb+O4VaJjDXGGS/c5D2FQsoEOSxaWs6JIyFGGnPU+lNG0tFU13nvfEA==
X-Received: by 2002:a17:90b:3b4d:b0:1fe:4d47:76ed with SMTP id ot13-20020a17090b3b4d00b001fe4d4776edmr26862361pjb.150.1662489653216;
        Tue, 06 Sep 2022 11:40:53 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:1190:fbfa:ae95:111c])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c24500b0016dc78d0153sm2310051plg.296.2022.09.06.11.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 11:40:52 -0700 (PDT)
Date:   Tue, 6 Sep 2022 11:40:50 -0700
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
Message-ID: <YxeUMg2DE1Dqct+f@google.com>
References: <20220830231541.1135813-1-rrangel@chromium.org>
 <20220830171332.1.Id022caf53d01112188308520915798f08a33cd3e@changeid>
 <CAJZ5v0h10wrurjYG50dA+pCfRtNDqN=c8odQ0p6HJRnOyJh7KA@mail.gmail.com>
 <Yw+yqbaTi04Ydgkq@google.com>
 <Yw+zo9eUQM+T1eYZ@google.com>
 <CAHQZ30C0Q39cSxTcfu3+6ZNj7iuRE6pJpc9aPdreFt4MNHqZRQ@mail.gmail.com>
 <YxLg7t2wyPajh/rY@google.com>
 <CAHQZ30BEksUMuwqkin8XtXxPpFR0havN-pqx6nSjzpA2wSdORw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQZ30BEksUMuwqkin8XtXxPpFR0havN-pqx6nSjzpA2wSdORw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 11:18:49AM -0600, Raul Rangel wrote:
> On Fri, Sep 2, 2022 at 11:07 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Wed, Aug 31, 2022 at 08:17:23PM -0600, Raul Rangel wrote:
> > > On Wed, Aug 31, 2022 at 1:16 PM Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> > > >
> > > > On Wed, Aug 31, 2022 at 12:12:41PM -0700, Dmitry Torokhov wrote:
> > > > > On Wed, Aug 31, 2022 at 08:01:12PM +0200, Rafael J. Wysocki wrote:
> > > > > > On Wed, Aug 31, 2022 at 1:16 AM Raul E Rangel <rrangel@chromium.org> wrote:
> > > > > > >
> > > > > > > The Elan I2C touchpad driver is currently manually managing the wake
> > > > > > > IRQ. This change removes the explicit enable_irq_wake/disable_irq_wake
> > > > > > > and instead relies on the PM subsystem. This is done by calling
> > > > > > > dev_pm_set_wake_irq.
> > > > > > >
> > > > > > > i2c_device_probe already calls dev_pm_set_wake_irq when using device
> > > > > > > tree, so it's only required when using ACPI. The net result is that this
> > > > > > > change should be a no-op. i2c_device_remove also already calls
> > > > > > > dev_pm_clear_wake_irq, so we don't need to do that in this driver.
> > > > > > >
> > > > > > > I tested this on an ACPI system where the touchpad doesn't have _PRW
> > > > > > > defined. I verified I can still wake the system and that the wake source
> > > > > > > was the touchpad IRQ GPIO.
> > > > > > >
> > > > > > > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > > > > >
> > > > > > I like this a lot [...]
> > > > >
> > >
> > > > > I also like this a lot, but this assumes that firmware has correct
> > > > > settings for the interrupt... Unfortunately it is not always the case
> > > > > and I see that at least Chrome OS devices, such as glados line (cave, chell, sentry,
> > > > > ect) do not mark interrupt as wakeup:
> > > > >
> > > > > src/mainboard/google/glados/variants/chell/overridetree.cb
> > > > >
> > > > >                         chip drivers/i2c/generic
> > > > >                                 register "hid" = ""ELAN0000""
> > > > >                                 register "desc" = ""ELAN Touchpad""
> > > > >                                 register "irq" = "ACPI_IRQ_LEVEL_LOW(GPP_B3_IRQ)"
> > > > >                                 register "wake" = "GPE0_DW0_05"
> > > > >                                 device i2c 15 on end
> > > > >
> > >
> > > So the above entry specifies the `wake` register. This generates an
> > > ACPI _PRW resource. The patch series will actually fix devices like
> > > this. Today without this patch series we get two wake events for a
> > > device. The ACPI wake GPE specified by the _PRW resource, and the
> > > erroneous GPIO wake event. But you bring up a good point.
> >
> 
> 
> > Does this mean that the example that we currently have in coreboot
> > documentation (Documentation/acpi/devicetree.md) is not correct:
> >
> > device pci 15.0 on
> >         chip drivers/i2c/generic
> >                 register "hid" = ""ELAN0000""
> >                 register "desc" = ""ELAN Touchpad""
> >                 register "irq" = "ACPI_IRQ_WAKE_LEVEL_LOW(GPP_A21_IRQ)"
> >                 register "wake" = "GPE0_DW0_21"
> >                 device i2c 15 on end
> >         end
> > end # I2C #0
> >
> > Doesn't in say that we have both GpioIrq and GPE wakeup methods defined
> > for the same device?
> 
> Hrmm, yeah that is wrong and will cause duplicate wake events for the
> device. I'll push a CL to clean up the documentation.

Thanks. I think we also need to clean up our ADL boards (and likely
more).

> 
> >
> > >
> > > I wrote a quick and dirty script (https://0paste.com/391849) to parse
> > > the coreboot device tree entries. Open source firmware is great isn't
> > > it? ;)
> > >
> > > $ find src/mainboard/google/ -iname '*.cb' | xargs awk -f touch.awk --
> > > src/mainboard/google/eve/devicetree.cb
> >
> > ...
> >
> > > src/mainboard/google/sarien/variants/sarien/devicetree.cb
> > > 1
> > > chip drivers/i2c/generic
> > > register "hid" = ""ELAN0000""
> > > register "desc" = ""ELAN Touchpad""
> > > register "irq" = "ACPI_IRQ_EDGE_LOW(GPP_B3_IRQ)"
> > > register "probed" = "1"
> > > device i2c 2c on end
> > > end
> > > Total Touchpad: 202
> > > Total Wake: 195
> > >
> > > Out of all the touchpads defined on ChromeOS it looks like only 4
> > > devices are missing a wake declaration. I omitted touchpanels because
> > > ChromeOS doesn't use those as a wake source. chromeos_laptop.c already
> > > defines some devices with i2c board_info and it sets the
> > > `I2C_CLIENT_WAKE` flag. I'm not sure if this is actually working as
> > > expected. `i2c_device_probe` requires a `wakeup` irq to be present in
> > > the device tree if the `I2C_CLIENT_WAKE` flag is set, but I'm assuming
> >
> > No it does not. If there is no wakeup IRQ defined of_irq_get_byname()
> > will return an error and we'll take the "else if (client->irq > 0)"
> > branch and will set up client->irq as the wakeup irq.
> >
> > > the device tree was missing wake attributes.
> 
> Oh thanks for pointing that out. I might refactor patch #4 to just set
> the `I2C_CLIENT_WAKE` flag when `acpi_wake_capable` is true.
> 
> >
> > >
> > > Anyway, patches 6, and 7 are the ones that drop the legacy behavior. I
> > > can figure out how to add the above boards to chromeos_laptop.c and
> > > get the wake attribute plumbed, or I can add something directly to the
> > > elan_i2c_core, etc so others can add overrides for their boards there.
> > > I'll also send out CLs to fix the device tree configs (not that we
> > > would run a FW qual just for this change).
> >
> > My preference is to limit board-specific hacks in drivers if we can, so
> > adding missing properties to chromeos_laptop.c would be my preference.
> 
> How should we handle non chromeos boards?

My preference would be to shove something like chromeos_laptop into
drivers/platform/x86... Something like
drivers/platform/x86/x86-android-tablets.c

Thanks.

-- 
Dmitry
