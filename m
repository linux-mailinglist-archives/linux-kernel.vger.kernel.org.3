Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9CF47F3CE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 17:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhLYQTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 11:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhLYQTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 11:19:54 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04683C061401;
        Sat, 25 Dec 2021 08:19:53 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m21so45480349edc.0;
        Sat, 25 Dec 2021 08:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UsdPYpm1DtVrhyxxHtm/LRi0HP6GcDMlcCiYeTd9gAY=;
        b=DBuPiQjuMuhPNfWWQy6bNRFOKdcwLTJbYbtu/VPNqL3NITwnLHm8oXZzVoJtbbVLt6
         gpYl5Vtji8Iht7Py1LIjWZqa9dIDF9hYVFFmqQ6qSmO0Id8rORquYHO/TzWmFHKTFemr
         aEDWcXGKPWv4m91k6JnPHImDeQuBFmVPv0JF42/9QZ+8Hnpsh+V14gl1YbGGF0R0I3lc
         HvP1QwBGMmhhGzzAIoXhPMRJe8B6lpR0P6Fw0VtF/iy2GIPmVVGu8lHkoDg1YHpdHIHl
         +kcm5hYi/PXeXaKAhBfdonoTLABlwFqY/AL2AcYMkXzBIqM6ygL31I50+Jj1cweN63jS
         myMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UsdPYpm1DtVrhyxxHtm/LRi0HP6GcDMlcCiYeTd9gAY=;
        b=yNu5yQRG1F70Ig/0zckGv62IV1y9fTmSwFWpHFbIkpl3oMGva8DKc2bAQ4cU5tkI4Q
         r+zW3alUvwMYQ0/kFZHSCnhvsDYf8Azh+/Hefbwx1xqGVid1ua7EcB/nR9rARBFgLhdZ
         blHAr+pA2Yel3iBzhYv8dzf8/H/fFZ/N5oSxazB8OTm7dWd9oQF4OFcJQnQLL8gDeG4W
         Zn/WD9nlyNVQ5V05n3HgeGvU/QuMfiSXT+4DLarCFXR9y8vvNAoCbhMD5OTM7XrzMEg5
         uHsAS8r1A1S3zErZXuCz+GZaKuFHD+DT8zDwA249qbm2cSOIofxQywVqutvrtSQeq+Ws
         12zg==
X-Gm-Message-State: AOAM53004N4LA1SMtCOJQdmgi1h440GWN21J9gqLKTIv0MybifHcpOpF
        3Gm1vWwXQOZXv8FChObkCGmpPzfNHZl9cxlqta8=
X-Google-Smtp-Source: ABdhPJxGyNpikOCL5/GEECxckYkRk1Ur/E/IGIyu2LWJJKZsC3jsfXtHUs+THG9Fy/XdQiG4nntekHnYWpiwsFhqzBg=
X-Received: by 2002:a05:6402:4301:: with SMTP id m1mr9059887edc.125.1640449192335;
 Sat, 25 Dec 2021 08:19:52 -0800 (PST)
MIME-Version: 1.0
References: <20211224145903.368999-1-kai.heng.feng@canonical.com>
 <CAHp75Vd3RhVUe_Yoz-fPErzYcV=+gtOVsxNTmn2_52JbSUaMaA@mail.gmail.com> <CAAd53p7bu=+bs5c2Y1LQLC7fPLUihNX_QHw-yOh=fUKUdXWWhg@mail.gmail.com>
In-Reply-To: <CAAd53p7bu=+bs5c2Y1LQLC7fPLUihNX_QHw-yOh=fUKUdXWWhg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 18:19:16 +0200
Message-ID: <CAHp75VeVFcaJJeacDCMBEaAVNXUgEF_oaHWXUpHobAYX4EmBuQ@mail.gmail.com>
Subject: Re: [PATCH] iio: humidity: hdc100x: Add ACPI HID table
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chris Lesiak <chris.lesiak@licor.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 3:05 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> On Sat, Dec 25, 2021 at 7:32 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Friday, December 24, 2021, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> >>
> >> x86 boards may use ACPI HID "HDC1010" to for hdc100x device.
> >>
> >> So add an ACPI match table for that accordingly.
> >
> > No. We do not add abusing IDs blindly.
> > Why this is in use? Is the creative creator of that informed that is an ACPI spec abuse?
>
> Can you please elaborate more on this topic? How is this an ACPI spec abuse?

Yes, https://uefi.org/PNP_ACPI_Registry has links to PNP and ACPI ID registries.
Note, the main differences between them are:
- PNP uses 3-letter vendor ID, ACPI uses 4-letter
- PNP is in maintenance mode and shouldn't be expanded

So, Since above should formally satisfy the PNP ID, the HDC is not a
TI vendor ID in the PNP ID registry.

The section in the spec that refers to it:
https://uefi.org/specs/ACPI/6.4/06_Device_Configuration/Device_Configuration.html#hid-hardware-id

> I did suggest them to use PRP0001, but I also don't think this is an abuse.

The PRP0001 is not an abuse per se, but rather it is highly _not_
recommended for a production use.

> > What devices are those? Is it available on the market? Where is the link to DSDT?
>
> It's not on the market yet.

Thank God!

> Do you need the full DSDT? Or just the
> part of the ACPI device?
> I'll need approve from customer to disclose these info.

This is a requirement only for the devices on the market when nobody
prevented the disaster from becoming... Since it's not yet, no need
for it.

> > Does TI has an ID for that?
>
> I was told by customer this is approved by TI.

How can TI approve that for "HARDCOM ELEKTRONIK & DATATEKNIK"? Is
there evidence that this company has been bought by TI or TI got full
rights on their IPs?

ACPI: TEXAS INSTRUMENTS TXNW
PNP: TEXAS INSTURMENTS TXN
(seems a typo in the company's name, but it should be notified to the
appropriate channels)

So, the ID should start with one of the above, and not HDC as far as I
understood.

PNP: TEXAS MICROSYSTEM TMI
This one probably is not related, but I'm not informed.

I would like you (and your customer) to point to my blog post on the
topic and it explains how the things should be done with the ACPI IDs:
https://andy-shev.dreamwidth.org/151340.html

Hope this will help and be resolved soon.

-- 
With Best Regards,
Andy Shevchenko
