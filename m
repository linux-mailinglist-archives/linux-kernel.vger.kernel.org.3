Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D8A4A815E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242923AbiBCJVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:21:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31406 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236784AbiBCJVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:21:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643880067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ymO1ny2VTg5adVGUcFKdR8rnoVLduAifRMEj7/KChjk=;
        b=VdrkT2veT36yasmjpMSHS+go5ipTPqKvBGAkVUYGqxcWGPrhbMjO44xIdJt7jJARJIPV/N
        S77NZIyvru1TrYCUMVkHwHFIMWVpEOpRsRyShuJu/LEHyk2o7Q06IkD4/PTcQUlSs/nV6Q
        Teov4FfutvMaeFC2FScv9z7oCzIXbWw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-xwWMekf6PEOZM9_6G_DkOQ-1; Thu, 03 Feb 2022 04:21:06 -0500
X-MC-Unique: xwWMekf6PEOZM9_6G_DkOQ-1
Received: by mail-wm1-f70.google.com with SMTP id l20-20020a05600c1d1400b0035153bf34c3so5551869wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 01:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ymO1ny2VTg5adVGUcFKdR8rnoVLduAifRMEj7/KChjk=;
        b=SGgGzAtr81NtyGxLOr095Fymo60daLvD+jNqWn7NDJ/YQSNYhMRg+iZ9Wwrz3imAGh
         hQsaL7N7HHYQ9INXhWbnR+WiNwxlw2hzN2qx1LTePnG73zfRholfE+WiifwvCQhhpc3A
         fkjeUXLsTzwT3dW4o8Imo0qC542QaNk2zt9L9r0tLI3cFyVgHX+6MgoxvO+CIBBpuvrv
         igi4j5KNKc3WLPR75Ul45ulYXJW+fbLWZzxLSYP8lJygFK/R8ChB5eqnxmH/qrixv9zc
         Kk4SqL3gn/NASJEngifEXY0Qbtx2rhtcDJqdxseEns0kgSPqG29G41Iot3yz3QeTDCmN
         jdvA==
X-Gm-Message-State: AOAM531i4C0DOv4h0lVhAr+7NoK4QgSW73qzPPuKyUbHrqPscefQjDE4
        x6hNwY2nn/L/lTGJhjWsG3U7892peVT7S48nZRt2VvgPatktcN5gEAgUuAZbgEdt+BYMf8dYsBH
        mIOvLkpzwIyqcW8TLCcejtkoe
X-Received: by 2002:adf:d1ef:: with SMTP id g15mr5897392wrd.399.1643880064860;
        Thu, 03 Feb 2022 01:21:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfsGYlewOq82YmfXvfn/6q60hYBvXySvT8EHwJOTnfzPihf3jKxSkwzXUn3s/hhBpbuXI9BQ==
X-Received: by 2002:adf:d1ef:: with SMTP id g15mr5897365wrd.399.1643880064649;
        Thu, 03 Feb 2022 01:21:04 -0800 (PST)
Received: from ?IPV6:2003:d8:2f11:9700:838c:3860:6500:5284? (p200300d82f119700838c386065005284.dip0.t-ipconnect.de. [2003:d8:2f11:9700:838c:3860:6500:5284])
        by smtp.gmail.com with ESMTPSA id x13sm19426733wru.28.2022.02.03.01.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 01:21:04 -0800 (PST)
Message-ID: <e23cc6da-b21d-f36e-5f69-e02d76f1b341@redhat.com>
Date:   Thu, 3 Feb 2022 10:21:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/6] mm: handle uninitialized numa nodes gracefully
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Rafael Aquini <raquini@redhat.com>
References: <20220127085305.20890-3-mhocko@kernel.org>
 <YfKgE5hTgbaBeaMa@kernel.org> <YfKwjAlPW2kJUv5w@dhcp22.suse.cz>
 <20220201024119.2ailcw4rp5thambz@master> <YfkDXYhGjAvAKKeU@dhcp22.suse.cz>
 <20220203002116.akpk5um5nkpeflve@master> <YfuC6IaasxcnAdGl@kernel.org>
 <c67e5fc0-95dd-1659-3a81-f23cf0be9c08@redhat.com>
 <YfubhocKKKWgKlEq@kernel.org>
 <15ad305f-a147-4a9c-35e5-bb0a868499ad@redhat.com>
 <YfueNDJJJIm/1MAy@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YfueNDJJJIm/1MAy@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.02.22 10:19, Michal Hocko wrote:
> So we will go with the following.
> /*
>  * We do not want to confuse userspace by sysfs files/directories for node
>  * without any memory attached to it, so this node is not marked as
>  * N_MEMORY and not marked online so that no sysfs hierarchy will be
>  * created via register_one_node for this node. The pgdat will get fully
>  * initialized by hotadd_init_pgdat() when memory is hotpluged into this
>  * node
>  */
> 
> OK?

LGTM, thanks!

-- 
Thanks,

David / dhildenb

