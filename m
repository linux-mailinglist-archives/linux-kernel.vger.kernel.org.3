Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3502515BA5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 11:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382387AbiD3JF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 05:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382390AbiD3JFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 05:05:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D91527D0;
        Sat, 30 Apr 2022 02:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=iBnV4BkP5XE7j8/bHDZPth3sjqyHE93A1brAIaxH/rg=; b=IJMwzSNyCZKTtgb4cyzEMxr84M
        Ez+oQK7GJyHGk54jRGjCYc9u4Im5XGW4yGMPK3Wm8/tfZAhgaPfCTavOwcYii4HLBT9yxL3FR/43i
        ywIhOGB+CgjGWVrYNyfFaXhBemdXk1N2tRo8uVFOcPGPDfSe1en29+zVYKg7L15K6Y7Oly/U5u7Nk
        IE4G+PTDiBzdA2HVooWo3uQNflAh6yo0xzY0pHYrCy9H6M7C2fWycu9kIwbzLC3gJkm3X0FyuYZMD
        UnpMzct8F/rmtGmgO8l/9J/bISQlIDTEGkb+Hf+6ZlwZCowCmgaa31gINJ6X5a/GOhF+thgIJQtYg
        b1vltvWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkizQ-009sJC-9L; Sat, 30 Apr 2022 09:02:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC8F8300473;
        Sat, 30 Apr 2022 11:02:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 96E142028EFE6; Sat, 30 Apr 2022 11:02:05 +0200 (CEST)
Date:   Sat, 30 Apr 2022 11:02:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH 00/21] KCFI support
Message-ID: <Ymz7DWkRJy3PMaHm@hirez.programming.kicks-ass.net>
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <202204291545.47C6A97EA2@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202204291545.47C6A97EA2@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 03:53:12PM -0700, Kees Cook wrote:
> On Fri, Apr 29, 2022 at 01:36:23PM -0700, Sami Tolvanen wrote:
> > KCFI is a proposed forward-edge control-flow integrity scheme for
> > Clang, which is more suitable for kernel use than the existing CFI
> > scheme used by CONFIG_CFI_CLANG. KCFI doesn't require LTO, doesn't
> > alter function references to point to a jump table, and won't break
> > function address equality.
> 
> 🎉 :)
> 
> > The latest LLVM patches are here:
> > 
> >   https://reviews.llvm.org/D119296
> >   https://reviews.llvm.org/D124211
> > 
> > [...]
> > To test this series, you'll need to compile your own Clang toolchain
> > with the patches linked above. You can also find the complete source
> > tree here:
> > 
> >   https://github.com/samitolvanen/llvm-project/commits/kcfi-rfc
> 
> And note that this RFC is seeking to break a bit of a circular dependency
> with regard to the design of __builtin_kcfi_call_unchecked (D124211
> above), as the implementation has gone around a few times in review within
> LLVM, and we want to make sure that kernel folks are okay with what was
> settled on. If there are no objections on the kernel side, then we can
> land the KCFI patches, as this is basically the only remaining blocker.

So aside from the static_call usage, was there any other?

Anyway, I think I hate that __builtin, I'd *much* rather see a variable
attribute or qualifier for this, such that one can mark a function
pointer as not doing CFI.

I simply doesn't make sense to have a builtin that operates on an
expression. The whole thing is about indirect calls, IOW function
pointers.
