Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DBB5081B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359596AbiDTHKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiDTHKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:10:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD609275C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650438472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=53ZSQ8DZrgfSyEjP1HZalPjAdZsv4fTD0UcvmrFu4rs=;
        b=bXfHgYYEWtFcFIdghRQlqn0c2iTHj74q0EdhSwAw2AwzRDLSaOp/eb2kE/7znPnqlcnair
        VicnZPKHD+g1F5WZw7Ff1gYUYIxxCEe6g8DXiPn3uG/VFisxp9HZNvqJBVmvosylSE7HOU
        liYN0JS/GdYGM4hIY0duL+a42uJ+v/Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-mN6Efle_Om2lqxcAjdzjIQ-1; Wed, 20 Apr 2022 03:07:50 -0400
X-MC-Unique: mN6Efle_Om2lqxcAjdzjIQ-1
Received: by mail-wm1-f72.google.com with SMTP id az19-20020a05600c601300b003914ac8efb8so560062wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=53ZSQ8DZrgfSyEjP1HZalPjAdZsv4fTD0UcvmrFu4rs=;
        b=3mIMgyXLGwsZCeug+hl9IMUzUqnP0qNt9KicTDnjseaRYLf482t4EfpS88I3JCaTYw
         Kta53+rMGDysPeO9xj233hVOyQh5Nhg65GEKFfyGmUeEzEOEP6c+47qNgCx4KFSMwZYX
         JIrzFB030JFeG95SpFHZwDn9EZRJOLrT0/W6DWRgvsolA8x3kkNV9R5czgWHhUgt4XX3
         CJX/YeCbltL/cK28KE2ZxkoO8Bv4oLY1RRhB+iKg6dPHDv7jPcbkYPcDigPSVYcolHv3
         9mxIS/qLq932xVg7dIJHVUZpXkQ6zchTTtLaWX+7bOyugSwX4+2WNr1qzpUZsQEQLZ/y
         LmoQ==
X-Gm-Message-State: AOAM530LeVGn6XIwB5fXdPJSNO8sVFVs17k6tjK5gpw21ASjwat1iDZT
        f9kU61vqhc8nyOLmTGxXfMyvGNzYYLxGl3oKDarerReaSR8b8wpl8Y6NGHuSB5m0bZlQI2vOAkz
        czqmDN3k+TeG02iVW/fdTdjYr
X-Received: by 2002:a05:600c:a03:b0:38c:f953:ae13 with SMTP id z3-20020a05600c0a0300b0038cf953ae13mr2130079wmp.99.1650438469639;
        Wed, 20 Apr 2022 00:07:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxX+/xB8hJ1qyU9HGOjEiJmQi7PnVrCP/c7OX8ZAJZ3EXklbNcIWsUJ1NOyQ8fESFa6nJBcGA==
X-Received: by 2002:a05:600c:a03:b0:38c:f953:ae13 with SMTP id z3-20020a05600c0a0300b0038cf953ae13mr2130051wmp.99.1650438469286;
        Wed, 20 Apr 2022 00:07:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:3d00:23e4:4c84:67a5:3ccf? (p200300cbc7023d0023e44c8467a53ccf.dip0.t-ipconnect.de. [2003:cb:c702:3d00:23e4:4c84:67a5:3ccf])
        by smtp.gmail.com with ESMTPSA id v11-20020adfa1cb000000b0020ab21e1e61sm274196wrv.51.2022.04.20.00.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 00:07:48 -0700 (PDT)
Message-ID: <e2352989-959d-2969-40e4-2d92eb8a5f9b@redhat.com>
Date:   Wed, 20 Apr 2022 09:07:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] mm/swapfile: unuse_pte can map random data if swap
 read fails
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        dhowells@redhat.com, neilb@suse.de, surenb@google.com,
        minchan@kernel.org, peterx@redhat.com, sfr@canb.auug.org.au,
        rcampbell@nvidia.com, naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220416030549.60559-1-linmiaohe@huawei.com>
 <87tuapk9n7.fsf@nvdebian.thelocal> <87r15tjy76.fsf@nvdebian.thelocal>
 <e320fb01-7d53-668e-53b5-463312ae0909@huawei.com>
 <87k0bkk2rp.fsf@nvdebian.thelocal>
 <6cf3726c-d6d0-4255-2deb-3688227c633e@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <6cf3726c-d6d0-4255-2deb-3688227c633e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.22 08:15, Miaohe Lin wrote:
> On 2022/4/20 8:25, Alistair Popple wrote:
>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>
>>> On 2022/4/19 15:53, Alistair Popple wrote:
>>>> Also in madvise_free_pte_range() you could just remove the swap entry as it's no
>>>> longer needed.
>>>>
>>>
>>> This swap entry will be removed in madvise_dontneed_single_vma().
>>> And in madvise_free_pte_range(), we may need to keep it as same as
>>> hwpoison entry. Or am I supposed to remove it even if hwpoison entry
>>> is reused later?
>>
>> Why would we need to keep it for MADV_FREE though? It only works on private
>> anonymous memory, and once the MADV_FREE operation has succeeded callers can
>> expect they might get zero-fill pages if accessing the memory again. Therefore
>> it should be safe to delete the entry. I think that applies equally to a
>> hwpoison entry too - there's no reason to kill the process if it has called
>> MADV_FREE on the range.
> 
> I tend to agree. We can drop the swapin error entry and hwpoison entry when MADV_FREE
> is called. Should I squash these into the current patch or a separate one is preferred?
> 

That should go into a separate patch.

-- 
Thanks,

David / dhildenb

