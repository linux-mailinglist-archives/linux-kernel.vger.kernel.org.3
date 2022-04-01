Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312894EEF32
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 16:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346807AbiDAOYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 10:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244735AbiDAOYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:24:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B5BE27CE17
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 07:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648822932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QOICKI5zhLuzzljpfPcHS3hr163EJLkUZtGfVJM2FU=;
        b=PMSWPgpWKWYEf39UpGw7c+lRnpsrZSBKutoEBgKseRQjDQLtuIPeh01UrZtCBfZiwktVDC
        PXdgnBwH5YC+67bWpnxQScB+Js3bbZQWMcaajI05U6Mtcvd3UtJffx3yVTUA1f8U02Rlgr
        GFFl79cBTiyzdylvcW/Z48Dig+zIL/Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-KLf0lPM7ONKcepYDXApQAw-1; Fri, 01 Apr 2022 10:22:11 -0400
X-MC-Unique: KLf0lPM7ONKcepYDXApQAw-1
Received: by mail-wm1-f72.google.com with SMTP id 9-20020a05600c240900b0038c99b98f6fso1229204wmp.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 07:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=3QOICKI5zhLuzzljpfPcHS3hr163EJLkUZtGfVJM2FU=;
        b=yx0BcbWcAnfvk3INqUXmXe1uZjuCatp3KJpNAZ7FR5QNAWpkbq8zwBnce1bbr6IWG7
         hW8vvkrFWUb4oEC6O+NilZO1kCesnY0NgVH1ssdGzAt9arPKtgzuRBkzOuDargzSslab
         7m+Dk+DlVmUz5oCyWg+BhNmTyNybFqJvXibQ7307mNsTnqZEhou+QmG+l80nUQT0byyg
         LmsbJMxxezB/d9A3CK4DYy2sV/ArmmjjH4hgoXGFPyfkaEJexaI41EpNGKMe35oepU3+
         ACBvLGO5KnwbAg4f7NI1RdpBBU3kRHOA1UCXn2O+vKjFn9e+Hq9pqIsGvY/c1TKUUzg8
         vbtA==
X-Gm-Message-State: AOAM5338D8mka7T4ZEfLqtCmL5BXYUc3UO9S+xRgme7zImYwSEmKzkrR
        7BfVN7eaHTz8+4DSS7ioVP0NxxNA4QO7Q6nP0vxAxm7j7B/RwOXYvCh6nN1fcJMJXGCSQ35aey3
        UYI2z63OZi7jiutMbIou/Jmnh
X-Received: by 2002:a5d:6842:0:b0:204:72d:e97e with SMTP id o2-20020a5d6842000000b00204072de97emr7915126wrw.254.1648822930334;
        Fri, 01 Apr 2022 07:22:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy02L/MJnt+FwHcW2ZM1qZzkNlErDZTTehX7rnwXkJ4uJGyMdYW3gSqSKaQTGpR8b06y7T1gw==
X-Received: by 2002:a5d:6842:0:b0:204:72d:e97e with SMTP id o2-20020a5d6842000000b00204072de97emr7915108wrw.254.1648822930033;
        Fri, 01 Apr 2022 07:22:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:9e00:229d:4a10:2574:c6fa? (p200300cbc7069e00229d4a102574c6fa.dip0.t-ipconnect.de. [2003:cb:c706:9e00:229d:4a10:2574:c6fa])
        by smtp.gmail.com with ESMTPSA id v15-20020a056000144f00b002057eac999fsm2270539wrx.76.2022.04.01.07.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 07:22:09 -0700 (PDT)
Message-ID: <85520c49-5ef9-25f2-d6fa-f8b26e5dfec2@redhat.com>
Date:   Fri, 1 Apr 2022 16:22:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 1/2] mm: page_alloc: simplify pageblock migratetype check
 in __free_one_page().
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20220401135820.1453829-1-zi.yan@sent.com>
 <134f56da-e827-2d29-75ba-1ec88ae2b118@redhat.com>
 <66F9766D-A7D8-4310-9FA9-5EC8B2CC341C@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <66F9766D-A7D8-4310-9FA9-5EC8B2CC341C@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.04.22 16:19, Zi Yan wrote:
> On 1 Apr 2022, at 10:12, David Hildenbrand wrote:
> 
>> On 01.04.22 15:58, Zi Yan wrote:
>>
>> It's weird, your mails arrive on my end as empty body with attachment. I
>> first suspected Thunderbird, but I get the same result on the google
>> mail web client.
>>
>> Not sure why that happens.
> 
> No idea. They look fine (except mangled links by outlook) on my outlook
> desk client and web client on my side. lore looks OK too:
> https://lore.kernel.org/linux-mm/20220401135820.1453829-1-zi.yan@sent.com/

I can spot in the raw mail I receive

"Content-Type: application/octet-stream; x-default=true"

But that seems to differ to the lore mail:

https://lore.kernel.org/linux-mm/20220401135820.1453829-1-zi.yan@sent.com/raw


Maybe something in my mail server chain decides to do some nasty
conversion (grml, wouldn't be the first time)

-- 
Thanks,

David / dhildenb

