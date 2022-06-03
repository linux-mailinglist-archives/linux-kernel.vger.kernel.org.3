Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E4C53C296
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240907AbiFCBew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 21:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238982AbiFCBeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 21:34:44 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26E233376
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 18:34:42 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id i185so6133478pge.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 18:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=WmOqgdw/lnzn8y98yzEspXlCbFr81s8ZPh+l/fuZnvU=;
        b=xeAlMB6iggUl/Q8oT9BpeIQvESRsiCcKlbCJYKeCd+AcQwHrX+ICmf4uTA0ijqOnhb
         hxEH8wEdkCxiO39rdJvSTuiSk+QmJah1jdSSFKYR16Vch89RSDb+rLFKgvEqB6nzM7C/
         x4GILcrRidctOmr4tvRVPSzso60xvcL3oT7C4uJfyvIcemKJ6ei+Ip1bkliuZ3M4nug4
         dLqxlSUe7qMZIQlVWMIx2+W6w0hvM/XeGRINsuZ7tlNzTFbUXJ3f2kA0S6pxoSkhCPaH
         rF4/o2im3XsBaehO8nwSNKjSVo5nSQNm5L5QqiUfKUZEs5D8sga4hDWdZOW1h9YwCAjo
         brwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=WmOqgdw/lnzn8y98yzEspXlCbFr81s8ZPh+l/fuZnvU=;
        b=uSC57xdVN0YNYtR2z17tsA9wzHqgK/vfbQhR9fYNpDhYc63aGcyOE1YSN/mLPyOu/A
         jdxAg0u26FpCM+EuX51NXeILhrXI+JeIEgtGFHgEqOXUkcLJmhWOR0XUC87e9HVCfi/z
         GiS6F1XOR9CcgXb83EfAVm1oJ2td7koGDqxFPaIh+HQdyecLsBqbQTVYY+D+x5dx+M7f
         J7WpEESuIUw5848NWa/XkDOf1JxdS2c0ImmbxFpf55euAsHhNWj+P3BnoB6jwB7XhI09
         Lm5EqoJrAH3UuMFjZ1bKi5Zq81mLLaTQa2kqjbleToQH7UYN/b8UZJxBjI+AxCeoLPh/
         Y18w==
X-Gm-Message-State: AOAM531dHEglYHH5j9P2gQMDDbrsSMr2mKP1GQk+XPKTcSQ5dkxnIvZk
        PnToEC5ZQpYFSzEVEZSjMQsHZQ==
X-Google-Smtp-Source: ABdhPJxwYUZESxzEAwVBw31/r+YLXs53IRagWzDsSQ7NAeM1zO5QT7RF2ZuUyKJXdRv88efZm8Br8Q==
X-Received: by 2002:a05:6a00:2353:b0:518:96b7:ceb8 with SMTP id j19-20020a056a00235300b0051896b7ceb8mr8062973pfj.5.1654220082298;
        Thu, 02 Jun 2022 18:34:42 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id s6-20020a170902ea0600b0016232dbd01fsm4082360plg.292.2022.06.02.18.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 18:34:41 -0700 (PDT)
Date:   Thu, 02 Jun 2022 18:34:41 -0700 (PDT)
X-Google-Original-Date: Thu, 02 Jun 2022 18:34:32 PDT (-0700)
Subject:     Re: [PATCH] riscv: Move alternative length validation into subsection
In-Reply-To: <20220516214520.3252074-1-nathan@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        ndesaulniers@google.com, heiko@sntech.de,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev, nathan@kernel.org,
        lkp@intel.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     nathan@kernel.org
Message-ID: <mhng-e4c58f1b-2015-48b1-88ae-dbb9db72643f@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022 14:45:21 PDT (-0700), nathan@kernel.org wrote:
> After commit 49b290e430d3 ("riscv: prevent compressed instructions in
> alternatives"), builds with LLVM's integrated assembler fail:
>
>   In file included from arch/riscv/mm/init.c:10:
>   In file included from ./include/linux/mm.h:29:
>   In file included from ./include/linux/pgtable.h:6:
>   In file included from ./arch/riscv/include/asm/pgtable.h:108:
>   ./arch/riscv/include/asm/tlbflush.h:23:2: error: expected assembly-time absolute expression
>           ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
>           ^
>   ./arch/riscv/include/asm/errata_list.h:33:5: note: expanded from macro 'ALT_FLUSH_TLB_PAGE'
>   asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,        \
>       ^
>   ./arch/riscv/include/asm/alternative-macros.h:187:2: note: expanded from macro 'ALTERNATIVE'
>           _ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
>           ^
>   ./arch/riscv/include/asm/alternative-macros.h:113:2: note: expanded from macro '_ALTERNATIVE_CFG'
>           __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, IS_ENABLED(CONFIG_k))
>           ^
>   ./arch/riscv/include/asm/alternative-macros.h:110:2: note: expanded from macro '__ALTERNATIVE_CFG'
>           ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
>           ^
>   ./arch/riscv/include/asm/alternative-macros.h:99:3: note: expanded from macro 'ALT_NEW_CONTENT'
>           ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
>            ^
>   <inline asm>:26:6: note: instantiated into assembly here
>   .org    . - (889b - 888b) + (887b - 886b)
>           ^
>
> This error happens because LLVM's integrated assembler has a one-pass
> design, which means it cannot figure out the instruction lengths when
> the .org directive is outside of the subsection that contains the
> instructions, which was changed by the .option directives added by the
> above change.
>
> Move the .org directives before the .previous directive so that these
> directives are always within the same subsection, which resolves the
> failures and does not introduce any new issues with GNU as. This was
> done for arm64 in commit 966a0acce2fc ("arm64/alternatives: move length
> validation inside the subsection") and commit 22315a2296f4 ("arm64:
> alternatives: Move length validation in alternative_{insn, endif}").
>
> While there is no error from the assembly versions of the macro, they
> appear to have the same problem so just make the same change there as
> well so that there are no problems in the future.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1640
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/riscv/include/asm/alternative-macros.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
> index e13b1f6bb400..ec2f3f1b836f 100644
> --- a/arch/riscv/include/asm/alternative-macros.h
> +++ b/arch/riscv/include/asm/alternative-macros.h
> @@ -27,9 +27,9 @@
>  	\new_c
>  	.option pop
>  889 :
> -	.previous
>  	.org    . - (889b - 888b) + (887b - 886b)
>  	.org    . - (887b - 886b) + (889b - 888b)
> +	.previous
>  	.endif
>  .endm
>
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
>
> base-commit: 93c0651617a62a69717299f1464dda798af8bebb

Thanks, this in on for-next (still for 5.19).  I'm going to CC stable so 
it'll get backported, as it seems pretty harmless.
