Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3E54AE0BA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384922AbiBHS0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355630AbiBHS0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:26:43 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F82C061578
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:26:42 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c10so1472111pfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 10:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Oedbq8uCfgl/Lmier/kIS95BKeP6ZEkA8SDWcSTE1FI=;
        b=grDnjNcZkEEhpCEfjigfvL1FDIQrRjnM1TMnJGjPMzCpftYc4E1x+pbMOfDIhFJs0W
         bRclRAm+tx4bYGZx6b9T4LTCqadYtwRgzynyiIwx47ykyqynQiyCOuUp7Pd2+kq0C30O
         oaaGvabktvOgzD9Ab5uG+GoZURiTqdIesGgEbZ9XHjWvQPv+cUwEIauZB3M1FxQFovGB
         TpTjgwvdk1C5j2g6SjO+Pw5sEYdkaMYzyG8iGOncU870sQLfAVp78jezRhYl2bCkq4e6
         +OUgN4QSbHJwRNDcxDrA4HGYRjfUe8jUZ4J1WbfJdeyKs+03biUSPg5R9xTgY+WS6F9p
         Q3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Oedbq8uCfgl/Lmier/kIS95BKeP6ZEkA8SDWcSTE1FI=;
        b=wZsCSkZaF03x/2aKSUseqcUi9R1MKk0OvrYoazfLB0rPgAfIPVukTEYahPD/5kwp5z
         zZgMFmNmRJqJXbPcV6dtRJut6D06AHG8b4y+lQYRkpcCq14jMcPnPcvnr5Cn4G0HkT6M
         Jzor76Gk7Eq/DdsP5Pmb/1nl4hlP4MdwDBI5otkZl5i2Rma+Fs1fY8NwKC6wvIzIXdir
         u709EPqAxTHcOdEVCzU3WSjiTzV46EIZe79d9kvstb0Y0IukiGr9HAsl9dl0KGUyX1mL
         PGiEo1DQgllftUGB6Y8mKB0o1CFn6rUwdgjNkbHAUQK12OXMFZbJKzAocPd2y8LyFcsd
         0Rfw==
X-Gm-Message-State: AOAM532cH69wQ0LqnSN+8ubQX0Y/MZnsUPBaDPOUZkuLzzbauff95JrR
        Fp26jgLS/uVOc7hFvHKo34k=
X-Google-Smtp-Source: ABdhPJz/99dHFmQjV+UhB4YqEZrLsVL026VTFnva2vhgxqBuNMNkSw9NfCwXwO9g7mYvh3sdxXfswQ==
X-Received: by 2002:a63:690a:: with SMTP id e10mr4516261pgc.599.1644344802118;
        Tue, 08 Feb 2022 10:26:42 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id k14sm16950038pff.25.2022.02.08.10.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:26:41 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 8 Feb 2022 08:26:40 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] kernfs: Replace per-fs global rwsem with per-fs
 hashed rwsem.
Message-ID: <YgK14ElTBW1BOXxW@slm.duckdns.org>
References: <20220206010925.1033990-1-imran.f.khan@oracle.com>
 <20220206010925.1033990-3-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206010925.1033990-3-imran.f.khan@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Feb 06, 2022 at 12:09:25PM +1100, Imran Khan wrote:
> Having a single rwsem to synchronize all operations across a kernfs
> based file system (cgroup, sysfs etc.) does not scale well. Replace
> it with a hashed rwsem to reduce contention around single per-fs
> rwsem.
> Also introduce a perfs rwsem to protect per-fs list of kernfs_super_info.

Can you split the two conversions into separate patches? Also, I'm not sure
about the per-fs hashtable as before.

>  static bool kernfs_active(struct kernfs_node *kn)
>  {
> -	lockdep_assert_held(&kernfs_root(kn)->kernfs_rwsem);
> +	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
> +
> +	lockdep_assert_held(&kernfs_root(kn)->kernfs_rwsem[idx]);

Please encapsulate this into a function. If possible, it'd be ideal if the
conversion can be done in steps - e.g. first introduce lock encapsulation
interface while leaving locking itself alone and then switch the actual
locking.

> -static void kernfs_drain(struct kernfs_node *kn)
> -	__releases(&kernfs_root(kn)->kernfs_rwsem)
> -	__acquires(&kernfs_root(kn)->kernfs_rwsem)
> +static void kernfs_drain(struct kernfs_node *kn, struct kernfs_node *anc)
> +	__releases(&kernfs_root(anc)->kernfs_rwsem[a_idx])
> +	__acquires(&kernfs_root(anc)->kernfs_rwsem[a_idx])
>  {
>  	struct kernfs_root *root = kernfs_root(kn);
> +	int a_idx = hash_ptr(anc, NR_KERNFS_LOCK_BITS);
>  
> -	lockdep_assert_held_write(&root->kernfs_rwsem);
> -	WARN_ON_ONCE(kernfs_active(kn));
> +	lockdep_assert_held_write(&root->kernfs_rwsem[a_idx]);
> +	WARN_ON_ONCE(atomic_read(&kn->active) >= 0);

Ditto, I'd much prefer to see the lock lookup and accompanying operations to
be encapsulated somehow.

> @@ -1588,37 +1597,65 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
>  		     const char *new_name, const void *new_ns)
>  {
>  	struct kernfs_node *old_parent;
> -	struct kernfs_root *root;
>  	const char *old_name = NULL;
> -	int error;
> +	int error, idx, np_idx, p_idx;
>  
>  	/* can't move or rename root */
>  	if (!kn->parent)
>  		return -EINVAL;
>  
> -	root = kernfs_root(kn);
> -	down_write(&root->kernfs_rwsem);
> +	/*
> +	 * Take lock of node's old (current) parent.
> +	 * If new parent has a different lock, then take that
> +	 * lock as well.
> +	 */
> +	idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
> +	p_idx = hash_ptr(kn->parent, NR_KERNFS_LOCK_BITS);
> +	np_idx = hash_ptr(new_parent, NR_KERNFS_LOCK_BITS);
> +
> +	/*
> +	 * Take only kn's lock. The subsequent kernfs_put
> +	 * may free up old_parent so if old_parent has a
> +	 * different lock, we will explicitly release that.
> +	 */
> +	down_write_kernfs_rwsem(kn, LOCK_SELF, 0);
> +
> +	if (idx != np_idx) /* new parent hashes to different lock */
> +		down_write_kernfs_rwsem(new_parent, LOCK_SELF, 1);
> +
> +	/* old_parent hashes to a different lock */
> +	if (idx != p_idx && p_idx != np_idx)
> +		down_write_kernfs_rwsem(kn->parent, LOCK_SELF, 2);

Can't this lead to ABBA deadlock? When double locking, the locking order
should always be consistent. If we were doing per-kernfs_node lock, child ->
parent ordering works but we're hashing locks, so that doesn't work anymore
- one child-parent combo can lock A then B while the other child-parent
combo hash the other way around and lock B then A. The only order we can
define is in terms of the locks themselves - e.g. if the address (or index)
of lock A < lock B, then we lock A first whether that maps to the child or
parent.

Also, please encapsulate double locking in a set of functions. We really
don't wanna see all the details in the users.

> --- a/fs/kernfs/kernfs-internal.h
> +++ b/fs/kernfs/kernfs-internal.h
> @@ -19,6 +19,9 @@
>  #include <linux/kernfs.h>
>  #include <linux/fs_context.h>
>  
> +#define LOCK_SELF 0
> +#define LOCK_SELF_AND_PARENT 1

I get that this is private header but can you please add some identifying
prefix and make them enums? That makes it way easier for debuggers, bpf and
tracing.

> +/*
> + * If both node and it's parent need locking,
> + * lock child first so that kernfs_rename_ns
> + * does not change the parent, leaving us
> + * with old parent here.
> + */

Please reflow it close to 80 chars and ditto with above. We can't follow
child -> parent order with hashed locks.

Thanks.

-- 
tejun
