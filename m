Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F58150CB3C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 16:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbiDWOil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 10:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiDWOij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 10:38:39 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4966AA41
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 07:35:41 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bq30so18976574lfb.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 07:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5Ob5FZ3XWHH7ndiX9e02UPLlc8ptKYdQZQQb2q10kFk=;
        b=edcQjFzK13CxlrO3DRi39U1HLX1VBiZdMToLxtPriW5w54rke5iEMAjcSbz0qLKiU1
         6Dg/+t7jlWN4zLOE4R7gc+Oiehyx44/fBegjF9CUPZTdazhsEq5kmlyBBIDrFcpJ2UXh
         39lAPieblL9SemJymxB3+VitLdVV4ID+j2PN+nuGr61uKUGz8IVRPkA+fobqsdBAqXKq
         ApWZOKdhVIcgtmhqGwlNCdGSukJgvhZDorgcmTlkv0mfPzZ/PfSWiA/hCgs5Wv2oL+vK
         XJZN28Yak1op0o0AkGamHUIANzbptaiH+ktbXi6pl22teiG63KGXxIYyM50hdzwzZcwU
         6EXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5Ob5FZ3XWHH7ndiX9e02UPLlc8ptKYdQZQQb2q10kFk=;
        b=v5fAXtOMLNsLkV+LbT/bHMU1SJ7kVfgmEeAOFy3SbhzlNukzDNVpdUvpDZfu/kfjb7
         XGgXDt22Mp1gNS8gt4nbA/kbmx2ZGzt2ZdMeqwrsZbgL2Do459qbOLLU5AP0dAe+eLDa
         2f8dhqDmxUd7sIkqgcNEGIVeb3MrcKcLIeBfUD3Ls7KS1wecdYNBRB2EiMgKmM/4vrYl
         FGclPv8YEQuaQGJj0IDoJgTPYtwgEgY2Huz+D1Yu6lRkvswMT0kKrbItcBbBBvdv9X6g
         wRJhX4srmZSlwvHZk/CMfTUjqfnKk0A61tRzCF6Hh0tduhJgi2Q70zHCwT1LrOY1H8Ro
         o6AQ==
X-Gm-Message-State: AOAM533okCZXzhPf+pjTSB+KimSmYTGg2/OFDIxScguohfGaI3nMKwKr
        haeMGyEH9446FN2BidpEkwo=
X-Google-Smtp-Source: ABdhPJzuBm8Fq2ksLNZubEsggwEds0YNor4simf+758e/Wch36unqYhiwGrQiA/w92oNFg+B4tk+9w==
X-Received: by 2002:a05:6512:2348:b0:471:92ac:3bfd with SMTP id p8-20020a056512234800b0047192ac3bfdmr6525788lfu.199.1650724539295;
        Sat, 23 Apr 2022 07:35:39 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id k10-20020a19560a000000b0046d1707fcbdsm640495lfb.215.2022.04.23.07.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 07:35:38 -0700 (PDT)
Subject: Re: [PATCH V1 1/6] arm/xen: Introduce xen_setup_dma_ops()
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Kees Cook <keescook@chromium.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-2-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2204221509220.915916@ubuntu-linux-20-04-desktop>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <a1112ea4-6eb9-f4ec-745d-e28c41fd1930@gmail.com>
Date:   Sat, 23 Apr 2022 17:35:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2204221509220.915916@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23.04.22 01:59, Stefano Stabellini wrote:


Hello Stefano


> On Fri, 22 Apr 2022, Oleksandr Tyshchenko wrote:
>> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>
>> This patch introduces new helper and places it in new header.
>> The helper's purpose is to assign any Xen specific DMA ops in
>> a single place. For now, we deal with xen-swiotlb DMA ops only.
>> The one of the subsequent commits in current series will add
>> xen-grant DMA ops case.
>>
>> Also re-use the xen_swiotlb_detect() check on Arm32.
>>
>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


Thanks!


checkpatch.pl suggests adding missing SPDX-License-Identifier to 
Arm/Arm64's xen-ops.h

I will retain your R-b tag after making this change. Please let me know 
if you think otherwise.



>> ---
>> Changes RFC -> V1:
>>     - update commit description
>>     - move commit to the beginning of the series
>>     - move #ifdef CONFIG_XEN from dma-mapping.c to xen-ops.h
>> ---
>>   arch/arm/include/asm/xen/xen-ops.h   |  1 +
>>   arch/arm/mm/dma-mapping.c            |  7 ++-----
>>   arch/arm64/include/asm/xen/xen-ops.h |  1 +
>>   arch/arm64/mm/dma-mapping.c          |  7 ++-----
>>   include/xen/arm/xen-ops.h            | 15 +++++++++++++++
>>   5 files changed, 21 insertions(+), 10 deletions(-)
>>   create mode 100644 arch/arm/include/asm/xen/xen-ops.h
>>   create mode 100644 arch/arm64/include/asm/xen/xen-ops.h
>>   create mode 100644 include/xen/arm/xen-ops.h
>>
>> diff --git a/arch/arm/include/asm/xen/xen-ops.h b/arch/arm/include/asm/xen/xen-ops.h
>> new file mode 100644
>> index 00000000..8d2fa24
>> --- /dev/null
>> +++ b/arch/arm/include/asm/xen/xen-ops.h
>> @@ -0,0 +1 @@
>> +#include <xen/arm/xen-ops.h>
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index 82ffac6..059cce0 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -33,7 +33,7 @@
>>   #include <asm/dma-iommu.h>
>>   #include <asm/mach/map.h>
>>   #include <asm/system_info.h>
>> -#include <xen/swiotlb-xen.h>
>> +#include <asm/xen/xen-ops.h>
>>   
>>   #include "dma.h"
>>   #include "mm.h"
>> @@ -2287,10 +2287,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>>   
>>   	set_dma_ops(dev, dma_ops);
>>   
>> -#ifdef CONFIG_XEN
>> -	if (xen_initial_domain())
>> -		dev->dma_ops = &xen_swiotlb_dma_ops;
>> -#endif
>> +	xen_setup_dma_ops(dev);
>>   	dev->archdata.dma_ops_setup = true;
>>   }
>>   
>> diff --git a/arch/arm64/include/asm/xen/xen-ops.h b/arch/arm64/include/asm/xen/xen-ops.h
>> new file mode 100644
>> index 00000000..8d2fa24
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/xen/xen-ops.h
>> @@ -0,0 +1 @@
>> +#include <xen/arm/xen-ops.h>
>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>> index 6719f9e..6099c81 100644
>> --- a/arch/arm64/mm/dma-mapping.c
>> +++ b/arch/arm64/mm/dma-mapping.c
>> @@ -9,9 +9,9 @@
>>   #include <linux/dma-map-ops.h>
>>   #include <linux/dma-iommu.h>
>>   #include <xen/xen.h>
>> -#include <xen/swiotlb-xen.h>
>>   
>>   #include <asm/cacheflush.h>
>> +#include <asm/xen/xen-ops.h>
>>   
>>   void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
>>   		enum dma_data_direction dir)
>> @@ -52,8 +52,5 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>>   	if (iommu)
>>   		iommu_setup_dma_ops(dev, dma_base, dma_base + size - 1);
>>   
>> -#ifdef CONFIG_XEN
>> -	if (xen_swiotlb_detect())
>> -		dev->dma_ops = &xen_swiotlb_dma_ops;
>> -#endif
>> +	xen_setup_dma_ops(dev);
>>   }
>> diff --git a/include/xen/arm/xen-ops.h b/include/xen/arm/xen-ops.h
>> new file mode 100644
>> index 00000000..288deb1
>> --- /dev/null
>> +++ b/include/xen/arm/xen-ops.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_ARM_XEN_OPS_H
>> +#define _ASM_ARM_XEN_OPS_H
>> +
>> +#include <xen/swiotlb-xen.h>
>> +
>> +static inline void xen_setup_dma_ops(struct device *dev)
>> +{
>> +#ifdef CONFIG_XEN
>> +	if (xen_swiotlb_detect())
>> +		dev->dma_ops = &xen_swiotlb_dma_ops;
>> +#endif
>> +}
>> +
>> +#endif /* _ASM_ARM_XEN_OPS_H */
>> -- 
>> 2.7.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
-- 
Regards,

Oleksandr Tyshchenko

