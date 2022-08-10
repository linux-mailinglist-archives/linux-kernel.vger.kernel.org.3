Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7583158F22E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 20:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiHJSO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 14:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiHJSOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 14:14:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DC2975389
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 11:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660155263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dvFX4t0B/SpHtAyJJhX1X854uDLR0fd0SKbf+261CSI=;
        b=BaXyAh1eQp4SHOtNByh0tHunOopf1hV3xVhv1RvwXpieTyJkBVD0o4x/fpZ9IASAMVUNEc
        ZyjcAWVdC0tYgsw/+2Utn3cDQ4hDNnwk0Ta/IrCSYpx8H/x+QEIpsVM5VP+qAh2cQ7xeN/
        I4P+eJHaHuVZ4gkuCM+DdsulVKvbHOM=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-Kk9FFp_HNniJbaXJ9-i4-g-1; Wed, 10 Aug 2022 14:14:22 -0400
X-MC-Unique: Kk9FFp_HNniJbaXJ9-i4-g-1
Received: by mail-yb1-f199.google.com with SMTP id 137-20020a250b8f000000b0067a5a14d730so12738946ybl.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 11:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dvFX4t0B/SpHtAyJJhX1X854uDLR0fd0SKbf+261CSI=;
        b=2d5sJLTInXD2vJVC/Zutv1eO5Otr9DmcYpCw2hjRPEEfajlqNBvj1K2x1ZbsKlwNxC
         NhvuCQ3pKrwPQxIn9cjOyvO6/oClNZ1VPQGUhekc9VNACBUvnDnjzmkPxcEa3HTPfmG3
         1CuUDqgG76amPuM7R2zQtN76eTLcye4YFKzbVUpMqbA/ph5OkJAmbrf8IgKhDYgr1lIe
         f+I3BVgf/HyAURZSkvMm1YaQiyz3HrmwTtMvc/aAsVx0nacb30tALgeZVLJYrQ6HVysy
         5y8D4tRAsW5bA3fR1k1wGi9fUli3wbSYYHfok87yXbA+UBz5HdTP8H8ytVP5iJ9+o8oQ
         fsLg==
X-Gm-Message-State: ACgBeo0SGHU6W6vdOrWMgWF0AvU3Akv7gSurzr0BMZ63+ILnD2Iy+NOV
        ZthssOIiFdkoc7t/IxOlt2lPGD5BC8BXlxu16N9+EqoWx3+O/1XD9UlYqFroiAlLCZeAbJjuF6a
        yA7NL04TP7PTCV4xC5LfvnANC4vvRNlevyDRn/bmA
X-Received: by 2002:a0d:c745:0:b0:324:8800:f63d with SMTP id j66-20020a0dc745000000b003248800f63dmr29130194ywd.106.1660155262275;
        Wed, 10 Aug 2022 11:14:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6muemIRMkvnwQwC0YGQ9xi48xUoLNMRmcd7lKsvryfN7vF3N1f9cU5/b6fdn1SeHdJ0SQPfUHfpAVCid56NvM=
X-Received: by 2002:a0d:c745:0:b0:324:8800:f63d with SMTP id
 j66-20020a0dc745000000b003248800f63dmr29130162ywd.106.1660155262052; Wed, 10
 Aug 2022 11:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220810160209.1630707-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220810160209.1630707-1-Liam.Howlett@oracle.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 10 Aug 2022 20:14:10 +0200
Message-ID: <CAFqZXNuOvt_p0ZNjh89Vt9sGQ=CE5_GLr+XOT6OkzxcHdEHgKQ@mail.gmail.com>
Subject: Re: [PATCH v2] binder_alloc: Add missing mmap_lock calls when using
 the VMA
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 6:02 PM Liam Howlett <liam.howlett@oracle.com> wrote:
> Take the mmap_read_lock() when using the VMA in
> binder_alloc_print_pages() and when checking for a VMA in
> binder_alloc_new_buf_locked().
>
> It is worth noting binder_alloc_new_buf_locked() drops the VMA read lock
> after it verifies a VMA exists, but may be taken again deeper in the
> call stack, if necessary.
>
> Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
> Reported-by: syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com
> Fixes: a43cfc87caaf (android: binder: stop saving a pointer to the VMA)
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  drivers/android/binder_alloc.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index f555eebceef6..c5e7c6d3a844 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -395,12 +395,15 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
>         size_t size, data_offsets_size;
>         int ret;
>
> +       mmap_read_lock(alloc->vma_vm_mm);
>         if (!binder_alloc_get_vma(alloc)) {
> +               mmap_read_unlock(alloc->vma_vm_mm);
>                 binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
>                                    "%d: binder_alloc_buf, no vma\n",
>                                    alloc->pid);
>                 return ERR_PTR(-ESRCH);
>         }
> +       mmap_read_unlock(alloc->vma_vm_mm);
>
>         data_offsets_size = ALIGN(data_size, sizeof(void *)) +
>                 ALIGN(offsets_size, sizeof(void *));
> @@ -922,17 +925,25 @@ void binder_alloc_print_pages(struct seq_file *m,
>          * Make sure the binder_alloc is fully initialized, otherwise we might
>          * read inconsistent state.
>          */
> -       if (binder_alloc_get_vma(alloc) != NULL) {
> -               for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
> -                       page = &alloc->pages[i];
> -                       if (!page->page_ptr)
> -                               free++;
> -                       else if (list_empty(&page->lru))
> -                               active++;
> -                       else
> -                               lru++;
> -               }
> +
> +       mmap_read_lock(alloc->vma_vm_mm);
> +       if (binder_alloc_get_vma(alloc) == NULL) {
> +               mmap_read_unlock(alloc->vma_vm_mm);
> +               goto uninitialized;
>         }
> +
> +       mmap_read_unlock(alloc->vma_vm_mm);
> +       for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
> +               page = &alloc->pages[i];
> +               if (!page->page_ptr)
> +                       free++;
> +               else if (list_empty(&page->lru))
> +                       active++;
> +               else
> +                       lru++;
> +       }
> +
> +uninitialized:
>         mutex_unlock(&alloc->mutex);
>         seq_printf(m, "  pages: %d:%d:%d\n", active, lru, free);
>         seq_printf(m, "  pages high watermark: %zu\n", alloc->pages_high);
> --
> 2.35.1

Can confirm that with this patch the selinux-testsuite's binder test
passes again with no warnings in dmesg.

Tested-by: Ondrej Mosnacek <omosnace@redhat.com>

Thanks!

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

