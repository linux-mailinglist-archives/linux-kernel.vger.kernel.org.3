Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02E753AC0C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354306AbiFARff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352260AbiFARfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:35:30 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964A4A5014
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 10:35:29 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id v9so2754852lja.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 10:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NTLfADh8lSfx6tLN8KBP3kdlF2/kw53HzSdkGJeezGo=;
        b=X4a0J2xdOaYaLyoglRcy+IjmYCqytQ1InubXGIgs1o/lCAUt07elZ+wctYLphPcvrg
         m57WjaEYd1NRbsT5XAACUuansZuvtzQzj/z/CBmPrAQ9DtjwA5RRoLtxxak8M3HiBUY6
         TfMw0Z1S25638qgsrTmJ4/gmNs9i7WFK5I0ZPlcCX7tBcgCmDFhh2/zry8jQPUp+J91D
         H8BKtNGeBrHp95UTfZ130N6x7KPm8c1fTHLmJ6TGckZip9+2OlhAOAble8kdvPVLUEAj
         LMvt4V9gAa53NlQMBy28aWrisBQFIFmRxchIhRyKLTqagmCxuyHTe4PNpW/UwhX8saJe
         1yBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NTLfADh8lSfx6tLN8KBP3kdlF2/kw53HzSdkGJeezGo=;
        b=WWylPbFOLn9sZOzw//oANGbluOiPy49K4++O21/E1INMsoQCmPD2OJI1Jf0QsUXyKR
         Zx0Wr3Jj/WOsNONsWZ3zZA9wW+Tx6kViegCUbXSLVwjJdQyTg2RDGHbC96cigZAUVO+d
         6rufQk4HmaZBIrEpxJ9P3kzHaPPhOxLzo1laYHU0HA2QdpNIZxIxL/XzfA/A88gXqdQM
         LEIeiyydmoPk8ASzsEH0Ni+UIUOTXgefFMwn/3Y7xwtIJ533SFhVvTeMIFWqXFwofVg4
         +Sq1X26mbhhTenBoL3xWVCymMT0CcGpcnwqJ5h8vsCSNUivTZ/IfIaHfXDc/p1yUQkdA
         3dmw==
X-Gm-Message-State: AOAM531JTSsveGAlBp7I7D/JFXw8vVA+ZkXKKrCqxP3F8PXMqm7rfNFl
        AvMnyGdOwCyBSzxjswYF2avEcUYVlZ/mZA6uHXqD+w==
X-Google-Smtp-Source: ABdhPJwkrwRQMBlasTORNG2O4r97fBgmL3eOhBAi7bv5kQLU/MeO8uLXOQk9UI/HWYjGUFw+9aM2H9wIt1fppNQhRQo=
X-Received: by 2002:a05:651c:179a:b0:247:d37b:6ec5 with SMTP id
 bn26-20020a05651c179a00b00247d37b6ec5mr37984487ljb.112.1654104927772; Wed, 01
 Jun 2022 10:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220601010017.2639048-1-cmllamas@google.com> <CAK7LNARjJJfEUhfs8_5Jw3ADg6kKSP=u10=dg4URS10hRk4tsQ@mail.gmail.com>
In-Reply-To: <CAK7LNARjJJfEUhfs8_5Jw3ADg6kKSP=u10=dg4URS10hRk4tsQ@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Wed, 1 Jun 2022 10:35:16 -0700
Message-ID: <CAHRSSEwMvw2A6N-su40Odbs7AH4EjQ1nVWrrG49aFKUC1PpFug@mail.gmail.com>
Subject: Re: [PATCH] binder: fix sender_euid type in uapi header
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Carlos Llamas <cmllamas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christopher Ferris <cferris@google.com>
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

On Wed, Jun 1, 2022 at 9:53 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Wed, Jun 1, 2022 at 10:00 AM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > The {pid,uid}_t fields of struct binder_transaction were recently
> > replaced to use kernel types in commit 169adc2b6b3c ("android/binder.h:
> > add linux/android/binder(fs).h to UAPI compile-test coverage").
> >
> > However, using __kernel_uid_t here breaks backwards compatibility in
> > architectures using 16-bits for this type, since glibc and some others
> > still expect a 32-bit uid_t. Instead, let's use __kernel_uid32_t which
> > avoids this compatibility problem.
> >
> > Fixes: 169adc2b6b3c ("android/binder.h: add linux/android/binder(fs).h to UAPI compile-test coverage")
> > Reported-by: Christopher Ferris <cferris@google.com>
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
>
> Ahhh, good catch.
>
> Thank you for fixing this!
>
>  Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Todd Kjos <tkjos@google.com>

>
>
> >  include/uapi/linux/android/binder.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
> > index 11157fae8a8e..688bcdaeed53 100644
> > --- a/include/uapi/linux/android/binder.h
> > +++ b/include/uapi/linux/android/binder.h
> > @@ -289,7 +289,7 @@ struct binder_transaction_data {
> >         /* General information about the transaction. */
> >         __u32           flags;
> >         __kernel_pid_t  sender_pid;
> > -       __kernel_uid_t  sender_euid;
> > +       __kernel_uid32_t        sender_euid;
> >         binder_size_t   data_size;      /* number of bytes of data */
> >         binder_size_t   offsets_size;   /* number of bytes of offsets */
> >
> > --
> > 2.36.1.255.ge46751e96f-goog
> >
>
>
> --
> Best Regards
> Masahiro Yamada
