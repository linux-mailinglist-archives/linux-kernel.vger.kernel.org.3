Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFED6524DC4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354135AbiELNGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351021AbiELNGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:06:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FFF5DA4B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:06:41 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652360799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tU5R0oUSocyA3MxRM564LYiuixGd7K4ozSHlUmSLzHI=;
        b=LbPNYrty+ztXBREIQ8dN9l2FL71M/k2cJyRdgBYL4uqjO2PaPlSjpIKuWVc2Af3b32yPe3
        WRFj5MMmgkF8on2M902Bxg/EvvU+zLfMiLNcQ0BeYZIpiLUqU/v7qRLp7EXO7WubapDr5b
        y+P1XeeWe9AoVBfcfMYRrORojtCQWQJkj/g5p67sROSDzmHaj6HFtAjJRM0vq3+kZ7S3A5
        M0nSsI0Em0ZZMuZ3tmWMDMlyTgULNIEbIeN91M3ou4zi3bteUI9ClP4cBxbCkn7+FHN4dK
        2mLpaLojfVPOOWdNPA8GxJTst9FKZphCsvFf6exYcajuzbJDdJLsUXyjeDPlOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652360799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tU5R0oUSocyA3MxRM564LYiuixGd7K4ozSHlUmSLzHI=;
        b=BaBb+Mh9+cvyEdyShOUxJpim5uzRIvh9yvb0uSnm78y5U86So7HUzvOJLGjHgnnb4DKz3e
        tZB4nYwgLwrk9fAQ==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFCv2 05/10] x86/mm: Provide untagged_addr() helper
In-Reply-To: <20220511022751.65540-7-kirill.shutemov@linux.intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-7-kirill.shutemov@linux.intel.com>
Date:   Thu, 12 May 2022 15:06:38 +0200
Message-ID: <87a6bmx5lt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11 2022 at 05:27, Kirill A. Shutemov wrote:
> +#define __untagged_addr(addr, n)	\
> +	((__force __typeof__(addr))sign_extend64((__force u64)(addr), n))

How is this supposed to be correct? This sign extends based on bit 47
resp. 56, i.e. the topmost bit of the userspace address space for the
LAM mode.

So if that bit _is_ set, then the result has bit 48-63 resp. 57-63 set
as well. Not really what you want, right?

This has to mask out bit 48-62 resp. 57-62 and leave all other bits
alone.

> +#define untagged_addr(addr)	({					\
> +	u64 __addr = (__force u64)(addr);				\
> +	if (__addr >> 63 == 0) {					\
> +		if (current->thread.features & X86_THREAD_LAM_U57)	\
> +			__addr &= __untagged_addr(__addr, 56);		\
> +		else if (current->thread.features & X86_THREAD_LAM_U48)	\
> +			__addr &= __untagged_addr(__addr, 47);		\
> +	}								\
> +	(__force __typeof__(addr))__addr;				\
> +})

So this wants something like this:

#define untagged_addr(addr)	({			\
	u64 __addr = (__force u64)(addr);		\
							\
	__addr &= current->thread.lam_untag_mask;	\
	(__force __typeof__(addr))__addr;		\
})

No conditionals, fast _and_ correct. Setting this untag mask up once
when LAM is enabled is not rocket science.

Thanks,

        tglx
