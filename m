Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491C14A58F7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 10:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbiBAJJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 04:09:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:17760 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230333AbiBAJJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 04:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643706547; x=1675242547;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nhJLTuyBB3KiQVqGcKTS+5p6NB5lOpznI/LO6Fl/2Hs=;
  b=IBF0iwAHaAzFYIlaOUrWF+5QPpjO6WhZ3r0/9GIi85yO1E6Ycwqk6qzx
   x3EwHIWBqtF1LQRuT/fChd1A3IwVn/8UHlrv7UdoU15Dzp4+Wyr5ftPeh
   MchwLqPUvqrGfOOgglD0L0fmCagqphegaT03IrFm3JAixmE4bRwFral//
   FQRt9SVh+kkseo/1/YlRMK4r+5gKFQ9jpyBxH3eQdPXD4yfnxdgCCWabf
   w3g3OPjHQ8Kc9+bzs20m6II0uZ+C8/p0StRRr3bNhSoP7ifwH8vpTVm/9
   CBFP6DwgCtxIslIkhob8cg/zIEa9WwoIsNFPXol2nx6nPtQ188Gr8rVX9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="227621055"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="227621055"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 01:09:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="698339217"
Received: from bconlan-mobl1.ger.corp.intel.com (HELO [10.213.212.46]) ([10.213.212.46])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 01:09:01 -0800
Message-ID: <c2e873de-9031-ea80-acd6-45ef53000635@linux.intel.com>
Date:   Tue, 1 Feb 2022 09:08:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Intel-gfx] linux-next: build failure after merge of the
 drm-intel-fixes tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220201092735.1d5b38d3@canb.auug.org.au>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20220201092735.1d5b38d3@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31/01/2022 22:27, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the drm-intel-fixes tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/gpu/drm/i915/i915_vma.c: In function 'i915_vma_bind':
> drivers/gpu/drm/i915/i915_vma.c:451:25: error: 'ret' undeclared (first use in this function); did you mean 'net'?
>    451 |                         ret = i915_gem_object_wait_moving_fence(vma->obj, true);
>        |                         ^~~
>        |                         net
> 
> Caused by commit
> 
>    2e872d87cbf2 ("drm/i915: delete shadow "ret" variable")
> 
> I have reverted that commit for today.

Dropping was the right call - I have since removed it from 
drm-intel-fixes as well.

Root cause was a bad Fixes: tag in that patch which caused it to be 
wrongly cherry-picked and I did not build test before pushing.

We can't edit the wrong Fixes: tag now, so for future reference only, 
2e872d87cbf2 ("drm/i915: delete shadow "ret" variable") should not be 
backported to 5.17 by anyone.

Wrong tag:
Fixes: f6c466b84cfa ("drm/i915: Add support for moving fence waiting")

Correct tag should have been:
Fixes: 2f6b90da9192 ("drm/i915: Use vma resources for async unbinding")

Regards,

Tvrtko
