Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A584691E9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239912AbhLFJHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:07:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230492AbhLFJHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638781451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eCz1k7fVnWvveVn2f/X/M5AqFdb9nW25Tyb/GRGTDTU=;
        b=AtEuQBixW6+sXboKsdGPyFqWvX1L9W+8wERu2gDKLZ8kaLg/QnHUFtdHqj+7nDuAgdbral
        mLRalGBSbNxv1M5Owx7BX0trMrSjQDaV7GB3AQWoXunKSXQlJKSNUV+2nl3HplcYnRo1OX
        HTeKtYRDCTX53FPwv0J/J6/O4MtOt4g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-blYKVapyNT-rqgfYS1BKPA-1; Mon, 06 Dec 2021 04:04:07 -0500
X-MC-Unique: blYKVapyNT-rqgfYS1BKPA-1
Received: by mail-ed1-f69.google.com with SMTP id s12-20020a50ab0c000000b003efdf5a226fso7740408edc.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 01:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eCz1k7fVnWvveVn2f/X/M5AqFdb9nW25Tyb/GRGTDTU=;
        b=7t9x5/txW+pi6Juj8oNrAxIDvyXaxlPEiE9L830vhJ0XUYOhqwIeUOYqmfnlY/gIBu
         Qznl1UkPpqT2aZGFvVSU3paa5lDrA7c61tp7CKzM9yCsxRxqVUK/1KJbkQUPcqbJgzIM
         ROHThik9giKOJvmsPV9V5iW2D6hgedsa3w9qFvd5VAgBXmFLwNoqx6FfFghPJ5W6W7RD
         cNb6nCs5JVeNgCw/5goChz/KNYyJnEMIDh8XKl7L4V3kiZTHXEzIGPX2lvJtR3DvxP4X
         gX3jEAxQxgNKa2xMj65tjiyJOibixCJY8GEHDUPWWerxnX0ve0noD38lqcEPMGkLUcbH
         s4IQ==
X-Gm-Message-State: AOAM530lgNl9sCV41SjaqYWUXU8b4I8VkcLdYoQoT0gbsDSsO27J8vV1
        8fH5QLwLD5ybWcI7pym8f/2LhVLY/0zy378NAWpFy1G0Ilf8GN1WsvN1OTnGaeTr142qVnp67Ve
        MLtdNH8LBKHWyZ6/wsZBpWi+g
X-Received: by 2002:a05:6402:354e:: with SMTP id f14mr51893434edd.245.1638781446348;
        Mon, 06 Dec 2021 01:04:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxD0cif/EQgl1GZxIYPmco6+CVBBRmPEgg+DVW4/c2W97sveNAX8oBEfwAGEcwgl6vuG5YbQ==
X-Received: by 2002:a05:6402:354e:: with SMTP id f14mr51893414edd.245.1638781446187;
        Mon, 06 Dec 2021 01:04:06 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id t20sm7410599edv.81.2021.12.06.01.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 01:04:05 -0800 (PST)
Message-ID: <eb8ba4a3-3889-6fd3-16f1-2b297a05c82a@redhat.com>
Date:   Mon, 6 Dec 2021 10:04:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 0/2] ACPI: scan: Introduce a replacement for
 acpi_bus_get_device()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
References: <2828957.e9J7NaK4W3@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2828957.e9J7NaK4W3@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/3/21 17:34, Rafael J. Wysocki wrote:
> Hi All,
> 
> Because acpi_bus_get_device() turned out to be problematic in the past, it has
> been changed to the point that its calling convention doesn't make much sense
> any more (ie. the pointer passed to it as the second argument is cleared on
> errors and it can only return one error value if that pointer is nonzero, so
> there is some duplication of information in there) and it has to make redundant
> checks.
> 
> Moreover, its name suggests some kind of reference counting which really isn't
> the case.
> 
> Thus patch [1/2] introduces a replacement for it, called acpi_fetch_acpi_dev(),
> and makes the code in scan.c use it instead of acpi_bus_get_device() internally.
> 
> Patch [2/2] updates all of the callers of acpi_bus_get_device() within the ACPI
> subsystem to use the replacement (which involves fixing a couple of bugs related
> to that).

Thanks, the series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans

