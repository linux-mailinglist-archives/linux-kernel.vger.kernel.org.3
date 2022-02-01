Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27A64A5E36
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbiBAO0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:26:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239247AbiBAO0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:26:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643725563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rPLhPOdNSB7PJok3SKPVCTJi2bZZQJ/Ip1kdffjANMc=;
        b=EKP/gOj3NfIl7W/ac0C9o0WrfBdlaFpBXd0xchRfPBXrUEEyjMIRqbd8aSdR3kJGV+qsDV
        CzYgpSfGay4PaT8Ffr9mMcGUS5P+rBgAqBf2MUzIDt9xT1Uy+IkXlhaY8vzJZ5rvw7/XUw
        pw56JAmU+xrtds52Mu6N4RgH+WvMvEQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-g4ijchYbNBehHYrgvyoV6g-1; Tue, 01 Feb 2022 09:26:02 -0500
X-MC-Unique: g4ijchYbNBehHYrgvyoV6g-1
Received: by mail-ed1-f69.google.com with SMTP id k5-20020a508ac5000000b00408dec8390aso8684349edk.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 06:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rPLhPOdNSB7PJok3SKPVCTJi2bZZQJ/Ip1kdffjANMc=;
        b=InCjJOg2/T/OvlTpKy/ubAYTzMefNysl/jz8RzotZXKJswNg39+2E1rPuq3G+yrjOT
         e8551LO6ckB3zuRTcmtRJ4i9yHqExBhHN0SIVwWXty/bOaJrkw+J1IIap5Okh3uUgtJy
         ev1NUCfUBSKPPt5nRokHr00fLP9uznj00BCXzg5KiQG3KY74ztRE+bBvYPDrH9MaMcWh
         WJI3ahGwTkv+LFu4dXRmNoWB2/yasVHLgFIw5nhaogwikQGgPZnVlkcDsppjA/ycyuQF
         loa/bCQpd6CJSIS8xFtCie67oZ2brx3I9V3OVNJCUPmFVy+7+kHpoMRPgu/QQ1bBbQLD
         8usA==
X-Gm-Message-State: AOAM532w/2BxVOF2fswgxlwn+mFEGFpAL+Lt/46nIOh2FoszOCe7pNi4
        svwdMrdHj61dr3k2pWDLJhFSzreFOsDPr7+d52i3t5A6SlJ8CsOhNzrqAHAHO5nFSjafgBeTkdy
        9BV5Ye/c1Ch10RijLkqyuhPDn
X-Received: by 2002:aa7:d312:: with SMTP id p18mr24728916edq.49.1643725561650;
        Tue, 01 Feb 2022 06:26:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQcDKGpASKFAHDWC+uv1+s0squ1+FRZAslqH6LoVgn8BgVh44QX+sA2dPzucd6pM4miRcZ0g==
X-Received: by 2002:aa7:d312:: with SMTP id p18mr24728900edq.49.1643725561429;
        Tue, 01 Feb 2022 06:26:01 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id op20sm14709161ejb.68.2022.02.01.06.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 06:25:58 -0800 (PST)
Message-ID: <f8d94992-67a7-30c0-f59b-f4d2b448260e@redhat.com>
Date:   Tue, 1 Feb 2022 15:25:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v6 0/9] Support Spi in i2c-multi-instantiate driver
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@opensource.cirrus.com
References: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On 1/21/22 18:24, Stefan Binding wrote:
> Add support for SPI bus in the i2c-multi-instantiate driver as
> upcoming laptops will need to multi instantiate SPI devices from
> a single device node, which has multiple SpiSerialBus entries at
> the ACPI table.
> 
> With the new SPI support, i2c-multi-instantiate becomes
> bus-multi-instantiate and is moved to the ACPI folder.
> 
> The intention is to support the SPI bus by re-using the current
> I2C multi instantiate, instead of creating a new SPI multi
> instantiate, to make it possible for peripherals that can be
> controlled by I2C or SPI to have the same HID at the ACPI table.
> 
> The new driver (serial multi instantiate, smi) checks for the
> hard-coded bus type and returns -ENODEV in case of zero devices
> found for that bus. In the case of automatic bus detection, 
> the driver will give preference to I2C.
> 
> The expectation is for a device node in the ACPI table to have
> multiple I2cSerialBus only or multiple SpiSerialBus only, not
> a mix of both; and for the case where there are both entries in
> one device node, only the I2C ones would be probed.
> 
> This new serial multi instantiate will be used in CS35L41 HDA new
> driver.
> 
> Changes since V5:
>  - comment, commit message and Kconfig description fixes
>  - minor fixes in serial-multi-instantiate
>  - use lowercase for SSIDs in patch_realtek.c

Thank you for the new versions.

I gave a bunch of:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

tags for v4, unless you make big changes, you are supposed to
collect this tag and add it to newer versions of the
patch-set (just above your own S-o-b).

I'll resend the Reviewed-by-s for this version, please
collect them for the next version (I noticed there are
still some small issues, sorry).

Regards,

Hans



> 
> Lucas Tanure (4):
>   platform/x86: i2c-multi-instantiate: Rename it for a generic serial
>     driver name
>   platform/x86: serial-multi-instantiate: Reorganize I2C functions
>   ALSA: hda/realtek: Add support for HP Laptops
>   ACPI / scan: Create platform device for CS35L41
> 
> Stefan Binding (5):
>   spi: Make spi_alloc_device and spi_add_device public again
>   spi: Create helper API to lookup ACPI info for spi device
>   spi: Support selection of the index of the ACPI Spi Resource before
>     alloc
>   spi: Add API to count spi acpi resources
>   platform/x86: serial-multi-instantiate: Add SPI support
> 
>  MAINTAINERS                                   |   4 +-
>  drivers/acpi/scan.c                           |  16 +-
>  drivers/platform/x86/Kconfig                  |  12 +-
>  drivers/platform/x86/Makefile                 |   2 +-
>  drivers/platform/x86/i2c-multi-instantiate.c  | 174 ---------
>  .../platform/x86/serial-multi-instantiate.c   | 349 ++++++++++++++++++
>  drivers/spi/spi.c                             | 137 ++++++-
>  include/linux/spi/spi.h                       |  20 +
>  sound/pci/hda/patch_realtek.c                 |  43 ++-
>  9 files changed, 551 insertions(+), 206 deletions(-)
>  delete mode 100644 drivers/platform/x86/i2c-multi-instantiate.c
>  create mode 100644 drivers/platform/x86/serial-multi-instantiate.c
> 

