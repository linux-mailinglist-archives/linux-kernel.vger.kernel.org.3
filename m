Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623F6598A63
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344842AbiHRRXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344699AbiHRRWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:22:34 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE61F5B6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:22:32 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id b15so1131745ilq.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc;
        bh=jH2VlH2vwqX5qxVWjudYS+DqwE3jxZzRobXXOdNN1PA=;
        b=fIMLDjhPlqtyKIGWal957mZqvdDJwRo/FxSUBuh9Zg2aufKTVm+F5hPo7qYebI/OnS
         YsaOrfi5k9v3CF8ptF2rlnSdiVXHNAuST2BPEgU9ZIaGaVai45462/2h7xe/8JzhyO7k
         i0rVwx9VnqAZy1S5AFLmfD2ZbKKwhpL4Cby+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc;
        bh=jH2VlH2vwqX5qxVWjudYS+DqwE3jxZzRobXXOdNN1PA=;
        b=o+avUmwRwwkCJb25tj4lpWUHIrGlpvm+A4NxTIBy0T/58MhyOuN/mQTgvomMEBXgn2
         rVdNjEcc8baiwCUoCnkhoAN+asnpQeVuIOISDC9W2oSHJ1JKMzTa3RKkzeZdpxHw0fTi
         O/lnW4HBxjsfmCUyLhROiH2yQ+YQaxRUurFl4z3oK8jJ86QXshTENjR3HUTqFKc365cv
         Mrys++d7hwRYsTGFJXHTi0cma9pCVBMQgIoLSqC6j6R4EO88nGDH8Gw97t8/WrY1Somu
         54Cx+4Y8IaxKB/6yjV1isThspQ8tHZVcjNeEWjkzUDcjjAtnPOdqRV4s3/DwyF2CxvY6
         9DJg==
X-Gm-Message-State: ACgBeo0ZRcY9rwFPCevGRrC0gGYrC367x416YDYyWNzywwunYFdrlunE
        q46ROQcucWh19/awsMy6Q4zEE55o2cVb9xh5cEedOWKtyU6Xsg==
X-Google-Smtp-Source: AA6agR56YpcxhvGBL8DRhBX8nAjPsZ11NEeok4yV/vqvGdMAe6CkrAzrZjozA/qqKnWkAI1TnNwn9b7JPLpuymji6fE=
X-Received: by 2002:a05:6e02:20eb:b0:2df:302c:fb10 with SMTP id
 q11-20020a056e0220eb00b002df302cfb10mr1931040ilv.35.1660843351572; Thu, 18
 Aug 2022 10:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220809034517.3867176-1-joel@joelfernandes.org> <20220809034517.3867176-5-joel@joelfernandes.org>
In-Reply-To: <20220809034517.3867176-5-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 18 Aug 2022 13:22:20 -0400
Message-ID: <CAEXW_YSMYj6DN+ps09SkU2t1hNNg+xGf-6c0rL8dBoy262_-ew@mail.gmail.com>
Subject: Re: [PATCH v3 resend 4/6] fs: Move call_rcu() to call_rcu_lazy() in
 some paths
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 8, 2022 at 11:45 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> This is required to prevent callbacks triggering RCU machinery too
> quickly and too often, which adds more power to the system.
>
> When testing, we found that these paths were invoked often when the
> system is not doing anything (screen is ON but otherwise idle).

Unfortunately, I am seeing a slow down in ChromeOS boot performance
after applying this particular patch. It is the first time I could
test ChromeOS boot times with the series since it was hard to find a
ChromeOS device that runs the upstream kernel.

Anyway, Vlad, Neeraj, do you guys also see slower boot times with this
patch? I wonder if the issue is with wake up interaction with the nocb
GP threads.

We ought to disable lazy RCU during boot since it would have little
benefit anyway. But I am also concerned about some deeper problem I
did not catch before.

I'll look into tracing the fs paths to see if I can narrow down what's
causing it. Will also try a newer kernel, I am currently testing on
5.19-rc4.

Thanks,

 - Joel

>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  fs/dcache.c     | 4 ++--
>  fs/eventpoll.c  | 2 +-
>  fs/file_table.c | 2 +-
>  fs/inode.c      | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 93f4f5ee07bf..7f51bac390c8 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -366,7 +366,7 @@ static void dentry_free(struct dentry *dentry)
>         if (unlikely(dname_external(dentry))) {
>                 struct external_name *p = external_name(dentry);
>                 if (likely(atomic_dec_and_test(&p->u.count))) {
> -                       call_rcu(&dentry->d_u.d_rcu, __d_free_external);
> +                       call_rcu_lazy(&dentry->d_u.d_rcu, __d_free_external);
>                         return;
>                 }
>         }
> @@ -374,7 +374,7 @@ static void dentry_free(struct dentry *dentry)
>         if (dentry->d_flags & DCACHE_NORCU)
>                 __d_free(&dentry->d_u.d_rcu);
>         else
> -               call_rcu(&dentry->d_u.d_rcu, __d_free);
> +               call_rcu_lazy(&dentry->d_u.d_rcu, __d_free);
>  }
>
>  /*
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 971f98af48ff..57b3f781760c 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -729,7 +729,7 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
>          * ep->mtx. The rcu read side, reverse_path_check_proc(), does not make
>          * use of the rbn field.
>          */
> -       call_rcu(&epi->rcu, epi_rcu_free);
> +       call_rcu_lazy(&epi->rcu, epi_rcu_free);
>
>         percpu_counter_dec(&ep->user->epoll_watches);
>
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 5424e3a8df5f..417f57e9cb30 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -56,7 +56,7 @@ static inline void file_free(struct file *f)
>         security_file_free(f);
>         if (!(f->f_mode & FMODE_NOACCOUNT))
>                 percpu_counter_dec(&nr_files);
> -       call_rcu(&f->f_u.fu_rcuhead, file_free_rcu);
> +       call_rcu_lazy(&f->f_u.fu_rcuhead, file_free_rcu);
>  }
>
>  /*
> diff --git a/fs/inode.c b/fs/inode.c
> index bd4da9c5207e..38fe040ddbd6 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -312,7 +312,7 @@ static void destroy_inode(struct inode *inode)
>                         return;
>         }
>         inode->free_inode = ops->free_inode;
> -       call_rcu(&inode->i_rcu, i_callback);
> +       call_rcu_lazy(&inode->i_rcu, i_callback);
>  }
>
>  /**
> --
> 2.37.1.559.g78731f0fdb-goog
>
