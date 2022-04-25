Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A3150DA87
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241501AbiDYHyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241506AbiDYHww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:52:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0BA2113
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650872987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TMN+SqXsYo3d//MTs5uT9QiA8HmOLnYDXkfcKG4wEW0=;
        b=TbhaCiBaF9AI+T98PJCpx3PSJK5do5TcxE744+jrhiFVumzjdmrCRo2/Vk8LKYutC3rXIS
        NmTTeoUU4oiIWtj7C0w5BD29+bWJA/YHmFFJPbsDHGQk6+/ZZ0dq6iE6Qa43soNkyiiFSb
        V0XeKbcem+SMVejshZgoMA2Qmpyp6eQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-KHfZ2AkNMSK6h0TDdzmzOw-1; Mon, 25 Apr 2022 03:49:46 -0400
X-MC-Unique: KHfZ2AkNMSK6h0TDdzmzOw-1
Received: by mail-wr1-f70.google.com with SMTP id n17-20020adfc611000000b0020a7e397ccaso3033011wrg.23
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=TMN+SqXsYo3d//MTs5uT9QiA8HmOLnYDXkfcKG4wEW0=;
        b=NoznD0kFFXRbkOpvkY1ueJNitl8NEArVmcHj3V88dF7gbZ2HYUZ3lBDdpaerTyo0kn
         8DSVYee6aiXTxpa1Ds0Ka73KuWdMxaOl+QoNREzgunet1skq8MWfGuPvz67FYURBCv8O
         jaKi5LwQr8aCtiMTsO8BczZTsvILn+GcWzGi7hsajJQo1oNYoPCHfYVYepYdT7QG4ajG
         etNN+WhBdNVMmloZ28Sgpsk20u3GQTr3tZqoT3lx8RyKZijYn1S42DcDNZ5QtdWeVzOp
         r0fuqu/ivBxjfcgnTC9fGr6jgjTvaXm2NiWPAzGab5wLBTyYlCmN2Uf+byb2Sux9Jl4h
         noEw==
X-Gm-Message-State: AOAM533h2QXKRv9cqP5fJwxb0xh69ETJWwBgCZntKBQsEFBPxlkYer1k
        btIyBuqKHQ3QJ7FGgRyk921YeNC/FF6MN7ydox3SPUiCGTMhTZ70Vvg6bx2wXCmD6KV+m5w1vRi
        nwL6yvSQpDAVjnFAozFrmzlZe
X-Received: by 2002:a05:600c:350f:b0:393:ec06:4262 with SMTP id h15-20020a05600c350f00b00393ec064262mr3417383wmq.165.1650872985017;
        Mon, 25 Apr 2022 00:49:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxQO8+qq0D++pW4n/MjMu77yOzpy/8PzYibDLgHNPuYQDzKI0pe3hNoGJFI6KjwOY0rJrejg==
X-Received: by 2002:a05:600c:350f:b0:393:ec06:4262 with SMTP id h15-20020a05600c350f00b00393ec064262mr3417358wmq.165.1650872984803;
        Mon, 25 Apr 2022 00:49:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:490d:ed6a:8b22:223a? (p200300cbc700fc00490ded6a8b22223a.dip0.t-ipconnect.de. [2003:cb:c700:fc00:490d:ed6a:8b22:223a])
        by smtp.gmail.com with ESMTPSA id s10-20020adf978a000000b0020ae0154f1esm373753wrb.5.2022.04.25.00.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 00:49:44 -0700 (PDT)
Message-ID: <f88412b4-83db-e594-fc48-2f4b8b9f3be8@redhat.com>
Date:   Mon, 25 Apr 2022 09:49:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 1/3] mm/swapfile: unuse_pte can map random data if swap
 read fails
Content-Language: en-US
To:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, surenb@google.com,
        minchan@kernel.org, peterx@redhat.com, sfr@canb.auug.org.au,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220424091105.48374-1-linmiaohe@huawei.com>
 <20220424091105.48374-2-linmiaohe@huawei.com>
 <8aeebc2f0b2a251d3d70402cd0edf063ba911013.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <8aeebc2f0b2a251d3d70402cd0edf063ba911013.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.22 09:41, ying.huang@intel.com wrote:
> Hi, Miaohe,
> 
> On Sun, 2022-04-24 at 17:11 +0800, Miaohe Lin wrote:
>> There is a bug in unuse_pte(): when swap page happens to be unreadable,
>> page filled with random data is mapped into user address space.  In case
>> of error, a special swap entry indicating swap read fails is set to the
>> page table.  So the swapcache page can be freed and the user won't end up
>> with a permanently mounted swap because a sector is bad.  And if the page
>> is accessed later, the user process will be killed so that corrupted data
>> is never consumed.  On the other hand, if the page is never accessed, the
>> user won't even notice it.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> ---
>>  include/linux/swap.h    |  7 ++++++-
>>  include/linux/swapops.h | 10 ++++++++++
>>  mm/memory.c             |  5 ++++-
>>  mm/swapfile.c           | 11 +++++++++++
>>  4 files changed, 31 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index 5553189d0215..b82c196d8867 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -55,6 +55,10 @@ static inline int current_is_kswapd(void)
>>   * actions on faults.
>>   */
>>
>> +#define SWP_SWAPIN_ERROR_NUM 1
>> +#define SWP_SWAPIN_ERROR     (MAX_SWAPFILES + SWP_HWPOISON_NUM + \
>> +			     SWP_MIGRATION_NUM + SWP_DEVICE_NUM + \
>> +			     SWP_PTE_MARKER_NUM)
>>
>>
> 
> It appears wasteful to use another swap device number. 

Do we really care?

We currently use 5 bits for swap types, so we have a total of 32.

SWP_HWPOISON_NUM -> 1
SWP_MIGRATION_NUM -> 3
SWP_PTE_MARKER_NUM -> 1
SWP_DEVICE_NUM -> 4
SWP_SWAPIN_ERROR_NUM -> 1

Which would leave us with 32 - 10 = 22 swap devices. IMHO that's plenty
for real life scenarios.

I'd prefer reworking this when we really run into trouble (and we could
think about using more bits for applicable architectures then, for
select 64bit architectures it might be fairly easily possible).

-- 
Thanks,

David / dhildenb

