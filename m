Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681FC493847
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349406AbiASKUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:20:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35934 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240254AbiASKUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642587642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CjTXHpMu7iQCe4aRsTdgqOxoinRj5QFe260cZ5ycsEc=;
        b=hfXIyv0WdUsR0IV6hoHgTLTZq+u++0oMQ+e/r/SFLtJQ4FB/2zBNOHc9rQDQgGwE2yyqLx
        jbOpzIG2gqzGTIlNDa7XduDNpxCNa7PpQzx9ZwE1fa6tzpdxkOx+bKCb/WU2XFbDHP6gSW
        KaBAR8wF0d3H352XfhISTvKrLXQAv9Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-3VL1q2QONzKkXqFMv5r5BQ-1; Wed, 19 Jan 2022 05:20:40 -0500
X-MC-Unique: 3VL1q2QONzKkXqFMv5r5BQ-1
Received: by mail-ed1-f71.google.com with SMTP id ee53-20020a056402293500b004022f34edcbso1850996edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 02:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CjTXHpMu7iQCe4aRsTdgqOxoinRj5QFe260cZ5ycsEc=;
        b=6bTVBSGtpL5v+TPqhl8N/rQ1K1E/LZLwhZ86eCBcLNk3zW6yaigH36IMmOUEwQnp/o
         n6yleO5TQo+NSn7CrFzAJBDKjCxG4ClbqCn2IRpYDUxlTTAy/DQtIdNNntuvqP3d4GM5
         iWT1ICN1WidCQQZRYNfIbFMHzdaHTdLabwJ9F2X2b1pgArQkco8UkSQw0Dt7Gogmri6Q
         VN9AhY7iufwlZmyiWcITxemmI5oFwRWHe9xRmTdtD2qxJH3WDJ7F2GaxJXD2j4HPg/ev
         n9mlXdaeQ3HhkjgCucF2SgjxR1SRHeJHK/3CozPv+m/efIPUa0ae/X6BRf1xDfoh5o6T
         kHWg==
X-Gm-Message-State: AOAM530sO9cOqtbDysoRhi3bWuyWzFu6gfNpk+h74W3JWMSYa473nzEq
        Jyu82FYYxliUBo0uWRKI9KOlTyJ8fss4/v+EIKWELwJy4lSfsxhTetSJm84k601XJkTI4hF4t24
        dSmrg5PiL+tdGQtcsff+lklSf
X-Received: by 2002:a05:6402:1753:: with SMTP id v19mr107112edx.235.1642587638125;
        Wed, 19 Jan 2022 02:20:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwoiJPGbOGpM4FmcLGm0Qj+Q8OOCakdv1fB7szWja2xhM3i4oxVE1YYw3gThDCOMr/vfhtx9Q==
X-Received: by 2002:a05:6402:1753:: with SMTP id v19mr107084edx.235.1642587637864;
        Wed, 19 Jan 2022 02:20:37 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id ek14sm952418edb.53.2022.01.19.02.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 02:20:37 -0800 (PST)
Message-ID: <fa51355f-9ab6-7bbf-d7f6-e2af2d68056c@redhat.com>
Date:   Wed, 19 Jan 2022 11:20:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: Convert type of 'struct dmi_system_id -> driver_data' from 'void
 *' to kernel_ulong_t?
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     jkosina@suse.cz, Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>, mgurtovoy@nvidia.com,
        linux@weissschuh.net, Arnd Bergmann <arnd@arndb.de>,
        stephan@gerhold.net, "Rafael J. Wysocki" <rafael@kernel.org>
References: <CAAd53p5EiTXfAhCFPDaicksQOa5usOkS5v7moPgM2A7QZ6QCqg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAAd53p5EiTXfAhCFPDaicksQOa5usOkS5v7moPgM2A7QZ6QCqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai-Heng,

On 1/19/22 02:22, Kai-Heng Feng wrote:
> Hi,
> 
> I wonder if there's any reason to use 'void *' instead of
> kernel_ulong_t for 'driver_data' in 'struct dmi_system_id'?
> 
> I'd like to use the driver_data for applying quirk flags, and I found
> out unlike most other struct *_id, the dmi variant is using 'void *'
> for driver_data. Is there any technical reason for this?

I don't know if there is a technical reason for this, nor
why this choice was originally made.

But I do believe that changing this now will just lead to a lot
of unnecessary churn.

You can easily use the current void * for flags by doing;

#define FLAG1	BIT(0)
#define FLAG2	BIT(1)

...
		.driver_data = (void *)(FLAG1 | FLAG20,

...

	long quirks = (long)dmi_id->driver_data;


It is already used this way in many places. Have you done a grep
to see in how many places dmi_system_id is used? DMI based quirks
are used all over the place, changing this will cause a really
large amount of churn and for what?

So I just did a quick check and dmi_system_id is used in
*204* files in the kernel.

You are asking for a technical reason why "void *" was used,
but lets turn that around, why do you believe that "unsigned long"
is inherently a better type here ?

driver_data in most places in the kernel (like data for
all sort of callback functions) actually typically is a void *
already, because often people want to pass more data then what
fits in a single long and this also applies to driver-id attached
data.

Just a random example from: drivers/mmc/host/sdhci-pci.h

#define SDHCI_PCI_DEVICE(vend, dev, cfg) { \
        .vendor = _PCI_VEND(vend), .device = _PCI_DEV(vend, dev), \
        .subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, \
        .driver_data = (kernel_ulong_t)&(sdhci_##cfg) \
}

So here the unsigned long is actually not what we want and
we have to do a cast the other way around; and again the
kernel is full of these examples. So arguably if anything we
should change the other driver_data fields from
include/linux/mod_devicetable.h
to avoid the need for these kinda casts all over the kernel
(but again that would not be worth the churn IMHO).

TL;DR: lets just leave this all as it is please.

Regards,

Hans

