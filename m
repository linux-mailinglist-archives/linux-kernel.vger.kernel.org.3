Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33927524DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354106AbiELNFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354109AbiELNFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:05:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B00DF24F0D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652360704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=efOMr3P/7pGohN9ErE4jqv2LFNSoc71Z8ICykAkWQU4=;
        b=ZAd/ciL751cl3b3Gi/6Qx8aPT+I1X7d74HyQzlIusChTx20ipjI6lRtqjrRdFiIhXaX2Bh
        hcLxJMtGrOKp9NOVe+YazU8VP0F8Oa+L8jPBvH5yN4bCwma8Z5JYhGzdaXP7xQik6bZS2w
        74LRearqVDvaC+wNv6XIOTBJGm0kkrc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-HnpCOUiZOHO01vNbvQvfbA-1; Thu, 12 May 2022 09:05:02 -0400
X-MC-Unique: HnpCOUiZOHO01vNbvQvfbA-1
Received: by mail-wm1-f69.google.com with SMTP id bi5-20020a05600c3d8500b0039489e1d18dso4367062wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=efOMr3P/7pGohN9ErE4jqv2LFNSoc71Z8ICykAkWQU4=;
        b=gnFYkAyAUoXUWfu6t7BcYWUJACg5TnjDzU8246+RW0Nh5KJhQrEe5G6tYruDMP1Z/3
         X9ZfLwcJqU2olfrbcdY8v6iS/1zGfj159fs0xUKZvFwGca5/pqnSJ/XespSBVSnmbPDa
         XVNGJSIGP8QrnV+D6O7KIBVTO9UVJbTih+StvJSMu3KWyYbWM5/RXlkzyfOW2QtKk18z
         pNGDGpS1jFIidHHckwCOJ268niFzjDiLGxLyYLtLCjmczjP9yXLHVmMdMCukX7OMyOsy
         RMMcVQfDcK+FFp+yyKcHpRxLg0rGehgK/ORQ/MIs0KksAmuyZdRAcClwLBp+VZ7oi0du
         k3wA==
X-Gm-Message-State: AOAM531K2SYq86ATt4gfiKR4jNo+KYRePNwp6rCOSyHEDYfZSMGvEKnO
        a2DZTTuNrd77iUN4jVgXzjPi9Hj4pq+akbLbcqFXriMqmOj7EOouPwatdOnAKdVOp3arS97uB5S
        QoRlHXYvEGcA5NprMlg8RCbP0
X-Received: by 2002:a5d:5502:0:b0:20a:e0aa:90bd with SMTP id b2-20020a5d5502000000b0020ae0aa90bdmr28284043wrv.551.1652360700699;
        Thu, 12 May 2022 06:05:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdbDUlWFRb1WciroIQ1XDBEiFyzj/9JbtF68Ro3xbJ4jLGkiv/MQOmwWuOkoPWwT9ahyEkiw==
X-Received: by 2002:a5d:5502:0:b0:20a:e0aa:90bd with SMTP id b2-20020a5d5502000000b0020ae0aa90bdmr28284017wrv.551.1652360700457;
        Thu, 12 May 2022 06:05:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id a7-20020a7bc1c7000000b0039429bfebeasm2647067wmj.2.2022.05.12.06.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 06:04:59 -0700 (PDT)
Message-ID: <284eec3f-a79d-c5f0-3cd6-53b8e64100cd@redhat.com>
Date:   Thu, 12 May 2022 15:04:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v10 2/4] mm: memory_hotplug: override memmap_on_memory
 when hugetlb_free_vmemmap=on
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220509062703.64249-1-songmuchun@bytedance.com>
 <20220509062703.64249-3-songmuchun@bytedance.com>
 <ebffd794-697b-9bf1-f41b-4b2d52c100fc@redhat.com>
 <Yn0Ck5isxx4ghQi6@FVFYT0MHHV2J.usts.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Yn0Ck5isxx4ghQi6@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.05.22 14:50, Muchun Song wrote:
> On Thu, May 12, 2022 at 09:36:15AM +0200, David Hildenbrand wrote:
>> On 09.05.22 08:27, Muchun Song wrote:
>>> Optimizing HugeTLB vmemmap pages is not compatible with allocating memmap on
>>> hot added memory. If "hugetlb_free_vmemmap=on" and
>>> memory_hotplug.memmap_on_memory" are both passed on the kernel command line,
>>> optimizing hugetlb pages takes precedence. 
>>
>> Why?
>>
> 
> Because both two features are not compatible since hugetlb_free_vmemmap cannot
> optimize the vmemmap pages allocated from alternative allocator (when
> memory_hotplug.memmap_on_memory=1). So when the feature of hugetlb_free_vmemmap
> is introduced, I made hugetlb_free_vmemmap take precedence.  BTW, I have a plan
> to remove this restriction, I'll post it out ASAP.

I was asking why vmemmap optimization should take precedence.
memmap_on_memory makes it more likely to succeed memory hotplug in
close-to-OOM situations -- which is IMHO more important than a vmemmap
optimization.

But anyhow, the proper approach should most probably be to simply not
mess with the vmemmap if we stumble over a vmemmap that's special due to
memmap_on_memory. I assume that's what you're talking about sending out.

-- 
Thanks,

David / dhildenb

