Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D24251C6AD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382965AbiEESG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382959AbiEESGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:06:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04B0D53E32;
        Thu,  5 May 2022 11:03:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDD20106F;
        Thu,  5 May 2022 11:03:14 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.38.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0C0E3FA31;
        Thu,  5 May 2022 11:03:12 -0700 (PDT)
Date:   Thu, 5 May 2022 19:03:08 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev
Subject: Re: [RFC PATCH 10/21] treewide: Drop function_nocfi
Message-ID: <YnQRXCqBW/Ggu3pc@FVFF77S0Q05N.cambridge.arm.com>
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <20220429203644.2868448-11-samitolvanen@google.com>
 <YnP7j+miotxYM6fu@FVFF77S0Q05N.cambridge.arm.com>
 <CABCJKue6c0FMpKXysdoT0Lc+RBqGFhp52iM03tttWwRv7CZr5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKue6c0FMpKXysdoT0Lc+RBqGFhp52iM03tttWwRv7CZr5w@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 09:51:39AM -0700, Sami Tolvanen wrote:
> On Thu, May 5, 2022 at 9:30 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > I also believe that in most cases we can drop the __nocfi annotation on callers
> > now that we can mark the called assembly function with SYM_TYPED_FUNC_START().
> 
> Good point, thanks for pointing that out. I'll add these to the next
> version of the series.

Also, I *think* we can drop __nocfi from __init, and always check calls to
functions in .init.text. IIUC we made those __nocfi because it leads to section
mismatches, and dangling entries in the jump tables after we discarded the init
text, neither of which should be a problem with kCFI.

Unfortuantely, that appears to be masking some existing type mismatches; e.g.
psci_dt_init() blows up because it uses the wrong type for its callees (a
mismatched `const`). With that fixed up, arm64 boots fine.

> > There' a latent bug here with the existing CFI scheme, since
> > `kpti_install_ng_mappings` isn't marked with __nocfi, and should explode when
> > calling `idmap_kpti_install_ng_mappings` via the idmap.
> 
> The CONFIG_UNMAP_KERNEL_AT_EL0 version of kpti_install_ng_mappings is
> marked __nocfi

Ah, so it is. Sorry for the noise!

> > There' a latent bug here with the existing CFI scheme, since
> > `machine_kexec` isn't marked with __nocfi, and should explode when calling
> > `cpu_soft_restart` via the idmap.
> 
> But it's indeed missing from this one.

Cool; I'll prep a patch that fixes just this, then.

Thanks,
Mark.
