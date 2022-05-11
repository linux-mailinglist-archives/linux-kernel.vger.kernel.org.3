Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97B3523DB6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347065AbiEKTkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347061AbiEKTkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:40:23 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4227F21A95E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:40:21 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 16so3867532lju.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s0WHnwC/LKH7P9lNbxHLOT0Ey/YFu5D9xNYFJTYtZ1Q=;
        b=Fvz5uPtJHUorCw5qkY372eQ60ClhKlpeLwO1xjhAL9PQHj9vflc26CO74tkzg7EmAI
         FEHbyF3V9YbZQYUmxvm1RNGhLDcIjYqTBqP4pZiVRnOpH7gUtNFeTmFleqdhViv3AS3i
         q3If8KCbEwTyPf7Uo6YzYZ1DgplKvn07+Q5FTK3v4nApvYHZxE1K0C9zkXE0CAEZsylG
         /vV6IuLMlkcjNQ0IVy3QsNh5mor400xpsLkIzUSChrp4HwfNkleiWjE/UsdexJvxUSKo
         7XcpLaapmKfq6RqUk63VDmyq5ZCSDITSYlTLQDsqe8Nq/YlTdnTooSQfbfWhq1VOhG6a
         uP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s0WHnwC/LKH7P9lNbxHLOT0Ey/YFu5D9xNYFJTYtZ1Q=;
        b=HnFLRU/2tDDN3hILG8L2dKZWWTsSkAIzuLpJpY4vSUDWO/X1SC2dbGi7VEC7VOrcB5
         xUF988+ZWl3SPtLTgpL13FoHO8yGsykIX47GVodwVNGgMFeKOeCw3gJnpJD8LGduo1w7
         B7njBGZtBmmEA6F8mpvWP0yk1BdYE6wWt/QQyWEIQH9n667Cg/HTpod7UXp2ZWcMZYMf
         0uuw1HYcJPnW5+FcZ4mbirI0o6v3CIMsAeLCN/YTJj5dKbkt3k5P3r18qcn9X82/jGWm
         5KE1P/fafkdFrG1sO3WW+R7gA7IrSg2sfQyMYWWBmn1S8U8AepIf1xVP7Ah/GHVjwWZJ
         qNYA==
X-Gm-Message-State: AOAM533cvzT912ypNcf6zu9YBrXCys3E5VYPPSL3vNGac1BmialX3li9
        +ryY3FyTxOzvrv7ucpXT9VLgctzgCG6kJZkao1f0NQ==
X-Google-Smtp-Source: ABdhPJz0NVpIZePVvZ3oOx6+FO7jLpzyA7B8CJCC9CbYcQngiEhIKV2dTdoUVdm176erPVni03DBhy5q0Zs/JvZO3y4=
X-Received: by 2002:a05:651c:101:b0:250:896d:f870 with SMTP id
 a1-20020a05651c010100b00250896df870mr17878467ljb.235.1652298019389; Wed, 11
 May 2022 12:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220511120532.2228616-1-hca@linux.ibm.com> <20220511120532.2228616-8-hca@linux.ibm.com>
In-Reply-To: <20220511120532.2228616-8-hca@linux.ibm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 May 2022 12:40:07 -0700
Message-ID: <CAKwvOdn3Mdn9ek-7EotHmd6Wb7C5rzZnOxAQVtbQEd2LBBZGRg@mail.gmail.com>
Subject: Re: [PATCH 7/8] s390/boot: do not emit debug info for assembly with
 llvm's IAS
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jonas Paulsson <paulsson@linux.vnet.ibm.com>,
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 5:05 AM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> Commit ee6d777d3e93 ("s390/decompressor: support extra debug flags")
> added extra debug flags, in particular debug info is created,
> depending on config options.
>
> With llvm's IAS this causes this compile warning:
>
> arch/s390/boot/head.S:38:1: warning: DWARF2 only supports one section per compilation unit
> .section ".head.text","ax"
> ^
>
> This is a known problem and was addressed with a commit b8a9092330da
> ("Kbuild: do not emit debug info for assembly with LLVM_IAS=1").
> Just do the same for s390 to get rid of this warning.
>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> index c59efc83f020..d73611b35164 100644
> --- a/arch/s390/Makefile
> +++ b/arch/s390/Makefile
> @@ -20,7 +20,9 @@ LDFLAGS_vmlinux       := -pie
>  endif
>  aflags_dwarf   := -Wa,-gdwarf-2

^ or can we use a more modern variant of dwarf, like at least dwarf-4?

>  KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
> +ifndef CONFIG_AS_IS_LLVM
>  KBUILD_AFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),$(aflags_dwarf))
> +endif
>  KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2 -mpacked-stack
>  KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
>  KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float -mbackchain
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
