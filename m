Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD6C54E804
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378190AbiFPQr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378212AbiFPQpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:45:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEB548E58
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655397880; x=1686933880;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AdP8Dk9pXfh/UDGbaguw7FM/+lSMWsYqrPnRmQpgFSk=;
  b=a1nL9v9rGiXLP5D2ZBNO/IbR0fZl08osMD+Z64SU+VQYVCoF0075nuaq
   x9N3Dwq4XtdTBoypTTpBzjD+nae/8758Rr8grZn3D75086lkVkFSPNccH
   G+fVLwZbDnXRCW+IMYxiE4ISYm/flJhLLFTm2c9SbWp9xckixQxxXmxmT
   NsLPEzGNXf9VJys3ytk3hUX+XSwg9RTEStMVjxAnQe5lvRf/V2ixMvAI0
   U28uYyFEocG8JcmvqXWPHewvKQ+oBuS7n8c2xmjWncxkbwFLiEr5UX9Ec
   Lc5mN3jD9eFdgiuGQfXbZtjtX1x0QRD3XTYoDMwTmi+jE4nGG8DUJad1N
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="276867872"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="276867872"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 09:44:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="762922183"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 16 Jun 2022 09:44:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id DC857109; Thu, 16 Jun 2022 19:44:40 +0300 (EEST)
Date:   Thu, 16 Jun 2022 19:44:40 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kcc@google.com" <kcc@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv3 5/8] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
Message-ID: <20220616164440.vw7sqnof6grrmnvl@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-6-kirill.shutemov@linux.intel.com>
 <c7e2f8fb44da067e7565d091edeac300977b65ed.camel@intel.com>
 <Yqr4SVMyHRTkc+LN@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqr4SVMyHRTkc+LN@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 11:30:49AM +0200, Peter Zijlstra wrote:
> On Mon, Jun 13, 2022 at 05:36:43PM +0000, Edgecombe, Rick P wrote:
> > On Fri, 2022-06-10 at 17:35 +0300, Kirill A. Shutemov wrote:
> > > +#ifdef CONFIG_X86_64
> > > +/*
> > > + * Mask out tag bits from the address.
> > > + *
> > > + * Magic with the 'sign' allows to untag userspace pointer without
> > > any branches
> > > + * while leaving kernel addresses intact.
> > 
> > Trying to understand the magic part here. I guess how it works is, when
> > the high bit is set, it does the opposite of untagging the addresses by
> > setting the tag bits instead of clearing them. So:
> 
> The magic is really rather simple to see; there's two observations:
> 
>   x ^ y ^ y == x
> 
> That is; xor is it's own inverse. And secondly, xor with 1 is a bit
> toggle.
> 
> So if we mask a negative value, we destroy the sign. Therefore, if we
> xor with the sign-bit, we have a nop for positive numbers and a toggle
> for negatives (effectively making them positive, -1, 2s complement
> yada-yada) then we can mask, without fear of destroying the sign, and
> then we xor again to undo whatever we did before, effectively restoring
> the sign.
> 
> Anyway, concequence of all this is that LAM_U48 won't work correct on
> 5-level kernels, because the mask will still destroy kernel pointers.

Any objection against this variant (was posted in the thread):

       	#define untagged_addr(mm, addr) ({                                      \
               	u64 __addr = (__force u64)(addr);                               \
               	s64 sign = (s64)__addr >> 63;                                   \
               	__addr &= (mm)->context.untag_mask | sign;                      \
               	(__force __typeof__(addr))__addr;                               \
       	})

?

I find it easier to follow and it is LAM_U48-safe.

-- 
 Kirill A. Shutemov
