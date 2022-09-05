Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B71A5AD4D3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbiIEOa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237386AbiIEOa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:30:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502DE252BF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gxQZxrz6/Rmgmd2QHgOZBnPfQnJH2I/vdis+B00Izpw=; b=H8IdYE3vM9OygIjH6gEddeQqWy
        wURL43ZQ8U8kNWUwDEejjJPrHRXxZ3ggxQZHq4KAiC+aNGO6znvPOaVK763MokIv2Ymd7//zyP9vk
        ypyMIL2g+qmFvJseRroyyJoznSlSMDojJqRhjwfuaCh0CJ9F7+51GyIP2KQjgLo0SQWPq47nRXjoP
        r7aJklZmeKbW9hwHotZwKhDj0LwH/PIPGyD7nJUOap0F/vQX583rwsco63KLWhQEF4GOog+upEduo
        0vzd96rSxr2J8B1Y6LLoChzTkeZtXn0POrp7MciofPpcZGGELp+yWmQXIECm7c/6LnGkIMahLSdSR
        lVUBnHwQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVD7M-009YGc-Tu; Mon, 05 Sep 2022 14:30:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8BE993002A3;
        Mon,  5 Sep 2022 16:30:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E2032B954D28; Mon,  5 Sep 2022 16:30:25 +0200 (CEST)
Date:   Mon, 5 Sep 2022 16:30:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Bharata B Rao <bharata@amd.com>, ananth.narayan@amd.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <YxYIAVx2qJLMDJlC@hirez.programming.kicks-ass.net>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
 <20220904010001.knlcejmw4lg2uzy3@box.shutemov.name>
 <64519d0b-b696-db47-52c2-303451e10c09@amd.com>
 <20220905134457.a2f7uluq42frsgwe@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905134457.a2f7uluq42frsgwe@box.shutemov.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 04:44:57PM +0300, Kirill A. Shutemov wrote:
> On Mon, Sep 05, 2022 at 10:35:44AM +0530, Bharata B Rao wrote:
> > Hi Kirill,
> > 
> > On 9/4/2022 6:30 AM, Kirill A. Shutemov wrote:
> > > On Tue, Aug 30, 2022 at 04:00:53AM +0300, Kirill A. Shutemov wrote:
> > >> Linear Address Masking[1] (LAM) modifies the checking that is applied to
> > >> 64-bit linear addresses, allowing software to use of the untranslated
> > >> address bits for metadata.
> > >>
> > >> The patchset brings support for LAM for userspace addresses. Only LAM_U57 at
> > >> this time.
> > >>
> > >> Please review and consider applying.
> > >>
> > >> git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
> > > 
> > > +Bharata, Ananth.
> > > 
> > > Do you folks have any feedback on the patchset?
> > > 
> > > Looks like AMD version of the tagged pointers feature does not get
> > > traction as of now, but I want to be sure that the interface introduced
> > > here can be suitable for your future plans.
> > > 
> > > Do you see anything in the interface that can prevent it to be extended to
> > > the AMD feature?
> > 
> > The arch_prctl() extensions is generic enough that it should be good.
> > 
> > The untagged_addr() macro looks like this from one of the callers:
> > 
> >         start = untagged_addr(mm, start);
> > ffffffff814d39bb:       48 8b 8d 40 ff ff ff    mov    -0xc0(%rbp),%rcx
> > ffffffff814d39c2:       48 89 f2                mov    %rsi,%rdx
> > ffffffff814d39c5:       48 c1 fa 3f             sar    $0x3f,%rdx
> > ffffffff814d39c9:       48 0b 91 50 03 00 00    or     0x350(%rcx),%rdx
> > ffffffff814d39d0:       48 21 f2                and    %rsi,%rdx
> > ffffffff814d39d3:       49 89 d6                mov    %rdx,%r14
> > 
> > Can this overhead of a few additional instructions be removed for
> > platforms that don't have LAM feature? I haven't measured how much
> > overhead this effectively contributes to in real, but wonder if it is
> > worth optimizing for non-LAM platforms.
> 
> I'm not sure how the optimization should look like. I guess we can stick
> static_cpu_has() there, but I'm not convinced that adding jumps there will
> be beneficial.

I suppose the critical bit is the memory load. That can stall and then
you're sad. A jump_label is easy enough to add.
