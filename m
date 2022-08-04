Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74DF58990D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbiHDIMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237383AbiHDIMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:12:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FC5B65555
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 01:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659600724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aGdCtTL3UL2LGgp3SeT4qjaDXoDUVEPuKKGyzuwB8kA=;
        b=PTrs4u0iLHJHnpP+uAEZ8JYgUDydV0OMORVc+PYJ6ZWDLxAM1iaUTZiA19qv3aWfySU5SY
        jIe3Hyp+F00+vW1wQtvQu7viknatAJZ+qkQAMn5N8yeowXq39i67z0UOkM68mEA4xOkY/L
        9fDlbSgU+VGql+OVCY2mGDI0LQ76lTo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-5bK4g4AaN5KoBfz071ewDA-1; Thu, 04 Aug 2022 04:12:03 -0400
X-MC-Unique: 5bK4g4AaN5KoBfz071ewDA-1
Received: by mail-wr1-f72.google.com with SMTP id w17-20020adfbad1000000b0021f0acd5398so4481767wrg.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 01:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=aGdCtTL3UL2LGgp3SeT4qjaDXoDUVEPuKKGyzuwB8kA=;
        b=tHUR9BIt/oM/3NavSnhZj4PkhqZNNphmXLhLlgGYO+1I0LoZE9Chs8RigFM8l8Idaw
         t6w+674jehxyvEaXIcvA2tSVTLMslYzgGNjcIoG4/uUgLW4F6bqOMFiW3GgkT3pCoU+4
         o1nomA93V4p2Es3afSCt5b6r5DMxetWC3/kmCIuh3q0+SRwSMycfuD+2nyiW6tjpFCYW
         puq4D4Txbq7vCDcMHYwg1uMzS7CiEeli7WNgr9hwZQScy4091Z55KF4eWZbJ0RRaa9TA
         Wq9nT6RiOGQ1WHAECp6bZlykVf5mETeD1oRo31cmuQXwWNfJdfIp4T/yhnwMX/lux6Kj
         4BwQ==
X-Gm-Message-State: ACgBeo0qjTiiIGLhdTsMn6v0G/Vz1k+I+pDH2mHHyM7jFJiPs2LzIFTf
        y+s+9mg8IgbZMwOML6fAC9Dvw2ubjsoSnD9cuJRg8A8xzyCepxnaePSKV+0WVR6cLfE8otEkSym
        0N5w0AphjzfJA9HUsK3YiCLqe
X-Received: by 2002:a5d:64ed:0:b0:220:703f:6dac with SMTP id g13-20020a5d64ed000000b00220703f6dacmr565033wri.28.1659600721718;
        Thu, 04 Aug 2022 01:12:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6HngA/rR4yDuzc0gS0/lhCN+Cjjv7Ttco7l7BobC6NlYILDIyPH468IAlqD9bqRIpNFyEfcg==
X-Received: by 2002:a5d:64ed:0:b0:220:703f:6dac with SMTP id g13-20020a5d64ed000000b00220703f6dacmr565017wri.28.1659600721447;
        Thu, 04 Aug 2022 01:12:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:8900:2c18:b992:1fa1:f88b? (p200300cbc70689002c18b9921fa1f88b.dip0.t-ipconnect.de. [2003:cb:c706:8900:2c18:b992:1fa1:f88b])
        by smtp.gmail.com with ESMTPSA id s8-20020a05600c384800b003a503a64e5esm3517967wmr.15.2022.08.04.01.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 01:12:00 -0700 (PDT)
Message-ID: <eaaab6c4-1719-5e21-ebf7-a0c17487314c@redhat.com>
Date:   Thu, 4 Aug 2022 10:12:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH V4 1/1] mm: add last level page table numa info to
 /proc/pid/numa_pgtable
Content-Language: en-US
To:     haoxin <xhao@linux.alibaba.com>, willy@infradead.org
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220801121727.76186-1-xhao@linux.alibaba.com>
 <20220801121727.76186-2-xhao@linux.alibaba.com>
 <0c1f9e76-9b1d-7069-bb09-c18e4f19f0c4@redhat.com>
 <bc0d16a6-e340-e261-82a0-e17bd236c2d9@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <bc0d16a6-e340-e261-82a0-e17bd236c2d9@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.22 10:04, haoxin wrote:
> 
> 在 2022/8/1 下午9:28, David Hildenbrand 写道:
>> On 01.08.22 14:17, Xin Hao wrote:
>>> In many data center servers, the shared memory architectures is
>>> Non-Uniform Memory Access (NUMA), remote numa node data access
>>> often brings a high latency problem, but what we are easy to ignore
>>> is that the page table remote numa access, It can also leads to a
>>> performance degradation.
>> Let me try rewriting:
>>
>> "
>> Many data center servers employ Non-Uniform Memory Access (NUMA)
>> architectures. Remote numa memory access results in high latency. While
>> memory placement is one issue, sub-optimal page table placement can also
>> result in surprise performance degradation.
>> "
> Thanks,  it reads more clearly.
> 
>>> So there add a new interface in /proc, This will help developers to
>>> get more info about performance issues if they are caused by cross-NUMA.
>>
>> Why do we only care about "last level page table", why not about the others?
>>
>> IMHO, we could emit something like "0, 1, 3, 0" instead for a given user
>> space address, showing the NUMA node the page table belongs to from
>> highest to lowest page table level.
> 
> I have planned to implement the PTE page table in this version first,  
> and then support other page tables in the next patch later.

If there are plans, let's do it all at once, to get a good and single
interface to expose that information.

-- 
Thanks,

David / dhildenb

