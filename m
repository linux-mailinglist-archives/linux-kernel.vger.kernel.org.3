Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBF64DB48F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242953AbiCPPOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358124AbiCPPOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:14:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD61D10FC2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 08:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4K5R+UfTKpVmh7UUCsHxGMmZro1+3YPGLK6keFmVP14=; b=TDx4HFP9PrQw1jlnpndtpf5frp
        iwil/n7t0o164xeIsotgbG7Fl+FyEwNLS/b4LYaXqq0y/P1rscYncYw5N3Bm1BVVyHiNh1eCKWLtI
        z0Vy0qRWzsR0zRRPb+LabGFC+e3Mb4Gk/lf1eLAS95+BTEYOq8zyGIz4GWLHkNzgmzzLlVHMhWFHs
        hoTU/ZpM+6q5rhqmeSuM3GOiB1mSojmhK7xfl+FBIZf2xFHwBZQkf5l0NWEpo7CEPwAPkqQUADvIW
        lhth3wrudKygesyRMPURgmRGtJjHEthSloyh5JwIZBlXNfBjcUnGNLBI/7yjEUdrYjKWwUsF2FGY0
        NwmC4FIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUVKe-001Zjn-O0; Wed, 16 Mar 2022 15:13:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 64F2930021B;
        Wed, 16 Mar 2022 16:13:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 533A93040066C; Wed, 16 Mar 2022 16:13:00 +0100 (CET)
Date:   Wed, 16 Mar 2022 16:13:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH V3 0/7] x86/entry: Clean up entry code
Message-ID: <YjH+fAaH5yHGrxRu@hirez.programming.kicks-ass.net>
References: <20220315073949.7541-1-jiangshanlai@gmail.com>
 <YjH+VdHIiHZM3maD@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjH+VdHIiHZM3maD@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 04:12:21PM +0100, Peter Zijlstra wrote:
> On Tue, Mar 15, 2022 at 03:39:42PM +0800, Lai Jiangshan wrote:
> 
> > Lai Jiangshan (7):
> >   x86/entry: Use idtentry macro for entry_INT80_compat
> >   x86/traps: Move pt_regs only in fixup_bad_iret()
> >   x86/entry: Switch the stack after error_entry() returns
> >   x86/entry: move PUSH_AND_CLEAR_REGS out of error_entry
> >   x86/entry: Move cld to the start of idtentry
> >   x86/entry: Don't call error_entry for XENPV
> >   x86/entry: Convert SWAPGS to swapgs and remove the definition of
> >     SWAPGS
> 
> So AFAICT these patches are indeed correct.
> 
> I do however worry a little bit about the I$ impact of patch 4, and
> there's a few niggles, but otherwise looks good.
> 
> I'd love for some of the other x86 people to also look at this, but a
> tentative ACK on this.
> 

Also, I forgot to mention; they no longer apply cleanly because I
sprinked ENDBR all over the place. Mostly trivial to fixup though.
