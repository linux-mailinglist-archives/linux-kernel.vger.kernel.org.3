Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6414F4BD4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448252AbiDEXGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573174AbiDESHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:07:43 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A7A1F623
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 11:05:41 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 5so24729928lfp.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 11:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X0ND6VwIEZwinAToHYv1JdQDzPnywveE91KVWFTQSKU=;
        b=RBo9gfw+D1FKrMZUzQe7qcOB2qaHge7l/8AZd+/yufIzV5iTwW+v7Gjmkr/gKOAcNR
         I2VGdF2YwGb7Zle/dZok5Yyl2CtHHebkp9lEYidiaJhOvNRNDTRQVF7A8nfj401cpygQ
         FO2NhbyaeDO4GmHuxCFSiKMxVLVZMBk0GflYWXitt5FIktd0zIcCKMjhsaq2+XV96aWQ
         ynP4oGJx6nvLzcrAbZ7wzwjeuf2QjqP3JYzssIEKsY4U3nzMObksFK1B2lE2y5EpJaSQ
         fBPtz7EBAjtN5TKpS5F13PNhDk+urTpeI9xzG4SuKlQa2s11FC4PGryTK0PeQ5RBbjZ/
         u4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0ND6VwIEZwinAToHYv1JdQDzPnywveE91KVWFTQSKU=;
        b=0Zr5YG2W6njDKKW/7BfqVUUybvOxSf9NA8Fq8nBwrny793FgtjyM7+Jv4GZFEqBAft
         Bbhsva8ovqH10w4wdMaAsdP5qB6i8J/vPu6RMYPsUlGF/SXDV76LLgC2RoOoeZH1g//b
         y8sjG+PqjNO0RBnx01tpcx5mNMzUJhjzd4N3jtWIJ4F7VGkrTkoiK1jNUvTShZv1s4jt
         ++IQWizwvRWibQiWSRQRBb9nkSLD1f5F2FTreMdktXwh1tfuzieqUnEvOj3kQz5+p/Nl
         X70Q5j7qp/hscvVrpV+M03hkBwntaBMOCPhTiYKFPlTkuh2ITMwV+y1zb1ESt6H4MCqD
         K55g==
X-Gm-Message-State: AOAM530xf4N/O/zVsrGSmQpDHfNVOvFg5uEaDrTwqr9FSeeXVpnH/NdK
        MKoJ7Hq7FFc7dOWyG25QHDbIJGClMceHivRWYFQ3BNweJZpQvQ==
X-Google-Smtp-Source: ABdhPJz8Ob2IFSJ2xU2SEyque7PyMmTt1CuxsFgqOZW+PCOTKSh0Ys9Ztyvr9JrHOENxXbwRXkEU1ITLIiTlI2b9UYE=
X-Received: by 2002:ac2:5223:0:b0:448:5100:e427 with SMTP id
 i3-20020ac25223000000b004485100e427mr3474419lfl.87.1649181939752; Tue, 05 Apr
 2022 11:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220402131546.3383578-1-trix@redhat.com>
In-Reply-To: <20220402131546.3383578-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Apr 2022 11:05:28 -0700
Message-ID: <CAKwvOdnVcXgJtJsVujXpEVOLrY_BU5BPHN4tW_ziXNB-xnZPkw@mail.gmail.com>
Subject: Re: [PATCH] lib: remove back_str initialization
To:     Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     nathan@kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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

On Sat, Apr 2, 2022 at 6:16 AM Tom Rix <trix@redhat.com> wrote:
>
> Clang static analysis reports this false positive
> glob.c:48:32: warning: Assigned value is garbage
>   or undefined
>   char const *back_pat = NULL, *back_str = back_str;
>                                 ^~~~~~~~   ~~~~~~~~
>
> back_str is set after back_pat and it's use is
> protected by the !back_pat check.  It is not
> necessary to initialize back_str, so remove
> the initialization.
>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Andrew, would you mind picking this up for us, please?

> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  lib/glob.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/glob.c b/lib/glob.c
> index 85ecbda45cd8..15b73f490720 100644
> --- a/lib/glob.c
> +++ b/lib/glob.c
> @@ -45,7 +45,7 @@ bool __pure glob_match(char const *pat, char const *str)
>          * (no exception for /), it can be easily proved that there's
>          * never a need to backtrack multiple levels.
>          */
> -       char const *back_pat = NULL, *back_str = back_str;
> +       char const *back_pat = NULL, *back_str;
>
>         /*
>          * Loop over each token (character or class) in pat, matching
> --
> 2.27.0
>


-- 
Thanks,
~Nick Desaulniers
