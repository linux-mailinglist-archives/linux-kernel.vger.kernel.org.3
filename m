Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67ECF489CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiAJQBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:01:11 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54214 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiAJQBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:01:10 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8AF5B21124;
        Mon, 10 Jan 2022 16:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641830468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D00Bu/OaqQp+xz1jioGkH/uBLlzxER4lIrUiLnDYdbA=;
        b=XXfMLcPMKwNIoNavoLEUxu7bT2AMpgVsU/4ywbhb/MoA6zyK1fzLmvS+cdpWwGMFTQd3xC
        8WaIxLLqFURAgv58tdE8zDi+KI0bEkinf+WlZ7TT46gP13zum5MnX2GBWfnUL0x5VRSkH0
        4qXdKKkM6L436naE/jsw2yzF7D3vs+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641830468;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D00Bu/OaqQp+xz1jioGkH/uBLlzxER4lIrUiLnDYdbA=;
        b=2W8/0bZvAs0zdxQD3IZy/iDtNVVDd2YMfz4l64Xn8aDXpq0GYpwXBYXzCvNgzTsl6Ah5Rx
        UWl0AdEamC8IcQCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3571F13D88;
        Mon, 10 Jan 2022 16:01:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H1NJDERY3GFrEgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 10 Jan 2022 16:01:08 +0000
Message-ID: <8edfd643-888b-fbe6-97c0-21f900767c27@suse.cz>
Date:   Mon, 10 Jan 2022 17:01:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v6 6/9] mm: multigenerational lru: aging
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Rik van Riel <riel@surriel.com>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <YdcU4P+XWkbDUUoO@dhcp22.suse.cz> <YdxKORU9OWCv114O@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YdxKORU9OWCv114O@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/22 16:01, Michal Hocko wrote:
> On Thu 06-01-22 17:12:18, Michal Hocko wrote:
>> On Tue 04-01-22 13:22:25, Yu Zhao wrote:
>> > +static struct lru_gen_mm_walk *alloc_mm_walk(void)
>> > +{
>> > +	if (!current->reclaim_state || !current->reclaim_state->mm_walk)
>> > +		return kvzalloc(sizeof(struct lru_gen_mm_walk), GFP_KERNEL);
> 
> One thing I have overlooked completely. You cannot really use GFP_KERNEL
> allocation here because the reclaim context can be constrained (e.g.
> GFP_NOFS). This allocation will not do any reclaim as it is PF_MEMALLOC
> but I suspect that the lockdep will complain anyway.
> 
> Also kvmalloc is not really great here. a) vmalloc path is never
> executed for small objects and b) we do not really want to make a
> dependency between vmalloc and the reclaim (by vmalloc -> reclaim ->
> vmalloc).
> 
> Even if we rule out vmalloc and look at kmalloc alone. Is this really
> safe? I do not see any recursion prevention in the SL.B code. Maybe this
> just happens to work but the dependency should be really documented so
> that future SL.B changes won't break the whole scheme. 

Slab implementations drop all locks before calling into page allocator (thus
possibly reclaim) so slab itself should be fine and I don't expect it to
change. But we could eventually reach the page allocator recursively again,
that's true and not great.
