Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191E3523E12
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347333AbiEKTzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347305AbiEKTy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:54:56 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F1393982
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:54:54 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i10so5357708lfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Qb1M+JmVqidyh+GcY2AVrkjW3SfrjqMOoV1GmxoVTk=;
        b=aNqlCDjSlQAd5Mkgx9/ZjT6A3I6OWm4d++cBnww6hEPmMfrBMTKVPsD/1CUt1mcZoX
         FKcLAr/gRpPKKPPep48fSb6xq4ggxDJONXdvVJHAZrBuiluQK/Ynrxm9YvW0KHU2fgGj
         TiRJbIM7X79t91zZCCuEypIdirxM7C/m4vmPji5m2EgzfU3QrbDfeKMdKM/zPobP8xMp
         SupwiG77x1WnILjbHZUv7laC8VunueEaZHxeQkgAsw8U8onVelHw8ZaX/GYYUW6NQ9z5
         JIrDS3puH0QxD2pqiwkVF78OyB0PQfib9zYepB2Vs61A1xBTMgN5RTEiO5dEIZqQObc5
         re8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Qb1M+JmVqidyh+GcY2AVrkjW3SfrjqMOoV1GmxoVTk=;
        b=u6sqcqFbaIQSH30UKoPwFJyejBY7VcIERNuZ8R9Hcx/caVtKMhWvxmdbsm1yCXWqnh
         r2UbGj474Ld7M539dZ1f2y4vcsjw/kQmQI+yx8ww97EWaq6bNWM8ARvnWICC1d92X/pm
         YH4+diU0rUBhlFAsCGzDHiQdQhJGX42u+7YUSvW7u3w9OV7qzsk7834qb2fvJgrZGQHs
         gHn/uj/JjsyC5memtjXrhFtvCqnIXGSggKEw7TlICdzG0WqApLjJjIk5OG8QVDeVVhaW
         I6t73t3OPkyP2oJmrSr1G2CgueyxS58cI9LeyiSBlcEsiv4QEBPEgSK9xBNgjViLuDTH
         bVMg==
X-Gm-Message-State: AOAM531BUUwTYOIeFwHkmNu8NCpkdKgEwea+Iu5Wvw0/EgNEJ1fjnMSF
        q+7ZKuUMYwbm2mDrMYkj4JDMlQ1nzDbsUX1HrT4cjQ==
X-Google-Smtp-Source: ABdhPJyv+rsZDchbo4bbs51p7N/3mDFXD5dB/xCj/WH1juB/LdvdRHX77SRuTlb0XXqG1KUKBYTfafEXBGS1FNyaTNg=
X-Received: by 2002:ac2:4646:0:b0:472:108e:51af with SMTP id
 s6-20020ac24646000000b00472108e51afmr21415635lfo.184.1652298892520; Wed, 11
 May 2022 12:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220511120532.2228616-1-hca@linux.ibm.com> <20220511120532.2228616-6-hca@linux.ibm.com>
In-Reply-To: <20220511120532.2228616-6-hca@linux.ibm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 May 2022 12:54:41 -0700
Message-ID: <CAKwvOdm3P+c0W+oZ9wtgMyxcP3KYX0UkYxO4o=7DLLyMdKdnPg@mail.gmail.com>
Subject: Re: [PATCH 5/8] s390/purgatory: workaround llvm's IAS limitations
To:     Heiko Carstens <hca@linux.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 5:05 AM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> llvm's integrated assembler cannot handle immediate values which are
> calculated with two local labels:
>
> arch/s390/purgatory/head.S:139:11: error: invalid operand for instruction
>  aghi %r8,-(.base_crash-purgatory_start)

I thought this was fixed in
https://github.com/ClangBuiltLinux/linux/issues/1420
https://reviews.llvm.org/D113341
(clang-14)
?

>
> Workaround this by partially rewriting the code.
>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/purgatory/head.S | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/arch/s390/purgatory/head.S b/arch/s390/purgatory/head.S
> index 3d1c31e0cf3d..ac1a27a20b66 100644
> --- a/arch/s390/purgatory/head.S
> +++ b/arch/s390/purgatory/head.S
> @@ -44,11 +44,14 @@
>  .endm
>
>  .macro MEMSWAP dst,src,buf,len
> -10:    cghi    \len,bufsz
> +10:    larl    %r0,purgatory_end
> +       larl    %r1,stack
> +       slgr    %r0,%r1
> +       cgr     \len,%r0
>         jh      11f
>         lgr     %r4,\len
>         j       12f
> -11:    lghi    %r4,bufsz
> +11:    lgr     %r4,%r0
>
>  12:    MEMCPY  \buf,\dst,%r4
>         MEMCPY  \dst,\src,%r4
> @@ -135,12 +138,18 @@ ENTRY(purgatory_start)
>
>  .start_crash_kernel:
>         /* Location of purgatory_start in crash memory */
> +       larl    %r0,.base_crash
> +       larl    %r1,purgatory_start
> +       slgr    %r0,%r1
>         lgr     %r8,%r13
> -       aghi    %r8,-(.base_crash-purgatory_start)
> +       sgr     %r8,%r0
>
>         /* Destination for this code i.e. end of memory to be swapped. */
> +       larl    %r0,purgatory_end
> +       larl    %r1,purgatory_start
> +       slgr    %r0,%r1
>         lg      %r9,crash_size-.base_crash(%r13)
> -       aghi    %r9,-(purgatory_end-purgatory_start)
> +       sgr     %r9,%r0
>
>         /* Destination in crash memory, i.e. same as r9 but in crash memory. */
>         lg      %r10,crash_start-.base_crash(%r13)
> @@ -149,15 +158,19 @@ ENTRY(purgatory_start)
>         /* Buffer location (in crash memory) and size. As the purgatory is
>          * behind the point of no return it can re-use the stack as buffer.
>          */
> -       lghi    %r11,bufsz
> +       larl    %r11,purgatory_end
>         larl    %r12,stack
> +       slgr    %r11,%r12
>
>         MEMCPY  %r12,%r9,%r11   /* dst  -> (crash) buf */
>         MEMCPY  %r9,%r8,%r11    /* self -> dst */
>
>         /* Jump to new location. */
>         lgr     %r7,%r9
> -       aghi    %r7,.jump_to_dst-purgatory_start
> +       larl    %r0,.jump_to_dst
> +       larl    %r1,purgatory_start
> +       slgr    %r0,%r1
> +       agr     %r7,%r0
>         br      %r7
>
>  .jump_to_dst:
> @@ -169,7 +182,9 @@ ENTRY(purgatory_start)
>
>         /* Load new buffer location after jump */
>         larl    %r7,stack
> -       aghi    %r10,stack-purgatory_start
> +       larl    %r0,purgatory_start
> +       slgrk   %r0,%r7,%r0
> +       agr     %r10,%r0
>         MEMCPY  %r10,%r7,%r11   /* (new) buf -> (crash) buf */
>
>         /* Now the code is set up to run from its designated location. Start
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
