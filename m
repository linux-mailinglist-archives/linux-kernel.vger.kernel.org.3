Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB73251779A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiEBT70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiEBT7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:59:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D11BC39;
        Mon,  2 May 2022 12:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mYYa7YhSPmVPESGC3WBfSUVLu7/5dL6ovKiS3tnTNxc=; b=X7JjkI1eS+hZwlLL/I9p7ec0h2
        UeIxqvrdiJt3meq6ElbsNEDYIxW+qZz/j2FrSu6coXltcfr4QtTMMPFDzslv9IR5A31jl1ddBKnH9
        c2qsGdbgoQzF9iywxqp5QHtMYcYLEB3+RVk8mUsIOTnJ93L7VRDhLz56q/kJE1S8EfyygaZ+EPJH4
        +lUKye+VxqZ8KUh1eKBescSHXrCybAweDQoUoV1TG8LbXYRpZEdQGzvMqMTJ67eTO75Z/LyqmGrAJ
        WIdEZp2LKR7NJxMrEW0UmH4MNpVWroXNW+J0b79QIxFrPP2W8RHSAR29nZiASkc9sS+Ga1qVVPW+d
        6RQX6kKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlc8m-00AZWD-7z; Mon, 02 May 2022 19:55:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 772E030017D;
        Mon,  2 May 2022 21:55:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5223120288CEB; Mon,  2 May 2022 21:55:25 +0200 (CEST)
Date:   Mon, 2 May 2022 21:55:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev
Subject: Re: [RFC PATCH 00/21] KCFI support
Message-ID: <YnA3Le2uJRaFF4TC@hirez.programming.kicks-ass.net>
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <202204291545.47C6A97EA2@keescook>
 <Ymz7DWkRJy3PMaHm@hirez.programming.kicks-ass.net>
 <CABCJKuckt75qA1op-LpkJnQsJC36m9fstbY3uD=7pET2VyyZSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKuckt75qA1op-LpkJnQsJC36m9fstbY3uD=7pET2VyyZSg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 08:22:57AM -0700, Sami Tolvanen wrote:

> > Anyway, I think I hate that __builtin, I'd *much* rather see a variable
> > attribute or qualifier for this, such that one can mark a function
> > pointer as not doing CFI.
> >
> > I simply doesn't make sense to have a builtin that operates on an
> > expression. The whole thing is about indirect calls, IOW function
> > pointers.
> 
> I also thought an attribute would be more convenient, but the compiler
> folks prefer a built-in:
> 
> https://reviews.llvm.org/D122673

That seems to mostly worry about C++ things (overload sets, template
specialization, name mangling) we kernel folks don't seem to much care
about.

I'll stick with saying type system makes more sense to me though.
