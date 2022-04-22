Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A8F50BCC7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381145AbiDVQXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381140AbiDVQWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:22:54 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D1C38B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:20:00 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id q1so10711697plx.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rjjW4zQB7vN5AG68qTGDJtZghbNfzvjCEtyfJgY2xk0=;
        b=prpGUJEyn8mdgtycpc0mzQF2T1UMGTvU6Ec6MORRJLGzNO3OgXp+DFVo0JWivKmczK
         kuDVBFLNcZJGP0gUS5qLpbIgmK/SsKMWTVXrbGVWx68wSGny9Ec22z9V2sesXchEE76f
         ylWHJTfjV8XqaLst8Ps3Y6++CxLUEjHYEiZMj40KZY37s2Ve9+bBlpJOeQcLahPImh1G
         HGB4E0xsg8n3DlZXSZllMnHPrMe1tgFiY5YAco5ijSIR1j6XSfAlj42S+KQ1biCjBc5e
         Lxjjpnc4L9Do1ZGd6AggxESmxuRv/Eq2+krTgi8emqgqJ7VDvNeGnye1tCWjiWD30t54
         UIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rjjW4zQB7vN5AG68qTGDJtZghbNfzvjCEtyfJgY2xk0=;
        b=J0GClb/zLHt22ff0eG2NQjx6CN6SP/zL+7oHsQbJZEWlEvxDDKsMnzjG2y2LK9XZn+
         15pig0ZDqiqxjAoVtg/z2twQfFrPiz+eO31HPcsBLbShOiyW0BUNiM3nX8nPngyA3jLg
         Ngb0N96lk/K9rMkVvnHBVkVO2TlPotH2PRXb8CtNcoWv5gsLi6IqvCjzDGyMos+tncdi
         XxKOAc9Zv/PNbpYzTMWPfCtjNBA89GO246jRtoosSLFgxbxOIDFMQMZdFxvunu9mBRIv
         GJM+UkECJJXt3+z5F21eEm1UEIVSt+p3wAPwLcc5AH4CsBFG1DfepvKOvlv1r2Lfw0UT
         q4nA==
X-Gm-Message-State: AOAM5336MIiwUXZZvLioZL65QCa/vSjStKAKwB7l1WklKkeIO3zdyAG6
        bgYa4A3OqtsQe6bl2f1Qmcg=
X-Google-Smtp-Source: ABdhPJydCtl/D5ID5Ixg+EuaOjMiK/UcmWJdz+W3/m6443mWuwdGxxCBYo5L6Y4XCKeTfRe3FDXZ5g==
X-Received: by 2002:a17:902:9a8c:b0:15a:a21:b52a with SMTP id w12-20020a1709029a8c00b0015a0a21b52amr5172529plp.86.1650644399987;
        Fri, 22 Apr 2022 09:19:59 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:b5ae])
        by smtp.gmail.com with ESMTPSA id l2-20020a637c42000000b003644cfa0dd1sm2509576pgn.79.2022.04.22.09.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:19:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 22 Apr 2022 06:19:57 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 02/10] kernfs: make ->attr.open RCU protected.
Message-ID: <YmLVrfI4UN8ajoUM@slm.duckdns.org>
References: <20220410023719.1752460-1-imran.f.khan@oracle.com>
 <20220410023719.1752460-3-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410023719.1752460-3-imran.f.khan@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 12:37:11PM +1000, Imran Khan wrote:
>  static int kernfs_seq_show(struct seq_file *sf, void *v)
>  {
>  	struct kernfs_open_file *of = sf->private;
> +	struct kernfs_open_node *on = rcu_dereference_raw(of->kn->attr.open);

I suppose raw deref is safe because @on can't go away while @of is alive,
right? If that's the case, please factor out of -> on dereferencing into a
helper and put a comment there explaining why the raw deref is safe.

...
> @@ -201,7 +203,8 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  		goto out_free;
>  	}
>  
> -	of->event = atomic_read(&of->kn->attr.open->event);
> +	on = rcu_dereference_raw(of->kn->attr.open);

cuz we don't wanna sprinkle raw derefs in multiple places without
explanation like this.

...
>  /**
> @@ -566,24 +567,30 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
>  static void kernfs_put_open_node(struct kernfs_node *kn,
>  				 struct kernfs_open_file *of)
>  {
> -	struct kernfs_open_node *on = kn->attr.open;
> -	unsigned long flags;
> +	struct kernfs_open_node *on;
> +
> +	/* ->attr.open NULL means there are no more open files */
> +	if (rcu_dereference_raw(kn->attr.open) == NULL)
> +		return;

For pointer value check, what you want is rcu_access_pointer(). That said,
tho, why is this being called if no one is linked on it? Before removing the
refcnt, that'd be the same as trying to put a 0 ref. How does that happen?
Also, can you please rename it to unlink or something of the sort? It's
confusing to call it put when there's no refcnt.

>  
>  	mutex_lock(&kernfs_open_file_mutex);
> -	spin_lock_irqsave(&kernfs_open_node_lock, flags);
> +
> +	on = rcu_dereference_protected(kn->attr.open,
> +				       lockdep_is_held(&kernfs_open_file_mutex));

Again, a better way to do it would be defining a kn -> on accessor which
encodes the safe way to deref and use it. The deref rule is tied to the
deref itself not the callsite.

> +
> +	if (!on) {
> +		mutex_unlock(&kernfs_open_file_mutex);
> +		return;
> +	}
>  
>  	if (of)
>  		list_del(&of->list);
>  
> -	if (list_empty(&on->files))
> -		kn->attr.open = NULL;
> -	else
> -		on = NULL;
> -
> -	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
> +	if (list_empty(&on->files)) {
> +		rcu_assign_pointer(kn->attr.open, NULL);
> +		kfree_rcu(on, rcu_head);
> +	}
>  	mutex_unlock(&kernfs_open_file_mutex);
> -
> -	kfree(on);
>  }
>  
>  static int kernfs_fop_open(struct inode *inode, struct file *file)
> @@ -765,12 +772,13 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
>  	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
>  		return;
>  
> -	on = kn->attr.open;
> -	if (!on)
> +	if (rcu_dereference_raw(kn->attr.open) == NULL)
>  		return;

rcu_access_pointer again and you gotta explain why the lockless check is
safe.

>  	mutex_lock(&kernfs_open_file_mutex);
> -	if (!kn->attr.open) {
> +	on = rcu_dereference_check(kn->attr.open,
> +				   lockdep_is_held(&kernfs_open_file_mutex));
> +	if (!on) {
>  		mutex_unlock(&kernfs_open_file_mutex);
>  		return;
>  	}
...
> @@ -912,14 +920,13 @@ void kernfs_notify(struct kernfs_node *kn)
>  		return;
>  
>  	/* kick poll immediately */
> -	spin_lock_irqsave(&kernfs_open_node_lock, flags);
> -	on = kn->attr.open;
> +	rcu_read_lock();
> +	on = rcu_dereference(kn->attr.open);
>  	if (on) {
>  		atomic_inc(&on->event);
>  		wake_up_interruptible(&on->poll);
>  	}
> -	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
> -
> +	rcu_read_unlock();

An explanation of why this is safe in terms of event ordering would be great
here.

Thanks.

-- 
tejun
