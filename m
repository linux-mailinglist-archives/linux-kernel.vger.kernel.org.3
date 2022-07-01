Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47140562D44
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbiGAH5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbiGAH5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:57:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 773456EEBD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 00:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656662221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fIrKXBVyZdoDvQRp8apiHHZa1MCXdxr3bOtHIpyaBs4=;
        b=QEObLUJKF+CjMaJT4p6+LELYTo5vf1X+ikpQSiOrA0WO+45TKbe1zTNmSKIpP2Qohcdcgm
        Vk+vA5JdW3M2NuoBHhV1ffTfOlavxt8P4TmPpujwn6WzFw3ShL5+8kMBjjC3kA62bLpXed
        nE8VCKwgPZVt0agSTMRP0CTXPSpT/z0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-ubQ2WoAdPzq3RAaZrl5r0w-1; Fri, 01 Jul 2022 03:56:59 -0400
X-MC-Unique: ubQ2WoAdPzq3RAaZrl5r0w-1
Received: by mail-lf1-f69.google.com with SMTP id z13-20020a056512308d00b004811694f893so787766lfd.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 00:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=fIrKXBVyZdoDvQRp8apiHHZa1MCXdxr3bOtHIpyaBs4=;
        b=WHUULpP7x/ihCJkatEyUDTqCX0GkWBJT4X7nVEgh+UBEGhF6AT8uUY1WA+lsBB0aQA
         xKMZXIlUh7Ewqkkn3v7q2rzMpGGB6AudY9peHqkKiQVC44q/VmvyBHRbvoPuQIBw6uuN
         sdDXkWECAWiA2NdPDaK4WhAtHqP8nAlEpMQ5rPSxWUzf+rI2mTBb0PZz/lanOWpWu3+s
         fjtxTFf4TL05xyEgFBD12GfoIBtVuthhT+aSmAbty1sJyBFKo+TXRwOGnofULITe43oQ
         u1fjZSDnZv165Wn0BUHp9jRuJSmt3HHc43i0t+4/VrFepBDyA5V6anoXNM7WnJMWp+C3
         oZGQ==
X-Gm-Message-State: AJIora8rwZ0SbTGJb9IvpMujEqk3Obcte8QT6y5hh66ibXvcJlmd2rCU
        ut3P28QDwUD6M6U7JM3WtX9C2yer3f0WhB7yDbQbM4xGBQRCLd/Nbf7F36R4guC2o0tlfdlkmsZ
        tQlERZV0U/00CmzYJpDDVFo4o
X-Received: by 2002:a2e:8787:0:b0:25b:efd1:2064 with SMTP id n7-20020a2e8787000000b0025befd12064mr6527171lji.369.1656662218018;
        Fri, 01 Jul 2022 00:56:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vJT4/sVGIa3RjZL7cGY2WKjApKKjg8AkzsZnAqMr1q7eNiOijDvdHMIC1bGPpnOayRioNyrA==
X-Received: by 2002:a2e:8787:0:b0:25b:efd1:2064 with SMTP id n7-20020a2e8787000000b0025befd12064mr6527159lji.369.1656662217812;
        Fri, 01 Jul 2022 00:56:57 -0700 (PDT)
Received: from [192.168.0.50] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id v10-20020a2e924a000000b0025bc62c1cafsm1959760ljg.44.2022.07.01.00.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 00:56:57 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <728b4c15-8114-e253-5d45-a5610882f891@redhat.com>
Date:   Fri, 1 Jul 2022 09:56:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Cc:     brouer@redhat.com, jbrouer@redhat.com, hawk@kernel.org,
        ilias.apalodimas@linaro.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, lorenzo@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, lipeng321@huawei.com, chenhao288@hisilicon.com
Subject: Re: [PATCH net-next v2] net: page_pool: optimize page pool page
 allocation in NUMA scenario
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        Guangbin Huang <huangguangbin2@huawei.com>
References: <20220629133305.15012-1-huangguangbin2@huawei.com>
 <20220630211534.6d1c32da@kernel.org>
In-Reply-To: <20220630211534.6d1c32da@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/07/2022 06.15, Jakub Kicinski wrote:
> On Wed, 29 Jun 2022 21:33:05 +0800 Guangbin Huang wrote:
>> +#ifdef CONFIG_NUMA
>> +	pref_nid = (pool->p.nid == NUMA_NO_NODE) ? numa_mem_id() : pool->p.nid;
>> +#else
>> +	/* Ignore pool->p.nid setting if !CONFIG_NUMA */
>> +	pref_nid = NUMA_NO_NODE;
>> +#endif
> 
> Please factor this out to a helper, this is a copy of the code from
> page_pool_refill_alloc_cache() and #ifdefs are a little yuck.
> 

I would say simply use 'pool->p.nid' in the call to
alloc_pages_bulk_array_node() and drop this optimization (that was
copy-pasted from fast-path).

The optimization avoids one reading from memory compile time depending
on CONFIG_NUMA.  It is *not* worth doing in this code path which is even
named "slow" (__page_pool_alloc_pages_slow).

--Jesper

