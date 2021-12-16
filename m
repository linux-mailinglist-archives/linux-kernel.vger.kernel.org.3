Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B062D477627
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbhLPPly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:41:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232607AbhLPPlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:41:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639669310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ns7kDMEcoaKNGUL81oUCnFc8/9AieN/OkLMyVTe3m3I=;
        b=dzvFCdBJPLHjRFLrHNGG1s8lZ9/Qdkzz2KDb5ikiFh+a8SELSG2Bsf6phuTMQRbJdq7anF
        92qUPmYE6E19PrhfLlkjzMrtdOVgtutLqra8MfQHzPgjfRr9+GB0A6QbNVnwepinSKa4wl
        hBfbE2jZsVmo1U2xyTp/pgUtJ3KdF2w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-2sCapa5TPI-vCUiV_a7VpA-1; Thu, 16 Dec 2021 10:41:49 -0500
X-MC-Unique: 2sCapa5TPI-vCUiV_a7VpA-1
Received: by mail-ed1-f71.google.com with SMTP id v10-20020aa7d9ca000000b003e7bed57968so23558796eds.23
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:41:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ns7kDMEcoaKNGUL81oUCnFc8/9AieN/OkLMyVTe3m3I=;
        b=RUHijjNYJ46Hqm226VfwQjhX89FkgKkG43yxbkvgD78aRCbR+bQpmmV4Rw4j2Ong/d
         Ca+oLGv/WzT8gTfBZJC/ehY869CfBK3fURqWkzAmJT2OhtbkkeMB+Ons6MkK5dP5qFZt
         k0+oEi5ov+J0SZ0RXFDxi1jBc0D+DXk+Fi/qxmLlIwKYvVM6/RF84XygxqqDTcHC17xH
         Bovb5/0mw9i1WlFb0nDsX45IOioe5PAYq3KbqLqNSFYJ8GfOqbjkumwY6vzhT4Z1/ydN
         ULzhZbfyAqpMYEVu2QMd8Zd4GZ0sq6WUJ07nap/YcsQl953DwXrsuEUqlxNjibv+3fu8
         0SOA==
X-Gm-Message-State: AOAM532i7lESIZBpCyvDDpUfRV3Kyue8pFcYIQDTeU3/klxqWsfRs+nm
        Ca/QEvShSEzqBbO44I9MSrkwV8YKmE8DeV3NrXKXazhLwZ/QGwJdCoWSo7OdKexeHqTq9RZzhBr
        ufWRg15aJrKOViTCKOi7Evzpt
X-Received: by 2002:a17:906:730d:: with SMTP id di13mr7423021ejc.557.1639669308382;
        Thu, 16 Dec 2021 07:41:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1hty/NqPgPOCvuZBByYKKfw+FS2DPD3jcu2pyAp6MB4tRgVw73vipf1LyB4LBXvx9BUiuUQ==
X-Received: by 2002:a17:906:730d:: with SMTP id di13mr7422994ejc.557.1639669308104;
        Thu, 16 Dec 2021 07:41:48 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id 23sm1937056ejg.213.2021.12.16.07.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 07:41:47 -0800 (PST)
Message-ID: <0a2a0f82-b914-e9fe-97a3-13a9608f2dde@redhat.com>
Date:   Thu, 16 Dec 2021 16:41:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 0/4] power: supply: add charge_behaviour property
 (force-discharge, inhibit-charge)
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
Cc:     linux-pm@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        linux-kernel@vger.kernel.org, linrunner@gmx.net, bberg@redhat.com,
        hadess@hadess.net, markpearson@lenovo.com,
        nicolopiazzalunga@gmail.com, njoshi1@lenovo.com, smclt30p@gmail.com
References: <20211123232704.25394-1-linux@weissschuh.net>
 <20211203213305.dfjedjj3b25ftj2z@earth.universe>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211203213305.dfjedjj3b25ftj2z@earth.universe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/3/21 22:33, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Nov 24, 2021 at 12:27:00AM +0100, Thomas Weißschuh wrote:
>> This series adds support for the charge_behaviour property to the power
>> subsystem and thinkpad_acpi driver.
>>
>> As thinkpad_acpi has to use the 'struct power_supply' created by the generic
>> ACPI driver it has to rely on custom sysfs attributes instead of proper
>> power_supply properties to implement this property.
>>
>> Patch 1: Adds the power_supply documentation and basic public API
>> Patch 2: Adds helpers to power_supply core to help drivers implement the
>>   charge_behaviour attribute
>> Patch 3: Adds support for force-discharge to thinkpad_acpi.
>> Patch 4: Adds support for inhibit-discharge to thinkpad_acpi.
>>
>> Patch 3 and 4 are largely taken from other patches and adapted to the new API.
>> (Links are in the patch trailer)
>>
>> Ognjen Galic:
>>
>> Your S-o-b is on the original inhibit_charge and force_discharge patches.
>> I would like to add you as Co-developed-by but to do that it will also require
>> your S-o-b. Could you give your sign-offs for the new patches, so you can be
>> properly attributed?
>>
>> Sebastian Reichel:
>>
>> Currently the series does not actually support the property as a proper
>> powersupply property handled fully by power_supply_sysfs.c because there would
>> be no user for this property.
> 
> I'm not too happy how the acpi-battery hooks work, but that's not
> your fault and this patchset does not really make the situation
> worse. So:
> 
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sebastian, what is the plan for taking this upstream ? Does your ack mean that
you are ok with me taking the entire series upstream through the pdx86 tree?

Or do you plan to apply patches 1-2 through linux-power-supply.git; and in that
case can you provide an inmmutable branch with those patches for me to merge
into pdx86/for-next so that I can then apply patches 3 + 4 there ?

Note merging everything through the linux-power-supply.git tree is non ideal
in this case because the thinkpad_acpi.c code already has a lot of changes
in pdx86/for-next.

Regards,

Hans


>> Previous discussions about the API:
>>
>> https://lore.kernel.org/platform-driver-x86/20211108192852.357473-1-linux@weissschuh.net/
>> https://lore.kernel.org/platform-driver-x86/21569a89-8303-8573-05fb-c2fec29983d1@gmail.com/
>>
>> v1: https://lore.kernel.org/lkml/20211113104225.141333-1-linux@weissschuh.net/
>> v1 -> v2:
>>
>> * Use sysfs_emit-APIs instead of plain sprintf
>> * More cecks for actual feature availability
>> * Validation of the written values
>> * Read inhibit-charge via BICG instead of PSSG (peak shift state)
>> * Don't mangle error numbers in charge_behaviour_store()
>>
>> Open points:
>>
>> Thomas Koch has observed that on a T450s with two batteries
>> inhibit-charge on BAT0 will affect both batteries and for BAT1 it is ignored
>> entirely, this seems to be a bug in the EC.
>> On my T460s with two batteries it works correctly.
>>
>> Thomas Weißschuh (4):
>>   power: supply: add charge_behaviour attributes
>>   power: supply: add helpers for charge_behaviour sysfs
>>   platform/x86: thinkpad_acpi: support force-discharge
>>   platform/x86: thinkpad_acpi: support inhibit-charge
>>
>>  Documentation/ABI/testing/sysfs-class-power |  14 ++
>>  drivers/platform/x86/thinkpad_acpi.c        | 191 +++++++++++++++++++-
>>  drivers/power/supply/power_supply_sysfs.c   |  51 ++++++
>>  include/linux/power_supply.h                |  16 ++
>>  4 files changed, 268 insertions(+), 4 deletions(-)
>>
>>
>> base-commit: 66f4beaa6c1d28161f534471484b2daa2de1dce0
>> -- 
>> 2.34.0
>>

