Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33093497D31
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237156AbiAXKaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:30:13 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60116 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237146AbiAXKaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:30:12 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 65E3E2197D;
        Mon, 24 Jan 2022 10:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643020211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hUS7IPB39sYAuBcxNuJ+tx/xCk5Lnvrdaahae+B90KE=;
        b=WgojSsf0PtqCZK8UxbwfTaD9xL3fmJfrz7PGpUKcV8b+Q2xYPC/+3WR+WGo5bQX0FUI3Rk
        HXF5+ZQKW2GLwnVk4M05WxOAdymhw8h63nJ7l7LJyZEi9R1RlJJv1k+jVX+FRfu3Ewfygh
        PSAt4VlRsKKMsP9udbtYnx9EP42/o+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643020211;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hUS7IPB39sYAuBcxNuJ+tx/xCk5Lnvrdaahae+B90KE=;
        b=f52QtYuDzFI6iyOY8FWMS09mFbbX/11pE0GhLERIcvNyIAdSGWr0xf0V1eG1kmKo1DJcxB
        8Bbal1MSFg8sVYCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2EF7713B1C;
        Mon, 24 Jan 2022 10:30:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2KHVCrN/7mHVawAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 24 Jan 2022 10:30:11 +0000
Message-ID: <93c48e68-2266-72ee-0763-65805b94c968@suse.cz>
Date:   Mon, 24 Jan 2022 11:30:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm: remove offset check on page->compound_head and
 folio->lru
Content-Language: en-US
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        peterz@infradead.org, will@kernel.org, linyunsheng@huawei.com,
        aarcange@redhat.com, feng.tang@intel.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
References: <20220106235254.19190-1-richard.weiyang@gmail.com>
 <Yde6hZ41agqa2zs3@casper.infradead.org>
 <20220107134059.flxr2hcd6ilb6vt7@master>
 <Ydi6iMbSZ/FewYPT@casper.infradead.org>
 <20220107160825.13c71fdd871d7d5611d116b9@linux-foundation.org>
 <YdjfsbAR0UlwyC6b@casper.infradead.org>
 <20220108081340.3oi2z2rm3cbqozzt@master>
 <20220123013852.mm7eyn3z26v3hkc2@master>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220123013852.mm7eyn3z26v3hkc2@master>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/22 02:38, Wei Yang wrote:
> On Sat, Jan 08, 2022 at 08:13:40AM +0000, Wei Yang wrote:
>>On Sat, Jan 08, 2022 at 12:49:53AM +0000, Matthew Wilcox wrote:
>>>On Fri, Jan 07, 2022 at 04:08:25PM -0800, Andrew Morton wrote:
>>>> On Fri, 7 Jan 2022 22:11:20 +0000 Matthew Wilcox <willy@infradead.org> wrote:
>>>> 
>>>> > > Hi, Matthew
>>>> > > 
>>>> > > Would you mind sharing some insight on this check?
>>>> > 
>>>> > It's right there in the comments.
>>>> 
>>>> Well I can't figure out which comment you're referring to?
>>>
>>>         * WARNING: bit 0 of the first word is used for PageTail(). That
>>>         * means the other users of this union MUST NOT use the bit to
>>>         * avoid collision and false-positive PageTail().
>>>
>>
>>I know this requirement on bit 0 of first word. But I don't see the connection
>>between this and the check of page->compound_head and folio->lru.
>>
>>This is more like a internal requirement on struct page. There are 8 struct in
>>this five words union. And this requirement apply to bit 0 of first word of
>>all those five struct.
>>
>>To me, if folio has the same layout of page, folio meets this requirement. I
>>still not catch the point why we need this check here.
>>
> 
> Hi, Matthew
> 
> Are you back from vocation? If you could give more insight on this check, I
> would be appreciated.

I can offer my insight (which might be of course wrong). Ideally one day
page.lru will be gone and only folio will be used for LRU pages. Then there
won't be a  FOLIO_MATCH(lru, lru); and FOLIO_MATCH(compound_head, lru);
won't appear to be redundant anymore. lru is list_head so two pointers and
thus valid pointers are aligned in such a way they can't accidentaly set the
bit 0.


