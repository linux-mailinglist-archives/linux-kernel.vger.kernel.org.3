Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299025624D9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbiF3VIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbiF3VIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:08:49 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0851319C30
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 14:08:48 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u14so253228ljh.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 14:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ZoCzbq4enWBVchP9RP44MqGpIFw4W432LhKj2F/Ovs=;
        b=JPpSnMTCb87zEzKFyOpGz0aoNzR5cYSj+hUDxxSOlkCRnvE1VRKqGctg22nrcuqCgn
         SF990zjUvZFUPM82RpA3A/N9rK/+VLjG6teSA3BXQBsljxyPYnTH2OcdRk407319vuRr
         EU7T9MGIgwjADBrCkHdDdP7YrkrZA2uvx3RCOjlqPe6tBVytl08nu2JQyv4SapqxHBBQ
         RH8m/msvnTMGSSrR+dcgX56RxtoSbrrY+UyBAR8ixv098rSIOYbXI5Bb+7dRKFCe/cfn
         9+vOCLti2oXp0AxUH8P6f/9criLrFQ/tnZUDHpTXj9wJtqSH1whhK+8AM94718jPKHJb
         s5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ZoCzbq4enWBVchP9RP44MqGpIFw4W432LhKj2F/Ovs=;
        b=6AEaFz5bqE87Pv9mX1w0MmsQFMCVFtkFmfnwn8fnDdaMXThD+sZTxF6EuSOi7CxFsC
         axaHmY4wgM+EwB16ONvZVhGT84bObDuUCZZGdGfQ09dxLuZZqrnTvxLgQpjMtQ8JlUKr
         l/mnHFXe81yw7EjLwZfX7CmaXB9LPRhg4HR038fLtlR+b+F/qcRyHRA1fCTYSHwI8Nq6
         n3fOkxaFlJOFtYK/yGJ6Tg2G8zcQcL+5NgYSpBC2nkLd2BPDSg2Mv6vutTx5ov9DzayC
         sp1/a7xghRwqjXKZs9ikdl15thZpuwIU1fQyeBNq+yE+91HQW5jeo4+MxvkBhgn1gPO+
         HBYA==
X-Gm-Message-State: AJIora9UKn4QOrj7cuHid2NyVbGhXZ7ldDa5x/ECfFF55ptw5IhGIVXs
        IyCC+1B9KYc167KyvA1MZlXyvamgvSZzzBcRZcXIpw==
X-Google-Smtp-Source: AGRyM1vBEvtf7ov+JoIEPe7L4X7srxN3a2/MCUADh+0tWA0mWFZJNSmPn9Itfl63NL6pqyJURE6SqRGtOGHQ2yZqCT0=
X-Received: by 2002:a2e:720f:0:b0:25a:9f46:6f5e with SMTP id
 n15-20020a2e720f000000b0025a9f466f5emr6013417ljc.103.1656623326207; Thu, 30
 Jun 2022 14:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220630153121.1317045-1-nathan@kernel.org> <20220630153121.1317045-3-nathan@kernel.org>
In-Reply-To: <20220630153121.1317045-3-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 30 Jun 2022 14:08:34 -0700
Message-ID: <CAKwvOd=UdmcP0Ef8gbyO7QWqS6kRTC2JLNH8LE4QdjQAXX=EbQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: vdso32: Add DWARF_DEBUG
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linudx.dev
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

On Thu, Jun 30, 2022 at 8:32 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> When building the 32-bit vDSO with LLVM 15 and CONFIG_DEBUG_INFO, there
> are the following orphan section warnings:
>
>   ld.lld: warning: arch/arm64/kernel/vdso32/note.o:(.debug_abbrev) is being placed in '.debug_abbrev'
>   ld.lld: warning: arch/arm64/kernel/vdso32/note.o:(.debug_info) is being placed in '.debug_info'
>   ld.lld: warning: arch/arm64/kernel/vdso32/note.o:(.debug_str_offsets) is being placed in '.debug_str_offsets'
>   ld.lld: warning: arch/arm64/kernel/vdso32/note.o:(.debug_str) is being placed in '.debug_str'
>   ld.lld: warning: arch/arm64/kernel/vdso32/note.o:(.debug_addr) is being placed in '.debug_addr'
>   ld.lld: warning: arch/arm64/kernel/vdso32/note.o:(.debug_line) is being placed in '.debug_line'
>   ld.lld: warning: arch/arm64/kernel/vdso32/note.o:(.debug_line_str) is being placed in '.debug_line_str'
>   ld.lld: warning: arch/arm64/kernel/vdso32/vgettimeofday.o:(.debug_loclists) is being placed in '.debug_loclists'
>   ld.lld: warning: arch/arm64/kernel/vdso32/vgettimeofday.o:(.debug_abbrev) is being placed in '.debug_abbrev'
>   ld.lld: warning: arch/arm64/kernel/vdso32/vgettimeofday.o:(.debug_info) is being placed in '.debug_info'
>   ld.lld: warning: arch/arm64/kernel/vdso32/vgettimeofday.o:(.debug_rnglists) is being placed in '.debug_rnglists'
>   ld.lld: warning: arch/arm64/kernel/vdso32/vgettimeofday.o:(.debug_str_offsets) is being placed in '.debug_str_offsets'
>   ld.lld: warning: arch/arm64/kernel/vdso32/vgettimeofday.o:(.debug_str) is being placed in '.debug_str'
>   ld.lld: warning: arch/arm64/kernel/vdso32/vgettimeofday.o:(.debug_addr) is being placed in '.debug_addr'
>   ld.lld: warning: arch/arm64/kernel/vdso32/vgettimeofday.o:(.debug_frame) is being placed in '.debug_frame'
>   ld.lld: warning: arch/arm64/kernel/vdso32/vgettimeofday.o:(.debug_line) is being placed in '.debug_line'
>   ld.lld: warning: arch/arm64/kernel/vdso32/vgettimeofday.o:(.debug_line_str) is being placed in '.debug_line_str'
>
> These are DWARF5 sections, as that is the implicit default version for

Most of these are DWARF v5, but some like .debug_info and .debug_line
are DWARF v2; this isn't specifically a DWARF v5 issue, more so just
an issue with CONFIG_DEBUG_INFO.  Not worth a v2 IMO though.  Thanks
for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> clang-14 and newer when just '-g' is used. All DWARF sections are
> handled by the DWARF_DEBUG macro from include/asm-generic/vmlinux.lds.h
> so use that macro here to fix the warnings regardless of DWARF version.
>
> Fixes: 9d4775b332e1 ("arm64: vdso32: enable orphan handling for VDSO")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/arm64/kernel/vdso32/vdso.lds.S | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/vdso.lds.S
> index c25bed8e6df1..8d95d7d35057 100644
> --- a/arch/arm64/kernel/vdso32/vdso.lds.S
> +++ b/arch/arm64/kernel/vdso32/vdso.lds.S
> @@ -57,6 +57,7 @@ SECTIONS
>         .rel.dyn        : { *(.rel*) }
>
>         .ARM.exidx : { *(.ARM.exidx*) }
> +       DWARF_DEBUG
>         ELF_DETAILS
>         .ARM.attributes 0 : { *(.ARM.attributes) }
>
> --
> 2.37.0
>


-- 
Thanks,
~Nick Desaulniers
