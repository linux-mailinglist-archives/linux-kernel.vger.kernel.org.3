Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274AC54CF46
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357083AbiFORBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349045AbiFOQ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:58:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48A62CDCA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655312308; x=1686848308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bmcpvg7QLQWHYlV2e3pTfXD5SVvwtZuJHl7SPF3EiJE=;
  b=muAASBUzCCQ2MXABirDGudfJjDOpwonyAEv+Sk5ZMbqnKirSt6AGTIFm
   B61unKHQXKzFnMdbqXozZsBAHEFxpo4uyb/bQMNMAca9YEWyMyB5mmR2P
   CSMOTAkmv9HItAKmJKuNmeHrES14OEnjYqwIkhc2KdXq7J24CtV/Q0Wti
   6RQt38oHlshnD2fgeal4MgHQwLaR/Xa4DPaPD4mQDFmNyiCNaia4sX6rU
   j8DK1brkDChBR6osImMmLcuSjsfljWA7xKEDMaYt5nVtkwgUig6a1zYn3
   HIXaJcwF13BOfomjmt+opNaiur3dpg53uOxdWjrZa1m6IHVI5DtZ/IUuu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="342991361"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="342991361"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 09:58:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="762547847"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 15 Jun 2022 09:58:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 0E39F109; Wed, 15 Jun 2022 19:58:28 +0300 (EEST)
Date:   Wed, 15 Jun 2022 19:58:28 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
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
Message-ID: <20220615165828.5ggwnoxo7zhvmqzt@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-6-kirill.shutemov@linux.intel.com>
 <c7e2f8fb44da067e7565d091edeac300977b65ed.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7e2f8fb44da067e7565d091edeac300977b65ed.camel@intel.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 05:36:43PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2022-06-10 at 17:35 +0300, Kirill A. Shutemov wrote:
> > +#ifdef CONFIG_X86_64
> > +/*
> > + * Mask out tag bits from the address.
> > + *
> > + * Magic with the 'sign' allows to untag userspace pointer without
> > any branches
> > + * while leaving kernel addresses intact.
> 
> Trying to understand the magic part here. I guess how it works is, when
> the high bit is set, it does the opposite of untagging the addresses by
> setting the tag bits instead of clearing them. So:
>  - For proper canonical kernel addresses (with U57) it leaves them 
>    intact since the tag bits were already set.
>  - For non-canonical kernel-half addresses, it fixes them up. 
>    (0xeffffff000000840->0xfffffff000000840)
>  - For U48 and 5 level paging, it corrupts some normal kernel 
>    addresses. (0xff90ffffffffffff->0xffffffffffffffff)
> 
> I just ported this to userspace and threw some addresses at it to see
> what happened, so hopefully I got that right.

Ouch. Thanks for noticing this. I should have catched this myself. Yes,
this implementation is broken for LAM_U48 on 5-level machine.

What about this:

	#define untagged_addr(mm, addr)	({					\
		u64 __addr = (__force u64)(addr);				\
		s64 sign = (s64)__addr >> 63;					\
		__addr &= (mm)->context.untag_mask | sign;			\
		(__force __typeof__(addr))__addr;				\
	})

It makes mask effectively. all-ones for supervisor addresses. And it is
less magic to my eyes.

The generated code also look sane to me:

    11d0:	48 89 f8             	mov    %rdi,%rax
    11d3:	48 c1 f8 3f          	sar    $0x3f,%rax
    11d7:	48 0b 05 52 2e 00 00 	or     0x2e52(%rip),%rax        # 4030 <untag_mask>
    11de:	48 21 f8             	and    %rdi,%rax

Any comments?

> Is this special kernel address handling only needed because
> copy_to_kernel_nofault(), etc call the user helpers?

I did not have any particular use-case in mind. But just if some kernel
address gets there and bits get cleared we will have very hard to debug
bug.

-- 
 Kirill A. Shutemov
