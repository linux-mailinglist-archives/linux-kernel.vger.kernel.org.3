Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBD746E7C8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbhLIL4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:56:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44459 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230080AbhLIL4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639050779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0TYqDLKrFKQnJiMTqk3TD0EmAaxYdybXmgiw3V7bkHY=;
        b=Ap/qwDeUTyQj+yzssTzH+0vqCHX9t/W0AbQGW+izxrJLw0uTijVuAtRUymbmT/2VI9lMRk
        I06rzq60c+2KeslMoaky9pxLqmE0cLBWoqdy468oqHLGZ9OAhyIgvHs+BKpbrlbrTxeXss
        qlG0jItKIc3vAIdDkV54uL14HPJWZ+M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-whJQucYfMymwnYZiOPsxbA-1; Thu, 09 Dec 2021 06:52:58 -0500
X-MC-Unique: whJQucYfMymwnYZiOPsxbA-1
Received: by mail-wr1-f72.google.com with SMTP id b1-20020a5d6341000000b001901ddd352eso1331256wrw.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 03:52:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=0TYqDLKrFKQnJiMTqk3TD0EmAaxYdybXmgiw3V7bkHY=;
        b=LaaYp5IFvV7E6u7tOuzPO9sbjvLq560FFZtwVjzkX7AdA16c7NZpt83U37L2Cbdqtp
         0L+giTup4jWOZHzxh9rLhjArKChoz1qfZuMy26TS6prdE/aka18e101F6GUp4SNeRLNJ
         m+s6dsDzfGjLL5pzpjoZ8DMxQgXuNsvqj1ZrymCVpa90Bkn4YF5jkDTTZ4U5ZD6pAXHL
         yjX6VjisGETxy2kk3OjCqEhTOylWTRJcKYNF+Q1decojOK0UJ9By5s0orU5JlDf2GI/X
         9IFrRHzShD3H/CAiYLaEozozXamTizZR9Q+CN5cbwUIJECNs8SOf/phxns4y7iTZoj80
         9KcA==
X-Gm-Message-State: AOAM5315qEjqimVcT/5OoCu+XXU0dZWPClZ6Wn6X+YSGQ1bRszj12usA
        xIOWuAQLmDthgVtjcak8b6zjfcC1IgfduUlfPDWneqWybqWl+Nstx5wmxkz1wI27gnHQNaqrXZC
        mpC9ubDAe2ZrNNPLjjnErPTkJ
X-Received: by 2002:a1c:448b:: with SMTP id r133mr6687571wma.85.1639050777615;
        Thu, 09 Dec 2021 03:52:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyL2rego16YzHim2g10utaFg2hLXRfWqlX4AYNOsaFkm/biENlPxtMps3emSdCNW89UHAze0A==
X-Received: by 2002:a1c:448b:: with SMTP id r133mr6687533wma.85.1639050777348;
        Thu, 09 Dec 2021 03:52:57 -0800 (PST)
Received: from [192.168.3.132] (p4ff23ded.dip0.t-ipconnect.de. [79.242.61.237])
        by smtp.gmail.com with ESMTPSA id b6sm8982964wmq.45.2021.12.09.03.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 03:52:56 -0800 (PST)
Message-ID: <858b3185-6770-6c46-5efb-53698c913eec@redhat.com>
Date:   Thu, 9 Dec 2021 12:52:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 2/2] virtio-mem: prepare fake page onlining code for
 granularity smaller than MAX_ORDER - 1
Content-Language: en-US
To:     Eric Ren <renzhengeek@gmail.com>, linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Gavin Shan <gshan@redhat.com>, Hui Zhu <teawater@gmail.com>,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
References: <20211126134209.17332-1-david@redhat.com>
 <20211126134209.17332-3-david@redhat.com>
 <a4e2099d-b543-e2e3-f189-0cdfcc38420e@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <a4e2099d-b543-e2e3-f189-0cdfcc38420e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

thanks for the review!

>>   		if (PageDirty(page)) {
>> -			virtio_mem_clear_fake_offline(pfn + i, max_nr_pages,
>> -						      false);
>> -			generic_online_page(page, MAX_ORDER - 1);
>> +			virtio_mem_clear_fake_offline(pfn + i, 1 << order, false);
>> +			generic_online_page(page, order);
>>   		} else {
>> -			virtio_mem_clear_fake_offline(pfn + i, max_nr_pages,
>> -						      true);
>> -			free_contig_range(pfn + i, max_nr_pages);
>> -			adjust_managed_page_count(page, max_nr_pages);
>> +			virtio_mem_clear_fake_offline(pfn + i, 1 << order, true);
>> +			free_contig_range(pfn + i, 1 << order);
>> +			adjust_managed_page_count(page, 1 << order);
> In the loop, pfn + i, 1 << order are repeatedly calculated. 1 << order 
> is a step size, pfn + i  is each step position.
> Better to figure the numer once each iter?

The compiler better be smart enough to calculate such constants once :)

> 
> LGTL.
> LGTM.
> Reviewed-by: Eric Ren <renzhengeek@gmail.com>

Thanks!


-- 
Thanks,

David / dhildenb

