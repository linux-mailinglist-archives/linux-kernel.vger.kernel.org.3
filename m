Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9474B5968
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 19:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357356AbiBNSK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:10:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiBNSK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:10:56 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495196541B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:10:48 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so19665046pjl.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fsT7lSAVYkp9weLcsjjFUcpaz6KeRlFgjOc+jPp5SLw=;
        b=SSDPNr8/MHlLHsdeCjQIWLjj54yWgtlyyGDG3JWsl3RrdXDL9ccmj3ra0peSk8liJX
         OI9gCUedBiCr9nDwvTpN1Nd+uLVhOCNh4EvC68Wixq0o02daALU3MRYM+YOxQYD27rit
         Im01CHx4qHtVcw2Tl43YIhFxJDvPmMNdB1iyBRjoY9zQEL37vE8fUQ9z1mavkAnOuVcq
         R+wReTg5aubxbsrgzJcnRJgxf/9dSWNfwMgF0h5rUakd0uuCWe7nMwUpaCBJDzBXW7RX
         cvODpFc7YBc0+IqdViTfNgPiGVthko6mHd3EnYyFKsZFP2Jp/y7zB9ngc7BMdG8RgFiV
         pnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fsT7lSAVYkp9weLcsjjFUcpaz6KeRlFgjOc+jPp5SLw=;
        b=KK6fcCg+Bfu66r30PQXnQBhTCgB8HT1uwHWgQ2IpIuY7vLl5XkXA9YiJWCf6Xo6U/O
         uIyXsmei3KCst0RVUo818bX6IWK0FiZlBjkMA+ccKVFWPLYSpsbAIGYYxYXJVXJxU+Fm
         VAXo6H2iCPOUYJ4M5E6iYNkv2WNI/oq4QIhMk6aRWC/1oMJieBgcvaHmc2I+vjm9bGZU
         vqwm5f+9HM8+kHIEkwtlF5ME7+D8gw7u2H//9GVLvd7BQMyA70RCtf3kJh2+7+Ouv73n
         VXtf04o5GWs7KUPb57Zyg61WeOYU2nYyPHdfHHhM0nYJHN0cnVxd3R9EzGpUqjMJBM5r
         fh+g==
X-Gm-Message-State: AOAM532jr8mIC6PxCIqEjEWwvxXBI7OaMajqaskWgUVbzIQYafeHwcPr
        uPMO7e5aFPYy6jT6vlSie/o=
X-Google-Smtp-Source: ABdhPJyRevZISbVVEODjyftiRPR9ISk40D+7cKnW09JRPf63npZqU5VSfgstAIffRDeyxL/fbBLwvQ==
X-Received: by 2002:a17:90a:5210:: with SMTP id v16mr16337719pjh.107.1644862247647;
        Mon, 14 Feb 2022 10:10:47 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id t200sm3533608pfc.35.2022.02.14.10.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 10:10:46 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Feb 2022 08:10:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/7] kernfs: Introduce hashed rw-sem to replace per-fs
 kernfs_rwsem.
Message-ID: <YgqbJS64XpsnOeHH@slm.duckdns.org>
References: <20220214120322.2402628-1-imran.f.khan@oracle.com>
 <20220214120322.2402628-7-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214120322.2402628-7-imran.f.khan@oracle.com>
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

On Mon, Feb 14, 2022 at 11:03:21PM +1100, Imran Khan wrote:
> +/**
> + * up_write_kernfs_rwsem_for_two_nodes() - Release hashed rwsem for 2 nodes
> + *
> + * @kn1: kernfs_node for which hashed rwsem needs to be released
> + * @kn2: kernfs_node for which hashed rwsem needs to be released
> + *
> + * In case of nested locking, rwsem with higher address is released first.
> + */
> +static inline void up_write_kernfs_rwsem_for_two_nodes(struct kernfs_node *kn1,
> +						       struct kernfs_node *kn2)
> +{
> +	struct rw_semaphore *rwsem1 = kernfs_rwsem_ptr(kn1);
> +	struct rw_semaphore *rwsem2 = kernfs_rwsem_ptr(kn2);
> +
> +	if (rwsem1 == rwsem2)
> +		up_write(rwsem1);
> +	else {
> +		if (rwsem1 > rwsem2) {
> +			up_write(rwsem1);
> +			up_write(rwsem2);
> +		} else {
> +			up_write(rwsem2);
> +			up_write(rwsem1);
> +		}
> +	}
> +
> +	kernfs_put(kn1);
> +	kernfs_put(kn2);
> +}

You don't need to order unlocks.

> +/**
> + * down_read_kernfs_rwsem_for_two_nodes() - Acquire hashed rwsem for 2 nodes
> + *
> + * @kn1: kernfs_node for which hashed rwsem needs to be taken
> + * @kn2: kernfs_node for which hashed rwsem needs to be taken
> + *
> + * In certain cases we need to acquire hashed rwsem for 2 nodes that don't have a
> + * parent child relationship. This is one of the cases of nested locking involving
> + * hashed rwsem and rwsem with lower address is acquired first.
> + */
> +static inline void down_read_kernfs_rwsem_for_two_nodes(struct kernfs_node *kn1,
> +							struct kernfs_node *kn2)

Maybe something like kernfs_down_read_double_nodes() is enough as the name?
up/down already imply rwsem.

> +static inline void down_read_kernfs_rwsem(struct kernfs_node *kn,
> +				      enum kernfs_rwsem_lock_pattern ptrn)
> +{
> +	struct rw_semaphore *p_rwsem = NULL;
> +	struct rw_semaphore *rwsem = kernfs_rwsem_ptr(kn);
> +	int lock_parent = 0;

bool?

> +
> +	if (ptrn == KERNFS_RWSEM_LOCK_SELF_AND_PARENT && kn->parent)

I wonder whether it'd be clearer to separate the double lock case into its
own function. The backend implementation being shared is fine but if we had
e.g. kernfs_down_read() and kernfs_down_read_double(), wouldn't that be
simpler?

> +		lock_parent = 1;
> +
> +	if (lock_parent)
> +		p_rwsem = kernfs_rwsem_ptr(kn->parent);
> +
> +	if (!lock_parent || rwsem == p_rwsem) {
> +		down_read_nested(rwsem, 0);
> +		kernfs_get(kn);
> +		kn->unlock_parent = 0;
> +	} else {
> +		/**
> +		 * In case of nested locking, locks are taken in order of their
> +		 * addresses. lock with lower address is taken first, followed
> +		 * by lock with higher address.
> +		 */
> +		if (rwsem < p_rwsem) {
> +			down_read_nested(rwsem, 0);
> +			down_read_nested(p_rwsem, 1);
> +		} else {
> +			down_read_nested(p_rwsem, 0);
> +			down_read_nested(rwsem, 1);
> +		}
> +		kernfs_get(kn);
> +		kernfs_get(kn->parent);
> +		kn->unlock_parent = 1;

I wouldn't put this inside kernfs_node. Either make the same decision
(whether it has a parent) in up() or return something which can be passed to
up() by the caller.

> +/**
> + * down_write_kernfs_rwsem_rename_ns() - take hashed rwsem during

kernfs_down_write_triple()?

> +static inline void up_write_kernfs_rwsem_rename_ns(struct kernfs_node *kn,
> +					struct kernfs_node *current_parent,
> +					struct kernfs_node *old_parent)
> +{
> +	struct rw_semaphore *array[3];
> +
> +	array[0] = kernfs_rwsem_ptr(kn);
> +	array[1] = kernfs_rwsem_ptr(current_parent);
> +	array[2] = kernfs_rwsem_ptr(old_parent);

So, we had sth like the following:

struct kernfs_rwsem_token {
       struct kernfs_node held[3];
};

which the down functions return (probably as out argument), wouldn't we be
able to share up() for all variants and make the code simpler?

> +static inline void down_read_kernfs_rwsem_rename_ns(struct kernfs_node *kn,
> +					struct kernfs_node *current_parent,
> +					struct kernfs_node *new_parent)
> +{
> +	struct rw_semaphore *array[3];
> +
> +	array[0] = kernfs_rwsem_ptr(kn);
> +	array[1] = kernfs_rwsem_ptr(current_parent);
> +	array[2] = kernfs_rwsem_ptr(new_parent);
> +
> +	if (array[0] == array[1] && array[0] == array[2]) {
> +		/* All 3 nodes hash to same rwsem */
> +		down_read_nested(array[0], 0);
> +	} else {
> +		/**
> +		 * All 3 nodes are not hashing to the same rwsem, so sort the
> +		 * array.
> +		 */
> +		kernfs_sort_rwsems(array);
> +
> +		if (array[0] == array[1] || array[1] == array[2]) {
> +			/**
> +			 * Two nodes hash to same rwsem, and these
> +			 * will occupy consecutive places in array after
> +			 * sorting.
> +			 */
> +			down_read_nested(array[0], 0);
> +			down_read_nested(array[2], 1);
> +		} else {
> +			/* All 3 nodes hashe to different rwsems */
> +			down_read_nested(array[0], 0);
> +			down_read_nested(array[1], 1);
> +			down_read_nested(array[2], 2);
> +		}
> +	}

How about factoring out "am I locking one, two or three?" into a function -
e.g. the sort function takes the array, sort & uniq's them into locking
token so that the down functions (for both double and triple) just do what's
the token says.

Thanks.

-- 
tejun
