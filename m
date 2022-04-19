Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD54506CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352375AbiDSMrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241939AbiDSMrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:47:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC29C36E01
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1j/CBqe+Y/QZrJKL+PC6OKI6vmJNLB3SpUMrJYCq/34=; b=iPrTwgNzgZcIXPc/UyK08mQwPe
        qlcPRG1U6xmh34hgBZFu3OrcnELUOOfpU0L/FEo9cSAI6AyhbUN4le7ojqgfEYDh2iHDdF3MiytVS
        VbABNPpMEt2+sICQlc9vEYaRjj9HpoT7rxbdz4ktMr0mPOX8DI5phJBKiUXmAxeAemZw8I5uh5Qb1
        c3cRHFf8o1AllvX3TVACZC2I/rPxEUr0MVdbQuf2MKDdvutfjfJVYwaDVCy16VwpLj/ayQH09h+Hd
        7iaWFueGPhNrY6f0Jb8gmissQJGpVpa0l+K32HpzgcmGgfT293+AtHzJjUtPT13SHmvELsj+wi7vD
        vIilWGng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngnDK-0035rz-Qc; Tue, 19 Apr 2022 12:44:14 +0000
Date:   Tue, 19 Apr 2022 13:44:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] mm/highmem: Fix kernel-doc warnings in highmem*.h
Message-ID: <Yl6unkluUEeRZBbB@casper.infradead.org>
References: <20220418175638.30018-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418175638.30018-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 07:56:38PM +0200, Fabio M. De Francesco wrote:
> +/**
> + * kunmap_atomic - Unmap the virtual address mapped by kmap_atomic()
> + * @__addr:       Virtual address to be unmapped
> + *
> + * Counterpart to kmap_atomic().

I don't think this is a terribly useful paragraph?

> + * Effectively a wrapper around kunmap_local() which additionally undoes
> + * the side effects of kmap_atomic(), i.e. reenabling pagefaults and
> + * preemption. Prevent people trying to call kunmap_atomic() as if it
> + * were kunmap() because kunmap_atomic() should get the return value of
> + * kmap_atomic(), not its argument which is a pointer to struct page.

I'd rather this were useful advice to the caller than documentation of
how it works.  How about:

 * Unmap an address previously mapped by kmap_atomic().  Mappings
 * should be unmapped in the reverse order that they were mapped.
 * See kmap_local_page() for details.  @__addr can be any address within
 * the mapped page, so there is no need to subtract any offset that has
 * been added.  In contrast to kunmap(), this function takes the address
 * returned from kmap_atomic(), not the page passed to kmap_atomic().
 * The compiler will warn you if you pass the page.

