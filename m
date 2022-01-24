Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE33E497A24
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242115AbiAXIUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242113AbiAXIUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:20:30 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E36C06173D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:20:29 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 10-20020a9d030a000000b0059f164f4a86so3756804otv.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fe4pubot63aeTTcTlbwPRtQDcLp34onKse+sfKBfh3g=;
        b=hbC0p1HgxcZOO8c4bWIlLFPNxwvCGs6Ub4zMCdalps8HkcEOtggdMiekbyEPh6BfgO
         4uobjusmvFQj9LeEIgWb+tK8VZzkTQbdJg3hP/g+iEXPHcjv4rIUhbYxt+fJCq/5S7Vi
         oMuTLRyLsaqtbdEbkL0wBWIpQpgMJpvm+atEfWH+rpt50zQOIYrh/tU2xqe5t1nRbizp
         og7jrskWPDy65dLCj3eWex6wpg5E3BNSuplfpblwi6mf8pP16hdD8yqbb+833/0D7xew
         FQvVS34vXLTiIvNxMpFSFwhu5F9+m50cxLEn6saAs4oyrzq4K1VTO0PkpqRktNVzql6p
         et5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fe4pubot63aeTTcTlbwPRtQDcLp34onKse+sfKBfh3g=;
        b=CPTNKeC5Fk4YqfRc3Rk2yFjzpVVKMo58iNaR91GIQOvBWv3gN78Q3YtzrJq/Co4LSA
         ICv/fisrLcvyjGDQCTBhyHKNhHC+4YO0pESsJxoniiu8ZWfiSkqxdstYwl6+/6nW5rpR
         5veNQaM/9PWCI2FtwBYOmpXua/F/RWxL1TMJoqjadTDURWDUHA2OMx9imsUvgG41w2WK
         2DCixhwHyyLPXmeCUobj9UT0siE04JRrT9kR1iAtqJFMENR2u+VXlfBHSMQ+koxH1W+f
         cBOUoRocqK+0GQYPp765ndXcgL3RpIQthE6i54KtrcrrYbXJAWmM+eYDznZedo8An5G7
         t5+g==
X-Gm-Message-State: AOAM533WCiYyXFakbhIL1AYn2FneI+MieDPfrSU7puw5s+fXDCEpUQVd
        wUMkzdLdm51tbhdQ4VSuYXNIWo+TXYMkXpzx1X5MCA==
X-Google-Smtp-Source: ABdhPJwOSQbPzFSjnMIC0k8eXN8NZWLSv40CjBpajvpNz8+4iCNlxNVEC0V+MQKJlFwrUD/QSe/IcXsddnFctH+E070=
X-Received: by 2002:a9d:7053:: with SMTP id x19mr10625205otj.196.1643012428642;
 Mon, 24 Jan 2022 00:20:28 -0800 (PST)
MIME-Version: 1.0
References: <20220124025205.329752-1-liupeng256@huawei.com> <20220124025205.329752-3-liupeng256@huawei.com>
In-Reply-To: <20220124025205.329752-3-liupeng256@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 24 Jan 2022 09:20:17 +0100
Message-ID: <CANpmjNNBt8LazZMLH2_6rFc8u3bVpPNNyetV0fqmanwB5DLZPQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] kfence: Optimize branches prediction when sample
 interval is zero
To:     Peng Liu <liupeng256@huawei.com>
Cc:     glider@google.com, dvyukov@google.com, corbet@lwn.net,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        akpm@linux-foundation.org, kasan-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 at 03:37, Peng Liu <liupeng256@huawei.com> wrote:
>
> In order to release a uniform kernel with KFENCE, it is good to
> compile it with CONFIG_KFENCE_SAMPLE_INTERVAL = 0. For a group of
> produtions who don't want to use KFENCE, they can use kernel just
> as original vesion without KFENCE. For KFENCE users, they can open
> it by setting the kernel boot parameter kfence.sample_interval.
> Hence, set KFENCE sample interval default to zero is convenient.
>
> The current KFENCE is supportted to adjust sample interval via the
> kernel boot parameter. However, branches prediction in kfence_alloc
> is not good for situation with CONFIG_KFENCE_SAMPLE_INTERVAL = 0
> and boot parameter kfence.sample_interval != 0, which is because
> the current kfence_alloc is likely to return NULL when
> CONFIG_KFENCE_SAMPLE_INTERVAL = 0. To optimize branches prediction
> in this situation, kfence_enabled will check firstly.

This patch doesn't make any sense. You're adding an unconditional LOAD
to the fast path.

And the choice of static_branch_unlikely() if
CONFIG_KFENCE_SAMPLE_INTERVAL == 0 is very much deliberate, as it
generates code that is preferable in the common case (KFENCE is
disabled).

Please see include/linux/jump_label.h:430. But even then, CPUs are
very good at dealing with unconditional branches, so the difference
really is a wash.

But that new LOAD is not acceptable.

Sorry, but Nack.

> Signed-off-by: Peng Liu <liupeng256@huawei.com>
> ---
>  include/linux/kfence.h | 5 ++++-
>  mm/kfence/core.c       | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> index aec4f6b247b5..bf91b76b87ee 100644
> --- a/include/linux/kfence.h
> +++ b/include/linux/kfence.h
> @@ -17,6 +17,7 @@
>  #include <linux/atomic.h>
>  #include <linux/static_key.h>
>
> +extern bool kfence_enabled;
>  extern unsigned long kfence_num_objects;
>  /*
>   * We allocate an even number of pages, as it simplifies calculations to map
> @@ -115,7 +116,9 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags);
>   */
>  static __always_inline void *kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
>  {
> -#if defined(CONFIG_KFENCE_STATIC_KEYS) || CONFIG_KFENCE_SAMPLE_INTERVAL == 0
> +       if (!kfence_enabled)
> +               return NULL;
> +#if defined(CONFIG_KFENCE_STATIC_KEYS)
>         if (!static_branch_unlikely(&kfence_allocation_key))
>                 return NULL;
>  #else
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 4655bcc0306e..2301923182b8 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -48,7 +48,7 @@
>
>  /* === Data ================================================================= */
>
> -static bool kfence_enabled __read_mostly;
> +bool kfence_enabled __read_mostly;
>
>  static unsigned long kfence_sample_interval __read_mostly = CONFIG_KFENCE_SAMPLE_INTERVAL;
>
> --
> 2.18.0.huawei.25
>
