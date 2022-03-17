Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327CE4DCB9C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbiCQQnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbiCQQna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:43:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29CF81FE562
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 09:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647535333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HJErirJ66arxMZox+IRTVlRJvZSugg2fEsdBhUSMHeY=;
        b=bPXOhnIEAXhKdNA/J+zGfaLkmhwcbHRzUxpNQdMqd4+sncNtutbY1okHZNswMsYsyMAkoL
        N2qk6CiwGWSqqv5rgAt7o8h0hJpqghHbcpUy/6sPhatGL+J8LJC7dnRQHurr4IlR7pbciA
        bry3vG6omFDrIs4FfpP3HEo+8+iN1/I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-O8ZATRlyN46i3FTTYgn4Sw-1; Thu, 17 Mar 2022 12:42:12 -0400
X-MC-Unique: O8ZATRlyN46i3FTTYgn4Sw-1
Received: by mail-wm1-f71.google.com with SMTP id 12-20020a05600c24cc00b0038c6caa95f7so2276498wmu.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 09:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=HJErirJ66arxMZox+IRTVlRJvZSugg2fEsdBhUSMHeY=;
        b=EffBPbrz5b+vaK6X+nteVwDgt10n7EolU6O6pFA/R7yMzgnhIlIqoUR5nanE5mNKfi
         Yb35c1nqdYOrm0lfSATXy4IKlk/qJHzCwr+ykZChmlXQFQm3Ks4VB1cQ5FUXAW5AKsCz
         hHq1T8kyvtLS+0nq0XojJsGkCMx4RbtXF95f7AIExCBLZWhzUEkZqlBzUUKEC4dlRDp5
         p6DcAkG4nOpOj00yDDK+qtOQxA4RcHsPImHvv5uY99n0GAVIYPOik1ituXQ+f/szULBV
         bsBQS/Pv8gbHj1HvxV9ffhwXSDLmDPBNwwGW7m8YVp3w+zDFSDbZ1RSiu2UcdlCCSt9X
         TiHQ==
X-Gm-Message-State: AOAM530OM7smHxlH+P1YsmKo4ZzdYR/QqnK/3s2GBXBlM6PwChcKytok
        Xu5Aa7qbsIEDT3n0RGIoMBkzS5kevMrrihDR2uCeTJ0hc/6WhsZzKaSh1e0QnwBTZA31ZeeOocm
        FZuvlZ0Wsd/p8YlbK2iqtB20t
X-Received: by 2002:a05:600c:3548:b0:389:f649:7c40 with SMTP id i8-20020a05600c354800b00389f6497c40mr12299503wmq.153.1647535330788;
        Thu, 17 Mar 2022 09:42:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1vJ6bZqm36xZfp/abp1FY6J7494fS7B+TGM6qhnhjwcz93WDTunGuyU2SF9x/EsteRakOsg==
X-Received: by 2002:a05:600c:3548:b0:389:f649:7c40 with SMTP id i8-20020a05600c354800b00389f6497c40mr12299483wmq.153.1647535330547;
        Thu, 17 Mar 2022 09:42:10 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f24:9200:124e:f0bf:6f8c:cbd8? (p200300d82f249200124ef0bf6f8ccbd8.dip0.t-ipconnect.de. [2003:d8:2f24:9200:124e:f0bf:6f8c:cbd8])
        by smtp.gmail.com with ESMTPSA id o41-20020a05600c512900b00389d8c3e2b9sm4843453wms.15.2022.03.17.09.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 09:42:10 -0700 (PDT)
Message-ID: <d604d77e-636f-eb6d-0014-087d880de80e@redhat.com>
Date:   Thu, 17 Mar 2022 17:42:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC PATCH V1 0/3] mm/damon: Add CMA minotor support
Content-Language: en-US
To:     xhao@linux.alibaba.com, sj@kernel.org
Cc:     rongwei.wang@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>
References: <cover.1647378112.git.xhao@linux.alibaba.com>
 <a1e0a9e9-07ef-8d1c-a409-2b4fb12ed553@redhat.com>
 <6e6ef9fa-3916-3449-954d-efd63a959019@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <6e6ef9fa-3916-3449-954d-efd63a959019@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.03.22 08:03, Xin Hao wrote:
> Hi David,
> 
> On 3/16/22 11:09 PM, David Hildenbrand wrote:
>> On 15.03.22 17:37, Xin Hao wrote:
>>
>> s/minotor/monitor/
> Thanks,  i will fix it.
>>
>>> The purpose of these patches is to add CMA memory monitoring function.
>>> In some memory tight scenarios, it will be a good choice to release more
>>> memory by monitoring the CMA memory.
>> I'm sorry, but it's hard to figure out what the target use case should
>> be. Who will release CMA memory and how? Who will monitor that? What are
>> the "some memory tight scenarios"? What's the overall design goal?
> I may not be describing exactly what  i mean，My intention is to find out 
> how much of the reserved CMA space is actually used and which is unused,
> For those that are not used, I understand that they can be released by 
> cma_release(). Of course, This is just a little personal thought that I 
> think is helpful for saving memory.

Hm, not quite. We can place movable allocations on cma areas, to be
migrated away once required for allocations via CMA. So just looking at
the pages allocated within a CMA area doesn't really tell you what's
actually going on.

-- 
Thanks,

David / dhildenb

