Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018D8493B64
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 14:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354915AbiASNs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 08:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349591AbiASNsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:48:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE51CC061574;
        Wed, 19 Jan 2022 05:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=KXtnBmHR26VnyA5/MyeO0p5Mer/FOttvLvx2Yg5H/f0=; b=q307KYxlizBZChDxVWf50BNc7i
        ulkozYxgvKy0JvUzcELQya+co3ae/kHNFbO1y3/T6S4j4u1q9n27AiQpeEc9GpLDMLSVvksmQpPJK
        MnOEHc+PxkQY8WS6RXMiDj04z27Jr9OmVBz/rv0fcvN4azhZg8dQVHcGy+WMroOnLK3bySxG5A+xI
        LWqXJF+Jr7gv+tHXgGkVDEIF2ha516o0dx4gsz6ldb3tNDDk3wMbKx6lT5M3fygBiU12ICmzCpzXc
        3HIhEJKLOdRJ6XLNvaHagY1xzR38gvmSE8gEDYjtJuNOqUATZ+WipQz+OHME+/GVUHEcyAgphvSQK
        QIPa9SLA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nABJt-00AwLk-Qj; Wed, 19 Jan 2022 13:48:13 +0000
Date:   Wed, 19 Jan 2022 13:48:13 +0000
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
Message-ID: <YegWneON2voE9htO@casper.infradead.org>
References: <20211227145903.187152-1-wangkefeng.wang@huawei.com>
 <20211227145903.187152-2-wangkefeng.wang@huawei.com>
 <1642473992.qrnqczjfna.astroid@bobo.none>
 <f0dd59eb-6eb8-5b60-508d-7f4022f655ec@huawei.com>
 <YegQfIQibQi993dp@casper.infradead.org>
 <93db576e-9a62-ee98-5af2-a62f8386212c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93db576e-9a62-ee98-5af2-a62f8386212c@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 09:44:20PM +0800, Kefeng Wang wrote:
> 
> On 2022/1/19 21:22, Matthew Wilcox wrote:
> > On Wed, Jan 19, 2022 at 08:57:58PM +0800, Kefeng Wang wrote:
> > > Only parts of our products wants this feature,  we add some interfaces which
> > > only
> > > 
> > > alloc hugevmalloc for them, eg,
> > > vmap_hugepage/vmalloc_hugepage/remap_vmalloc_hugepage_range..
> > > 
> > > for our products, but it's not the choice of most products, also add
> > > nohugevmalloc
> > > 
> > > for most products is expensive, so this is the reason for adding the patch.
> > > 
> > > more config/cmdline are more flexible for test/products，
> > But why do only some products want it?  What goes wrong if all products
> > enable it?  Features should be auto-tuning, not relying on admins to
> > understand them.
> 
> Because this feature will use more memory for vmalloc/vmap, that's why we
> add some explicit
> interfaces as said above in our kernel to control the user.

Have you validated that?  What sort of performance penalty do you see?
