Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B877468530
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 14:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385109AbhLDN7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 08:59:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56427 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235843AbhLDN73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 08:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638626163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3DklwqLIbhF70738BmmNkWjzvOd8rpPIg3v//EXAr9M=;
        b=HB1CnTnoEntHBO719lxhyuVtu9v5jDv8IHllrkTFHkslPDaV2vhFGN0jWiDx+PtX7PHY3v
        QwrT9st8YAXe49iUNELqK10AGGuDfxMs9KqcZlEAcCLhhOcDz6RKRDFxhX6eVqil0f2/Rr
        hvHe5fzlxFndCBiimc8hJrBr4V5QPB0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-5E0sPUhDOoaoXnqikblOdw-1; Sat, 04 Dec 2021 08:56:02 -0500
X-MC-Unique: 5E0sPUhDOoaoXnqikblOdw-1
Received: by mail-ed1-f71.google.com with SMTP id bx28-20020a0564020b5c00b003e7c42443dbso4805251edb.15
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 05:56:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3DklwqLIbhF70738BmmNkWjzvOd8rpPIg3v//EXAr9M=;
        b=gvgZn7PY2HdA+RUDWCcD7WMOsJngH6OBPLRuh/kPCbM7WyolUtCfIHq+bzdyegJqbp
         n5GGIkWqmEnZOK/jgkOgwxrPr2xfUgx0pkzOo3U7eWKjFyuf9EYv7IZTDOse0woejfSC
         GP9BGoQ9UjeLqunzhdEnrL5QK+7UQM7YTCUFw/mFhPfHB5cau+mcLdW2DAzU8iw0QfKm
         d0jRWi5UjYAxcg9j3Yhlb3nvIWIrTuMJlIQPc2R9JBWJO+03yUr8kD6ekJAGfwRwSzQI
         zBSWVZeKfC/JYVbSGR+MhTcU/Dt4NOHhXX7TtMnoeVUq+3VzWro8Jp0RCA+iPEVlU0LZ
         yOFg==
X-Gm-Message-State: AOAM533jGNkNxtEvuLw48qLq8A6E2g0+xeu2RhQ5P2HGsdxwgKtu8cBD
        tPrXRTqrNsTzJsFiV5qvDU/1N3eG9tA/LA205ZYid1nqbCYn7i0Bw6efNcCzTZ9juVe/akRUFog
        CLB5hXr/uwFTxnHLAnexEDMKF
X-Received: by 2002:a05:6402:100e:: with SMTP id c14mr36308598edu.196.1638626161378;
        Sat, 04 Dec 2021 05:56:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy720jlD8y093U5xCfFPqtufnO7SYwJMPNYXI69mU0Ze3KrgsMlDFozoRuc1r8FLrioVjtByg==
X-Received: by 2002:a05:6402:100e:: with SMTP id c14mr36308579edu.196.1638626161173;
        Sat, 04 Dec 2021 05:56:01 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id ho17sm3820836ejc.111.2021.12.04.05.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Dec 2021 05:56:00 -0800 (PST)
Message-ID: <015913c3-171f-3ecb-2813-54404d6db273@redhat.com>
Date:   Sat, 4 Dec 2021 14:56:00 +0100
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

I haven't looked at the thinkpad_apci.c bits closely yet (for this new version),
but assuming those are ready for merging too, we need to discuss about how
to merge this.

The thinkpad_acpi code has already seen quite a lot of changes in -next,
so I would like the thinkpad_acpi changes to go upstream through the
platform-drivers-x86.git tree to avoid conflicts.

As such I think it is best if you (Sebastian) can prepare an immutable
branch with patch 1 + 2 for me to merge. Then even if patch 3 + 4 need
more work, Thomas can just respin those on top of the immutable branch.

Alternatively I can take the entire series upstream through the
platform-drivers-x86.git tree if that is ok with you (Sebastian).

Either way please let me know how you want to proceed with this.

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

