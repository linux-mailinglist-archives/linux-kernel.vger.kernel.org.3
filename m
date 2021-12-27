Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFABA47F9F0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 04:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhL0DTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 22:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbhL0DTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 22:19:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80ECC06173E;
        Sun, 26 Dec 2021 19:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=kf/tP0+x+PcG14mcVnYZ+U9SH0RIj9hQSnEdArsxzxY=; b=MtCuALaIeb/dLfa2KTxQ3nYxYH
        Y9BeioyuLk7vFZqvoKiPaCBMIZHldVpK2lDdZkW7oKZuiV4RtT+fXMYMvxqaYZHL5A6XHIazkokN1
        LoxDzngZY6fP1L43ItBwVLJDxggUMPYjISfHrU9fUtzlfP9Wj0Di2G/gVyQabiZG5nDHn/vD4tyGA
        /lUTMmb1Hq18SML0Dv+A7LwSfiAh78sHv+2X4Y9YRFxQzggC5nLcvuh6WoLBBwFaC/EmGN0GaNo8X
        DUPie5mUG+s0d8oeFU4QVSknrOWuJwr3IoJmja6EoxeefrxpjevLinFNSPV7VzLHrS4+DWbvmNkIu
        EAo2JvfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n1gXg-0076xR-GH; Mon, 27 Dec 2021 03:19:20 +0000
Date:   Mon, 27 Dec 2021 03:19:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/3] mm: vmalloc: Let user to control huge vmalloc
 default behavior
Message-ID: <YckwuA8CWcQpQdGO@casper.infradead.org>
References: <20211226083912.166512-1-wangkefeng.wang@huawei.com>
 <20211226083912.166512-2-wangkefeng.wang@huawei.com>
 <6c4bd989-268e-5899-09a7-ac573bd8b4d9@csgroup.eu>
 <c7037a3a-d0b1-6351-5e31-22be0d8e0e01@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7037a3a-d0b1-6351-5e31-22be0d8e0e01@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 09:44:24AM +0800, Kefeng Wang wrote:
> 
> On 2021/12/27 1:36, Christophe Leroy wrote:
> > 
> > Le 26/12/2021 à 09:39, Kefeng Wang a écrit :
> > > Add HUGE_VMALLOC_DEFAULT_ENABLED to let user to choose whether or
> > > not enable huge vmalloc mappings by default, and this could make
> > > more architectures to enable huge vmalloc mappings feature but
> > > don't want to enable it by default.
> > > 
> > > Add hugevmalloc=on/off parameter to enable or disable this feature
> > > at boot time, nohugevmalloc is still supported and equivalent to
> > > hugevmalloc=off.
> > 
> > Is there a real added value to have the user be able to select that ?
> > 
> > If the architecture supports it, is there any good reason to not use it ?
> 
> There are some disadvantages[1],  one of the main concerns is the possible
> 
> memory waste, we have backported this feature to our kernel 5.10, but our
> 
> downstream in our some scenario(especially in embedded), they don't want
> 
> it enabled by default, and others want it, this is why patch1 comes.
> 
> > 
> > Why not just do like PPC and enable it by default ? Why should it be
> > enabled by default on PPC but disabled by default on ARM64 and X86 ?
> 
> The PPC is default enabled, we don't changes this behavior.
> 
> Maybe upstream is not care about this, as I said in cover-letter, if
> arm64/x86
> 
> don't want patch1, we could only just select config to enable it.
> 
> Let's wait for more feedback.

We should not have different defaults by architecture.  Either we change
the default for PPC, or x86 & arm should have the same default as PPC.
