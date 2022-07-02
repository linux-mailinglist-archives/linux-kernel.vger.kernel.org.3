Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331F356400C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 14:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiGBMJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 08:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiGBMJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 08:09:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364FA13F59;
        Sat,  2 Jul 2022 05:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656763789; x=1688299789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yq/niB36C+kmBjxAX8/BvYD9grF4zUI1khCx8AbNpZA=;
  b=h7e4HeYpDBbblWwfweG72wKt+VBnCX74sR/HUv56VMf6jnL60RzWZJfZ
   JxHkoWBtQyDsDoYI7UGnnpASwsLsYig7zHmg1/qoBLlg/NWtawIiyD0by
   fxK4kjh7+RNP0Fid8FZUiamcCX6G8G3ZdAMcvnHL+gNcg3xFbnG41QULZ
   V8TvWxa6l/Pi8IdTvHKPoz1Ask/BShKT+hhqBTFvxm21iJRPM5buPlwUC
   Gkhm06SGeGSyeMVJmfzdHBSM7oXnzEmmsh/eT2OcS32GeqwLDfF0/0tUp
   qDHrXhEYrNrJXMGfhWyzZvlXaK8oDyqmZWaX7mS8+uebZnSuYxtviN7JG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="271596294"
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="271596294"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 05:09:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="591991334"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 05:09:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o7bwT-0013bJ-09;
        Sat, 02 Jul 2022 15:09:41 +0300
Date:   Sat, 2 Jul 2022 15:09:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 7/8] mm: split include/linux/gfp.h
Message-ID: <YsA1hHc3GgTIsglN@smile.fi.intel.com>
References: <20220701125430.2907638-1-yury.norov@gmail.com>
 <20220701125430.2907638-8-yury.norov@gmail.com>
 <YsA0k5G1B1kiQdXY@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsA0k5G1B1kiQdXY@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2022 at 03:05:39PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 01, 2022 at 05:54:29AM -0700, Yury Norov wrote:
> > gfp.h belongs to many include paths, and it causes circular dependencies
> > when, for example, trying to keep cpumask one-line wrappers in headers.
> > 
> > In many cases, sources need only gfp flags. This patch splits gfp.h by
> > moving flags to include/linux/gfp_flags.h. It helps to move trivial 
> > wrappers from c-file to header in the following patch for cpumask.
> 
> Wondering if you checked Ingo's gigantic series [1] for something similar.
> Maybe you may utilize his work if there is anything like this.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/log/?h=sched/headers

https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?h=sched/headers&id=56a20d45417dc517d91626e5ef9f5492a5e901aa
and a few more patches on top

-- 
With Best Regards,
Andy Shevchenko


