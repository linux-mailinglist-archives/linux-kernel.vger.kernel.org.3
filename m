Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B961493B04
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 14:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354780AbiASNWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 08:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiASNWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:22:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E994DC061574;
        Wed, 19 Jan 2022 05:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=XdBwF/RjhbWIU5o6Jz7HpuQNLjSadEnmWI/i7GCW5y0=; b=Cc09zlkLM5/Ab6cb+M3cwSs7PG
        huGqk0aJjbCMfwx7cGINmtqiWpkOY2MZWDoKt5SA8m0jllV54qtTq+XMW167egJYN43cWA6wmB1kT
        NSiw6gsSlTYaYYCOytDuMJy4dFx/vs+lSzcFzo9SptNPM3xm07UEtjKPEEPZNEk8oivGNJkbVOLpd
        5E4WhC0Wuj3mmjvZ3xxOdSBKLgCT1DGgCxproJPPwnGtPAjYjE7oVogDUTUmyoh8RSR3wa/r3oLCM
        BAkDt2EQRiO5AzaEt+RVfOvnIvPA1+sAN1KiGh40QWfqiVw95Gyi1Xn2ZGs2zJNxe5PnYpg//wkd6
        sU6IJtWA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAAua-00AsKQ-Da; Wed, 19 Jan 2022 13:22:04 +0000
Date:   Wed, 19 Jan 2022 13:22:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/3] mm: vmalloc: Let user to control huge vmalloc
 default behavior
Message-ID: <YegQfIQibQi993dp@casper.infradead.org>
References: <20211227145903.187152-1-wangkefeng.wang@huawei.com>
 <20211227145903.187152-2-wangkefeng.wang@huawei.com>
 <1642473992.qrnqczjfna.astroid@bobo.none>
 <f0dd59eb-6eb8-5b60-508d-7f4022f655ec@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0dd59eb-6eb8-5b60-508d-7f4022f655ec@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 08:57:58PM +0800, Kefeng Wang wrote:
> Only parts of our products wants this feature,  we add some interfaces which
> only
> 
> alloc hugevmalloc for them, eg,
> vmap_hugepage/vmalloc_hugepage/remap_vmalloc_hugepage_range..
> 
> for our products, but it's not the choice of most products, also add
> nohugevmalloc
> 
> for most products is expensive, so this is the reason for adding the patch.
> 
> more config/cmdline are more flexible for test/products，

But why do only some products want it?  What goes wrong if all products
enable it?  Features should be auto-tuning, not relying on admins to
understand them.
