Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808CF593010
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiHONh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiHONh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:37:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A7F205DC
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OhsclZAw4++SCZJt6PxhgQPcNRPDZfNSWoLpFgsjkGI=; b=FWhBtbK8RNKAe2/3k1sg4n3CeI
        FO0yg/TTs4CrLDJTCKqjufhGjDWmG9UuieY5TABoSNFycYYsqv3OPexmsT3WG0/xACkcSjJo4MUlO
        ooZzswzZO0ApmXRJJyUWvPKk9WTK9+nzUvbTvwdnPYP7Widg7YyzbutugTfMBfDcE/IBMKnrPqAvo
        EPJsvLw8UmKvF+6xQQxV/7rJLb75ibQVwVMm9NdPk25S6K4ymc1qEZjTxRFJ0KFPJJXJ39EGLMH4r
        H/ldw96DPoMm7XppAQCPs3+v/kkN5NaWvPl+3Ur5ibDgs/eXuNVkjsszt1nUtrYYgZWuur065Bsxq
        stSI/nAA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNaHO-005kwY-2i; Mon, 15 Aug 2022 13:37:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A20F5980153; Mon, 15 Aug 2022 15:37:16 +0200 (CEST)
Date:   Mon, 15 Aug 2022 15:37:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 06/11] x86/mm: Provide arch_prctl() interface for LAM
Message-ID: <YvpMDOeVVKIzJhKV@worktop.programming.kicks-ass.net>
References: <20220815041803.17954-1-kirill.shutemov@linux.intel.com>
 <20220815041803.17954-7-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815041803.17954-7-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 07:17:58AM +0300, Kirill A. Shutemov wrote:

> +static void enable_lam_func(void *mm)
> +{
> +	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
> +	unsigned long lam_mask;
> +	unsigned long cr3;
> +
> +	if (loaded_mm != mm)
> +		return;
> +
> +	lam_mask = READ_ONCE(loaded_mm->context.lam_cr3_mask);
> +
> +	/* Update CR3 to get LAM active on the CPU */
> +	cr3 = __read_cr3();
> +	cr3 &= ~(X86_CR3_LAM_U48 | X86_CR3_LAM_U57);
> +	cr3 |= lam_mask;
> +	write_cr3(cr3);
> +	set_tlbstate_cr3_lam_mask(lam_mask);
> +}
> +
> +static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
> +{
> +	int ret = 0;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_LAM))
> +		return -ENODEV;
> +
> +	mutex_lock(&mm->context.lock);
> +
> +	/* Already enabled? */
> +	if (mm->context.lam_cr3_mask) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	if (!nr_bits) {
> +		ret = -EINVAL;
> +		goto out;
> +	} else if (nr_bits <= 6) {
> +		mm->context.lam_cr3_mask = X86_CR3_LAM_U57;
> +		mm->context.untag_mask =  ~GENMASK(62, 57);
> +	} else {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* Make lam_cr3_mask and untag_mask visible on other CPUs */
> +	smp_mb();

smp_mb() doesn't make visible -- it is about ordering, what does it
order against that the below on_each_cpu_mask() doesn't already take
care of?

> +
> +	on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);
> +out:
> +	mutex_unlock(&mm->context.lock);
> +	return ret;
> +}
