Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EEF5A709D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiH3WVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiH3WUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:20:35 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F866520A9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:20:19 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bq11so15969887wrb.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=HPrbJ+vQ4o+fFD/423VJ+T5YmPm3lPQCBpQHSndaOWk=;
        b=BmZbDD+CmNe77coREpWAp5PxrknVqRJCdZ7TB5b+lKhL/T2cQ+KQshuF5ZFE478uUM
         SjwF1n0TW1/TBbIb3XMokYSDeJ8SqEAUywLe2yhwSmajq+uT0DR8azDtSNj6UTg4KWC7
         VLDpuutcOeOcsOTbveoBk5PqnOPoaeUi6roKqthPPwuo6obEz0PdNwc7r02blAfv2CIJ
         gY+fPBXvNI4SGCjGA6YrC/4agzYiUv8YoJWSfnXPBz7ICGkEitmWWBdiH8q+UIlaMvFd
         jeCENyhUM6LTfiwBe9EZGcpxGaSSCY2Z/71+cQYkoBI2+sn1omeTb44tdJuddoxLkPsh
         hlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HPrbJ+vQ4o+fFD/423VJ+T5YmPm3lPQCBpQHSndaOWk=;
        b=GNSkhRCjwVbzWWrU/hId4Ggj0YHA2a2jT2cSFZQW4/THYb3lcaGpIBc9ou5K8Zibcu
         CkUvnEvNufWK1XMb0gvJU1nxkwWJskdvkQhUt9QU2cCSEylVXcAL1GJfWTUFd5cgbhPp
         oc975dtW1xoiclCh8t6pjXYh0lfCL/WT98q/i/5y5/DayWSS0CRKP1uhupmi1EMGCBY7
         qtXpL8fziDvW05OCdzeuyozkrA3Bwnd6y/DKCbSanGkf7dIddknlpjkk9pcpApaX22Dm
         pmzBOTrYkbCgc5pSfcwSUHR5cppGppXmKieRj3VeDEeYC5SJi7bqH+m2ym2vcKQhFgfu
         E+iA==
X-Gm-Message-State: ACgBeo0oC+5YNJv6oCXVQcAfDKjEBNv8eTfskXhvJYIa24lcY4zkaxVC
        d20eEl/mt8k2/RwiODIHTBZ5BVddANJZvKIwy9GZTA==
X-Google-Smtp-Source: AA6agR6AHK3n/oQ6l8SIk21SqNa4hPOU8qFm/SkR6osnTCJcO6g82JPZIqMp1m8voh/gkX3ZK9OD3+FxbsH5RuCdkq4=
X-Received: by 2002:a5d:64ab:0:b0:226:d997:ad5c with SMTP id
 m11-20020a5d64ab000000b00226d997ad5cmr6974773wrp.602.1661898017406; Tue, 30
 Aug 2022 15:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220829201254.1814484-1-cmllamas@google.com> <20220829201254.1814484-4-cmllamas@google.com>
In-Reply-To: <20220829201254.1814484-4-cmllamas@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 30 Aug 2022 15:20:06 -0700
Message-ID: <CAHRSSEzCUcmAO4SDeUtAutRSkhV9pOX9Ea7Q0uaeGcf_Mj9NRw@mail.gmail.com>
Subject: Re: [PATCH 3/7] binder: rename alloc->vma_vm_mm to alloc->mm
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
> Rename ->vma_vm_mm to ->mm to reflect the fact that we no longer cache
> this reference from vma->vm_mm but from current->mm instead.
>
> No functional changes in this patch.
>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder_alloc.c | 34 +++++++++++++++++-----------------
>  drivers/android/binder_alloc.h |  4 ++--
>  2 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 9b1778c00610..749a4cd30a83 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -208,8 +208,8 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
>                 }
>         }
>
> -       if (need_mm && mmget_not_zero(alloc->vma_vm_mm))
> -               mm = alloc->vma_vm_mm;
> +       if (need_mm && mmget_not_zero(alloc->mm))
> +               mm = alloc->mm;
>
>         if (mm) {
>                 mmap_read_lock(mm);
> @@ -322,9 +322,9 @@ static inline void binder_alloc_set_vma(struct binder_alloc *alloc,
>          */
>         if (vma) {
>                 vm_start = vma->vm_start;
> -               mmap_assert_write_locked(alloc->vma_vm_mm);
> +               mmap_assert_write_locked(alloc->mm);
>         } else {
> -               mmap_assert_locked(alloc->vma_vm_mm);
> +               mmap_assert_locked(alloc->mm);
>         }
>
>         alloc->vma_addr = vm_start;
> @@ -336,7 +336,7 @@ static inline struct vm_area_struct *binder_alloc_get_vma(
>         struct vm_area_struct *vma = NULL;
>
>         if (alloc->vma_addr)
> -               vma = vma_lookup(alloc->vma_vm_mm, alloc->vma_addr);
> +               vma = vma_lookup(alloc->mm, alloc->vma_addr);
>
>         return vma;
>  }
> @@ -401,15 +401,15 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
>         size_t size, data_offsets_size;
>         int ret;
>
> -       mmap_read_lock(alloc->vma_vm_mm);
> +       mmap_read_lock(alloc->mm);
>         if (!binder_alloc_get_vma(alloc)) {
> -               mmap_read_unlock(alloc->vma_vm_mm);
> +               mmap_read_unlock(alloc->mm);
>                 binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
>                                    "%d: binder_alloc_buf, no vma\n",
>                                    alloc->pid);
>                 return ERR_PTR(-ESRCH);
>         }
> -       mmap_read_unlock(alloc->vma_vm_mm);
> +       mmap_read_unlock(alloc->mm);
>
>         data_offsets_size = ALIGN(data_size, sizeof(void *)) +
>                 ALIGN(offsets_size, sizeof(void *));
> @@ -823,7 +823,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
>         buffers = 0;
>         mutex_lock(&alloc->mutex);
>         BUG_ON(alloc->vma_addr &&
> -              vma_lookup(alloc->vma_vm_mm, alloc->vma_addr));
> +              vma_lookup(alloc->mm, alloc->vma_addr));
>
>         while ((n = rb_first(&alloc->allocated_buffers))) {
>                 buffer = rb_entry(n, struct binder_buffer, rb_node);
> @@ -873,8 +873,8 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
>                 kfree(alloc->pages);
>         }
>         mutex_unlock(&alloc->mutex);
> -       if (alloc->vma_vm_mm)
> -               mmdrop(alloc->vma_vm_mm);
> +       if (alloc->mm)
> +               mmdrop(alloc->mm);
>
>         binder_alloc_debug(BINDER_DEBUG_OPEN_CLOSE,
>                      "%s: %d buffers %d, pages %d\n",
> @@ -931,13 +931,13 @@ void binder_alloc_print_pages(struct seq_file *m,
>          * read inconsistent state.
>          */
>
> -       mmap_read_lock(alloc->vma_vm_mm);
> +       mmap_read_lock(alloc->mm);
>         if (binder_alloc_get_vma(alloc) == NULL) {
> -               mmap_read_unlock(alloc->vma_vm_mm);
> +               mmap_read_unlock(alloc->mm);
>                 goto uninitialized;
>         }
>
> -       mmap_read_unlock(alloc->vma_vm_mm);
> +       mmap_read_unlock(alloc->mm);
>         for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
>                 page = &alloc->pages[i];
>                 if (!page->page_ptr)
> @@ -1020,7 +1020,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
>         index = page - alloc->pages;
>         page_addr = (uintptr_t)alloc->buffer + index * PAGE_SIZE;
>
> -       mm = alloc->vma_vm_mm;
> +       mm = alloc->mm;
>         if (!mmget_not_zero(mm))
>                 goto err_mmget;
>         if (!mmap_read_trylock(mm))
> @@ -1089,8 +1089,8 @@ static struct shrinker binder_shrinker = {
>  void binder_alloc_init(struct binder_alloc *alloc)
>  {
>         alloc->pid = current->group_leader->pid;
> -       alloc->vma_vm_mm = current->mm;
> -       mmgrab(alloc->vma_vm_mm);
> +       alloc->mm = current->mm;
> +       mmgrab(alloc->mm);
>         mutex_init(&alloc->mutex);
>         INIT_LIST_HEAD(&alloc->buffers);
>  }
> diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
> index 0c37935ff7a2..fe80cc405707 100644
> --- a/drivers/android/binder_alloc.h
> +++ b/drivers/android/binder_alloc.h
> @@ -78,7 +78,7 @@ struct binder_lru_page {
>   *                      (invariant after mmap)
>   * @tsk:                tid for task that called init for this proc
>   *                      (invariant after init)
> - * @vma_vm_mm:          copy of vma->vm_mm (invariant after mmap)
> + * @mm:                 copy of task->mm (invariant after open)
>   * @buffer:             base of per-proc address space mapped via mmap
>   * @buffers:            list of all buffers for this proc
>   * @free_buffers:       rb tree of buffers available for allocation
> @@ -101,7 +101,7 @@ struct binder_lru_page {
>  struct binder_alloc {
>         struct mutex mutex;
>         unsigned long vma_addr;
> -       struct mm_struct *vma_vm_mm;
> +       struct mm_struct *mm;
>         void __user *buffer;
>         struct list_head buffers;
>         struct rb_root free_buffers;
> --
> 2.37.2.672.g94769d06f0-goog
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
