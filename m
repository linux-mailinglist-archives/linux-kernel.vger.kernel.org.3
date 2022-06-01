Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D227D53AB55
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353102AbiFAQx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343763AbiFAQx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:53:27 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64721B797
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 09:53:25 -0700 (PDT)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 251GrB0V013766
        for <linux-kernel@vger.kernel.org>; Thu, 2 Jun 2022 01:53:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 251GrB0V013766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654102392;
        bh=3NKQ+J3mzt26WVeE86BqFNJ9+iqJLoZtenf097yyYe4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ULej1WToW/U7kHpiFTAlHr7SmsxH2jVcbm1DCPMRb0hYM2dBBu/V59Rj4o2qPGCZt
         aQzSMtWANhX+9E0LUBjNrlwQ2OkAKr2OpHyuMu5ltTvhmVCj6EM3r4AwtJkFaEMrUU
         n1Ei+DYyJZu0Of3CaBNrgYAFg1TI/LB5W6/3cOuEVP5Lh4PD7MfjTt4na51uNw1Zpg
         vi1JUTBrKONiH7AqDcdFUbEXAIIgYXhR60s0UuDkB/+wjUoVfBhrnBqP6VZcCK/ru/
         LJCgZ9sLq2Ukp8fEq7cpSvjTbxkJ1HERqc3B73cKMugPv/bEzUHvDPuIS83Sps+YbY
         NjSp05CInRw+g==
X-Nifty-SrcIP: [209.85.214.176]
Received: by mail-pl1-f176.google.com with SMTP id i1so2321724plg.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 09:53:11 -0700 (PDT)
X-Gm-Message-State: AOAM530JabizqbdhfxuVsuQ0QXaKg8f6+yTJBDrw40VzJGmiHGJkfJFD
        PTdKwvj/t/Q6AKzxm2gfz3ft32g7ct2n43w1sho=
X-Google-Smtp-Source: ABdhPJxhsJ0yvfOfuO3coLIJWFOt3V5F/7NjPqiVQQUCpJ+4KU1HKIWEydX7/88qEsknlnrnKrn+feViD2SNnFCqpPY=
X-Received: by 2002:a17:903:1205:b0:15e:8cbc:fd2b with SMTP id
 l5-20020a170903120500b0015e8cbcfd2bmr333667plh.99.1654102391009; Wed, 01 Jun
 2022 09:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220601010017.2639048-1-cmllamas@google.com>
In-Reply-To: <20220601010017.2639048-1-cmllamas@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 2 Jun 2022 01:52:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNARjJJfEUhfs8_5Jw3ADg6kKSP=u10=dg4URS10hRk4tsQ@mail.gmail.com>
Message-ID: <CAK7LNARjJJfEUhfs8_5Jw3ADg6kKSP=u10=dg4URS10hRk4tsQ@mail.gmail.com>
Subject: Re: [PATCH] binder: fix sender_euid type in uapi header
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christopher Ferris <cferris@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 1, 2022 at 10:00 AM Carlos Llamas <cmllamas@google.com> wrote:
>
> The {pid,uid}_t fields of struct binder_transaction were recently
> replaced to use kernel types in commit 169adc2b6b3c ("android/binder.h:
> add linux/android/binder(fs).h to UAPI compile-test coverage").
>
> However, using __kernel_uid_t here breaks backwards compatibility in
> architectures using 16-bits for this type, since glibc and some others
> still expect a 32-bit uid_t. Instead, let's use __kernel_uid32_t which
> avoids this compatibility problem.
>
> Fixes: 169adc2b6b3c ("android/binder.h: add linux/android/binder(fs).h to UAPI compile-test coverage")
> Reported-by: Christopher Ferris <cferris@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Ahhh, good catch.

Thank you for fixing this!

 Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>


>  include/uapi/linux/android/binder.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
> index 11157fae8a8e..688bcdaeed53 100644
> --- a/include/uapi/linux/android/binder.h
> +++ b/include/uapi/linux/android/binder.h
> @@ -289,7 +289,7 @@ struct binder_transaction_data {
>         /* General information about the transaction. */
>         __u32           flags;
>         __kernel_pid_t  sender_pid;
> -       __kernel_uid_t  sender_euid;
> +       __kernel_uid32_t        sender_euid;
>         binder_size_t   data_size;      /* number of bytes of data */
>         binder_size_t   offsets_size;   /* number of bytes of offsets */
>
> --
> 2.36.1.255.ge46751e96f-goog
>


-- 
Best Regards
Masahiro Yamada
