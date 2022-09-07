Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2ED5B087E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiIGPY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiIGPYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D85B7EC1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662564249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v4l5DNVkzArsZpK0R2MFCWt5K5AAMK992Cl+i+af9Zw=;
        b=UzIg0LKst/1WSCWkAUhXvVKVsfWRAp1OSuCrL0BCA/P632AaYW5ritS9CS7DGyxM2OMfK3
        nqros7pDQb6TMcgsANa2IayrmE5axLTR56M6m6ZwxKA02uqq+8eXIqoul8CojbTKAfd/cn
        b0XpRBJYlMFOosb9isKBIGe+Xxg0qsg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-44-dqhD8UWXO6unK1zVAxgxWQ-1; Wed, 07 Sep 2022 11:24:07 -0400
X-MC-Unique: dqhD8UWXO6unK1zVAxgxWQ-1
Received: by mail-wr1-f69.google.com with SMTP id e18-20020adfa452000000b00228a420c389so2945158wra.16
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 08:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=v4l5DNVkzArsZpK0R2MFCWt5K5AAMK992Cl+i+af9Zw=;
        b=bD2be+p191sQiELh9MgWSocz+kPzsrmqDDSZuXzy9ilncHz4KETMz9YNzXC7ZaNrA7
         USbaR6oNJs1c4QYoZfArwXoCvQx3QuIgzrcHUTWReKeao20y5rrBbJBQkI0J+yjW2bgO
         rGILf+86s2lpbiPJVn8Hmwyz7D2zypHXyXyXQaFB3GMZYYjTOSI6FENg+sQk3U/2Vq1Z
         R6HxNsDiI8QmTnjqhloz0mhEWA+dOIGcfUggUyIv74wNCyQg3nRWmwthIsf1x+XEOmYL
         HmeG2Tss/CPEoE0gcGEmHtPDwBSX9zrMwdO/xRQKmqCnMeX4/DjAlEWx8i6Qh47ZZHXd
         zmuw==
X-Gm-Message-State: ACgBeo2hiIehvOW4Jo+lM1Chf1z53hC/ncHG1vaw2XomKh0ngqRem/pu
        coGklOUzuybQGu7DdPKJ7Lj0WcWWTYflJJCXcxyOs4gv00n8lxGeW+T+jTQqLo6P0qU0qPULquh
        +elHvWMUsZor+cDI3atAh9kPc
X-Received: by 2002:adf:eb4c:0:b0:220:6aaf:ef5e with SMTP id u12-20020adfeb4c000000b002206aafef5emr2342065wrn.488.1662564246748;
        Wed, 07 Sep 2022 08:24:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7q59MkDqRdrR8Zk+P8doVY/5pZv2Hk7jquOShJm7zSA4dY0zMX3LJofvj/sz7wXMKgqT3uqw==
X-Received: by 2002:adf:eb4c:0:b0:220:6aaf:ef5e with SMTP id u12-20020adfeb4c000000b002206aafef5emr2342050wrn.488.1662564246525;
        Wed, 07 Sep 2022 08:24:06 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0? (p200300d82f0dba00c95131d7b2b08ba0.dip0.t-ipconnect.de. [2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b003a31fd05e0fsm5905804wms.2.2022.09.07.08.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 08:24:05 -0700 (PDT)
Message-ID: <5f89b54c-c1e8-04fe-890b-24d1daa865e8@redhat.com>
Date:   Wed, 7 Sep 2022 17:24:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 1/3] mm: reuse pageblock_start/end_pfn() macro
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
References: <20220907060844.126891-1-wangkefeng.wang@huawei.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220907060844.126891-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.22 08:08, Kefeng Wang wrote:
> Move pageblock_start_pfn/pageblock_end_pfn() into pageblock-flags.h,
> then they could be used somewhere else, not only in compaction, also
> use ALIGN_DOWN() instead of round_down() to be pair with ALIGN(), which
> should be same for pageblock usage.
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

