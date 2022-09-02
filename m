Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289385AA741
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 07:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiIBFcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 01:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIBFcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 01:32:43 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6FDB69EA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 22:32:43 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j9-20020a17090a3e0900b001fd9568b117so1111355pjc.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 22:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=rtJH7HDl3ZtKSbrfLkxuA1N38k7LaCGirWVFNaiJ6R4=;
        b=TLwLBT3uGdA+Z8T75wH08Ri404/Qtg9nbBpojuvigEs/I6m+/vOfLlNUIgvcRUBjRv
         xd6pyeC7pZ6K8jP0tKu5XOaQyLEbfQloPxspX2b9PfO9SIjOU1sivZWKVF7rnSRuSl9b
         bsw8pLIE7OOrugLZKK8J9CITZGlXOSRaYFuR/SLF+tlyrH1VXZe6JBilcXxI/QVTjPHD
         fQ/dl4U2C9yX50CJblBIui6sH4rnbfwv6JW7KIHetG2tznuC4NjAlgf3YcRX3o4VoW/R
         /jgz87ZWiY/Bij45zvdDUNSoWzFwBqVIGWEL4Ox2xosW4+Es7WQvOvqPRYev7IYT7xzs
         6PQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rtJH7HDl3ZtKSbrfLkxuA1N38k7LaCGirWVFNaiJ6R4=;
        b=2nXS3AqMbYuy8GGuiVOjQu8IdQ3baXQz+I/0pB/YSGaQ2/WamwuffaQ6emCvkpqboy
         2Xz85pdoQhn7vYNiuYVAul9fLKxNz5ZTRxrXFIcTJ8SlR43BvVCztp+6o2E5w2Br4qEV
         dYhRDtJCHuwKPH/wGDOYfm3kFVryViPczZFbBTNDBgH6Y8y5kkaZmjByH+Q4rlKu7p4o
         ikeALmGMcLzgxFYC+xhfUHxO+GgLeiG75HVuDAUi5HQ9ytGX1uGyMNEofsS9h0uPiL46
         Qkimt1XVJ5QNrZpB7U/PmdKk5mi+PVdh0yrs0Z1qystV9IDO++PKGgIXriKy7YDx7caK
         od1w==
X-Gm-Message-State: ACgBeo1nJj4IgLb7dz4vGiDQUqOJtrg9mGwOIo713f7ywL+LIkBVO3TV
        Wji2VfVIi1CE2tRpgr12WnWeo+kWoCI=
X-Google-Smtp-Source: AA6agR5DZqKe/pZ3wQTonj7mZ/5CX3roXnOiggq9KM6jHI+wC94769cob0GqyU6YD6/oXyMK+1z/rQ==
X-Received: by 2002:a17:90b:4ac3:b0:1fd:ded0:ea80 with SMTP id mh3-20020a17090b4ac300b001fdded0ea80mr2926310pjb.142.1662096762577;
        Thu, 01 Sep 2022 22:32:42 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id b24-20020a630c18000000b0042a5e8486a1sm513142pgl.42.2022.09.01.22.32.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Sep 2022 22:32:42 -0700 (PDT)
Date:   Fri, 2 Sep 2022 13:34:58 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: fix pcluster use-after-free on UP platforms
Message-ID: <20220902133458.000008b0.zbestahu@gmail.com>
In-Reply-To: <20220902045710.109530-1-hsiangkao@linux.alibaba.com>
References: <20220902045710.109530-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  2 Sep 2022 12:57:10 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> During stress testing with CONFIG_SMP disabled, KASAN reports as below:
> 
> ==================================================================
> BUG: KASAN: use-after-free in __mutex_lock+0xe5/0xc30
> Read of size 8 at addr ffff8881094223f8 by task stress/7789
> [ 3482.258885]
> CPU: 0 PID: 7789 Comm: stress Not tainted 6.0.0-rc1-00002-g0d53d2e882f9 #3
> Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> Call Trace:
>  <TASK>
> ..
>  __mutex_lock+0xe5/0xc30
> ..
>  z_erofs_do_read_page+0x8ce/0x1560
> ..
>  z_erofs_readahead+0x31c/0x580
> ..
> Freed by task 7787
>  kasan_save_stack+0x1e/0x40
>  kasan_set_track+0x20/0x30
>  kasan_set_free_info+0x20/0x40
>  __kasan_slab_free+0x10c/0x190
>  kmem_cache_free+0xed/0x380
>  rcu_core+0x3d5/0xc90
>  __do_softirq+0x12d/0x389
> [ 3482.295630]
> Last potentially related work creation:
>  kasan_save_stack+0x1e/0x40
>  __kasan_record_aux_stack+0x97/0xb0
>  call_rcu+0x3d/0x3f0
>  erofs_shrink_workstation+0x11f/0x210
>  erofs_shrink_scan+0xdc/0x170
>  shrink_slab.constprop.0+0x296/0x530
>  drop_slab+0x1c/0x70
>  drop_caches_sysctl_handler+0x70/0x80
>  proc_sys_call_handler+0x20a/0x2f0
>  vfs_write+0x555/0x6c0
>  ksys_write+0xbe/0x160
>  do_syscall_64+0x3b/0x90
> 
> The root cause is that erofs_workgroup_unfreeze() doesn't reset
> to orig_val thus it causes a race that the pcluster reuses unexpectedly
> before freeing.
> 
> Since UP platforms are quite rare now, such path becomes unnecessary.
> Let's drop such specific-designed path directly instead.
> 
> Fixes: 73f5c66df3e2 ("staging: erofs: fix `erofs_workgroup_{try_to_freeze, unfreeze}'")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/internal.h | 29 -----------------------------
>  1 file changed, 29 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index cfee49d33b95..a01cc82795a2 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -195,7 +195,6 @@ struct erofs_workgroup {
>  	atomic_t refcount;
>  };
>  
> -#if defined(CONFIG_SMP)
>  static inline bool erofs_workgroup_try_to_freeze(struct erofs_workgroup *grp,
>  						 int val)
>  {
> @@ -224,34 +223,6 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
>  	return atomic_cond_read_relaxed(&grp->refcount,
>  					VAL != EROFS_LOCKED_MAGIC);
>  }
> -#else
> -static inline bool erofs_workgroup_try_to_freeze(struct erofs_workgroup *grp,
> -						 int val)
> -{
> -	preempt_disable();
> -	/* no need to spin on UP platforms, let's just disable preemption. */
> -	if (val != atomic_read(&grp->refcount)) {
> -		preempt_enable();
> -		return false;
> -	}
> -	return true;
> -}
> -
> -static inline void erofs_workgroup_unfreeze(struct erofs_workgroup *grp,
> -					    int orig_val)
> -{
> -	preempt_enable();
> -}
> -
> -static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
> -{
> -	int v = atomic_read(&grp->refcount);
> -
> -	/* workgroup is never freezed on uniprocessor systems */
> -	DBG_BUGON(v == EROFS_LOCKED_MAGIC);
> -	return v;
> -}
> -#endif	/* !CONFIG_SMP */
>  #endif	/* !CONFIG_EROFS_FS_ZIP */
>  

Reviewed-by: Yue Hu <huyue2@coolpad.com>

>  /* we strictly follow PAGE_SIZE and no buffer head yet */

