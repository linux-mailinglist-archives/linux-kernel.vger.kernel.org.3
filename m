Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A7454E660
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377525AbiFPPsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376523AbiFPPsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:48:54 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4044041333
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:48:53 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r5so1611779pgr.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8yMbeVFXqMfABZuD1QhZzDycY4ah96Hm1iyf1N+XaCc=;
        b=NPaQ29iOsmaX0ern/t18JW3P7X5V0/IA95mA5CfnVJ5Wh/LAnHstJ107DuAHYvbQhx
         smVduWzMoevMvm4UFhxeipo+Yp2l6d7HcPbKO2zjkQAoCGZFUB7xAUKTGWzNSaKEkwbP
         rPDJwr3UB0UmELX5eSK/vvgZBBn5pZaA6elMumk16q86hYPgqGOKSM+fqV8EJoTa+0ao
         m6l51mGIckC+s0kwxxKB1gJBz1e7VMGirG53O2FSVxILi6q0QoEmIYoXp1EiV1hPgAdU
         s+/LLqIwEY0XATKNpWznzwir0So84J6OioTRQkqDXihwGotv1QKx7GJAiEAlZQ3PULvg
         zJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8yMbeVFXqMfABZuD1QhZzDycY4ah96Hm1iyf1N+XaCc=;
        b=UMN4jy7ILbbZvsgZHcy0H4hl90UtyfQ9szfXfbAcgpwnCLra/sf/RIMHv+cCF7Sxnw
         jn/Q+9ugnYFSECJ1Ah6GQqCJx/IbcX52n/u0+Bh9q0/0AVW1AZkzoyes201Nzvh+AhS6
         JUE6riQ0sL0Kb+bldevs/IV0XtIaZxq6FQFEnvpm8z1JVtus0FMRNOK48f6ZSpV3RTsl
         elWiUf9bhBmnt7LDeQgSlRH2elhHWDyoH/VhBYCmLhEKeCnsBAJE93ETWHPOAt6GinC/
         +AxMImVO293Upk6wmlZJDh1DmL6LYSIUp2J+zhpUr/gYZsFICIszvrCkXaMzV4+PuXPM
         NfyA==
X-Gm-Message-State: AJIora+oREjNMfhwrGqeS24wtwXlX4uNl/nnWZe6+EcKZf9l9zIxcMN8
        WT81jLfYyuIekLsn1BAKa3dDVrnXTPlEHGJnaUg=
X-Google-Smtp-Source: AGRyM1tkRjEBrR2X7zt3PKGtFk1sPtW46TnhHBgTPgTZ7YEPeO0e3yTm3z7KMBE/1wVtNsV7yn5QW4qzKIy6yycnWNc=
X-Received: by 2002:a63:3f42:0:b0:408:c84e:509c with SMTP id
 m63-20020a633f42000000b00408c84e509cmr4932844pga.75.1655394532784; Thu, 16
 Jun 2022 08:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220611084731.55155-1-linmiaohe@huawei.com> <20220611084731.55155-6-linmiaohe@huawei.com>
 <CAHbLzkrxOJmgx3mhj-5nAVXPjED9=4Pe+nzcEsXgrbv2ksVvkw@mail.gmail.com> <c48b8562-4375-ab22-9dfa-224f3e27a079@huawei.com>
In-Reply-To: <c48b8562-4375-ab22-9dfa-224f3e27a079@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 16 Jun 2022 08:48:40 -0700
Message-ID: <CAHbLzkpkzgq+YK9s1fLW9L90oBo87eaZPp3GEPv=Ug1uV9mmcA@mail.gmail.com>
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

On Thu, Jun 16, 2022 at 12:07 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2022/6/16 5:28, Yang Shi wrote:
> > On Sat, Jun 11, 2022 at 1:47 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
> >>
> >> Use helper macro __ATTR_RW to define the khugepaged attributes. Minor
> >> readability improvement.
> >>
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> ---
> >>  mm/khugepaged.c | 37 +++++++++++++++----------------------
> >>  1 file changed, 15 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >> index 8e6fad7c7bd9..142e26e4bdbf 100644
> >> --- a/mm/khugepaged.c
> >> +++ b/mm/khugepaged.c
> >> @@ -147,8 +147,7 @@ static ssize_t scan_sleep_millisecs_store(struct kobject *kobj,
> >>         return count;
> >>  }
> >>  static struct kobj_attribute scan_sleep_millisecs_attr =
> >> -       __ATTR(scan_sleep_millisecs, 0644, scan_sleep_millisecs_show,
> >> -              scan_sleep_millisecs_store);
> >> +       __ATTR_RW(scan_sleep_millisecs);
> >>
> >>  static ssize_t alloc_sleep_millisecs_show(struct kobject *kobj,
> >>                                           struct kobj_attribute *attr,
> >> @@ -175,8 +174,7 @@ static ssize_t alloc_sleep_millisecs_store(struct kobject *kobj,
> >>         return count;
> >>  }
> >>  static struct kobj_attribute alloc_sleep_millisecs_attr =
> >> -       __ATTR(alloc_sleep_millisecs, 0644, alloc_sleep_millisecs_show,
> >> -              alloc_sleep_millisecs_store);
> >> +       __ATTR_RW(alloc_sleep_millisecs);
> >>
> >>  static ssize_t pages_to_scan_show(struct kobject *kobj,
> >>                                   struct kobj_attribute *attr,
> >> @@ -200,8 +198,7 @@ static ssize_t pages_to_scan_store(struct kobject *kobj,
> >>         return count;
> >>  }
> >>  static struct kobj_attribute pages_to_scan_attr =
> >> -       __ATTR(pages_to_scan, 0644, pages_to_scan_show,
> >> -              pages_to_scan_store);
> >> +       __ATTR_RW(pages_to_scan);
> >>
> >>  static ssize_t pages_collapsed_show(struct kobject *kobj,
> >>                                     struct kobj_attribute *attr,
> >> @@ -221,13 +218,13 @@ static ssize_t full_scans_show(struct kobject *kobj,
> >>  static struct kobj_attribute full_scans_attr =
> >>         __ATTR_RO(full_scans);
> >>
> >> -static ssize_t khugepaged_defrag_show(struct kobject *kobj,
> >> +static ssize_t defrag_show(struct kobject *kobj,
> >>                                       struct kobj_attribute *attr, char *buf)
> >
> > Why do you rename all the functions? Seems unnecessary and less intriguing TBH.
>
> It's because e.g. __ATTR_RW(defrag) expects the defrag_show and defrag_store instead
> of khugepaged_defrag_show and khugepaged_defrag_store.

Aha, I see. I missed this.

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Thanks.
>
> >
> >>  {
> >>         return single_hugepage_flag_show(kobj, attr, buf,
> >>                                          TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG);
> >>  }
> >> -static ssize_t khugepaged_defrag_store(struct kobject *kobj,
> >> +static ssize_t defrag_store(struct kobject *kobj,
> >>                                        struct kobj_attribute *attr,
> >>                                        const char *buf, size_t count)
> >>  {
> >> @@ -235,8 +232,7 @@ static ssize_t khugepaged_defrag_store(struct kobject *kobj,
> >>                                  TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG);
> >>  }
> >>  static struct kobj_attribute khugepaged_defrag_attr =
> >> -       __ATTR(defrag, 0644, khugepaged_defrag_show,
> >> -              khugepaged_defrag_store);
> >> +       __ATTR_RW(defrag);
> >>
> >>  /*
> >>   * max_ptes_none controls if khugepaged should collapse hugepages over
> >> @@ -246,13 +242,13 @@ static struct kobj_attribute khugepaged_defrag_attr =
> >>   * runs. Increasing max_ptes_none will instead potentially reduce the
> >>   * free memory in the system during the khugepaged scan.
> >>   */
> >> -static ssize_t khugepaged_max_ptes_none_show(struct kobject *kobj,
> >> +static ssize_t max_ptes_none_show(struct kobject *kobj,
> >>                                              struct kobj_attribute *attr,
> >>                                              char *buf)
> >>  {
> >>         return sysfs_emit(buf, "%u\n", khugepaged_max_ptes_none);
> >>  }
> >> -static ssize_t khugepaged_max_ptes_none_store(struct kobject *kobj,
> >> +static ssize_t max_ptes_none_store(struct kobject *kobj,
> >>                                               struct kobj_attribute *attr,
> >>                                               const char *buf, size_t count)
> >>  {
> >> @@ -268,17 +264,16 @@ static ssize_t khugepaged_max_ptes_none_store(struct kobject *kobj,
> >>         return count;
> >>  }
> >>  static struct kobj_attribute khugepaged_max_ptes_none_attr =
> >> -       __ATTR(max_ptes_none, 0644, khugepaged_max_ptes_none_show,
> >> -              khugepaged_max_ptes_none_store);
> >> +       __ATTR_RW(max_ptes_none);
> >>
> >> -static ssize_t khugepaged_max_ptes_swap_show(struct kobject *kobj,
> >> +static ssize_t max_ptes_swap_show(struct kobject *kobj,
> >>                                              struct kobj_attribute *attr,
> >>                                              char *buf)
> >>  {
> >>         return sysfs_emit(buf, "%u\n", khugepaged_max_ptes_swap);
> >>  }
> >>
> >> -static ssize_t khugepaged_max_ptes_swap_store(struct kobject *kobj,
> >> +static ssize_t max_ptes_swap_store(struct kobject *kobj,
> >>                                               struct kobj_attribute *attr,
> >>                                               const char *buf, size_t count)
> >>  {
> >> @@ -295,17 +290,16 @@ static ssize_t khugepaged_max_ptes_swap_store(struct kobject *kobj,
> >>  }
> >>
> >>  static struct kobj_attribute khugepaged_max_ptes_swap_attr =
> >> -       __ATTR(max_ptes_swap, 0644, khugepaged_max_ptes_swap_show,
> >> -              khugepaged_max_ptes_swap_store);
> >> +       __ATTR_RW(max_ptes_swap);
> >>
> >> -static ssize_t khugepaged_max_ptes_shared_show(struct kobject *kobj,
> >> +static ssize_t max_ptes_shared_show(struct kobject *kobj,
> >>                                                struct kobj_attribute *attr,
> >>                                                char *buf)
> >>  {
> >>         return sysfs_emit(buf, "%u\n", khugepaged_max_ptes_shared);
> >>  }
> >>
> >> -static ssize_t khugepaged_max_ptes_shared_store(struct kobject *kobj,
> >> +static ssize_t max_ptes_shared_store(struct kobject *kobj,
> >>                                               struct kobj_attribute *attr,
> >>                                               const char *buf, size_t count)
> >>  {
> >> @@ -322,8 +316,7 @@ static ssize_t khugepaged_max_ptes_shared_store(struct kobject *kobj,
> >>  }
> >>
> >>  static struct kobj_attribute khugepaged_max_ptes_shared_attr =
> >> -       __ATTR(max_ptes_shared, 0644, khugepaged_max_ptes_shared_show,
> >> -              khugepaged_max_ptes_shared_store);
> >> +       __ATTR_RW(max_ptes_shared);
> >>
> >>  static struct attribute *khugepaged_attr[] = {
> >>         &khugepaged_defrag_attr.attr,
> >> --
> >> 2.23.0
> >>
> >>
> > .
> >
>
