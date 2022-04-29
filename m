Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83ACA514576
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356635AbiD2JgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354512AbiD2JgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A69CDC6144
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651224780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/tOR54sNmC3XZUOFOHQ4Yl+AwgBMX0e/7hZwa5pXik=;
        b=dyaGkh+SPyK2L6pmQIKfh9yGD3cDE6MBkF0/r2QwHWUCFaD9OWqmQmQqj3lhO5qKFcT40/
        Ybzhc5YisOtY6ZfuNJInjEb/yKWjoKkUcxvvHkf+nyLyiIfiSYcJSPEHNrR9nBs6+Mg00r
        aGZni/NfzZuld9ok5WwnTLfGMxNuUJY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-0xx3YCdSMqO8SV0nnCLk2g-1; Fri, 29 Apr 2022 05:32:58 -0400
X-MC-Unique: 0xx3YCdSMqO8SV0nnCLk2g-1
Received: by mail-wm1-f71.google.com with SMTP id n26-20020a1c721a000000b003941ea1ced7so355213wmc.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=I/tOR54sNmC3XZUOFOHQ4Yl+AwgBMX0e/7hZwa5pXik=;
        b=vphQ1cBs3q9sZXTMFmuhLgFW563aYcOrlwb5S5TBuqzIf5SrHkJKl4KDOpDnpj2kM9
         vv6gEaio05vuLYmxFuM1zeTW1xtE7DauS2EqK76l8h0zw3pfboHV3jlGQegho4xr11eG
         7DWA6Cq0iBRRjrafENcuAQ09TqQ1IXA7T/Jl2p+Z5z7WeSB+HIDJ0UbOuU21lxZc/NWw
         AbLz6OKZA9RAbFZpWpNqS78m5NJfKk3rodOfHVwLruu85NKah4VUTPszcveKe2IOAU0q
         ED9GzX09BQWXrggi0dzw0esfUq3z5t8CRpAbGL2H5gfdXiVa8ZyVj0cEI9MBF5VC+pMV
         RuAg==
X-Gm-Message-State: AOAM531sQHosVhIDsyDiB/F6VdLVEtk6jjLYD3DkIJ8paSv7IIKtRkGK
        GFt/mKxwu3ypE5E0mu9tXM218tYLDkv0KcirT/Y9FnYhfVXLucsmWtRQhYYiKErdnJrzf5L+s4g
        kwzihcO1AqI0mb+8Dq5Npy1q+
X-Received: by 2002:a05:600c:1d9b:b0:393:ffc8:a09b with SMTP id p27-20020a05600c1d9b00b00393ffc8a09bmr2361944wms.40.1651224777291;
        Fri, 29 Apr 2022 02:32:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAZpnopCct+J3YhYQM6TcFt5LHE6kqYWM16L6lA6v065iSffCewmWU3++q1gRQMouQtPZgzQ==
X-Received: by 2002:a05:600c:1d9b:b0:393:ffc8:a09b with SMTP id p27-20020a05600c1d9b00b00393ffc8a09bmr2361932wms.40.1651224777084;
        Fri, 29 Apr 2022 02:32:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:fe00:bbeb:98e6:617a:dea1? (p200300cbc707fe00bbeb98e6617adea1.dip0.t-ipconnect.de. [2003:cb:c707:fe00:bbeb:98e6:617a:dea1])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d4b03000000b0020af3a12d15sm1966249wrq.2.2022.04.29.02.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 02:32:56 -0700 (PDT)
Message-ID: <44a6d752-6957-0cdc-aafa-eee81725a215@redhat.com>
Date:   Fri, 29 Apr 2022 11:32:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v4] hugetlb: Fix wrong use of nr_online_nodes
Content-Language: en-US
To:     Peng Liu <liupeng256@huawei.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        baolin.wang@linux.alibaba.com, songmuchun@bytedance.com,
        liuyuntao10@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        dave@stgolabs.net
References: <20220413032915.251254-2-liupeng256@huawei.com>
 <20220416103526.3287348-1-liupeng256@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220416103526.3287348-1-liupeng256@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.22 12:35, Peng Liu wrote:
> Certain systems are designed to have sparse/discontiguous nodes. In
> this case, nr_online_nodes can not be used to walk through numa node.
> Also, a valid node may be greater than nr_online_nodes.
> 
> However, in hugetlb, it is assumed that nodes are contiguous. Recheck
> all the places that use nr_online_nodes, and repair them one by one.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Fixes: 4178158ef8ca ("hugetlbfs: fix issue of preallocation of gigantic pages can't work")
> Fixes: b5389086ad7b ("hugetlbfs: extend the definition of hugepages parameter to support node allocation")
> Fixes: e79ce9832316 ("hugetlbfs: fix a truncation issue in hugepages parameter")
> Fixes: f9317f77a6e0 ("hugetlb: clean up potential spectre issue warnings")
> Signed-off-by: Peng Liu <liupeng256@huawei.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

