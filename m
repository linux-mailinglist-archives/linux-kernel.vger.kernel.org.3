Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7333B467665
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244911AbhLCLgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:36:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243608AbhLCLgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638531158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TQ7nLjc9VxHScYYLJMo0urs77TFXO3jNSnIUJwe6f0M=;
        b=ACwi/DbSFsFfr/Zvl4FscpzYCCqq8UDk+4gcPbNeduKDlorBemonPllXz+tZ2uQcXCJJmr
        fTDuB2jHHKGsbLbVI+uu5M/R7gS7et2Y/jpKALQTPn73bxrTXCBmGj57gIxRnuhsYWXolO
        ZrwJV7CAYxM36G8KG8QvImtUyoXfe2I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-xJuOvddSMjGr8xnfDFCGuw-1; Fri, 03 Dec 2021 06:32:37 -0500
X-MC-Unique: xJuOvddSMjGr8xnfDFCGuw-1
Received: by mail-ed1-f69.google.com with SMTP id s12-20020a50ab0c000000b003efdf5a226fso2302557edc.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 03:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TQ7nLjc9VxHScYYLJMo0urs77TFXO3jNSnIUJwe6f0M=;
        b=vDwWBAJ5S2YJHlXNhd46CFTK6mTzWF6cZ/u58OgqtmzkW+mabnBp7JHWWPHoH/7Nsp
         p2xdGKTxkJJUDPU6iCwN6JkQpVUUfiU7IqKB+ME8N6ktwFfWx3WchW1A/h9qa8Memjcc
         +ficxKDgO2o90rOtsLraUu/SQKgEpMpo0w6TmsuzszUQ0t0sNdTmr5TLsea2UkQMPynZ
         UDAQVWhLbLfOzjbZjYCMkYcuMy212quHULJ5ZyzsGSTYb0hlnyVzgtwzbSnAL3EbNWo5
         C/rDtBS2iA8u8ssgnslCFQEEiWVdyb8QwdlHpkpuUlZjIzdj/GOkznVWPYtzQPw+dAk/
         SEFg==
X-Gm-Message-State: AOAM533KpwGK6kpbQh6DgRzYuoeaZrVmWN7xYMVoBT5AlwRYh1F0ec7r
        +5RK6SvSgE8Oj9dw7V5L4jZN2SFdZIe2v2R7cBwLq+muGjiGHAcGUofbxhqF9+olV/R4diRl44k
        JrwqQN9uUdwEYXecfew2mLYRM
X-Received: by 2002:a17:906:794e:: with SMTP id l14mr23543980ejo.64.1638531156278;
        Fri, 03 Dec 2021 03:32:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkICAQL8GiTshlOn84TUIFQ4qNasCqonq3ts9RuZRQdzRqiyDTQxevK4ByWH8E+QBEw+HiEQ==
X-Received: by 2002:a17:906:794e:: with SMTP id l14mr23543961ejo.64.1638531156096;
        Fri, 03 Dec 2021 03:32:36 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id gs17sm1918722ejc.28.2021.12.03.03.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 03:32:35 -0800 (PST)
Message-ID: <a2d551d3-7426-1dff-9936-d4bde10c4a59@redhat.com>
Date:   Fri, 3 Dec 2021 12:32:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] mfd: intel-lpss: Fix I2C4 not being available on the
 Microsoft Surface Go & Go 2
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dan Scally <djrscally@gmail.com>, Kate Hsuan <hpa@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>
References: <20211202201351.74419-1-hdegoede@redhat.com>
 <CAHp75VctFk8xO4ddWi1V49eNp5+h_AOcRVv_=iMnjmVt0TOM5w@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VctFk8xO4ddWi1V49eNp5+h_AOcRVv_=iMnjmVt0TOM5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/2/21 22:15, Andy Shevchenko wrote:
> On Thu, Dec 2, 2021 at 10:14 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Many DSDTs for Kaby Lake and Kaby Lake Refresh models contain a
>> _SB.PCI0.GEXP ACPI Device node describing an I2C attached GPIO expander.
> 
> For the record (and probably good to mention it's here) it's a PCA953x
> compatible one.

Ack, added to the commit msg for v2.

>> This seems to be something which is copy and pasted from the DSDT
>> from some reference design since this ACPI Device is present even on
>> models where no such GPIO expander is used at all, such as on the
>> Microsoft Surface Go & Go 2.
> 
> Does this come from schematics? Or..? Ah, I see below.
> 
>> This ACPI Device is a problem because it contains a SystemMemory
>> OperationRegion which covers the MMIO for the I2C4 I2C controller this
>> causes the MFD cell for the I2C4 controller to not be instantiated due
>> to a resource conflict, requiring the use of acpi_enforce_resources=lax
>> to work around this.
> 
> Right.
> 
>> I have done an extensive analysis of all the ACPI tables on the
>> Microsoft Surface Go and the _SB.PCI0.GEXP ACPI Device's methods are
>> not used by any code in the ACPI tables, neither are any of them
>> directly called by any Linux kernel code. This is unsurprising since
>> running i2cdetect on the I2C4 bus shows that there is no GPIO
>> expander chip present on these devices at all.
> 
> I believe it's an optional component on our reference designs (I saw a
> lot of those expanders on our development boards).
> 
>> This commit adds a PCI subsystem vendor:device table listing PCI devices
>> where it is known to be safe to ignore a resource-conflicts with ACPI
> 
> ignore resource conflicts

Ack, fixed for v2.


> (no article, no dash) ?
> 
>> declared SystemMemory regions.
>>
>> This makes the I2C4 bus work out of the box on the Microsoft Surface
>> Go & Go 2, which is necessary for the cameras on these devices to work.
> 
> After addressing comments
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Thanks for the patch!
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
>> +       /* Microsoft Surface Go (version 1) I2C4 */
>> +       { PCI_DEVICE_SUB(0x8086, 0x9d64, 0x152d, 0x1182), },
>> +       /* Microsoft Surface Go 2 I2C4 */
>> +       { PCI_DEVICE_SUB(0x8086, 0x9d64, 0x152d, 0x1237), },
> 
> Can we use PCI_VENDOR_ID_INTEL?

Done for v2.

Thank you for the review.

Regards,

Hans

> 
>> +       { }
>> +};
>> +
>>  static int intel_lpss_pci_probe(struct pci_dev *pdev,
>>                                 const struct pci_device_id *id)
>>  {
>> @@ -35,6 +44,9 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
>>         info->mem = &pdev->resource[0];
>>         info->irq = pdev->irq;
>>
>> +       if (pci_match_id(ignore_resource_conflicts_ids, pdev))
>> +               info->ignore_resource_conflicts = true;
>> +
>>         pdev->d3cold_delay = 0;
>>
>>         /* Probably it is enough to set this for iDMA capable devices only */
>> diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
>> index 0e15afc39f54..cfbee2cfba6b 100644
>> --- a/drivers/mfd/intel-lpss.c
>> +++ b/drivers/mfd/intel-lpss.c
>> @@ -401,6 +401,7 @@ int intel_lpss_probe(struct device *dev,
>>                 return ret;
>>
>>         lpss->cell->swnode = info->swnode;
>> +       lpss->cell->ignore_resource_conflicts = info->ignore_resource_conflicts;
>>
>>         intel_lpss_init_dev(lpss);
>>
>> diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
>> index 22dbc4aed793..062ce95b68b9 100644
>> --- a/drivers/mfd/intel-lpss.h
>> +++ b/drivers/mfd/intel-lpss.h
>> @@ -19,6 +19,7 @@ struct software_node;
>>
>>  struct intel_lpss_platform_info {
>>         struct resource *mem;
>> +       bool ignore_resource_conflicts;
>>         int irq;
>>         unsigned long clk_rate;
>>         const char *clk_con_id;
>> --
>> 2.33.1
>>
> 
> 

