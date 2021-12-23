Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F8947E906
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 22:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350338AbhLWVV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 16:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbhLWVVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 16:21:24 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9686C061401;
        Thu, 23 Dec 2021 13:21:24 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gj24so6039421pjb.0;
        Thu, 23 Dec 2021 13:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DTIdj4RaXLtlrp+r65BDVsD3Sau1mr41CGpuUX0r64Y=;
        b=O8AWEdwEPgElj8UoLoYPC3gMFYVKmTGtAbCF2OMgxvBAVeKpFkPBwmRGRua5mdsUjR
         KG51Jj8S82+QkbUdOCobo0mVG3QN5zBvIe4stqrO7mjvbuLDjKadUDYUOfTRnTKCafeS
         T2KoDprD7zKSaxa8pGwQ1ONOKIZs+J3tqFLbBT2mF/LYpxDpILKxBjs44iV6LQgrUD7x
         eDfAeDjRhrcMazqp8W2XH8Fr1EQ0cvgeL+WhoHMa8gkddXBmUhjycDtsAnzz/nBcZEPs
         krdvAinmw9wjjloveywVgNpLlkTUbigGE8TVq0uVoxBZ+F4FW+GoxtwhYjSDbllW+36r
         4Kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DTIdj4RaXLtlrp+r65BDVsD3Sau1mr41CGpuUX0r64Y=;
        b=N9LFkTcp82TCAcBiyq4/SED+rgx1ml8UuibGozWqpNv3kLAQrqbFin17bPCl/kVPXy
         UR3A3+2uoeUb5PkOxnNhBIqtCwmk9UXw/KwNwds1VovlqxqBbkGUA2/i7IvEI4qpXT58
         aH2j6X87LrZiNu6UKoU2K7DIe2/COSAwpJ/MjMX1E6sDsHSw4YsS1P9dTJ1i1LUJT8/+
         2oCXaAKGJHtuKozhx5gIJGP3HWcJMSfQiLDbl4wofyBLPCwFBonIKj3G01brxYOX4GP/
         Dxmq1nQ5cx2xHTsrxCI8x/LrgkNyn2XytVrJmc27Y36WLaIS5yb4Efvc9ubNb1xx1KKx
         NsjQ==
X-Gm-Message-State: AOAM532mcvnlVvMzqcpw6KVOPZcNz/eiUMcrJdhSHjULAWgqxDnNoX6i
        T62+ci2BdVtiw9hzusHaAxO8JqX6ch8=
X-Google-Smtp-Source: ABdhPJzyidRIMksQmItyUN0kVoD0eAGTAfAPwMFUhHo4dUqWYQ3CTokDzTe5t60mHIp4I8++YVjWVg==
X-Received: by 2002:a17:90b:3b46:: with SMTP id ot6mr4540663pjb.62.1640294484114;
        Thu, 23 Dec 2021 13:21:24 -0800 (PST)
Received: from google.com ([2620:15c:202:201:e54e:1f66:583f:ea16])
        by smtp.gmail.com with ESMTPSA id y65sm5630284pgd.79.2021.12.23.13.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 13:21:22 -0800 (PST)
Date:   Thu, 23 Dec 2021 13:21:20 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Raul E Rangel <rrangel@chromium.org>, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, linux-input@vger.kernel.org,
        dianders@chromium.org, "jingle.wu" <jingle.wu@emc.com.tw>
Subject: Re: [PATCH 2/3] Input: elan_i2c - Use PM subsystem to manage wake irq
Message-ID: <YcToUCQ8gzzSWbrm@google.com>
References: <20211220234346.2798027-1-rrangel@chromium.org>
 <20211220163823.2.Id022caf53d01112188308520915798f08a33cd3e@changeid>
 <YcE+xrSnS7qw0G1/@google.com>
 <9b004b3d-deed-1b63-2344-a445a9e53b61@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b004b3d-deed-1b63-2344-a445a9e53b61@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 03:42:24PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 12/21/21 03:41, Dmitry Torokhov wrote:
> > Hi Raul,
> > 
> > On Mon, Dec 20, 2021 at 04:43:45PM -0700, Raul E Rangel wrote:
> >> @@ -1368,11 +1367,13 @@ static int elan_probe(struct i2c_client *client,
> >>  	}
> >>  
> >>  	/*
> >> -	 * Systems using device tree should set up wakeup via DTS,
> >> +	 * Systems using device tree or ACPI should set up wakeup via DTS/ACPI,
> >>  	 * the rest will configure device as wakeup source by default.
> >>  	 */
> >> -	if (!dev->of_node)
> >> +	if (!dev->of_node && !ACPI_COMPANION(dev)) {
> > 
> > I think this will break our Rambis that use ACPI for enumeration but
> > actually lack _PRW. As far as I remember their trackpads were capable
> > of waking up the system.
> > 
> > I think we should remove this chunk completely and instead add necessary
> > code to drivers/platform/chrome/chrome-laptop.c (I suppose we need to
> > have additional member in struct acpi_peripheral to indicate whether
> > device needs to be configured for wakeup and then act upon it in
> > chromeos_laptop_adjust_client().

FWIW I looked at Rambi some more and I see that it actually defines a
separate device an ACPI to handle wakeups, it is separate from the ACPI
node for the trackpad:

Scope (\_SB)
{
#ifdef BOARD_TRACKPAD_IRQ
        /* Wake device for touchpad */
        Device (TPAD)
        {
                Name (_HID, EisaId ("PNP0C0E"))
                Name (_UID, 1)
                Name (_PRW, Package() { BOARD_TRACKPAD_WAKE_GPIO, 0x3 })

                Name (RBUF, ResourceTemplate()
                {
                        Interrupt (ResourceConsumer, Level, ActiveLow)
                        {
                                BOARD_TRACKPAD_IRQ
                        }
                })

                Method (_CRS)
                {
                        /* Only return interrupt if I2C1 is PCI mode */
                        If (LEqual (\S1EN, 0)) {
                                Return (^RBUF)
                        }

                        /* Return empty resource template otherwise */
                        Return (ResourceTemplate() {})
                }
        }
#endif

I am not quite sure why we did this...

> > 
> >>  		device_init_wakeup(dev, true);
> >> +		dev_pm_set_wake_irq(dev, client->irq);
> >> +	}
> 
> As I already mentioned in my other reply in this thread:
> 
> https://lore.kernel.org/linux-input/f594afab-8c1a-8821-a775-e5512e17ce8f@redhat.com/
> 
> AFAICT most x86 ACPI laptops do not use GPEs for wakeup by touchpad and
> as such they do not have a _PRW method.
> 
> So for wakeup by elan_i2c touchpads to keep working this code is not
> just necessary for some ChromeOS devices, but it is necessary on
> most ACPI devices.
> 
> The problem of not making these calls on devices where a GPE is actually
> used for touchpad wakeup (which at least for now is the exception not
> the rule) should probably be fixed by no running this "chunk"
> when the device has an ACPI_COMPANION (as this patch already checks)
> *and* that ACPI_COMPANION has a valid _PRW method.
> 
> Simply removing this chunk, or taking this patch as is will very
> likely lead to regressions on various x86 laptop models.

Hans, could you share a couple of DSDTs for devices that do not use GPEs
for wakeup?

For OF we already recognize that wakeup source/interrupt might differ
from "main" I2C interrupt, I guess we need to do similar for ACPI cases.
The question is to how determine if a device is supposed to be a wakeup
source if it does not have _PRW.

Thanks.

-- 
Dmitry
