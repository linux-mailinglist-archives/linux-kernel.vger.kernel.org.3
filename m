Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECFE5351ED
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 18:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245207AbiEZQVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 12:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiEZQVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:21:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8127FB48B
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 09:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653582064; x=1685118064;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nHe73Yb0QyfWDajqZj2XgEOhY5Zepq7qVF2OmswxRk0=;
  b=IrG6JN2/IffynQ8rDDwSY0X249kSA/D8oxuZ5HtlUIYQYfALZ9jKh7pH
   OwP6qOgarHsOL1FL9i0I/yEEAoHdLapNbXfXsF3HTMtlvBv/psgg0ioEQ
   Fk1JhsveGuKmWtY+xsN2BRk7CUqXl73+qe2djyoh1WhkUv+BxKn7u0WMR
   +z0juXf0j/qDjYscwPN/Aod+ihiDzYMgUH4wusP0F78wLnYwAuYF4hd2y
   ASspt+IOTcZ8jFJsb45kMZyrqCc/PrvdBP0mpmMcK8J6MmbylbVD0MXCB
   4sbzZupHmH2ZgBAnmppR/Cco8A4JKqPnbgenScPOBbkbTHkHVDa607t8q
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="256273001"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="256273001"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 09:20:58 -0700
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="642953575"
Received: from tjeziers-mobl1.amr.corp.intel.com (HELO [10.251.23.34]) ([10.251.23.34])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 09:20:57 -0700
Message-ID: <6350b927-4b3f-6f43-aa62-f8db19fa8d5b@intel.com>
Date:   Thu, 26 May 2022 09:20:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv3 3/3] x86/tdx: Handle load_unaligned_zeropad() page-cross
 to a shared page
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org
References: <20220524221012.62332-1-kirill.shutemov@linux.intel.com>
 <20220524221012.62332-4-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220524221012.62332-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/22 15:10, Kirill A. Shutemov wrote:
> +	/*
> +	 * MMIO accesses suppose to be naturally aligned and therefore never
> +	 * cross a page boundary. Seeing unaligned accesses indicates a bug or
> +	 * load_unaligned_zeropad() that steps into unmapped shared page.

Wait a sec though...

We've been talking all along about how MMIO accesses are in some cases
just plain old compiler-generated memory accesses.  It's *probably* bad
code that does this, but it's not necessarily a bug.

It's kinda like the split lock detection patches.  Those definitely
found some stupid stuff, but it wasn't anything that I would have called
an outright bug.  Plus, in those cases, folks had explicitly opted in to
more crashes on stupid stuff.

That stupid stuff _might_ be rare enough that it's still OK to just punt
on it and not emulate the instruction (aka. crash).  Or, to say that TDX
guests are opting in to being more fragile, just like with split lock
detection.

But, either of those would call for a very different comment.
