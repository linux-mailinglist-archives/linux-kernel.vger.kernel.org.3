Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8C449D727
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 02:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiA0BK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 20:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiA0BK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:10:58 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EE3C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 17:10:57 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m11so1437169edi.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 17:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ezizBQJzev59fSxaPiCAfhX5lgLl/r7lnW/TtwPXhG8=;
        b=NlD2IckMmRI2RKARXlvPtGcR7GXp1Z4X/v8iPLvUwpDBgjkmfSNUmTv9LUSrAxfnmD
         M7jH6bQQCgoDicDTkvXPLGrojNTp1u9JdJUdo2IMMHO79VaBv00li0yfcjDp9x/oZp3a
         sPSFit5FvNS5FpX+HBeijVk0+JJYLwo4Kk5mPjXryrwD3Ft20pXZc2FGxka3n2YVh1K7
         Qyg1ot/cVyipuEKyeuirJ5UwmcRynCAUaZpwBZhs63mXwNEzT1btPpNcoLSj4YaAfmvg
         SzLy/CsCihnVhJ9/IoK6Tt3AijNMavTN/sZUQ4lFUqXK7D/Svt6bx+JPi30uw9AyHiq/
         IuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ezizBQJzev59fSxaPiCAfhX5lgLl/r7lnW/TtwPXhG8=;
        b=vdlWR7NrkbI3BXEf9WcrHLRwqFs9WrQpKZPFbB7T1RM0Lku8LeG/OxVarcWRT1ADMm
         +qwxfB4iie0Wbd3PU7AukO7la+Z02lVkP7kedhLVW9hNaCM8KV2inD6ZVDgz/hkFMXTS
         0OqSDUyrShk5h2/OhnSGj+hOS1uKywsHK6v0vo3OJL4wPq7UEHADz9u5yF0eDUMkM/Jv
         XmhoRmOZLAxhVTX53s9CY/FpIm9IXYxjzOjmmTpMQB1EGAbAF6C2d1d1P5YjSX2kTi3W
         ZXsmU2m4dgz0xWtHkteKvrmnyWgYfgrOGv5Pv5c5E0irscA0IPQVPnbIi6vdKdj98k0A
         VwZg==
X-Gm-Message-State: AOAM533/YeWj5UhG8aUI93hX38n1vmsYI2QFrcFQRNigUwqRLISdV0ze
        8xQ5aaaVPTI+XExXN17Jpp4=
X-Google-Smtp-Source: ABdhPJxIdE/of/4IGj89ekhK751/aJ6U10BCkPQIouD0ZVupPoTGazWmR0/rvf7f7zT9OvrR4nXxig==
X-Received: by 2002:aa7:dd02:: with SMTP id i2mr1514611edv.251.1643245856071;
        Wed, 26 Jan 2022 17:10:56 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id w18sm7777189edr.59.2022.01.26.17.10.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jan 2022 17:10:55 -0800 (PST)
Date:   Thu, 27 Jan 2022 01:10:54 +0000
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
Message-ID: <20220127011054.zlqtydxbhi4ioj5d@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <Yde6hZ41agqa2zs3@casper.infradead.org>
 <20220107134059.flxr2hcd6ilb6vt7@master>
 <Ydi6iMbSZ/FewYPT@casper.infradead.org>
 <20220107160825.13c71fdd871d7d5611d116b9@linux-foundation.org>
 <YdjfsbAR0UlwyC6b@casper.infradead.org>
 <20220108081340.3oi2z2rm3cbqozzt@master>
 <20220123013852.mm7eyn3z26v3hkc2@master>
 <93c48e68-2266-72ee-0763-65805b94c968@suse.cz>
 <20220124225531.26yyse52yo5x3fr5@master>
 <581f4247-83b1-df39-6724-af0565d0c7ea@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <581f4247-83b1-df39-6724-af0565d0c7ea@suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 11:11:40AM +0100, Vlastimil Babka wrote:
>On 1/24/22 23:55, Wei Yang wrote:
>> On Mon, Jan 24, 2022 at 11:30:10AM +0100, Vlastimil Babka wrote:
>>>On 1/23/22 02:38, Wei Yang wrote:
>>>> On Sat, Jan 08, 2022 at 08:13:40AM +0000, Wei Yang wrote:
>>>>>On Sat, Jan 08, 2022 at 12:49:53AM +0000, Matthew Wilcox wrote:
>>>>>>On Fri, Jan 07, 2022 at 04:08:25PM -0800, Andrew Morton wrote:
>>>>>
>>>>>To me, if folio has the same layout of page, folio meets this requirement. I
>>>>>still not catch the point why we need this check here.
>>>>>
>>>> 
>>>> Hi, Matthew
>>>> 
>>>> Are you back from vocation? If you could give more insight on this check, I
>>>> would be appreciated.
>>>
>>>I can offer my insight (which might be of course wrong). Ideally one day
>>>page.lru will be gone and only folio will be used for LRU pages. Then there
>>>won't be a  FOLIO_MATCH(lru, lru); and FOLIO_MATCH(compound_head, lru);
>>>won't appear to be redundant anymore. lru is list_head so two pointers and
>> 
>> Thanks for your comment.
>> 
>> I can't imagine the final result. If we would remove page.lru, we could remove
>> FOLIO_MATCH(lru, lru) and add FOLIO_MATCH(compound_head, lru) at that moment?
>
>Yes, or we could forget to do it. Adding it right now is another option that
>Matthew has chosen and I don't see a strong reason to change it. Can you
>measure a kernel build speedup thanks to removing the now redundant check?
>

If we forget to do it, the compile would fail, right?

Put it here for a future reason is not persuasive.

>>>thus valid pointers are aligned in such a way they can't accidentaly set the
>>>bit 0.
>>>
>> 

-- 
Wei Yang
Help you, Help me
