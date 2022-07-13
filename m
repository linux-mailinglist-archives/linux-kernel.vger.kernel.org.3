Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09BE573380
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbiGMJvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbiGMJvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:51:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3969F8979
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iu/Gvbn1zK0U1w4KjsahsWiWxBTvbHb4Y4IJVd8CDks=; b=CMZSyjYu2liUqwCCJQQR5lsAaa
        urxcvfXDlInV5XsxRX9DIUJAe/VE6kxRBzApADSHI2/N5sz8tTCvqRiJ7/an9jEXWwvYRCWJmVlOo
        625Ill+RuC28ZZzbUJYvUHKMjawVD0jeAoS6AflBqhW4UHE9T6SshLJ1MVpUIAABDljNgiN669VRw
        uICAwiBHSYnL6SogTEQI7YUZdBKukBWR8GXcOxkgLJVTaXGen5/FN+J7fBtqNu4q0WLxcc7NJtQ6X
        kC4Cgoh04IXmwzljN+oNCJ4ycWHajmlSWWh9wmq6hemQ9rf0T6qbmezZIeFQsgGqmDZnEYlaptSQO
        onJZpPMg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBZ1A-0081TJ-Ev; Wed, 13 Jul 2022 09:50:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 724993000D5;
        Wed, 13 Jul 2022 11:50:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 55E12201ECFBD; Wed, 13 Jul 2022 11:50:50 +0200 (CEST)
Date:   Wed, 13 Jul 2022 11:50:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: UNTRAIN_RET in native_irq_return_ldt
Message-ID: <Ys6VeoAtKeCyZGOq@hirez.programming.kicks-ass.net>
References: <35b0d50f-12d1-10c3-f5e8-d6c140486d4a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35b0d50f-12d1-10c3-f5e8-d6c140486d4a@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 08:20:44PM +0200, Alexandre Chartre wrote:
> 
> Hi,
> 
> I think there is an issue in native_irq_return_ldt: UNTRAIN_RET is used and can
> clobber %rax which is expected to be the user rax.

and cx and dx..

> A simple fix would be to preserve %rax:
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index a4ba162e52c3..f1fe05289d84 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -728,7 +728,11 @@ native_irq_return_ldt:
>         pushq   %rdi                            /* Stash user RDI */
>         swapgs                                  /* to kernel GS */
>         SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi   /* to kernel CR3 */
> +
> +       /* UNTRAIN_RET can clobber %rax, so preserve it */
> +       movq    %rax, %rdi
>         UNTRAIN_RET
> +       movq    %rdi, %rax
>         movq    PER_CPU_VAR(espfix_waddr), %rdi
>         movq    %rax, (0*8)(%rdi)               /* user RAX */
> 

Which still leaves cx and dx scrambled.

> But I wonder if we really need to use UNTRAIN_RET in native_irq_return_ldt because
> I think we reach this point from the kernel after untrain has already be done,
> and it looks like we don't do ret afterward (the code just fixup the stack and
> then iret).

Yes, I think removing it is fine, the objtool unret validation also
doesn't complain about it not being there (I really should have written
that validation before doing these patches, not after, oh well).
