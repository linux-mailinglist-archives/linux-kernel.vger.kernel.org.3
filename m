Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6FD4D00BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242995AbiCGOJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiCGOJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:09:35 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110BE50069
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:08:41 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id w16so31133556ybi.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 06:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mfdVxCs2eXbpyZ6nxJcq9Zy4MImVpxL60Izt6BU+nxo=;
        b=SmeiVRFmQ8g7mSnedUz1LcG/NOWQj6Gt+IojkiZXTmkmrvv0y6aAlFY0bQO/Y/Axp7
         AGgdTaDFjm9G4t+WmfSjT5YXjWkvZgNF7Mrc55Y76TQ3jyiyeKByVXQtiX7UrpvgOw/K
         u8TmLiQw25oUjFD4KCsaD9eF9eYkQDDINBAuAJsLb2RZJVhByasnu4eFWAQJw+0nk1U2
         dOH7LXlBtQY5+mCaiSNtmOxYnWU6RDwLMfgieAE7jqfV17jRdDJJ5fiPNfaXjmnyTwDa
         XGXauRoPpOA9sxkfpvSavIN7wG2rkAubrwXldxomdxpuXIKuTpvoSxaHIRfXUf5SE3sR
         1E1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mfdVxCs2eXbpyZ6nxJcq9Zy4MImVpxL60Izt6BU+nxo=;
        b=fWxcm8Xzp+NyEENBOFQ9V2/KeNd7CBJzNC0SySvGa7S9CY70l4PIzJDhmKfeoJj3Pp
         2hkT9tfD8ZIyRhAOev5LTq0bUV419mIKXYSwzicsjdEmkSVGtYdANhaSDWc4JgwBn81K
         SedJihqNYQWOQrdjirRBUPW6ENn6/LhWpbhno4Nw05Q4bHjv9P2PCqtbwsH9POSeZMDu
         Z7hpwwdx4jQDHjowuHwCA8zzgccL7mg80JhCq0qf0Y8xVoOc97LmvVNB3jTQtwcVJUVl
         TY48mUFUMI/NwPZiruExnc8+C+ylyuBTyGYqbeXCDu0Z+BOtFu6uoSGGpRT3VCU4wPTS
         zUeA==
X-Gm-Message-State: AOAM533SvIWbO4ryibu5ezZjH0IvlvDvH1UitnsxQJxLndOrxBGx48Ij
        0mK7QPLpuCxGifDFR31X2/+0fusf0xF4TeaWNabIHOD/O40=
X-Google-Smtp-Source: ABdhPJx8r4SJMNl3A3gjJ+Oa5BbJgBlKte3tJgN1vRtLq3MCGTlNTu41PJNq1jmWd1EGf3FDC2heiu51uE6dpwP3Z4M=
X-Received: by 2002:a25:d50c:0:b0:627:660c:1874 with SMTP id
 r12-20020a25d50c000000b00627660c1874mr7642377ybe.625.1646662120116; Mon, 07
 Mar 2022 06:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20220307074516.6920-1-dtcccc@linux.alibaba.com> <20220307074516.6920-2-dtcccc@linux.alibaba.com>
In-Reply-To: <20220307074516.6920-2-dtcccc@linux.alibaba.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 7 Mar 2022 15:08:03 +0100
Message-ID: <CANpmjNNMQNd8LnCOaL0JXqS3r3Gv-DHrcw7Q6YvD6uWqnCz03Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kfence: Allow re-enabling KFENCE after system startup
To:     Tianchen Ding <dtcccc@linux.alibaba.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Mon, 7 Mar 2022 at 08:45, Tianchen Ding <dtcccc@linux.alibaba.com> wrote:
>
> If once KFENCE is disabled by:
> echo 0 > /sys/module/kfence/parameters/sample_interval
> KFENCE could never be re-enabled until next rebooting.
>
> Allow re-enabling it by writing a positive num to sample_interval.
>
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  mm/kfence/core.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 13128fa13062..caa4e84c8b79 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -38,14 +38,17 @@
>  #define KFENCE_WARN_ON(cond)                                                   \
>         ({                                                                     \
>                 const bool __cond = WARN_ON(cond);                             \
> -               if (unlikely(__cond))                                          \
> +               if (unlikely(__cond)) {                                        \
>                         WRITE_ONCE(kfence_enabled, false);                     \
> +                       disabled_by_warn = true;                               \
> +               }                                                              \
>                 __cond;                                                        \
>         })
>
>  /* === Data ================================================================= */
>
>  static bool kfence_enabled __read_mostly;
> +static bool disabled_by_warn __read_mostly;
>
>  unsigned long kfence_sample_interval __read_mostly = CONFIG_KFENCE_SAMPLE_INTERVAL;
>  EXPORT_SYMBOL_GPL(kfence_sample_interval); /* Export for test modules. */
> @@ -55,6 +58,7 @@ EXPORT_SYMBOL_GPL(kfence_sample_interval); /* Export for test modules. */
>  #endif
>  #define MODULE_PARAM_PREFIX "kfence."
>
> +static int kfence_enable_late(void);
>  static int param_set_sample_interval(const char *val, const struct kernel_param *kp)
>  {
>         unsigned long num;
> @@ -65,10 +69,11 @@ static int param_set_sample_interval(const char *val, const struct kernel_param
>
>         if (!num) /* Using 0 to indicate KFENCE is disabled. */
>                 WRITE_ONCE(kfence_enabled, false);
> -       else if (!READ_ONCE(kfence_enabled) && system_state != SYSTEM_BOOTING)
> -               return -EINVAL; /* Cannot (re-)enable KFENCE on-the-fly. */
>
>         *((unsigned long *)kp->arg) = num;
> +
> +       if (num && !READ_ONCE(kfence_enabled) && system_state != SYSTEM_BOOTING)
> +               return disabled_by_warn ? -EINVAL : kfence_enable_late();
>         return 0;
>  }
>
> @@ -787,6 +792,16 @@ void __init kfence_init(void)
>                 (void *)(__kfence_pool + KFENCE_POOL_SIZE));
>  }
>
> +static int kfence_enable_late(void)
> +{
> +       if (!__kfence_pool)
> +               return -EINVAL;
> +
> +       WRITE_ONCE(kfence_enabled, true);
> +       queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
> +       return 0;
> +}
> +
>  void kfence_shutdown_cache(struct kmem_cache *s)
>  {
>         unsigned long flags;
> --
> 2.27.0
>
