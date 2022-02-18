Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1484F4BBC20
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbiBRP1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:27:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiBRP13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:27:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C744D1C9184
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645198031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rYb+BCPyLsby6zJoGkmOBz+36TaLQgOr0GISja/FGo4=;
        b=DtaAaNQC+Xh6/FPc6qvefvAN2uNL2FNm0COOFAhYSVoZgC6MR8ylFgY0rQtiUfci1Mh1mH
        H10sPIuPNNAvW7VQUmUcnFww4CECZ6sVo2hwB7YvbzaYFeVypZy34yaYZSDRVu7AEobynb
        YdNHJ+S5uzgR9D/yZlHRpHntCSEFzYk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-VLY_8kVnO9ueyG5JKUWiHA-1; Fri, 18 Feb 2022 10:27:10 -0500
X-MC-Unique: VLY_8kVnO9ueyG5JKUWiHA-1
Received: by mail-qv1-f72.google.com with SMTP id 3-20020a0562140d0300b0042d7c7ac26aso9165007qvh.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:27:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rYb+BCPyLsby6zJoGkmOBz+36TaLQgOr0GISja/FGo4=;
        b=1//KHIWMXTOaoJQeh9JZY0VsEPVx153YjNgtXALmo2tuUzNBMgT93pbp0ShV5i+xfA
         7eExirPThSaUFQ7LpfabJHkbc0IY9qnwluBAbCV9l9eSXfdS1ZZ5EfIJgAEl5v4CfazQ
         vHZlpVS9sPjD+X5oEulqu25DOG9XQv2AD1XbUNKm6rkThLETYRSnLdDRgVuFq/5RKqWD
         5l8n4Ka3X5uEl3lGCatOLoTeHAXkn0kKn2/jUeDDVi/uhNwR3UQrmWlh5UFwmuK9rWwp
         nka9KOPwlR9O8BoNmFp0tyAWjdtxn0ZxRKc7kHT12kBRPX90pjNhzl6Pj7KzlgszzuvE
         FLfQ==
X-Gm-Message-State: AOAM532zD1/FJEMG/bw6Jx1Vy+BSzZH4pYiI3PS/KbyW/AJdYqG39rKU
        NjndYEcjqBtqxoCH5WQD0qEU5TeGdkHtqyLaZIr/JCTRo2WdZJCP5Qc85uPLJzMKVio6DFss/vK
        /ojMLa0P8/I9k3WrmK7PEl/DB
X-Received: by 2002:a05:6214:23ce:b0:42c:ead:30bf with SMTP id hr14-20020a05621423ce00b0042c0ead30bfmr6091954qvb.122.1645198030346;
        Fri, 18 Feb 2022 07:27:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwso/6LGXeV4Zu4ZnP/5E/1c8n8lvSxGwqKvfcp8q2OR1q1XJmk90Bq+AluwKPgLZkbfahlAg==
X-Received: by 2002:a05:6214:23ce:b0:42c:ead:30bf with SMTP id hr14-20020a05621423ce00b0042c0ead30bfmr6091932qvb.122.1645198030110;
        Fri, 18 Feb 2022 07:27:10 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id t11sm16975190qkp.82.2022.02.18.07.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 07:27:09 -0800 (PST)
Subject: Re: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-8-tianfei.zhang@intel.com>
 <ed8f4b5f-5c92-f555-ed2d-c5b8f38d5372@redhat.com>
 <BN9PR11MB5483BC7EE52A47CEAEFC58A0E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3c9fce03-ef29-d80f-6639-0c237c28cf58@redhat.com>
Date:   Fri, 18 Feb 2022 07:27:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5483BC7EE52A47CEAEFC58A0E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/18/22 1:03 AM, Zhang, Tianfei wrote:
>
>> -----Original Message-----
>> From: Tom Rix <trix@redhat.com>
>> Sent: Wednesday, February 16, 2022 12:16 AM
>> To: Zhang, Tianfei <tianfei.zhang@intel.com>; Wu, Hao <hao.wu@intel.com>;
>> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.org;
>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org
>> Cc: corbet@lwn.net; Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> Subject: Re: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
>>
>>
>> On 2/14/22 3:26 AM, Tianfei zhang wrote:
>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>
>>> Add the PCI product id for an Open FPGA Stack PCI card.
>> Is there a URL to the card ?
> This PCIe Device IDs have registered by Intel.
A URL is useful to introduce the board, Is there one ?
>
>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>>> ---
>>>    drivers/fpga/dfl-pci.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c index
>>> 83b604d6dbe6..cb2fbf3eb918 100644
>>> --- a/drivers/fpga/dfl-pci.c
>>> +++ b/drivers/fpga/dfl-pci.c
>>> @@ -76,12 +76,14 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
>>>    #define PCIE_DEVICE_ID_INTEL_PAC_D5005		0x0B2B
>>>    #define PCIE_DEVICE_ID_SILICOM_PAC_N5010	0x1000
>>>    #define PCIE_DEVICE_ID_SILICOM_PAC_N5011	0x1001
>>> +#define PCIE_DEVICE_ID_INTEL_OFS		0xbcce
>> INTEL_OFS is a generic name, pci id's map to specific cards
>>
>> Is there a more specific name for this card ?
> I think using INTEL_OFS is better, because INTEL_OFS is the Generic development platform can support multiple cards which using OFS specification,
> like Intel PAC N6000 card.

I would prefer something like PCIE_DEVICE_ID_INTEL_PAC_N6000 because it 
follows an existing pattern.  Make it easy on a developer, they will 
look at their board or box, see X and try to find something similar in 
the driver source.

To use OSF_ * the name needs a suffix to differentiate it from future 
cards that will also use ofs.

If this really is a generic id please explain in the doc patch how every 
future board with use this single id and how a driver could work around 
a hw problem in a specific board with a pci id covering multiple boards.

Tom

>
>> Tom
>>
>>>    /* VF Device */
>>>    #define PCIE_DEVICE_ID_VF_INT_5_X		0xBCBF
>>>    #define PCIE_DEVICE_ID_VF_INT_6_X		0xBCC1
>>>    #define PCIE_DEVICE_ID_VF_DSC_1_X		0x09C5
>>>    #define PCIE_DEVICE_ID_INTEL_PAC_D5005_VF	0x0B2C
>>> +#define PCIE_DEVICE_ID_INTEL_OFS_VF		0xbccf
>>>
>>>    static struct pci_device_id cci_pcie_id_tbl[] = {
>>>    	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_INT_5_X),},
>> @@
>>> -95,6 +97,8 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
>>>    	{PCI_DEVICE(PCI_VENDOR_ID_INTEL,
>> PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
>>>    	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK,
>> PCIE_DEVICE_ID_SILICOM_PAC_N5010),},
>>>    	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK,
>>> PCIE_DEVICE_ID_SILICOM_PAC_N5011),},
>>> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_OFS),},
>>> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL,
>> PCIE_DEVICE_ID_INTEL_OFS_VF),},
>>>    	{0,}
>>>    };
>>>    MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);

