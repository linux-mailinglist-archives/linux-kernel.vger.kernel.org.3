Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA513508E18
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380935AbiDTRNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380924AbiDTRNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:13:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6600345502;
        Wed, 20 Apr 2022 10:10:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9598221107;
        Wed, 20 Apr 2022 17:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650474628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fv+DUHDuv75iqi/speofL8fyyiV3PO12nkEaPGAjVpg=;
        b=qEFLX/t/h3r7OpqmNOmGOP8dA4rSO2sikq6ol1N77QIelrvEBFghQ7bcvovldgvJObmH6p
        66q5lRqmWi9t95sVzEwUZIP8Cr7uNETQRm4NEKf64zjhBKay2Q/2JBXNnuG2fhAbtkoWOO
        HtmZ7GIqs22vDe7hH9NqFNk4XWWgWUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650474628;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fv+DUHDuv75iqi/speofL8fyyiV3PO12nkEaPGAjVpg=;
        b=Lz02F1m0uYxMKVcER4wii/ZMq3u7/dEO9YPxA0w+R8Q7KJp2LiDa55Odye1bSPkQBU7LeS
        pJ2pECEhijNbb1DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E940913A30;
        Wed, 20 Apr 2022 17:10:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +h0eOIM+YGIqXwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 20 Apr 2022 17:10:27 +0000
Message-ID: <b49f1b4c-defa-ef32-1984-0273e1fad178@suse.cz>
Date:   Wed, 20 Apr 2022 19:10:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/8] mm/swap: remember PG_anon_exclusive via a swp pte
 bit
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
 <20220329164329.208407-2-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220329164329.208407-2-david@redhat.com>
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
> Currently, we clear PG_anon_exclusive in try_to_unmap() and forget about
> it. We do this, to keep fork() logic on swap entries easy and efficient:
> for example, if we wouldn't clear it when unmapping, we'd have to lookup
> the page in the swapcache for each and every swap entry during fork() and
> clear PG_anon_exclusive if set.
> 
> Instead, we want to store that information directly in the swap pte,
> protected by the page table lock, similarly to how we handle
> SWP_MIGRATION_READ_EXCLUSIVE for migration entries. However, for actual
> swap entries, we don't want to mess with the swap type (e.g., still one
> bit) because it overcomplicates swap code.
> 
> In try_to_unmap(), we already reject to unmap in case the page might be
> pinned, because we must not lose PG_anon_exclusive on pinned pages ever.
> Checking if there are other unexpected references reliably *before*
> completely unmapping a page is unfortunately not really possible: THP
> heavily overcomplicate the situation. Once fully unmapped it's easier --
> we, for example, make sure that there are no unexpected references
> *after* unmapping a page before starting writeback on that page.
> 
> So, we currently might end up unmapping a page and clearing
> PG_anon_exclusive if that page has additional references, for example,
> due to a FOLL_GET.
> 
> do_swap_page() has to re-determine if a page is exclusive, which will
> easily fail if there are other references on a page, most prominently
> GUP references via FOLL_GET. This can currently result in memory
> corruptions when taking a FOLL_GET | FOLL_WRITE reference on a page even
> when fork() is never involved: try_to_unmap() will succeed, and when
> refaulting the page, it cannot be marked exclusive and will get replaced
> by a copy in the page tables on the next write access, resulting in writes
> via the GUP reference to the page being lost.
> 
> In an ideal world, everybody that uses GUP and wants to modify page
> content, such as O_DIRECT, would properly use FOLL_PIN. However, that
> conversion will take a while. It's easier to fix what used to work in the
> past (FOLL_GET | FOLL_WRITE) remembering PG_anon_exclusive. In addition,
> by remembering PG_anon_exclusive we can further reduce unnecessary COW
> in some cases, so it's the natural thing to do.
> 
> So let's transfer the PG_anon_exclusive information to the swap pte and
> store it via an architecture-dependant pte bit; use that information when
> restoring the swap pte in do_swap_page() and unuse_pte(). During fork(), we
> simply have to clear the pte bit and are done.
> 
> Of course, there is one corner case to handle: swap backends that don't
> support concurrent page modifications while the page is under writeback.
> Special case these, and drop the exclusive marker. Add a comment why that
> is just fine (also, reuse_swap_page() would have done the same in the
> past).
> 
> In the future, we'll hopefully have all architectures support
> __HAVE_ARCH_PTE_SWP_EXCLUSIVE, such that we can get rid of the empty
> stubs and the define completely. Then, we can also convert
> SWP_MIGRATION_READ_EXCLUSIVE. For architectures it's fairly easy to
> support: either simply use a yet unused pte bit that can be used for swap
> entries, steal one from the arch type bits if they exceed 5, or steal one
> from the offset bits.
> 
> Note: R/O FOLL_GET references were never really reliable, especially
> when taking one on a shared page and then writing to the page (e.g., GUP
> after fork()). FOLL_GET, including R/W references, were never really
> reliable once fork was involved (e.g., GUP before fork(),
> GUP during fork()). KSM steps back in case it stumbles over unexpected
> references and is, therefore, fine.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

With the fixup as reportedy by Miaohe Lin

Acked-by: Vlastimil Babka <vbabka@suse.cz>

(sent a separate mm-commits mail to inquire about the fix going missing from
mmotm)

https://lore.kernel.org/mm-commits/c3195d8a-2931-0749-973a-1d04e4baec94@suse.cz/T/#m4e98ccae6f747e11f45e4d0726427ba2fef740eb

