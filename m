Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB5B508E32
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380994AbiDTRRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380948AbiDTRRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:17:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098D8457A9;
        Wed, 20 Apr 2022 10:14:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 53D461F380;
        Wed, 20 Apr 2022 17:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650474856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cCyVaEehkrahTF4ZZE0t6pBOtUmw5LLz8/1wxeHDxX4=;
        b=K7U7yAPVtWoeKBCvI9IM0SUrBd3SuNQlXwbO69YYMvu/uQgJCBHLxvJUvYDJUM+CzMgGQE
        RVSlZxkoXhp1TqU71hUtulLocxn+2wyVtaobkUyEwzAopoea+zPD+x5OcZ/P14F7mUWQ0X
        9jy/5tEGm6a4qWbujDTO1fyNpFdYlOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650474856;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cCyVaEehkrahTF4ZZE0t6pBOtUmw5LLz8/1wxeHDxX4=;
        b=NwzWMKJRWqBiYsMEpHY2LSE0kR5L5AsWQDr46B/AzDDh+7ae+1bOHK7cbVF3M3crtt+AoJ
        6QSH0t6rY1IUvWBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E94C13A30;
        Wed, 20 Apr 2022 17:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cLLMJWc/YGJFYAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 20 Apr 2022 17:14:15 +0000
Message-ID: <e1b61853-143a-3691-2e6d-4fea5c049562@suse.cz>
Date:   Wed, 20 Apr 2022 19:14:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/8] mm/debug_vm_pgtable: add tests for
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
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
        Jann Horn <jannh@google.com>, Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
References: <20220329164329.208407-1-david@redhat.com>
 <20220329164329.208407-3-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220329164329.208407-3-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 18:43, David Hildenbrand wrote:
> Let's test that __HAVE_ARCH_PTE_SWP_EXCLUSIVE works as expected.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/debug_vm_pgtable.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index db2abd9e415b..55f1a8dc716f 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -837,6 +837,19 @@ static void __init pmd_soft_dirty_tests(struct pgtable_debug_args *args) { }
>  static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args) { }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> +static void __init pte_swap_exclusive_tests(struct pgtable_debug_args *args)
> +{
> +#ifdef __HAVE_ARCH_PTE_SWP_EXCLUSIVE
> +	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
> +
> +	pr_debug("Validating PTE swap exclusive\n");
> +	pte = pte_swp_mkexclusive(pte);
> +	WARN_ON(!pte_swp_exclusive(pte));

I guess only this WARN_ON must be guarded by the #ifdef, but doesn't matter
that much - won't gain significantly more test coverage.

> +	pte = pte_swp_clear_exclusive(pte);
> +	WARN_ON(pte_swp_exclusive(pte));
> +#endif /* __HAVE_ARCH_PTE_SWP_EXCLUSIVE */
> +}
> +
>  static void __init pte_swap_tests(struct pgtable_debug_args *args)
>  {
>  	swp_entry_t swp;
> @@ -1288,6 +1301,8 @@ static int __init debug_vm_pgtable(void)
>  	pte_swap_soft_dirty_tests(&args);
>  	pmd_swap_soft_dirty_tests(&args);
>  
> +	pte_swap_exclusive_tests(&args);
> +
>  	pte_swap_tests(&args);
>  	pmd_swap_tests(&args);
>  

