Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987DB46105E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 09:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349495AbhK2IqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 03:46:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229624AbhK2Iny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 03:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638175237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7dfmfZx/oTtlvSbTuXbHxY4wt7Cbbp2yPAyLGt1QqFg=;
        b=AU2FKbw9YIsWikpUKfTxxePJzZ6oskE6VxZksFcQ2DYhf0mKtryOYkaSAj9pjjuYz3ivwC
        npyXEgdV32DGkiw8bCJFZZJRYEVP+sNCgcrSDWaEexjdeTXaBcvA3Mof0E6GukkSsaFc1V
        J6MWbfyyoevIb6eY9kloG5Kzw4I6KXE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-525-VHsTZSV3MEuY2BLemoi-Dg-1; Mon, 29 Nov 2021 03:40:35 -0500
X-MC-Unique: VHsTZSV3MEuY2BLemoi-Dg-1
Received: by mail-wr1-f71.google.com with SMTP id q17-20020adff791000000b00183e734ba48so2570276wrp.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 00:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=7dfmfZx/oTtlvSbTuXbHxY4wt7Cbbp2yPAyLGt1QqFg=;
        b=pMBj0ORL3V3Dzx9Pg6NM4XJGFf7vYjkNtAP+IOagnxRrFE7ldhwe0cjpwp26ZRQX3/
         iSqZED3LyUIFdk5BGN5ZsNtSUU4HHCk/cy9oAM9ImQ/A6taB1kozDwr1y51cfuvQ2O1V
         fEykiRUT7aY8wW/xS+68sNZRWc/BSTS520sZnkUbYCFwT38BgH1qF+d2UTUA16K7C5yC
         QMyVlfaHcJKoi7J23W8EHRQobNT15NRIyXuQQQIG34jhJvL47nHsNkj1Za2aTQl0Id6s
         eyn8NCjm0t9W0jAFxuuwPX2y2+ZRwC8nvA3Ukk5GVHuR7XDxjbYR7DvnlnI5zw6HPwkL
         HMhQ==
X-Gm-Message-State: AOAM5330+Po6MHGRD69YGB4lb0ywRL6db/uscfF8k4qL6RKy9nJGClWv
        rAtl0tW8REr3HuvHa8YnzR2e8999B7H3PVenlPc+U90jnZ47nCBe2BqphHJX77Qw8Pter9pogb/
        6RNCwO4DFBrK7nNruah6pQqC0
X-Received: by 2002:adf:e512:: with SMTP id j18mr32721465wrm.532.1638175234323;
        Mon, 29 Nov 2021 00:40:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwarss23e2ed4Ips4qwa1sTOMdQ8tiDjZ9+GLFrGV/WtsuKWGho3Z9R3S1FYhQg1owAydxxRg==
X-Received: by 2002:adf:e512:: with SMTP id j18mr32721456wrm.532.1638175234160;
        Mon, 29 Nov 2021 00:40:34 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6664.dip0.t-ipconnect.de. [91.12.102.100])
        by smtp.gmail.com with ESMTPSA id a10sm19941453wmq.27.2021.11.29.00.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 00:40:33 -0800 (PST)
Message-ID: <7fdab1f3-abf7-1214-8d74-8cdcc6d96918@redhat.com>
Date:   Mon, 29 Nov 2021 09:40:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH for 4.14-stable] s390/mm: validate VMA in PGSTE
 manipulation functions
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, hca@linux.ibm.com, imbrenda@linux.ibm.com
References: <16371715631177@kroah.com>
 <20211126171536.22963-1-david@redhat.com> <YaNuALgYu4OQDVXN@kroah.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YaNuALgYu4OQDVXN@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.11.21 12:54, Greg KH wrote:
> On Fri, Nov 26, 2021 at 06:15:36PM +0100, David Hildenbrand wrote:
>> commit fe3d10024073f06f04c74b9674bd71ccc1d787cf upstream.
>>
>> We should not walk/touch page tables outside of VMA boundaries when
>> holding only the mmap sem in read mode. Evil user space can modify the
>> VMA layout just before this function runs and e.g., trigger races with
>> page table removal code since commit dd2283f2605e ("mm: mmap: zap pages
>> with read mmap_sem in munmap"). gfn_to_hva() will only translate using
>> KVM memory regions, but won't validate the VMA.
>>
>> Further, we should not allocate page tables outside of VMA boundaries: if
>> evil user space decides to map hugetlbfs to these ranges, bad things will
>> happen because we suddenly have PTE or PMD page tables where we
>> shouldn't have them.
>>
>> Similarly, we have to check if we suddenly find a hugetlbfs VMA, before
>> calling get_locked_pte().
>>
>> Fixes: 2d42f9477320 ("s390/kvm: Add PGSTE manipulation functions")
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>> Acked-by: Heiko Carstens <hca@linux.ibm.com>
>> Link: https://lore.kernel.org/r/20210909162248.14969-4-david@redhat.com
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  arch/s390/mm/pgtable.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
> 
> What about for 5.10-stable and 5.4-stable and 4.19-stable?  Will this
> commit work there as well?

Good point, I only have "FAILED: patch "[PATCH] s390/mm: validate VMA in
PGSTE manipulation functions" failed to apply to 4.14-stable tree" in my
inbox ... but maybe I accidentally deleted the others.


This commit can also be used for:
- 4.19-stable
- 5.4-stable
- 5.10-stable

They all lack vma_lookup() and we have to implement the start address
check manually.

-- 
Thanks,

David / dhildenb

