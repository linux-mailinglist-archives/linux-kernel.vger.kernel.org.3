Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70632577E56
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiGRJH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbiGRJH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:07:57 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710AC11810
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:07:56 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 64so19637126ybt.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9eJN+m0pEHtjJ1cyznLRwut5IHeAG8qD1A+Zq2Ji8RE=;
        b=a28ILWIbndvvHjicaKV1NVvzz3vVS0NEL6I/oMvaX5/7dAEFb7NRO6NFh1gJmzRhjg
         S7cDPxX9yShHvrtd8+TZ51ZmL8uwlX5cRDVVaECNYg4D8Zbc62fQHXLhFrBJJENJ4v6u
         kzR43CopMtm1pqMP0OSbhlTtIlZMrv1/q0pq4PTIa0HKg+vNGOlV8pe7y+lydcP1vf8M
         U1ddaGUxm1eDRD+vr3PN2rZWBXhr6ch2fQsZvGk8zSjLTVFOt1HiSInkS4Z6GhHFQADs
         HNEiR0CGvpjp+HRQ2UCXxkm8OdgxA0xdMJSBynsOWBIx2M+10rZJe+KjZkKJTc6NjBYv
         71jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9eJN+m0pEHtjJ1cyznLRwut5IHeAG8qD1A+Zq2Ji8RE=;
        b=57utpJeSeafh24iMbTFeIkDp24lNwHRAVdKe3CDSqL39hK7NIh0Jpqv+RdTV7nke2t
         IQa5/KhX8Ra1KRwFEy52my+cgppLOOli/QQJhbOQ2VriU1CikwWYJnsXiQniLshxnSAU
         cNxlJ8Dxe1a+q177axwm5NYW4vMjatSaeI7c54ePEpBaN2PnjfCUUsUhqYbKCBww8zZX
         h6czqhrLjmSy69cIs8HEcLe1vJIrM4c3gU/B7Cmt2rAQFfZjZf3dZn2pCKnq00C6PX9J
         gk8IAKUZ08wz3HpB8NsSCl0Y2K8HV1E48N007Add0wu82NMt+bX+a2Mo8mYbgO/+JwGU
         bhcA==
X-Gm-Message-State: AJIora+rUiPp+42yh0Y2/G0o2/Ezrg0vQhxNzAzdwCfTKp2UV6e2rdeL
        thPXP2yoG89WRBa6l2KcYQjT4OmGCNc5/ww/mBpLPw==
X-Google-Smtp-Source: AGRyM1slwFfk5U3IpZzcEo3JyKbDkizozgOVrCNpodmEfJGeCB577KdrlSLcv1KnQ57zoe+PIhqjOgjjp3fZl3K/7dQ=
X-Received: by 2002:a25:f508:0:b0:66f:3c5f:c39f with SMTP id
 a8-20020a25f508000000b0066f3c5fc39fmr24891200ybe.374.1658135275708; Mon, 18
 Jul 2022 02:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220712021527.109921-1-lihuafei1@huawei.com> <20220712021527.109921-4-lihuafei1@huawei.com>
In-Reply-To: <20220712021527.109921-4-lihuafei1@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 11:07:43 +0200
Message-ID: <CACRpkdYvOjfmf=Z3pGfD-UPxfTc9PXtOyw2x+ptYiSy=gmGnpQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] ARM: stacktrace: Allow stack trace saving for
 non-current tasks
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, ardb@kernel.org,
        will@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, arnd@arndb.de, rostedt@goodmis.org,
        nick.hawkins@hpe.com, john@phrozen.org, mhiramat@kernel.org,
        ast@kernel.org, linyujun809@huawei.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 4:18 AM Li Huafei <lihuafei1@huawei.com> wrote:

> The current ARM implementation of save_stack_trace_tsk() does not allow
> saving stack trace for non-current tasks, which may limit the scenarios
> in which stack_trace_save_tsk() can be used. Like other architectures,
> or like ARM's unwind_backtrace(), we can leave it up to the caller to
> ensure that the task that needs to be unwound is not running.
>
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>

That sounds good, but:

>         if (tsk != current) {
> -#ifdef CONFIG_SMP
> -               /*
> -                * What guarantees do we have here that 'tsk' is not
> -                * running on another CPU?  For now, ignore it as we
> -                * can't guarantee we won't explode.
> -                */
> -               return;
> -#else
> +               /* task blocked in __switch_to */

The commit text is not consistent with the comment you are removing.

The commit is talking about "non-current" tasks which is one thing,
but the code is avoiding any tasks under SMP because they may be
running on another CPU. So you need to update the commit
message to say something like "non-current or running on another CPU".

If this condition will be checked at call sites in following patches,
then mention
that in the commit as well, so we know the end result is that we do
not break it,

I think Russell want to check this commit as well,

Yours,
Linus Walleij
