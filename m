Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA7852924E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347812AbiEPVCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349433AbiEPVBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:01:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A590457BC;
        Mon, 16 May 2022 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EbBaokCH/n+lu1lhLbT43j8JHvfW0Dz6fbZSBx6scuQ=; b=cck+N1iLqqxU1fpBU5JRS0N1B6
        eW8XgJDTLybclIC8HWUHWK+x40eUEu8VMVwSSmlyw+onOPHMk6103otDgCjr7r/gj6AxMt2JG6zUS
        FW4hJRDCt9gi/Y74jHnj0bbThZ+7LKrvpptAvCL55WgUl7ZD6jSPLOk/J4LOT4mrFcg6jtgO57sZt
        hoQHbJApaKSta71c1RKZSudOrac98MGT5V/n0coOYJFLWdl32rXWvgxWcG33eetfT5yIc3RruifoO
        ZrNvjqUXgCWB5KIdVFsLiQqcqKbl6b+c2YyIDFV+k68y0msMUu03cxyi6w0nAy8xLqVwa1jdYBQwI
        0Zpgu9bA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqhT5-00ADs8-0T; Mon, 16 May 2022 20:37:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45A20980DCC; Mon, 16 May 2022 22:37:23 +0200 (CEST)
Date:   Mon, 16 May 2022 22:37:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v2 20/21] x86: Add support for CONFIG_CFI_CLANG
Message-ID: <20220516203723.GN76023@worktop.programming.kicks-ass.net>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-21-samitolvanen@google.com>
 <YoIfWENLV1AR2ijj@hirez.programming.kicks-ass.net>
 <CABCJKucXA2jbTc9TF1mLUsEDKu52t71tzxpnsGOXY3_ks+W4Bg@mail.gmail.com>
 <20220516183047.GM76023@worktop.programming.kicks-ass.net>
 <CABCJKudmrBOkoDvDPOA-aEyrs9evHPWpzMpDZ10n8vXDBRdCxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKudmrBOkoDvDPOA-aEyrs9evHPWpzMpDZ10n8vXDBRdCxQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 12:39:19PM -0700, Sami Tolvanen wrote:

> > > With the current compiler patch, LLVM sets up function arguments after
> > > the CFI check. if it's a problem, we can look into changing that.
> >
> > Yes, please fix that. Again see that same patch for why this is a
> > problem. Objtool can trivially find retpoline calls, but finding this
> > kCFI gadget is going to be hard work. If you ensure they're
> > unconditionally stuck together, then the problem goes away find one,
> > finds the other.
> 
> You can use .kcfi_traps to locate the check right now, but I agree,
> it's not quite ideal.

Oohh, indeed. Looking at that, I think .kcfi_traps would be better as
relative offsets; eg. 'addr = (void*)s + *s' like. Halfs the amount of
storage needed for it.

Also, that code can use a few {} extra.
