Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27DB523E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347422AbiEKT5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347513AbiEKT4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:56:42 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DB01F97BC
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:56:41 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id y19so3967768ljd.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4nav3zqBTONgwlQKkoQjO7boVlk/kox8wJwi0Xj/n8I=;
        b=ic/D5CKG2LyVrqw4wvCxxA6OLn57RU3DCA8VBOtixUNoN24i8HfMU1HXyuPrX8rWY7
         9a4GzrCJDGSGxlEUCziaqhFiwRK0oy+kn8UTP5elQBBPa1c4/12eKVIPOQN1gKSwS6Il
         G72397sWxrnK8ZkEd3tWWg3rJfpGFj7Kg5RnjIayGMpPPfFG+LQ3HK+Nq3tdUcmBa8wp
         UNOFQfQfw3fH4X1YkYR1SHrNjFET2bC0S6eNMZYShxraJX1+EOwfBEbp66sth9vidqwt
         5ndTtZ290g8yXXU06GWXVAb2gf3brP8aaoKozX4+gQ9MPoVEVSUkFaoWNtjLPCm5L7Wt
         2ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4nav3zqBTONgwlQKkoQjO7boVlk/kox8wJwi0Xj/n8I=;
        b=xxgfpU9oa2wI7xqlv+Iva12eEgBcyhhp7afjtqHAPLqmrlf1MPqVMZ+HosqatCauP4
         wtFPAtqgJMRgsOwQdNMyTwxXholW2aYnFspClKMqWVr/9BSGWDX//aZlruapOwd4/krd
         BI7ewN4s0s3FG1NgaR7YwUjGZAC0uPU5TCH23acforOobOI2OmfKbr+e23cHKHwxFcgL
         yKmjcmeal5+Kmeal+6BAOieaUYOA0FsjmRqsvQLbZiYHcqQ/0kKMK/m4UIq6GCaQbVo6
         nSpCTxo/PEA27RUZIGc/tDe9W+TIknO/dxmwhuTDnmPHu+f7Pf/CmuS15o+CMvJUR50K
         Towg==
X-Gm-Message-State: AOAM533Xf5F463Z1KlkUkE3ahwnDmdd1kDjsRBjRNO1U4DAVzZYGLyjy
        0e8u+hgRMD5mgf+ynDKGNgXfAveyvPuhDLn5N5j3/A==
X-Google-Smtp-Source: ABdhPJyfR5tpRmHvf0W0smFj5zTGn2GPW75XC4VbTwtu6gw8q649ATaXEfp3GanjzSqmQcNTQL/2MvVi/IKK2CcD5Vg=
X-Received: by 2002:a2e:91cf:0:b0:24f:11ea:d493 with SMTP id
 u15-20020a2e91cf000000b0024f11ead493mr17680560ljg.408.1652298999315; Wed, 11
 May 2022 12:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220511120532.2228616-1-hca@linux.ibm.com> <20220511120532.2228616-9-hca@linux.ibm.com>
 <CAKwvOd=EQa9tyWUi-ZfKrK-AABDRG7=TErHK+yb+_Z_dkjrmfQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=EQa9tyWUi-ZfKrK-AABDRG7=TErHK+yb+_Z_dkjrmfQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 May 2022 12:56:27 -0700
Message-ID: <CAKwvOd=T5bd69-pduh8OnYdzGuBdJmF692VYP833ZG3BfGUA+A@mail.gmail.com>
Subject: Re: [PATCH 8/8] scripts/min-tool-version.sh: raise minimum clang
 version to 14.0.0 for s390
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 12:27 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, May 11, 2022 at 5:05 AM Heiko Carstens <hca@linux.ibm.com> wrote:
> >
> > Before version 14.0.0 llvm's integrated assembler fails to handle some
> > displacement variants:
> >
> > arch/s390/purgatory/head.S:108:10: error: invalid operand for instruction
> >  lg %r11,kernel_type-.base_crash(%r13)
> >
> > Instead of working around this and given that this is already fixed
> > raise the minimum clang version from 13.0.0 to 14.0.0.
>
> Do you have the commit in LLVM that fixed this? Might be nice to link

Maybe it's
https://reviews.llvm.org/D113341?

Also, these are the open issues we had for the integrated assembler.
https://github.com/ClangBuiltLinux/linux/issues?q=is%3Aopen+is%3Aissue+label%3A%22%5BARCH%5D+s390%22+label%3A%22%5BTOOL%5D+integrated-as%22

Any chance you could include relevant Link tags on your commit
messages for patches that address these? It makes it easier to track
when/where things land if we ever intend to backport anything to
stable.

Or can any of those be closed out?

> to the particular commit in the commit message. Either way:
> Acked-by: Nick Desaulniers <ndesaulniers@google.com>
>
> (Thanks for the series, will pull down and test!)
>
> If you have a github account, let me know it if you'd like to be cc'ed
> when we wire this up in our CI.
>
> >
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > ---
> >  scripts/min-tool-version.sh | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> > index 53fe64856015..f1e8358ec19a 100755
> > --- a/scripts/min-tool-version.sh
> > +++ b/scripts/min-tool-version.sh
> > @@ -24,9 +24,8 @@ icc)
> >         echo 16.0.3
> >         ;;
> >  llvm)
> > -       # https://lore.kernel.org/r/YMtib5hKVyNknZt3@osiris/
> >         if [ "$SRCARCH" = s390 ]; then
> > -               echo 13.0.0
> > +               echo 14.0.0
> >         else
> >                 echo 11.0.0
> >         fi
> > --
> > 2.32.0
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
