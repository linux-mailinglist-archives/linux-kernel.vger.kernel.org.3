Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A027B515145
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379389AbiD2RHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347686AbiD2RHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:07:08 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE49CE136
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:03:49 -0700 (PDT)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 23TH3RUn022680
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 02:03:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 23TH3RUn022680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651251808;
        bh=2vpSHisjjsnf9NfbpwTfPLzqRn0BtksbaOiDQMdZIhY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vIZKmixvU3vr2L5AM0NRMs6Js+aaHTAUpjPmRsHYlD5bN0Z5suE+z4fPNRck9lLwY
         9OhL5IeMww9wXpimeozNQUifnf7B/A48CioSTRkFjOEZx4x+GUggqd/6KHorFx04oO
         r8J4y+qlitJaoI+gNbzG9DHCAxHri4RjZv8EGE3uywnsygVFleDHHyDUP+qmD8a7bz
         peFt01GltVqHLatiy9e82YOwbvsL1ooF0mnioAfyxzXQCcI9juATsu0Wl4hfRxLmON
         52rIlHEKuwQvNHp7HQC1mBOwHKCX1UfUM2iVHTlpL682CKfVJtbUPn92rSq3JehAlD
         plDZDEbrLlf5g==
X-Nifty-SrcIP: [209.85.216.46]
Received: by mail-pj1-f46.google.com with SMTP id fv2so7618955pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:03:28 -0700 (PDT)
X-Gm-Message-State: AOAM531gWQiM2ImmhljskT9t/eG2GFvc9zQE1OY7cKIE2EKaKyjn2qn8
        niiTpy6tKtA54PqAhrKl1sOLB+jdpnyuUTToVLM=
X-Google-Smtp-Source: ABdhPJxTFHxNrrT5TqeOkyMPJTn0AidkGCpkTxYwuoLHQHkodF0cp0Iagk/I7OqOD0n4qehCHvFWugf2l3faxbK2OGU=
X-Received: by 2002:a17:902:f54e:b0:15e:6c3f:5b5 with SMTP id
 h14-20020a170902f54e00b0015e6c3f05b5mr342925plf.99.1651251807401; Fri, 29 Apr
 2022 10:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220422151725.1336997-1-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20220422151725.1336997-1-mailhol.vincent@wanadoo.fr>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 30 Apr 2022 02:02:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNARL+_amg-6RN9W+P9n8KuWqobpWrvo6gXxRphxj+=OU7Q@mail.gmail.com>
Message-ID: <CAK7LNARL+_amg-6RN9W+P9n8KuWqobpWrvo6gXxRphxj+=OU7Q@mail.gmail.com>
Subject: Re: [PATCH] checksyscalls: ignore -Wunused-macros
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 12:18 AM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> The macros defined in this file are for testing only and are purposely
> not used. When compiled with W=2, both gcc and clang yield some
> -Wunused-macros warnings. Ignore them.
>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---

Applied to linux-kbuild (only the second hunk)
Thanks.

The current check is not nice,
but this does not hurt.



>  scripts/checksyscalls.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
> index 9dbab13329fa..cde15f22ec98 100755
> --- a/scripts/checksyscalls.sh
> +++ b/scripts/checksyscalls.sh
> @@ -255,6 +255,7 @@ cat << EOF
>  /* 64-bit ports never needed these, and new 32-bit ports can use statx */
>  #define __IGNORE_fstat64
>  #define __IGNORE_fstatat64
> +
>  EOF
>  }

Noise.
I dropped it.



>
> @@ -268,4 +269,4 @@ syscall_list() {
>  }
>
>  (ignore_list && syscall_list $(dirname $0)/../arch/x86/entry/syscalls/syscall_32.tbl) | \
> -$* -Wno-error -E -x c - > /dev/null
> +$* -Wno-error -Wno-unused-macros -E -x c - > /dev/null
> --
> 2.35.1
>


-- 
Best Regards
Masahiro Yamada
