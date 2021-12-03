Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2C146765A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242972AbhLCLc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:32:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26372 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232921AbhLCLc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638530974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i+CIEvgg++DU+7jpob1iXyG3lXaTsLjuBqRp72NQIfk=;
        b=BHV3+sb3Dd0BySnWBmV97fAAw3kRF4TN0b9cZfMiw3+mDWvBkBcp0RPWxkRoHtCkGL89T2
        3aoGN/99DWDGJaOvcjGGnHq4j+SXgrceuR5RXJD2baJHiT4TNUGwE4u9CYpR0bPAFEz4NH
        +3OlCBhad7uZIhRjHpf72J+uNadgjVc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-CCM5oN7aMjuRur_5t8vM_w-1; Fri, 03 Dec 2021 06:29:33 -0500
X-MC-Unique: CCM5oN7aMjuRur_5t8vM_w-1
Received: by mail-ed1-f69.google.com with SMTP id l15-20020a056402124f00b003e57269ab87so2317833edw.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 03:29:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i+CIEvgg++DU+7jpob1iXyG3lXaTsLjuBqRp72NQIfk=;
        b=3CQJZIY5d/IL/8c98bOOo8si6ighiqwAIfnT64aBFeLPqmbhZRBTsFBCehq04/HQ9D
         GPh+LM9rHE3S8Mv815/5SsPNYNSugi0J0o6xESuuSJCyt+JBKteVkkdFQ311so+sb2Rc
         LYLTpwKw7PO/Byc2c8nmNsNdG4noPWM+Jmf5NIZAY0+XtCM41FF/tjJhZlv+/8dkBYjd
         eUH8u1JvI8Fi+reNj0GGyssp80yoxk3YilETec2ZxgROJv4B+T8tj1g22ZoOkdpuZOCw
         W2rzwdUSKyJUbBM5GMzPFMBq8erKb/9OUuxCbH15p/WtH4LjoTDxtGLQSM+gD8P1HC7b
         rbLg==
X-Gm-Message-State: AOAM530Ml6w8D2WGFADJ4jYS40vBH/IqKTN47LWDcX/RsrZjaXVXtBAm
        APNL//YANjpIO3A8W9VVrjzXPYMhuuptCy6SNBSn52Fe5vpoK2ah6ccNgLCVeVKSHmXu1p9GIxn
        E5zzYGJ3CMA8C+iGub7uLd+Lh
X-Received: by 2002:a17:907:7f18:: with SMTP id qf24mr22912309ejc.568.1638530972318;
        Fri, 03 Dec 2021 03:29:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyljo0yzyit+aVuiSXzB3zF77d7gRe2Vqs+2cSCDKlXjj7zW5AkwPH+bRMAsPpMUAOo2IFmKw==
X-Received: by 2002:a17:907:7f18:: with SMTP id qf24mr22912286ejc.568.1638530972159;
        Fri, 03 Dec 2021 03:29:32 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id aq6sm1770485ejc.41.2021.12.03.03.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 03:29:31 -0800 (PST)
Message-ID: <c9e9b173-022c-696f-699a-1a4d4d369255@redhat.com>
Date:   Fri, 3 Dec 2021 12:29:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] mfd: intel-lpss: Fix I2C4 not being available on the
 Microsoft Surface Go & Go 2
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, Dan Scally <djrscally@gmail.com>,
        Kate Hsuan <hpa@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>
References: <20211202201351.74419-1-hdegoede@redhat.com>
 <Yakv+JF+euUlE1Tv@pendragon.ideasonboard.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Yakv+JF+euUlE1Tv@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 12/2/21 21:43, Laurent Pinchart wrote:
> Hi Hans,
> 
> Thank you for the patch.
> 
> On Thu, Dec 02, 2021 at 09:13:51PM +0100, Hans de Goede wrote:
>> Many DSDTs for Kaby Lake and Kaby Lake Refresh models contain a
>> _SB.PCI0.GEXP ACPI Device node describing an I2C attached GPIO expander.
>>
>> This seems to be something which is copy and pasted from the DSDT
>> from some reference design since this ACPI Device is present even on
>> models where no such GPIO expander is used at all, such as on the
>> Microsoft Surface Go & Go 2.
>>
>> This ACPI Device is a problem because it contains a SystemMemory
>> OperationRegion which covers the MMIO for the I2C4 I2C controller this
> 
> s/this/that/ (or ". This" ?)

I've gone with ". This" for v2.


> 
>> causes the MFD cell for the I2C4 controller to not be instantiated due
>> to a resource conflict, requiring the use of acpi_enforce_resources=lax
>> to work around this.
>>
>> I have done an extensive analysis of all the ACPI tables on the
>> Microsoft Surface Go and the _SB.PCI0.GEXP ACPI Device's methods are
>> not used by any code in the ACPI tables, neither are any of them
>> directly called by any Linux kernel code. This is unsurprising since
>> running i2cdetect on the I2C4 bus shows that there is no GPIO
>> expander chip present on these devices at all.
>>
>> This commit adds a PCI subsystem vendor:device table listing PCI devices
>> where it is known to be safe to ignore a resource-conflicts with ACPI
>> declared SystemMemory regions.
>>
>> This makes the I2C4 bus work out of the box on the Microsoft Surface
>> Go & Go 2, which is necessary for the cameras on these devices to work.
> 
> This will make the life of the Go and Go2 users *much* easier.
> 
>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Cc: Dan Scally <djrscally@gmail.com>
>> Cc: Kate Hsuan <hpa@redhat.com>
>> Cc: Maximilian Luz <luzmaximilian@gmail.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/mfd/intel-lpss-pci.c | 12 ++++++++++++
>>  drivers/mfd/intel-lpss.c     |  1 +
>>  drivers/mfd/intel-lpss.h     |  1 +
>>  3 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
>> index a872b4485eac..593290ff08a6 100644
>> --- a/drivers/mfd/intel-lpss-pci.c
>> +++ b/drivers/mfd/intel-lpss-pci.c
>> @@ -17,6 +17,15 @@
>>  
>>  #include "intel-lpss.h"
>>  
>> +/* Some DSDTs have an unused GEXP ACPI device conflicting with I2C4 resources */
>> +static const struct pci_device_id ignore_resource_conflicts_ids[] = {
>> +	/* Microsoft Surface Go (version 1) I2C4 */
>> +	{ PCI_DEVICE_SUB(0x8086, 0x9d64, 0x152d, 0x1182), },
>> +	/* Microsoft Surface Go 2 I2C4 */
>> +	{ PCI_DEVICE_SUB(0x8086, 0x9d64, 0x152d, 0x1237), },
>> +	{ }
> 
> Reading the commit message, I was going to mention that the match should
> probably be machine-dependent, but that seems to be covered by the PCI
> subsystem ID.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks you.

Regards,

Hans


> 
>> +};
>> +
>>  static int intel_lpss_pci_probe(struct pci_dev *pdev,
>>  				const struct pci_device_id *id)
>>  {
>> @@ -35,6 +44,9 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
>>  	info->mem = &pdev->resource[0];
>>  	info->irq = pdev->irq;
>>  
>> +	if (pci_match_id(ignore_resource_conflicts_ids, pdev))
>> +		info->ignore_resource_conflicts = true;
>> +
>>  	pdev->d3cold_delay = 0;
>>  
>>  	/* Probably it is enough to set this for iDMA capable devices only */
>> diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
>> index 0e15afc39f54..cfbee2cfba6b 100644
>> --- a/drivers/mfd/intel-lpss.c
>> +++ b/drivers/mfd/intel-lpss.c
>> @@ -401,6 +401,7 @@ int intel_lpss_probe(struct device *dev,
>>  		return ret;
>>  
>>  	lpss->cell->swnode = info->swnode;
>> +	lpss->cell->ignore_resource_conflicts = info->ignore_resource_conflicts;
>>  
>>  	intel_lpss_init_dev(lpss);
>>  
>> diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
>> index 22dbc4aed793..062ce95b68b9 100644
>> --- a/drivers/mfd/intel-lpss.h
>> +++ b/drivers/mfd/intel-lpss.h
>> @@ -19,6 +19,7 @@ struct software_node;
>>  
>>  struct intel_lpss_platform_info {
>>  	struct resource *mem;
>> +	bool ignore_resource_conflicts;
>>  	int irq;
>>  	unsigned long clk_rate;
>>  	const char *clk_con_id;
> 

