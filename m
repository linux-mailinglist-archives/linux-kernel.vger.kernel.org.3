Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207CE4BC1C7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239658AbiBRVVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:21:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238704AbiBRVVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:21:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738F89F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ipqDGX0Ipb0izMfhsY1IIHhii55xSCNUzg/jdL11qHM=; b=ir+lGUKIH1TDOtxVxg1JggDWTn
        RfL+mc+eg2LX+GJq67KAC+ulGJmaDrnWeImIYdWt1kbr0rK+XKoKOTenx4w8JmFi8UkHrAAtmI4Fb
        sCDFShPnMdn+MSH2gH9l3MuXIhfYlR1aKgAOoNldD34dmG4QT/6dNBOtTVf0dO2ibDJiZdwumyI6E
        0+ifMm7ryQtdFKsKkk0yIGtEzC4BNbriRjQit0Xt0HNfuq7y9ibXok/FPbFzZzAsLjhYEYLppnlPG
        qvdgbLDlOT0m9Amsdwdaqq4xW2EF0rxBDzgOEzhnv7gB1CSyg+vl3VBgWtWNJeAF2qeSQNu46YKGx
        HFXPP9wQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLAgi-00GxEK-De; Fri, 18 Feb 2022 21:21:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ADC9F300478;
        Fri, 18 Feb 2022 22:21:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F1272BCA7EBB; Fri, 18 Feb 2022 22:21:11 +0100 (CET)
Date:   Fri, 18 Feb 2022 22:21:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 05/29] x86: Base IBT bits
Message-ID: <YhANx8ysGKXWBD3B@hirez.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <20220218171408.867389898@infradead.org>
 <20220218211451.6h6gdlbnnuxhhati@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218211451.6h6gdlbnnuxhhati@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 01:14:51PM -0800, Josh Poimboeuf wrote:
> On Fri, Feb 18, 2022 at 05:49:07PM +0100, Peter Zijlstra wrote:
> > +#ifdef CONFIG_X86_64
> > +#define ASM_ENDBR	"endbr64\n\t"
> > +#else
> > +#define ASM_ENDBR	"endbr32\n\t"
> > +#endif
> 
> Is it safe to assume all supported assemblers know this instruction?

I was hoping the answer was yes, given CC_HAS_IBT.
