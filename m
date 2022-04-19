Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7D3507260
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354127AbiDSP7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351075AbiDSP7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:59:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41FC237D8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:56:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4FBF11F746;
        Tue, 19 Apr 2022 15:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650383812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OtGb0B+xVaMUOR9TH3eGpGH3Rm/fFjg1NOhtMi5AUB0=;
        b=Q4gR8e9hF6R1WIxUXQa0AxU+tadg5Q0S/b//sEZCC6M3Qbe5z0t/+XAsNHDN05NA9tWM0f
        KvxuWeIhgaiWW1ydLDdLU4qx/GnAJv+aPGMkK2kEgQHMMRgB1YrBGuiz/806L2xDMDgFKx
        qLTrAYARB252gd04IozSIo3UEvEQDBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650383812;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OtGb0B+xVaMUOR9TH3eGpGH3Rm/fFjg1NOhtMi5AUB0=;
        b=GsmktdgmvEF9My+EljUH0wy6tjAUH8F2AFdXn7ez/QNin50kfMzEoavOW1TiGFFeRHTjDV
        bUvOVXm95E9hiuBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D649B139BE;
        Tue, 19 Apr 2022 15:56:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id REqfM8PbXmLyRQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 19 Apr 2022 15:56:51 +0000
Message-ID: <b35374d1-858c-393a-7b63-8816efe9b175@suse.cz>
Date:   Tue, 19 Apr 2022 17:56:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 15/16] mm/gup: trigger FAULT_FLAG_UNSHARE when
 R/O-pinning a possibly shared anonymous page
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
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220329160440.193848-1-david@redhat.com>
 <20220329160440.193848-16-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220329160440.193848-16-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 18:04, David Hildenbrand wrote:
> Whenever GUP currently ends up taking a R/O pin on an anonymous page that
> might be shared -- mapped R/O and !PageAnonExclusive() -- any write fault
> on the page table entry will end up replacing the mapped anonymous page
> due to COW, resulting in the GUP pin no longer being consistent with the
> page actually mapped into the page table.
> 
> The possible ways to deal with this situation are:
>  (1) Ignore and pin -- what we do right now.
>  (2) Fail to pin -- which would be rather surprising to callers and
>      could break user space.
>  (3) Trigger unsharing and pin the now exclusive page -- reliable R/O
>      pins.
> 
> Let's implement 3) because it provides the clearest semantics and
> allows for checking in unpin_user_pages() and friends for possible BUGs:
> when trying to unpin a page that's no longer exclusive, clearly
> something went very wrong and might result in memory corruptions that
> might be hard to debug. So we better have a nice way to spot such
> issues.
> 
> This change implies that whenever user space *wrote* to a private
> mapping (IOW, we have an anonymous page mapped), that GUP pins will
> always remain consistent: reliable R/O GUP pins of anonymous pages.
> 
> As a side note, this commit fixes the COW security issue for hugetlb with
> FOLL_PIN as documented in:
>   https://lore.kernel.org/r/3ae33b08-d9ef-f846-56fb-645e3b9b4c66@redhat.com
> The vmsplice reproducer still applies, because vmsplice uses FOLL_GET
> instead of FOLL_PIN.
> 
> Note that follow_huge_pmd() doesn't apply because we cannot end up in
> there with FOLL_PIN.
> 
> This commit is heavily based on prototype patches by Andrea.
> 
> Co-developed-by: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
