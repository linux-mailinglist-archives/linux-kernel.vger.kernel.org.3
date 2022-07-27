Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9552458355E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 00:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbiG0WnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 18:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiG0WnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 18:43:12 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38745C9DC;
        Wed, 27 Jul 2022 15:43:11 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id b21so737qte.12;
        Wed, 27 Jul 2022 15:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0JygPca+Z1fPoiib7T7Cj4rvDSqJp8OQBczobRUF3E=;
        b=hohLD6VNHfYjjpslfgLTnGstI5czOgE1mqUjkUThOL4N584LrC4848Pxb9eN9xYy1k
         TkVUxKRAenZcfMoxZZC0RxXCCNav6n/GJCp4Re7WXeW3F/9GaLieluzD3XIDfatBn+bJ
         zeTvmIsF0AP2SfsK9UoO7FEKXaw12LjZzT5m17/Xcj1PCqwZ15SFpBCIIR3UxKxjxJiM
         +ZWVfpVZOVzg8QohAp/7odOipVeABd3VmGUxfsjuJlU4MdswjFlOpKoHfJytlqT1aZYi
         JU7/3mHxw6QwYhIuIMvm/a3UcMsESeKWXoWvi13EAOnk3XmjtDWKk9oSdWRvk7JDD6jk
         mp/Q==
X-Gm-Message-State: AJIora8ExPQWphrokaFJTyFolLGWGAW/j8CAOoERtgf9NbTpHz3qag/Z
        Ij2IPMLALSBE6sBZX/07AAgdK19zpyN/ELJdWwI=
X-Google-Smtp-Source: AGRyM1s8ecY09zoVnNG1wuZMfVNGLiUzdFDLfLIfkkOR6vxaUMjhFfOKO+nR9N77Wr/u0hvc+k8oi+kriTCTQizF4zk=
X-Received: by 2002:a05:622a:178c:b0:31e:f628:f4ab with SMTP id
 s12-20020a05622a178c00b0031ef628f4abmr20992947qtk.82.1658961790864; Wed, 27
 Jul 2022 15:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220727111954.105118-1-gpavithrasha@gmail.com> <20220727111954.105118-3-gpavithrasha@gmail.com>
In-Reply-To: <20220727111954.105118-3-gpavithrasha@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 27 Jul 2022 15:43:00 -0700
Message-ID: <CAM9d7chRyvYQMYaPSiem8_9wwh6+p0mgF3qMD++17QNpbWGGeg@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] perf mutex and cond: Updated files mutex.h & mutex.c
To:     gpavithrasha@gmail.com
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 4:20 AM <gpavithrasha@gmail.com> wrote:
>
> From: pavithra <gpavithrasha@gmail.com>
>
> Added new struct and corresponding
> functions to wrap usage of pthread_cond_t.
> Added a new function for mutex_trylock-similar to
> mutex_lock.
>
> Signed-off-by: pavithra <gpavithrasha@gmail.com>
> ---
>  tools/perf/util/mutex.c | 37 ++++++++++++++++++++++++++++++++-----
>  tools/perf/util/mutex.h | 13 +++++++++++--
>  2 files changed, 43 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/mutex.c b/tools/perf/util/mutex.c
> index b7264a1438c4..9dc37a3f374f 100644
> --- a/tools/perf/util/mutex.c
> +++ b/tools/perf/util/mutex.c
> @@ -1,8 +1,8 @@
>  #include <mutex.h>
>  #include <pthread.h>
>
> -//to avoid the warning : implicit declaration of BUG_ON,
> -//we add the following 2 headers.
> +/*to avoid the warning : implicit declaration of BUG_ON*/
> +/*we add the following 2 headers*/
>  #include <linux/compiler.h>
>  #include <linux/kernel.h>
>
> @@ -11,14 +11,15 @@ void mutex_init(struct mutex *mtx)
>  pthread_mutexattr_t lock_attr;
>  pthread_mutexattr_init(&lock_attr);
>  pthread_mutexattr_settype(&lock_attr, PTHREAD_MUTEX_ERRORCHECK);
> -BUG_ON(pthread_mutex_init(&mtx->lock, &lock_attr));
> -//on success, returns 0.
> +/*pthread_mutex_init:on success, returns 0*/
> +BUG_ON(pthread_mutex_init(&mtx->lock, &lock_attr));
>  pthread_mutexattr_destroy(&lock_attr);
>  }
>
>  void mutex_destroy(struct mutex *mtx)
>  {
> -BUG_ON(pthread_mutex_destroy(&mtx->lock));     //on success, returns 0.
> +/*pthread_mutex_destroy:on success, returns 0*/
> +BUG_ON(pthread_mutex_destroy(&mtx->lock));

Above changes should belong to the patch 1.

>  }
>
>  void mutex_lock(struct mutex *mtx)
> @@ -30,3 +31,29 @@ void mutex_unlock(struct mutex *mtx)
>  {
>  BUG_ON(pthread_mutex_unlock(&mtx->lock) != 0);
>  }
> +
> +bool mutex_trylock(struct mutex *mtx)
> +{
> +return pthread_mutex_trylock(&mtx->lock)!=0;
> +}
> +
> +void cond_wait(struct cond *cnd, struct mutex *mtx)
> +{
> +BUG_ON(pthread_cond_wait(&cnd->cond, &mtx->lock) != 0);
> +}
> +
> +void cond_signal(struct cond *cnd)
> +{
> +BUG_ON(pthread_cond_signal(&cnd->cond) != 0);
> +}
> +
> +void cond_init(struct cond *cnd)
> +{
> +pthread_condattr_t attr;
> +
> +pthread_condattr_init(&attr);
> +
> +/*pthread_cond_init:on success, returns 0*/
> +BUG_ON(pthread_cond_init(&cnd->cond, &attr));

Please be consistent with != 0.

Thanks,
Namhyung


> +pthread_condattr_destroy(&attr);
> +}
> diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
> index ab2ebb98b24a..f1b4aaa151be 100644
> --- a/tools/perf/util/mutex.h
> +++ b/tools/perf/util/mutex.h
> @@ -1,15 +1,24 @@
>  #ifndef __PERF_MUTEX_H
> -#define _PERF_MUTEX_H
> +#define __PERF_MUTEX_H
>
>  #include <pthread.h>
> +#include <stdbool.h>
>
>  struct mutex {
>  pthread_mutex_t lock;
>  };
>
> +struct cond {
> +pthread_cond_t cond;
> +};
> +
>  void mutex_lock(struct mutex *mtx);
>  void mutex_unlock(struct mutex *mtx);
> +bool mutex_trylock(struct mutex *mtx);
>  void mutex_init(struct mutex *mtx);
>  void mutex_destroy(struct mutex *mtx);
>
> -#endif /* _PERF_MUTEX_H */
> +void cond_wait(struct cond *cnd, struct mutex *mtx);
> +void cond_signal(struct cond *cnd);
> +void cond_init(struct cond *cnd);
> +#endif /* __PERF_MUTEX_H */
> --
> 2.25.1
>
