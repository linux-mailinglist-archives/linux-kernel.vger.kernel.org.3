Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE98B507927
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353292AbiDSSeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358169AbiDSSd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:33:58 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082A546662
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:24:27 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id c15so21587182ljr.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AsTN3hKy53tOQ0yC6mN5UWrEJyNRzz9niRjTVy3QZo8=;
        b=pLPd3Ud5SWGgyZg65CkOgH1iVO3cAmCL0kj8iFG9FTiRUu1PjX6hIL2HCpjxtKjEW6
         f0HISjf8DaCWmjJ6C2W/4soMJmEMMQvn4AeMwkrPVwUWyF+eJNc5RzGhBLGkvQI6HJwk
         Ss9ScSdwcNCyt8Kp5C9pZwO5IMEeeGT/s/inSL2aFCr+ITKFgFK0BarvG8qkYXS77p/f
         80DI5NUs/0BpOHda6Ip1uI2afHAhUKp56WAGjX4pgF6mhfLDA5jVZ0cRBdUufkMDzrYo
         PeLKJfifrdlxsM5NKxHdVBiZKWu94hRx68UUJRLgg0O5XLz0e1ggBmzpCwdrE5Bqf1xq
         UmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AsTN3hKy53tOQ0yC6mN5UWrEJyNRzz9niRjTVy3QZo8=;
        b=JNaSZ5Xo5uoSRIFJ+Vgg2plfh6N+xsy7O05qSmx8D+bgVaXFjvwB/C5BRkv0CrWIRY
         ad76NjRHhqQPme87k8TmeZYdMDc2YlG0yDtmSz/OfS4DlQwgoSWnU+DbgdsO0echfuNQ
         WiwTNbb903xokbWJAUfyawUzGtGIF+UZhl3PvwrplDQuiirM4kTxQ0OhaAavXvpsQEaA
         ZC+JkDHaEQjo7yAy5jquzA6/nIHYXhdrKqXT6pAy34A6tNOgMNGyujHPa9KRXYaaPWcz
         xPSnYYGvK4xhcDCb1/vfI6yiIJB9f0bwYt8amgRlKsaDipHtYsgTpEBy8vtOCF6dqFeS
         RjJQ==
X-Gm-Message-State: AOAM531zZa3x6Khq0o4AF8eTT/PMnMuoO7QbcgyLZJ9JLjku2lH3O0kI
        iMPGt+2h2bJBr9Xwijtxs2+yE4hUpEDkkuqI3UHmGw==
X-Google-Smtp-Source: ABdhPJwkSfr9pP2nwB9541Zh+TriNUNVh/fdYmxFU+HUUdAzi/nkK2G5Tx3EnrgDlc3XvoRpt4dfIepSPQxY6mOuYTw=
X-Received: by 2002:a2e:9345:0:b0:24b:451:7ce1 with SMTP id
 m5-20020a2e9345000000b0024b04517ce1mr10844943ljh.258.1650392665301; Tue, 19
 Apr 2022 11:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220325232454.2210817-1-cmllamas@google.com>
In-Reply-To: <20220325232454.2210817-1-cmllamas@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 19 Apr 2022 11:24:13 -0700
Message-ID: <CAHRSSEwC9hO-BPdYUGz_QF77bDJLWMJexaGV5+VhFYdrW-H64w@mail.gmail.com>
Subject: Re: [PATCH] binder: hold fd_install until allocating fds first
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>
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

On Fri, Mar 25, 2022 at 4:25 PM Carlos Llamas <cmllamas@google.com> wrote:
>
> Al noted in [1] that fd_install can't be undone, so it must come last in
> the fd translation sequence, only after we've successfully reserved all
> descriptors and copied them into the transaction buffer.
>
> This patch takes Al's proposed fix in [2] and makes a few tweaks to fold
> the traversal of t->fd_fixups during release.
>
> [1] https://lore.kernel.org/driverdev-devel/YHnJwRvUhaK3IM0l@zeniv-ca.linux.org.uk
> [2] https://lore.kernel.org/driverdev-devel/YHo6Ln9VI1T7RmLK@zeniv-ca.linux.org.uk
>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c          | 34 ++++++++++++-------------------
>  drivers/android/binder_internal.h |  2 ++
>  2 files changed, 15 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 8351c5638880..bfadc0c4a442 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -1481,6 +1481,8 @@ static void binder_free_txn_fixups(struct binder_transaction *t)
>
>         list_for_each_entry_safe(fixup, tmp, &t->fd_fixups, fixup_entry) {
>                 fput(fixup->file);
> +               if (fixup->target_fd >= 0)
> +                       put_unused_fd(fixup->target_fd);
>                 list_del(&fixup->fixup_entry);
>                 kfree(fixup);
>         }
> @@ -2220,6 +2222,7 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset,
>         }
>         fixup->file = file;
>         fixup->offset = fd_offset;
> +       fixup->target_fd = -1;
>         trace_binder_transaction_fd_send(t, fd, fixup->offset);
>         list_add_tail(&fixup->fixup_entry, &t->fd_fixups);
>
> @@ -4067,10 +4070,9 @@ static int binder_wait_for_work(struct binder_thread *thread,
>   * Now that we are in the context of the transaction target
>   * process, we can allocate and install fds. Process the
>   * list of fds to translate and fixup the buffer with the
> - * new fds.
> + * new fds first and only then install the files.
>   *
> - * If we fail to allocate an fd, then free the resources by
> - * fput'ing files that have not been processed and ksys_close'ing
> + * If we fail to allocate an fd, skip the install and release
>   * any fds that have already been allocated.
>   */
>  static int binder_apply_fd_fixups(struct binder_proc *proc,
> @@ -4087,41 +4089,31 @@ static int binder_apply_fd_fixups(struct binder_proc *proc,
>                                      "failed fd fixup txn %d fd %d\n",
>                                      t->debug_id, fd);
>                         ret = -ENOMEM;
> -                       break;
> +                       goto err;
>                 }
>                 binder_debug(BINDER_DEBUG_TRANSACTION,
>                              "fd fixup txn %d fd %d\n",
>                              t->debug_id, fd);
>                 trace_binder_transaction_fd_recv(t, fd, fixup->offset);
> -               fd_install(fd, fixup->file);
> -               fixup->file = NULL;
> +               fixup->target_fd = fd;
>                 if (binder_alloc_copy_to_buffer(&proc->alloc, t->buffer,
>                                                 fixup->offset, &fd,
>                                                 sizeof(u32))) {
>                         ret = -EINVAL;
> -                       break;
> +                       goto err;
>                 }
>         }
>         list_for_each_entry_safe(fixup, tmp, &t->fd_fixups, fixup_entry) {
> -               if (fixup->file) {
> -                       fput(fixup->file);
> -               } else if (ret) {
> -                       u32 fd;
> -                       int err;
> -
> -                       err = binder_alloc_copy_from_buffer(&proc->alloc, &fd,
> -                                                           t->buffer,
> -                                                           fixup->offset,
> -                                                           sizeof(fd));
> -                       WARN_ON(err);
> -                       if (!err)
> -                               binder_deferred_fd_close(fd);
> -               }
> +               fd_install(fixup->target_fd, fixup->file);
>                 list_del(&fixup->fixup_entry);
>                 kfree(fixup);
>         }
>
>         return ret;
> +
> +err:
> +       binder_free_txn_fixups(t);
> +       return ret;
>  }
>
>  static int binder_thread_read(struct binder_proc *proc,
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index d6b6b8cb7346..cf70a104594d 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -515,6 +515,7 @@ struct binder_thread {
>   * @fixup_entry:          list entry
>   * @file:                 struct file to be associated with new fd
>   * @offset:               offset in buffer data to this fixup
> + * @target_fd:            fd to use by the target to install @file
>   *
>   * List element for fd fixups in a transaction. Since file
>   * descriptors need to be allocated in the context of the
> @@ -525,6 +526,7 @@ struct binder_txn_fd_fixup {
>         struct list_head fixup_entry;
>         struct file *file;
>         size_t offset;
> +       int target_fd;
>  };
>
>  struct binder_transaction {
> --
> 2.35.1.1021.g381101b075-goog
>
