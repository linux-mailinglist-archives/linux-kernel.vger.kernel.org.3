Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35FD4DD9AD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbiCRMWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbiCRMWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:22:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6841FAA18
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 05:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647606084; x=1679142084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vVgvop8ogGrUADiEvIVvjtGIkCVphzfkaitXclPagy8=;
  b=MlJx7bPMyMaxQgqXp8QCwjVHGSglBcsC4ZQskwZa/gdqGnTegrz/bpFP
   uXs/1Ht74hlISX74MvuvzncQwX7bd749qu7Mu8vk96OsaWiAAWkIGQGte
   28HUsQOO5mkjl/moXDSgbVem2mwL7UDKYzSaeY1R6fBYpSwMBNazG55Pt
   QXeOuLC091iaIIvUGggKniP5DL3UZQD3ciTvnVoT1DkYmOaxIaxrsQ82N
   Zds2tQoJ0h4wYgJnWXesySIAV8Xl+kt8288Eg2ogMK6K9nybjR4sovZJ3
   Dc68nJgEyn4wdX58SLcAkLyZE1mQA5ZSsXpXzko0Z3mTwVYIE2rAPyhaU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="256851454"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="256851454"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 05:21:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="715457854"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 05:21:23 -0700
Date:   Fri, 18 Mar 2022 05:21:18 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        Pavel Machek <pavel@denx.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v2 1/2] x86/split_lock: Make life miserable for split
 lockers
Message-ID: <YjR5Pl2uAUPbDZzT@otcwcpicx3.sc.intel.com>
References: <20220217012721.9694-1-tony.luck@intel.com>
 <20220310204854.31752-1-tony.luck@intel.com>
 <20220310204854.31752-2-tony.luck@intel.com>
 <20220317111305.GB2237@amd>
 <87fsngcv25.ffs@tglx>
 <e2baf93885684512b4c7dc5363620a6f@AcuMS.aculab.com>
 <8ceaa1e7624b46feafb15da0935e161c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ceaa1e7624b46feafb15da0935e161c@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 03:40:16PM -0700, Luck, Tony wrote:
> > They are actually more likely to happen in the kernel
> > when code casts int[] to long[] and then uses the 'BIT' functions to
> > set/clear bits - which do locked operations.
> > Quite often then don't need the locks anyway.
> > And that cast is surprisingly common and completely broken on BE.
> 
> Default split lock mode is "kernel dies". We had to fix up a dozen or
> so places (mostly involving set_bit/clr_bit as you describe). But
> all Ice Lake. Tiger Lake and Alder Lake systems are running in
> that mode ... and we haven't heard of widespread death (or disabling
> the boot option).

Split lock is designed to report this kind of "hidden" performance issues.
After initial fix up wave, it has been sparse to find any legacy split lock
issue in the kernel.

If a new split lock issue is introduced, the developer hopefully will
capture and fix it before upstream. So others won't see it any more.

Thanks.

-Fenghua
