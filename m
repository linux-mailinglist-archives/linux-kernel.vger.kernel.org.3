Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891AF55E066
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239805AbiF0MFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239790AbiF0ME5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:04:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4E612D0A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:01:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E68CB81063
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01681C3411D;
        Mon, 27 Jun 2022 12:00:57 +0000 (UTC)
Date:   Mon, 27 Jun 2022 13:00:54 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, Will Deacon <will@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 7/8] x86: Expose untagging mask in
 /proc/$PID/arch_status
Message-ID: <Yrmb9gvd4KsIPy/b@arm.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-8-kirill.shutemov@linux.intel.com>
 <144af1ab-1e7e-b75c-331c-d9c2e55b9062@intel.com>
 <20220611012830.hs437yikbjgwlije@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611012830.hs437yikbjgwlije@black.fi.intel.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

Sorry, this fell through the cracks (thanks to Will for reminding me).

On Sat, Jun 11, 2022 at 04:28:30AM +0300, Kirill A. Shutemov wrote:
> On Fri, Jun 10, 2022 at 08:24:38AM -0700, Dave Hansen wrote:
> > On 6/10/22 07:35, Kirill A. Shutemov wrote:
> > > +/*
> > > + * Report architecture specific information
> > > + */
> > > +int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
> > > +			struct pid *pid, struct task_struct *task)
> > > +{
> > > +	/*
> > > +	 * Report AVX512 state if the processor and build option supported.
> > > +	 */
> > > +	if (cpu_feature_enabled(X86_FEATURE_AVX512F))
> > > +		avx512_status(m, task);
> > > +
> > > +	seq_printf(m, "untag_mask:\t%#lx\n", mm_untag_mask(task->mm));
> > > +
> > > +	return 0;
> > > +}
> > 
> > Arch-specific gunk is great for, well, arch-specific stuff.  AVX-512 and
> > its, um, "quirks", really won't show up anywhere else.  But x86 isn't
> > even the first to be doing this address tagging business.
> > 
> > Shouldn't we be talking to the ARM folks about a common way to do this?
> 
> + Catalin, Will.
> 
> I guess we can expose the mask via proc for ARM too, but I'm not sure if
> we can unify interface further without breaking existing TBI users: TBI is
> enabled per-thread while LAM is per-process.

Hardware TBI is enabled for all user space at boot (it was like this
form the beginning). The TBI syscall interface is per-thread (TIF flag)
but it doesn't change any hardware behaviour. The mask is fixed in
hardware, unchangeable. I'm fine with reporting an untag_mask in a
common way, only that setting it won't be possible on arm64.

If arm64 ever gains support for a modifiable untag_mask, it's a good
chance it would be per mm as well since the controls for TBI are per
page table.

-- 
Catalin
