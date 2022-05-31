Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB75E539569
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346534AbiEaRZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346530AbiEaRZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:25:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A9ED91581
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654017920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GWVsgvasjKFu7z5I/eXlJvrY6N+EO7MxwgR4Sgm9+Go=;
        b=aswjErDxYQohuGadGV6DsE6nDma/SIklv7FtHAw+NXFYh8pAUmyeERkWxkQfIYEsxo7k6u
        2ln3zFqTsw91Z9T525uv0ZJ1sw0HA5MCa7XMBj0dzba9/zrjfQFzxUtU/RO8nJUtnM8pTs
        lmCVx/wecwuwFgyrQeLjh3OBEO5NY7M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-NvvUCaLROd-r9XE6IdJYBA-1; Tue, 31 May 2022 13:25:15 -0400
X-MC-Unique: NvvUCaLROd-r9XE6IdJYBA-1
Received: by mail-wm1-f70.google.com with SMTP id o2-20020a05600c510200b0039747b0216fso1862797wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=GWVsgvasjKFu7z5I/eXlJvrY6N+EO7MxwgR4Sgm9+Go=;
        b=ZE+6HFGfE51IstTTRzjgkLWiu68Ho+dCX2VC/RHIsPgVIWBQeKKEJ/MyjIT9x0jakG
         /7qkQ9Xw662Tz2V1NQ0qQ0QcXE7BopHSUIYfT2kAgqRBNOLUsqQb6aOyiVDlLSRPMToy
         mTJf1jQDz0eSL63ZwpAQDbUZpHfRLGVLHi1F/5+GBcZYjSZ/obpVs+vV1qpJTvw0TtHX
         wqgL2R7UBTCAw5HN9PkqNfU04DQePd6R0JnjkRKd7dHrBQhdpl1JPELUWmbR+1LQNaK0
         sFzw+V+bya2KEmAIevkQ2bqV2kG2wlrtnACkucbS8EciWDQ2cNSM1xuDogCjnpWPBLUF
         iKKA==
X-Gm-Message-State: AOAM532L3Z8cOSpvLL/NObc2lgkc3rbFQ0/DhxsmFTCGavi+QYb7xvO3
        kUqCn44iEMDAx7Fo1hZ8Z0SvQXvBGo5Tw1Q78usUyYeo4AqUaQzX9LWSQrX20BeVBI2NUdGUiD/
        UfAKpM6xTT5l/CNKAHTKN1VKU
X-Received: by 2002:a05:600c:3b96:b0:397:485a:f5c5 with SMTP id n22-20020a05600c3b9600b00397485af5c5mr23841674wms.185.1654017914732;
        Tue, 31 May 2022 10:25:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiYyMevH+pTIELsJQyjP042wwEE8MJCwzxhlq/qCMkA32w1acei2/0TVEQQMQyIzGolkgqrQ==
X-Received: by 2002:a05:600c:3b96:b0:397:485a:f5c5 with SMTP id n22-20020a05600c3b9600b00397485af5c5mr23841652wms.185.1654017914452;
        Tue, 31 May 2022 10:25:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:f100:8096:9368:ba52:a341? (p200300cbc708f10080969368ba52a341.dip0.t-ipconnect.de. [2003:cb:c708:f100:8096:9368:ba52:a341])
        by smtp.gmail.com with ESMTPSA id a7-20020a5d5087000000b0020e608186a5sm11741527wrt.48.2022.05.31.10.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 10:25:12 -0700 (PDT)
Message-ID: <3e4635bb-7c16-151a-d8ed-27742f0ae673@redhat.com>
Date:   Tue, 31 May 2022 19:25:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 3/3] hugetlb: Lazy page table copies in fork()
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220527225849.284839-1-mike.kravetz@oracle.com>
 <20220527225849.284839-4-mike.kravetz@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220527225849.284839-4-mike.kravetz@oracle.com>
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

On 28.05.22 00:58, Mike Kravetz wrote:
> Lazy page table copying at fork time was introduced with commit
> d992895ba2b2 ("Lazy page table copies in fork()").  At the time,
> hugetlb was very new and did not support page faulting.  As a result,
> it was excluded.  When full page fault support was added for hugetlb,
> the exclusion was not removed.
> 
> Simply remove the check that prevents lazy copying of hugetlb page
> tables at fork.  Of course, like other mappings this only applies to
> shared mappings.
> 
> Lazy page table copying at fork will be less advantageous for hugetlb
> mappings because:
> - There are fewer page table entries with hugetlb
> - hugetlb pmds can be shared instead of copied
> 
> In any case, completely eliminating the copy at fork time shold speed
> things up.

+ make hugetlb less special, at least a tiny little bit


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

