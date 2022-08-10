Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C737B58E43E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 02:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiHJAyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 20:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHJAyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 20:54:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68577E802
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 17:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660092842; x=1691628842;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=nItkLIlxJEYz2NOoOOtaYjhZi5bSbXZOnKdSyUbLTIA=;
  b=Dqc5opApna+ziCix7zfxEA1NyNP6S8gXcSUHHAkz3+xvRpCTpEbDbBEZ
   JUZPXND66qLYMRzA71NJm4nML5aeFMgBRE8h48Cg4u5z7VJWSUtKiMzy/
   dPey/4Y1TCdYXIG2AhINBYL9lxhfEjTq05D49J8rnrJtlipkjrG5seBPD
   I6z/QuW3txVA41jdxRxdShPf++B/pM3Fh8givQBzNKryQW29DJfInSjD7
   CVDENtONZBawN32PIDcNhx2jg5WjX2n8zXe7uCMEi+1HaxxGnMrTUvNZm
   SsdO8gim6f9ma38T+TxNAnb1Bwax8+ZXDLMx6PBxjDf3vWTtgkXbxQffC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="291754526"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="291754526"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 17:54:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="581024195"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 17:53:58 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/2] mm: Remember young/dirty bit for page migrations
References: <20220804203952.53665-1-peterx@redhat.com>
        <20220804203952.53665-3-peterx@redhat.com>
        <877d3hhksz.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <YvKglA2LQkYeznZ9@xz-m1.local>
Date:   Wed, 10 Aug 2022 08:53:49 +0800
In-Reply-To: <YvKglA2LQkYeznZ9@xz-m1.local> (Peter Xu's message of "Tue, 9 Aug
        2022 13:59:48 -0400")
Message-ID: <87wnbggbqa.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> On Tue, Aug 09, 2022 at 04:40:12PM +0800, Huang, Ying wrote:
[snip]
>
>> I don't find pte_dirty() is synced to PageDirty() as in
>> try_to_migrate_one().  Is it a issue in the original code?
>
> I think it has?  There is:
>
> 		/* Set the dirty flag on the folio now the pte is gone. */
> 		if (pte_dirty(pteval))
> 			folio_mark_dirty(folio);
>

Sorry, my original words are confusing.  Yes, there's dirty bit syncing
in try_to_migrate_one().  But I don't find that in migrate_device.c

 $ grep dirty mm/migrate_device.c
				if (pte_soft_dirty(pte))
					swp_pte = pte_swp_mksoft_dirty(swp_pte);
				if (pte_swp_soft_dirty(pte))
					swp_pte = pte_swp_mksoft_dirty(swp_pte);
			entry = pte_mkwrite(pte_mkdirty(entry));

I guess that migrate_device.c is used to migrate between CPU visible
page to CPU un-visible page (device visible), so the rule is different?

Best Regards,
Huang, Ying
