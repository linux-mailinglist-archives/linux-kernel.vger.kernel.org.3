Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2843C4EB76B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 02:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241437AbiC3AXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 20:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbiC3AXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 20:23:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69255171EF9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 17:21:34 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g9-20020a17090ace8900b001c7cce3c0aeso498861pju.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 17:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=7iLxch5y6RIgvR/T0zWqMEJ+cpUfEurleqixAHzR59g=;
        b=d6l2S7X6ubR/3qtqSf1gEAmewrLprB360r1t8kyD8au6PP6Uw3qtG3LFOeEsaJuH0a
         Uosk+2PV7kD+ZX41oUKqASL7vtobWwWbrZJvt2qsw6/kKgMSkxy7Lq84FNozbqUYHRO2
         YT7MYq8O8bUwbqTIN42fVMirVmIwOvEoQttWZbrfSjMBhzCfXvgLFxOX3i4/k5Nw+6KK
         rKsSsKvqZokfFUXKFzNJtCqZW7J1WLvA9xJaPpccQmHui9c8uOmKXzNTQKgFMa987eml
         aZ6D+6PIJZayCZT3qTHhE0yfQFYCmZ2Z+gfvHJDE1AtWZQKN3bGIedg0RDDF8j4CozAR
         cRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=7iLxch5y6RIgvR/T0zWqMEJ+cpUfEurleqixAHzR59g=;
        b=yoMaXqyVmtLtHTgSDcDeMtfgku2/9wrxreFrZ54dXEoyt0RPo2F7U7kCz7+yUekcjS
         d55KXLdtHRQ81ruO65DMFyxuCXRjNARPPUnGAv52k2wSUOFcwjWdgu5b6sPsQtoGyJzH
         ldSN4Fb73WrAMXVQ4Mn/ss04Yi3jl6jQSSZyYAR8VnXSd3Je7Bi6PPV2giLa2E/F6WOG
         Ko4gVT47fQhsJxRTI4WaFqlWJrE/Wt50CpWsWH3lKsbeIplgdfpLHlRLhZLLcgwieW0L
         HlOI0MVozAm+zxcFVw+WyzNNES3g0fM50nDoXqbmvkTbVDMvCJCh7rxhgooEX7tLbXx4
         WgyA==
X-Gm-Message-State: AOAM531mtuM3idE0TynHUfXlZe4XcRt2HhsANF41iN8+k6lbSCqzg9I7
        3dgM+NgL9ZLxG7b24iMwaARq1w==
X-Google-Smtp-Source: ABdhPJxEvni5Sq3KIcfnKaN2LY52DfkeM+nZCKa8T5kJ161E/ZTfTMkikxIcAWzUNAuNKmyxa8oPgw==
X-Received: by 2002:a17:902:7205:b0:156:1a0a:2c39 with SMTP id ba5-20020a170902720500b001561a0a2c39mr9686710plb.88.1648599693682;
        Tue, 29 Mar 2022 17:21:33 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p15-20020a056a000a0f00b004f7c63cba5asm21702403pfh.21.2022.03.29.17.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 17:21:32 -0700 (PDT)
Date:   Tue, 29 Mar 2022 17:21:32 -0700 (PDT)
X-Google-Original-Date: Tue, 29 Mar 2022 14:36:59 PDT (-0700)
Subject:     Re: [PATCH v2] riscv module: remove (NOLOAD)
In-Reply-To: <20220322012617.3517297-1-maskray@google.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, nathan@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        maskray@google.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     maskray@google.com
Message-ID: <mhng-891192a6-d537-444f-b092-5ae92620b233@palmer-mbp2014>
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

On Mon, 21 Mar 2022 18:26:17 PDT (-0700), maskray@google.com wrote:
> On ELF, (NOLOAD) sets the section type to SHT_NOBITS[1]. It is conceptually
> inappropriate for .plt, .got, and .got.plt sections which are always
> SHT_PROGBITS.
>
> In GNU ld, if PLT entries are needed, .plt will be SHT_PROGBITS anyway
> and (NOLOAD) will be essentially ignored. In ld.lld, since
> https://reviews.llvm.org/D118840 ("[ELF] Support (TYPE=<value>) to
> customize the output section type"), ld.lld will report a `section type
> mismatch` error (later changed to a warning). Just remove (NOLOAD) to
> fix the warning.
>
> [1] https://lld.llvm.org/ELF/linker_script.html As of today, "The
> section should be marked as not loadable" on
> https://sourceware.org/binutils/docs/ld/Output-Section-Type.html is
> outdated for ELF.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1597
> Fixes: ab1ef68e5401 ("RISC-V: Add sections of PLT and GOT for kernel module")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Fangrui Song <maskray@google.com>
> ---
>  arch/riscv/include/asm/module.lds.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/module.lds.h b/arch/riscv/include/asm/module.lds.h
> index 4254ff2ff049..1075beae1ac6 100644
> --- a/arch/riscv/include/asm/module.lds.h
> +++ b/arch/riscv/include/asm/module.lds.h
> @@ -2,8 +2,8 @@
>  /* Copyright (C) 2017 Andes Technology Corporation */
>  #ifdef CONFIG_MODULE_SECTIONS
>  SECTIONS {
> -	.plt (NOLOAD) : { BYTE(0) }
> -	.got (NOLOAD) : { BYTE(0) }
> -	.got.plt (NOLOAD) : { BYTE(0) }
> +	.plt : { BYTE(0) }
> +	.got : { BYTE(0) }
> +	.got.plt : { BYTE(0) }
>  }
>  #endif

Thanks, this is on for-next (it'd be OK for fixes as well, but it's the 
merge window so I'm just on one branch).
