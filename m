Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CCC5A77E2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiHaHpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiHaHp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0B93ECD5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661931900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dpy4YKvRic0CfOkMcyrOI8ocSgvF1hU1/YMITsEVbp8=;
        b=LXcET1G4NwOPfRvhDYhhT2TU8smswJQTuRfYwmmrJpDKD8lXuzS663SWTjK8ZDX4YxojFK
        zsANT78q0CMnSE53u8KJH189/HStClgpw6VDd7FBkXh68qAiKjNOc/0Skno9A5rU/uMhnV
        r0Pbil5+EUupMlrOe0C3QLXpIMBme/4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-490-xa9kOPtGNjuCxqRcj6YZTw-1; Wed, 31 Aug 2022 03:44:59 -0400
X-MC-Unique: xa9kOPtGNjuCxqRcj6YZTw-1
Received: by mail-wr1-f69.google.com with SMTP id u15-20020adfa18f000000b00226d4b62f10so1599186wru.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=dpy4YKvRic0CfOkMcyrOI8ocSgvF1hU1/YMITsEVbp8=;
        b=VoepFSs1N+wzxlq0MeSV8vpODDFnZ0O88mwJUN7CqAJa+XPh9W7uLZTxF/hejnVg8G
         2+8FdQWoMxLtwky+TCl2i3EAutl1iCf3uYdZretTPMepcHoPXQmECfs+Xs1d8jcFaHKW
         XO4/tWujPtHEGGIWRiAqZuyBHFvCJyrnSict6Mmv3aLCH49ul9qQUo8+DT2vHrYKLgE2
         rjrtx2K17lU76IkU5zdYaH9hMFfvYSXTzSpDsWyVhqa1BtpHSqPOUKFLSuaOcgxRJ2sh
         UTQT96vHQoXQW/EofffoYiJDDn8jdTtST6wLv8SBwigUf2kZVb3otXYgD6UkLrMJX+Sm
         +nHQ==
X-Gm-Message-State: ACgBeo2KqtPvhlBp2ntQ6VOyXi8QH3Q9qmd5qrk3Rmi/GedeNG5UW2tR
        DiQlKoXCeHEMNzq19eUnygsMXUTCllChh9RlUoPbxFZSqqs6bgccB7orTynzxNPzllAH87lLhht
        rA4QJeMiTXGLcLSpluh2kbJ5s
X-Received: by 2002:a5d:4acc:0:b0:225:74d6:57a4 with SMTP id y12-20020a5d4acc000000b0022574d657a4mr10680734wrs.500.1661931898380;
        Wed, 31 Aug 2022 00:44:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7vwEX7l5fxHsydx9msv2QgAleH7o4CayyjuKAa/vA88L7Tm5NwytDB9HOyJpTAiYtA4auvVQ==
X-Received: by 2002:a5d:4acc:0:b0:225:74d6:57a4 with SMTP id y12-20020a5d4acc000000b0022574d657a4mr10680717wrs.500.1661931898043;
        Wed, 31 Aug 2022 00:44:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:2900:1613:4308:aca3:2786? (p200300cbc706290016134308aca32786.dip0.t-ipconnect.de. [2003:cb:c706:2900:1613:4308:aca3:2786])
        by smtp.gmail.com with ESMTPSA id u21-20020a7bc055000000b003a3442f1229sm1229908wmc.29.2022.08.31.00.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 00:44:57 -0700 (PDT)
Message-ID: <ac02593b-9272-df8c-120f-611b5489458a@redhat.com>
Date:   Wed, 31 Aug 2022 09:44:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>
References: <20220825164659.89824-1-david@redhat.com>
 <20220825164659.89824-3-david@redhat.com>
 <1892f6de-fd22-0e8b-3ff6-4c8641e1c68e@redhat.com>
 <2e20c90d-4d1f-dd83-aa63-9d8d17021263@redhat.com>
 <Yw5a1paQJ9MNdgmW@nvidia.com>
 <9ce3aaaa-71a6-5a81-16a3-36e6763feb91@redhat.com>
 <9a4fe603-950e-785b-6281-2e309256463f@nvidia.com>
 <68b38ac4-c680-b694-21a9-1971396d63b9@redhat.com>
 <Yw6g7G4jvXaoBORm@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 2/3] mm/gup: use gup_can_follow_protnone() also in
 GUP-fast
In-Reply-To: <Yw6g7G4jvXaoBORm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.22 01:44, Jason Gunthorpe wrote:
> On Tue, Aug 30, 2022 at 09:23:44PM +0200, David Hildenbrand wrote:
>> @@ -2997,6 +2997,11 @@ static inline bool gup_must_unshare(unsigned int flags, struct page *page)
>>  	 */
>>  	if (!PageAnon(page))
>>  		return false;
>> +
>> +	/* See page_try_share_anon_rmap() for GUP-fast details. */
>> +	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) && irqs_disabled())
>> +		smp_rmb();
>> +
>>  	/*
>>  	 * Note that PageKsm() pages cannot be exclusive, and consequently,
>>  	 * cannot get pinned.
>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>> index bf80adca980b..454c159f2aae 100644
>> --- a/include/linux/rmap.h
>> +++ b/include/linux/rmap.h
>> @@ -267,7 +267,7 @@ static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
>>   * @page: the exclusive anonymous page to try marking possibly shared
>>   *
>>   * The caller needs to hold the PT lock and has to have the page table entry
>> - * cleared/invalidated+flushed, to properly sync against GUP-fast.
>> + * cleared/invalidated.
>>   *
>>   * This is similar to page_try_dup_anon_rmap(), however, not used during fork()
>>   * to duplicate a mapping, but instead to prepare for KSM or temporarily
>> @@ -283,12 +283,60 @@ static inline int page_try_share_anon_rmap(struct page *page)
>>  {
>>  	VM_BUG_ON_PAGE(!PageAnon(page) || !PageAnonExclusive(page), page);
>>  
>> -	/* See page_try_dup_anon_rmap(). */
>> -	if (likely(!is_device_private_page(page) &&
>> -	    unlikely(page_maybe_dma_pinned(page))))
>> -		return -EBUSY;
>> +	/* device private pages cannot get pinned via GUP. */
>> +	if (unlikely(is_device_private_page(page))) {
>> +		ClearPageAnonExclusive(page);
>> +		return 0;
>> +	}
>>  
>> +	/*
>> +	 * We have to make sure that while we clear PageAnonExclusive, that
>> +	 * the page is not pinned and that concurrent GUP-fast won't succeed in
>> +	 * concurrently pinning the page.
>> +	 *
>> +	 * Conceptually, GUP-fast pinning code of anon pages consists of:
>> +	 * (1) Read the PTE
>> +	 * (2) Pin the mapped page
>> +	 * (3) Check if the PTE changed by re-reading it; back off if so.
>> +	 * (4) Check if PageAnonExclusive is not set; back off if so.
>> +	 *
>> +	 * Conceptually, PageAnonExclusive clearing code consists of:
>> +	 * (1) Clear PTE
>> +	 * (2) Check if the page is pinned; back off if so.
>> +	 * (3) Clear PageAnonExclusive
>> +	 * (4) Restore PTE (optional)
>> +	 *
>> +	 * In GUP-fast, we have to make sure that (2),(3) and (4) happen in
>> +	 * the right order. Memory order between (2) and (3) is handled by
>> +	 * GUP-fast, independent of PageAnonExclusive.
>> +	 *
>> +	 * When clearing PageAnonExclusive(), we have to make sure that (1),
>> +	 * (2), (3) and (4) happen in the right order.
>> +	 *
>> +	 * Note that (4) has to happen after (3) in both cases to handle the
>> +	 * corner case whereby the PTE is restored to the original value after
>> +	 * clearing PageAnonExclusive and while GUP-fast might not detect the
>> +	 * PTE change, it will detect the PageAnonExclusive change.
>> +	 *
>> +	 * We assume that there might not be a memory barrier after
>> +	 * clearing/invalidating the PTE (1) and before restoring the PTE (4),
>> +	 * so we use explicit ones here.
>> +	 *
>> +	 * These memory barriers are paired with memory barriers in GUP-fast
>> +	 * code, including gup_must_unshare().
>> +	 */
>> +
>> +	/* Clear/invalidate the PTE before checking for PINs. */
>> +	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
>> +		smp_mb();
>> +
>> +	if (unlikely(page_maybe_dma_pinned(page)))
>> +		return -EBUSY;
> 
> It is usually a bad sign to see an attempt to create a "read release"..

I still have to get used to the acquire/release semantics ... :)

> 
>>  	ClearPageAnonExclusive(page);
>> +
>> +	/* Clear PageAnonExclusive() before eventually restoring the PTE. */
>> +	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
>> +		smp_mb__after_atomic();
>>  	return 0;
>>  }
> 
> I don't know enough about the memory model to say if this is OK..

I guess it's best to include some memory model folks once we have something
that looks reasonable.

> 
> Generally, I've never seen an algorithm be successfull with these
> kinds of multi-atomic gyrations.

Yeah, I'm absolutely looking for a nicer alternative to sync with
RCU GUP-fast. So far I wasn't successful.

> 
> If we break it down a bit, and replace the 'read release' with an
> actual atomic for discussion:
> 
> 
>        CPU0                  CPU1
>                             clear pte 
>                             incr_return ref // release & acquire
>  add_ref // acquire
> 
> This seems OK, if CPU1 views !dma then CPU0 must view clear pte due to
> the atomic's release/acquire semantic
> 
> If CPU1 views dma then it just exits
> 
> 
> Now the second phase:
> 
>        CPU0                  CPU1
>                             clear anon_exclusive
>                             restore pte // release
> 
>  read_pte // acquire
>  read anon_exclusive 
> 
> If CPU0 observes the restored PTE then it must observe the cleared
> anon_exclusive
> 
> Otherwise CPU0 must observe the cleared PTE.
> 
> So, maybe I could convince myself it is OK, but I think your placement
> of barriers is confusing as to what data the barrier is actually
> linked to.
> 
> We are using a barrier around the ref - acquire on the CPU0 and full
> barier on the CPU1 (eg atomic_read(); smb_mb_after_atomic() )

When dropping the other patch, I think we still need something like

diff --git a/mm/gup.c b/mm/gup.c
index 5abdaf487460..8c5ff41d5e56 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -158,6 +158,13 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
                else
                        folio_ref_add(folio,
                                        refs * (GUP_PIN_COUNTING_BIAS - 1));
+               /*
+                * Adjust the pincount before re-checking the PTE for changes.
+                *
+                * Paired with a memory barrier in page_try_share_anon_rmap().
+                */
+               smb_mb__after_atomic();
+
                node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
 
                return folio;


> 
> The second phase uses a smp_store_release/load_acquire on the PTE.
> 
> It is the same barriers you sketched but integrated with the data they
> are ordering.

Sorry for having to ask, but what exactly would be your suggestion?

Thanks for having a look!

-- 
Thanks,

David / dhildenb

