Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DFE4B7A67
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244032AbiBOWWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:22:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242968AbiBOWWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:22:45 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B420674E5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644963755; x=1676499755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fyM9BdY2VLSsQXK310mGQhW+fXu4Axlzng/tIkJ9TZo=;
  b=fBRrW4m+rxEEkUIZnEjUeMxnPx5z3t/0SlmhKRnWg4EQqcpy/0j1IaZY
   Hvyrp/+FTt64v74yiLwtKyI7Q3xtDOBvsPYh7BWSTIHiPXFThJdINhiGP
   Mwy8WQ7eCtolD1w0CYMw9h/5TUo2DEnnhO+2HkIUtXQZ23bahBddpD9Uc
   OrUXInytCeuYkAe35vzyvVyis3xRBiuPyHQdXNvXFH1ZPhbBDA6wYn2zh
   Qi1wGuQJiYzV19pJZ9japEVnNBmsit++FtdC3x2JvpIwgj+0AQNMmKuwb
   GSiT2DSe9XPbuXxdAlEd+PWQxbEtkJ2ZPstFGfMfAB9gQB6R1pIuv54Ap
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="311207493"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="311207493"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 14:22:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="636163020"
Received: from agluck-desk3.sc.intel.com ([172.25.222.60])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 14:22:34 -0800
Date:   Tue, 15 Feb 2022 14:22:33 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jue Wang <juew@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] x86/mce: Add workaround for SKX/CLX/CPX spurious machine
 checks
Message-ID: <YgwnqTc8FGG3orcE@agluck-desk3.sc.intel.com>
References: <CAPcxDJ7nriZEJHF6dMPR7tQ+dGuueyRjw1NC+4CbjxiAT_S+ZA@mail.gmail.com>
 <20220208150945.266978-1-juew@google.com>
 <Ygwka++3eipjQzB2@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygwka++3eipjQzB2@zn.tnic>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 11:08:43PM +0100, Borislav Petkov wrote:
> > This is still better than the OS crashes on MCEs raised on an
> > irrelevant process due to 'rep movs*' accesses in a kernel context,
> > e.g., copy_page.
> 
> Wait a minute: so the MCE will happen for a piece of buffer that REP;
> MOVS *wasn't* supposed to copy.

Yes. That's why this is a "spurious" MCE. The "REP; MOVS" does
a fetch beyond the source range. If there is poison there, BOOM,
MCE :-(

> So why are we even disabling fast strings operations? Why aren't we
> simply ignoring this MCE with a warn in dmesg since, reportedly, we can
> recover safely?

This early in do_machine check we don't know whether this was from
a over enthusistic REP;MOVS fetch, or a "normal" machine check.
I don't think there is an easy way to tell the difference.

Since that "extra fetch" is part of the fast string mode, the workaround
is to disable fast strings and return. Now that will mean that fast
strings gets disabled for machine checks that had nothing to do with
this quirk. But this does provide a good-enough workaround.

> What about the MCE broadcasting synchronization? This is bypassing
> everything. There's mce_exception_count which counts stuff too.

The first check:

	if ((mcgstatus & MCG_STATUS_LMCES) 

is for "is this a local machine check"? So no broadcast sync
needed. But that needs a comment.

-Tony
