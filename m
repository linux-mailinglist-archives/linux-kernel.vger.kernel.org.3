Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9E2519C8A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347881AbiEDKLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbiEDKLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:11:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A987F24967;
        Wed,  4 May 2022 03:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651658853; x=1683194853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9twPMGUhGLkTOQzFXdvf7xUT5W9ZWvaoGTeC5Py9svk=;
  b=ScROUhuouH6wXM3AX0Wcuu3T2SJwyk2wUiWKMygVNxWQUOPrpVmc4A+E
   KCk7ZiEQXHcqyXRP8J+4gn0YhY7puHO9WV4TJMc8tAQDwdhtJyPRCjbR3
   MxBk7kuV++14ydyc85jHYUq/K8S1b3Z0a/cufFejtxyDeT1oGsIKMZUyo
   mTBbGmZOrkuBpDtk8v0SzkPabT7K85B7y3SyeUahB/oSHLIdBmNZEPicW
   XuBHFH7oVAG5Km51d4vTJ99Jhz7vbu454Jp0YlRkLb2BacqsZLtfkjBGf
   R8NSsIVmYDsFvNYaauaPUGKErNf6A0whqkjPMO4uINTd1pHsNPkSvcYwk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="255185928"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="255185928"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 03:07:33 -0700
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="568039833"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 03:07:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nmBuo-00Bq4L-Ux;
        Wed, 04 May 2022 13:07:26 +0300
Date:   Wed, 4 May 2022 13:07:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Stafford Horne <shorne@gmail.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <msnitzer@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH v2] hex2bin: make the function hex_to_bin constant-time
Message-ID: <YnJQXr3igEMTqY3+@smile.fi.intel.com>
References: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com>
 <alpine.LRH.2.02.2204250723120.26714@file01.intranet.prod.int.rdu2.redhat.com>
 <YnI7hE4cIfjsdKSF@antec>
 <YnJI4Ru0AlUgrr9C@zx2c4.com>
 <YnJOCbLtdATzC+jn@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnJOCbLtdATzC+jn@zx2c4.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 11:57:29AM +0200, Jason A. Donenfeld wrote:
> On Wed, May 04, 2022 at 11:42:27AM +0200, Jason A. Donenfeld wrote:
> > So more likely is that this patch just helps unmask a real issue
> > elsewhere -- linker, compiler, or register restoration after preemption.
> > I don't think there's anything to do with regards to the patch of this
> > thread, as it's clearly fine. 
> 
> The problem even goes away if I just add a nop...

Alignment? Compiler bug? HW issue?

> diff --git a/lib/hexdump.c b/lib/hexdump.c
> index 06833d404398..ace74f9b3d5a 100644
> --- a/lib/hexdump.c
> +++ b/lib/hexdump.c
> @@ -46,6 +46,7 @@ EXPORT_SYMBOL(hex_asc_upper);
>  int hex_to_bin(unsigned char ch)
>  {
>  	unsigned char cu = ch & 0xdf;
> +	__asm__("l.nop 0");
>  	return -1 +
>  		((ch - '0' +  1) & (unsigned)((ch - '9' - 1) & ('0' - 1 - ch)) >> 8) +
>  		((cu - 'A' + 11) & (unsigned)((cu - 'F' - 1) & ('A' - 1 - cu)) >> 8);
> 

-- 
With Best Regards,
Andy Shevchenko


