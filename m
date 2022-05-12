Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23664525326
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356790AbiELRCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356570AbiELRCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:02:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1995E52AC
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652374961; x=1683910961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sMZBofsExJ4XZ0XAXWwsuHVeTzHqA51EM19kzKk8154=;
  b=BmrXD/tkfKrjq1P/QI23oQ3DDsGRuvgnFQZmuPWngE1gseGHyU/QJc9i
   G0YRGnOR/tHkNazvzDb2NIn6zNrPLBJ9KxqVZfIbX1Y9EC6hzfbdSqGK9
   Cgs5Uqjjx28oI4vKrWXrrTLcPfa1lMjTGpFm+QkcCbzcs4ovsV8iPCeiK
   DWr5nG62daNKkrhUNY3BkaBfA36Yi6Ta8Lgo8XvEuTy686xf1S6rEfyRh
   tHMnjsgjyDq/Uh6s8gpbc+0vjakykACL+/m/oUD6s9qrU3CCpCL6sR+du
   MQTvM1ppWU/8W2+e7QpcvGMamicU8w2eaOpRg8SamttkPAlddzlMmcwog
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="257612806"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="257612806"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 10:00:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="712002221"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 May 2022 10:00:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id C4A29CE; Thu, 12 May 2022 20:00:01 +0300 (EEST)
Date:   Thu, 12 May 2022 20:00:01 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: Implement Linear Address Masking support
Message-ID: <20220512170001.6olwffikg4u3cke3@black.fi.intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-2-kirill.shutemov@linux.intel.com>
 <fc54d360620d436f93785ae5e9f8a23f@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc54d360620d436f93785ae5e9f8a23f@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 01:01:07PM +0000, David Laight wrote:
> From: Kirill A. Shutemov
> > Sent: 11 May 2022 03:28
> > 
> > Linear Address Masking feature makes CPU ignore some bits of the virtual
> > address. These bits can be used to encode metadata.
> > 
> > The feature is enumerated with CPUID.(EAX=07H, ECX=01H):EAX.LAM[bit 26].
> > 
> > CR3.LAM_U57[bit 62] allows to encode 6 bits of metadata in bits 62:57 of
> > user pointers.
> > 
> > CR3.LAM_U48[bit 61] allows to encode 15 bits of metadata in bits 62:48
> > of user pointers.
> > 
> > CR4.LAM_SUP[bit 28] allows to encode metadata of supervisor pointers.
> > If 5-level paging is in use, 6 bits of metadata can be encoded in 62:57.
> > For 4-level paging, 15 bits of metadata can be encoded in bits 62:48.
> > 
> ...
> > +static vaddr clean_addr(CPUArchState *env, vaddr addr)
> > +{
> > +    CPUClass *cc = CPU_GET_CLASS(env_cpu(env));
> > +
> > +    if (cc->tcg_ops->do_clean_addr) {
> > +        addr = cc->tcg_ops->do_clean_addr(env_cpu(env), addr);
> 
> The performance of a conditional indirect call will be horrid.
> Over-engineered when there is only one possible function.

It is QEMU patch. As I mentioned in the cover letter, it was rejected by
upstream, but it is functional and can be used for testing before HW
arrived.

I may give it another try when I get time to look deeper at TCG.

-- 
 Kirill A. Shutemov
