Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4814B231C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348892AbiBKK3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:29:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbiBKK3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:29:54 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4618E88
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:29:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 412C921128;
        Fri, 11 Feb 2022 10:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644575391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GW7hPp8S196ICKXiVx/9snE9bFc+0wtN2XNyXb5NVwk=;
        b=x6FCekV0/pdOfIhIB0TMRFA1MHk138uXkTCmK6U2a5LW8ag27HpEf6GcKG9oF3sAL4k+Bv
        7SNhcZg+t+G14dd8k/iHjB8tFa4ZgPBZFuvG5x+cEJyYen7PbKwAdYmBWU0ORp1Re9Q63U
        t+hSL3u5UnV+CPHmBeZhz09WI4IJuxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644575391;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GW7hPp8S196ICKXiVx/9snE9bFc+0wtN2XNyXb5NVwk=;
        b=euZCpMrbeYkxcGwbG2R9UA4Z+LKEJIqMjR/Jic1ODwVeJCqhZWTWcoWMcvWCo1bTsLyqIa
        GkswS8s6WLwZfLAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07F8D13BD9;
        Fri, 11 Feb 2022 10:29:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zBwjAZ86BmKHMQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 11 Feb 2022 10:29:51 +0000
Message-ID: <fc8510c6-f39f-231b-d822-2c5ce4422a60@suse.cz>
Date:   Fri, 11 Feb 2022 11:29:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 04/13] mm/munlock: rmap call mlock_vma_page()
 munlock_vma_page()
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
 <9f9ca113-ffb9-498e-4bd6-6bfeaaa10b7@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <9f9ca113-ffb9-498e-4bd6-6bfeaaa10b7@google.com>
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

On 2/6/22 22:36, Hugh Dickins wrote:
> Add vma argument to mlock_vma_page() and munlock_vma_page(), make them
> inline functions which check (vma->vm_flags & VM_LOCKED) before calling
> mlock_page() and munlock_page() in mm/mlock.c.
> 
> Add bool compound to mlock_vma_page() and munlock_vma_page(): this is
> because we have understandable difficulty in accounting pte maps of THPs,
> and if passed a PageHead page, mlock_page() and munlock_page() cannot
> tell whether it's a pmd map to be counted or a pte map to be ignored.
> 
> Add vma arg to page_add_file_rmap() and page_remove_rmap(), like the
> others, and use that to call mlock_vma_page() at the end of the page
> adds, and munlock_vma_page() at the end of page_remove_rmap() (end or
> beginning? unimportant, but end was easier for assertions in testing).
> 
> No page lock is required (although almost all adds happen to hold it):
> delete the "Serialize with page migration" BUG_ON(!PageLocked(page))s.
> Certainly page lock did serialize with page migration, but I'm having
> difficulty explaining why that was ever important.
> 
> Mlock accounting on THPs has been hard to define, differed between anon
> and file, involved PageDoubleMap in some places and not others, required
> clear_page_mlock() at some points.  Keep it simple now: just count the
> pmds and ignore the ptes, there is no reason for ptes to undo pmd mlocks.
> 
> page_add_new_anon_rmap() callers unchanged: they have long been calling
> lru_cache_add_inactive_or_unevictable(), which does its own VM_LOCKED
> handling (it also checks for not VM_SPECIAL: I think that's overcautious,
> and inconsistent with other checks, that mmap_region() already prevents
> VM_LOCKED on VM_SPECIAL; but haven't quite convinced myself to change it).
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Yeah, much better when most of the sites are encapsulated in rmap operations
like this.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
