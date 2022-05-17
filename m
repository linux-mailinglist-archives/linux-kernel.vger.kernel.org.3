Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D13529CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243714AbiEQIr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiEQIrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:47:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7381D43AEC;
        Tue, 17 May 2022 01:47:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5D5D1063;
        Tue, 17 May 2022 01:47:43 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.4.124])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E2EE3F73D;
        Tue, 17 May 2022 01:47:41 -0700 (PDT)
Date:   Tue, 17 May 2022 09:47:37 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH v2 08/21] psci: Fix the function type for
 psci_initcall_t
Message-ID: <YoNhKaTT3EDukxXY@FVFF77S0Q05N>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-9-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-9-samitolvanen@google.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:21:46PM -0700, Sami Tolvanen wrote:
> Functions called through a psci_initcall_t pointer all have
> non-const arguments. Fix the type definition to avoid tripping
> indirect call checks with CFI_CLANG.
> 
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

I'd prefer that we spread the `const` to each of the implementations rather
than dropping it from the type.

I have a local patch for that I can send out shortly.

Thanks,
Mark.

> ---
>  drivers/firmware/psci/psci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index cfb448eabdaa..6554bf4b8c99 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -521,7 +521,7 @@ static int __init psci_probe(void)
>  	return 0;
>  }
>  
> -typedef int (*psci_initcall_t)(const struct device_node *);
> +typedef int (*psci_initcall_t)(struct device_node *);
>  
>  /*
>   * PSCI init function for PSCI versions >=0.2
> -- 
> 2.36.0.550.gb090851708-goog
> 
