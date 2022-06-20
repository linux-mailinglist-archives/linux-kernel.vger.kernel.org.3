Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FDA55137E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240358AbiFTI4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239675AbiFTI4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:56:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A97CA627B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655715367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QEyy/6JZbSt5hhSc4lO1WFt1fgnwbmapR64qYRXGvPc=;
        b=HPIKtSN1Is/swNaRBOj4kuzWqb9sHL3m/SkejYrhCptU3O08MAoSLUO0YxOfmEfHz2mxFc
        WUKDtN8ZGrOo5zNVw+pvM5JF54xBequCKhSLSCgf6ML4xa6rNI/rI+gbxRCWDsVArgXVIO
        MjxbgBwth3Qkzh0gUUQRJDk+/qtaw4w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-jSplWCh9NNmm3tSESPwIuQ-1; Mon, 20 Jun 2022 04:56:06 -0400
X-MC-Unique: jSplWCh9NNmm3tSESPwIuQ-1
Received: by mail-wm1-f70.google.com with SMTP id j31-20020a05600c1c1f00b0039c481c4664so3128819wms.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=QEyy/6JZbSt5hhSc4lO1WFt1fgnwbmapR64qYRXGvPc=;
        b=Bi9095eXfx69EYLR9kHvH4NsxWGYZ/ns0TbhmhopR02IWgUtzOE6LoVcvHfbFZ5pvA
         f1sIxEiunUGLPB4xDyctJqmCCjkig/gAnJ1fmZ/mjoRspe57k/PQdI7+lOI84DLWtmg5
         gbXsoWsMAN9KeOQWMrrMGONLdBqizHuYyN2zcGkw0ZtpTm23TejPrHC3fx+0qPoT1zV+
         WcxB16tJRYYsucncAQnMXIe8W8eDqiBN+Wfl8yelEt4kzms645dAC4PelOn4V+FXGQuw
         2H4YiQImPoM24x7WzMsQ4zNANf/kV0Sigv41nCZVoBCTRVgizGkvRa2P/9JzG5P23H+m
         ialw==
X-Gm-Message-State: AOAM531DiOauwG3URwiqLH+G5pJRQPxj4J7VUWnkeSn+dAw7l4fAmXPh
        Jd2noTCGLxuhpCTuDaQEcUSSXvX/07WFRigivcNZQ5KvjiF/7uPHa/6fvozfzo7skMDMMU50el5
        Jw7N/1zmaAILkXSE9ZcQSforl
X-Received: by 2002:a05:600c:1da4:b0:39c:8ca8:5f1d with SMTP id p36-20020a05600c1da400b0039c8ca85f1dmr33538673wms.138.1655715365268;
        Mon, 20 Jun 2022 01:56:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzr1ro13LIJcKzfP5ERziX/+M6AnLEwJ6AA+0q3d8eDjW5v/wKfnrKJGnpWgFweL5QvjYawSw==
X-Received: by 2002:a05:600c:1da4:b0:39c:8ca8:5f1d with SMTP id p36-20020a05600c1da400b0039c8ca85f1dmr33538645wms.138.1655715365042;
        Mon, 20 Jun 2022 01:56:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:2500:cdb0:9b78:d423:43f? (p200300d82f042500cdb09b78d423043f.dip0.t-ipconnect.de. [2003:d8:2f04:2500:cdb0:9b78:d423:43f])
        by smtp.gmail.com with ESMTPSA id p10-20020a5d48ca000000b002102f2fac37sm12841247wrs.51.2022.06.20.01.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 01:56:04 -0700 (PDT)
Message-ID: <4be7946c-54f5-80a9-4139-5ae07a89e781@redhat.com>
Date:   Mon, 20 Jun 2022 10:56:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 2/2] mm: memory_hotplug: make hugetlb_optimize_vmemmap
 compatible with memmap_on_memory
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, corbet@lwn.net, mike.kravetz@oracle.com,
        paulmck@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220619133851.68184-1-songmuchun@bytedance.com>
 <20220619133851.68184-3-songmuchun@bytedance.com>
 <YrAgUtV6wD6CIrad@FVFYT0MHHV2J.usts.net>
 <226243a9-b4f5-182e-1a5b-7b8d5c28f3b3@redhat.com>
 <YrAv18GnMOcQaAxz@FVFYT0MHHV2J.usts.net>
 <YrAzeHbYt1mAs9ue@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YrAzeHbYt1mAs9ue@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.22 10:44, Oscar Salvador wrote:
> On Mon, Jun 20, 2022 at 04:29:11PM +0800, Muchun Song wrote:
>>>> Although it works, I think PageVmemmapSelfHosted() check for the 1st pfn's
>>>> vmemmap page is not always reliable.  Since we reused PG_owner_priv_1
>>>> as PG_vmemmap_self_hosted, the test is noly reliable for vmemmap page's
>>>> vmemmap page.  Other non-vmemmap page can be flagged with PG_owner_priv_1.
>>>> So this check can be false-positive. Maybe the following code snippet is
>>>> the solution.
>>>
>>> How could that happen for pages used for backing a vmemmap?
>>>
>>
>> It cannot happen for memmap_on_memory case. Howwver, it can happen for other
>> cases. E.g. the 1st pfn (of boot memory block) whose vmemmap page may be flagged
>> as PG_owner_priv_1 (if PG_swapcache is set). Then, the check is false-positive.
> 
> If this can really happen, which I am not that sure tbh, maybe a way out would be
> to just define a new page-type as we did in previous versions of memmap_on_memory.
> In that way we would not for flags, but for its type.
> 
> But as I said, I am not entirely sure about the potential fallout of what you mention.

We are talking about the memmap of a page, who's page content is the
memmap of pages actually exposed to other users (file-backed, anonymous,
whatsoever).

In other words, while setting PG_swapcache on the memmap of a page
exposed to the user is possible, it shouldn't be possible for the memmap
of the page "hosting" these memmaps.

I know, it's confusing and I keep confusing myself. I tried creating a
picture and it doesn't really clarify the situation :D

-- 
Thanks,

David / dhildenb

