Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E8F4F2183
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiDEC5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiDEC4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:56:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A957D224514
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 19:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649124384; x=1680660384;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=0UMmqY4Wx6ejR5qQpD5MVqGgAO4U/to+JQIHPyY6qWc=;
  b=GgsEdMa/W+GnfXp4dqK85Bge6A2WZKheBtnkca5zacIwweK1EXfJhldP
   6QIFPHm9U7eN4ErR7Mn0ho+JRIFA0Dl4L4/a2yUk4bwGoY/ADReC0CjwV
   mUnAlQEl8EhjIEIpulTwe65hTn1Ux05kGezRiN6sSCJF00Spnv0rc3Q7P
   oXuBaZf/9qjDwoqxc2xBZEWoeL7YaYu3g6c0KbeR/FA15zqV80Zwidc9+
   oUX3R7jvGeF8xvQJTEBEfVo2o8ZBzffGX3V2Y2n2uXbeZ/ncTxMMbzuTc
   47BOtZQegn+nmJD8IeoNgAZB6GhEMKAWmmCsVPJhgPLELTFjW7yRAic5u
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="347073698"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="347073698"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 17:01:27 -0700
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="641413179"
Received: from sunjie1-mobl3.amr.corp.intel.com (HELO [10.209.28.63]) ([10.209.28.63])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 17:01:26 -0700
Message-ID: <5263978a-19ef-fff3-cc61-b272a833171f@intel.com>
Date:   Mon, 4 Apr 2022 17:01:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        bp@alien8.de
Cc:     aarcange@redhat.com, ak@linux.intel.com, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
References: <YjXtK4awY6utz3wE@zn.tnic>
 <20220321160245.42886-1-kirill.shutemov@linux.intel.com>
 <9f8f57fdbbf76e70471541dc42b04f8a89be4a56.camel@intel.com>
 <dd5c52ad-9c61-54c3-6654-7a30c56b1917@intel.com>
 <2fcd12bb42c7d30f0e7bd09a7f66d76122493b32.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv7.1 02/30] x86/tdx: Provide common base for SEAMCALL and
 TDCALL C wrappers
In-Reply-To: <2fcd12bb42c7d30f0e7bd09a7f66d76122493b32.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 16:35, Kai Huang wrote:
> Both error code formats defined by P-SEAMLDR and TDX module has some reserved
> bits which will never be set to 1.  I think we can just add a simple comment
> explaining that and choose a value which has 1 set for those reserved bits (even
> doesn't have to be -1). For example:
> 
> 	/*
> 	 * Use -1ULL which will never conflict with any actual error code
> 	 * returned by both the P-SEAMLDR and the TDX module to represent
> 	 * VMfailInvalid.  Both error code definitions defined by the
> 	 * P-SEAMLDR and the TDX module have some reserved bits which will
> 	 * never be set to 1.
> 	 */
> 	#define TDX_SEAMCALL_VMFAILINVALID	GENMASK_ULL(63, 0)

The vague "some reserved bits" magic works for exactly *one* error code.
 If you ever want to make it two, then you subject some some poor future
dope to a trip to TDX documentation purgatory.

All I'm asking is that this code stand on its own.  Just declare what
the *ACTUAL* reserved bits are.  Not some vague reference to "some
bits".  There are *REAL* documented bits.  Use them, please.
