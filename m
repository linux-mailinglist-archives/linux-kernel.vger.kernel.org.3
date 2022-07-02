Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5104A564009
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 14:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiGBMFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 08:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiGBMFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 08:05:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE1613E9C;
        Sat,  2 Jul 2022 05:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656763548; x=1688299548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1X9AhfDF/UQuIagUhUV1PLkN0an++X08KVSCFikKIto=;
  b=CbNrDOLAw+NA+C1iRbwuoB6O1SR8axvmJtHVLrNNhbdbg1ZH0f42cjr9
   NicEzGRinCUr8KAubhKjoy4UBN7K1+S2TXVeF3pfAwlRY+ntFlVxaHeM/
   4TNa6FZg6WIwTFoVgW01H4bXL3ZStk/LiqT/SUUbcR+EUX/aUd7bED1yC
   MBIFzGvQbCIW/qK4rkSjEsb18FEcfJqnX84kpLAdWkP4t9Py1oYcXpscQ
   svpOiMeTDL8OhCq7FAv3NxrTBr+fqMbfWIH/8tQooWyBYNZ1OomiDSeVf
   e4f/tVhNGxbVIb+KZquStc0PgxFoM5xTWvpSA5y5zTVJEYf8Paq6zs9fh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="280381326"
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="280381326"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 05:05:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="596550381"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 05:05:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o7bsZ-0013b7-1H;
        Sat, 02 Jul 2022 15:05:39 +0300
Date:   Sat, 2 Jul 2022 15:05:39 +0300
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
Message-ID: <YsA0k5G1B1kiQdXY@smile.fi.intel.com>
References: <20220701125430.2907638-1-yury.norov@gmail.com>
 <20220701125430.2907638-8-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701125430.2907638-8-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 05:54:29AM -0700, Yury Norov wrote:
> gfp.h belongs to many include paths, and it causes circular dependencies
> when, for example, trying to keep cpumask one-line wrappers in headers.
> 
> In many cases, sources need only gfp flags. This patch splits gfp.h by
> moving flags to include/linux/gfp_flags.h. It helps to move trivial 
> wrappers from c-file to header in the following patch for cpumask.

Wondering if you checked Ingo's gigantic series [1] for something similar.
Maybe you may utilize his work if there is anything like this.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/log/?h=sched/headers

-- 
With Best Regards,
Andy Shevchenko


