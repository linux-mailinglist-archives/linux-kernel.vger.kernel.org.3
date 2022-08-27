Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFE45A37B0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 14:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbiH0MrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 08:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiH0Mo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 08:44:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70C11D6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661604283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zNyRZOkSzWJ9EYhoio6oWAIWSR6y4SVpHgKEpnVly0g=;
        b=SXicbRaX7ruTJV5B7Hx1IVqnCtSvZSyIHmzAtV4r14+J3b2H00Iv+qp1aurbByglTQBBfZ
        KvwGjBAnwmB5LEa8udLSfC45ER5uqgcq2fOVWwdZsXBhOzRAES8YzuXPapTJV3M5LpZmET
        z4rsrYQ9O0AUqV54A784CoCxztsKSLs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-316-bTHQ3Ps1NkODmQhz3J5vbw-1; Sat, 27 Aug 2022 08:44:42 -0400
X-MC-Unique: bTHQ3Ps1NkODmQhz3J5vbw-1
Received: by mail-ed1-f69.google.com with SMTP id w17-20020a056402269100b0043da2189b71so2656192edd.6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 05:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=zNyRZOkSzWJ9EYhoio6oWAIWSR6y4SVpHgKEpnVly0g=;
        b=tSfE9eGMteISLYLoF26dJRFzeyzRMSaMZ6LbyxfhYNsGsRnX5e/4itsyvLOKG1FswQ
         XmSQlsanadxnis07KwY8jTcA1vMRuVAT6XQPAQmxvAcR17pslQrwgcE458QwzSCqk+iK
         U/kujOIo0Gwv+s87jqv+EjC2KNAo3rqHhuMlHWgDp9fQTHfIOFX/373o6I6w4Snd1xss
         kc1SDBjFyUwRhU9gGdj7jN5RFDHZkurhecfcOc5l75W/Bl4wZB+u4XpLaVQwq82YAqGM
         kOObjVlKb2GN8IXlky9WEgJufXhgRbzS2Z3K+E3FZApJdh7kKi0yzywBD01lx6oW03NU
         oyYw==
X-Gm-Message-State: ACgBeo2vRuMKXXuoJ2qCx+B3xuq3EViJj0u5+9KfavrlBeKOaw27xYnI
        /NNTFAhJh0gG4aHYujRW4sjjZHvU1t6RCxq8mOc7sBrHKmZYeQ9HMRiG9E57OchgxfFQPl6iqB/
        3junlamGiMRbntGdDqRswY3vi
X-Received: by 2002:a05:6402:1769:b0:447:911f:976b with SMTP id da9-20020a056402176900b00447911f976bmr10127040edb.300.1661604281215;
        Sat, 27 Aug 2022 05:44:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6vj29lcPuFbHHTDDtHSn5P5zzs852lz2t1xrhic61Dz/N0SAO3ArNPy/BmYfioHP+NzD+7QA==
X-Received: by 2002:a05:6402:1769:b0:447:911f:976b with SMTP id da9-20020a056402176900b00447911f976bmr10127018edb.300.1661604280989;
        Sat, 27 Aug 2022 05:44:40 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f23-20020a05640214d700b0043ba437fe04sm2758020edx.78.2022.08.27.05.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 05:44:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Liu <wei.liu@kernel.org>,
        Deepak Rawat <drawat.floss@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v2 2/3] Drivers: hv: Always reserve framebuffer region
 for Gen1 VMs
In-Reply-To: <SN6PR2101MB1693BDB6EF855BCE594AE376D7729@SN6PR2101MB1693.namprd21.prod.outlook.com>
References: <20220825090024.1007883-1-vkuznets@redhat.com>
 <20220825090024.1007883-3-vkuznets@redhat.com>
 <SN6PR2101MB1693BDB6EF855BCE594AE376D7729@SN6PR2101MB1693.namprd21.prod.outlook.com>
Date:   Sat, 27 Aug 2022 14:44:39 +0200
Message-ID: <87mtbpvoso.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Kelley (LINUX)" <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Thursday, August 25, 2022 2:00 AM
>> 
>> vmbus_reserve_fb() tries reserving framebuffer region iff
>> 'screen_info.lfb_base' is set. Gen2 VMs seem to have it set by EFI fb
>
> Just so I'm clear, by "EFI fb" you mean the EFI layer code that sets
> up the frame buffer before the Linux kernel ever boots, right?
> You are not referring to the Linux kernel EFI framebuffer
> driver, which may or may not be configured in the kernel.

My very shallow understanding is that initially, screen_info comes from
boot_params and this depends on how Linux was booted. Kernel EFI
framebuffer (when enabled), however, gets it first and can modify it
(see efifb_setup()) before we get to analyze it in Vmbus.

>
>> (or, in some edge cases like kexec, the address where the buffer was
>> moved, see https://lore.kernel.org/all/20201014092429.1415040-1-kasong@redhat.com/
>> but on Gen1 VM it depends on bootloader behavior. With grub, it depends
>> on 'gfxpayload=' setting but in some cases it is observed to be zero.
>> Relying on 'screen_info.lfb_base' to reserve framebuffer region is
>> risky. Instead, it is possible to get the address from the dedicated
>> PCI device which is always present.
>> 
>> Check for legacy PCI video device presence and reserve the whole
>> region for framebuffer on Gen1 VMs.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  drivers/hv/vmbus_drv.c | 46 +++++++++++++++++++++++++++++-------------
>>  1 file changed, 32 insertions(+), 14 deletions(-)
>> 
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index 23c680d1a0f5..536f68e563c6 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -35,6 +35,7 @@
>>  #include <linux/kernel.h>
>>  #include <linux/syscore_ops.h>
>>  #include <linux/dma-map-ops.h>
>> +#include <linux/pci.h>
>>  #include <clocksource/hyperv_timer.h>
>>  #include "hyperv_vmbus.h"
>> 
>> @@ -2262,26 +2263,43 @@ static int vmbus_acpi_remove(struct acpi_device *device)
>> 
>>  static void vmbus_reserve_fb(void)
>>  {
>> -	int size;
>> +	resource_size_t start = 0, size;
>> +	struct pci_dev *pdev;
>> +
>> +	if (efi_enabled(EFI_BOOT)) {
>> +		/* Gen2 VM: get FB base from EFI framebuffer */
>> +		start = screen_info.lfb_base;
>> +		size = max_t(__u32, screen_info.lfb_size, 0x800000);
>> +	} else {
>> +		/* Gen1 VM: get FB base from PCI */
>> +		pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
>> +				      PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
>> +		if (!pdev)
>> +			return;
>> +
>> +		if (pdev->resource[0].flags & IORESOURCE_MEM) {
>> +			start = pci_resource_start(pdev, 0);
>> +			size = pci_resource_len(pdev, 0);
>> +		}
>> +
>> +		/*
>> +		 * Release the PCI device so hyperv_drm or hyperv_fb driver can
>> +		 * grab it later.
>> +		 */
>> +		pci_dev_put(pdev);
>> +	}
>> +
>> +	if (!start)
>> +		return;
>> +
>>  	/*
>>  	 * Make a claim for the frame buffer in the resource tree under the
>>  	 * first node, which will be the one below 4GB.  The length seems to
>>  	 * be underreported, particularly in a Generation 1 VM.  So start out
>>  	 * reserving a larger area and make it smaller until it succeeds.
>>  	 */
>> -
>> -	if (screen_info.lfb_base) {
>> -		if (efi_enabled(EFI_BOOT))
>> -			size = max_t(__u32, screen_info.lfb_size, 0x800000);
>> -		else
>> -			size = max_t(__u32, screen_info.lfb_size, 0x4000000);
>> -
>> -		for (; !fb_mmio && (size >= 0x100000); size >>= 1) {
>> -			fb_mmio = __request_region(hyperv_mmio,
>> -						   screen_info.lfb_base, size,
>> -						   fb_mmio_name, 0);
>> -		}
>> -	}
>> +	for (; !fb_mmio && (size >= 0x100000); size >>= 1)
>> +		fb_mmio = __request_region(hyperv_mmio, start, size, fb_mmio_name, 0);
>>  }
>> 
>>  /**
>> --
>> 2.37.1
>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>

Thanks!

-- 
Vitaly

