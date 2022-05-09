Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98377520142
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbiEIPje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238470AbiEIPjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:39:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022B53BBDF
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652110537; x=1683646537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XS/v6rosssf0DyqOwJ5B9g1oPnMSnoSeVg0C434Vg+0=;
  b=l3ZvzI1Z7j5iQbsxCEG9JBi7p2MMFWlgbcPDff/96Q6WE2yA7OBm0qgS
   ZcL1irRH98zazbNz9IaLztyKqv4RpRHycXcVig23UK5j5IbX67/KwK03U
   hMcPyDAkQRKCDMRM4WIEV8Zus4tDqrZQc8paFCWazjgw7tqRF0y3c2KS7
   gb3bW6GkHZ3G+/jRsVWbhbfKSt+yVxeDdjhyo2XJjGXccCeEdq5MXal4v
   TFQmrFrl084pcdKpn9816R7PIFpwhMauv0ZevYJMnTVxk3c5qADB/q3n8
   RPjJlvIZJsQ7uEir1EYmh6O6vQw5KrFEQJvy/Bf+N+Ymz6D+bIV9BCHeX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="332120017"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="332120017"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 08:35:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="813525451"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 09 May 2022 08:35:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id D7E0ED1; Mon,  9 May 2022 18:35:34 +0300 (EEST)
Date:   Mon, 9 May 2022 18:35:34 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Kai Huang <kai.huang@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
Message-ID: <20220509153534.i6v4xcb2g24ia2i4@black.fi.intel.com>
References: <40ccd0f0-35a1-5aa7-9e51-25ab196d79e5@linux.intel.com>
 <2ed5c9cc316950a5a47ee714715b7980f358a140.camel@intel.com>
 <ab17102c-0cb7-87d3-3494-969866d64573@linux.intel.com>
 <d53696f85ada39a91a3685c61d177c582810772e.camel@intel.com>
 <d63d2774-c44d-27da-74b6-550935a196fd@intel.com>
 <dca06ffa36abe9989f0a7abaeafc83c1a7250651.camel@intel.com>
 <20220507004236.5p5dyksftge7wwr3@black.fi.intel.com>
 <45d184273f1950320843f6696eb3071f7d354fd3.camel@intel.com>
 <20220509120927.7rg6v5pyc3f4pxsh@box.shutemov.name>
 <4506e2c2-af4b-623d-5618-48269e65c295@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4506e2c2-af4b-623d-5618-48269e65c295@intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 07:14:20AM -0700, Dave Hansen wrote:
> On 5/9/22 05:09, Kirill A. Shutemov wrote:
> > Private->Shared conversion is destructive. You have to split SEPT, flush
> > TLB. Backward conversion even more costly.
> > 
> > Rule of thumb is avoid conversion where possible. DMA API is there for
> > you.
> 
> Kirill, I understand that the DMA API is a quick fix today.  But is it
> _really_ the right long-term interface?

Yes, I think so.

> There will surely come a time when TDX I/O devices won't be using fixed
> bounce buffers.  What will the quote generation code do then?  How will
> we know to come back around and fix this up?

VirtIO will not go away with TDX I/O in picture. TDX I/O will be addition
to existing stuff, not replacement.

And we have hooks in place to accommodate this: force_dma_unencrypted()
will return false for devices capable of TDX I/O. While the rest of
devices, including VirtIO and attestation, keep using existing paths with
swiotlb.

> Does SEV or the s390 ultravisor need anything like this?

At quick glance sev-guest.c uses set_memory_decrypted()/encrypted() for
allocation and freeing shared memory. I consider it inferior to using DMA
API.

-- 
 Kirill A. Shutemov
