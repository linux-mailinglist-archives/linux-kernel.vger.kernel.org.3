Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4B14F8C87
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbiDHBYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 21:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiDHBYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:24:17 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5426445
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:22:15 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id i10-20020a17090a2aca00b001ca56c9ab16so7244154pjg.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 18:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A6OclNo6fSItQpTxQTpaUCER7lHP82G03LIl77so8jw=;
        b=zSb4agSs6+sEx1Gos/tvaPy9cnZsjfM6UBsveMu1xbXuLiS2sYW5lZu5i5fVIaC2Uc
         TnBbYZzHnB6Lfdx4TY/UdQbAZQm0p/8+FUrOEYttBaMsqVgEBTaUxbv+MIbOmKf1hN88
         1y4BpCaILLtwuVHG+12DtsYjcMbWUaz489ALsW7l/a5CmmDrI9GkoUMUsMAHHsHqgUIR
         cUhDqIqhiUxL0nDHDJZH1iJxSzUbp8LKnCIWFtXLBPm4+qRPAFgIPzoYgLs9WNl8bhb/
         DmpmuQnOVqtw5NH7a1ZqG/NN+gIQwyGPCj3MT0Tfd3rP2jBe0g2HTC+b4Y0LjmweN30a
         Agvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A6OclNo6fSItQpTxQTpaUCER7lHP82G03LIl77so8jw=;
        b=MSnbrUhX9XrjObesaMxUk/bckFktVMV8Kh/5SPwrWa83re90OVd2kMP6WQGtVVVzLz
         Qbp2VZ8FPlfw9CpPKs3N+SILhguhZLYuKG0/ZM4QwX5T2KnQvuCyG6hleeBYh24Rbj0K
         Ox1winFm+xY8c0zg6P4Kxqv4BndZgHPXPA6ZjpMSfOEofzcFQXXyvJAQjUHrlEZSTXf/
         pZyn4SrfsCmNj1KbyKlSjWpuxQxBlZcITI3YBRzD5oJnap6q9vY8cZqf/RveY+4Fv1nh
         cIuikObARay9wY1dpT0S6ur9SS8881NggPCqnNwMNfT8JIzTFVg7HOfb3E7URskFRvPB
         GMRQ==
X-Gm-Message-State: AOAM532xvrOORw5KKGDbawurehYX6jefBb+LAismpI3XeiwJA1kFMCjS
        jciijdBiYmAI0TN0QTt5oRlHwg==
X-Google-Smtp-Source: ABdhPJwhsbSFMkUvU8wzdDL8blnk++f7WzgqCYdkmeqpKagtwMsEnmQtneoW8sDRmpOVWWTI40PeuA==
X-Received: by 2002:a17:90a:bf12:b0:1ca:69bd:9a10 with SMTP id c18-20020a17090abf1200b001ca69bd9a10mr18877946pjs.92.1649380934743;
        Thu, 07 Apr 2022 18:22:14 -0700 (PDT)
Received: from [10.76.15.169] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id q28-20020a656a9c000000b00372f7ecfcecsm21038355pgu.37.2022.04.07.18.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 18:21:10 -0700 (PDT)
Message-ID: <e77ae1d9-49f3-97e8-f88f-a8518ff0573b@bytedance.com>
Date:   Fri, 8 Apr 2022 09:17:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Re: [PATCH] mm: fix kernel NULL pointer dereference in
 page_vma_mapped_walk
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220407064008.71869-1-pizhenwei@bytedance.com>
 <Yk7tIi4UKjiqQyoF@casper.infradead.org>
 <Yk7yd5ho2a7jWNfS@casper.infradead.org>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <Yk7yd5ho2a7jWNfS@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 22:17, Matthew Wilcox wrote:
> On Thu, Apr 07, 2022 at 02:54:42PM +0100, Matthew Wilcox wrote:
>> On Thu, Apr 07, 2022 at 02:40:08PM +0800, zhenwei pi wrote:
>>> size_to_hstate(4K) returns NULL pointer, this leads kernel BUG in
>>> function page_vma_mapped_walk.
>>
>> Yes, I think this is the right fix.  It's not immediately obvious from
>> the bug and the patch, but what's going on is:
>>
>> page_mapped_in_vma() sets nr_pages to 1.  This is correct because we
>> usually only want to know about the precise page, and not about the
>> folio containing it.  But hugetlbfs is special (... in so many ways ...)
>> and actually wants to work on the entire folio.  We could set nr_pages
>> specially for hugetlb pages, but it's better to ignore it in
>> page_vma_mapped_walk() for the hugetlb case.
>>
>> I'll fix up the changelog and add it to my pile of fixes that I'm
>> sending tomorrow.
>> https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/for-next
> 
> I looked over the patch in context, and realised we now don't need to
> call size_to_hstate since we're getting the hstate from the VMA.
> 
> https://git.infradead.org/users/willy/pagecache.git/commitdiff/98ea02597b9967c0817d29fee2f96d21b9e59ca5
> 
Thanks!
-- 
zhenwei pi
