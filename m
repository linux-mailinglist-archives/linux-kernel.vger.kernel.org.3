Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1F849F663
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347629AbiA1JcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:32:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29991 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347612AbiA1Jb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643362317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f5A/C5kiEp1/LBNi9MRAUlEKU1cKas7e8kxGW0FiZoQ=;
        b=e3n7m06fy3/DQUrlNm5UtoAnXKOcDrs6sEjINzgiO4DYY09a4jOFgUtAl+mvTPtaulm8ss
        Qdhn1ewzUP535+kBMBQmVmKRYnpMKfKXkt+AZqdcmTAeaZmWR1Imz2Nx1cdLtnNQiOT80l
        TZFOX6ChP+jVMJyFzsRFcNSvev2CEBg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-zC8DlF5mPTOUW0hy1t-7iA-1; Fri, 28 Jan 2022 04:31:55 -0500
X-MC-Unique: zC8DlF5mPTOUW0hy1t-7iA-1
Received: by mail-ed1-f69.google.com with SMTP id f21-20020a50d555000000b00407a8d03b5fso2759406edj.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=f5A/C5kiEp1/LBNi9MRAUlEKU1cKas7e8kxGW0FiZoQ=;
        b=bGVzSUZVnav2fwUJjoJ7IZGl4xqYWuYi8xULZB2ycVzIn/c2qfkSxC83JDDMdATBLt
         8Gpj3bbU7h/vOpL6B4ERhpsxEv9CdyPxL8Q7Vh55pWzrsuIgmRsAtMQyaFi36p4XjZ+l
         RbTTfhVHzQ1KNCDwUTt3LTdYCBPvCDHGv5XBKuu2J2SPFfVRW38PLvzlVHbRGL48KKtd
         0p4UdWP8nHsdIXiccLx4Q2kB/HhGJvnUjU5rqcX03A1sPDKpM328buZwmNFVL/LHVGkf
         YhxFIHJPZjX5Z6Nm03SV6vzQVrsfxrekREUT2mPpzAO6vVjzTHO/pMUVlk0iURnnP5Dw
         aNDA==
X-Gm-Message-State: AOAM532u9Q2W8TALbTF7a41GJqehwT7H3k4ZKMKRs5cZa/Ut/kE0moGt
        r9T/CYug0GeU8cQBHI8kE3wZ4RHZWG1kn/3lKMNSK8P5pQahXOUTaQoHzfJS98CidllRi5/5y+6
        Q3eEXUY1G/7cnM6TxCSkODryf
X-Received: by 2002:a05:6402:2682:: with SMTP id w2mr7239620edd.355.1643362314424;
        Fri, 28 Jan 2022 01:31:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzq2XcKLD8u9nkhxIX+xxB2DKFLZ7ljDiXbsciOfiq2sHMfns2CyXpaKzoSo2qM4CjQVOz+oA==
X-Received: by 2002:a05:6402:2682:: with SMTP id w2mr7239607edd.355.1643362314230;
        Fri, 28 Jan 2022 01:31:54 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id x12sm11516164edv.57.2022.01.28.01.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 01:31:53 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Yury Norov <yury.norov@gmail.com>
Subject: RE: [PATCH 43/54] drivers/hv: replace cpumask_weight with
 cpumask_weight_eq
In-Reply-To: <MWHPR21MB1593C8511E18E4539CECAEC5D7219@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-44-yury.norov@gmail.com>
 <87sftdij76.fsf@redhat.com>
 <MWHPR21MB1593C8511E18E4539CECAEC5D7219@MWHPR21MB1593.namprd21.prod.outlook.com>
Date:   Fri, 28 Jan 2022 10:31:52 +0100
Message-ID: <8735l8gq9j.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Kelley (LINUX)" <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Monday, January 24, 2022 1:20 AM
>> 
>> Yury Norov <yury.norov@gmail.com> writes:
>> 
...
>> >
>> > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
>> > index 60375879612f..7420a5fd47b5 100644
>> > --- a/drivers/hv/channel_mgmt.c
>> > +++ b/drivers/hv/channel_mgmt.c
>> > @@ -762,8 +762,8 @@ static void init_vp_index(struct vmbus_channel *channel)
>> >  		}
>> >  		alloced_mask = &hv_context.hv_numa_map[numa_node];
>> >
>> > -		if (cpumask_weight(alloced_mask) ==
>> > -		    cpumask_weight(cpumask_of_node(numa_node))) {
>> > +		if (cpumask_weight_eq(alloced_mask,
>> > +			    cpumask_weight(cpumask_of_node(numa_node)))) {
>> 
>> This code is not performace critical and I prefer the old version:
>> 
>>  	cpumask_weight() == cpumask_weight()
>> 
>>  looks better than
>> 
>> 	cpumask_weight_eq(..., cpumask_weight())
>> 
>> (let alone the inner cpumask_of_node()) to me.
>> 
>> >  			/*
>> >  			 * We have cycled through all the CPUs in the node;
>> >  			 * reset the alloced map.
>> 
> I agree with Vitaly in preferring the old version, and indeed performance
> here is a shrug.  But actually, I think the old version is a poorly coded way
> to determine if the two cpumasks are equal. The following would correctly
> capture the intent:
>
> 	if (cpumask_equal(alloced_mask, cpumask_of_node(numa_node))
>

Indeed. While it seems that only CPUs from 'cpumask_of_node(numa_node)'
can be set in 'alloced_mask' (and thus the comparison is valid), there's
no real need to weigh anything. I'll send a patch.

-- 
Vitaly

