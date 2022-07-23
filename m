Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686DD57EF04
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 13:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbiGWLWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 07:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiGWLWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 07:22:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E893DF1F;
        Sat, 23 Jul 2022 04:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dcy6i7FRX4l5Gbr0LDQ+gwpAZaDUrfwf4W+C0zpF9zY=; b=XzjWAAubT+U3O39VOBD7COtuQo
        AOf9QP0iEkwskFRAAfV1kC1nLpuLSrszaEmxvEeuo990Q9Rq+UeITy/5G3WtlRuF3o3qfYIaeBMg8
        9b5IqKho5Nsp9pHrndUHstA+vAhdW1N4gLtDFYGzSWhrW3sU3ksbV2hW7dZIE0Iu9SxnUXBsl96L8
        WFOii/NhiO75NBOK1USoyAuejuWJw3374X7yUQfbvIaXOw3TUiA0GdfGvKdhdb5ECmh2wiG090taA
        8/54Ml179UxlGL7PyBjGIsxgu0iY+y8jASEmQaQtaWopJWnfSFOefldSo6UcC/yzTB650j52dVspG
        6LSRR++A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oFDCR-0067Mf-Ps; Sat, 23 Jul 2022 11:21:36 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 01AA898016F; Sat, 23 Jul 2022 13:21:33 +0200 (CEST)
Date:   Sat, 23 Jul 2022 13:21:33 +0200
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
Subject: Re: [RFC PATCH v3 20/20] x86: Add support for CONFIG_CFI_CLANG
Message-ID: <YtvZvYHC1BKzEz1p@worktop.programming.kicks-ass.net>
References: <20220610233513.1798771-1-samitolvanen@google.com>
 <20220610233513.1798771-21-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610233513.1798771-21-samitolvanen@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 04:35:13PM -0700, Sami Tolvanen wrote:

> +#ifdef CONFIG_CFI_CLANG
> +#define __CFI_TYPE(name)					\
> +	.fill 7, 1, 0xCC ASM_NL					\
> +	SYM_START(__cfi_##name, SYM_L_LOCAL, SYM_A_NONE)	\
> +	int3 ASM_NL						\
> +	int3 ASM_NL						\
> +	mov __kcfi_typeid_##name, %eax ASM_NL			\
> +	int3 ASM_NL						\
> +	int3 ASM_NL						\
> +	SYM_FUNC_END(__cfi_##name)
> +#endif

Like said on IRC yesterday, this doesn't generate the right mov
encoding.

	.byte 0xb8 ; .long __kcfi_typeid_##name ;		\

works. Your LLVM tree already has the ZExt patch you gave me yesterday
to fix up the linker fallout from this change.
