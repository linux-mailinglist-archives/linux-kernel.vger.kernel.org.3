Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FA550180C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347686AbiDNQAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348917AbiDNPkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:40:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60441C4E33
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:18:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD5611F748;
        Thu, 14 Apr 2022 15:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649949533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dkqemCFNSh+ZhebkGa09gVt5pLy70xI4ZccBTAffCZc=;
        b=DxIcnPfo0yw48SFmUwgjqknFyxwyu9/5UOHIYjR/u80AC8WwvWRGi19AYn+UYzYlcaoNFm
        CmQuiS7GljV5MGuYtMBDIvPfEBYHaazqJwzzLT7Wl43ZR5M2cXEu5m7luqUOjgoKzt5BeY
        +SPMS8Hzt2pXydg7/qwdO1v7ZXlbNBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649949533;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dkqemCFNSh+ZhebkGa09gVt5pLy70xI4ZccBTAffCZc=;
        b=6P/o1p51DiXtaKeb2Y1dqvIQdSv7sHqoEAyyddZ9KCmHveSbw389Nrh5g+x7lf3P2bOOQc
        xjqZhKB2ey364hCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8432C13A86;
        Thu, 14 Apr 2022 15:18:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VJi8H107WGJFbwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 14 Apr 2022 15:18:53 +0000
Message-ID: <08c355b4-fa21-8716-bf05-3331914f150e@suse.cz>
Date:   Thu, 14 Apr 2022 17:18:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 13/16] mm/gup: disallow follow_page(FOLL_PIN)
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
 <20220329160440.193848-14-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220329160440.193848-14-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 18:04, David Hildenbrand wrote:
> We want to change the way we handle R/O pins on anonymous pages that
> might be shared: if we detect a possibly shared anonymous page --
> mapped R/O and not !PageAnonExclusive() -- we want to trigger unsharing
> via a page fault, resulting in an exclusive anonymous page that can be
> pinned reliably without getting replaced via COW on the next write
> fault.
> 
> However, the required page fault will be problematic for follow_page():
> in contrast to ordinary GUP, follow_page() doesn't trigger faults
> internally. So we would have to end up failing a R/O pin via
> follow_page(), although there is something mapped R/O into the page
> table, which might be rather surprising.
> 
> We don't seem to have follow_page(FOLL_PIN) users, and it's a purely
> internal MM function. Let's just make our life easier and the semantics of
> follow_page() clearer by just disallowing FOLL_PIN for follow_page()
> completely.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
