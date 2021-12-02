Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43918466D3E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240957AbhLBWyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236683AbhLBWyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:54:45 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A87C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 14:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vYJYxPFB81ImcxxA4eEVz9rlIlKDPAv4RKehjdDENs4=; b=aFcQYqC6VzAkaf91CjZkaXj7zU
        PA2dKQC9K2YZdZT4mk220HAeEvqMZ8KKNIYnC3wQXVtS1LlDXhGJAfKc8QYZ0mRoV/9kDTXXdwvdv
        spqP0DljuGJMdZ6SxfP+Gd6LGXhflr7WW6+7L75GqZ6xDb0SohGYpdASVT+0J+LFRu2rMNQjtuFbW
        v7J4jjuYEAtIIVxcaxVhXIOwqS0KoxHjzZG8b6yq4sEO7S43gReIBEs4X5F9Ratskdn5SRnNwyRPS
        QCtgA3SUHqAkHGZ7YgS66/2ELGQuGawJzQQd40dBHZST/0K+wj2UTAIj8Jxs3Kyj/jM0MIGtuNzjF
        Fzef6MyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1msuuz-001tMY-7E; Thu, 02 Dec 2021 22:51:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0B76E9810D4; Thu,  2 Dec 2021 23:51:08 +0100 (CET)
Date:   Thu, 2 Dec 2021 23:51:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Brian Gerst' <brgerst@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 2/6] x86-64: Convert stack protector to normal percpu
 variable
Message-ID: <20211202225107.GF16608@worktop.programming.kicks-ass.net>
References: <20211130205549.116673-1-brgerst@gmail.com>
 <20211130205549.116673-3-brgerst@gmail.com>
 <2c23335e98bc4a66b1fd779a78ddd821@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c23335e98bc4a66b1fd779a78ddd821@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 09:50:57AM +0000, David Laight wrote:
> From: Brian Gerst
> > Sent: 30 November 2021 20:56
> > 
> > Older versions of GCC fixed the location of the stack protector canary
> > at %gs:40.  This constraint forced the percpu section to be linked at
> > virtual address 0 so that the canary could be the first data object in
> > the percpu section.  Supporting the zero-based percpu section requires
> > additional code to handle relocations for RIP-relative references to
> > percpu data, extra complexity to kallsyms, and workarounds for linker
> > bugs due to the use of absolute symbols.
> > 
> > Since version 8.1, GCC has options to configure the location of the
> > canary value.  This allows the canary to be turned into a normal
> > percpu variable and removes the constraint that the percpu section
> > be zero-based.
> 
> I didn't think the minimum gcc version has been raised as far as 8.1?

Older GCC can still build a kernel, just not with stack protector on.
And 8.1 is already 3 years old. If you run ancient distros, you can run
ancient kernels too.
