Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71154BF19B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 06:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiBVFmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:42:37 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiBVFmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:42:20 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F40B854
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 21:41:47 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id e140so38731781ybh.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 21:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q3j1v/ieMhWWZ8B1LjbJFMKNN3+pYWRoz3JVkgTF+2M=;
        b=IzgCNKJMkd3X18WfrRnx1/vbPzn5YqpZRgWbvXhcTGrcSjf5mZ70iqEEHP/IjEevxA
         kTkpugo6dJAc/ZGigkizl54+/Oy+aXpsCbo8CyXJFquQJfVWKNVv48ns4e5hrcKt58ll
         UEM21waFMiJQ1LMPMQm9OtRYmAuAfDDkMCcbAjdzSgeN0MuqbiAHzg+ujppAev0s5As+
         K9/QlTUQwd90lyNhgYuDjDt2ELLauUcadRrQNKvnha9Bl8tg1mmTkKgVzCEWyrjbSdXO
         GsR66v522BrQRGNS2107poTKqJ9WqNMvTU+LvoBRuhb5LNjY80TNWCzivd33Jr84LQAP
         NGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3j1v/ieMhWWZ8B1LjbJFMKNN3+pYWRoz3JVkgTF+2M=;
        b=nSJ5Zl8NjlQPZcM3w+SkpN1BXUBg4cSS+qBG5RGfZN8Qft2nxlDVPraSjuPdPXPxPO
         PwZsPdN73o+1K1U40yUQO7U0NVrpUkfrw00ptHJ9tmUGPi0Z/O3VTKk9kvuHeddLHBM5
         LWL9DuvTt7x3yoxdZeNVYt+DzrXCAElJ4U4xlXnTz45y4OTHXR87qIRg2J71TN7NTXNg
         XBmLWawVESdI1nhk1BOb5NkJKuaVSkDBtEal1Sx7HaGnWPFcRWUnvHJWRgKAi+/ACwoV
         +HyULCPjb4DWEB3GdNd8cqjv4MecJ4VsdzHRj7ft/1JoaPCI+QmTtQKKGl1DAl9kj/mJ
         asWQ==
X-Gm-Message-State: AOAM533LnZZZu34evRB1f3P4V8EOlz/ciTZKLHqpaO1LDqYOjsgKSS5t
        fko4CdSS1pvjByXvx3Fj3GpAeVg9WDJCaXE9IBZqdA==
X-Google-Smtp-Source: ABdhPJzRzwoQ5s6qyAHP8/WqFbpiNGqoLzw7CNXZasSgjjaB7Va0jlhjUkvhdql7d7H/JNlR02DnTOEVVLEiVzYdZ78=
X-Received: by 2002:a25:2693:0:b0:624:50a8:fee9 with SMTP id
 m141-20020a252693000000b0062450a8fee9mr15135617ybm.348.1645508501550; Mon, 21
 Feb 2022 21:41:41 -0800 (PST)
MIME-Version: 1.0
References: <20220222054025.3412898-1-surenb@google.com> <20220222054025.3412898-3-surenb@google.com>
In-Reply-To: <20220222054025.3412898-3-surenb@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 21 Feb 2022 21:41:30 -0800
Message-ID: <CAJuCfpHrwz-FJsPzCMk2go8GH8t7e8xSPQ=91H=Ctk+6JSBn-g@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm: fix use-after-free when anon vma name is used
 after vma is freed
To:     akpm@linux-foundation.org
Cc:     ccross@google.com, sumit.semwal@linaro.org, mhocko@suse.com,
        dave.hansen@intel.com, keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, ebiederm@xmission.com, brauner@kernel.org,
        legion@kernel.org, ran.xiaokai@zte.com.cn, sashal@kernel.org,
        chris.hyser@oracle.com, dave@stgolabs.net, pcc@google.com,
        caoxiaofeng@yulong.com, david@redhat.com, gorcunov@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com,
        syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
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

On Mon, Feb 21, 2022 at 9:40 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> When adjacent vmas are being merged it can result in the vma that was
> originally passed to madvise_update_vma being destroyed.  In the current
> implementation, the name parameter passed to madvise_update_vma points
> directly to vma->anon_name->name and it is used after the call to
> vma_merge.  In the cases when vma_merge merges the original vma and
> destroys it, this will result in use-after-free bug as shown below:
>
> madvise_vma_behavior << passes vma->anon_name->name as name param
>   madvise_update_vma(name)
>     vma_merge
>       __vma_adjust
>         vm_area_free <-- frees the vma
>     replace_vma_anon_name(name) <-- UAF
>
> Fix this by raising the name refcount and stabilizing it.
>
> Fixes: 9a10064f5625 ("mm: add a field to store names for private anonymous memory")
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reported-by: syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
> ---
> changes in v3:
> - Reapplied the fix after code refactoring, per Michal Hocko

Hi Andrew,
Since I needed to make some refactoring before adding this fix, in
order to apply this new version to mmotm you would need to revert the
previous version of this patch from your tree:
0cc16837d264 ("mm: fix use-after-free when anon vma name is used after
vma is freed")
and then apply the whole patchset (3 patches) after it is reviewed.
Sorry for the inconvenience but I think this way the refactoring and
the fix would be in the right order and with no overlap.
The patchset applies cleanly to Linus' ToT and to mmotm after
0cc16837d264 is reverted.
Thanks,
Suren.

>
>  mm/madvise.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index a395884aeecb..00e8105430e9 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -140,6 +140,8 @@ static int replace_vma_anon_name(struct vm_area_struct *vma,
>  /*
>   * Update the vm_flags on region of a vma, splitting it or merging it as
>   * necessary.  Must be called with mmap_sem held for writing;
> + * Caller should ensure anon_name stability by raising its refcount even when
> + * anon_name belongs to a valid vma because this function might free that vma.
>   */
>  static int madvise_update_vma(struct vm_area_struct *vma,
>                               struct vm_area_struct **prev, unsigned long start,
> @@ -1021,8 +1023,10 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
>         }
>
>         anon_name = vma_anon_name(vma);
> +       anon_vma_name_get(anon_name);
>         error = madvise_update_vma(vma, prev, start, end, new_flags,
>                                    anon_name);
> +       anon_vma_name_put(anon_name);
>
>  out:
>         /*
> --
> 2.35.1.473.g83b2b277ed-goog
>
