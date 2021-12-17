Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE44F478BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbhLQMtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbhLQMtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:49:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA24C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 04:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=phfSQOq+yHoa1/Is//J703S9KmGy3k5Z+ZGw0hERoCw=; b=nqhpDQDdE4h3YoMocmuJgMOmWR
        U9+JtecNnWJDXaXsYT4Q4SaMyfV8T0rbbFBXLx2zRmcUofUm3WVSBZ+YlroZwx2BXs1juzKuUnRNz
        sBPovTeDZuncDOL5A0A1pROpidRxOMHDKNItT7POmhMUHeCW5DS7An/RIBLaP4ZGetRfiSo2BBUre
        OvblY9ZV7SrCIJnIZiR/Pwj0UeTkDQP7goSGyJCZSBcgqpII2AEUFuNQk7T09VsR8/IkelBMOxCY/
        Wd1bzGe8JrWFhHVd75XJh6D1vpk3MUZtpZJ3WCiKGr0w4a+CE3jlY6l4NQLHxiFbdCgANsxLTqMm8
        QQMGWAAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1myCf6-00Gh52-Aa; Fri, 17 Dec 2021 12:48:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A0463000E6;
        Fri, 17 Dec 2021 13:48:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB0F426713FE3; Fri, 17 Dec 2021 13:48:35 +0100 (CET)
Date:   Fri, 17 Dec 2021 13:48:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bill Wendling <morbo@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>, llvm@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: use builtins to read eflags
Message-ID: <YbyHIxIvsisEtfr8@hirez.programming.kicks-ass.net>
References: <20211215211847.206208-1-morbo@google.com>
 <87mtl1l63m.ffs@tglx>
 <CAGG=3QV2sw1w+j2NDqPVAbobGj04QXfOF0VcSCebRbs6y-L5WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=3QV2sw1w+j2NDqPVAbobGj04QXfOF0VcSCebRbs6y-L5WA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 11:55:12AM -0800, Bill Wendling wrote:
> On Wed, Dec 15, 2021 at 4:57 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Bill,
> >
> > On Wed, Dec 15 2021 at 13:18, Bill Wendling wrote:
> >
> > please always CC the relevant mailing lists, i.e. this lacks a cc:
> > linux-kernel@vger.kernel.org
> >
> I thought that was automatically added. But as Peter pointed out in
> another email thread, no one has time to read the LKML, so it seems a
> bit pointless? Nonetheless it's added now.

It is archived and really handy for future references. If/when needed etc..
