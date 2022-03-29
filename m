Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390DB4EAEEE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbiC2OBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiC2OBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:01:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7D8C255A81
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648562401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ZqemDiilpXZRsGW64Filc3A1/e3UcE51b6PVnuxGic=;
        b=d0a54JcknmtIqp5NCxGxQKEuwZ2hUkm5JiidUp63Z2E6H+jd8nWZguTQqYfbIAcW7Yt9kW
        uqspddwfV5fxJxV3uYEf8n1/6A27tq37hVscDk3Yd6G1V257E1U4IKnXkKUFzuDcMYYytI
        nQWG/pyI208VP9rrYgcWj3yJ7l/YAng=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-TS7YT3xAOL2t-UbqSxXKqQ-1; Tue, 29 Mar 2022 09:59:59 -0400
X-MC-Unique: TS7YT3xAOL2t-UbqSxXKqQ-1
Received: by mail-wm1-f71.google.com with SMTP id 84-20020a1c0257000000b0038124c99ebcso6787518wmc.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=/ZqemDiilpXZRsGW64Filc3A1/e3UcE51b6PVnuxGic=;
        b=a+FtXZ7zNttvOJp89CmrC/44GbMG6tE7YGT0zQxuiS4CmpBQpoPK/ugV7EjgDPOlPN
         qSkHXzy3/nm+s7F3RnRn3J8q040xQihGnWf/M2LUVz9mNxfGiAOP3oPoiXxCVFOL+B/H
         fU5YxuZzFNt27qTHGxSX0pyxxBUPYWc1CMksX/kGyvOXwFhgKte/AGCaOSQpGD793pDT
         JTmUycgDt4FTKTPg5R2FbPHXxLhk6Iqp/GJebOpzU9PUq/BBVfHYcT6OTAq6fwE3BL4B
         zrgLTaHH+KINS/FpnLEhLPIokvrP8SbQu4TkTuPyzhHszpS8J2RE4Dai6m1sCFZmd4qs
         HaVg==
X-Gm-Message-State: AOAM533Vo2MHRnV8aIS5zQRHOY6YD/ro6jgl9bGDK2+VBkVXGdO2vzyO
        s3CJ7KlXA4lTmzedmcjGA++qY4o8f8po69+f4UYoO4uVhmEq/5WoSxL0MTCdwFkRFhNZFZYFGA9
        viQWf9zsjdur6ilzN/93ePnMHelAC69fPaE+tgn89BSLrqS7bcdSwv7WYz1oVkgYCdQytTdc0
X-Received: by 2002:a5d:6c6f:0:b0:204:555:73cf with SMTP id r15-20020a5d6c6f000000b00204055573cfmr30183192wrz.24.1648562398436;
        Tue, 29 Mar 2022 06:59:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBbJdDFpIw2PVYMOn0HR+uQcrMf86yObuHBVJz108nl3QEF3sbNHSGEVByeUJ9zQeXwtkZSQ==
X-Received: by 2002:a5d:6c6f:0:b0:204:555:73cf with SMTP id r15-20020a5d6c6f000000b00204055573cfmr30183121wrz.24.1648562398042;
        Tue, 29 Mar 2022 06:59:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:af00:7a8a:46df:a7c3:c4c7? (p200300cbc708af007a8a46dfa7c3c4c7.dip0.t-ipconnect.de. [2003:cb:c708:af00:7a8a:46df:a7c3:c4c7])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm17207749wrz.29.2022.03.29.06.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 06:59:57 -0700 (PDT)
Message-ID: <d98bd1f9-e9b7-049c-7bde-3348b074eb18@redhat.com>
Date:   Tue, 29 Mar 2022 15:59:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220315104741.63071-1-david@redhat.com>
 <20220315104741.63071-2-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 01/15] mm/rmap: fix missing swap_free() in
 try_to_unmap() after arch_unmap_one() failed
In-Reply-To: <20220315104741.63071-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.22 11:47, David Hildenbrand wrote:
> In case arch_unmap_one() fails, we already did a swap_duplicate(). let's
> undo that properly via swap_free().
> 
> Fixes: ca827d55ebaa ("mm, swap: Add infrastructure for saving page metadata on swap")
> Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/rmap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 6a1e8c7f6213..f825aeef61ca 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1625,6 +1625,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  				break;
>  			}
>  			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
> +				swap_free(entry);
>  				set_pte_at(mm, address, pvmw.pte, pteval);
>  				ret = false;
>  				page_vma_mapped_walk_done(&pvmw);

Hi Khalid,

I'm a bit confused about the semantics if arch_unmap_one(), I hope you can clarify.


See patch #11 in this series, were we can fail unmapping after arch_unmap_one() succeeded. E.g., 

@@ -1623,6 +1634,24 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 				page_vma_mapped_walk_done(&pvmw);
 				break;
 			}
+			if (anon_exclusive &&
+			    page_try_share_anon_rmap(subpage)) {
+				swap_free(entry);
+				set_pte_at(mm, address, pvmw.pte, pteval);
+				ret = false;
+				page_vma_mapped_walk_done(&pvmw);
+				break;
+			}
+			/*
+			 * Note: We don't remember yet if the page was mapped
+			 * exclusively in the swap entry, so swapin code has
+			 * to re-determine that manually and might detect the
+			 * page as possibly shared, for example, if there are
+			 * other references on the page or if the page is under
+			 * writeback. We made sure that there are no GUP pins
+			 * on the page that would rely on it, so for GUP pins
+			 * this is fine.
+			 */
 			if (list_empty(&mm->mmlist)) {
 				spin_lock(&mmlist_lock);
 				if (list_empty(&mm->mmlist))


For now, I was under the impression that we don't have to undo anything after
arch_unmap_one() succeeded, because we seem to not do anything for two
cases below. But looking into arch_unmap_one() and how it allocates stuff I do
wonder what we would actually want to do here -- I'd assume we'd want to
trigger the del_tag_store() somehow?

arch_unmap_one() calls adi_save_tags(), which allocates memory.
adi_restore_tags()->del_tag_store() reverts that operation and ends up
freeing memory conditionally; However, it's only
called from arch_do_swap_page().


Here is why I have to scratch my head:

a) arch_do_swap_page() is only called from do_swap_page(). We don't do anything similar
for mm/swapfile.c:unuse_pte(), aren't we missing something?

b) try_to_migrate_one() does the arch_unmap_one(), but who will do the
restore+free after migration succeeded or failed, aren't we missing something?


I assume that we won't be properly freeing the tag space in case of a), and won't
be properly restoring/migrating the tags in case of a) and b).


I'll send out v3 of this series today, and I'll keep ignoring arch_unmap_one()
for now, because I have no clue what to do and it looks incomplete already, unless
I am missing something important.

-- 
Thanks,

David / dhildenb

