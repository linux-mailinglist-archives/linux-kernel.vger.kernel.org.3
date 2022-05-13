Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAA5526D42
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 01:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384929AbiEMW75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 18:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384927AbiEMW7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 18:59:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FE25DBDA
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 15:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652482782; x=1684018782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S0PigX2MDUeA1FsxOZTsaM1CtoD0SV42JUS/vyCyeIc=;
  b=bMvlic/C1Fbk9W+R+JOcXdcIO6+HYrlUXJKHzaPbsbG7dKIZu+Qa1jy0
   WJVvqGL7UTDexnfPZq3YWuRrv+zHO6317+h1zNGzrjdyIJ6v08yxgcQoE
   tKX9ycuTT8iHKUEmdqtfAnJX2hY/FCtM7fcvut2f6qmDURdFoGd9lKwUu
   BQB9lZvJuqNI5h2bL2QKPVbQftZfhsQ76HZPuGJmA8FjEM2ETYgfFwVkW
   TtVcHQnHNzrFyEPmjDMT8qttvJL1/BLpt62WKqV6q2K2jcTco7utNRAWE
   1mJNyzjTSw1IQESIpsdukZ9aFMplOYXspN4xKNjpcAUt2B+Q/PNczYTwx
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="295691406"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="295691406"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 15:59:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="698684291"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2022 15:59:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id CAE73A8; Sat, 14 May 2022 01:59:36 +0300 (EEST)
Date:   Sat, 14 May 2022 01:59:36 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
Message-ID: <20220513225936.qo4cy6sijqpzmvpt@black.fi.intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com>
 <875ymav8ul.ffs@tglx>
 <87zgjmtpf8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgjmtpf8.ffs@tglx>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 11:24:27PM +0200, Thomas Gleixner wrote:
> On Thu, May 12 2022 at 21:39, Thomas Gleixner wrote:
> > On Thu, May 12 2022 at 10:22, Dave Hansen wrote:
> >> One of the stated reasons for adding LAM hardware is that folks want to
> >> use sanitizers outside of debugging environments.  To me, that means
> >> that LAM is something that the same binary might run with or without.
> >
> > On/off yes, but is there an actual use case where such a mechanism would
> > at start time dynamically chose the number of bits?
> 
> This would need cooperation from the application because it has to tell
> the magic facility whether it intends to utilize the large VA space on a
> 5-level paging system or not.
> 
> I have no idea how that is supposed to work, but what do I know about
> magic.
> 
> >> It's totally fine with me if the kernel only initially supports LAM_U57.
> >>  But, I'd ideally like to make sure that the ABI can support LAM_U57,
> >> LAM_U48, AMD's UAI (in whatever form it settles), or other masks.
> >
> > Sure. No argument here.
> 
> Assumed that the acronym of the day, which uses this, has a real benefit
> from the larger number of bits, we can support it.
> 
> But we are not going to make this a per thread selectable thing.
> 
> It's a process wide decision at startup simply because it does no buy
> thread A anything to select U57 if thread B selects U48 before thread A
> was able to map something into the U48 covered address space. Same issue
> the other way round as then B has to fallback to U57 or NONE. That does
> not make any sense at all.
> 
> I'm all for flexible, but not just because we can. It has to make sense.

Some JVMs arn javascript engines are known for using tags in high bit of
pointers (and clearing them manually on dereferencing as of now).

One use-case I had in mind was having a thread that runs VM/JIT, like
javascript/JVM/LUA/whatever that serves the rest of the application.
The thread uses LAM while the rest of the application does not. Leaking
tagged pointer into into thread that does not use LAM would indicate an
issue and SIGSEGV would be deserved.

No idea if it is practical.

-- 
 Kirill A. Shutemov
