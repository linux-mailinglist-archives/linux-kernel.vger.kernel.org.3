Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB4D573D02
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbiGMTLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGMTLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:11:50 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E974F1F63D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:11:49 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso5315393pjc.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6WniWrj3ZgV51g7LWc0uoxvElrFWWSWmqIiBeCx0TGA=;
        b=ftc2b3pp6VR3l1NA92GZ1N4vRKA+MEjmtdqoxsl3Ilze+gmL3NDB39Xm1aCUdHFAve
         ViqgNdDyRFizVooQRLgGQH4tRCDVbf4YL5Uh6mby/MBunMDDoadRWmyj+YL3qrHF0ypW
         MkAabV2guUnjUXJVxtpso92ITWK0U905ay0RjCxncmkv0mJM8tDNb4SXV8BKG4ELjF+V
         lgFX2eOjqFWohepJI+Jle2fvaTfUeWje32HNTboIhc2w6V2+2S5ky6HHrX0eWNVnaMfo
         UpJP2oGxGfI7HhWKRl9gQIMdw38F9HGZxfy6d326Dhx08QkiR6O7njqSDrStBulkTbw+
         NdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6WniWrj3ZgV51g7LWc0uoxvElrFWWSWmqIiBeCx0TGA=;
        b=aaSSMc5wcWTD6BPwc2aE12frsiz/qAzd6OgI40hmrMo4KOEL/SBtW04OejysF5Wo4w
         S1DzAWwgiIIoquafTg27eLm0D5SsW4tm+PVfEORdPGUk25MZT2Y72ezwcbWbZzKgZ+Tp
         ZCVgjgDFqreyvxHElTB9ShrIvCdMXXK84JggvTmMqJwhKKR5rulR8gYlK7wNnVmOvO0w
         BeXgv4vo4YQnZ9q41hoR0brpQvNMyMGLX9M2ZSwKJ2I3t0rw/K1xCNexxUzxA8oQw22Q
         wmVwjf+SkLSEJvJ3JFjGx/DjRO/ZmixrT8ZZg98X+S2vjQuehci/Hgl7ElosaL52EejE
         68dg==
X-Gm-Message-State: AJIora/9BxdDE3TBXDFI02H4C/VqSoZiPXRw4MeD5FZMNLqKiwW+EdbQ
        Soq1Jro2aPlJ8tK32P5rOSLwwKRC2wWSx1C3y3R7Eg==
X-Google-Smtp-Source: AGRyM1s7h95SkBhPctIM6Jk4WHc6HW94JZP5f9ql2cZvctg5a76kUb6rS1bFK6/zTvkzmwLovIkP/1ZWeMRAm34h4vI=
X-Received: by 2002:a17:903:244d:b0:16c:5bfe:2e87 with SMTP id
 l13-20020a170903244d00b0016c5bfe2e87mr4671742pls.148.1657739509327; Wed, 13
 Jul 2022 12:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220713173503.3889486-1-nathan@kernel.org>
In-Reply-To: <20220713173503.3889486-1-nathan@kernel.org>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 13 Jul 2022 12:11:38 -0700
Message-ID: <CAKH8qBsTJcipS65962_hTLhpqzv42YWQpXntVkkt4RhCYubT7g@mail.gmail.com>
Subject: Re: [PATCH] bpf, arm64: Mark dummy_tramp as global
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>,
        Xu Kuohai <xukuohai@huawei.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 10:35 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> When building with clang + CONFIG_CFI_CLANG=y, the following error
> occurs at link time:
>
>   ld.lld: error: undefined symbol: dummy_tramp
>
> dummy_tramp is declared globally in C but its definition in inline
> assembly does not use .global, which prevents clang from properly
> resolving the references to it when creating the CFI jump tables.
>
> Mark dummy_tramp as global so that the reference can be properly
> resolved.
>
> Fixes: b2ad54e1533e ("bpf, arm64: Implement bpf_arch_text_poke() for arm64")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1661
> Suggested-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Stanislav Fomichev <sdf@google.com>

> ---
>  arch/arm64/net/bpf_jit_comp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index fd1cb0d2aaa6..dcc572b7d4da 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -604,6 +604,7 @@ void dummy_tramp(void);
>
>  asm (
>  "      .pushsection .text, \"ax\", @progbits\n"
> +"      .global dummy_tramp\n"
>  "      .type dummy_tramp, %function\n"
>  "dummy_tramp:"
>  #if IS_ENABLED(CONFIG_ARM64_BTI_KERNEL)
>
> base-commit: ace2bee839e08df324cb320763258dfd72e6120e
> --
> 2.37.1
>
