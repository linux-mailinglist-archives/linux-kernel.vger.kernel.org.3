Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353AB53BB1D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbiFBOnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiFBOnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:43:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6AD1D314
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 07:43:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C28A6187A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 14:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA50C385A5;
        Thu,  2 Jun 2022 14:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654180983;
        bh=4kWjTMseHRZBI+DoHWf0Iz0RsrVG0ExhwVphkECDeXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QkYqJ9SfCLMOEcWgp/w59i9xvAktYsHjQg+lErZVTJ2szgYWIO1xjDikg8088WxZF
         dckdZBFejMjwPzVBMV+Ky0T/shh5Iy0duUpeEcIznP4GT3jnIT+LzymPfm6yCg1uua
         j2AublGX7CZa4LcjsysfXXNLHaFYFuBsW1yT4NaMy+01pGgh1enqqW1tGY7TctmKFd
         JdC0wWoqVFhJDl3ipjGcr0Z/zJ3/9O03UjQZgWoJin0SWX3CM/Lh7VxYMRXTEKgUBg
         svDa5XvlG3ir7+wuVJC7bl1T0XOFzZJrcsAHL3D4R8DRgzeVqeMNDXW9K9k959FOrz
         xldkhSt08Rt0w==
Date:   Thu, 2 Jun 2022 07:43:01 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Changbin Du <changbin.du@huawei.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, changbin.du@gmail.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Hui Wang <hw.huiwang@huawei.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: riscv: alternatives: move length validation inside the subsection
Message-ID: <YpjMdVjLzoIoSGz9@dev-arch.thelio-3990X>
References: <20220602112734.it2bzlqaismotjof@M910t>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602112734.it2bzlqaismotjof@M910t>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 07:27:34PM +0800, Changbin Du wrote:
> Apply the same fix from commit 966a0acce2fc ("arm64/alternatives: move
> length validation inside the subsection") to riscv.  Due to the one-pass
> design of LLVM's integrated assembler, it can not compute the length of
> instructions if the .org directive is outside of the subsection that these
> instructions are in.
> 
> Here is the build error reported by llvm:
> 
> In file included from ./arch/riscv/include/asm/pgtable.h:108:
> ./arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
>         ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
>         ^
> ./arch/riscv/include/asm/errata_list.h:41:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
> asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
>     ^
> ./arch/riscv/include/asm/alternative-macros.h:187:2: note: expanded from macro 'ALTERNATIVE'
>         _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
>         ^
> ./arch/riscv/include/asm/alternative-macros.h:113:2: note: expanded from macro '_ALTERNATIVE_CFG'
>         __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
>         ^
> ./arch/riscv/include/asm/alternative-macros.h:110:2: note: expanded from macro '__ALTERNATIVE_CFG'
>         ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
>         ^
> ./arch/riscv/include/asm/alternative-macros.h:98:3: note: expanded from macro 'ALT_NEW_CONTENT'
>         ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
>          ^
> <inline asm>:25:6: note: instantiated into assembly here
> .org    . - (887b - 886b) + (889b - 888b)
>         ^
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Thanks for the patch! I already sent an equivalent change two weeks ago
as https://lore.kernel.org/20220516214520.3252074-1-nathan@kernel.org/,
which I think is slightly better because it handles the __ASSEMBLY__
version of the macro as well.

Cheers,
Nathan

> ---
>  arch/riscv/include/asm/alternative-macros.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
> index e13b1f6bb400..c7d7f1945768 100644
> --- a/arch/riscv/include/asm/alternative-macros.h
> +++ b/arch/riscv/include/asm/alternative-macros.h
> @@ -94,9 +94,9 @@
>  	new_c "\n"							\
>  	".option pop\n"							\
>  	"889 :\n"							\
> -	".previous\n"							\
>  	".org	. - (887b - 886b) + (889b - 888b)\n"			\
>  	".org	. - (889b - 888b) + (887b - 886b)\n"			\
> +	".previous\n"							\
>  	".endif\n"
>  
>  #define __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, enable)	\
> -- 
> 2.26.2
> 
