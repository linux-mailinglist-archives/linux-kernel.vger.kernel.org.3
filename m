Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81ABA4BBAE9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbiBROtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:49:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbiBROtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:49:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D99FD3FDAD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645195764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJfoFtjczcmtegK/n8NOa4kXtMnG6dmxGgGSDhaREok=;
        b=L1aOEiX8ekvF4D0sxy1/2zo2vDWvRBs0R1NdClF1c/MUNpnxlEuDjX1tQ5PgxAq57CvRO7
        cb1wbE792yLIOjbIS12bG9ioe0hCfgOfSkiLlNncYwfWJlh4izfvr9qXZepIkxp62VH1F0
        hOX4BgiVkgl9pMgJ3K0EwvnbgHR/D70=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-C3LSIdl8MqeClFKaJc9Tow-1; Fri, 18 Feb 2022 09:49:22 -0500
X-MC-Unique: C3LSIdl8MqeClFKaJc9Tow-1
Received: by mail-qv1-f70.google.com with SMTP id g2-20020a0562141cc200b004123b0abe18so9089756qvd.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 06:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gJfoFtjczcmtegK/n8NOa4kXtMnG6dmxGgGSDhaREok=;
        b=AOXMxK1Y7bGgY44wME5xXZRhVGF67RaWmjOKicngI+YKoHPdZhyHe0ToGc+LNS6kut
         mgr275LumZwSO3WxRy/Ili4I1jItVf8/L2wHXoBp3lF2BFXP6F6nj6/15g4TcQZlu4Qe
         JrLAbMtVb2Qqsfiy430erHbavUs++dJINJtvwH6tpEhHkMNkZoaPqLpVyZZICLlYSode
         ecbpetdfn86HVoyX5SR4raPXZxOQbQyP4fjXFkF80MYjc+L8l3f6Kczp1cG+BCYOYWo0
         8JM3acc77ILSFiaSJ6JlKLsfnzm1Yh3SVOxkrueoi+/lvr43P5wy1m+h0rbXaYWSvsv+
         OckA==
X-Gm-Message-State: AOAM530r4IFZui2iJdyoVn1h/tgNheTAjT6gzqjfFd31XMZe6iw2mrSZ
        8uc2N7mIXlFnf9OsNbXrtZMejFkOG6YkzbNDE9z4tva4TqYwYhGPjqhw3wUTUx37hjJXjdnQbB0
        ediTC07L1PUH8VZCqZBu+d4aH
X-Received: by 2002:a37:270c:0:b0:5f0:832f:6d81 with SMTP id n12-20020a37270c000000b005f0832f6d81mr4816606qkn.682.1645195762279;
        Fri, 18 Feb 2022 06:49:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQim60t2atOU27c1fu+yon22RzCPjCx8VCJ86EPIuz8BlqduYrSkDFoluOksZ0bKF6i3KRJg==
X-Received: by 2002:a37:270c:0:b0:5f0:832f:6d81 with SMTP id n12-20020a37270c000000b005f0832f6d81mr4816590qkn.682.1645195762039;
        Fri, 18 Feb 2022 06:49:22 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id d17sm22661042qkn.84.2022.02.18.06.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 06:49:21 -0800 (PST)
Subject: Re: [PATCH v1 3/7] fpga: dfl: Allow for ports with no local bar
 space.
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-4-tianfei.zhang@intel.com>
 <0fdd3d0d-d280-8104-eccc-8fa8d8a992c2@redhat.com>
 <BN9PR11MB548314968CBC0CA5E446B366E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <efee5ac0-4c3a-085d-9b9d-0c8ade022f30@redhat.com>
Date:   Fri, 18 Feb 2022 06:49:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB548314968CBC0CA5E446B366E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/17/22 11:31 PM, Zhang, Tianfei wrote:
>
>> -----Original Message-----
>> From: Tom Rix <trix@redhat.com>
>> Sent: Tuesday, February 15, 2022 11:06 PM
>> To: Zhang, Tianfei <tianfei.zhang@intel.com>; Wu, Hao <hao.wu@intel.com>;
>> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.org;
>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org
>> Cc: corbet@lwn.net; Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> Subject: Re: [PATCH v1 3/7] fpga: dfl: Allow for ports with no local bar space.
>>
>>
>> On 2/14/22 3:26 AM, Tianfei zhang wrote:
>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>
>>>   From a fpga partial reconfiguration standpoint, a port may not be
>>> connected any local BAR space.  The port could be connected to a
>>> different PCIe Physical Function (PF) or Virtual Function (VF), in
>>> which case another driver instance would manage the endpoint.
>> It is not clear if this is part of iofs or a bug fix.
> This is the new implementation/feature of IOFS.
> On IOFS support multiple methods to access the AFU.
> 1. Legacy Model. This is used for N3000 and N5000 card.
> In this model the entire AFU region is a unit of PR, and there is a Port device connected to this AFU.
> On DFL perspective, there is "Next AFU" point to the AFU, and the "BarID" is  the PCIe Bar ID of AFU.
> In this model, we can use the AFU APIs to access the entire AFU resource, like MMIO.
> 2. Micro-Personas in AFU.
> IOFS intruding new model for PR and AFU access.
> Micro-Personas allow the RTL developer to designate their own AFU-defined PR regions.
> In this model the unit of PR is not the entire AFU, instead
> the unit of PR can be any size block or blocks inside the AFU.
> 3. Multiple VFs per PR slot.
> In this method, we can instance multiple VFs over SRIOV for one PR slot, and access the AFU resource
> by different VFs in virtualization usage. In this case, the Port device would not connected to AFU (the BarID of Port device
> should be set to invalid), so this patch want to support this use model.

What I am looking for is how the older cards using (my term) dfl 1 will 
still work with dfl 2 and vice versa.

No where do I see a version check for dfl 2 nor a pci id check so either 
this just works or backward compatibility has not be considered.

Please add a backward compatibility section to the doc patch

>
>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>>> ---
>>>    drivers/fpga/dfl-pci.c | 8 ++++++++
>>>    1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c index
>>> 4d68719e608f..8abd9b408403 100644
>>> --- a/drivers/fpga/dfl-pci.c
>>> +++ b/drivers/fpga/dfl-pci.c
>>> @@ -243,6 +243,7 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
>>>    		v = readq(base + FME_HDR_CAP);
>>>    		port_num = FIELD_GET(FME_CAP_NUM_PORTS, v);
>>>
>>> +		dev_info(&pcidev->dev, "port_num = %d\n", port_num);
>>>    		WARN_ON(port_num > MAX_DFL_FPGA_PORT_NUM);
>>>
>>>    		for (i = 0; i < port_num; i++) {
>>> @@ -258,6 +259,13 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
>>>    			 */
>>>    			bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
>>>    			offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
>>> +			if (bar >= PCI_STD_NUM_BARS) {
>> Is bar set to a better magic number that pci_std_num_bars ? maybe 0xff's
>>
>> How do you tell between this case and broken hw ?
> Yes, I agree that magic number is better, Currently the RTL using PCI_STD_NUM_BARS for an invalid PCIe bar number.

How do you tell between this case and broken hw ?

Tom

>> Move up a line and skip getting an offset that will not be used.
> Yes, this line is not necessary, I will remove it on next version patch.
>
>>> +				dev_info(&pcidev->dev, "skipping port without
>> local BAR space %d\n",
>>> +					 bar);
>>> +				continue;
>>> +			} else {
>>> +				dev_info(&pcidev->dev, "BAR %d offset %u\n",
>> bar, offset);
>>> +			}
>>>    			start = pci_resource_start(pcidev, bar) + offset;
>>>    			len = pci_resource_len(pcidev, bar) - offset;
>>>
>> Is similar logic needed for else-if (port) block below this ?
> I think, the else-if is not necessary. I will remove it on next version patch.
>> Tom

