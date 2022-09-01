Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610C35A9A94
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbiIAOiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiIAOhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:37:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7147E33A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662043048; x=1693579048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ORmCa86BV+qGlurL4z2DsbOpqGhBny3TKiFZbG9VSiE=;
  b=e8xM7R8KpaWD2nK4qkUhPAu5pmObtK4PakJ5pd6GZZkhkB4vtiL56561
   pAROG139lMioSXi1j49VfKIcYKaWQ7Zuv643TvMLULg3UQ1if+Wtr0w40
   s6/McE4vSYn5oJ58NRvEATmpI+UFvhyojsF8e3DhfFdL9a9mromwCKSFN
   gOVJxrvVzOQTx/JxdIH7wZTwWs8EcIfIQGwelO4+YsTGizvC0SDPUTZnw
   A0UFrj89mKq6cZWQ1ym2ZpVO40j1Kak558VlLW3I61+XiPKxRZhUKu5yp
   cxiW2FHHecnhllabBu3HnkoWMO2R4s56I8gDkJ3qw7Km+6IvxdqSM/6Mr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="357447782"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="357447782"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 07:37:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="754842284"
Received: from vzilkov-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.53.108])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 07:37:25 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 277F610483D; Thu,  1 Sep 2022 17:37:23 +0300 (+03)
Date:   Thu, 1 Sep 2022 17:37:23 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sasha Levin <sasha.levin@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v1] mm/gup: adjust stale comment for RCU GUP-fast
Message-ID: <20220901143723.wg2wjqubcfztze7a@box.shutemov.name>
References: <20220901072119.37588-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901072119.37588-1-david@redhat.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:21:19AM +0200, David Hildenbrand wrote:
> commit 4b471e8898c3 ("mm, thp: remove infrastructure for handling splitting
> PMDs") didn't remove all details about the THP split requirements for
> RCU GUP-fast.
> 
> IPI broeadcasts on THP split are no longer required.
> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Sasha Levin <sasha.levin@oracle.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jerome Marchand <jmarchan@redhat.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
