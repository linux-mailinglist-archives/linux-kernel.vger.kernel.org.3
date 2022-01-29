Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F2A4A2AA7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 01:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241447AbiA2Arn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 19:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbiA2Arl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 19:47:41 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA5BC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:47:41 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ka4so21421793ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kB67G3+aOp/BknIObLtkl/DFgO8sf3NUTmgGKY/E+24=;
        b=m5JrgPX7rY1AXo8AND+SfpLXf3k2VCB5OjOQaBw9OBwOjk2D96RC5Zw5ntj8UhIMNB
         rnS3z977Hf7D8NMVhUSdafGokY6KjItiXQY3sfZctdaQHLcLzfPEr3R/oy8OqvSlkoLh
         gR87RUHh79Y+ZSQayph17cTUxnVTKd5tNRGuKF5C9sx2Yea1Y0EgxJAlIX2rAtcfhPGk
         DeLm7ypYMnY3hh2xDTRvxlbWIlcdP1QYATq27qrII08uSYo2I1ssMMPYyK6AZylpFtDI
         FGUDvkvo/fQoiFciCe1idMY6fyuchYRVnC3Nx4Jz6m/ZqT6ki+WXKhAFqbJFoc22ctjv
         8OYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kB67G3+aOp/BknIObLtkl/DFgO8sf3NUTmgGKY/E+24=;
        b=7ob3thO7r+2+Sj4s+kSNG2bjDl4GLH7yMq1cCcUUMmxRhUmQSKDo8tS5M0ciFddQgJ
         MjagBFCIX+hhpP6py/ggOBUJq03kIu+n9sa8SDDwsF2ojvwQhHimiGqVVyFkULW7KNa8
         IBAZ8PlsEp0GMODa7QY2doIXIEThqgYp1bpZFvhGvjGKxvK1bpP6OA3IfxUyMqiM81Sr
         k11BSHDVJG6OUEt2NVKGUZ20ArLABQzSDBudF/hyBvg9lrjoHQa577OUZJCQnGY9cCZq
         WIiVfc7URZ/tMzbTW1AZJMYo0HpIC8q/anXUWgeHT9ulDjag+EywSxpiomy3dob6u7kK
         9Cdg==
X-Gm-Message-State: AOAM5308P+h0/gu0trtCvsVWquMOVEGOduQ+49o2NMO8wR+J8BLw13u1
        4IbuFk+SS9bEGO5ILu3qHfU=
X-Google-Smtp-Source: ABdhPJyLPOWrHg5Qh5KESKL/LjIkKA+rI2w1NbdXIt5W/b98M05/Q+1LIAVjaiokBR5V0GOiAt72Tg==
X-Received: by 2002:a17:906:7308:: with SMTP id di8mr9028450ejc.464.1643417260182;
        Fri, 28 Jan 2022 16:47:40 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id q23sm8124776ejz.30.2022.01.28.16.47.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jan 2022 16:47:39 -0800 (PST)
Date:   Sat, 29 Jan 2022 00:47:39 +0000
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
Message-ID: <20220129004739.d2b3dqiv3qw6dfhs@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <Ydi6iMbSZ/FewYPT@casper.infradead.org>
 <20220107160825.13c71fdd871d7d5611d116b9@linux-foundation.org>
 <YdjfsbAR0UlwyC6b@casper.infradead.org>
 <20220108081340.3oi2z2rm3cbqozzt@master>
 <20220123013852.mm7eyn3z26v3hkc2@master>
 <93c48e68-2266-72ee-0763-65805b94c968@suse.cz>
 <20220124225531.26yyse52yo5x3fr5@master>
 <581f4247-83b1-df39-6724-af0565d0c7ea@suse.cz>
 <20220127011054.zlqtydxbhi4ioj5d@master>
 <9451a3f7-ef63-6d01-1357-4953f3d1e566@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9451a3f7-ef63-6d01-1357-4953f3d1e566@suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 04:42:10PM +0100, Vlastimil Babka wrote:
>On 1/27/22 02:10, Wei Yang wrote:
>> On Tue, Jan 25, 2022 at 11:11:40AM +0100, Vlastimil Babka wrote:
>>>On 1/24/22 23:55, Wei Yang wrote:
>>>> On Mon, Jan 24, 2022 at 11:30:10AM +0100, Vlastimil Babka wrote:
>>>>>On 1/23/22 02:38, Wei Yang wrote:
>>>>>
>>>>>I can offer my insight (which might be of course wrong). Ideally one day
>>>>>page.lru will be gone and only folio will be used for LRU pages. Then there
>>>>>won't be a  FOLIO_MATCH(lru, lru); and FOLIO_MATCH(compound_head, lru);
>>>>>won't appear to be redundant anymore. lru is list_head so two pointers and
>>>> 
>>>> Thanks for your comment.
>>>> 
>>>> I can't imagine the final result. If we would remove page.lru, we could remove
>>>> FOLIO_MATCH(lru, lru) and add FOLIO_MATCH(compound_head, lru) at that moment?
>>>
>>>Yes, or we could forget to do it. Adding it right now is another option that
>>>Matthew has chosen and I don't see a strong reason to change it. Can you
>>>measure a kernel build speedup thanks to removing the now redundant check?
>>>
>> 
>> If we forget to do it, the compile would fail, right?
>
>No, FOLIO_MATCH is like a build-time assert. It can only fail if the assert
>is there, and the condition evaluates to false.

Currently we have this check

  FOLIO_MATCH(lru, lru)

Which checks page->lru and folio->lru.

As you mentioned page->lru would be gone. So this check would fail at compile?


-- 
Wei Yang
Help you, Help me
