Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4046C522CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242729AbiEKHEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242683AbiEKHDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:03:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A695EAD22
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4mTV/2QbqZWLgPOWVuiVpIoSDAtrtxN8hCmcU8TRmeg=; b=QFwQGZsV3dczD+XlfgiqYuGLKX
        /VyHnwZDpeWSzO6tWAjgm1CcoAAU2Rle7YqMDvaPx2RLpGY5Trq/UF+vIbu6Ol9ZNqdz/yVx2PbkM
        wf+Cd+lVstE0otYE3SInI807gN5jZ1X1BqBpgob6XHQpofscJOEwPinxiYe+B2SwY2FlZAUnJrsvh
        P0PzKkOjaCMQn8lV1bt2zsn3UB2/FP6g4BM6rPUJvbMrMLDiCBER68A87y0vawa3d9kwTxSEKSr9I
        xnVN0ZSY0fwTWIn2056OWU0JO34GQ5jJHqYJ3VR/HBsCsdYz/L6c+rET8qQPHo0LJjv8a9dSDI2Xa
        zlw/vX7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nogMO-005DCv-Hi; Wed, 11 May 2022 07:02:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0EF1F980E3A; Wed, 11 May 2022 09:02:12 +0200 (CEST)
Date:   Wed, 11 May 2022 09:02:11 +0200
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
Subject: Re: [RFCv2 04/10] x86/mm: Introduce X86_THREAD_LAM_U48 and
 X86_THREAD_LAM_U57
Message-ID: <20220511070211.GS76023@worktop.programming.kicks-ass.net>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511022751.65540-6-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511022751.65540-6-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 05:27:45AM +0300, Kirill A. Shutemov wrote:

> +#define LAM_NONE	0
> +#define LAM_U57		1
> +#define LAM_U48		2

> +#define X86_THREAD_LAM_U48		0x1
> +#define X86_THREAD_LAM_U57		0x2

Seriously pick an order and stick with it. I would suggest keeping the
hardware order and then you can do:

> +static inline unsigned long lam_to_cr3(u8 lam)
> +{
> +	switch (lam) {
> +	case LAM_NONE:
> +		return 0;
> +	case LAM_U57:
> +		return X86_CR3_LAM_U57;
> +	case LAM_U48:
> +		return X86_CR3_LAM_U48;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return 0;
> +	}

	return (lam & 0x3) << X86_CR3_LAM_U57;

> +}
> +
> +static inline u8 cr3_to_lam(unsigned long cr3)
> +{
> +	if (cr3 & X86_CR3_LAM_U57)
> +		return LAM_U57;
> +	if (cr3 & X86_CR3_LAM_U48)
> +		return LAM_U48;
> +	return 0;


	return (cr3 >> X86_CR3_LAM_U57) & 0x3;

> +}

and call it a day, or something.

I'm still not liking LAM(e), I'm thikning it's going to create more
problems than it solves.
