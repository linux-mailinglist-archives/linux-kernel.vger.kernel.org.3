Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427B64FCC71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343505AbiDLC2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344278AbiDLC1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:27:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3629140EB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 19:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649730328; x=1681266328;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/YNjGe2k1XHHXzOpRm2DQ1nukMRHEZIryQqNHeS5Lho=;
  b=eYx8U7fFHd+Cn8rSdDC1GZQnH48F7y4i6uNEw9sTrpUSgon3tX9sL87C
   Rk/skhXuRcslnnC29Tw8xyrRpynwX4k9BchMZLuydAMw7WL27c6D7aIPU
   +hmJll++opt4O1vpPn0kueCNsak4AMESu4Afc6YneUmlL2w3Th7ETZREw
   PbVlJ2n3GXP2NKmOLkdPiVL9W1TEi9/x7ArS0lJPTawEbgqSfiYSL8Ybj
   HZGXp9tV8/Q0zc0dddncRwsTZZARadfvC11a+++JbkOt/7jlPtkfMYkEN
   whUAwtX8g8i5b9ywwbBaRh79OrmNC1G452e5kARLAsrOfGuawZKMN+YJ9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261107485"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="261107485"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 19:25:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="572517663"
Received: from joliu-mobl2.ccr.corp.intel.com ([10.254.214.243])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 19:25:22 -0700
Message-ID: <e268117b314817ecd4c07ac48b0a6dcaf680ed69.camel@intel.com>
Subject: Re: [PATCH 0/4] A few cleanup and fixup patches for migration
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     mike.kravetz@oracle.com, shy828301@gmail.com, willy@infradead.org,
        ziy@nvidia.com, minchan@kernel.org, apopple@nvidia.com,
        dave.hansen@linux.intel.com, o451686892@gmail.com,
        jhubbard@nvidia.com, peterx@redhat.com, naoya.horiguchi@nec.com,
        mhocko@suse.com, riel@redhat.com, osalvador@suse.de,
        david@redhat.com, sfr@canb.auug.org.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 12 Apr 2022 10:25:17 +0800
In-Reply-To: <20220409073846.22286-1-linmiaohe@huawei.com>
References: <20220409073846.22286-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-04-09 at 15:38 +0800, Miaohe Lin wrote:
> Hi everyone,
> This series contains a few patches to remove unneeded lock page and
> PageMovable check, reduce the rcu lock duration. Also we fix potential
> pte_unmap on an not mapped pte. More details can be found in the
> respective changelogs. Thanks!

It appears that you ignored my comments for the previous version.  Can
you check it?

Best Regards,
Huang, Ying

> ---
> v1:
>   rebase [1] on mainline.
> 
> [1] https://lore.kernel.org/lkml/20220304093409.25829-2-linmiaohe@huawei.com/T/
> ---
> Miaohe Lin (4):
>   mm/migration: reduce the rcu lock duration
>   mm/migration: remove unneeded lock page and PageMovable check
>   mm/migration: return errno when isolate_huge_page failed
>   mm/migration: fix potential pte_unmap on an not mapped pte
> 
>  include/linux/migrate.h |  2 +-
>  include/linux/swapops.h |  4 ++--
>  mm/filemap.c            | 10 +++++-----
>  mm/hugetlb.c            |  2 +-
>  mm/migrate.c            | 31 +++++++++++++------------------
>  5 files changed, 22 insertions(+), 27 deletions(-)
> 


