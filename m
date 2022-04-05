Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECB24F2CA5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 13:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbiDEJch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 05:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239502AbiDEIUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:20:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F55CE1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 01:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yTl7CnxscX3tM8Q2WvPQUxdf1oA0EUFe77KHAeexXLo=; b=guHAxSDl6KUIlPMY1ymkDtNzkp
        MSAuTErMX9PQeS+yG/hoG1AhcfFZPtqdmtXOvqnNUMaRhmQcl+1lgOKocA8nxjxYx/TLCQsLFf4QZ
        ZKjjyVPtCDHtZlzcndhBvZmStUOlGq2Iq/bagX5h7UbargEmGMfuEPRAMzdhhKTHKIBsV6LJx2Hlu
        hiWTUUHKTRtUGbt15qMEAqbY4pyc26FTuMMKm0LUwB4MhqsHUsNwsnAmHYeJn7hO4HOmCJkAA+wsN
        C+F5y6g3+d1bi6SyvKmi8oTjxJNWtVrwlzKOARg3fO4dgoKT92dGz02nVz2V9stsu/uAs1U3dNjgU
        97fbqbvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbeKa-006UbN-7s; Tue, 05 Apr 2022 08:14:28 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF2B2986B5B; Tue,  5 Apr 2022 10:14:27 +0200 (CEST)
Date:   Tue, 5 Apr 2022 10:14:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bharata B Rao <bharata@amd.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, the arch/x86 maintainers <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, shuah@kernel.org,
        Oleg Nesterov <oleg@redhat.com>, ananth.narayan@amd.com
Subject: Re: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
Message-ID: <20220405081427.GD30877@worktop.programming.kicks-ass.net>
References: <20220310111545.10852-1-bharata@amd.com>
 <6a5076ad-405e-4e5e-af55-fe2a6b01467d@www.fastmail.com>
 <b0861376-e628-06bd-713e-8837e0dc9d0b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0861376-e628-06bd-713e-8837e0dc9d0b@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 01:18:41PM +0530, Bharata B Rao wrote:
> On 3/22/2022 3:59 AM, Andy Lutomirski wrote:

> > I hate to be a pain, but I'm really not convinced that this feature
> > is suitable for Linux.  There are a few reasons:
> > 
> > Right now, the concept that the high bit of an address determines
> > whether it's a user or a kernel address is fairly fundamental to the
> > x86_64 (and x86_32!) code.  It may not be strictly necessary to
> > preserve this, but violating it would require substantial thought.
> > With UAI enabled, kernel and user addresses are, functionally,
> > interleaved.  This makes things like access_ok checks, and more
> > generally anything that operates on a range of addresses, behave
> > potentially quite differently.  A lot of auditing of existing code
> > would be needed to make it safe.
> 
> Ok got that. However can you point to me a few instances in the current
> kernel code where such assumption of high bit being user/kernel address
> differentiator exists so that I get some idea of what it takes to
> audit all such cases?

The fact that you have to ask and can't readily find them should be a
big honking clue on its own, no?

Anyway, see here:

arch/x86/events/perf_event.h:static inline bool kernel_ip(unsigned long ip)
arch/x86/events/perf_event.h:{
arch/x86/events/perf_event.h:#ifdef CONFIG_X86_32
arch/x86/events/perf_event.h:   return ip > PAGE_OFFSET;
arch/x86/events/perf_event.h:#else
arch/x86/events/perf_event.h:   return (long)ip < 0;
arch/x86/events/perf_event.h:#endif
arch/x86/events/perf_event.h:}

