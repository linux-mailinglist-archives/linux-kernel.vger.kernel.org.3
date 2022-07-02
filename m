Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2404564003
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 13:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiGBL6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 07:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbiGBL6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 07:58:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87D613F0D;
        Sat,  2 Jul 2022 04:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656763079; x=1688299079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=re3LFd38nLBlu3MQiWD1Ny6wrWGEckMsB9soYe/z/cY=;
  b=cTjwzHOQVxjy8OoznS3kmtCaQEwEMI8xKkmcjN43xbg4Zb+YdQiLOcCZ
   JjN3mK18CCJuz/fHzyffyVcN9aLbeYoL0zkoI5DggQJH6WqDD7EjV3NcR
   fitx1/mon4tS/913OkkrseBAiVrR4tBBdzppp2BD/DxDZAlQQ0tdkNskZ
   Mp8pbyoveJx4vK41Hyh5/d3aB0ds0lxno0f2BHzyL16efBBryksAOuKUl
   EcPPbBEW+GxSlnSBkg+LC4iWMT8Cr0eVCSqC45RyqmJsWWGGwYzCLwLKf
   mj85zdo5lWdS1YJUsN58w07cApc3P79cI6XFfYmpmIEmgXhIP7MbqCu8K
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="346808172"
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="346808172"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 04:57:59 -0700
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="541992929"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 04:57:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o7bl1-0013ah-1H;
        Sat, 02 Jul 2022 14:57:51 +0300
Date:   Sat, 2 Jul 2022 14:57:51 +0300
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
Subject: Re: [PATCH 3/8] lib/bitmap: change type of bitmap_weight to unsigned
 int
Message-ID: <YsAyv66xOYoNSoga@smile.fi.intel.com>
References: <20220701125430.2907638-1-yury.norov@gmail.com>
 <20220701125430.2907638-4-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701125430.2907638-4-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 05:54:25AM -0700, Yury Norov wrote:
> bitmap_weight() doesn't return negative values, so change it's type
> to unsigned int.

Patch (the code) suggests something else.

> It may help compiler to generate better code and
> catch bugs.

...

> -int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
> +unsigned long __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);

-- 
With Best Regards,
Andy Shevchenko


