Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E0D53911F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243998AbiEaMvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344392AbiEaMut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:50:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ADC0793A8
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654001435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PQ9GZTWpkSx0AlurU9b72BzKHjHccSN9YLXwnZc+oZM=;
        b=G8VAMOZlQZBaZfur1KeFF6+yfj4APfBXlvxhKzO7nKBIi3jYqZU4e+NyHuDQnT6VPgAuKK
        k5FOd8zuve7QdQR7Y3xdOIDYzkYykYbujpVAAex5qci9HZBLUlZ92nPvXPXOuUMZyPxo+t
        0CLscjfx6lgPrmlBq27JfaNDXPsm9+M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-vGqANyfZPlOcQ3tAbcK36Q-1; Tue, 31 May 2022 08:50:34 -0400
X-MC-Unique: vGqANyfZPlOcQ3tAbcK36Q-1
Received: by mail-wm1-f69.google.com with SMTP id m10-20020a05600c3b0a00b003948b870a8dso1420807wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=PQ9GZTWpkSx0AlurU9b72BzKHjHccSN9YLXwnZc+oZM=;
        b=heElEyytO9iEMnvKURm3HZ3eOb/9iyr54g1OyORxbRWKeiMfcB2SV1F+wlKzXWOj9r
         DsiceKKYVcj3jpnzeTRcMuJjp+v3CCZ1B+JLFIB25FRJPlc+aT37NIOv/9dcoTSAXnWn
         5mtPYRnMPbTpSKZmxOA1EgTRjuOc+8jJMol0ddRyLTxUUz7UzgDLRzK4LDt39JAAVkmL
         cLtUU86Mng3NQZvF+rwQN08UM7HkQLBqIaHDNbA5SeLwehIJn2q6rUf+1FFwjNtI1mz4
         R2RR8LLZl7Cr5ZT6ldEqWU0LcWCw8tAzKXHPoPzEhrHfUD5c5NOe0YyuAuqk+aDVeq2w
         5UtQ==
X-Gm-Message-State: AOAM53155JnMsDOZIIc8Yytcbthna8qoAjg+H7uv8WLtiaHCLDrKZEK2
        g6RLECv9GuXBHullLV7HYsCEV0MTOKMDTt5fxmV4W7G0Xn6rHVLGEgRgJ1IXhAKIKdLnhp6B1kK
        XXrFFlGBGA356qoC8gkugTXPu
X-Received: by 2002:a05:600c:1e89:b0:397:82c8:eda9 with SMTP id be9-20020a05600c1e8900b0039782c8eda9mr22415158wmb.156.1654001433145;
        Tue, 31 May 2022 05:50:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvJIEqnHWuI6ybmB4RG++fRq6IJObIoYScVxPeHd+ExtbFuMqs2z1vAISWOVM7yHneQ8biYw==
X-Received: by 2002:a05:600c:1e89:b0:397:82c8:eda9 with SMTP id be9-20020a05600c1e8900b0039782c8eda9mr22415149wmb.156.1654001432942;
        Tue, 31 May 2022 05:50:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:f100:8096:9368:ba52:a341? (p200300cbc708f10080969368ba52a341.dip0.t-ipconnect.de. [2003:cb:c708:f100:8096:9368:ba52:a341])
        by smtp.gmail.com with ESMTPSA id l8-20020adffe88000000b0020d03c14b9csm11594884wrr.1.2022.05.31.05.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 05:50:32 -0700 (PDT)
Message-ID: <4835edc9-501b-cd75-402f-3ebd3b2a57cd@redhat.com>
Date:   Tue, 31 May 2022 14:50:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 1/4] mm: reduce the rcu lock duration
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com
Cc:     peterx@redhat.com, apopple@nvidia.com, ying.huang@intel.com,
        osalvador@suse.de, mike.kravetz@oracle.com,
        songmuchun@bytedance.com, hch@lst.de, dhowells@redhat.com,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220530113016.16663-1-linmiaohe@huawei.com>
 <20220530113016.16663-2-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220530113016.16663-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.05.22 13:30, Miaohe Lin wrote:
> Commit 3268c63eded4 ("mm: fix move/migrate_pages() race on task struct")
> extends the period of the rcu_read_lock until after the permissions checks
> are done to prevent the task pointed to from changing from under us. But
> the task_struct refcount is also taken at that time, the reference to task
> is guaranteed to be stable. So it's unnecessary to extend the period of
> the rcu_read_lock. Release the rcu lock after task refcount is successfully
> grabbed to reduce the rcu holding time.
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Christoph Lameter <cl@linux.com>


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

