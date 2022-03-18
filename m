Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F78C4DD630
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiCRIay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbiCRIao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:30:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C23AF264812
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647592164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LDoEDSiNBMa0d/W0Sq58qXmb+e3TteSbt+UhcZgHo1g=;
        b=XNzMPOBIc+ojGQ9r3C6a+gN9L66pf84POq1jBwuCJ4ZiOjvad9Sxrp2UqDFziXDcHX7sUH
        +KVPlefnfSnDx8ZUKd91d1PzPyEy4QjcH52UD/wCVP/O7BQyqB49zpAQnjhpmLeyK6TBlN
        YeFA/StkeXNcO340E5YTIFRNycTSdPo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-L_eF4plhOx2_Ex2uEgAH0w-1; Fri, 18 Mar 2022 04:29:23 -0400
X-MC-Unique: L_eF4plhOx2_Ex2uEgAH0w-1
Received: by mail-wm1-f70.google.com with SMTP id f19-20020a7bcd13000000b0038c01defd5aso2957831wmj.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=LDoEDSiNBMa0d/W0Sq58qXmb+e3TteSbt+UhcZgHo1g=;
        b=QiGus3uN7+qGfXcZWmYqRId+xz90TYkJg7ESpIQ62v1zAHZKwWoS5rvn3F8NjkgSE7
         2PKOtIbK7UFDB5hTKqo9Tz8R6sNGyxaW2YamNrdP0fzuZj7EuzOGqWapzjEPuPZRiNkl
         t8ggILi4+ME5SBhEE2ZoRAKXe7X4swYtjIAerqS+il7Ll7gtGpU/5b84t9GEwHPrgTne
         ErRP4ngOFpum0t+5SVF+yY8e2eQnUNtUTyeBT2DsFUraovqQNpmh+I0khrOTgLjt+SR+
         tz4CAIfwACHdH2MzerbIgCbXyC7lrE5/StNo1GhXvc0YXxDxnUpRoKaXyqNfvx5eUFBy
         VYZA==
X-Gm-Message-State: AOAM533JnmPfmGuSrcHZwMXWjQDktJhvwzAOJbFlzOoDsRzrW/9n7l35
        gCJXXIqhEPE/bqO3aG5hGpwSIh31Wl1R889r7QeZ4g4NQGaiNtCL01KdhGsfeNErPXMyRfkUBuw
        N971rNtptf//P521urpKhFZ6r
X-Received: by 2002:a7b:c3d5:0:b0:389:a49f:c7e6 with SMTP id t21-20020a7bc3d5000000b00389a49fc7e6mr14793740wmj.99.1647592162297;
        Fri, 18 Mar 2022 01:29:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkPC1mF1Lx1YUqLN1xR6qms12TLZDWMc4+fr+Mty0rmuPrDlL/XBjnqqVxOKdNJCpuxEZkCw==
X-Received: by 2002:a7b:c3d5:0:b0:389:a49f:c7e6 with SMTP id t21-20020a7bc3d5000000b00389a49fc7e6mr14793725wmj.99.1647592162025;
        Fri, 18 Mar 2022 01:29:22 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f24:9200:124e:f0bf:6f8c:cbd8? (p200300d82f249200124ef0bf6f8ccbd8.dip0.t-ipconnect.de. [2003:d8:2f24:9200:124e:f0bf:6f8c:cbd8])
        by smtp.gmail.com with ESMTPSA id p12-20020a5d48cc000000b001e6114938a8sm5784805wrs.56.2022.03.18.01.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 01:29:21 -0700 (PDT)
Message-ID: <5c46548a-04b9-607e-f43a-63545131d336@redhat.com>
Date:   Fri, 18 Mar 2022 09:29:20 +0100
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
 <d604d77e-636f-eb6d-0014-087d880de80e@redhat.com>
 <611f2ec6-04de-440a-3d54-c2bc34f45cf3@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <611f2ec6-04de-440a-3d54-c2bc34f45cf3@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.03.22 06:13, xhao@linux.alibaba.com wrote:
> 
> On 3/18/22 12:42 AM, David Hildenbrand wrote:
>> On 17.03.22 08:03, Xin Hao wrote:
>>> Hi David,
>>>
>>> On 3/16/22 11:09 PM, David Hildenbrand wrote:
>>>> On 15.03.22 17:37, Xin Hao wrote:
>>>>
>>>> s/minotor/monitor/
>>> Thanks,  i will fix it.
>>>>> The purpose of these patches is to add CMA memory monitoring function.
>>>>> In some memory tight scenarios, it will be a good choice to release more
>>>>> memory by monitoring the CMA memory.
>>>> I'm sorry, but it's hard to figure out what the target use case should
>>>> be. Who will release CMA memory and how? Who will monitor that? What are
>>>> the "some memory tight scenarios"? What's the overall design goal?
>>> I may not be describing exactly what  i mean，My intention is to find out
>>> how much of the reserved CMA space is actually used and which is unused,
>>> For those that are not used, I understand that they can be released by
>>> cma_release(). Of course, This is just a little personal thought that I
>>> think is helpful for saving memory.
>> Hm, not quite. We can place movable allocations on cma areas, to be
>> migrated away once required for allocations via CMA. So just looking at
>> the pages allocated within a CMA area doesn't really tell you what's
>> actually going on.
> 
> I don't think so,  the damon not looking at the pages allocate, It is 
> constantly monitoring who is using CMA area pages through tracking page 
> access bit
> 
> in the kernel via the kdamond.x thread, So through damon, it can tell us 
> about  the hot and cold distribution of CMA memory.

I'm not sure I follow. With random movable pages being placed on the CMA
area, the mentioned use case of "cma_release()" to release pages doesn't
make sense to me.

I assume I'm missing the big picture -- and that should be properly
documented in the patch description. We don't add stuff just because it
could be used somehow, there should be a clear motivation how it can
actually be used.

-- 
Thanks,

David / dhildenb

