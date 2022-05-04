Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9235B519B7F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347395AbiEDJYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347339AbiEDJYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:24:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6F965F0;
        Wed,  4 May 2022 02:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651656031; x=1683192031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TLzDWArVZkel1+bI6EkTXQXMN2nFcD9kEsCR+FoZJaA=;
  b=DT7w0TubNRhsOzSXIaHYYyFVrvu+oQg574GTPdBA+INHkAo5iuwicEK6
   DB8GbJZFGIoMc1Ddm3A2mFS3sb+Rk3eh93EBKiWoLuF122i/WSH6q881V
   DRDnPdrVV3xhyh77oGMndtyN7bqOmpCzI0hd1Sv2l28aqaAlDi9p/K1D7
   0j9e3XXCztzW6SZo4/vcaGSTuuXx4ZTlv/Ce6j3ZiVn7hqHLdc3nknhfW
   kZdcYDlpq3hkbC9l1rxSJUYsgRcZEeHMkbtBSJuV6uoVG6TuWH8PFLEvV
   X68WLn7Pgd2Y76TD3A4A1tixwnHDgj/8AalFRqGkrzy7k1HJGr7danfT3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="249691738"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="249691738"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 02:20:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="620727958"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 02:20:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nmBBG-00BpBT-GT;
        Wed, 04 May 2022 12:20:22 +0300
Date:   Wed, 4 May 2022 12:20:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Stafford Horne <shorne@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <msnitzer@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Milan Broz <gmazyland@gmail.com>, Jason@zx2c4.com
Subject: Re: [PATCH v2] hex2bin: make the function hex_to_bin constant-time
Message-ID: <YnJFViBFIgYOl7/2@smile.fi.intel.com>
References: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com>
 <alpine.LRH.2.02.2204250723120.26714@file01.intranet.prod.int.rdu2.redhat.com>
 <YnI7hE4cIfjsdKSF@antec>
 <alpine.LRH.2.02.2205040453050.22937@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2205040453050.22937@file01.intranet.prod.int.rdu2.redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 04:57:35AM -0400, Mikulas Patocka wrote:
> On Wed, 4 May 2022, Stafford Horne wrote:
> > On Mon, Apr 25, 2022 at 08:07:48AM -0400, Mikulas Patocka wrote:

...

> > Just a heads up it seems this patch is causing some instability with crypto self
> > tests on OpenRISC when using a PREEMPT kernel (no SMP).
> > 
> > This was reported by Jason A. Donenfeld as it came up in wireguard testing.
> > 
> > I am trying to figure out if this is an OpenRISC PREEMPT issue or something
> > else.

> That patch is so simple that I can't imagine how could it break the 
> curve25519 test. Are you sure that you bisected it correctly?

Can you provide a test cases for hex_to_bin()?

-- 
With Best Regards,
Andy Shevchenko


