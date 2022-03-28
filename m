Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24614E9698
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242487AbiC1MbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239818AbiC1MbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6C7135AA1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648470566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uDJW+VRZ0lkB4aVLbXWKZbUhXcFP4EfwK6n4Uy4lwg0=;
        b=g99VIiqZ3f97S88+sXzv2ZvWfpmG/DPGMn8B2x/OmY/ThMH639FKs2b6orTkI21rXl5nMm
        NN0GdndNA+phntUE5aT8JETOzzSLNo9bLE8oRUKGJ+wT2fcwnYV0eyBD30WMUilH9yfmaA
        /n3y3N71mFZzg5y2TO0LaqBDodVfFfs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-_B6QAUrdPfKCussknQBAFQ-1; Mon, 28 Mar 2022 08:29:24 -0400
X-MC-Unique: _B6QAUrdPfKCussknQBAFQ-1
Received: by mail-wr1-f70.google.com with SMTP id s8-20020adfc548000000b00203eba1052eso4259567wrf.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=uDJW+VRZ0lkB4aVLbXWKZbUhXcFP4EfwK6n4Uy4lwg0=;
        b=pX7pX9IObulIgwfqIeXWyhHbfuJ6ALGFaMNaeBHyS6bYOvOPz4ZzUGMjyb8X2yfFGi
         j+mnNcdQz+0Ctzff1jUrV96WPcQuxtwQ9FLwmcVfphPhOeySWAugX4fAfrsl7jKc0Bfc
         DpYSuiitg88f/EuOpm4+5i6QNw39ZfdgFGr81NhSQ0k0UlEgJY6ejAg2XhGkPyZ2q+L9
         PTHBYft2FKnuQjQlYQrWM7xyqSn/HLSijc5WvzoXPI8OXAFEYgEJe5UjWl2+kLUN/BxN
         HcenjbIyn9TBKeNyWwZ1/1a37h7E6xLbLq+A7xDooER9hhLG/nVRGyjHrwX81LV9xnRu
         7DeA==
X-Gm-Message-State: AOAM532+Ig5xW0wmzqiqFG2W4n4Hvb9Uo4p9ZHkb1zT3+hz/X0x72CXM
        VGfQytwhASvmvuI1PDRMmByMN43sbdarlu1xuWkpZx3CepgS8nb7TGXhSSkMhupLHwEeP5D7eNl
        SKFUfZ4a8sd3z8WWQDaq09EIl
X-Received: by 2002:a05:600c:2188:b0:38c:9a21:9c95 with SMTP id e8-20020a05600c218800b0038c9a219c95mr34197768wme.87.1648470562763;
        Mon, 28 Mar 2022 05:29:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx65TgCLAVpVyrjQljIsWyIGLMML5hh19qQWup4wGr237NPXo64tTFUf24HO1O4bjAyZGY+iA==
X-Received: by 2002:a05:600c:2188:b0:38c:9a21:9c95 with SMTP id e8-20020a05600c218800b0038c9a219c95mr34197726wme.87.1648470562499;
        Mon, 28 Mar 2022 05:29:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:2200:50d1:ff5c:5927:203a? (p200300cbc704220050d1ff5c5927203a.dip0.t-ipconnect.de. [2003:cb:c704:2200:50d1:ff5c:5927:203a])
        by smtp.gmail.com with ESMTPSA id k23-20020a7bc417000000b0038ccada7566sm11524959wmi.11.2022.03.28.05.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 05:29:21 -0700 (PDT)
Message-ID: <400edaab-7c6c-f4d1-9a94-e8d0803857fa@redhat.com>
Date:   Mon, 28 Mar 2022 14:29:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [page-reclaim] Re: [GIT PULL] Multi-gen LRU for 5.18-rc1
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <baohua@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Donald Carr <d@chaos-reins.com>,
        Hillf Danton <hdanton@sina.com>,
        =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Rik van Riel <riel@surriel.com>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        the arch/x86 maintainers <x86@kernel.org>
References: <20220326010003.3155137-1-yuzhao@google.com>
 <CAHk-=wjp=jEhjvD9GPnHfuV5Kc1=rUnf84b_qscLJ8fkY74u3Q@mail.gmail.com>
 <CAOUHufbqum18T4kZ=d_hMehz=N=3iSuNfGrLof5tB8kjGkk8yw@mail.gmail.com>
 <20220326134928.ad739eeecd5d0855dbdc6257@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220326134928.ad739eeecd5d0855dbdc6257@linux-foundation.org>
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

On 26.03.22 21:49, Andrew Morton wrote:
> On Fri, 25 Mar 2022 19:16:15 -0600 Yu Zhao <yuzhao@google.com> wrote:
> 
>> On Fri, Mar 25, 2022 at 7:07 PM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> On Fri, Mar 25, 2022 at 6:00 PM Yu Zhao <yuzhao@google.com> wrote:
>>>>
>>>> This is more of an option than a request for 5.18. I'm sending it to
>>>> you directly because, in my judgement, it's now as ready as it'll ever
>>>> be.
>>>
>>> So I do expect to merge this, but I don't think it has been in
>>> linux-next, has it?
>>
>> No. I could ask Stephen to see if he is willing to take this series. I
>> was hoping to go through Andrew since his tree is what most MM
>> developers test. I haven't heard from Andrew, so I assume he has no
>> strong opinion and I don't want to put him in a different position.
> 
> hm, sorry, something in the headers here fooled my (elaborate) procmail
> rules :(
> 
> Please yes, let's have a cycle in -next.  I thought we decided to do
> that in discussion with Matthew Wilcox?
> 

I'd appreciate if we could merge most MM-related stuff through the -MM
tree; it exists for a reason IMHO. Andrew, you usually have a very good
feeling when something's ready to be merged upstream (sufficient review
from relevant folks, sufficient exposure via -mm and -next, ...).

-- 
Thanks,

David / dhildenb

