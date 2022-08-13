Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20D8591C6D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 21:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbiHMTmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 15:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiHMTmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 15:42:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D91ADF3E
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 12:42:33 -0700 (PDT)
Received: from zn.tnic (p2e55d27b.dip0.t-ipconnect.de [46.85.210.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 28A241EC0674;
        Sat, 13 Aug 2022 21:42:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660419748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZBaCHodZtQdoAxEcaFO06NCvHc0MdEgcdLsNN8F00i4=;
        b=VszxltkJd00ofa9SoHDpxDgAX6nJWdGuqRy7SdOA+HigNK2oZCFEVg8DPzssk6KtFdx8SF
        I7eDowNI09Jd8jSWJyiTC8DBlDawyq5eSNKiafvwdFN2I0Kw8QvD+HEz32RdZt6b+KoSxQ
        SVzVa3APC6kb3lMe1HJzsx0UlLKr3hg=
Date:   Sat, 13 Aug 2022 21:40:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/2] x86/sev: Put PSC struct on the stack in prep for
 unaccepted memory support
Message-ID: <Yvf+HnofHZ3rZ+yL@zn.tnic>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1659978985.git.thomas.lendacky@amd.com>
 <21d5d55640ee1c5d66501b9398858b6a6bd6546f.1659978985.git.thomas.lendacky@amd.com>
 <YvZPoEm6PSeoflAz@zn.tnic>
 <6d9d433f-779d-7531-02b5-382796acceef@amd.com>
 <YvZkpYRfrgPLLoJV@zn.tnic>
 <fc48ce75-7a4c-4804-92ce-71f63c2db5ea@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc48ce75-7a4c-4804-92ce-71f63c2db5ea@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 09:51:41AM -0500, Tom Lendacky wrote:
> On 8/12/22 09:33, Borislav Petkov wrote:
> > On Fri, Aug 12, 2022 at 09:11:25AM -0500, Tom Lendacky wrote:
> > > There was a whole discussion on this
> > 
> > Pointer to it?
> 
> It starts here: https://lore.kernel.org/lkml/658c455c40e8950cb046dd885dd19dc1c52d060a.1659103274.git.thomas.lendacky@amd.com/

So how come none of the rationale for the on-stack decision vs a single
buffer with a spinlock protection hasn't made it to this patch?

We need to have the reason why this thing is changed documented
somewhere.

> > So smaller, on-stack PSC but lockless is still better than a bigger one
> > but with synchronized accesses to it?

That thing.

That decision for on-stack buffer needs explaining why.

> > > Well when we don't know which GHCB is in use, using that reserved area in
> > > the GHCB doesn't help.
> > 
> > What do you mean?
> > 
> > The one which you read with
> > 
> > 	data = this_cpu_read(runtime_data);
> 
> Memory acceptance is called before the per-CPU GHCBs have been allocated
> and so you would be actually be using early boot GHCB. And that is decided
> based on the #VC handler that is invoked - but in this case we're not
> coming through the #VC handler to accept memory.

But then ghcb_percpu_ready needs to be a per-CPU variable too! Because
it is set right after snp_register_per_cpu_ghcb() which works on the
*per-CPU* GHCB.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
