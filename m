Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108C45093A5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383259AbiDTXiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383253AbiDTXh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:37:58 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EB815827
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:35:11 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id x39so5690340ybd.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ECM2wc8JXCnTE6oGrB79vBtHjRr5KdZQitQE/whOnY4=;
        b=RzDioNeIShP/yGG2gscLGRAYk74YFjGOnKh3wdQyInMM7qMEjF631j27pEt+fjfopF
         bowM2rAIarYf0AGrONT1SjeUWU4kHgF1dTuca4WilRqnxbYec6UR9IcRdtJcj3p3Lr0m
         ZMuJPlZ9AFh0xKtPP4KJfH66OJvkFLymCb4FOSkFwvJ8W7aGowoJTe2vDKX9NwNXRj4I
         /URdjyeLiD87v+u1nGMwcY0B7zpGNqiOsMEuBbcBufSt/IxtmvYr9Y1Y6vrjxNDV3dNi
         m/VZh9PbkVtI6j164Doubmqg/yU0zdY5nc1Ml6TmbK6KmjoWNIviae2ETBEh4h4K6VlS
         KvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ECM2wc8JXCnTE6oGrB79vBtHjRr5KdZQitQE/whOnY4=;
        b=aC++7EBVKeWGEOqbuFDiGNWY9/Gsww2yNWQYD4KNP3NGXUsEjt4nDZdb53zopTGl2f
         jo2l2Wh+JDU+mCCCdLUYWO1h7WTY/Cb6Wv3Chyd7MtJFnJOCzTN1rYGxhN67TNig0BBs
         d4BvYkIR0+mABcIc6t+GN+2bOaQyVvz0VRzA+t6to4w01EXOgz3ykBfTrEBpT+ikKeFp
         i0C1uabxLoudb7dYHt3XBfc9k5Hc3Dr1mi+1wt5fdNYKDIOJifgp1wc7UttiWG3oKiZE
         nDiEvRc1PKmZmm2IHjeTl1e8ufyZy8kJzWQdrVBpQHudU0SDaExYxR0017pm57mPn8Ji
         oVZw==
X-Gm-Message-State: AOAM532K41WNBE1Kn5cTJ15elFUysULeu/0zXBDgjbyUuWtIZ2SHbHVQ
        V4DWOb0GJwjPH5LaMbNipeVO/mBBQXc+z3sdrdm92g==
X-Google-Smtp-Source: ABdhPJwghaJ8cCp6pfpjdzLpkWVFa16TUOTD4HZ8X5n0no+B+TlSeltc06jf3qoyx3JBhkajkG2HThf+Up35B9O7Xa4=
X-Received: by 2002:a05:6902:389:b0:633:31c1:d0f7 with SMTP id
 f9-20020a056902038900b0063331c1d0f7mr21883274ybs.543.1650497710318; Wed, 20
 Apr 2022 16:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220420224356.322697-1-tuhailong@gmail.com>
In-Reply-To: <20220420224356.322697-1-tuhailong@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 20 Apr 2022 16:34:59 -0700
Message-ID: <CAJuCfpFMgLvLHKK8ZKrU3vciZFK0FJoCFen_3tbUBk5s+yWnSw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/damon: Fix the timer always stays active
To:     Hailong Tu <tuhailong@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, sj@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@google.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, tuhailong@oppo.com,
        lichunpeng@oppo.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 3:46 PM Hailong Tu <tuhailong@gmail.com> wrote:
>
> The timer stays active even if the reclaim mechanism is never enabled.
> It is unnecessary overhead can be completely avoided by using module_param_call() for enabled flag.
>
> Signed-off-by: Hailong Tu <tuhailong@gmail.com>
> ---
>  mm/damon/reclaim.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index e34c4d0c4d93..389c4be4f62b 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -28,7 +28,6 @@
>   * this.
>   */
>  static bool enabled __read_mostly;
> -module_param(enabled, bool, 0600);
>
>  /*
>   * Time threshold for cold memory regions identification in microseconds.
> @@ -358,11 +357,32 @@ static void damon_reclaim_timer_fn(struct work_struct *work)
>                         enabled = last_enabled;
>         }
>
> -       schedule_delayed_work(&damon_reclaim_timer,
> +       if (enabled)
> +               schedule_delayed_work(&damon_reclaim_timer,
>                         msecs_to_jiffies(ENABLE_CHECK_INTERVAL_MS));
>  }
>  static DECLARE_DELAYED_WORK(damon_reclaim_timer, damon_reclaim_timer_fn);
>
> +static int enabled_show(char *buffer, const struct kernel_param *kp)
> +{
> +       return sprintf(buffer, "%c\n", enabled ? 'Y' : 'N');
> +}
> +
> +static int enabled_store(const char *val,
> +               const struct kernel_param *kp)
> +{
> +       int rc = param_set_bool(val, kp);
> +
> +       if (rc < 0)
> +               return rc;
> +
> +       if (enabled)
> +               schedule_delayed_work(&damon_reclaim_timer, 0);
> +
> +       return 0;
> +}
> +module_param_call(enabled, enabled_store, enabled_show, &enabled, 0600);

As Matthew pointed out in the previous version, you can use
param_get_bool instead of enabled_show here.

> +
>  static int damon_reclaim_after_aggregation(struct damon_ctx *c)
>  {
>         struct damos *s;
> --
> 2.25.1
>
