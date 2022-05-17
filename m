Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC6752ABCC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 21:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352641AbiEQTSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 15:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243528AbiEQTSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:18:49 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7567C2B1AA
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:18:48 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h8so2207819ljb.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5jj0hfLXwv5NKyNSQq0cQn2yY9wFPizqfDkJ1NRfo4=;
        b=DWS8JGbeisC2lfPyrlCGUuKBIImqL9gH6ppVO68WrJgbfUd00qzpdFdZeABq8H1Cez
         vWssXOe3XUjdUiD2vlMOtRDrmEG4B92Jn7mMc/CviQG5KMn+8oNwdPvL8Ddb9+l0M2cs
         BzBS23a7oF/gqPt2lAyKlkLkCFGhnDTM4a3YcDU9Cxa9o8rlSeF1+zug8d+Q5kyVBHbx
         DvEyKgOi2zODODUrpgOvz2IXM1nLcuS6NaXz0p648/YbZoJdtu9oNT5B5gNpClEgJa7i
         RwSNOSovVQeDIlnnGKxBJn5h0LnmQilHewAEtGVdx7HvVRbI3kOs8TmbYLEmHXv5TKYH
         R4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5jj0hfLXwv5NKyNSQq0cQn2yY9wFPizqfDkJ1NRfo4=;
        b=UYdrJjxBpxjfMCREOKZ1Sf9dXBchksSPKF+gzQ2PC5wTwoQSaDuZV4PnpygRAkz5U8
         /ML8dMsGenelK5k1Mxv0EVA7ZEjpisHRlMuGONNC1sANPi8R0QHuJZ2TdCUL2pTZahcW
         wh6CLbmkoDpedeGcl1i3GnEKcFudfyZy6cpqWVqQiAZvaAudLxNfFMxawheyKVn5xE+q
         qtx4LjbP3O118oet1gq04VCrPtVL712GApj5W+K+yho2acF78rL9snU+QeoGcy51KMvy
         XuA+M66U8cuSBDSGcAAKcFStKgBb8N0WsUsyxGa481mVyIkqLOOt/EJxEd7iF9CXeniA
         TY9Q==
X-Gm-Message-State: AOAM532mhtfliwiVA4+VLa4TKmAQf8DSknMvsvn7bjGtLYMRtcOR+dyZ
        bbGT9tkdthC2XXWKLaAUIRYOnGbRqt9aPQQ4lUBaHQ==
X-Google-Smtp-Source: ABdhPJwkMnRiD5WhBfVjkJHY8123izcEUknoDVqzKtNgmeKMqgfvP1WqkL4yVE8D3GRUGby3jI/mB4lPT/4XH4HnR28=
X-Received: by 2002:a2e:944a:0:b0:24f:10bd:b7e8 with SMTP id
 o10-20020a2e944a000000b0024f10bdb7e8mr15214538ljh.238.1652815126626; Tue, 17
 May 2022 12:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220517185817.598872-1-cmllamas@google.com>
In-Reply-To: <20220517185817.598872-1-cmllamas@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 17 May 2022 12:18:34 -0700
Message-ID: <CAHRSSEyoBLC4U-Z1hXqG=1XhDeh6bHD8-z+LD9kxmc6nSgg0UA@mail.gmail.com>
Subject: Re: [PATCH] binder: fix potential UAF of target_{proc,thread}
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
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

On Tue, May 17, 2022 at 11:58 AM Carlos Llamas <cmllamas@google.com> wrote:
>
> Commit 9474be34a727 ("binder: add failed transaction logging info")
> dereferences target_{proc,thread} after they have been potentially
> freed by binder_proc_dec_tmpref() and binder_thread_dec_tmpref().
>
> This patch delays the release of the two references after their last
> usage. Fixes the following two errors reported by smatch:
>
>   drivers/android/binder.c:3562 binder_transaction() error: dereferencing freed memory 'target_proc'
>   drivers/android/binder.c:3563 binder_transaction() error: dereferencing freed memory 'target_thread'
>
> Fixes: 9474be34a727 ("binder: add failed transaction logging info")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index d9253b2a7bd9..83facfa1a5c3 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3546,10 +3546,6 @@ static void binder_transaction(struct binder_proc *proc,
>  err_empty_call_stack:
>  err_dead_binder:
>  err_invalid_target_handle:
> -       if (target_thread)
> -               binder_thread_dec_tmpref(target_thread);
> -       if (target_proc)
> -               binder_proc_dec_tmpref(target_proc);
>         if (target_node) {
>                 binder_dec_node(target_node, 1, 0);
>                 binder_dec_node_tmpref(target_node);
> @@ -3565,6 +3561,11 @@ static void binder_transaction(struct binder_proc *proc,
>                      (u64)tr->data_size, (u64)tr->offsets_size,
>                      return_error_line);
>
> +       if (target_thread)
> +               binder_thread_dec_tmpref(target_thread);
> +       if (target_proc)
> +               binder_proc_dec_tmpref(target_proc);
> +
>         {
>                 struct binder_transaction_log_entry *fe;
>
> --
> 2.36.0.550.gb090851708-goog
>
