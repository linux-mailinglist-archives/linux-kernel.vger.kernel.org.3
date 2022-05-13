Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D472F526513
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381393AbiEMOpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbiEMOnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:43:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF1E2D8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nJ0dd5dcOSKw4+ESckVZDki1YhEbIEmb3PnEsHXElEA=; b=Wu3k6TdGzaMVnAN+LPCeRXIcKZ
        diBlUnP56ZiXXCbTyuGJhSUSXTiVp45DqVdHHfmmAYWDH03vo4JuloK3B0g0qcpbDOr9+cH5FLtJF
        1NU7KSLBpOu7/Q2Ng1eHIxhNWlTjXyZ/v3KfvnrrN6rfdXSYvpGgpNgnjDN3ALD3J50xZCiei85XH
        bBRMdHLfVqrUAblS3eKc8uNdkyxWnJ2+nxGkW/iEnaUMDCX17IGXyrJbbBOrX1WNj++jb2N+GcHkG
        dZp/x+EFos/lm+Eftp53htZOEyMY9txh72gwqpEoJqmQY1ds9LD8+7C546LcKlBC611qJss0tcCEZ
        h7nnVHZw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npWVh-007QV9-Er; Fri, 13 May 2022 14:43:17 +0000
Date:   Fri, 13 May 2022 15:43:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
Message-ID: <Yn5uhco0kKN5wNdn@casper.infradead.org>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
 <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com>
 <875ymav8ul.ffs@tglx>
 <87zgjmtpf8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgjmtpf8.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Taking a step back ...

Consider an application like 'grep'.  It operates on streams of data,
and has a fairly bounded amount of virtual memory that it will use.
Let's say it's 1GB (*handwave*).  So it has 33 bits of address space that
it can use for "security" of one form or another.  ASLR is one thing which
is vying for bits, and now ASAN is another.  Somehow it is supposed to
tell the kernel "I want to use 6 bits for ASAN and 27 bits for ASLR".
Or "I want to use 15 bits for ASAN and 18 bits for ASLR".

So how does grep make that decision?  How does it find out what the
kernel supports?  Deciding which tradeoff is more valuable to grep is
clearly not something the kernel can help with, but I do think that the
kernel needs to have an API to query what's available.

Something like Libreoffice or Firefox is obviously going to be much more
complex; it doesn't really have a bounded amount of virtual memory to
work with.  But if we can't even solve this problem for applications
with bounded address space, we stand no chance of solving it for hard
cases.

