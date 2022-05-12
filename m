Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCB6525044
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355438AbiELOh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355439AbiELOhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:37:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2F953B4B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M6wXwKLlbJ5QPgqxQHjWz14n+naV6OjfbCxLRHepeE4=; b=CEvLUGZgVRlxnfeYt0yODEx8dw
        fztgH10apfgqAyyBrCeYiBrr8HG7phdnEu3WjfH+uotCIcfTix5lzv03h3/59NlBGDQa9LsHGTRXI
        I23fo0wbTxxXPpx5Qnw+0/5ycYRx5wXGMUHbo/iM+oaygezE6yzujEfxFj9HvjByqcdYw95CLn93/
        lUpgbB/aosEEle66JyKNYRGMbvJ9RwvqZ4vVm2OGwjt0h1ew6kjkoPOmF0KI+7xL+rCOwoT+dkGPB
        YvE18Eu0OBtX6GlYWf90asw3xHOZiLTUHZiZ6pKq8pXR/ZrcwJgY37zDNKDouRk4VDZ6Qx6xQd31/
        d/ISVUoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1np9w6-00DWlm-8Q; Thu, 12 May 2022 14:37:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A64DC30047E;
        Thu, 12 May 2022 16:37:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 92825201E235B; Thu, 12 May 2022 16:37:00 +0200 (CEST)
Date:   Thu, 12 May 2022 16:37:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 04/10] x86/mm: Introduce X86_THREAD_LAM_U48 and
 X86_THREAD_LAM_U57
Message-ID: <Yn0bjINOR9d/2/27@hirez.programming.kicks-ass.net>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-6-kirill.shutemov@linux.intel.com>
 <20220511070211.GS76023@worktop.programming.kicks-ass.net>
 <87ee0zvszt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ee0zvszt.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 02:24:22PM +0200, Thomas Gleixner wrote:
> On Wed, May 11 2022 at 09:02, Peter Zijlstra wrote:
> > On Wed, May 11, 2022 at 05:27:45AM +0300, Kirill A. Shutemov wrote:
> >
> >> +#define LAM_NONE	0
> >> +#define LAM_U57		1
> >> +#define LAM_U48		2
> >
> >> +#define X86_THREAD_LAM_U48		0x1
> >> +#define X86_THREAD_LAM_U57		0x2
> >
> > Seriously pick an order and stick with it. I would suggest keeping the
> > hardware order and then you can do:
> >
> >> +static inline unsigned long lam_to_cr3(u8 lam)
> >> +{
> >
> > 	return (lam & 0x3) << X86_CR3_LAM_U57;
> 
> This "works" because the hardware ignores LAM_U48 if LAM_U57 is set, but
> I'd rather make that exclusive in the prctl() as setting both does not
> make any sense.

Yes, I was very much assuming the interface would not allow setting
both, that would be daft.
