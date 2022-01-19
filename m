Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84DA49420F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357386AbiASUpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:45:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57077 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244777AbiASUp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:45:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642625125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Z6ATFgYm47R3O+EDDCyhoN8SR8w6/dPquwar2QtIME=;
        b=NzwhxdwUSmOrLU3lt85dvZVfhsI/cizmrEjVLDjq8PkM1xs2a2kVFiTGpU1kpmxdhy5GnZ
        M5FWEHUWJQ6yOvckM6EoOgCKLzs6N92rb59QyNhiEv8OahoK/tYQq2busszdx1yVEjBNxz
        +AK5QWwINRfN0DsRA+XWdBfSy42y2Y0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-7D-HmPXIMRK093ewGcl8Mg-1; Wed, 19 Jan 2022 15:45:24 -0500
X-MC-Unique: 7D-HmPXIMRK093ewGcl8Mg-1
Received: by mail-ed1-f71.google.com with SMTP id ej6-20020a056402368600b00402b6f12c3fso3819023edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8Z6ATFgYm47R3O+EDDCyhoN8SR8w6/dPquwar2QtIME=;
        b=ewCiw+1zqcTi/MkK285Na9d2ZJs+NAdKLLn9ppY+Cst6xU6vyzTayEpJxI1jxqwE4j
         CDU4NmRUDROyBg2QhM8LsGji2nJCf12Q8iHsPF2XixZwURNkSL2gGwOTdvA4RaIpP/k8
         XEPyuF1DhgERrx9o1kiP+kAe/FbOa5HU1X+FxAiMRDGZADCd3wy2TwhuErXk3McbDsYW
         vBIsRqKl9whoZjawocg7CHymw+Oc4GvHYnYqWON+WyHfEjr7OUoHlxo2lUkyiBExL3a1
         dxwMI6ZLLBvO0XB4tW55r41YAM+x6TmPC7tIBcFQz/BpIoyemJrvfGoH+Z4iY2zzbKOz
         Nm7Q==
X-Gm-Message-State: AOAM531N+JEI47urfLnTAgBHl5BlrC5xT6ri0zktKGlvxtAMppPfAYg+
        P3E/ZrgJmP5nAzw/+vlHjwJNGeZWht+5SwZVdCRptaew/BLPY4n0t+VDSjiA4G45qRr5bRed9ya
        M7s/p7GVrLjA6OcqLAnopsbmK
X-Received: by 2002:a17:907:1c8c:: with SMTP id nb12mr25358068ejc.433.1642625123350;
        Wed, 19 Jan 2022 12:45:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdu0WR7xuH8xLqLMAbpee9TRwFbG79tErUiR7LuzZL3XxOUAvoEyflMGBNblspBVEKpNBLZg==
X-Received: by 2002:a17:907:1c8c:: with SMTP id nb12mr25358055ejc.433.1642625123174;
        Wed, 19 Jan 2022 12:45:23 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id q4sm243765ejb.109.2022.01.19.12.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 12:45:22 -0800 (PST)
Message-ID: <4a767d48-fa5d-17be-373d-b49522910285@redhat.com>
Date:   Wed, 19 Jan 2022 21:45:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: Convert type of 'struct dmi_system_id -> driver_data' from 'void
 *' to kernel_ulong_t?
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>, jkosina@suse.cz,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>, mgurtovoy@nvidia.com,
        linux@weissschuh.net, Arnd Bergmann <arnd@arndb.de>,
        stephan@gerhold.net, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20220119202749.GA959272@bhelgaas>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220119202749.GA959272@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/19/22 21:27, Bjorn Helgaas wrote:
> On Wed, Jan 19, 2022 at 11:20:36AM +0100, Hans de Goede wrote:
>> On 1/19/22 02:22, Kai-Heng Feng wrote:
>>> I wonder if there's any reason to use 'void *' instead of
>>> kernel_ulong_t for 'driver_data' in 'struct dmi_system_id'?
>>>
>>> I'd like to use the driver_data for applying quirk flags, and I found
>>> out unlike most other struct *_id, the dmi variant is using 'void *'
>>> for driver_data. Is there any technical reason for this?
>>> ...
> 
>> You are asking for a technical reason why "void *" was used,
>> but lets turn that around, why do you believe that "unsigned long"
>> is inherently a better type here ?
>>
>> driver_data in most places in the kernel (like data for
>> all sort of callback functions) actually typically is a void *
>> already, because often people want to pass more data then what
>> fits in a single long and this also applies to driver-id attached
>> data.
> 
> FWIW, "egrep "context;|data;|info;" include/linux/mod_devicetable.h"
> says 4 of the ~40 instances use a void *; the others use
> kernel_ulong_t.

Right inside mod_devicetable.h kernel_ulong_t is the norm, but outside
e.g. inside struct device and with dev_set_drvdata/dev_get_drvdata
and all their many derratives using void * is the norm.

So looking at the kernel as a whole using kernel_ulong_t seems
to be the exception. But maybe that indeed has something to
do with:

> f45d069a5628 ("PCI dynids - documentation fixes, id_table NULL check")
> [1] (from the tglx history tree) added the original hint for
> pci_device_id that:
> 
>   Best practice for use of driver_data is to use it as an index into a
>   static list of equivalant device types, not to use it as a pointer.
> 
> I don't know the background of that, but I could imagine that using an
> index rather than a pointer makes things like /sys/bus/pci/.../new_id
> easier and safer.

Right, interesting.

OTOH we have:

const void *device_get_match_data(struct device *dev);

Which is a wrapper to easily get the driver_data for popular firmware
based matches (ACPI/of), which also returns a void *...

Actually the rule seems to be that firmware-id matching,
including WMI GUID matching uses void * where as hw-id
(e.g prod:vend matching) uses kernel_ulong_t with acpi_device_id
being the exception since it is a fwid using kernel_ulong_t,
which then gets "fixed" by acpi_device_get_match_data turning
it into a void * for the caller.

As DMI matching is closer to firmware compatible/id matching then
to actual hw-id matching, it seems that it actually follows
the pattern of fw-id matches using void * where as hw-id
matches using void * .

TBH I don't care much either way, but I also really don't see
strong reasons to spend a lot of time on changing any of this.

Regards,

Hans

