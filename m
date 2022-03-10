Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD3A4D4D43
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbiCJPRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiCJPRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:17:42 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06050DFEB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646925402; x=1678461402;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=newON6Td/5uryxsFhwVOGc46gIaVqhB7PFlNeP0VW6Y=;
  b=gYdJAEioB5H2LRSR+H0v+UtAVMXqzmRtnA1cFldFkZKp39wONSBxe4ME
   VQabVbBNId3pnpGtGXf9rDICVpA9axX9Sl/KmLWJUgeJpLVfNURCE90Gm
   kYqUtJhHP0zj4qAXco0EY0B4FjqHwjuPnfAEcb1q4V8iEEae0YH9DNjNP
   cTHOL6u0t3qahAJPKtuOxM+UAAFKL91eky9iLS8V+DsjRc6QSO8ylnpMQ
   jULy4KlViEdPkNFSEYHGUupArkXpvIsxWtsi6mpdU8V0LlHgM3j4OPEpE
   Qm4a81sVvrczJjHT8ekNVb4Iew5LzoEKMCTbyqNDpJdj+cD//2RxvdO05
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="252840303"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="252840303"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 07:16:34 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="688685867"
Received: from efrantz-mobl1.amr.corp.intel.com (HELO [10.212.252.101]) ([10.212.252.101])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 07:16:34 -0800
Message-ID: <81b6f618-05bc-f7d0-5461-4c3f0ca42d3f@intel.com>
Date:   Thu, 10 Mar 2022 07:16:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, x86@kernel.org,
        kirill.shutemov@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        oleg@redhat.com, ananth.narayan@amd.com
References: <20220310111545.10852-1-bharata@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
In-Reply-To: <20220310111545.10852-1-bharata@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/22 03:15, Bharata B Rao wrote:>
> This patchset builds on that prctl() extension and adds support
> for AMD UAI. AMD implementation is kept separate as equivalent
> Intel LAM implementation is likely to be different due to different
> bit positions and tag width.

Please don't keep the implementations separate.

We'll have one x86 implementation of address bit masking.  Both the
Intel and AMD implementations will feed into a shared implementation.
Something _like_ the cc_set_mask() interface where both implementations
do their detection and then call into common code to say how many bits
are being ignored.

A good litmus test for this is how many vendor-specific checks there are
in common code.  If there are a lot of them, it's not a good sign for
the design.

I'd also highly suggest going over Kirill's patch set in detail.  There
are things like this:

> https://lore.kernel.org/linux-mm/20210205151631.43511-10-kirill.shutemov@linux.intel.com/

which seem pretty sane to me but which are (I think) missing in this set.

I don't know if we can get there but, in an ideal world, this would be
series with, say 7 patches.  Patches 1-5 are generic enabling.  Patch 6
is tiny and does detection and enabling for UAI.  Patch 7 does the same
for LAM.  All the patches in the series are acked from LAM and UAI folks.
