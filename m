Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1F45481C5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239490AbiFMIFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239550AbiFMIEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:04:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5431E3C4;
        Mon, 13 Jun 2022 01:04:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 770591FAC3;
        Mon, 13 Jun 2022 08:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655107488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y60ZvMkZEvWsM3Un0BjgZp3hCBuh4mCFqBODWskoeZE=;
        b=akD1NQrPb8kShRnk5+EHe9Cr91LqOhi0QO71GuaEYHpEmW49+LoonALIapZr511qIZPLtq
        5K/x6DMxM+ZVP6WWM+45emQFsHMbb9xPma3VpqdrtcjOfkUSAQDyXTF1Q+r3dsdJ1rkrQb
        xo2AJdWVATN3YMr+padQdfhNAuXYTJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655107488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y60ZvMkZEvWsM3Un0BjgZp3hCBuh4mCFqBODWskoeZE=;
        b=wVCJhQJLX4rfg077cikqvO4E2WMFayaLWJVwyDa69Hq5geO6iYcXP8dsl3raNUwY8GAfMm
        Se+tuBPW96J9fFCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C19A613443;
        Mon, 13 Jun 2022 08:04:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WA+SLJ/vpmJeIAAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 13 Jun 2022 08:04:47 +0000
Date:   Mon, 13 Jun 2022 10:04:46 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 1/6] mm: hugetlb_vmemmap: delete
 hugetlb_optimize_vmemmap_enabled()
Message-ID: <Yqbvno7vM5knoh6u@localhost.localdomain>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
 <20220613063512.17540-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613063512.17540-2-songmuchun@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 02:35:07PM +0800, Muchun Song wrote:
> The name hugetlb_optimize_vmemmap_enabled() a bit confusing as it tests
> two conditions (enabled and pages in use).  Instead of coming up to
> an appropriate name, we could just delete it.  There is already a
> discussion about deleting it in thread [1].
> 
> There is only one user of hugetlb_optimize_vmemmap_enabled() outside of
> hugetlb_vmemmap, that is flush_dcache_page() in arch/arm64/mm/flush.c.
> However, it does not need to call hugetlb_optimize_vmemmap_enabled()
> in flush_dcache_page() since HugeTLB pages are always fully mapped and
> only head page will be set PG_dcache_clean meaning only head page's flag
> may need to be cleared (see commit cf5a501d985b).  So it is easy to
> remove hugetlb_optimize_vmemmap_enabled().
> 
> Link: https://lore.kernel.org/all/c77c61c8-8a5a-87e8-db89-d04d8aaab4cc@oracle.com/ [1]
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs
