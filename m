Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AE54B2ACD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351704AbiBKQpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:45:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351686AbiBKQpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:45:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E436D102
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:45:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 37F1D210E2;
        Fri, 11 Feb 2022 16:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644597927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JG6VCjeiAkeUL6Rpz2LpHri59dxNDgRuJeCG5zsYiLw=;
        b=c+bwZ0OXGT0PuuChKSsjvdI2ZwQGyZUoSx8Y+jlbLt0Lmme4ZOZ4Wlr8U9wTbcwB+VHCJ3
        hXBIA43sdeTPtwcBN5bB/cSef7K387eqIGQ9vjAjHFudxnp2C9PPJRgCmpSOvk+eYx1+m3
        ayC+yq4dPnPS1i9xm1nnOOhiyf82oJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644597927;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JG6VCjeiAkeUL6Rpz2LpHri59dxNDgRuJeCG5zsYiLw=;
        b=KF+weUUfsrjBr/2qs5X4rNiVuE8C6g+q4n2SDEBVfvfZM0DFXmKI4GjYsqvmeivgmu9sxj
        925HVhAQHm+tosCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDC7313C9E;
        Fri, 11 Feb 2022 16:45:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ppodOaaSBmKydAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 11 Feb 2022 16:45:26 +0000
Message-ID: <2ec49f65-fe4e-26a0-4059-c18e6dab0af4@suse.cz>
Date:   Fri, 11 Feb 2022 17:45:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 07/13] mm/munlock: mlock_pte_range() when mlocking or
 munlocking
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
 <8bc3ee8c-7f1-d812-7f22-4f9f6d436bc@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <8bc3ee8c-7f1-d812-7f22-4f9f6d436bc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/22 22:42, Hugh Dickins wrote:
> Fill in missing pieces: reimplementation of munlock_vma_pages_range(),
> required to lower the mlock_counts when munlocking without munmapping;
> and its complement, implementation of mlock_vma_pages_range(), required
> to raise the mlock_counts on pages already there when a range is mlocked.
> 
> Combine them into just the one function mlock_vma_pages_range(), using
> walk_page_range() to run mlock_pte_range().  This approach fixes the
> "Very slow unlockall()" of unpopulated PROT_NONE areas, reported in
> https://lore.kernel.org/linux-mm/70885d37-62b7-748b-29df-9e94f3291736@gmail.com/
> 
> Munlock clears VM_LOCKED at the start, under exclusive mmap_lock; but if
> a racing truncate or holepunch (depending on i_mmap_rwsem) gets to the
> pte first, it will not try to munlock the page: leaving release_pages()
> to correct it when the last reference to the page is gone - that's okay,
> a page is not evictable anyway while it is held by an extra reference.
> 
> Mlock sets VM_LOCKED at the start, under exclusive mmap_lock; but if
> a racing remove_migration_pte() or try_to_unmap_one() (depending on
> i_mmap_rwsem) gets to the pte first, it will try to mlock the page,
> then mlock_pte_range() mlock it a second time.  This is harder to
> reproduce, but a more serious race because it could leave the page
> unevictable indefinitely though the area is munlocked afterwards.
> Guard against it by setting the (inappropriate) VM_IO flag,
> and modifying mlock_vma_page() to decline such vmas.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> @@ -162,8 +230,7 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
>  	pgoff_t pgoff;
>  	int nr_pages;
>  	int ret = 0;
> -	int lock = !!(newflags & VM_LOCKED);
> -	vm_flags_t old_flags = vma->vm_flags;
> +	vm_flags_t oldflags = vma->vm_flags;
>  
>  	if (newflags == vma->vm_flags || (vma->vm_flags & VM_SPECIAL) ||

Nit: can use oldflags instead of vma->vm_flags above?

