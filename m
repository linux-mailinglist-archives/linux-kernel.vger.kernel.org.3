Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331275293B1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 00:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349705AbiEPWif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbiEPWid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:38:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C9B3EA81
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:38:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BEA85CE16E0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 22:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5B1C385B8;
        Mon, 16 May 2022 22:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652740708;
        bh=in1Km6RSLomipU4gTgXzsU0c+0UDtzLUVm/5QFxXPAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q44gTyJitNhYGT9BlIj0tHJ0AOrWd2jqV2H4o5SUez1iPGy874golGzim6ifaqXv+
         d6Cc3ob6UDv9GTtQgPI3epkH5Jqg38BCcMzM+wYGEglRk8al8id+Mzm3EaVzhO7v4D
         UIcR5nj/qqVGmAngKpjx3hKiOv87aIZTroYai92stRrITsuWgGoke2m+M6fse4iMlC
         Ud5PSYy5Ue9h2Fbc16jMRwa0mBA/mFPA3QWJUTD2InbZ2cNzqXQAw61gHobcCnaVHO
         zXmt3WrStPg3aQPQuUosI29qbOzoWec1D916+VMbK0GJ8QMwzu9wf5xsm1MOtRHqwN
         MmN+NzdlMPC6A==
Date:   Mon, 16 May 2022 15:38:25 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] riscv: Move alternative length validation into subsection
Message-ID: <YoLSYSmLV0+7Pcqa@dev-arch.thelio-3990X>
References: <20220516214520.3252074-1-nathan@kernel.org>
 <2827138.e9J7NaK4W3@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2827138.e9J7NaK4W3@diego>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Mon, May 16, 2022 at 11:55:47PM +0200, Heiko Stübner wrote:
> Hi,
> 
> Am Montag, 16. Mai 2022, 23:45:21 CEST schrieb Nathan Chancellor:
> > After commit 49b290e430d3 ("riscv: prevent compressed instructions in
> > alternatives"), builds with LLVM's integrated assembler fail:
> 
> the commit in question didn't change anything there, so I guess
> the issue itself was present before that already and the
> commit only triggered the different buildbots?

Sort of. I am not super knowledgeable on the internals of LLVM's
integrated assembler but as far as I understand it, the use of the
'.option' directive creates a new fragment within this subsection, which
messes up the integrated assembler's ability to resolve the differences
between these labels outside of the subsection. Moving the directives
into the subsection allows it to do this. So your patch did not really
do anything wrong, it just exposed existing brittleness (hence why I
did not add a Fixes tag).

> >   In file included from arch/riscv/mm/init.c:10:
> >   In file included from ./include/linux/mm.h:29:
> >   In file included from ./include/linux/pgtable.h:6:
> >   In file included from ./arch/riscv/include/asm/pgtable.h:108:
> >   ./arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
> >           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
> >           ^
> >   ./arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
> >   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
> >       ^
> >   ./arch/riscv/include/asm/alternative-macros.h:187:2: note: expanded from macro 'ALTERNATIVE'
> >           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
> >           ^
> >   ./arch/riscv/include/asm/alternative-macros.h:113:2: note: expanded from macro '_ALTERNATIVE_CFG'
> >           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
> >           ^
> >   ./arch/riscv/include/asm/alternative-macros.h:110:2: note: expanded from macro '__ALTERNATIVE_CFG'
> >           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
> >           ^
> >   ./arch/riscv/include/asm/alternative-macros.h:99:3: note: expanded from macro 'ALT_NEW_CONTENT'
> >           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
> >            ^
> >   <inline asm>:26:6: note: instantiated into assembly here
> >   .org    . - (889b - 888b) + (887b - 886b)
> >           ^
> > 
> > This error happens because LLVM's integrated assembler has a one-pass
> > design, which means it cannot figure out the instruction lengths when
> > the .org directive is outside of the subsection that contains the
> > instructions, which was changed by the .option directives added by the
> > above change.
> > 
> > Move the .org directives before the .previous directive so that these
> > directives are always within the same subsection, which resolves the
> > failures and does not introduce any new issues with GNU as. This was
> > done for arm64 in commit 966a0acce2fc ("arm64/alternatives: move length
> > validation inside the subsection") and commit 22315a2296f4 ("arm64:
> > alternatives: Move length validation in alternative_{insn, endif}").
> > 
> > While there is no error from the assembly versions of the macro, they
> > appear to have the same problem so just make the same change there as
> > well so that there are no problems in the future.
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1640
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> In any case, on my svpbmt testcases (qemu + d1-nezha):
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
> Thanks for looking into that
> Heiko

Thank you a lot for the quick testing and review!

Cheers,
Nathan

> > ---
> >  arch/riscv/include/asm/alternative-macros.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
> > index e13b1f6bb400..ec2f3f1b836f 100644
> > --- a/arch/riscv/include/asm/alternative-macros.h
> > +++ b/arch/riscv/include/asm/alternative-macros.h
> > @@ -27,9 +27,9 @@
> >  	\new_c
> >  	.option pop
> >  889 :
> > -	.previous
> >  	.org    . - (889b - 888b) + (887b - 886b)
> >  	.org    . - (887b - 886b) + (889b - 888b)
> > +	.previous
> >  	.endif
> >  .endm
> >  
> > @@ -94,9 +94,9 @@
> >  	new_c "\n"							\
> >  	".option pop\n"							\
> >  	"889 :\n"							\
> > -	".previous\n"							\
> >  	".org	. - (887b - 886b) + (889b - 888b)\n"			\
> >  	".org	. - (889b - 888b) + (887b - 886b)\n"			\
> > +	".previous\n"							\
> >  	".endif\n"
> >  
> >  #define __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, enable)	\
> > 
> > base-commit: 93c0651617a62a69717299f1464dda798af8bebb
> > 
> 
> 
> 
> 
