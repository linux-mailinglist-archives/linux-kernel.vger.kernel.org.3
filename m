Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CE454E816
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243175AbiFPQtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378048AbiFPQsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:48:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78B42E3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655398134; x=1686934134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SqLD6j6CK4H0MlXRyMIS5Rw1htjMR+a33Z1guh6Ibgk=;
  b=g48Keobn3QFaPdkiSpOAOpzzAGedybT8HJHtfdKA4PBHqehc813rAm+J
   XJ5k/J3CvHk8g4zBj21nxmLOjTNXfff6w2kuPMrt6FIqzwmiCvzuSRoNX
   Wjm/80L33riVuQRiQDnvaQDRMZ6+NYkcn54Dau++Ne7GFz6ZqGRaqTA8q
   9Pyjh9JVMygaDijhYh9iKZleYYnQRq7xhLKyGaeAz6N3IchcASQ19Ldq8
   kA6GqEMpE4zTP0VqT7d+xcbH89sZtYZtDlQ0gxiUdjVx+ijbL/WkT+G7A
   hOXwAhRwxO6sJ7VcryfojhMZeV0G+QzkkJAp00Ji7qsoRVeuaEjNj/QpS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="340948418"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="340948418"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 09:48:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="575334770"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 16 Jun 2022 09:48:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 348DD109; Thu, 16 Jun 2022 19:48:54 +0300 (EEST)
Date:   Thu, 16 Jun 2022 19:48:54 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 5/8] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
Message-ID: <20220616164854.oyvfpl3tzqj54rd6@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-6-kirill.shutemov@linux.intel.com>
 <Yqr/qBeIbLZYzgXi@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqr/qBeIbLZYzgXi@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 12:02:16PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 10, 2022 at 05:35:24PM +0300, Kirill A. Shutemov wrote:
> > +#ifdef CONFIG_X86_64
> > +/*
> > + * Mask out tag bits from the address.
> > + *
> > + * Magic with the 'sign' allows to untag userspace pointer without any branches
> > + * while leaving kernel addresses intact.
> > + */
> > +#define untagged_addr(mm, addr)	({					\
> > +	u64 __addr = (__force u64)(addr);				\
> > +	s64 sign = (s64)__addr >> 63;					\
> > +	__addr ^= sign;							\
> > +	__addr &= (mm)->context.untag_mask;				\
> > +	__addr ^= sign;							\
> > +	(__force __typeof__(addr))__addr;				\
> > +})
> 
> Can't we make that mask a constant and *always* unmask U57 irrespective
> of LAM being on?

We can do this if we give up on LAM_U48.

It would also needlessly relax canonical check. I'm not sure it is a good
idea.

-- 
 Kirill A. Shutemov
