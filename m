Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D9B4C9F11
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbiCBIZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240082AbiCBIZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:25:08 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BE7B82D9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:24:25 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id g26so1759361ybj.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L9rbSbvYK5rDSEFwlXV2PxcvZcFXMLcwIqFE8DUbfrQ=;
        b=uYr26UofS5yZvm/rbeNA7IQFxHmJzaQ1Q8XuMTqz4/dulbVtrNasTxtmu78Gdi07UN
         7ZZuHVsdszoU+CIcQnLDIRQ9J193gAKpz/aSuPQH1nQ1L0wBO/4PTUaGVCMCvhVmLhbu
         Ce5ZCLe4iNpl6Twod2/w511EzZDpgKbhK1qXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L9rbSbvYK5rDSEFwlXV2PxcvZcFXMLcwIqFE8DUbfrQ=;
        b=ObqBpk8BNCasVvaiStSJ0UC6bqvG58ZiELHxweWXr5ekNm5rHvGd9VZfFbVh3Hl80O
         ljOeqmkJ7G7rH+v41OlSfwWVYsjToB4YsAAuzeK8QyPcZEHrnlTw7KBvrVybkMV0Qg1h
         S8cXg/wBf17yBBtvbcE3Usup2gA7yfUSDFTBzR19w0WLMFfJMmvhr/wWtwEuhZuNZo7/
         qaFYNLhbtuyV9TrVfR6fWNS/7E8ipWq/yfSqQLrAS9KrlWtx1Y0y+UtxzpmHb71/QROV
         tf95vJYWMY5VjcqOVEifOqKKR61xw+sJQPHZ4MfRGCAG3ewoR9uKZGFO5QSrtb/pSUqE
         02pQ==
X-Gm-Message-State: AOAM531OS0JFt7yfdNx4/F6xwVEtHYgA8/C3U0FKvuXX5oypZYalh/Lv
        /S48d2v2TBHnJ3GwUeU7HvWhXr8/RDpkJ7KEkUfkXg==
X-Google-Smtp-Source: ABdhPJyLGE8qYKTmY2jxpWZpqqYwAbb4XkXo5Ep1leshsZdl96xtFe0Ism0EWSHpEW8nArNw4bt6gRMBuN5hX1LuJGI=
X-Received: by 2002:a25:6b4c:0:b0:628:757c:a379 with SMTP id
 o12-20020a256b4c000000b00628757ca379mr7809071ybm.645.1646209464943; Wed, 02
 Mar 2022 00:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20220219092533.12596-1-linmiaohe@huawei.com> <20220219092533.12596-6-linmiaohe@huawei.com>
In-Reply-To: <20220219092533.12596-6-linmiaohe@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Wed, 2 Mar 2022 09:24:14 +0100
Message-ID: <CAM4kBBLBASi6_gxT-655maZ023SUqEXRHrrCQYq0xT6gPqhOvw@mail.gmail.com>
Subject: Re: [PATCH 5/9] mm/z3fold: remove confusing local variable l reassignment
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2022 at 10:26 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> The local variable l holds the address of unbuddied[i] which won't change
> after we take the pool lock. Remove it to avoid confusion.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Vitaly Wool <vitaly.wool@konsulko.com>

> ---
>  mm/z3fold.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 2f848ea45b4d..adc0b3fa4906 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -876,7 +876,6 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
>
>                 /* Re-check under lock. */
>                 spin_lock(&pool->lock);
> -               l = &unbuddied[i];
>                 if (unlikely(zhdr != list_first_entry(READ_ONCE(l),
>                                                 struct z3fold_header, buddy)) ||
>                     !z3fold_page_trylock(zhdr)) {
> --
> 2.23.0
>
