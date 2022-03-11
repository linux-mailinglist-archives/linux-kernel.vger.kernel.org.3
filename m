Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912D34D645E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348647AbiCKPOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243774AbiCKPOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:14:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C9EFF68F7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647011618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHdAzCb9E/ykb7mXZSmAxXBDsvPPXbqE7I2bNDvhtZQ=;
        b=OwneAacmdxI/5bCg2mfjo/ey70WyaWuqX+iSyCY7v6ohX2azPdkgbJPm7Cjv7K44xJE3Fn
        sxqF3rK243rXCeONcZ/KfcNRQmRsTs2WJ72PdqD8yc3dwhAHBKjBaDtW7R6z/d9/MX4hDf
        mSRS67JhlHVtT9yEV7gdIf+hDVXukN8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-OBYDo44_OdOFZvD1NHzgxw-1; Fri, 11 Mar 2022 10:13:37 -0500
X-MC-Unique: OBYDo44_OdOFZvD1NHzgxw-1
Received: by mail-ed1-f69.google.com with SMTP id cf6-20020a0564020b8600b00415e9b35c81so4987421edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=jHdAzCb9E/ykb7mXZSmAxXBDsvPPXbqE7I2bNDvhtZQ=;
        b=cZTaP6HYrHb5jrNWBqeznzA1OaBhm37aWE9rswNZlRm6TPqSZL6fvoU2UbPql+QcH8
         oAQYPvUt2WvaL076DjvT6luFscH4jeHXy9j8I65kwf5JKirVhxaKWKLdQRlexGg+KNgA
         wqFSJOq3rs2tRwq6ZAh7zXgKdr65TZz25wjQAggN9vZCGNpfCZH5X323K5ouTUFHp/W6
         OMZD2GmoKg/92aWhBlzD9fkat2cSd/K6v52vBVz4ESUUyYvdGLaEtnqteq8WIOVPSCYf
         FfZBeGeWEGC9c01QjbaXi6oT6M+ufRBOS2dTCz9Tn4g//M32/Ja2tY9prJXuKT1i3gCL
         hWfg==
X-Gm-Message-State: AOAM5300RcCpxufNo0PCn9nTxvKLJZr9OL/aWAdMCKQBpr/yrqs+fxIi
        82WYOZtTtC6QDOcfPJXEX+HltAv5kLsf5KqLQarUPIy4jqfZGkUyYCJCDNyDIMzhlQYxUETQZ/N
        fIhYOHf2eZgRe0uJVCEzuhe0Y
X-Received: by 2002:a17:907:6d19:b0:6db:89c8:52e3 with SMTP id sa25-20020a1709076d1900b006db89c852e3mr6979202ejc.754.1647011610487;
        Fri, 11 Mar 2022 07:13:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxF1p8vYaPsGGWXPVhq1rKebNuUfAXFb6IM7QNaAbWl1xxDgUKrEGd9EWutPRE/7Om4UVteew==
X-Received: by 2002:a17:907:6d19:b0:6db:89c8:52e3 with SMTP id sa25-20020a1709076d1900b006db89c852e3mr6979151ejc.754.1647011609855;
        Fri, 11 Mar 2022 07:13:29 -0800 (PST)
Received: from ?IPV6:2a0e:5700:4:11:334c:7e36:8d57:40cb? ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id c5-20020a170906d18500b006ce371f09d4sm3097850ejz.57.2022.03.11.07.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 07:13:29 -0800 (PST)
Message-ID: <e8fde19d-02c3-50e5-ca15-c2b475259a41@redhat.com>
Date:   Fri, 11 Mar 2022 16:13:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/3] x86/PCI: Preserve host bridge windows completely
 covered by E820
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        =?UTF-8?Q?Benoit_Gr=c3=a9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, wse@tuxedocomputers.com
References: <20220304153245.GA1030861@bhelgaas>
 <86b17447-b285-f6ce-99d8-f2cad01405d5@redhat.com>
Content-Language: en-US
In-Reply-To: <86b17447-b285-f6ce-99d8-f2cad01405d5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/4/22 16:46, Hans de Goede wrote:
> Hi,
> 
> On 3/4/22 16:32, Bjorn Helgaas wrote:
>> On Fri, Mar 04, 2022 at 03:16:42PM +0100, Hans de Goede wrote:
>>> Hi Bjorn,
>>>
>>> On 3/4/22 04:51, Bjorn Helgaas wrote:
>>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>>
>>>> Many folks have reported PCI devices not working.  It could affect any
>>>> device, but most reports are for Thunderbolt controllers on Lenovo Yoga and
>>>> Clevo Barebone laptops and the touchpad on Lenovo IdeaPads.
>>>>
>>>> In every report, a region in the E820 table entirely encloses a PCI host
>>>> bridge window from _CRS, and because of 4dc2287c1805 ("x86: avoid E820
>>>> regions when allocating address space"), we ignore the entire window,
>>>> preventing us from assigning space to PCI devices.
>>>>
>>>> For example, the dmesg log [2] from bug report [1] shows:
>>>>
>>>>   BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>>>>   pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
>>>>   pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
>>>>
>>>> The efi=debug dmesg log [3] from the same report shows the EFI memory map
>>>> entries that created the E820 map:
>>>>
>>>>   efi: mem47: [Reserved |   |WB|WT|WC|UC] range=[0x4bc50000-0x5fffffff]
>>>>   efi: mem48: [Reserved |   |WB|  |  |UC] range=[0x60000000-0x60ffffff]
>>>>   efi: mem49: [Reserved |   |  |  |  |  ] range=[0x61000000-0x653fffff]
>>>>   efi: mem50: [MMIO     |RUN|  |  |  |UC] range=[0x65400000-0xcfffffff]
>>>>
>>>> 4dc2287c1805 ("x86: avoid E820 regions when allocating address space")
>>>> works around issues where _CRS contains non-window address space that can't
>>>> be used for PCI devices.  It does this by removing E820 regions from host
>>>> bridge windows.  But in these reports, the E820 region covers the entire
>>>> window, so 4dc2287c1805 makes it completely unusable.
>>>>
>>>> Per UEFI v2.8, sec 7.2, the EfiMemoryMappedIO type means:
>>>>
>>>>   Used by system firmware to request that a memory-mapped IO region be
>>>>   mapped by the OS to a virtual address so it can be accessed by EFI
>>>>   runtime services.
>>>>
>>>> A host bridge window is definitely a memory-mapped IO region, and EFI
>>>> runtime services may need to access it, so I don't think we can argue that
>>>> this is a firmware defect.
>>>>
>>>> Instead, change the 4dc2287c1805 strategy so it only removes E820 regions
>>>> when they overlap *part* of a host bridge window on the assumption that a
>>>> partial overlap is really register space, not part of the window proper.
>>>>
>>>> If an E820 region covers the entire window from _CRS, assume the _CRS
>>>> window is correct and do nothing.
>>>>
>>>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1868899
>>>> [2] https://bugzilla.redhat.com/attachment.cgi?id=1711424
>>>> [3] https://bugzilla.redhat.com/attachment.cgi?id=1861407
>>>>
>>>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
>>>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214259
>>>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
>>>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
>>>> BugLink: https://bugs.launchpad.net/bugs/1878279
>>>> BugLink: https://bugs.launchpad.net/bugs/1931715
>>>> BugLink: https://bugs.launchpad.net/bugs/1932069
>>>> BugLink: https://bugs.launchpad.net/bugs/1921649
>>>> Fixes: 4dc2287c1805 ("x86: avoid E820 regions when allocating address space")
>>>> Link: https://lore.kernel.org/r/20220228105259.230903-1-hdegoede@redhat.com
>>>> Based-on-patch-by: Hans de Goede <hdegoede@redhat.com>
>>>> Reported-by: Benoit Grégoire <benoitg@coeus.ca>   # BZ 206459
>>>> Reported-by: wse@tuxedocomputers.com              # BZ 214259
>>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>> ---
>>>>  arch/x86/kernel/resource.c | 11 +++++++++++
>>>>  1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
>>>> index 7378ea146976..405f0af53e3d 100644
>>>> --- a/arch/x86/kernel/resource.c
>>>> +++ b/arch/x86/kernel/resource.c
>>>> @@ -39,6 +39,17 @@ void remove_e820_regions(struct device *dev, struct resource *avail)
>>>>  		e820_start = entry->addr;
>>>>  		e820_end = entry->addr + entry->size - 1;
>>>>  
>>>> +		/*
>>>> +		 * If an E820 entry covers just part of the resource, we
>>>> +		 * assume E820 is telling us about something like host
>>>> +		 * bridge register space that is unavailable for PCI
>>>> +		 * devices.  But if it covers the *entire* resource, it's
>>>> +		 * more likely just telling us that this is MMIO space, and
>>>> +		 * that doesn't need to be removed.
>>>> +		 */
>>>> +		if (e820_start <= avail->start && avail->end <= e820_end)
>>>> +			continue;
>>>> +
>>>
>>> IMHO it would be good to add some logging here, since hitting this is
>>> somewhat of a special case. For the Fedora test kernels I did I changed
>>> this to:
>>>
>>> 		if (e820_start <= avail->start && avail->end <= e820_end) {
>>> 			dev_info(dev, "resource %pR fully covered by e820 entry [mem %#010Lx-%#010Lx]\n",
>>> 				 avail, e820_start, e820_end);
>>> 			continue;
>>> 		}
>>>
>>> And I expect/hope to see this new info message on the ideapad with the
>>> touchpad issue.
>>
>> Right, I would expect the same.
>>
>> We could add something like this.  But both the e820 entry and the
>> host bridge window are already in the dmesg log, so it doesn't really
>> add new information
> 
> Well it adds the information that the workaround (to the workaround)
> which we added for this case is working as expected and it allows
> seeing that is the case in a single glance.

I just got a report back from the Fedora test 5.16.12 kernel
with this series added on the X1C2 which had the suspend/resume
regression with my DMI_BIOS_DATE based approach. Everything still
works well there and it shows the new log messages from 2/3 in action:

[    0.326504] acpi PNP0A08:00: clipped [mem 0xdfa00000-0xfebfffff window] to [mem 0xdfa10000-0xfebfffff window] for e820 entry [mem 0xdceff000-0xdfa0ffff]
[    0.326515] acpi PNP0A08:00: clipped [mem 0xdfa10000-0xfebfffff window] to [mem 0xdfa10000-0xf7ffffff window] for e820 entry [mem 0xf8000000-0xfbffffff]

Regards,

Hans


