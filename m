Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A185A3FAE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 22:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiH1Url (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 16:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1Uri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 16:47:38 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FAF2B633
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 13:47:37 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-333a4a5d495so153289107b3.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 13:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kAoFlc805AehyA9fyFd+VfhPEKAjCfCEmxXhiLGWNEA=;
        b=DCyGAi54ZQfZz1Pj3ySan2iv3FHNPjwl2y25Zod9yfXkzqjIl3X0JcpY4/kAPx/8Vo
         wqrWceX9ObCgJwXwdrrDww+q2wkwXT1CJRLPgyj7O0PyKnusSoKzuKv4X+p9ia+ip1Qs
         ZA5pxYh9vSHRz355bKMmHKQ7D/vfGdT9/W5Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kAoFlc805AehyA9fyFd+VfhPEKAjCfCEmxXhiLGWNEA=;
        b=UXsmxUpTga4VXNfpMpPcTjvmzHpb+d4vzwEQd2UDdfxOxXaPiWyCLgBymMQD+5w7WT
         1aWSM9rdryPZF444WDEjLhkedg42HkhwUrzJZ3RZcAiIAsLLBsPFKl2Pg20ZBlKVnB7m
         aMXcfKrLfmaZxk0Wie8BDzBCZlg4hJVyUPP6jlHZtTUPCIaG7iDycwxZcpODm/Yh4hHS
         OrsRF8kVas+7KXTX8DmbV6VsSckFKXBlXRGEOQ2bq9CqXcxh1rrlA17ObejHp7ssxrTX
         PW/lSMXW5Uw9lGmYznZvR4XUdZtVMMDTKC2E9iAT3o/TO6U+N9RbllA5x3NLYQ8Yqxw0
         nmaA==
X-Gm-Message-State: ACgBeo2jIP7xTRTTdrfrcNvrqqJhdj/vqo3j+54V6RmsSIgvKdORfqoE
        gtbwvETyYsA+t//ueS/TlAFApOzlLLq8+zRsmkQ0Aw==
X-Google-Smtp-Source: AA6agR6iG18Lax5VtMCCCh65Zj+vVC32muhpzLTE4lF4tiDHLJwXwnRwPrJG3gEmf1sHIs7VY5gmShNrlDXdCoRWrcY=
X-Received: by 2002:a81:6d85:0:b0:339:ace2:f30b with SMTP id
 i127-20020a816d85000000b00339ace2f30bmr7412005ywc.328.1661719656472; Sun, 28
 Aug 2022 13:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220827104600.1813214-1-liushixin2@huawei.com> <20220827104600.1813214-3-liushixin2@huawei.com>
In-Reply-To: <20220827104600.1813214-3-liushixin2@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Sun, 28 Aug 2022 22:47:25 +0200
Message-ID: <CAM4kBB+-f+TF4=q5SdxHiKPdtAO7KWDGac9vNQb9rR0rUUjYrA@mail.gmail.com>
Subject: Re: [PATCH -next v3 2/5] frontswap: invoke ops->init for online swap
 device in frontswap_register_ops
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 12:12 PM Liu Shixin <liushixin2@huawei.com> wrote:
>
> Since we are supported to delay zswap initializaton, we need to invoke
> ops->init for the swap device which is already online when register
> backend.
>
> This patch is a revert of f328c1d16e4c ("frontswap: simplify frontswap_register_ops")
> and 633423a09cb5 ("mm: mark swap_lock and swap_active_head static")
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Sorry, is this the revert of 2 patches at the same time? I would
rather not do it like that.

Thanks,
Vitaly

> ---
>  include/linux/swapfile.h |  2 ++
>  mm/frontswap.c           | 47 ++++++++++++++++++++++++++++++++++++++++
>  mm/swapfile.c            |  4 ++--
>  3 files changed, 51 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/swapfile.h b/include/linux/swapfile.h
> index 2fbcc9afd814..75fc069594a5 100644
> --- a/include/linux/swapfile.h
> +++ b/include/linux/swapfile.h
> @@ -6,6 +6,8 @@
>   * these were static in swapfile.c but frontswap.c needs them and we don't
>   * want to expose them to the dozens of source files that include swap.h
>   */
> +extern spinlock_t swap_lock;
> +extern struct plist_head swap_active_head;
>  extern struct swap_info_struct *swap_info[];
>  extern unsigned long generic_max_swapfile_size(void);
>  /* Maximum swapfile size supported for the arch (not inclusive). */
> diff --git a/mm/frontswap.c b/mm/frontswap.c
> index 620f95af81dd..449e6f499b88 100644
> --- a/mm/frontswap.c
> +++ b/mm/frontswap.c
> @@ -96,11 +96,58 @@ static inline void inc_frontswap_invalidates(void) { }
>   */
>  int frontswap_register_ops(const struct frontswap_ops *ops)
>  {
> +       DECLARE_BITMAP(a, MAX_SWAPFILES);
> +       DECLARE_BITMAP(b, MAX_SWAPFILES);
> +       struct swap_info_struct *si;
> +       unsigned int i;
> +
>         if (frontswap_ops)
>                 return -EINVAL;
>
> +       bitmap_zero(a, MAX_SWAPFILES);
> +       bitmap_zero(b, MAX_SWAPFILES);
> +
> +       spin_lock(&swap_lock);
> +       plist_for_each_entry(si, &swap_active_head, list) {
> +               if (!WARN_ON(!si->frontswap_map))
> +                       __set_bit(si->type, a);
> +       }
> +       spin_unlock(&swap_lock);
> +
> +       /* the new ops needs to know the currently active swap devices */
> +       for_each_set_bit(i, a, MAX_SWAPFILES) {
> +               pr_err("init frontswap_ops\n");
> +               ops->init(i);
> +       }
> +
>         frontswap_ops = ops;
>         static_branch_inc(&frontswap_enabled_key);
> +
> +       spin_lock(&swap_lock);
> +       plist_for_each_entry(si, &swap_active_head, list) {
> +               if (si->frontswap_map)
> +                       __set_bit(si->type, b);
> +       }
> +       spin_unlock(&swap_lock);
> +
> +       /*
> +        * On the very unlikely chance that a swap device was added or
> +        * removed between setting the "a" list bits and the ops init
> +        * calls, we re-check and do init or invalidate for any changed
> +        * bits.
> +        */
> +       if (unlikely(!bitmap_equal(a, b, MAX_SWAPFILES))) {
> +               for (i = 0; i < MAX_SWAPFILES; i++) {
> +                       if (!test_bit(i, a) && test_bit(i, b)) {
> +                               pr_err("init frontswap_ops re\n");
> +                               ops->init(i);
> +                       } else if (test_bit(i, a) && !test_bit(i, b)) {
> +                               pr_err("inval frontswap_ops re\n");
> +                               ops->invalidate_area(i);
> +                       }
> +               }
> +       }
> +
>         return 0;
>  }
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 469d9af86be2..d383b282f269 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -51,7 +51,7 @@ static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
>                                  unsigned char);
>  static void free_swap_count_continuations(struct swap_info_struct *);
>
> -static DEFINE_SPINLOCK(swap_lock);
> +DEFINE_SPINLOCK(swap_lock);
>  static unsigned int nr_swapfiles;
>  atomic_long_t nr_swap_pages;
>  /*
> @@ -77,7 +77,7 @@ static const char Unused_offset[] = "Unused swap offset entry ";
>   * all active swap_info_structs
>   * protected with swap_lock, and ordered by priority.
>   */
> -static PLIST_HEAD(swap_active_head);
> +PLIST_HEAD(swap_active_head);
>
>  /*
>   * all available (active, not full) swap_info_structs
> --
> 2.25.1
>
