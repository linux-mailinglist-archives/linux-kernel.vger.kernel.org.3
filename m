Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22758509418
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 02:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383373AbiDUAOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 20:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348283AbiDUAOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 20:14:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AB2192A6;
        Wed, 20 Apr 2022 17:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650499887; x=1682035887;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DO8u08CYrrpFU9VtVrhYb0LJ+ph2/wh1S84s2b8igPE=;
  b=baORlmcRtjFPhbjxeMGeyz4YkHKHJay5aSji5jRILfyHEPjKWWKYhHOb
   KQu96wFN6xFEa3/izkSzRPokXzKaz9GKYbgiC6W94v04h/UvJoXXpgnuk
   USjQiKC9inbmj4ljziDtxmAoLaSoLoqONcT2VeNDvHdqQRsmvu7pLn+aL
   LBHLdHmKYr+gePEUNH41KKNHRQ8DohYh0Py5H5fS15jgK+n8knzHlGvoo
   XO6jIPXPMt4KNkebywUKbITMEmYCV15HmzBzb8QJqdhxJKVqd23TF1aBl
   JuB0J+6QRbey24sD8v0V4wOKiOibXeV+/2Umxgsj5xmetF8qyZdUjbKuU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="350634791"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="350634791"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 17:11:27 -0700
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="555463463"
Received: from ssharm9-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.30.148])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 17:11:23 -0700
Message-ID: <420a4d689f73f9f7dc1ef71c61da75b7c9777a3f.camel@intel.com>
Subject: Re: [PATCH v3 4/4] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, isaku.yamahata@gmail.com
Date:   Thu, 21 Apr 2022 12:11:21 +1200
In-Reply-To: <e0e2e399-2cac-cf75-2a64-9d017e6d7189@linux.intel.com>
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
         <b209ee09b74394ab7aed85e0244e2191ee3d4171.camel@intel.com>
         <e0e2e399-2cac-cf75-2a64-9d017e6d7189@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-20 at 16:45 -0700, Sathyanarayanan Kuppuswamy wrote:
> If we want to support multiple GetQuote requests in parallel, then we
> need some way to uniquely identify the GetQuote requests. So that when
> we get completion notification, we can understand which request is
> completed. This part is not mentioned/discussed in ABI spec. So we want 
> to serialize the requests for now.
> 

Yes it's unfortunate that this part (whether concurrent GetQuote requests are
supported by TDX architecture) is not explicitly mentioned in GHCI spec.  I am
fine with only supporting GetQuote requests one by one.  AFAICT there's no
request to support concurrent GetQuote requests anyway.  What concerns me is
exactly how explain this.

As I said, we have GET_QUOTE_IN_FLIGHT flag now.  Theoretically, you can queue
multiple GetQuote requests, and when you receive the interrupt, you check which
buffer has GET_QUOTE_IN_FLIGHT cleared.  That buffer is the one with Quote
ready.  However I am not 100% sure whether above will always work.  Interrupt
can get lost when there are multiple Quotes ready in multiple buffer in very
short time period, etc?  Perhaps Isaku can provide more input here.

Anyway, how about explaining in this way:

"The GHCI spec doesn't clearly say whether TDX can support or how to support
multiple GetQuote requests in parallel.  Attestation request is not supposed to
be frequent and should not be in performance critical path.  Only support
GetQuote requests in serialized way for now." 


-- 
Thanks,
-Kai


