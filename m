Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB42D50BDCA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351991AbiDVRDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiDVRDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:03:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C38674C6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:00:34 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q1so10955870plx.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v10trzwmlMCF4HVp15qAuxE5rF7lrmO1VjAPHLwUdps=;
        b=PhAKy1aIPDKAyUGzAW6fh1WV9VMGt1h6sguykFrQ1SOBILmS4Y0He9cKkDqnV12toU
         pzUjgo6koPLaemsZ8DHn4lbSuqJI06xyM2VXxsStSUdgQJQziz/YVTp8BHlnZ9KroNwE
         bINxJo/FiAiBk0Cn9kS0vfsD/fxE8xJbQvPY5BdhkBxFoi6WCjHVrJBcHoukxWPr2ozM
         qxOU5TiqUvtmK5fl9mnGYsp/ba4ToWMwrSRPMhrCSj0yPhB3XbVuv3hcvUhUpitV7aWk
         Y4hh58yVTDOTS8zSHEX28K9sZl/kcQl6QjQvWW5j/s/1aGeP/MBWUs30Gdf2iG/2Xktj
         D3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=v10trzwmlMCF4HVp15qAuxE5rF7lrmO1VjAPHLwUdps=;
        b=sOIwJ9jQ8OJKtTNkbsRoFXcwWT/kS8e7pTZK95hq8ixoC+M1a06KdhjSEQ+am7mjuI
         iTkz+eP1qZSuvvpPSpVbbkOqraw8QRfW6MDUsf1XVR5qQKlIcuZujhFDjvmrkztN6MEI
         tYXJf90AWsz+aAijb+RKudziUHJZUgw9tqlqECeQ3uzbgQmrA7VPhDPA97inZf0qiM/c
         cSidPuHYr/pkKaKHhtAebNUqmXDXAxRd/MP0GBF0wtDqjBfwIWGSxmn608NrLAvXvC+s
         A+P6lM/85VgYUHpVnHWSygOeNSzTuQgo3hiqzBHDN6krGBiF/vrvQnkUXtkzp+ZL6vjr
         m74Q==
X-Gm-Message-State: AOAM532lO1sJRWjkGtyWTjbd85yRu22DM8xXCkEzS9+dY4nhpmyD0/y5
        DDB9BLYaFdjIOSxWtxWjG94=
X-Google-Smtp-Source: ABdhPJxmX5W2RIM2SeB/u4w9g1T3kWJ861csqw3e80DEucccbgz9SQa8UNGFwHtoWmT3U3z+bJ5COg==
X-Received: by 2002:a17:90a:1d0e:b0:1cb:50ec:27f with SMTP id c14-20020a17090a1d0e00b001cb50ec027fmr17367450pjd.195.1650646832186;
        Fri, 22 Apr 2022 10:00:32 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:b5ae])
        by smtp.gmail.com with ESMTPSA id x2-20020aa79182000000b00505a61ec387sm3045162pfa.138.2022.04.22.10.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 10:00:31 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 22 Apr 2022 07:00:29 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 05/10] kernfs: Replace global kernfs_open_file_mutex
 with hashed mutexes.
Message-ID: <YmLfLX5Ce8+VF2G4@slm.duckdns.org>
References: <20220410023719.1752460-1-imran.f.khan@oracle.com>
 <20220410023719.1752460-6-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410023719.1752460-6-imran.f.khan@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 12:37:14PM +1000, Imran Khan wrote:
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index 214b48d59148..0946ab341ce4 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -19,18 +19,14 @@
>  #include "kernfs-internal.h"
>  
>  /*
> - * There's one kernfs_open_file for each open file and one kernfs_open_node
> - * for each kernfs_node with one or more open files.
> - *
> + * kernfs locks
> + */
> +extern struct kernfs_global_locks *kernfs_locks;

This should be in a header file, right?

> @@ -545,7 +543,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
>  	 * need rcu_read_lock to ensure its existence.
>  	 */
>  	on = rcu_dereference_protected(kn->attr.open,
> -				   lockdep_is_held(&kernfs_open_file_mutex));
> +				   lockdep_is_held(mutex));
>  	if (on) {
>  		list_add_tail(&of->list, &on->files);
>  		mutex_unlock(mutex);
> @@ -593,10 +591,10 @@ static void kernfs_put_open_node(struct kernfs_node *kn,
>  	mutex = kernfs_open_file_mutex_lock(kn);
>  
>  	on = rcu_dereference_protected(kn->attr.open,
> -				       lockdep_is_held(&kernfs_open_file_mutex));
> +				       lockdep_is_held(mutex));
>  
>  	if (!on) {
> -		mutex_unlock(&kernfs_open_file_mutex);
> +		mutex_unlock(mutex);
>  		return;
>  	}

Don't above chunks belong to the previous patch?

> @@ -769,6 +767,10 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
>  	struct mutex *mutex = NULL;
>  
>  	if (kn->flags & KERNFS_HAS_RELEASE) {
> +		/**
> +		 * Callers of kernfs_fop_release, don't need global
> +		 * exclusion so using hashed mutex here is safe.
> +		 */

I don't think we use /** for in-line comments. Just do balanced wings.

 /*
  * ....
  */

besides, I'm not sure the comment is helping that much. It'd be better to
have a comment describing the locking rules comprehensively around the lock
definition and/or helpers.

>  		mutex = kernfs_open_file_mutex_lock(kn);
>  		kernfs_release_file(kn, of);
>  		mutex_unlock(mutex);
> @@ -796,9 +798,9 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
>  
>  	mutex = kernfs_open_file_mutex_lock(kn);
>  	on = rcu_dereference_check(kn->attr.open,
> -				   lockdep_is_held(&kernfs_open_file_mutex));
> +				   lockdep_is_held(mutex));
>  	if (!on) {
> -		mutex_unlock(&kernfs_open_file_mutex);
> +		mutex_unlock(mutex);

Again, should be in the previous patch.

> +void __init kernfs_lock_init(void)
> +{
> +	int count;
> +
> +	kernfs_locks = kmalloc(sizeof(struct kernfs_global_locks), GFP_KERNEL);
> +	WARN_ON(!kernfs_locks);
> +
> +	for (count = 0; count < NR_KERNFS_LOCKS; count++)
> +		mutex_init(&kernfs_locks->open_file_mutex[count].lock);
> +}

Does this need to be a separate function?

>  void __init kernfs_init(void)
>  {
>  	kernfs_node_cache = kmem_cache_create("kernfs_node_cache",
> @@ -397,4 +409,6 @@ void __init kernfs_init(void)
>  	kernfs_iattrs_cache  = kmem_cache_create("kernfs_iattrs_cache",
>  					      sizeof(struct kernfs_iattrs),
>  					      0, SLAB_PANIC, NULL);
> +
> +	kernfs_lock_init();
>  }
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index 2dd9c8df0f4f..cc514bda0ae7 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
...
> + * filp->private_data points to seq_file whose ->private points to
> + * kernfs_open_file.
> + * kernfs_open_files are chained at kernfs_open_node->files, which is
> + * protected by kernfs_open_file_mutex.lock.

Can you either flow the sentences together or have a blank line inbetween if
they're supposed to be in separate paragraphs?

> + */
> +struct kernfs_open_file_mutex {
> +	struct mutex lock;
> +} ____cacheline_aligned_in_smp;

Is there a reason to define the outer struct?

> +/*
> + * To reduce possible contention in sysfs access, arising due to single
> + * locks, use an array of locks and use kernfs_node object address as
> + * hash keys to get the index of these locks.
> + */
> +struct kernfs_global_locks {
> +	struct kernfs_open_file_mutex open_file_mutex[NR_KERNFS_LOCKS];
> +};

Ditto, why not just define the array directly?

> +void kernfs_lock_init(void);

Does this function need to be exposed?

Thanks.

-- 
tejun
