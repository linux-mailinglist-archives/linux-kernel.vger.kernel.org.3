Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D74472F97
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbhLMOmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbhLMOmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:42:42 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B89C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 06:42:42 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id c4so27398805wrd.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 06:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zgOIUdqJjG5ZtlkbyxdaTIfhj8DMFPe0mkZOhLS2Xg8=;
        b=b3rRWh8SMEK8h6rzG2ZGzB0fjERqsuvsOdvIG+PcBpWw8+u4rL4vcTnHtQMDgNn4kP
         yv1xQDFS38yL83jeDtvDPPHyGGZcKrPKNG7e7z1guhHqsZf5FM9myJ2qfGFpie3ygIOJ
         Ak67/81hHCYFWUP0ZYKJbukaxdlbYHSiOQF9zadr4v6tV8HTqyDVHW4Fn/PP1ohUMaSn
         2cH80r2S+BqAw1uHAio5shlF4DRd2ygWpvLz+EMp7DPMD5+vzU9pYtt5NDF6sJpxkI8F
         PRGgtghQ5h1inI349aFXuSk0lzt/HUQ1lJkOmw1tjB0vMLpz1szCs2rBtKI+WY9nnxpz
         BftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zgOIUdqJjG5ZtlkbyxdaTIfhj8DMFPe0mkZOhLS2Xg8=;
        b=IONSKHFT1WfjV9QxHupxwiF7TkZ7K3cNwbbCLFNCsVGXYMDZLM8OuWIWqWf6IxT+yn
         kN523/6/no9qfP9uoWrYoEwlX99vQlhnKVzxHeUZ9oxQsI8WvvYQ1LynRnE6TMF1QPkL
         4vD8GRx5vKbk5Mxu302k3raQIGzEBbfUp654joxFI2eTpksC9VvO0kpfX8c15HXPPV1L
         mYMNYKZ8T0HzsiJpOHODFC0Bcbd4OaGWMsD9t0W+6JboH9qpzxlyQ176cTviJlXwVZPz
         w7x6hgDIqaoPOehYIun79Xf4D0M2a+sOdYvntLujqiKkz0plPr0DaXRa8FxDeYZgvgQB
         nH+g==
X-Gm-Message-State: AOAM532NZYrKFS3vgBQEx+7f4369NyNAAyuc5EEQObDseTm46hwZs3rk
        tYuRDFC0FoanH1+sCIRtxy9hZw==
X-Google-Smtp-Source: ABdhPJwzLGSlV/2nHo1AttYkIgW7kO86OjSgIdpV9/Em1xgKiW1IGzgCSSnNLdG45VAaiR+uRN0wkg==
X-Received: by 2002:a5d:624f:: with SMTP id m15mr31852490wrv.13.1639406560559;
        Mon, 13 Dec 2021 06:42:40 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:984e:fd4e:47c7:18be])
        by smtp.gmail.com with ESMTPSA id m3sm11071715wrv.95.2021.12.13.06.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 06:42:39 -0800 (PST)
Date:   Mon, 13 Dec 2021 15:42:34 +0100
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mark.rutland@arm.com,
        keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org, axboe@kernel.dk, paulmck@kernel.org
Subject: Re: [PATCH v2 0/9] refcount: Improve code-gen
Message-ID: <Ybdb2g63B3ZeJ0LR@elver.google.com>
References: <20211210161618.645249719@infradead.org>
 <Ybc6dDpZ/lxwlUqA@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybc6dDpZ/lxwlUqA@hirez.programming.kicks-ass.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 01:20PM +0100, Peter Zijlstra wrote:
> 
> Also, since this will conflict most mighty with Marco's kcsan work in
> the rcu tree, I've written the below patch as a replacement for the
> instrumentation patch in that series.
> 
> It depends on other bits in that series so it cannot be applied here,
> but will come in handy when trying to resolve the merge conflict.
> 
> ---
> Subject: locking/atomics, kcsan: Add instrumentation for barriers
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu Dec 9 17:08:16 CET 2021
> 
> Adds the required KCSAN instrumentation for barriers of atomics.
> 
> [adapted from https://lkml.kernel.org/r/20211130114433.2580590-17-elver@google.com]
> Originally-by: Marco Elver <elver@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks!

I wanted to test this, but can't quite figure out which branches I need
to merge together to get it to apply. I assume -rcu + your series? Or
the updated series not yet sent?

In any case, I'm expecting the merge conflict will occur when -rcu/kcsan
is merged into -tip/locking at some point (but also -next before that).

Thanks,
-- Marco

> ---
>  include/linux/atomic/atomic-instrumented.h |  141 ++++++++++++++++++++++++++++-
>  scripts/atomic/atomic-tbl.sh               |    6 +
>  scripts/atomic/gen-atomic-instrumented.sh  |   30 ++++--
>  3 files changed, 169 insertions(+), 8 deletions(-)
> 
> --- a/include/linux/atomic/atomic-instrumented.h
> +++ b/include/linux/atomic/atomic-instrumented.h
> @@ -45,6 +45,7 @@ atomic_set(atomic_t *v, int i)
>  static __always_inline void
>  atomic_set_release(atomic_t *v, int i)
>  {
> +	kcsan_release();
>  	instrument_atomic_write(v, sizeof(*v));
>  	arch_atomic_set_release(v, i);
>  }
> @@ -59,6 +60,7 @@ atomic_add(int i, atomic_t *v)
>  static __always_inline int
>  atomic_add_return(int i, atomic_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_add_return(i, v);
>  }
> @@ -73,6 +75,7 @@ atomic_add_return_acquire(int i, atomic_
>  static __always_inline int
>  atomic_add_return_release(int i, atomic_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_add_return_release(i, v);
>  }
> @@ -87,6 +90,7 @@ atomic_add_return_relaxed(int i, atomic_
>  static __always_inline int
>  atomic_fetch_add(int i, atomic_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_fetch_add(i, v);
>  }
> @@ -101,6 +105,7 @@ atomic_fetch_add_acquire(int i, atomic_t
>  static __always_inline int
>  atomic_fetch_add_release(int i, atomic_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_fetch_add_release(i, v);
>  }
> @@ -122,6 +127,7 @@ atomic_sub(int i, atomic_t *v)
>  static __always_inline int
>  atomic_sub_return(int i, atomic_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_sub_return(i, v);
>  }
> @@ -136,6 +142,7 @@ atomic_sub_return_acquire(int i, atomic_
>  static __always_inline int
>  atomic_sub_return_release(int i, atomic_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_sub_return_release(i, v);
>  }
> @@ -150,6 +157,7 @@ atomic_sub_return_relaxed(int i, atomic_
>  static __always_inline int
>  atomic_fetch_sub(int i, atomic_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_fetch_sub(i, v);
>  }
> @@ -164,6 +172,7 @@ atomic_fetch_sub_acquire(int i, atomic_t
>  static __always_inline int
>  atomic_fetch_sub_release(int i, atomic_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_fetch_sub_release(i, v);
>  }
> @@ -185,6 +194,7 @@ atomic_inc(atomic_t *v)
>  static __always_inline int
>  atomic_inc_return(atomic_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_inc_return(v);
>  }
> @@ -199,6 +209,7 @@ atomic_inc_return_acquire(atomic_t *v)
>  static __always_inline int
>  atomic_inc_return_release(atomic_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_inc_return_release(v);
>  }
> @@ -213,6 +224,7 @@ atomic_inc_return_relaxed(atomic_t *v)
>  static __always_inline int
>  atomic_fetch_inc(atomic_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_fetch_inc(v);
>  }
> @@ -227,6 +239,7 @@ atomic_fetch_inc_acquire(atomic_t *v)
>  static __always_inline int
>  atomic_fetch_inc_release(atomic_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_fetch_inc_release(v);
>  }
> @@ -248,6 +261,7 @@ atomic_dec(atomic_t *v)
>  static __always_inline int
>  atomic_dec_return(atomic_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_dec_return(v);
>  }
> @@ -262,6 +276,7 @@ atomic_dec_return_acquire(atomic_t *v)
>  static __always_inline int
>  atomic_dec_return_release(atomic_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_dec_return_release(v);
>  }
> @@ -276,6 +291,7 @@ atomic_dec_return_relaxed(atomic_t *v)
>  static __always_inline int
>  atomic_fetch_dec(atomic_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_fetch_dec(v);
>  }
> @@ -290,6 +306,7 @@ atomic_fetch_dec_acquire(atomic_t *v)
>  static __always_inline int
>  atomic_fetch_dec_release(atomic_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_fetch_dec_release(v);
>  }
> @@ -311,6 +328,7 @@ atomic_and(int i, atomic_t *v)
>  static __always_inline int
>  atomic_fetch_and(int i, atomic_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_fetch_and(i, v);
>  }
> @@ -325,6 +343,7 @@ atomic_fetch_and_acquire(int i, atomic_t
>  static __always_inline int
>  atomic_fetch_and_release(int i, atomic_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_fetch_and_release(i, v);
>  }
> @@ -346,6 +365,7 @@ atomic_andnot(int i, atomic_t *v)
>  static __always_inline int
>  atomic_fetch_andnot(int i, atomic_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_fetch_andnot(i, v);
>  }
> @@ -360,6 +380,7 @@ atomic_fetch_andnot_acquire(int i, atomi
>  static __always_inline int
>  atomic_fetch_andnot_release(int i, atomic_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_fetch_andnot_release(i, v);
>  }
> @@ -381,6 +402,7 @@ atomic_or(int i, atomic_t *v)
>  static __always_inline int
>  atomic_fetch_or(int i, atomic_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_fetch_or(i, v);
>  }
> @@ -395,6 +417,7 @@ atomic_fetch_or_acquire(int i, atomic_t
>  static __always_inline int
>  atomic_fetch_or_release(int i, atomic_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_fetch_or_release(i, v);
>  }
> @@ -416,6 +439,7 @@ atomic_xor(int i, atomic_t *v)
>  static __always_inline int
>  atomic_fetch_xor(int i, atomic_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_fetch_xor(i, v);
>  }
> @@ -430,6 +454,7 @@ atomic_fetch_xor_acquire(int i, atomic_t
>  static __always_inline int
>  atomic_fetch_xor_release(int i, atomic_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_fetch_xor_release(i, v);
>  }
> @@ -444,6 +469,7 @@ atomic_fetch_xor_relaxed(int i, atomic_t
>  static __always_inline int
>  atomic_xchg(atomic_t *v, int i)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_xchg(v, i);
>  }
> @@ -458,6 +484,7 @@ atomic_xchg_acquire(atomic_t *v, int i)
>  static __always_inline int
>  atomic_xchg_release(atomic_t *v, int i)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_xchg_release(v, i);
>  }
> @@ -472,6 +499,7 @@ atomic_xchg_relaxed(atomic_t *v, int i)
>  static __always_inline int
>  atomic_cmpxchg(atomic_t *v, int old, int new)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_cmpxchg(v, old, new);
>  }
> @@ -486,6 +514,7 @@ atomic_cmpxchg_acquire(atomic_t *v, int
>  static __always_inline int
>  atomic_cmpxchg_release(atomic_t *v, int old, int new)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_cmpxchg_release(v, old, new);
>  }
> @@ -500,6 +529,7 @@ atomic_cmpxchg_relaxed(atomic_t *v, int
>  static __always_inline bool
>  atomic_try_cmpxchg(atomic_t *v, int *old, int new)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	instrument_read_write(old, sizeof(*old));
>  	return arch_atomic_try_cmpxchg(v, old, new);
> @@ -516,6 +546,7 @@ atomic_try_cmpxchg_acquire(atomic_t *v,
>  static __always_inline bool
>  atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	instrument_read_write(old, sizeof(*old));
>  	return arch_atomic_try_cmpxchg_release(v, old, new);
> @@ -532,6 +563,7 @@ atomic_try_cmpxchg_relaxed(atomic_t *v,
>  static __always_inline bool
>  atomic_sub_and_test(int i, atomic_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_sub_and_test(i, v);
>  }
> @@ -539,6 +571,7 @@ atomic_sub_and_test(int i, atomic_t *v)
>  static __always_inline bool
>  atomic_dec_and_test(atomic_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_dec_and_test(v);
>  }
> @@ -546,6 +579,7 @@ atomic_dec_and_test(atomic_t *v)
>  static __always_inline bool
>  atomic_inc_and_test(atomic_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_inc_and_test(v);
>  }
> @@ -553,6 +587,7 @@ atomic_inc_and_test(atomic_t *v)
>  static __always_inline bool
>  atomic_add_negative(int i, atomic_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_add_negative(i, v);
>  }
> @@ -560,6 +595,7 @@ atomic_add_negative(int i, atomic_t *v)
>  static __always_inline int
>  atomic_fetch_add_unless(atomic_t *v, int a, int u)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_fetch_add_unless(v, a, u);
>  }
> @@ -567,6 +603,7 @@ atomic_fetch_add_unless(atomic_t *v, int
>  static __always_inline bool
>  atomic_add_unless(atomic_t *v, int a, int u)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_add_unless(v, a, u);
>  }
> @@ -574,6 +611,7 @@ atomic_add_unless(atomic_t *v, int a, in
>  static __always_inline bool
>  atomic_inc_not_zero(atomic_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_inc_not_zero(v);
>  }
> @@ -581,6 +619,7 @@ atomic_inc_not_zero(atomic_t *v)
>  static __always_inline bool
>  atomic_inc_unless_negative(atomic_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_inc_unless_negative(v);
>  }
> @@ -588,6 +627,7 @@ atomic_inc_unless_negative(atomic_t *v)
>  static __always_inline bool
>  atomic_dec_unless_positive(atomic_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_dec_unless_positive(v);
>  }
> @@ -595,6 +635,7 @@ atomic_dec_unless_positive(atomic_t *v)
>  static __always_inline int
>  atomic_dec_if_positive(atomic_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_dec_if_positive(v);
>  }
> @@ -616,6 +657,7 @@ atomic_dec_if_positive(atomic_t *v)
>  #define atomic_dec_and_test_ofl(v, L) \
>  ({ \
>  	typeof(v) __ai_v = (v); \
> +	kcsan_mb(); \
>  	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
>  	arch_atomic_dec_and_test_ofl(__ai_v, L); \
>  })
> @@ -644,6 +686,7 @@ atomic64_set(atomic64_t *v, s64 i)
>  static __always_inline void
>  atomic64_set_release(atomic64_t *v, s64 i)
>  {
> +	kcsan_release();
>  	instrument_atomic_write(v, sizeof(*v));
>  	arch_atomic64_set_release(v, i);
>  }
> @@ -658,6 +701,7 @@ atomic64_add(s64 i, atomic64_t *v)
>  static __always_inline s64
>  atomic64_add_return(s64 i, atomic64_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_add_return(i, v);
>  }
> @@ -672,6 +716,7 @@ atomic64_add_return_acquire(s64 i, atomi
>  static __always_inline s64
>  atomic64_add_return_release(s64 i, atomic64_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_add_return_release(i, v);
>  }
> @@ -686,6 +731,7 @@ atomic64_add_return_relaxed(s64 i, atomi
>  static __always_inline s64
>  atomic64_fetch_add(s64 i, atomic64_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_fetch_add(i, v);
>  }
> @@ -700,6 +746,7 @@ atomic64_fetch_add_acquire(s64 i, atomic
>  static __always_inline s64
>  atomic64_fetch_add_release(s64 i, atomic64_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_fetch_add_release(i, v);
>  }
> @@ -721,6 +768,7 @@ atomic64_sub(s64 i, atomic64_t *v)
>  static __always_inline s64
>  atomic64_sub_return(s64 i, atomic64_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_sub_return(i, v);
>  }
> @@ -735,6 +783,7 @@ atomic64_sub_return_acquire(s64 i, atomi
>  static __always_inline s64
>  atomic64_sub_return_release(s64 i, atomic64_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_sub_return_release(i, v);
>  }
> @@ -749,6 +798,7 @@ atomic64_sub_return_relaxed(s64 i, atomi
>  static __always_inline s64
>  atomic64_fetch_sub(s64 i, atomic64_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_fetch_sub(i, v);
>  }
> @@ -763,6 +813,7 @@ atomic64_fetch_sub_acquire(s64 i, atomic
>  static __always_inline s64
>  atomic64_fetch_sub_release(s64 i, atomic64_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_fetch_sub_release(i, v);
>  }
> @@ -784,6 +835,7 @@ atomic64_inc(atomic64_t *v)
>  static __always_inline s64
>  atomic64_inc_return(atomic64_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_inc_return(v);
>  }
> @@ -798,6 +850,7 @@ atomic64_inc_return_acquire(atomic64_t *
>  static __always_inline s64
>  atomic64_inc_return_release(atomic64_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_inc_return_release(v);
>  }
> @@ -812,6 +865,7 @@ atomic64_inc_return_relaxed(atomic64_t *
>  static __always_inline s64
>  atomic64_fetch_inc(atomic64_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_fetch_inc(v);
>  }
> @@ -826,6 +880,7 @@ atomic64_fetch_inc_acquire(atomic64_t *v
>  static __always_inline s64
>  atomic64_fetch_inc_release(atomic64_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_fetch_inc_release(v);
>  }
> @@ -847,6 +902,7 @@ atomic64_dec(atomic64_t *v)
>  static __always_inline s64
>  atomic64_dec_return(atomic64_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_dec_return(v);
>  }
> @@ -861,6 +917,7 @@ atomic64_dec_return_acquire(atomic64_t *
>  static __always_inline s64
>  atomic64_dec_return_release(atomic64_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_dec_return_release(v);
>  }
> @@ -875,6 +932,7 @@ atomic64_dec_return_relaxed(atomic64_t *
>  static __always_inline s64
>  atomic64_fetch_dec(atomic64_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_fetch_dec(v);
>  }
> @@ -889,6 +947,7 @@ atomic64_fetch_dec_acquire(atomic64_t *v
>  static __always_inline s64
>  atomic64_fetch_dec_release(atomic64_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_fetch_dec_release(v);
>  }
> @@ -910,6 +969,7 @@ atomic64_and(s64 i, atomic64_t *v)
>  static __always_inline s64
>  atomic64_fetch_and(s64 i, atomic64_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_fetch_and(i, v);
>  }
> @@ -924,6 +984,7 @@ atomic64_fetch_and_acquire(s64 i, atomic
>  static __always_inline s64
>  atomic64_fetch_and_release(s64 i, atomic64_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_fetch_and_release(i, v);
>  }
> @@ -945,6 +1006,7 @@ atomic64_andnot(s64 i, atomic64_t *v)
>  static __always_inline s64
>  atomic64_fetch_andnot(s64 i, atomic64_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_fetch_andnot(i, v);
>  }
> @@ -959,6 +1021,7 @@ atomic64_fetch_andnot_acquire(s64 i, ato
>  static __always_inline s64
>  atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_fetch_andnot_release(i, v);
>  }
> @@ -980,6 +1043,7 @@ atomic64_or(s64 i, atomic64_t *v)
>  static __always_inline s64
>  atomic64_fetch_or(s64 i, atomic64_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_fetch_or(i, v);
>  }
> @@ -994,6 +1058,7 @@ atomic64_fetch_or_acquire(s64 i, atomic6
>  static __always_inline s64
>  atomic64_fetch_or_release(s64 i, atomic64_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_fetch_or_release(i, v);
>  }
> @@ -1015,6 +1080,7 @@ atomic64_xor(s64 i, atomic64_t *v)
>  static __always_inline s64
>  atomic64_fetch_xor(s64 i, atomic64_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_fetch_xor(i, v);
>  }
> @@ -1029,6 +1095,7 @@ atomic64_fetch_xor_acquire(s64 i, atomic
>  static __always_inline s64
>  atomic64_fetch_xor_release(s64 i, atomic64_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_fetch_xor_release(i, v);
>  }
> @@ -1043,6 +1110,7 @@ atomic64_fetch_xor_relaxed(s64 i, atomic
>  static __always_inline s64
>  atomic64_xchg(atomic64_t *v, s64 i)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_xchg(v, i);
>  }
> @@ -1057,6 +1125,7 @@ atomic64_xchg_acquire(atomic64_t *v, s64
>  static __always_inline s64
>  atomic64_xchg_release(atomic64_t *v, s64 i)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_xchg_release(v, i);
>  }
> @@ -1071,6 +1140,7 @@ atomic64_xchg_relaxed(atomic64_t *v, s64
>  static __always_inline s64
>  atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_cmpxchg(v, old, new);
>  }
> @@ -1085,6 +1155,7 @@ atomic64_cmpxchg_acquire(atomic64_t *v,
>  static __always_inline s64
>  atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_cmpxchg_release(v, old, new);
>  }
> @@ -1099,6 +1170,7 @@ atomic64_cmpxchg_relaxed(atomic64_t *v,
>  static __always_inline bool
>  atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	instrument_read_write(old, sizeof(*old));
>  	return arch_atomic64_try_cmpxchg(v, old, new);
> @@ -1115,6 +1187,7 @@ atomic64_try_cmpxchg_acquire(atomic64_t
>  static __always_inline bool
>  atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	instrument_read_write(old, sizeof(*old));
>  	return arch_atomic64_try_cmpxchg_release(v, old, new);
> @@ -1131,6 +1204,7 @@ atomic64_try_cmpxchg_relaxed(atomic64_t
>  static __always_inline bool
>  atomic64_sub_and_test(s64 i, atomic64_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_sub_and_test(i, v);
>  }
> @@ -1138,6 +1212,7 @@ atomic64_sub_and_test(s64 i, atomic64_t
>  static __always_inline bool
>  atomic64_dec_and_test(atomic64_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_dec_and_test(v);
>  }
> @@ -1145,6 +1220,7 @@ atomic64_dec_and_test(atomic64_t *v)
>  static __always_inline bool
>  atomic64_inc_and_test(atomic64_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_inc_and_test(v);
>  }
> @@ -1152,6 +1228,7 @@ atomic64_inc_and_test(atomic64_t *v)
>  static __always_inline bool
>  atomic64_add_negative(s64 i, atomic64_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_add_negative(i, v);
>  }
> @@ -1159,6 +1236,7 @@ atomic64_add_negative(s64 i, atomic64_t
>  static __always_inline s64
>  atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_fetch_add_unless(v, a, u);
>  }
> @@ -1166,6 +1244,7 @@ atomic64_fetch_add_unless(atomic64_t *v,
>  static __always_inline bool
>  atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_add_unless(v, a, u);
>  }
> @@ -1173,6 +1252,7 @@ atomic64_add_unless(atomic64_t *v, s64 a
>  static __always_inline bool
>  atomic64_inc_not_zero(atomic64_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_inc_not_zero(v);
>  }
> @@ -1180,6 +1260,7 @@ atomic64_inc_not_zero(atomic64_t *v)
>  static __always_inline bool
>  atomic64_inc_unless_negative(atomic64_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_inc_unless_negative(v);
>  }
> @@ -1187,6 +1268,7 @@ atomic64_inc_unless_negative(atomic64_t
>  static __always_inline bool
>  atomic64_dec_unless_positive(atomic64_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_dec_unless_positive(v);
>  }
> @@ -1194,6 +1276,7 @@ atomic64_dec_unless_positive(atomic64_t
>  static __always_inline s64
>  atomic64_dec_if_positive(atomic64_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic64_dec_if_positive(v);
>  }
> @@ -1215,6 +1298,7 @@ atomic64_dec_if_positive(atomic64_t *v)
>  #define atomic64_dec_and_test_ofl(v, L) \
>  ({ \
>  	typeof(v) __ai_v = (v); \
> +	kcsan_mb(); \
>  	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
>  	arch_atomic64_dec_and_test_ofl(__ai_v, L); \
>  })
> @@ -1243,6 +1327,7 @@ atomic_long_set(atomic_long_t *v, long i
>  static __always_inline void
>  atomic_long_set_release(atomic_long_t *v, long i)
>  {
> +	kcsan_release();
>  	instrument_atomic_write(v, sizeof(*v));
>  	arch_atomic_long_set_release(v, i);
>  }
> @@ -1257,6 +1342,7 @@ atomic_long_add(long i, atomic_long_t *v
>  static __always_inline long
>  atomic_long_add_return(long i, atomic_long_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_add_return(i, v);
>  }
> @@ -1271,6 +1357,7 @@ atomic_long_add_return_acquire(long i, a
>  static __always_inline long
>  atomic_long_add_return_release(long i, atomic_long_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_add_return_release(i, v);
>  }
> @@ -1285,6 +1372,7 @@ atomic_long_add_return_relaxed(long i, a
>  static __always_inline long
>  atomic_long_fetch_add(long i, atomic_long_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_fetch_add(i, v);
>  }
> @@ -1299,6 +1387,7 @@ atomic_long_fetch_add_acquire(long i, at
>  static __always_inline long
>  atomic_long_fetch_add_release(long i, atomic_long_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_fetch_add_release(i, v);
>  }
> @@ -1320,6 +1409,7 @@ atomic_long_sub(long i, atomic_long_t *v
>  static __always_inline long
>  atomic_long_sub_return(long i, atomic_long_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_sub_return(i, v);
>  }
> @@ -1334,6 +1424,7 @@ atomic_long_sub_return_acquire(long i, a
>  static __always_inline long
>  atomic_long_sub_return_release(long i, atomic_long_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_sub_return_release(i, v);
>  }
> @@ -1348,6 +1439,7 @@ atomic_long_sub_return_relaxed(long i, a
>  static __always_inline long
>  atomic_long_fetch_sub(long i, atomic_long_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_fetch_sub(i, v);
>  }
> @@ -1362,6 +1454,7 @@ atomic_long_fetch_sub_acquire(long i, at
>  static __always_inline long
>  atomic_long_fetch_sub_release(long i, atomic_long_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_fetch_sub_release(i, v);
>  }
> @@ -1383,6 +1476,7 @@ atomic_long_inc(atomic_long_t *v)
>  static __always_inline long
>  atomic_long_inc_return(atomic_long_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_inc_return(v);
>  }
> @@ -1397,6 +1491,7 @@ atomic_long_inc_return_acquire(atomic_lo
>  static __always_inline long
>  atomic_long_inc_return_release(atomic_long_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_inc_return_release(v);
>  }
> @@ -1411,6 +1506,7 @@ atomic_long_inc_return_relaxed(atomic_lo
>  static __always_inline long
>  atomic_long_fetch_inc(atomic_long_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_fetch_inc(v);
>  }
> @@ -1425,6 +1521,7 @@ atomic_long_fetch_inc_acquire(atomic_lon
>  static __always_inline long
>  atomic_long_fetch_inc_release(atomic_long_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_fetch_inc_release(v);
>  }
> @@ -1446,6 +1543,7 @@ atomic_long_dec(atomic_long_t *v)
>  static __always_inline long
>  atomic_long_dec_return(atomic_long_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_dec_return(v);
>  }
> @@ -1460,6 +1558,7 @@ atomic_long_dec_return_acquire(atomic_lo
>  static __always_inline long
>  atomic_long_dec_return_release(atomic_long_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_dec_return_release(v);
>  }
> @@ -1474,6 +1573,7 @@ atomic_long_dec_return_relaxed(atomic_lo
>  static __always_inline long
>  atomic_long_fetch_dec(atomic_long_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_fetch_dec(v);
>  }
> @@ -1488,6 +1588,7 @@ atomic_long_fetch_dec_acquire(atomic_lon
>  static __always_inline long
>  atomic_long_fetch_dec_release(atomic_long_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_fetch_dec_release(v);
>  }
> @@ -1509,6 +1610,7 @@ atomic_long_and(long i, atomic_long_t *v
>  static __always_inline long
>  atomic_long_fetch_and(long i, atomic_long_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_fetch_and(i, v);
>  }
> @@ -1523,6 +1625,7 @@ atomic_long_fetch_and_acquire(long i, at
>  static __always_inline long
>  atomic_long_fetch_and_release(long i, atomic_long_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_fetch_and_release(i, v);
>  }
> @@ -1544,6 +1647,7 @@ atomic_long_andnot(long i, atomic_long_t
>  static __always_inline long
>  atomic_long_fetch_andnot(long i, atomic_long_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_fetch_andnot(i, v);
>  }
> @@ -1558,6 +1662,7 @@ atomic_long_fetch_andnot_acquire(long i,
>  static __always_inline long
>  atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_fetch_andnot_release(i, v);
>  }
> @@ -1579,6 +1684,7 @@ atomic_long_or(long i, atomic_long_t *v)
>  static __always_inline long
>  atomic_long_fetch_or(long i, atomic_long_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_fetch_or(i, v);
>  }
> @@ -1593,6 +1699,7 @@ atomic_long_fetch_or_acquire(long i, ato
>  static __always_inline long
>  atomic_long_fetch_or_release(long i, atomic_long_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_fetch_or_release(i, v);
>  }
> @@ -1614,6 +1721,7 @@ atomic_long_xor(long i, atomic_long_t *v
>  static __always_inline long
>  atomic_long_fetch_xor(long i, atomic_long_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_fetch_xor(i, v);
>  }
> @@ -1628,6 +1736,7 @@ atomic_long_fetch_xor_acquire(long i, at
>  static __always_inline long
>  atomic_long_fetch_xor_release(long i, atomic_long_t *v)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_fetch_xor_release(i, v);
>  }
> @@ -1642,6 +1751,7 @@ atomic_long_fetch_xor_relaxed(long i, at
>  static __always_inline long
>  atomic_long_xchg(atomic_long_t *v, long i)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_xchg(v, i);
>  }
> @@ -1656,6 +1766,7 @@ atomic_long_xchg_acquire(atomic_long_t *
>  static __always_inline long
>  atomic_long_xchg_release(atomic_long_t *v, long i)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_xchg_release(v, i);
>  }
> @@ -1670,6 +1781,7 @@ atomic_long_xchg_relaxed(atomic_long_t *
>  static __always_inline long
>  atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_cmpxchg(v, old, new);
>  }
> @@ -1684,6 +1796,7 @@ atomic_long_cmpxchg_acquire(atomic_long_
>  static __always_inline long
>  atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_cmpxchg_release(v, old, new);
>  }
> @@ -1698,6 +1811,7 @@ atomic_long_cmpxchg_relaxed(atomic_long_
>  static __always_inline bool
>  atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	instrument_read_write(old, sizeof(*old));
>  	return arch_atomic_long_try_cmpxchg(v, old, new);
> @@ -1714,6 +1828,7 @@ atomic_long_try_cmpxchg_acquire(atomic_l
>  static __always_inline bool
>  atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
>  {
> +	kcsan_release();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	instrument_read_write(old, sizeof(*old));
>  	return arch_atomic_long_try_cmpxchg_release(v, old, new);
> @@ -1730,6 +1845,7 @@ atomic_long_try_cmpxchg_relaxed(atomic_l
>  static __always_inline bool
>  atomic_long_sub_and_test(long i, atomic_long_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_sub_and_test(i, v);
>  }
> @@ -1737,6 +1853,7 @@ atomic_long_sub_and_test(long i, atomic_
>  static __always_inline bool
>  atomic_long_dec_and_test(atomic_long_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_dec_and_test(v);
>  }
> @@ -1744,6 +1861,7 @@ atomic_long_dec_and_test(atomic_long_t *
>  static __always_inline bool
>  atomic_long_inc_and_test(atomic_long_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_inc_and_test(v);
>  }
> @@ -1751,6 +1869,7 @@ atomic_long_inc_and_test(atomic_long_t *
>  static __always_inline bool
>  atomic_long_add_negative(long i, atomic_long_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_add_negative(i, v);
>  }
> @@ -1758,6 +1877,7 @@ atomic_long_add_negative(long i, atomic_
>  static __always_inline long
>  atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_fetch_add_unless(v, a, u);
>  }
> @@ -1765,6 +1885,7 @@ atomic_long_fetch_add_unless(atomic_long
>  static __always_inline bool
>  atomic_long_add_unless(atomic_long_t *v, long a, long u)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_add_unless(v, a, u);
>  }
> @@ -1772,6 +1893,7 @@ atomic_long_add_unless(atomic_long_t *v,
>  static __always_inline bool
>  atomic_long_inc_not_zero(atomic_long_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_inc_not_zero(v);
>  }
> @@ -1779,6 +1901,7 @@ atomic_long_inc_not_zero(atomic_long_t *
>  static __always_inline bool
>  atomic_long_inc_unless_negative(atomic_long_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_inc_unless_negative(v);
>  }
> @@ -1786,6 +1909,7 @@ atomic_long_inc_unless_negative(atomic_l
>  static __always_inline bool
>  atomic_long_dec_unless_positive(atomic_long_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_dec_unless_positive(v);
>  }
> @@ -1793,6 +1917,7 @@ atomic_long_dec_unless_positive(atomic_l
>  static __always_inline long
>  atomic_long_dec_if_positive(atomic_long_t *v)
>  {
> +	kcsan_mb();
>  	instrument_atomic_read_write(v, sizeof(*v));
>  	return arch_atomic_long_dec_if_positive(v);
>  }
> @@ -1814,6 +1939,7 @@ atomic_long_dec_if_positive(atomic_long_
>  #define atomic_long_dec_and_test_ofl(v, L) \
>  ({ \
>  	typeof(v) __ai_v = (v); \
> +	kcsan_mb(); \
>  	instrument_atomic_read_write(__ai_v, sizeof(*__ai_v)); \
>  	arch_atomic_long_dec_and_test_ofl(__ai_v, L); \
>  })
> @@ -1821,6 +1947,7 @@ atomic_long_dec_if_positive(atomic_long_
>  #define xchg(ptr, ...) \
>  ({ \
>  	typeof(ptr) __ai_ptr = (ptr); \
> +	kcsan_mb(); \
>  	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>  	arch_xchg(__ai_ptr, __VA_ARGS__); \
>  })
> @@ -1835,6 +1962,7 @@ atomic_long_dec_if_positive(atomic_long_
>  #define xchg_release(ptr, ...) \
>  ({ \
>  	typeof(ptr) __ai_ptr = (ptr); \
> +	kcsan_release(); \
>  	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>  	arch_xchg_release(__ai_ptr, __VA_ARGS__); \
>  })
> @@ -1849,6 +1977,7 @@ atomic_long_dec_if_positive(atomic_long_
>  #define cmpxchg(ptr, ...) \
>  ({ \
>  	typeof(ptr) __ai_ptr = (ptr); \
> +	kcsan_mb(); \
>  	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>  	arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
>  })
> @@ -1863,6 +1992,7 @@ atomic_long_dec_if_positive(atomic_long_
>  #define cmpxchg_release(ptr, ...) \
>  ({ \
>  	typeof(ptr) __ai_ptr = (ptr); \
> +	kcsan_release(); \
>  	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>  	arch_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
>  })
> @@ -1877,6 +2007,7 @@ atomic_long_dec_if_positive(atomic_long_
>  #define cmpxchg64(ptr, ...) \
>  ({ \
>  	typeof(ptr) __ai_ptr = (ptr); \
> +	kcsan_mb(); \
>  	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>  	arch_cmpxchg64(__ai_ptr, __VA_ARGS__); \
>  })
> @@ -1891,6 +2022,7 @@ atomic_long_dec_if_positive(atomic_long_
>  #define cmpxchg64_release(ptr, ...) \
>  ({ \
>  	typeof(ptr) __ai_ptr = (ptr); \
> +	kcsan_release(); \
>  	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>  	arch_cmpxchg64_release(__ai_ptr, __VA_ARGS__); \
>  })
> @@ -1906,6 +2038,7 @@ atomic_long_dec_if_positive(atomic_long_
>  ({ \
>  	typeof(ptr) __ai_ptr = (ptr); \
>  	typeof(oldp) __ai_oldp = (oldp); \
> +	kcsan_mb(); \
>  	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>  	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
>  	arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> @@ -1924,6 +2057,7 @@ atomic_long_dec_if_positive(atomic_long_
>  ({ \
>  	typeof(ptr) __ai_ptr = (ptr); \
>  	typeof(oldp) __ai_oldp = (oldp); \
> +	kcsan_release(); \
>  	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>  	instrument_read_write(__ai_oldp, sizeof(*__ai_oldp)); \
>  	arch_try_cmpxchg_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> @@ -1941,6 +2075,7 @@ atomic_long_dec_if_positive(atomic_long_
>  #define cmpxchg_local(ptr, ...) \
>  ({ \
>  	typeof(ptr) __ai_ptr = (ptr); \
> +	kcsan_mb(); \
>  	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>  	arch_cmpxchg_local(__ai_ptr, __VA_ARGS__); \
>  })
> @@ -1948,6 +2083,7 @@ atomic_long_dec_if_positive(atomic_long_
>  #define cmpxchg64_local(ptr, ...) \
>  ({ \
>  	typeof(ptr) __ai_ptr = (ptr); \
> +	kcsan_mb(); \
>  	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>  	arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__); \
>  })
> @@ -1955,6 +2091,7 @@ atomic_long_dec_if_positive(atomic_long_
>  #define sync_cmpxchg(ptr, ...) \
>  ({ \
>  	typeof(ptr) __ai_ptr = (ptr); \
> +	kcsan_mb(); \
>  	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \
>  	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__); \
>  })
> @@ -1962,6 +2099,7 @@ atomic_long_dec_if_positive(atomic_long_
>  #define cmpxchg_double(ptr, ...) \
>  ({ \
>  	typeof(ptr) __ai_ptr = (ptr); \
> +	kcsan_mb(); \
>  	instrument_atomic_read_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
>  	arch_cmpxchg_double(__ai_ptr, __VA_ARGS__); \
>  })
> @@ -1969,10 +2107,11 @@ atomic_long_dec_if_positive(atomic_long_
>  #define cmpxchg_double_local(ptr, ...) \
>  ({ \
>  	typeof(ptr) __ai_ptr = (ptr); \
> +	kcsan_mb(); \
>  	instrument_atomic_read_write(__ai_ptr, 2 * sizeof(*__ai_ptr)); \
>  	arch_cmpxchg_double_local(__ai_ptr, __VA_ARGS__); \
>  })
>  
>  
>  #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
> -// ca9d985faafbba0e0827441def0f010d3040d62d
> +// 539756d4ae3f55016f5a2101983e0eed82a9b303
> --- a/scripts/atomic/atomic-tbl.sh
> +++ b/scripts/atomic/atomic-tbl.sh
> @@ -42,6 +42,12 @@ meta_has_macro()
>  	meta_in "$1" "mn"
>  }
>  
> +#meta_has_rmw(meta)
> +meta_has_rmw()
> +{
> +	! meta_in "$1" "sl"
> +}
> +
>  #find_fallback_template(pfx, name, sfx, order)
>  find_fallback_template()
>  {
> --- a/scripts/atomic/gen-atomic-instrumented.sh
> +++ b/scripts/atomic/gen-atomic-instrumented.sh
> @@ -5,6 +5,17 @@ ATOMICDIR=$(dirname $0)
>  
>  . ${ATOMICDIR}/atomic-tbl.sh
>  
> +#gen_linebreak(meta)
> +gen_linebreak()
> +{
> +	local meta="$1"; shift
> +
> +	if meta_has_macro "${meta}"; then
> +		printf " \\"
> +	fi
> +	printf "\n"
> +}
> +
>  #gen_param_check(meta, arg)
>  gen_param_check()
>  {
> @@ -38,17 +49,22 @@ gen_param_check()
>  	fi
>  
>  	printf "\tinstrument_${pfx}${rw}(${name}, ${mult}sizeof(*${name}));"
> -	if meta_has_macro "${meta}"; then
> -		printf " \\"
> -	fi
> -	printf "\n"
> -
> +	gen_linebreak "${meta}"
>  }
>  
> -#gen_params_checks(meta, arg...)
> +#gen_params_checks(meta, order, arg...)
>  gen_params_checks()
>  {
>  	local meta="$1"; shift
> +	local order="$1"; shift
> +
> +	if [ "${order}" = "_release" ]; then
> +		printf "\tkcsan_release();"
> +		gen_linebreak "${meta}"
> +	elif [ -z "${order}" ] && meta_has_rmw "${meta}" && meta_has_ret "${meta}"; then
> +		printf "\tkcsan_mb();"
> +		gen_linebreak "${meta}"
> +	fi
>  
>  	while [ "$#" -gt 0 ]; do
>  		gen_param_check "$meta" "$1"
> @@ -120,7 +136,7 @@ gen_proto_order_variant()
>  		atomicname="${pfx}${name}${sfx}${order}"
>  	fi
>  
> -	local checks="$(gen_params_checks "${meta}" "$@")"
> +	local checks="$(gen_params_checks "${meta}" "${order}" "$@")"
>  	local args="$(gen_args "$@")"
>  
>  	if meta_has_macro "${meta}"; then
