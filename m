Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356334CA632
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242322AbiCBNnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbiCBNnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:43:18 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A38765C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646228554; x=1677764554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o+O6+leRrBJdBNbkMxO92SxNsanBGz/3EJ5c7tWB47w=;
  b=PRoLup4XjRD9iBoOWiWA7/kmGP5QcoD9bmVGcNoTm+ReTS4mIbFQ2XTY
   W3kfFcx9RQfc2STBgS7K/h9mgl+2FduVp2ONPxY7Z2k6RLMZ9i8eEFrB3
   BDt97D+WWpt575X5XLBbrO88P+nxtJtllZZxQlWBNVP4v1k4bye84/xtG
   NHAgkK7lyxuXbiAu9IiqF05hl7vLQMUYiRlI2Fte62b2N0PZhMJWJHJ4m
   x/TP0N1iridqByg4E95y1+m/d4DS/+eKJJB0xGuGNfXPWRFRDihTW9uaA
   wMapkvNdg+wTX+UYtmuyhe0/jGMoj8w3RLzoUZu7UnQclFPYyXNniqlG7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="314119716"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="314119716"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 05:42:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="511007530"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 02 Mar 2022 05:42:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 7D791183; Wed,  2 Mar 2022 15:42:45 +0200 (EET)
Date:   Wed, 2 Mar 2022 16:42:45 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 11/30] x86/tdx: Handle in-kernel MMIO
Message-ID: <20220302134245.paq2dcsdql77rz4y@black.fi.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-12-kirill.shutemov@linux.intel.com>
 <af7df79f-02b8-3025-c9a3-929b7bdd33e0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af7df79f-02b8-3025-c9a3-929b7bdd33e0@intel.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 12:11:54PM -0800, Dave Hansen wrote:
> 
> I found a few things lacking in that description.  How's that for a rewrite?

Looks great, thanks.
> > == Patching TDX drivers ==
> > 
> > Rather than touching the entire kernel, it might also be possible to
> > just go after drivers that use MMIO in TDX guests.  Right now, that's
> > limited only to virtio and some x86-specific drivers.
> > 
> > All virtio MMIO appears to be done through a single function, which
> > makes virtio eminently easy to patch. This will be implemented in the
> > future, removing the bulk of MMIO #VEs.
> 
> Given what is written here, this sounds like a great solution especially
> compared to all the instruction decoding nasiness.  What's wrong with it?

This will not cover non-virtio users. So #VE-based MMIO will remain as
fallback mechanism.

> > +	switch (mmio) {
> > +	case MMIO_WRITE:
> > +		memcpy(&val, reg, size);
> > +		return mmio_write(size, ve->gpa, val);
> > +	case MMIO_WRITE_IMM:
> > +		val = insn.immediate.value;
> > +		return mmio_write(size, ve->gpa, val);
> > +	case MMIO_READ:
> > +	case MMIO_READ_ZERO_EXTEND:
> > +	case MMIO_READ_SIGN_EXTEND:
> > +		break;
> > +	case MMIO_MOVS:
> > +	case MMIO_DECODE_FAILED:
> > +		return false;
> > +	default:
> > +		BUG();
> > +	}
> 
> Given the huge description above, it's borderline criminal to not
> discuss what could led to this BUG().

This bug actually covers "Unknown insn_decode_mmio() decode value" case.
I will add the comment.


> It could literally be some minor tweak in the compiler that changed a
> non-io.h-using MMIO access to get converted over to a instruction that
> can't be decoded.
> 
> Could we spend a few lines of comments to help out the future poor sod
> that sees "kernel bug at foo.c:1234"?  Maybe:
> 
> 	/*
> 	 * MMIO was accessed with an instruction that could not
> 	 * be decoded.  It was likely not using io.h helpers or
> 	 * accessed MMIO accidentally.
> 	 */

Thanks, I will use the comment for MMIO_DECODE_FAILED handling.

-- 
 Kirill A. Shutemov
