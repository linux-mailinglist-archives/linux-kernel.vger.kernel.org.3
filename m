Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DDB48619D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 09:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbiAFIqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 03:46:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231734AbiAFIqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 03:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641458772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gvQUSb/0wOHx0uoupA3dD1uksuFYjOrSDNBoPbsie0g=;
        b=FjVNdi+F+qlVViusI9U17Nzi17tnbTxMn6/F8MXR2Al0SEuX3KYKtvVureFubgC5RxQlnA
        SKWvS9U27EXAke34gxif2lKfg8B07umG2/d63QsKEkpo6Aa6TYzSUTnlBK7JsT68pAnlAg
        /Ujf9S1Nlfgn4LAHgYaRCr1HYnFEC3k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-5EVMkhBsNiW53ZSmVgiIjQ-1; Thu, 06 Jan 2022 03:46:11 -0500
X-MC-Unique: 5EVMkhBsNiW53ZSmVgiIjQ-1
Received: by mail-wm1-f70.google.com with SMTP id m15-20020a7bce0f000000b003473d477618so219195wmc.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 00:46:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gvQUSb/0wOHx0uoupA3dD1uksuFYjOrSDNBoPbsie0g=;
        b=Pom8ffBEl5FesU6qQEQK0uDzBk1fjkA5zNsyN69DIaAcnCCoFBDCTWje8U41c+bIaq
         5SDc3X7t4W/TRXZin8I7WvTd6KOADnH1ZPZqHxvwlLVdLWl6nLjJoVLQ1pUX5zmrmf30
         pohPBpndj7UNbQxWikWwsXhGbT+nauDr9CkqizrSC2paCC0TXb/DzAVMpzsu6FF5sZn8
         DGUsRW8/cEJqTaAvn/HJhBNNEaqByK4HNK2jIdgl04VeagL8mGC2NPleV5CCZmxbhuS7
         5bCFGkP9erVSUl5uY7q8R/dULRMZJKd6BFIMhAh7BPVzxIJdc/7Sid1dHHWjk/7oxEUL
         83Iw==
X-Gm-Message-State: AOAM5309bVy53lzV1Nf5Ye0yVACuzAcnpfCOp+jjcIEOYQK0rN4cO635
        3kMVdYCAW9glxxASjVNvPOo/cePdkjVN/uHo8qgPpUNuWxCBPVai9UmhLP7K1+kbeaku9iP6kMD
        4Ou82EUGSkLBnelyuwzYHsFf+8gNYhTyXteAroyu6bKMjwXNdR4u80NudBlfnHm/j3EvEd5xgrx
        bA
X-Received: by 2002:a05:600c:3d0a:: with SMTP id bh10mr6214109wmb.70.1641458770098;
        Thu, 06 Jan 2022 00:46:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyEcf9Cm6E5x6qmVYkAar4ZCeJBJ75uNjCAsPgRUEYSNi6nQAK3vncUFSzctVZUS5VDFWgX7w==
X-Received: by 2002:a05:600c:3d0a:: with SMTP id bh10mr6214080wmb.70.1641458769809;
        Thu, 06 Jan 2022 00:46:09 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id v184sm4348777wme.2.2022.01.06.00.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 00:46:09 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>, David Hildenbrand <david@redhat.com>
Cc:     linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] Drivers: hv: balloon: Temporary disable the driver
 on ARM64 when PAGE_SIZE != 4k
In-Reply-To: <20220105202203.evk7uckmephnu3ev@liuwe-devbox-debian-v2>
References: <20220105165028.1343706-1-vkuznets@redhat.com>
 <20220105202203.evk7uckmephnu3ev@liuwe-devbox-debian-v2>
Date:   Thu, 06 Jan 2022 09:46:07 +0100
Message-ID: <87leztp7zk.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> On Wed, Jan 05, 2022 at 05:50:28PM +0100, Vitaly Kuznetsov wrote:
>> Hyper-V ballooning and memory hotplug protocol always seems to assume
>> 4k page size so all PFNs in the structures used for communication are
>> 4k PFNs. In case a different page size is in use on the guest (e.g.
>> 64k), things go terribly wrong all over:
>> - When reporting statistics, post_status() reports them in guest pages
>> and hypervisor sees very low memory usage.
>> - When ballooning, guest reports back PFNs of the allocated pages but
>> the hypervisor treats them as 4k PFNs.
>> - When unballooning or memory hotplugging, PFNs coming from the host
>> are 4k PFNs and they may not even be 64k aligned making it difficult
>> to handle.
>> 
>> While statistics and ballooning requests would be relatively easy to
>> handle by converting between guest and hypervisor page sizes in the
>> communication structures, handling unballooning and memory hotplug
>> requests seem to be harder. In particular, when ballooning up
>> alloc_balloon_pages() shatters huge pages so unballooning request can
>> be handled for any part of it. It is not possible to shatter a 64k
>> page into 4k pages so it's unclear how to handle unballooning for a
>> sub-range if such request ever comes so we can't just report a 64k
>> page as 16 separate 4k pages.
>> 
>
> How does virtio-balloon handle it? Does its protocol handle different
> page sizes?
>

Let's ask the expert)

David,

how does virtio-balloon (and virtio-mem) deal with different page sizes
between guest and host?

>
>> Ideally, the protocol between the guest and the host should be changed
>> to allow for different guest page sizes.
>> 
>> While there's no solution for the above mentioned problems, it seems
>> we're better off without the driver in problematic cases.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  drivers/hv/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
>> index 0747a8f1fcee..fb353a13e5c4 100644
>> --- a/drivers/hv/Kconfig
>> +++ b/drivers/hv/Kconfig
>> @@ -25,7 +25,7 @@ config HYPERV_UTILS
>>  
>>  config HYPERV_BALLOON
>>  	tristate "Microsoft Hyper-V Balloon driver"
>> -	depends on HYPERV
>> +	depends on HYPERV && (X86 || (ARM64 && ARM64_4K_PAGES))
>>  	select PAGE_REPORTING
>>  	help
>>  	  Select this option to enable Hyper-V Balloon driver.
>> -- 
>> 2.33.1
>> 
>

-- 
Vitaly

