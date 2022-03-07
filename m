Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAFF4CFAB3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240486AbiCGKSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240517AbiCGKBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:01:04 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A631E2559D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646646591; x=1678182591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zuM8kRheDPx8x/ZAANh8fV7Si9//wAZ0JIyjesygWcA=;
  b=hLLztc9lh4ezVr3zE5RQwkkMnX85Mgos3A/COIt4sjj4ITZ25tztUDSb
   fq2Y3TPM1AKQ5dgMbshUfJdW1YM1y3NrorbFVe129CzSuA1udkvJpRRtS
   qHSc9QRKb0YK5CkCsh+W6mN4eYE4bL2xgYhjvS17jODXkzy5b+ivRSb1E
   F5VO0UvZsi/Ivp3iJs5ZcMM7gG41/oALgfHhvppCtyCZnk0nhC9eChIA2
   47ANEhm391ZNITDzuBv/XsS937gr7w8wCzN7yYtA2QMZglEQXmkEdJzd8
   3BDdU2nhcE8RDhppBT5yLJfngYtIgQDHcXWnrctWnaMPNeQbAqqceeDAV
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="254542061"
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="254542061"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 01:49:51 -0800
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="512620311"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 01:49:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nR9zE-00Ch8F-0q;
        Mon, 07 Mar 2022 11:49:04 +0200
Date:   Mon, 7 Mar 2022 11:49:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH] list: always set pos in list_prepare_entry()
Message-ID: <YiXVD8O3qyDEOGni@smile.fi.intel.com>
References: <20220306162635.2930407-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220306162635.2930407-1-jakobkoschel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2022 at 05:26:35PM +0100, Jakob Koschel wrote:
> In order to assign the result from list_prepare_entry() to another
> variable, it should also be set when pos != NULL.
> 
> This will be useful once the list iterator is no longer used after
> the loop.

...

>  #define list_prepare_entry(pos, head, member) \
> -	((pos) ? : list_entry(head, typeof(*pos), member))
> +	((pos) ? pos : list_entry(head, typeof(*pos), member))

I'm not sure why then we have () surrounding first pos.

Am I right that the original is an equivalent to

	((pos) ? (pos) : list_entry(head, typeof(*pos), member))

?

Then what the difference is made by not using parentheses?

-- 
With Best Regards,
Andy Shevchenko


