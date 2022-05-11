Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96EE522D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243045AbiEKHpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiEKHpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:45:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15C26B015
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zQStQvqHTMn/lq4ztBBoUMAZrkzuwgeyV+t4snpAvM8=; b=UWiv7NTPus3l28tAO0e8eiSK9I
        RT06/y3Q8GxqTVOEDoMwVswZAx+Mirl+fY3OBWVaCPpHbCpf1ZxdMiL2ZF60fdSWtFtyrT0cDwL7c
        ts6ahlMXeNOSk6Pm2j1wajMVAa97+TiASz8nZRr6Fq1pxyAyn4YAf+5D7Hw7XHSrpdAKFrgT6yAV8
        mDnM62iKyYMB+Q/hCKuZnvUzTUnPjA4nwCF9fYDCsi8Eu3hmegNKq+kkefuSswzZlvRf5IW/HxSw1
        jXbKRSTi3j0atnx1m8lGCnq8QO2sM5mVKLK8sSTQ9B/iY72iprnW7PdDTTV2rFBHUHieP5S11LCWr
        08ypHoYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noh1u-005F9n-QA; Wed, 11 May 2022 07:45:07 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 646FD980E3A; Wed, 11 May 2022 09:45:06 +0200 (CEST)
Date:   Wed, 11 May 2022 09:45:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 05/10] x86/mm: Provide untagged_addr() helper
Message-ID: <20220511074506.GB100765@worktop.programming.kicks-ass.net>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-7-kirill.shutemov@linux.intel.com>
 <20220511072116.GT76023@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511072116.GT76023@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 09:21:16AM +0200, Peter Zijlstra wrote:
> On Wed, May 11, 2022 at 05:27:46AM +0300, Kirill A. Shutemov wrote:
> > +#define __untagged_addr(addr, n)	\
> > +	((__force __typeof__(addr))sign_extend64((__force u64)(addr), n))
> > +
> > +#define untagged_addr(addr)	({					\
> > +	u64 __addr = (__force u64)(addr);				\
> > +	if (__addr >> 63 == 0) {					\
> > +		if (current->thread.features & X86_THREAD_LAM_U57)	\
> > +			__addr &= __untagged_addr(__addr, 56);		\
> > +		else if (current->thread.features & X86_THREAD_LAM_U48)	\
> > +			__addr &= __untagged_addr(__addr, 47);		\
> > +	}								\
> > +	(__force __typeof__(addr))__addr;				\
> > +})
> 
> Assuming you got your bits in hardware order:
> 
> 	u64 __addr = addr;
> 	if ((s64)__addr >= 0) {
> 		int lam = (current->thread.features >> X86_THREAD_LAM_U57) & 3;

That needs a _BIT suffix or something, same in the previous reply.

> 		if (lam)
> 			__addr &= sign_extend64(__addr, 65 - 9*lam);
> 	}
> 	__addr;
> 
> has less branches on and should definitely result in better code (or I
> need more morning juice).

I definitely needs more morning juice :-)
