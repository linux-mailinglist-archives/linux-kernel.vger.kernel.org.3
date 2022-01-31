Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2F74A4DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbiAaSEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiAaSE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:04:28 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CFBC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:04:28 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id g14so42956291ybs.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jKOkqEsF/LF5CvREpOhl/oWeS4V81mya8jnYw1wCDFw=;
        b=ZoEoPhFI/SkB8VO31hL0sxmvpM9bvkaNazc4+33voZ+d+Jq5CVfcf/4q4i0xfFVF+K
         6K3x1JC51OSZS84XuLrcAnSAKYqNlF3njdyY4m4M/pKKeCHTbzs+Xq85lzme9M8UxF4I
         1WfKC4mIWOsksRwShjtGW08RG0g2y8tChKAdjmFXp7Q3TjfNzMl9p/WhNHEqW/+QkIFr
         Yr5a3t+LeDzoi58dWsvqQRJ8qK6GGOHZzpXWEpXhYHvp2noblx7S6Gzn1tb7BLZHKN7X
         e23AKSODY44B7jDfGz4rsRiFIXwRylsE/dpWc9z9mafZeHrt3om02GsVon7YI8i/miOP
         c+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jKOkqEsF/LF5CvREpOhl/oWeS4V81mya8jnYw1wCDFw=;
        b=GMFZVyRQiyzYcryFBYwZdIWcC6iTBLvngQTRYRrZ7ei80gsFCoBxBXVnjo5NaT7tWm
         cGy/Unrff0iGmGi7aYuccOxqQqYxopVLppLctIQAqKteLRwIG9o3GH4nrl9ENtHvaSJX
         n5I0qrplutN7oxmFbRwmh6k9b3DLnPBXYEfj7+pCqMRE9Q+lhlBLi8HOiQptVve0BwXT
         q2wSEn85JUtMeyc8aMxBOa8Ch/89uB8ABaeRcVav8y1DwblIfOiI5K/m9Xf7f8BP+Hsb
         NzMPy1VBrumHvZ8kuwwDQzyJ8EFWQ5Lf1WiHMxj3JBPBEk8tMQLOG8qsvJiujYFzmi3p
         9Chg==
X-Gm-Message-State: AOAM530krmdnpzefL5XJjPE/KI4j/fFsdJYBmTbwQilfQrsrQMY+64V0
        weaqd7cE3NUdONvrrpRAx2zgTrTMVBo0CzMp/qzfYg==
X-Google-Smtp-Source: ABdhPJxSm9PiQ3U9z6FjArWXy90UeaLFc3caonzQOEh5hkATCDM1i9WF3dnhHFARISw+yK8dDaKgygwIlt49Rck/uf0=
X-Received: by 2002:a25:be41:: with SMTP id d1mr33068235ybm.488.1643652267644;
 Mon, 31 Jan 2022 10:04:27 -0800 (PST)
MIME-Version: 1.0
References: <20220128131006.67712-1-michel@lespinasse.org> <20220128131006.67712-23-michel@lespinasse.org>
 <20220129121319.3593-1-hdanton@sina.com>
In-Reply-To: <20220129121319.3593-1-hdanton@sina.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 31 Jan 2022 10:04:16 -0800
Message-ID: <CAJuCfpHBfSQBuz8=LHYhX-aOgZ1ng6nNfpv_jeBLz+KVr1OU5w@mail.gmail.com>
Subject: Re: [PATCH v2 22/35] percpu-rwsem: enable percpu_sem destruction in
 atomic context
To:     Hillf Danton <hdanton@sina.com>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 4:13 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On Fri, 28 Jan 2022 05:09:53 -0800 Michel Lespinasse wrote:
> > +
> > +static LIST_HEAD(destroy_list);
> > +static DEFINE_SPINLOCK(destroy_list_lock);
>
>    static bool destroyer_running;
>
> > +
> > +static void destroy_list_workfn(struct work_struct *work)
> > +{
> > +     struct percpu_rw_semaphore *sem, *sem2;
> > +     LIST_HEAD(to_destroy);
> > +
>
> again:
>
> > +     spin_lock(&destroy_list_lock);
>
>         if (list_empty(&destroy_list)) {
>                 destroyer_running = false;
>                 spin_unlock(&destroy_list_lock);
>                 return;
>         }
>         destroyer_running = true;
>
> > +     list_splice_init(&destroy_list, &to_destroy);
> > +     spin_unlock(&destroy_list_lock);
> > +
> > +     if (list_empty(&to_destroy))
> > +             return;
> > +
> > +     list_for_each_entry_safe(sem, sem2, &to_destroy, destroy_list_entry) {
>
>                 list_del(&sem->destroy_list_entry);
>
> > +             percpu_free_rwsem(sem);
> > +             kfree(sem);
> > +     }
>
>         goto again;
> > +}
> > +
> > +static DECLARE_WORK(destroy_list_work, destroy_list_workfn);
> > +
> > +void percpu_rwsem_async_destroy(struct percpu_rw_semaphore *sem)
> > +{
> > +     spin_lock(&destroy_list_lock);
> > +     list_add_tail(&sem->destroy_list_entry, &destroy_list);
> > +     spin_unlock(&destroy_list_lock);
> > +     schedule_work(&destroy_list_work);
>
> Nits
>         spin_lock(&destroy_list_lock);
> 1/      /* LIFO */
>         list_add(&sem->destroy_list_entry, &destroy_list);
> 2/      /* spawn worker if it is idle */
>         if (!destroyer_running)
> 3/              /* this is not critical work */
>                 queue_work(system_unbound_wq, &destroy_list_work);
>         spin_unlock(&destroy_list_lock);

Thanks for the review! Just to clarify, are you suggesting
simplifications to the current patch or do you see a function issue?

> > +}
> > --
> > 2.20.1
>
