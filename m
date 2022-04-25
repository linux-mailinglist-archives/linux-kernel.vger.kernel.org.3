Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1221050DA5C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241446AbiDYHtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241410AbiDYHsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:48:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E64F403EB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650872736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tpWZgiPbAxsqPPPmhkGAZAhjYuoPx+itMj+31Vjm+VU=;
        b=Y5T7ggkwo88MtNf86ujnmgPISrPzb3gjdmt+ggmOnqPvzlqYgN28LwRXG7kYw5swAb6M7p
        RqZ2EXuCoriB0SBzovW93TJ9FpIHM3uKZrKPZhL15Jc71CxBmp1Fr14vND015PYytbpX/E
        Gc9Bgv9x65iOG9nS9HhaJKU8H2ZkPJ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-KC7lBBZLO_28k3Ks3o8Glw-1; Mon, 25 Apr 2022 03:45:34 -0400
X-MC-Unique: KC7lBBZLO_28k3Ks3o8Glw-1
Received: by mail-wm1-f72.google.com with SMTP id n4-20020a1ca404000000b00392b49c7ae3so5007553wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=tpWZgiPbAxsqPPPmhkGAZAhjYuoPx+itMj+31Vjm+VU=;
        b=LJDOI00+jLReewemLgRFo+BUqkIlpuxTFXdz+74gJV3QOaUNam6EFyIZBok7ssoQ0/
         sfYM2koBjYHbbl0HcxusThh8MkiJrki4on69897RxUrUhulIgdUgwBQ0ZYYDUIxMwfLc
         0tIWbIXtqhhfI4w6+cb3ACHGQOUv4el8tXwkwdojdQSwwnoUn4xYuQnmLeJtNgDb60Jo
         /E/y0M+R+ZGowQzav34hfDwILqyJf/Acc4htLA7HdJGHYfxELGxzqXaIJpRgT3SJL0e6
         k+j0EXZ1S4tD42wh2/1dZc3oGvV9iIQ/TuRmcSpZS0WIoL+2xxmMwJwwX6FglcJc1+Xh
         VoCg==
X-Gm-Message-State: AOAM533NYEUynL0fjwJdYZ5XQTLIUUr5Zj+5iO84mc+LYv1+N8uBgmRE
        VGzHwIuB/mijGe8Yt1eOOUUJnZk+Aq7B6W4IMD8J4o7kQSV+WVz5FnTkzx7LrRMEdIRhUyudjnq
        qauioEh+N/MthHM7Ag+KMfAfd
X-Received: by 2002:a05:600c:1e09:b0:390:f313:bf15 with SMTP id ay9-20020a05600c1e0900b00390f313bf15mr24733913wmb.172.1650872733593;
        Mon, 25 Apr 2022 00:45:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVJnHaO9F/y9ZuWWcrcXXk1YwuRc7TsAX+Zeq7Nao24gvi2VH1SFP3lFk3t8yQ2He/EDlNkA==
X-Received: by 2002:a05:600c:1e09:b0:390:f313:bf15 with SMTP id ay9-20020a05600c1e0900b00390f313bf15mr24733887wmb.172.1650872733344;
        Mon, 25 Apr 2022 00:45:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:490d:ed6a:8b22:223a? (p200300cbc700fc00490ded6a8b22223a.dip0.t-ipconnect.de. [2003:cb:c700:fc00:490d:ed6a:8b22:223a])
        by smtp.gmail.com with ESMTPSA id bg26-20020a05600c3c9a00b00393e997c657sm3145948wmb.37.2022.04.25.00.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 00:45:32 -0700 (PDT)
Message-ID: <febd6309-b2a5-ef79-daa2-8000af09e291@redhat.com>
Date:   Mon, 25 Apr 2022 09:45:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "surenb@google.com" <surenb@google.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220424091105.48374-1-linmiaohe@huawei.com>
 <20220424091105.48374-2-linmiaohe@huawei.com>
 <20220425010804.GA3746096@hori.linux.bs1.fc.nec.co.jp>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 1/3] mm/swapfile: unuse_pte can map random data if swap
 read fails
In-Reply-To: <20220425010804.GA3746096@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.22 03:08, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Sun, Apr 24, 2022 at 05:11:03PM +0800, Miaohe Lin wrote:
>> There is a bug in unuse_pte(): when swap page happens to be unreadable,
>> page filled with random data is mapped into user address space.  In case
>> of error, a special swap entry indicating swap read fails is set to the
>> page table.  So the swapcache page can be freed and the user won't end up
>> with a permanently mounted swap because a sector is bad.  And if the page
>> is accessed later, the user process will be killed so that corrupted data
>> is never consumed.  On the other hand, if the page is never accessed, the
>> user won't even notice it.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> Hi Miaohe,
> 
> This bug sounds relatively serious to me, and it seems old, so is it worth
> sending to -stable?

I'm not sure if this is worth -stable, but no strong opinion.

The do_swap_page() part was added in 2005:

commit b81074800b98ac50b64d4c8d34e8abf0fda5e3d1
Author: Kirill Korotaev <dev@sw.ru>
Date:   Mon May 16 21:53:50 2005 -0700

    [PATCH] do_swap_page() can map random data if swap read fails
    
    There is a bug in do_swap_page(): when swap page happens to be unreadable,
    page filled with random data is mapped into user address space.  The fix is
    to check for PageUptodate and send SIGBUS in case of error.
    
    Signed-Off-By: Kirill Korotaev <dev@sw.ru>
    Signed-Off-By: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
    Acked-by: Hugh Dickins <hugh@veritas.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

So the do_swap_page() part has been fixed for quite a while already.

-- 
Thanks,

David / dhildenb

