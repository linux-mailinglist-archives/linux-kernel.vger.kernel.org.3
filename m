Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BC35A70BA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiH3WYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiH3WXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:23:39 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0BE3AE50
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:21:58 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e20so15955308wri.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=b3tpylOaVjEHDpEfk7DCJ80UTQR+CjvJJv64qHPChoU=;
        b=g1q6T/dgGYt7iXJGKvSDZvugBgDrwUlj83bCPpM1Jpt6m9HKfs8sj0SuGK4CLRgkBr
         E2VElC1sJGBpdUtzoj8A5Cf9p+2HAzZXYqtyBex4G2pD6l/0XEZ349kLns3y3eogCAFu
         4ihN1IN5S2CVXXoT9wfBafymWE3oUP6XYLLSpF7Tk6IHbjloyyW8O/HGn0MD4dNW6hqx
         CakLbWYjcIzXHjBNDLmCKW0fnWgypW25YrcSnQ2/6k+F82F4OgzckAJ/YJvCMs3GhJ22
         84GmR545ucUsONw2UwpfmySlq9ugw1Wc9C+eP+7yI2OK+HD71IJwkiqsv/Nwz4uXgmo9
         4b4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=b3tpylOaVjEHDpEfk7DCJ80UTQR+CjvJJv64qHPChoU=;
        b=H+gHpINgGUL/rd+X9qcz3j03thXcITp1qqwVEjNDF3rSVFpRby0ywsbf4tV19OQvoy
         svqT+bRBNo4vXxMuvxI75wWbioBp4HvNzFCOL1rqRg0hyYy/IlI1ar8ZpuUp80AjyrYt
         5+P7khvEIAhm0XeNo65h281Ho91qVGx6U/3EUF/nEMAa/ihDZDd3ca0xovvEwgvTM99z
         4q2iiYeupb9xcBMyBogtVVfjo6eNH5G8Jkj1HHAmHHcV8dXbrhKQ8tPNL4Q9kaK1G+jq
         z8gjGiOe/ePZn9AOBkt0mLMdzaMerqs1gdkAD6LIqgbl+alJQctTDc5ys2D+x007tzxN
         neZQ==
X-Gm-Message-State: ACgBeo1IINTJuHzBf23g2apqRENpawebVBt3HZOgAEvwx6gwRMLISKZD
        Q7TrAIwzSQg++xcubchdQ2BXc9juHbbZOVoSjkruMA==
X-Google-Smtp-Source: AA6agR5s7mbc4QDE4abq87FePUq0jFJ/3/b5VAOQEUktRUjZDEVwXcEJ6h/tMsL5QqIZuYZ9jXMrSvhAstckjq5Br6o=
X-Received: by 2002:adf:d84f:0:b0:226:d37a:b2c4 with SMTP id
 k15-20020adfd84f000000b00226d37ab2c4mr9088438wrl.42.1661898094851; Tue, 30
 Aug 2022 15:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220829201254.1814484-1-cmllamas@google.com> <20220829201254.1814484-6-cmllamas@google.com>
In-Reply-To: <20220829201254.1814484-6-cmllamas@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 30 Aug 2022 15:21:24 -0700
Message-ID: <CAHRSSEyomcATX3td1tiAAMjecDvwT=KnPD8OMY-RHKBSyt7cyA@mail.gmail.com>
Subject: Re: [PATCH 5/7] binder: remove unused binder_alloc->buffer_free
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
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

On Mon, Aug 29, 2022 at 1:13 PM 'Carlos Llamas' via kernel-team
<kernel-team@android.com> wrote:
>
> The ->buffer_free member was introduced in the first revision of the
> driver under staging but it appears like it was never actually used
> according to git's history. Remove it from binder_alloc.
>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder_alloc.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
> index fe80cc405707..ab3b027bcd29 100644
> --- a/drivers/android/binder_alloc.h
> +++ b/drivers/android/binder_alloc.h
> @@ -109,7 +109,6 @@ struct binder_alloc {
>         size_t free_async_space;
>         struct binder_lru_page *pages;
>         size_t buffer_size;
> -       uint32_t buffer_free;
>         int pid;
>         size_t pages_high;
>         bool oneway_spam_detected;
> --
> 2.37.2.672.g94769d06f0-goog
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
