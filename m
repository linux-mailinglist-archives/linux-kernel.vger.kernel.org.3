Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328AE535482
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244223AbiEZUg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242070AbiEZUgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:36:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C758654C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653597383; x=1685133383;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cUnZbG4WwDwCrkQ+YIPEfPdw9LIvwmfdzfFi2tbqaR0=;
  b=JK0PDCnDogNFPStkol/lVNizf4GKvj1smvlieOqZ2thAJmcke+V7Ef7a
   uLijLp0EWT6Bk07QP6GTZO6U9zdN/3gQ3B0fxpT8pYMdklDXghp9m98Bc
   CEuL+jvLRji4UXU9MM6YlJMfZPtsSa11QkeWnFwoSvEzjatLhroE3Rfv9
   0YjTfeMyDlCFs7psTaTWK4d7pTIWxzAHSCPjwuhsxJ2E8gEu/PkLzrlYx
   JjL2zTCkGTwR5Huq55qwKUBoCmLt46ShwSQE9BVphc122/uEi2VPK1mKe
   +dWJfqwxkWc8tg/NqTcjJU+ID7LA3jg/HRKchgeSUgoTvNC1EbXJ3kTnS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274386529"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="274386529"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 13:36:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="631120532"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 26 May 2022 13:36:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 0B945109; Thu, 26 May 2022 23:36:19 +0300 (EEST)
Date:   Thu, 26 May 2022 23:36:19 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv3 3/3] x86/tdx: Handle load_unaligned_zeropad()
 page-cross to a shared page
Message-ID: <20220526203619.gpyyl67ygk622e5g@black.fi.intel.com>
References: <20220524221012.62332-1-kirill.shutemov@linux.intel.com>
 <20220524221012.62332-4-kirill.shutemov@linux.intel.com>
 <6350b927-4b3f-6f43-aa62-f8db19fa8d5b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6350b927-4b3f-6f43-aa62-f8db19fa8d5b@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 09:20:56AM -0700, Dave Hansen wrote:
> On 5/24/22 15:10, Kirill A. Shutemov wrote:
> > +	/*
> > +	 * MMIO accesses suppose to be naturally aligned and therefore never
> > +	 * cross a page boundary. Seeing unaligned accesses indicates a bug or
> > +	 * load_unaligned_zeropad() that steps into unmapped shared page.
> 
> Wait a sec though...
> 
> We've been talking all along about how MMIO accesses are in some cases
> just plain old compiler-generated memory accesses.  It's *probably* bad
> code that does this, but it's not necessarily a bug.

Compiler-generated memory accesses tend to be aligned too. You need to do
something make them unalinged, like __packed or pointer trickery.

> It's kinda like the split lock detection patches.  Those definitely
> found some stupid stuff, but it wasn't anything that I would have called
> an outright bug.  Plus, in those cases, folks had explicitly opted in to
> more crashes on stupid stuff.
> 
> That stupid stuff _might_ be rare enough that it's still OK to just punt
> on it and not emulate the instruction (aka. crash).  Or, to say that TDX
> guests are opting in to being more fragile, just like with split lock
> detection.

I think it is reasonable to expect that TDX user value its data security
higher than uptime. 

And I'm not sure that compare unaligned MMIO access to split-lock is fair.
Split-lock is performance hit, but semantics is defined. In unalgined MMIO
case, I think the behaviour is not defined: it is not clear what memory
reqested should be issued on the memory bus in case of byte-algined 4-byte
access. It can make a difference on device side.

> But, either of those would call for a very different comment.

Fair enough.

-- 
 Kirill A. Shutemov
