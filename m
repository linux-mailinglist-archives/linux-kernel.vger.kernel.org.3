Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D36B564855
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 17:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiGCPVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 11:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiGCPVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 11:21:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F408F;
        Sun,  3 Jul 2022 08:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656861662; x=1688397662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jXW12Ga9G65nqsGYdHBdlWQ5IJhoQ1DN2e8R+iyO4VE=;
  b=hk/DyHciJM43sj1vk/J/swjmBjYo7E5A2DOKeMwRRGO2NiDWKNbzGitB
   TpMXFuqxNrpgWQmhbplFPN1uxQgRQbTZHTzzvek/3JZe2PiWRbfhLVmB1
   FsxA5BVa0+gwSLkVMZ1EZRWyQJ8Y8zUU1nLmq92EwAHqqkTBOX1EzhXXw
   X6h5Os2mURtjstKAmNEdYw8114nF0ve2LJaceQ4jr8isKGXb4lN3QDGoD
   N1Z+11C4X5jEjybf4fMq27Z4CJWRx8u3L3RTZXnUJp/CjuJIpVBcd4M4Y
   ngZ2VJR3Yz23HV5f+Y/4I6+/iwfsaM/Z2Vi4d3KVfCQBkVLLI4Z4GhYfX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="344639160"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="344639160"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 08:21:01 -0700
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="542233739"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 08:20:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o81P4-0014Px-0j;
        Sun, 03 Jul 2022 18:20:54 +0300
Date:   Sun, 3 Jul 2022 18:20:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Yury Norov <yury.norov@gmail.com>, agk@redhat.com,
        snitzer@kernel.org, dm-devel@redhat.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, almaz.alexandrovich@paragon-software.com,
        linux@rasmusvillemoes.dk, linux-s390@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/4] bitmap: Introduce bitmap_size()
Message-ID: <YsGz1Xp0RDM5ZhVY@smile.fi.intel.com>
References: <cover.1656785856.git.christophe.jaillet@wanadoo.fr>
 <98f5d3d855a9c687ccc035edf62016b02a6876b7.1656785856.git.christophe.jaillet@wanadoo.fr>
 <YsC0GpltMVaCPhkJ@yury-laptop>
 <4dc5d50a-2291-1d3a-efac-3f6378a15d69@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4dc5d50a-2291-1d3a-efac-3f6378a15d69@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2022 at 08:50:19AM +0200, Christophe JAILLET wrote:
> Le 02/07/2022 à 23:09, Yury Norov a écrit :
> > On Sat, Jul 02, 2022 at 08:29:36PM +0200, Christophe JAILLET wrote:

...

> > This should be dropped, for sure, and kmalloc() at line 128 should be
> > replaced with bitmap_alloc().
> 
> This kmalloc() is for a structure and a flexible array.
> 
> You mean re-arranging the code to allocate the structure alone at first,
> then the bitmap?

It's one way, but it will increase fragmentation of memory. The other one
as it seems to me is to name a new API properly, i.e. bitmap_size_to_bytes().

In such case you won't need renames to begin with. And then would be able
to convert driver-by-driver in cases of duplicated code.

I think that's what confused Yuri and I kinda agree that bitmap_size() should
return bits, and not bytes. Also argument for pure bitmap_size() would be
bitmap itself, but we have no way to detect the length of bitmap because we
are using POD and not a specific data structure for it.

-- 
With Best Regards,
Andy Shevchenko


