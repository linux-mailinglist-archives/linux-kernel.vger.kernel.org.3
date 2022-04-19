Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA81506623
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbiDSHps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349515AbiDSHpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:45:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 190B123BEC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650354183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0u9LoSCt9kBJxdoBabAgLxK4g9VSGrDcyjRPq+0x01U=;
        b=F278hVNY10zi/Q0G82I126Q7DeV8uvFT9yMhxGT4vwyQMeB9a6F0NhpJboiGaTUz3Polh8
        NoHAN9n67ILAqmXm1XaxE52Ojtlh+jZDsX44dEzxwmJKuckZeHCYFfBUdoYtyHkJMcaluk
        8MNLDn0SbqRH+ni5G4feI5sjBxxCTAo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-iN5lm-jfPiy9GMnIGT6Pbw-1; Tue, 19 Apr 2022 03:42:57 -0400
X-MC-Unique: iN5lm-jfPiy9GMnIGT6Pbw-1
Received: by mail-wm1-f72.google.com with SMTP id m125-20020a1c2683000000b00391893a2febso5822242wmm.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=0u9LoSCt9kBJxdoBabAgLxK4g9VSGrDcyjRPq+0x01U=;
        b=ZZY1ACw2CJGBMPrN2EskFJnG24CpAnAZyuKXA1C3DBEeqCmYnVyQCJEcRyLQg0hHIj
         Q5tKcG4v8YP69UZtS+S5wfdxna0DfMhxHSSo0YYrS9FY8TURPVM2LCsrehJ216YUflNX
         QtKYr5HDP8rej1Zcp8npLrF3OuGppYCOdV7eUdZ2lOv/1U1Qzk1qwTQFw/QfgO1AFbgZ
         OxrPgWg3fhU2l4z0hpI3O9+E4IeubiXFbdKtKq22FoVgERtK/w2OpUo7knVAybUXWK0/
         hi4791IAvnozwGwdb4nxmN2ZZVwWonPUM47D4EqbViQ1gF/h/1MKG48WQyEDO0oZyiog
         SlrA==
X-Gm-Message-State: AOAM5312cNMJ2P0TKqwMU7OJhRMSLwz4h8gZxBfM6I+rFYULyTYn/goJ
        paaQN9jIH/rt/wB/cxLVgy2kXu9/pOw9ULdXXb3H3UT0ZOYT1R9NEovvI35aodRan8PkWx72HRz
        LG0gUQbNjb4dT1tfOnyZ+25C8
X-Received: by 2002:a05:6000:1acc:b0:20a:a00a:47b0 with SMTP id i12-20020a0560001acc00b0020aa00a47b0mr3904977wry.132.1650354176772;
        Tue, 19 Apr 2022 00:42:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHdTjMah54EH1awwGGjJIhbb8cg8DJfykctuIPdOC/PJt4Heh8L8wYZaKJtjrQbqnPRZoy8Q==
X-Received: by 2002:a05:6000:1acc:b0:20a:a00a:47b0 with SMTP id i12-20020a0560001acc00b0020aa00a47b0mr3904965wry.132.1650354176520;
        Tue, 19 Apr 2022 00:42:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5d00:d8c2:fbf6:a608:957a? (p200300cbc7045d00d8c2fbf6a608957a.dip0.t-ipconnect.de. [2003:cb:c704:5d00:d8c2:fbf6:a608:957a])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm17547020wmp.14.2022.04.19.00.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 00:42:56 -0700 (PDT)
Message-ID: <47a4a4bf-3ac6-d65b-f40b-745c73ddd295@redhat.com>
Date:   Tue, 19 Apr 2022 09:42:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 09/12] mm: compaction: avoid possible NULL pointer
 dereference in kcompactd_cpu_online
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     vbabka@suse.cz, pintu@codeaurora.org, charante@codeaurora.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220418141253.24298-1-linmiaohe@huawei.com>
 <20220418141253.24298-10-linmiaohe@huawei.com>
 <20220418205531.2e4ed0f72e0e537ef55c6468@linux-foundation.org>
 <df57934c-0738-208b-d423-59032185f858@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <df57934c-0738-208b-d423-59032185f858@huawei.com>
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

On 19.04.22 08:47, Miaohe Lin wrote:
> On 2022/4/19 11:55, Andrew Morton wrote:
>> Please cc David H on memhotplug stuff.
> 
> I'm relying on the scripts/get_maintainer.pl to take me the right people now.
> Will take care of it. Many thanks for your remind!

Yes, we should add add a memhotplug in MAINTAINERS subsections for good
so I can punch in my name. Let me add that to my TODO list.

-- 
Thanks,

David / dhildenb

