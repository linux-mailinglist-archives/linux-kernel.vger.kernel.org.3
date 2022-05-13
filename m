Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06435525910
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 02:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359779AbiEMAqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 20:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359778AbiEMAqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 20:46:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CC146B22
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 17:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652402778; x=1683938778;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=he71VrxHOVWZ4p3KeXG6k3IhuTRcXTwXyu2PekoJBN8=;
  b=ToeYCaExkQBgY7DDxEPiF4bXlNjsSCXOyrdPuMEvtYX2h1tzfFWAgFb/
   GqKZDFPPiW3JOpzGwd13OkeNnVPzAjkFzhwiO2MVA6ySCuJIR0EBC1sNb
   gB5HtqTxFG7nTbvx557TevBcJ0k3OuaPvtu3/yU2YYwL2qZ0hRDSbPHQU
   5uFqQ5KauHx66fLsQtgMg6tD3YlggEMVFzZYPUaLP3sDm4jJCV5oSUVwF
   +hsqevY4iKP8eLGSlvkPwOvIvasss5Hw9qV88gKiC981+K2110Ex1DQL9
   l9uiIj/fMwa/mSGGdgUxbldtbdr8S5qBllxW/ZdZZIAIplrw3eNafgcmC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="257720699"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="257720699"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 17:46:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="572758289"
Received: from wdwickar-mobl1.amr.corp.intel.com (HELO [10.252.130.245]) ([10.252.130.245])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 17:46:16 -0700
Message-ID: <67aef839-0757-37b1-a42d-154c0116cbf5@intel.com>
Date:   Thu, 12 May 2022 17:46:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
Content-Language: en-US
To:     "H.J. Lu" <hjl.tools@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com> <875ymav8ul.ffs@tglx>
 <55176b79-90af-4a47-dc06-9f5f2f2c123d@intel.com>
 <CAMe9rOqb6ZnAZYe4uAWDt-vmhhP=z_+uZwi5fBURqyUWxCX9Cg@mail.gmail.com>
 <87o802tjd7.ffs@tglx>
 <CAMe9rOpXOLEMcir9zMq_UJe08Y-kM+9zok6gDicqAhPySV+3NA@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAMe9rOpXOLEMcir9zMq_UJe08Y-kM+9zok6gDicqAhPySV+3NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 17:08, H.J. Lu wrote:
> I am expecting applications to ask for LAM_U48 or LAM_U57, not just
> LAM.

If AMD comes along with UAI that doesn't match LAM_U48 or LAM_U57, apps
will specifically be coded to ask for one of the three?  That seems like
an awfully rigid ABI.

That also seems like a surefire way to have non-portable users of this
feature.  It basically guarantees that userspace code will look like this:

	if (support_lam_57()) {
		sys_enable_masking(LAM_57);
		mask = LAM_57_MASK;
	} else if (support_lam_48()) {
		sys_enable_masking(LAM_48);
		mask = LAM_48_MASK;
	} else if (...)
		... others

Which is *ENTIRELY* non-portable and needs to get patched if anything
changes in the slightest.  Where, if we move that logic into the kernel,
it's something more like:

	mask = sys_enable_masking(...);
	if (bitmap_weight(&mask) < MINIMUM_BITS)
		goto whoops;

That actually works for all underlying implementations and doesn't
hard-code any assumptions about the implementation other than a basic
sanity check.

There are three choices we'd have to make for a more generic ABI that I
can think of:

ABI Question #1:

Should userspace be asking the kernel for a specific type of masking,
like a number of bits to mask or a mask itself?  If not, the enabling
syscall is dirt simple: it's "mask = sys_enable_masking()".  The kernel
picks what it wants to mask unilaterally and just tells userspace.

ABI Question #2:

Assuming that userspace is asking for a specific kind of address
masking: Should that request be made in terms of an actual mask or a
number of bits?  For instance, if userspace asks for 0xf000000000000000,
it would fit UAI or ARM TBI.  If it asks for 0x7e00000000000000, it
would match LAM_U57 behavior.

Or, does userspace ask for "8 bits", or "6 bits" or "15 bits"?

ABI Question #3:

If userspace asks for something that the kernel can't satisfy exactly,
like "8 bits" on a LAM system, is it OK for the kernel to fall back to
the next-largest mask?  For instance sys_enable_masking(bits=8), could
the kernel unilaterally return a LAM_U48 mask because LAM_U48 means
supports 15>8 bits?  Or, could this "fuzzy" behavior be an opt-in?

If I had to take a shot at this today, I think I'd opt for:

	mask = sys_enable_masking(bits=6, flags=FUZZY_NR_BITS);

although I'm not super confident about the "fuzzy" flag.  I also don't
think I'd totally hate the "blind" interface where the kernel just gets
to pick unilaterally and takes zero input from userspace.
