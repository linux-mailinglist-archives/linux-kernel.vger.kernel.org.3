Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220E849A99B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383373AbiAYDYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1320491AbiAYDNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:13:06 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BF8C08ED72
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:55:34 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id p15so25642039ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JGwAG6/K6eqI4ROP11oN6njq1BO8cXo10ivrjJT1IhM=;
        b=R64AiEWFknCntog0tZC18TGnXiB1y5Y2xTuz/CmG0WEAEb8hm8E6OlvEkEIPAOdJM3
         Bw1nSqPs7QKx8RD3sME4v6zItGSmxO4aG+bc0TJ474BByBNnA3i75lKemIZ7eTHIH/9P
         oZosPYguHpX9tOo2yjIxcD2llPd6b4Mi0apoAIK6cldMPfGZclgoI/+Uu1AB+Asx6XOP
         CgPwk83bL4hgyCPvU7M9BDluwiY8S6nB/TEbnfiXsKCBFinTJT0ra/2h4oQBU6vzKxwi
         EwUqjMguq+7vNWTqvpv2kfnT2jewJMe0T4zg6ppg47t5uHQiinAR0t3t6KP11NOYRRXs
         Fvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JGwAG6/K6eqI4ROP11oN6njq1BO8cXo10ivrjJT1IhM=;
        b=1eeeFIIOu8Jo75aRoYBMXEQXLlfArDCFRxrSrrq21yxI0bvXg/TDgLDVjjayRqzrIt
         DTGr03nGloh3bdqRbYFgayrbhIRlw5YbdjXfTLYBw+Guf2+QTBF2br8cLr7jAQW/JFyT
         n1alQclhs/bnA77FYd5NAgf0NEEJF/Onr5dBcZjJ9zzytKyByk3FDMAxQDuuCNKlLrip
         F/tovq1b3c2xMrmpxt8NF/U0r/neAcwb0eL1gFFYg8y8kM56l632DwTVYawkv4WOF4Xp
         pZYUQVaYlIy6q95Ek9g3CgA1m81OmVin3YzRE0Hz3B2cyYkHGGa4lUfDyJtY/D/OAirG
         AoxQ==
X-Gm-Message-State: AOAM531qniywMFQO7a6sPZFB7C9xtAokKO2OP8qgLBueMhrEoOC0EK/g
        WreXpsXnABBa1tk1NaktptY=
X-Google-Smtp-Source: ABdhPJy4fhvQOv9L/Pg64yA057D2kOcfopDmGD1qNwJrWjtYqPlrSaW4ZhmHBJNGtCfkbs6U7aZeDg==
X-Received: by 2002:a17:907:d1a:: with SMTP id gn26mr1946334ejc.53.1643064932433;
        Mon, 24 Jan 2022 14:55:32 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id d6sm5045772eds.25.2022.01.24.14.55.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jan 2022 14:55:31 -0800 (PST)
Date:   Mon, 24 Jan 2022 22:55:31 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        peterz@infradead.org, will@kernel.org, linyunsheng@huawei.com,
        aarcange@redhat.com, feng.tang@intel.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove offset check on page->compound_head and
 folio->lru
Message-ID: <20220124225531.26yyse52yo5x3fr5@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220106235254.19190-1-richard.weiyang@gmail.com>
 <Yde6hZ41agqa2zs3@casper.infradead.org>
 <20220107134059.flxr2hcd6ilb6vt7@master>
 <Ydi6iMbSZ/FewYPT@casper.infradead.org>
 <20220107160825.13c71fdd871d7d5611d116b9@linux-foundation.org>
 <YdjfsbAR0UlwyC6b@casper.infradead.org>
 <20220108081340.3oi2z2rm3cbqozzt@master>
 <20220123013852.mm7eyn3z26v3hkc2@master>
 <93c48e68-2266-72ee-0763-65805b94c968@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93c48e68-2266-72ee-0763-65805b94c968@suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:30:10AM +0100, Vlastimil Babka wrote:
>On 1/23/22 02:38, Wei Yang wrote:
>> On Sat, Jan 08, 2022 at 08:13:40AM +0000, Wei Yang wrote:
>>>On Sat, Jan 08, 2022 at 12:49:53AM +0000, Matthew Wilcox wrote:
>>>>On Fri, Jan 07, 2022 at 04:08:25PM -0800, Andrew Morton wrote:
>>>>> On Fri, 7 Jan 2022 22:11:20 +0000 Matthew Wilcox <willy@infradead.org> wrote:
>>>>> 
>>>>> > > Hi, Matthew
>>>>> > > 
>>>>> > > Would you mind sharing some insight on this check?
>>>>> > 
>>>>> > It's right there in the comments.
>>>>> 
>>>>> Well I can't figure out which comment you're referring to?
>>>>
>>>>         * WARNING: bit 0 of the first word is used for PageTail(). That
>>>>         * means the other users of this union MUST NOT use the bit to
>>>>         * avoid collision and false-positive PageTail().
>>>>
>>>
>>>I know this requirement on bit 0 of first word. But I don't see the connection
>>>between this and the check of page->compound_head and folio->lru.
>>>
>>>This is more like a internal requirement on struct page. There are 8 struct in
>>>this five words union. And this requirement apply to bit 0 of first word of
>>>all those five struct.
>>>
>>>To me, if folio has the same layout of page, folio meets this requirement. I
>>>still not catch the point why we need this check here.
>>>
>> 
>> Hi, Matthew
>> 
>> Are you back from vocation? If you could give more insight on this check, I
>> would be appreciated.
>
>I can offer my insight (which might be of course wrong). Ideally one day
>page.lru will be gone and only folio will be used for LRU pages. Then there
>won't be a  FOLIO_MATCH(lru, lru); and FOLIO_MATCH(compound_head, lru);
>won't appear to be redundant anymore. lru is list_head so two pointers and

Thanks for your comment.

I can't imagine the final result. If we would remove page.lru, we could remove
FOLIO_MATCH(lru, lru) and add FOLIO_MATCH(compound_head, lru) at that moment?

>thus valid pointers are aligned in such a way they can't accidentaly set the
>bit 0.
>

-- 
Wei Yang
Help you, Help me
