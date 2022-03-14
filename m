Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7984D7D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbiCNIKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237611AbiCNIKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:10:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A9D38A1;
        Mon, 14 Mar 2022 01:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647245344; x=1678781344;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=9Z61s4WrZYBzdlpRR1dd1tEn6cmlD3NbOa2aklTM3Zk=;
  b=Z/nyyWQJ4Q6tn5rN7abW/7gLy9E0mmPXAfcIkJIxAeDmfvOf6nxpYomT
   RFfA8kZaRbidL2/DVs4uFOPJZXjldStVBIKkWhnMA1K9HO9q3Xna99Z/o
   2PjiBBRJU6cVLFedILzDzkMyAUHKWBIlwYG05N7bJ6MH/IQDmIIfkZ2qJ
   O5Z6cFVw1UfxGlmS4HRBVhwmMsFgNkqOufnwKHdHfj65UeFQW7aarodtA
   gNbWGiby40nmfnyGtRX7YXleZVztYY9RCkaTj2Tht3ntbGD7JUme7MlaU
   al0j0rRnHpcbdAzrJf7H2racrhjAgREdz93S9mJBaz2Ikf40f/RAvU3Wx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="342390612"
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="342390612"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 01:09:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="556298140"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 01:08:55 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?utf-8?Q?Hol?= =?utf-8?Q?ger_Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v9 05/14] mm: multi-gen LRU: groundwork
References: <20220309021230.721028-1-yuzhao@google.com>
        <20220309021230.721028-6-yuzhao@google.com>
Date:   Mon, 14 Mar 2022 16:08:53 +0800
In-Reply-To: <20220309021230.721028-6-yuzhao@google.com> (Yu Zhao's message of
        "Tue, 8 Mar 2022 19:12:22 -0700")
Message-ID: <875yoh552i.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yu,

Yu Zhao <yuzhao@google.com> writes:
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 3326ee3903f3..747ab1690bcf 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -892,6 +892,16 @@ config ANON_VMA_NAME
>  	  area from being merged with adjacent virtual memory areas due to the
>  	  difference in their name.
>  
> +# the multi-gen LRU {
> +config LRU_GEN
> +	bool "Multi-Gen LRU"
> +	depends on MMU
> +	# the following options can use up the spare bits in page flags
> +	depends on !MAXSMP && (64BIT || !SPARSEMEM || SPARSEMEM_VMEMMAP)

LRU_GEN depends on !MAXSMP.  So, What is the maximum NR_CPUS supported
by LRU_GEN?

> +	help
> +	  A high performance LRU implementation for memory overcommit.
> +# }
> +
>  source "mm/damon/Kconfig"
>  
>  endmenu

Best Regards,
Huang, Ying

[snip]
