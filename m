Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917A748DCE1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbiAMRZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:25:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20434 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232267AbiAMRZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642094734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u63CS+l8iXW5DrMeOzc0LeIu7b2fmrBj/JKV8w8cCSI=;
        b=B5uI4pD5Ge89PSrYBSPMm/1waCsFT05W2+q0ALSitxUsv11LG4C3GLB76IxVkFngS+CDtz
        fxA6bjgi8LHco39dmlvU46onGWPBMhWlyoO5mlVT0hIb0g/bZvuNdOy63SkhA5IJJTIic1
        kPd/hrluz6BR8JWumxB8fDrBNWCS2ng=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-7TpGM4m2Oq-E3wMImOBfHA-1; Thu, 13 Jan 2022 12:25:33 -0500
X-MC-Unique: 7TpGM4m2Oq-E3wMImOBfHA-1
Received: by mail-ed1-f71.google.com with SMTP id g2-20020a056402424200b003f8ee03207eso6003356edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 09:25:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=u63CS+l8iXW5DrMeOzc0LeIu7b2fmrBj/JKV8w8cCSI=;
        b=CZyVgvhhRQDxnbp6hzUWwVcxZgAuqIb40gH6O4f3eeXWH+WPDj5xHdqekmBjkISw99
         fGiQdITMjZ96/OcBh8941Klq8W3skxGqbd3iWSeZrjj5Q4OH/XbFzruWcynf0Ri7R36Q
         u+lB1jzEO+lKzOgv2OA+hLQhEEwriN7gI6I6U7fQJCCEQd9xoL8VO8wMBxjf5sUjUIdc
         oeDxD+wXv4Fr34ojUt9CD/z2zHM89jGTiiCbYNlNFvDicSEkdngFUvf39WbsMgN8U0wq
         ytTaSTlehYOC0MSBk014OJUuLH4elvni+qXXWCWcJtgec4QnIDJ5/DIyDVLYGPK2Q7gG
         j3Cw==
X-Gm-Message-State: AOAM531mUTq9Lmdz1iAZkz2tCqoIOvu9+YTDUq/T/57fUK/XZ3R1URVe
        s2btcEJ8S/NZwYUAAzsbuBCv8ePcbq8lO/RoZ2JhgATnrfdcl87/CgRRP0ZK5lI7mt1AyoR2o6o
        EwSJvi8pzhIjBtj0d4wWt+Dvg
X-Received: by 2002:a17:906:4c95:: with SMTP id q21mr4214914eju.173.1642094731974;
        Thu, 13 Jan 2022 09:25:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxue5EORH4C3LamFq5FM5xmxPnjCiuI6F176Ra3C23fIvF0TZiVgjwHdyJQKqJF9Gaw+f2Kig==
X-Received: by 2002:a17:906:4c95:: with SMTP id q21mr4214896eju.173.1642094731682;
        Thu, 13 Jan 2022 09:25:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:e200:8511:ed0f:ac2c:42f7? (p200300cbc703e2008511ed0fac2c42f7.dip0.t-ipconnect.de. [2003:cb:c703:e200:8511:ed0f:ac2c:42f7])
        by smtp.gmail.com with ESMTPSA id vr3sm1065351ejb.107.2022.01.13.09.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 09:25:31 -0800 (PST)
Message-ID: <c3f34084-7315-e0c5-55db-d1cb006979f4@redhat.com>
Date:   Thu, 13 Jan 2022 18:25:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Liang Zhang <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org>
 <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
 <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com>
 <CAHk-=wi21DZ4H5uLnn2QgAeAUqg0wNPboijC0OgDDk1e7TdkPw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
In-Reply-To: <CAHk-=wi21DZ4H5uLnn2QgAeAUqg0wNPboijC0OgDDk1e7TdkPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.01.22 18:14, Linus Torvalds wrote:
> On Thu, Jan 13, 2022 at 8:48 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> I'm wondering if we can get rid of the mapcount checks in
>> reuse_swap_page() and instead check for page_count() and swapcount only.
> 
> Honestly, I think even checking page_count() is pointless.
> 
> If the page has users, then that's fine. That's irrelevant for whether
> it's a swap page or not, no?
> 
> So if you want to remove it from the swap cache, all that matters is that
> 
>  (a) you have it locked so that there can be no new users trying to mix it up
> 
>  (b) there are no swapcount() users of this page (which don't have a
> ref to the page itself, they only have a swap entry), so that you
> can't have somebody trying to look it up (whether some racy
> "concurrent" lookup _or_ any later one, since we're about to remove
> the swap cache association).
> 
> Why would "map_count()" matter - it's now many times the *page* is
> mapped, it's irrelevant to swap cache status? And for the same reason,
> what difference does "page_count()" have?
> 
> One big reason I did the COW rewrite was literally that the rules were
> pure voodoo and made no sense at all. There was no underlying logic,
> it was just a random collection of random tests that didn't have any
> logical architecture to them.
> 
> Our VM is really really complicated already, so I really want our code
> to make sense.
> 
> So even if I'm entirely wrong in my swap/map-count arguments above,
> I'd like whatever patches in this area to be really well commented and
> have some fundamental rules and logic to them so that people can read
> the code and go "Ok, makes sense".
> 
> Please?

I might be missing something, but it's not only about whether we can remove
the page from the swap cache, it's about whether we can reuse the page
exclusively in a process with write access, avoiding a COW. And for that we
have to check if it's mapped somewhere else already (readable).

Here is a sketch (buggy, untested, uncompiled) of how I think reuse_swap_page()
could look like, removing any mapcount logic and incorporating the
refount, leaving the page_trans_huge_swapcount() changes etc. out of the picture.

Would that make any sense?


bool reuse_swap_page(struct page *page, bool mapped)
{
	int swapcount = 0, total_swapcount;

	VM_BUG_ON_PAGE(!PageLocked(page), page);
	if (unlikely(PageKsm(page)))
		return false;

	if (PageSwapCache(page)) {
		swapcount = page_trans_huge_swapcount(page, &total_swapcount);

		if (swapcount == 1 && !mapped &&
		    (likely(!PageTransCompound(page)) ||
		     /* The remaining swap count will be freed soon */
		     total_swapcount == page_swapcount(page))) {
			if (!PageWriteback(page)) {
				page = compound_head(page);
				delete_from_swap_cache(page);
				SetPageDirty(page);
			} else {
				swp_entry_t entry;
				struct swap_info_struct *p;

				entry.val = page_private(page);
				p = swap_info_get(entry);
				if (p->flags & SWP_STABLE_WRITES) {
					spin_unlock(&p->lock);
					return false;
				}
				spin_unlock(&p->lock);
			}
		}
	}

	/*
	 * We expect exactly one ref from our mapped page (if already mapped)
	 * and one ref from the swapcache (if in the swapcache).
	 */
	if (!mapped)
		return swapcount == 1 && page_count(page) == !!PageSwapCache(page)
	return swapcount == 0 && page_count(page) == 1 + !!PageSwapCache(page)
}


-- 
Thanks,

David / dhildenb

