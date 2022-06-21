Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27D4553899
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352214AbiFURLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiFURLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:11:21 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC51252B7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:11:20 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a11so7424643ljb.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UHw7FGyj5VAT0e05IQUwBdhOWh3gDF7+EbgcPMeg8vY=;
        b=p+x60DPcVkOmmYynyQGIIZNezjpkdiU78FJYIbWdymYtrpDiTDBnH5N2yROgnc5dI7
         mTHuQ8rXPT0ybYxb/iYR/LutqYacQQ8YoScd4YT6FfcESYbhGtf1e68ydOlgCarGDI36
         fICACdaHzC1rDEFNhiK775fZ88Kk2rq+aFSTloS09CIEtCYzsHGuKsksQlTWcFn33t67
         j6tLtXtW5fF4Mn0oil6ijEqz/rdCxnzFQi19+JB7/Df2XnI2H8vy4pYWDs8iBe46J7Gj
         KPvkMWfYG2gVGy07B7osUan1bW80LrUYawgPu1Zc1W4NN1+oyKjPwoPz1lMCVKT0bAlh
         G5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHw7FGyj5VAT0e05IQUwBdhOWh3gDF7+EbgcPMeg8vY=;
        b=QOQ29nceK5fYYBonTwX34m7u8dDBS659D+CpIo7HJTYPFUwjJBqXnTsurvPRmTkcNw
         spBbhW14wEC1mx1TPBVGLcaAWZxeUHehd4/aeKGeH9kTYMefkySQYUOzBu3be3QuANC8
         fc35KQgp8qK2zyspJUuCaOwSqkke327LgDtF/xbOjXXbGWw+4EhV6UrlEigUqW0zsI9P
         tQFfzlXrCLoivTS6xVEmTkxFYSRU0/bmr0uuze46Y2aM7eRvOCcRqu4l+qfVvfC4iTKv
         UxM1NWWofz4ggfBTXb0IFmqDGmKJtWrkv0tUQtCmGaFZN6DHS16XEr5wLOdFSkVIAKnU
         A4EQ==
X-Gm-Message-State: AJIora8iU57uh1oCL0GXyKuLoHXsnezKzgk/3qvI9Q7K/+WLqItq2rQv
        HZSvNVl/O06oKim1yeXjFUX/E9Jicex7UVEGa+EFxQ==
X-Google-Smtp-Source: AGRyM1vX2jP3Vuc8awojGqtXcjWr93iWdowWKv8S6sngmpYiI4qsHPLMmBpLlVrhcQWvCGoTYiKrFhGIvemurbFJZ38=
X-Received: by 2002:a2e:1443:0:b0:25a:7128:6535 with SMTP id
 3-20020a2e1443000000b0025a71286535mr4855988lju.258.1655831478247; Tue, 21 Jun
 2022 10:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220526220018.3334775-1-dualli@chromium.org> <20220526220018.3334775-2-dualli@chromium.org>
In-Reply-To: <20220526220018.3334775-2-dualli@chromium.org>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 21 Jun 2022 10:11:07 -0700
Message-ID: <CAHRSSEwJhpmiJtnK4j76uDh+EGXr9FwMotD8=vwr70EmVTfWsQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 1/1] Binder: add TF_UPDATE_TXN to replace
 outdated txn
To:     Li Li <dualli@chromium.org>
Cc:     dualli@google.com, gregkh@linuxfoundation.org,
        christian@brauner.io, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com, hridya@google.com,
        surenb@google.com, joel@joelfernandes.org, kernel-team@android.com
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

On Thu, May 26, 2022 at 3:00 PM Li Li <dualli@chromium.org> wrote:
>
> From: Li Li <dualli@google.com>
>
> When the target process is busy, incoming oneway transactions are
> queued in the async_todo list. If the clients continue sending extra
> oneway transactions while the target process is frozen, this queue can
> become too large to accommodate new transactions. That's why binder
> driver introduced ONEWAY_SPAM_DETECTION to detect this situation. It's
> helpful to debug the async binder buffer exhausting issue, but the
> issue itself isn't solved directly.
>
> In real cases applications are designed to send oneway transactions
> repeatedly, delivering updated inforamtion to the target process.
> Typical examples are Wi-Fi signal strength and some real time sensor
> data. Even if the apps might only care about the lastet information,
> all outdated oneway transactions are still accumulated there until the
> frozen process is thawed later. For this kind of situations, there's
> no existing method to skip those outdated transactions and deliver the
> latest one only.
>
> This patch introduces a new transaction flag TF_UPDATE_TXN. To use it,
> use apps can set this new flag along with TF_ONE_WAY. When such an
> oneway transaction is to be queued into the async_todo list of a frozen
> process, binder driver will check if any previous pending transactions
> can be superseded by comparing their code, flags and target node. If
> such an outdated pending transaction is found, the latest transaction
> will supersede that outdated one. This effectively prevents the async
> binder buffer running out and saves unnecessary binder read workloads.
>
> Signed-off-by: Li Li <dualli@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
> v3:
>   - Add this changelog required by "The canonical patch format"
> v2:
>   - Fix alignment warnings reported by checkpatch --strict
>   - Add descriptive summary in patch subject
>
>  drivers/android/binder.c            | 85 ++++++++++++++++++++++++++++-
>  drivers/android/binder_trace.h      |  4 ++
>  include/uapi/linux/android/binder.h |  1 +
>  3 files changed, 87 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index f3b639e89dd8..bb968cf2f9ec 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2594,6 +2594,56 @@ static int binder_fixup_parent(struct list_head *pf_head,
>         return binder_add_fixup(pf_head, buffer_offset, bp->buffer, 0);
>  }
>
> +/**
> + * binder_can_update_transaction() - Can a txn be superseded by an updated one?
> + * @t1: the pending async txn in the frozen process
> + * @t2: the new async txn to supersede the outdated pending one
> + *
> + * Return:  true if t2 can supersede t1
> + *          false if t2 can not supersede t1
> + */
> +static bool binder_can_update_transaction(struct binder_transaction *t1,
> +                                         struct binder_transaction *t2)
> +{
> +       if ((t1->flags & t2->flags & (TF_ONE_WAY | TF_UPDATE_TXN)) !=
> +           (TF_ONE_WAY | TF_UPDATE_TXN) || !t1->to_proc || !t2->to_proc)
> +               return false;
> +       if (t1->to_proc->tsk == t2->to_proc->tsk && t1->code == t2->code &&
> +           t1->flags == t2->flags && t1->buffer->pid == t2->buffer->pid &&
> +           t1->buffer->target_node->ptr == t2->buffer->target_node->ptr &&
> +           t1->buffer->target_node->cookie == t2->buffer->target_node->cookie)
> +               return true;
> +       return false;
> +}
> +
> +/**
> + * binder_find_outdated_transaction_ilocked() - Find the outdated transaction
> + * @t:          new async transaction
> + * @target_list: list to find outdated transaction
> + *
> + * Return: the outdated transaction if found
> + *         NULL if no outdated transacton can be found
> + *
> + * Requires the proc->inner_lock to be held.
> + */
> +static struct binder_transaction *
> +binder_find_outdated_transaction_ilocked(struct binder_transaction *t,
> +                                        struct list_head *target_list)
> +{
> +       struct binder_work *w;
> +
> +       list_for_each_entry(w, target_list, entry) {
> +               struct binder_transaction *t_queued;
> +
> +               if (w->type != BINDER_WORK_TRANSACTION)
> +                       continue;
> +               t_queued = container_of(w, struct binder_transaction, work);
> +               if (binder_can_update_transaction(t_queued, t))
> +                       return t_queued;
> +       }
> +       return NULL;
> +}
> +
>  /**
>   * binder_proc_transaction() - sends a transaction to a process and wakes it up
>   * @t:         transaction to send
> @@ -2619,6 +2669,7 @@ static int binder_proc_transaction(struct binder_transaction *t,
>         struct binder_node *node = t->buffer->target_node;
>         bool oneway = !!(t->flags & TF_ONE_WAY);
>         bool pending_async = false;
> +       struct binder_transaction *t_outdated = NULL;
>
>         BUG_ON(!node);
>         binder_node_lock(node);
> @@ -2646,12 +2697,24 @@ static int binder_proc_transaction(struct binder_transaction *t,
>         if (!thread && !pending_async)
>                 thread = binder_select_thread_ilocked(proc);
>
> -       if (thread)
> +       if (thread) {
>                 binder_enqueue_thread_work_ilocked(thread, &t->work);
> -       else if (!pending_async)
> +       } else if (!pending_async) {
>                 binder_enqueue_work_ilocked(&t->work, &proc->todo);
> -       else
> +       } else {
> +               if ((t->flags & TF_UPDATE_TXN) && proc->is_frozen) {
> +                       t_outdated = binder_find_outdated_transaction_ilocked(t,
> +                                                                             &node->async_todo);
> +                       if (t_outdated) {
> +                               binder_debug(BINDER_DEBUG_TRANSACTION,
> +                                            "txn %d supersedes %d\n",
> +                                            t->debug_id, t_outdated->debug_id);
> +                               list_del_init(&t_outdated->work.entry);
> +                               proc->outstanding_txns--;
> +                       }
> +               }
>                 binder_enqueue_work_ilocked(&t->work, &node->async_todo);
> +       }
>
>         if (!pending_async)
>                 binder_wakeup_thread_ilocked(proc, thread, !oneway /* sync */);
> @@ -2660,6 +2723,22 @@ static int binder_proc_transaction(struct binder_transaction *t,
>         binder_inner_proc_unlock(proc);
>         binder_node_unlock(node);
>
> +       /*
> +        * To reduce potential contention, free the outdated transaction and
> +        * buffer after releasing the locks.
> +        */
> +       if (t_outdated) {
> +               struct binder_buffer *buffer = t_outdated->buffer;
> +
> +               t_outdated->buffer = NULL;
> +               buffer->transaction = NULL;
> +               trace_binder_transaction_update_buffer_release(buffer);
> +               binder_transaction_buffer_release(proc, NULL, buffer, 0, 0);
> +               binder_alloc_free_buf(&proc->alloc, buffer);
> +               kfree(t_outdated);
> +               binder_stats_deleted(BINDER_STAT_TRANSACTION);
> +       }
> +
>         return 0;
>  }
>
> diff --git a/drivers/android/binder_trace.h b/drivers/android/binder_trace.h
> index 8eeccdc64724..8cc07e6a4273 100644
> --- a/drivers/android/binder_trace.h
> +++ b/drivers/android/binder_trace.h
> @@ -311,6 +311,10 @@ DEFINE_EVENT(binder_buffer_class, binder_transaction_failed_buffer_release,
>         TP_PROTO(struct binder_buffer *buffer),
>         TP_ARGS(buffer));
>
> +DEFINE_EVENT(binder_buffer_class, binder_transaction_update_buffer_release,
> +            TP_PROTO(struct binder_buffer *buffer),
> +            TP_ARGS(buffer));
> +
>  TRACE_EVENT(binder_update_page_range,
>         TP_PROTO(struct binder_alloc *alloc, bool allocate,
>                  void __user *start, void __user *end),
> diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
> index 11157fae8a8e..0b291b1d29d1 100644
> --- a/include/uapi/linux/android/binder.h
> +++ b/include/uapi/linux/android/binder.h
> @@ -271,6 +271,7 @@ enum transaction_flags {
>         TF_STATUS_CODE  = 0x08, /* contents are a 32-bit status code */
>         TF_ACCEPT_FDS   = 0x10, /* allow replies with file descriptors */
>         TF_CLEAR_BUF    = 0x20, /* clear buffer on txn complete */
> +       TF_UPDATE_TXN   = 0x40, /* update the outdated pending async txn */
>  };
>
>  struct binder_transaction_data {
> --
> 2.36.1.124.g0e6072fb45-goog
>
