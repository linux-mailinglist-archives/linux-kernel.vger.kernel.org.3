Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04338589892
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbiHDHkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239211AbiHDHki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:40:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE91661D7A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 00:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659598836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+WZV3/cdkw6cQVZQcHjV7n6CKEOnJ0svsTCr3g/sk6M=;
        b=Vxs+fw2cdA36/+WF/lVr/lssRN0Ci3q0sxpuUUpi4uN67th8pmZdkqzY/AVsFHhADZlUFd
        JduosQkqJ5K5g0CD5XuVY7hPLevtc01ehLpvYxz54WFiO1VIQJFRnnPIFfmhGjBmpWDQsH
        lGZRWO1NNbydICJazT773TmKPqmOwvU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-T3yfTbQhPFGkZN7gVc7Oww-1; Thu, 04 Aug 2022 03:40:35 -0400
X-MC-Unique: T3yfTbQhPFGkZN7gVc7Oww-1
Received: by mail-wm1-f72.google.com with SMTP id 189-20020a1c02c6000000b003a50fa69823so379386wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 00:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=+WZV3/cdkw6cQVZQcHjV7n6CKEOnJ0svsTCr3g/sk6M=;
        b=HRUlPG2IeGoBhIIwO1/mq4WIKNBQdw8a90zVt2ZieKJfmlolT5oaq5ihtUZt8XQMkl
         NXcHtKK6FKJcL31xUTNiV+Ivao6OuhQL0KT8adF/kLkaMIjjn6f+lR5AHnP/wvvrIjrt
         bM6USuhjZG7c3QLWEU8iqTlal7Dcbv2GHrUcm/rcq6/NNoxA6QWESpy4IdyQJhxWYjXg
         40qZCzRmb9H+mv2LKRBKAJoD80v4gbNK0faMkCuZpYvOYtF10MXO/ktFgqfCkJ+0AGJ0
         yRHtOh4bMjYd/5FrglKXHQjccLDZBF+MBBC4ImKaTy7fQMOynoYcqxJQsw90OZsDPo7l
         lxag==
X-Gm-Message-State: ACgBeo3bpsuehiGJx0ps+2pxSyMorgLn6oFpfR49u29F5O0kvtIdeqT7
        xrfRCfvHy+Hpt/vVuAk4WjdPVuQYP8AM0SisrwGwHd6d0OpBAJO2j2mLgFOa1/VRAc02yYVCtWP
        EBuJdkdKriIgqF0z416S8MZ2H
X-Received: by 2002:a05:600c:22cc:b0:3a5:1209:bbba with SMTP id 12-20020a05600c22cc00b003a51209bbbamr537666wmg.131.1659598834569;
        Thu, 04 Aug 2022 00:40:34 -0700 (PDT)
X-Google-Smtp-Source: AA6agR62Y6ne1DiShrSRbqQYc5mJ1dX+bf+AhMe3Je4WkCvDmV0K71eWzKuDsDTM0GKL/fS5+JSR8Q==
X-Received: by 2002:a05:600c:22cc:b0:3a5:1209:bbba with SMTP id 12-20020a05600c22cc00b003a51209bbbamr537653wmg.131.1659598834309;
        Thu, 04 Aug 2022 00:40:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:8900:2c18:b992:1fa1:f88b? (p200300cbc70689002c18b9921fa1f88b.dip0.t-ipconnect.de. [2003:cb:c706:8900:2c18:b992:1fa1:f88b])
        by smtp.gmail.com with ESMTPSA id c16-20020adffb50000000b002205c907474sm226711wrs.107.2022.08.04.00.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 00:40:33 -0700 (PDT)
Message-ID: <4cfb6fd5-f820-b56d-bbfe-13c92a5bf682@redhat.com>
Date:   Thu, 4 Aug 2022 09:40:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] mm/gup.c: Simplify and fix
 check_and_migrate_movable_pages() return codes
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, jgg@nvidia.com, minchan@kernel.org,
        linux-kernel@vger.kernel.org, jhubbard@nvidia.com,
        pasha.tatashin@soleen.com
References: <814dee5d3aadd38c3370eaaf438ba7eee9bf9d2b.1659399696.git-series.apopple@nvidia.com>
 <20220802171215.3c909e1984ec345ff94af155@linux-foundation.org>
 <87czdg7tlt.fsf@nvdebian.thelocal>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <87czdg7tlt.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.22 02:12, Alistair Popple wrote:
> 
> Andrew Morton <akpm@linux-foundation.org> writes:
> 
>> On Tue,  2 Aug 2022 10:30:12 +1000 Alistair Popple <apopple@nvidia.com> wrote:
>>
>>> When pinning pages with FOLL_LONGTERM check_and_migrate_movable_pages()
>>> is called to migrate pages out of zones which should not contain any
>>> longterm pinned pages.
>>>
>>> When migration succeeds all pages will have been unpinned so pinning
>>> needs to be retried. This is indicated by returning zero. When all pages
>>> are in the correct zone the number of pinned pages is returned.
>>>
>>> However migration can also fail, in which case pages are unpinned and
>>> -ENOMEM is returned. However if the failure was due to not being unable
>>> to isolate a page zero is returned. This leads to indefinite looping in
>>> __gup_longterm_locked().
>>>
>>> Fix this by simplifying the return codes such that zero indicates all
>>> pages were successfully pinned in the correct zone while errors indicate
>>> either pages were migrated and pinning should be retried or that
>>> migration has failed and therefore the pinning operation should fail.
>>>
>>> This fixes the indefinite looping on page isolation failure by failing
>>> the pin operation instead of retrying indefinitely.
>>>
>>
>> Are we able to identify a Fixes: for this?  Presumably something in the
>> series "Add MEMORY_DEVICE_COHERENT for coherent device memory mapping"?
> 
> It seems the infinite loop was desired behaviour so I will re-spin this
> as a pure clean-up.
> 

How can the infinite loop trigger when we allow longterm-pinning the
shared zeropage? (note: disallowing that for now was a bug)

-- 
Thanks,

David / dhildenb

