Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C069354DE92
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 12:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359781AbiFPKCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 06:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359726AbiFPKCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:02:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3D21054F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 03:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OQ8QjhId98aVZtkzwB92ymmCSygUJEF1LPTt92pl2Gc=; b=UDL5O5cYUZMb9AxEHHsVf7wADA
        bZGqmqtsWJ9W9SkQQXVbppUmg0g7E44h6X1TRU1QDmbI/6WUWcYUMVT2p7Zm4OyALLebThJMIPUn2
        ysg4d8OVIdPWFOwhd7cx8ET4cudZ+TVVq2W7LBMZ662sjTgxyMSv6wtfDt1CaZtz87sTiRJsYBG+V
        2ojUkX0OOP3p7xq1/d5bh/23wZRMwkGAL5QwNSgEWBIW07uLvqiTDT1qWiHaa6jv6m6SV+I02QvnT
        yKQEGZSH86LXX2H3qMkaNXYdomgfGBYkQvGNN6O4Dg6D5chWPluFzEhEM2UyA9c00XkDpETTZSByp
        vSRK4IcQ==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1mKQ-008NxA-BT; Thu, 16 Jun 2022 10:02:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 64BC2302E2E;
        Thu, 16 Jun 2022 12:02:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 568BB201A4015; Thu, 16 Jun 2022 12:02:16 +0200 (CEST)
Date:   Thu, 16 Jun 2022 12:02:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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
Message-ID: <Yqr/qBeIbLZYzgXi@hirez.programming.kicks-ass.net>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-6-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610143527.22974-6-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 05:35:24PM +0300, Kirill A. Shutemov wrote:
> +#ifdef CONFIG_X86_64
> +/*
> + * Mask out tag bits from the address.
> + *
> + * Magic with the 'sign' allows to untag userspace pointer without any branches
> + * while leaving kernel addresses intact.
> + */
> +#define untagged_addr(mm, addr)	({					\
> +	u64 __addr = (__force u64)(addr);				\
> +	s64 sign = (s64)__addr >> 63;					\
> +	__addr ^= sign;							\
> +	__addr &= (mm)->context.untag_mask;				\
> +	__addr ^= sign;							\
> +	(__force __typeof__(addr))__addr;				\
> +})

Can't we make that mask a constant and *always* unmask U57 irrespective
of LAM being on?
