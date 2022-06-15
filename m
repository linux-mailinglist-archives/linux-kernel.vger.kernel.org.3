Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2905E54D3B5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350224AbiFOV3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349595AbiFOV3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:29:00 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BAA56235
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:28:58 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id f65so12524075pgc.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6uvhMM2/svDEJEOuEple2fSlFRO2Ne9NBTatMU0CMw=;
        b=KLWfkbuTWupigOp7cJSukY+RwiP/N2atK1KZGvPU6jSkKujdEaiA8appxopU7wYdjH
         KMljlAktEMCx6XjKPU9sjVvg73VhyKkTpcGFnaFMuU0Rr97VCfrP9gpt8cXHHP/Hzl2N
         ZiiT6hOb3VG3cOJ9CkxKRnHJ/wMxjbD4dyMu3S3O6mY0RHmHNJOxXJQFHUMmR60Kq/B4
         lWrmJRIQgc38GVpCDQT2VcBr3jvOpovQnl2FhUOyRaruTqRbrVvnWwVD4E587ZG8QoqP
         uX4cnPw1AMKw82Hnmn31tGm5Oq+k0c87lBUsqP9TtzLQBBcrwb0zQCsSvWXEmng7CkZ2
         agIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6uvhMM2/svDEJEOuEple2fSlFRO2Ne9NBTatMU0CMw=;
        b=r9eZtQN+2lEj1CBr1zZOGIz24FYMuPKaYx4IupXGxnMhMrDjZ70JPDDNhTYItSZNX1
         LbMsJr35PpqbjTb5DRxpIPW+oY1qREMggZp8ZG9Oc40jr2EnkGF4jY1XsLhbQmFcf6vz
         Ui5eNNcTaEixjt2NXIvfwweMBwpQIhVQ0bthDDczZJ579hIQbySOxD7wYd6l5xaIJo3x
         8yTNi3h0EKTDMAoPd6Sb5W56G9fIMQ11I/X7ySRhfT4NEms4Kz44EBxZUa9UQ+PrgwhN
         tCXN2S1mhSAXEJ2CZQRUih5xIEvFpIuh5UFbOFYZJNHQ4PHGe0bD7T7EaLYkg5qBhppt
         JzRQ==
X-Gm-Message-State: AJIora8CaYssNfFALlC1vk5sA2hEM67in3Q78Mwx3CYR94Aakvdq9+32
        1FL34u1ZN+AaUDJdah5nwqO5b34Nc/HsjJac4xc=
X-Google-Smtp-Source: AGRyM1txoy0fUwJdaPAaRSfvdgLAtJXs6wo8KOYeiXrj7lPTXQlK6mvrA30wb7LJ2SB8dxKB1kZtz0lsRsVSUZF0FyQ=
X-Received: by 2002:a63:3183:0:b0:3fd:6797:70a8 with SMTP id
 x125-20020a633183000000b003fd679770a8mr1557693pgx.206.1655328538407; Wed, 15
 Jun 2022 14:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220611084731.55155-1-linmiaohe@huawei.com> <20220611084731.55155-6-linmiaohe@huawei.com>
In-Reply-To: <20220611084731.55155-6-linmiaohe@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 15 Jun 2022 14:28:46 -0700
Message-ID: <CAHbLzkrxOJmgx3mhj-5nAVXPjED9=4Pe+nzcEsXgrbv2ksVvkw@mail.gmail.com>
Subject: Re: [PATCH 5/7] mm/khugepaged: use helper macro __ATTR_RW
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Howells <dhowells@redhat.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 1:47 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Use helper macro __ATTR_RW to define the khugepaged attributes. Minor
> readability improvement.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/khugepaged.c | 37 +++++++++++++++----------------------
>  1 file changed, 15 insertions(+), 22 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 8e6fad7c7bd9..142e26e4bdbf 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -147,8 +147,7 @@ static ssize_t scan_sleep_millisecs_store(struct kobject *kobj,
>         return count;
>  }
>  static struct kobj_attribute scan_sleep_millisecs_attr =
> -       __ATTR(scan_sleep_millisecs, 0644, scan_sleep_millisecs_show,
> -              scan_sleep_millisecs_store);
> +       __ATTR_RW(scan_sleep_millisecs);
>
>  static ssize_t alloc_sleep_millisecs_show(struct kobject *kobj,
>                                           struct kobj_attribute *attr,
> @@ -175,8 +174,7 @@ static ssize_t alloc_sleep_millisecs_store(struct kobject *kobj,
>         return count;
>  }
>  static struct kobj_attribute alloc_sleep_millisecs_attr =
> -       __ATTR(alloc_sleep_millisecs, 0644, alloc_sleep_millisecs_show,
> -              alloc_sleep_millisecs_store);
> +       __ATTR_RW(alloc_sleep_millisecs);
>
>  static ssize_t pages_to_scan_show(struct kobject *kobj,
>                                   struct kobj_attribute *attr,
> @@ -200,8 +198,7 @@ static ssize_t pages_to_scan_store(struct kobject *kobj,
>         return count;
>  }
>  static struct kobj_attribute pages_to_scan_attr =
> -       __ATTR(pages_to_scan, 0644, pages_to_scan_show,
> -              pages_to_scan_store);
> +       __ATTR_RW(pages_to_scan);
>
>  static ssize_t pages_collapsed_show(struct kobject *kobj,
>                                     struct kobj_attribute *attr,
> @@ -221,13 +218,13 @@ static ssize_t full_scans_show(struct kobject *kobj,
>  static struct kobj_attribute full_scans_attr =
>         __ATTR_RO(full_scans);
>
> -static ssize_t khugepaged_defrag_show(struct kobject *kobj,
> +static ssize_t defrag_show(struct kobject *kobj,
>                                       struct kobj_attribute *attr, char *buf)

Why do you rename all the functions? Seems unnecessary and less intriguing TBH.

>  {
>         return single_hugepage_flag_show(kobj, attr, buf,
>                                          TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG);
>  }
> -static ssize_t khugepaged_defrag_store(struct kobject *kobj,
> +static ssize_t defrag_store(struct kobject *kobj,
>                                        struct kobj_attribute *attr,
>                                        const char *buf, size_t count)
>  {
> @@ -235,8 +232,7 @@ static ssize_t khugepaged_defrag_store(struct kobject *kobj,
>                                  TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG);
>  }
>  static struct kobj_attribute khugepaged_defrag_attr =
> -       __ATTR(defrag, 0644, khugepaged_defrag_show,
> -              khugepaged_defrag_store);
> +       __ATTR_RW(defrag);
>
>  /*
>   * max_ptes_none controls if khugepaged should collapse hugepages over
> @@ -246,13 +242,13 @@ static struct kobj_attribute khugepaged_defrag_attr =
>   * runs. Increasing max_ptes_none will instead potentially reduce the
>   * free memory in the system during the khugepaged scan.
>   */
> -static ssize_t khugepaged_max_ptes_none_show(struct kobject *kobj,
> +static ssize_t max_ptes_none_show(struct kobject *kobj,
>                                              struct kobj_attribute *attr,
>                                              char *buf)
>  {
>         return sysfs_emit(buf, "%u\n", khugepaged_max_ptes_none);
>  }
> -static ssize_t khugepaged_max_ptes_none_store(struct kobject *kobj,
> +static ssize_t max_ptes_none_store(struct kobject *kobj,
>                                               struct kobj_attribute *attr,
>                                               const char *buf, size_t count)
>  {
> @@ -268,17 +264,16 @@ static ssize_t khugepaged_max_ptes_none_store(struct kobject *kobj,
>         return count;
>  }
>  static struct kobj_attribute khugepaged_max_ptes_none_attr =
> -       __ATTR(max_ptes_none, 0644, khugepaged_max_ptes_none_show,
> -              khugepaged_max_ptes_none_store);
> +       __ATTR_RW(max_ptes_none);
>
> -static ssize_t khugepaged_max_ptes_swap_show(struct kobject *kobj,
> +static ssize_t max_ptes_swap_show(struct kobject *kobj,
>                                              struct kobj_attribute *attr,
>                                              char *buf)
>  {
>         return sysfs_emit(buf, "%u\n", khugepaged_max_ptes_swap);
>  }
>
> -static ssize_t khugepaged_max_ptes_swap_store(struct kobject *kobj,
> +static ssize_t max_ptes_swap_store(struct kobject *kobj,
>                                               struct kobj_attribute *attr,
>                                               const char *buf, size_t count)
>  {
> @@ -295,17 +290,16 @@ static ssize_t khugepaged_max_ptes_swap_store(struct kobject *kobj,
>  }
>
>  static struct kobj_attribute khugepaged_max_ptes_swap_attr =
> -       __ATTR(max_ptes_swap, 0644, khugepaged_max_ptes_swap_show,
> -              khugepaged_max_ptes_swap_store);
> +       __ATTR_RW(max_ptes_swap);
>
> -static ssize_t khugepaged_max_ptes_shared_show(struct kobject *kobj,
> +static ssize_t max_ptes_shared_show(struct kobject *kobj,
>                                                struct kobj_attribute *attr,
>                                                char *buf)
>  {
>         return sysfs_emit(buf, "%u\n", khugepaged_max_ptes_shared);
>  }
>
> -static ssize_t khugepaged_max_ptes_shared_store(struct kobject *kobj,
> +static ssize_t max_ptes_shared_store(struct kobject *kobj,
>                                               struct kobj_attribute *attr,
>                                               const char *buf, size_t count)
>  {
> @@ -322,8 +316,7 @@ static ssize_t khugepaged_max_ptes_shared_store(struct kobject *kobj,
>  }
>
>  static struct kobj_attribute khugepaged_max_ptes_shared_attr =
> -       __ATTR(max_ptes_shared, 0644, khugepaged_max_ptes_shared_show,
> -              khugepaged_max_ptes_shared_store);
> +       __ATTR_RW(max_ptes_shared);
>
>  static struct attribute *khugepaged_attr[] = {
>         &khugepaged_defrag_attr.attr,
> --
> 2.23.0
>
>
