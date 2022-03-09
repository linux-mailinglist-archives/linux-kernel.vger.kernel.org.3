Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761634D3203
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbiCIPpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiCIPp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:45:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 399BE7CDC6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 07:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646840667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPv2czUPN4P3J0p1kuWcwN5wFtTDrdP4nhrIIWXDX5M=;
        b=Hpu9PwjTqMsTTmSCUwXbwTMJ4N8tQnHtakP06hkNwLmBfyln43dlqp0qQOIPPh8OtYxhAq
        Mh4Tz5uCHTxFazV+25+B2wro6zXe0T4Zb0ihjdVWp9Z8bpqYeP19ZJghtdUPn5MdFfflxR
        +nI99401b9Gu9VEKWMDwV08tDWE+yCE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-reYmD6LzNXiXKyOnHE8sKg-1; Wed, 09 Mar 2022 10:44:24 -0500
X-MC-Unique: reYmD6LzNXiXKyOnHE8sKg-1
Received: by mail-qv1-f69.google.com with SMTP id l4-20020a0cc204000000b00435ac16d67cso2394464qvh.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 07:44:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=EPv2czUPN4P3J0p1kuWcwN5wFtTDrdP4nhrIIWXDX5M=;
        b=6/GwnhOXiEkgdv33+oTxR9iHjJ4ecOo6UOnBnxpd3dmRNEddB+dMzn2I2U6Rgh8Swu
         d8b1gpb4+4py/wPiVyvwashXD7J7zj1Itd0YSTfSEcQYNOMoY9SoMTwcoHqiRUXSOrsk
         dqxxuuGZZvBwB4QcYnrVwYWwwUJeko5wJcenT90UqD0pc3IRjKHOubT/iOdcWNLNPq+n
         PrlqpVNstIIsZlqtJDxpsqoupocxCONRQ8Jsy+n8Yer4ql9Yer0Cnf6UwgrgAc+5TUqI
         dPEc9AAZgUKYM1WrG51t7WFgv+TaXe5TM0dzpNyIjB51vqNIMYeBJaRjaBZ4D8Yd7vM1
         2e3w==
X-Gm-Message-State: AOAM530m/8gXtNiNkkNcHxMWtB8j/Zrp40qHuqjeiYVO43s2Zg6fXX/B
        quLOl8KDLObHXgvnldxHhnBJ6b7fKWgCRbISrQC3xxWL3hyfWDcH/WpBvsvugQCuv/ktX89WNQk
        1xps2FeiiB+khlkUNfbpFhR+E
X-Received: by 2002:a05:622a:14c:b0:2e1:a5c5:87ac with SMTP id v12-20020a05622a014c00b002e1a5c587acmr247669qtw.246.1646840663738;
        Wed, 09 Mar 2022 07:44:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJNGuKSaMEHnpv0VBhlvfbOKgbucbJF29mIvY1nAjWMtgIj8s5DzxuGSPOhnzq5jp8Pwx3Hg==
X-Received: by 2002:a05:622a:14c:b0:2e1:a5c5:87ac with SMTP id v12-20020a05622a014c00b002e1a5c587acmr247647qtw.246.1646840663386;
        Wed, 09 Mar 2022 07:44:23 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id m6-20020ae9e006000000b0067d3e75e2a6sm549575qkk.19.2022.03.09.07.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 07:44:23 -0800 (PST)
Message-ID: <b28618df1b6c31f42b75c8f759011444018bbece.camel@redhat.com>
Subject: Re: [PATCH v2 05/19] netfs: Split netfs_io_* object handling out
From:   Jeff Layton <jlayton@redhat.com>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 09 Mar 2022 10:44:22 -0500
In-Reply-To: <164678197044.1200972.11511937252083343775.stgit@warthog.procyon.org.uk>
References: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
         <164678197044.1200972.11511937252083343775.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-03-08 at 23:26 +0000, David Howells wrote:
> Split netfs_io_* object handling out into a file that's going to contain
> object allocation, get and put routines.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-cachefs@redhat.com
> 
> Link: https://lore.kernel.org/r/164622995118.3564931.6089530629052064470.stgit@warthog.procyon.org.uk/ # v1
> ---
> 
>  fs/netfs/Makefile      |    6 ++
>  fs/netfs/internal.h    |   18 +++++++
>  fs/netfs/objects.c     |  123 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/netfs/read_helper.c |  118 ----------------------------------------------
>  4 files changed, 147 insertions(+), 118 deletions(-)
>  create mode 100644 fs/netfs/objects.c
> 
> diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
> index c15bfc966d96..939fd00a1fc9 100644
> --- a/fs/netfs/Makefile
> +++ b/fs/netfs/Makefile
> @@ -1,5 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -netfs-y := read_helper.o stats.o
> +netfs-y := \
> +	objects.o \
> +	read_helper.o
> +
> +netfs-$(CONFIG_NETFS_STATS) += stats.o
>  
>  obj-$(CONFIG_NETFS_SUPPORT) := netfs.o
> diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
> index b7f2c4459f33..cf7a3ddb16a4 100644
> --- a/fs/netfs/internal.h
> +++ b/fs/netfs/internal.h
> @@ -5,17 +5,35 @@
>   * Written by David Howells (dhowells@redhat.com)
>   */
>  
> +#include <linux/netfs.h>
> +#include <trace/events/netfs.h>
> +
>  #ifdef pr_fmt
>  #undef pr_fmt
>  #endif
>  
>  #define pr_fmt(fmt) "netfs: " fmt
>  
> +/*
> + * objects.c
> + */
> +struct netfs_io_request *netfs_alloc_request(const struct netfs_request_ops *ops,
> +					     void *netfs_priv,
> +					     struct file *file);
> +void netfs_get_request(struct netfs_io_request *rreq);
> +void netfs_clear_subrequests(struct netfs_io_request *rreq, bool was_async);
> +void netfs_put_request(struct netfs_io_request *rreq, bool was_async);
> +struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq);
> +void netfs_put_subrequest(struct netfs_io_subrequest *subreq, bool was_async);
> +void netfs_get_subrequest(struct netfs_io_subrequest *subreq);
> +
>  /*
>   * read_helper.c
>   */
>  extern unsigned int netfs_debug;
>  
> +void netfs_rreq_work(struct work_struct *work);
> +
>  /*
>   * stats.c
>   */
> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> new file mode 100644
> index 000000000000..f7383c28dc6e
> --- /dev/null
> +++ b/fs/netfs/objects.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Object lifetime handling and tracing.
> + *
> + * Copyright (C) 2022 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#include <linux/slab.h>
> +#include "internal.h"
> +
> +/*
> + * Allocate an I/O request and initialise it.
> + */
> +struct netfs_io_request *netfs_alloc_request(
> +	const struct netfs_request_ops *ops, void *netfs_priv,
> +	struct file *file)
> +{
> +	static atomic_t debug_ids;
> +	struct netfs_io_request *rreq;
> +
> +	rreq = kzalloc(sizeof(struct netfs_io_request), GFP_KERNEL);
> +	if (rreq) {
> +		rreq->netfs_ops	= ops;
> +		rreq->netfs_priv = netfs_priv;
> +		rreq->inode	= file_inode(file);
> +		rreq->i_size	= i_size_read(rreq->inode);
> +		rreq->debug_id	= atomic_inc_return(&debug_ids);
> +		INIT_LIST_HEAD(&rreq->subrequests);
> +		INIT_WORK(&rreq->work, netfs_rreq_work);
> +		refcount_set(&rreq->usage, 1);
> +		__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
> +		if (ops->init_request)
> +			ops->init_request(rreq, file);
> +		netfs_stat(&netfs_n_rh_rreq);
> +	}
> +
> +	return rreq;
> +}
> +
> +void netfs_get_request(struct netfs_io_request *rreq)
> +{
> +	refcount_inc(&rreq->usage);
> +}
> +
> +void netfs_clear_subrequests(struct netfs_io_request *rreq, bool was_async)
> +{
> +	struct netfs_io_subrequest *subreq;
> +
> +	while (!list_empty(&rreq->subrequests)) {
> +		subreq = list_first_entry(&rreq->subrequests,
> +					  struct netfs_io_subrequest, rreq_link);
> +		list_del(&subreq->rreq_link);
> +		netfs_put_subrequest(subreq, was_async);
> +	}
> +}
> +
> +static void netfs_free_request(struct work_struct *work)
> +{
> +	struct netfs_io_request *rreq =
> +		container_of(work, struct netfs_io_request, work);
> +	netfs_clear_subrequests(rreq, false);
> +	if (rreq->netfs_priv)
> +		rreq->netfs_ops->cleanup(rreq->mapping, rreq->netfs_priv);
> +	trace_netfs_rreq(rreq, netfs_rreq_trace_free);
> +	if (rreq->cache_resources.ops)
> +		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
> +	kfree(rreq);
> +	netfs_stat_d(&netfs_n_rh_rreq);
> +}
> +
> +void netfs_put_request(struct netfs_io_request *rreq, bool was_async)
> +{
> +	if (refcount_dec_and_test(&rreq->usage)) {
> +		if (was_async) {
> +			rreq->work.func = netfs_free_request;
> +			if (!queue_work(system_unbound_wq, &rreq->work))
> +				BUG();
> +		} else {
> +			netfs_free_request(&rreq->work);
> +		}
> +	}
> +}
> +
> +/*
> + * Allocate and partially initialise an I/O request structure.
> + */
> +struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq)
> +{
> +	struct netfs_io_subrequest *subreq;
> +
> +	subreq = kzalloc(sizeof(struct netfs_io_subrequest), GFP_KERNEL);
> +	if (subreq) {
> +		INIT_LIST_HEAD(&subreq->rreq_link);
> +		refcount_set(&subreq->usage, 2);
> +		subreq->rreq = rreq;
> +		netfs_get_request(rreq);
> +		netfs_stat(&netfs_n_rh_sreq);
> +	}
> +
> +	return subreq;
> +}
> +
> +void netfs_get_subrequest(struct netfs_io_subrequest *subreq)
> +{
> +	refcount_inc(&subreq->usage);
> +}
> +
> +static void __netfs_put_subrequest(struct netfs_io_subrequest *subreq,
> +				   bool was_async)
> +{
> +	struct netfs_io_request *rreq = subreq->rreq;
> +
> +	trace_netfs_sreq(subreq, netfs_sreq_trace_free);
> +	kfree(subreq);
> +	netfs_stat_d(&netfs_n_rh_sreq);
> +	netfs_put_request(rreq, was_async);
> +}
> +
> +void netfs_put_subrequest(struct netfs_io_subrequest *subreq, bool was_async)
> +{
> +	if (refcount_dec_and_test(&subreq->usage))
> +		__netfs_put_subrequest(subreq, was_async);
> +}
> diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
> index 26d54055b17e..ef23ef9889d5 100644
> --- a/fs/netfs/read_helper.c
> +++ b/fs/netfs/read_helper.c
> @@ -27,122 +27,6 @@ unsigned netfs_debug;
>  module_param_named(debug, netfs_debug, uint, S_IWUSR | S_IRUGO);
>  MODULE_PARM_DESC(netfs_debug, "Netfs support debugging mask");
>  
> -static void netfs_rreq_work(struct work_struct *);
> -static void __netfs_put_subrequest(struct netfs_io_subrequest *, bool);
> -
> -static void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
> -				 bool was_async)
> -{
> -	if (refcount_dec_and_test(&subreq->usage))
> -		__netfs_put_subrequest(subreq, was_async);
> -}
> -
> -static struct netfs_io_request *netfs_alloc_request(
> -	const struct netfs_request_ops *ops, void *netfs_priv,
> -	struct file *file)
> -{
> -	static atomic_t debug_ids;
> -	struct netfs_io_request *rreq;
> -
> -	rreq = kzalloc(sizeof(struct netfs_io_request), GFP_KERNEL);
> -	if (rreq) {
> -		rreq->netfs_ops	= ops;
> -		rreq->netfs_priv = netfs_priv;
> -		rreq->inode	= file_inode(file);
> -		rreq->i_size	= i_size_read(rreq->inode);
> -		rreq->debug_id	= atomic_inc_return(&debug_ids);
> -		INIT_LIST_HEAD(&rreq->subrequests);
> -		INIT_WORK(&rreq->work, netfs_rreq_work);
> -		refcount_set(&rreq->usage, 1);
> -		__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
> -		if (ops->init_request)
> -			ops->init_request(rreq, file);
> -		netfs_stat(&netfs_n_rh_rreq);
> -	}
> -
> -	return rreq;
> -}
> -
> -static void netfs_get_request(struct netfs_io_request *rreq)
> -{
> -	refcount_inc(&rreq->usage);
> -}
> -
> -static void netfs_clear_subrequests(struct netfs_io_request *rreq, bool was_async)
> -{
> -	struct netfs_io_subrequest *subreq;
> -
> -	while (!list_empty(&rreq->subrequests)) {
> -		subreq = list_first_entry(&rreq->subrequests,
> -					  struct netfs_io_subrequest, rreq_link);
> -		list_del(&subreq->rreq_link);
> -		netfs_put_subrequest(subreq, was_async);
> -	}
> -}
> -
> -static void netfs_free_request(struct work_struct *work)
> -{
> -	struct netfs_io_request *rreq =
> -		container_of(work, struct netfs_io_request, work);
> -	netfs_clear_subrequests(rreq, false);
> -	if (rreq->netfs_priv)
> -		rreq->netfs_ops->cleanup(rreq->mapping, rreq->netfs_priv);
> -	trace_netfs_rreq(rreq, netfs_rreq_trace_free);
> -	if (rreq->cache_resources.ops)
> -		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
> -	kfree(rreq);
> -	netfs_stat_d(&netfs_n_rh_rreq);
> -}
> -
> -static void netfs_put_request(struct netfs_io_request *rreq, bool was_async)
> -{
> -	if (refcount_dec_and_test(&rreq->usage)) {
> -		if (was_async) {
> -			rreq->work.func = netfs_free_request;
> -			if (!queue_work(system_unbound_wq, &rreq->work))
> -				BUG();
> -		} else {
> -			netfs_free_request(&rreq->work);
> -		}
> -	}
> -}
> -
> -/*
> - * Allocate and partially initialise an I/O request structure.
> - */
> -static struct netfs_io_subrequest *netfs_alloc_subrequest(
> -	struct netfs_io_request *rreq)
> -{
> -	struct netfs_io_subrequest *subreq;
> -
> -	subreq = kzalloc(sizeof(struct netfs_io_subrequest), GFP_KERNEL);
> -	if (subreq) {
> -		INIT_LIST_HEAD(&subreq->rreq_link);
> -		refcount_set(&subreq->usage, 2);
> -		subreq->rreq = rreq;
> -		netfs_get_request(rreq);
> -		netfs_stat(&netfs_n_rh_sreq);
> -	}
> -
> -	return subreq;
> -}
> -
> -static void netfs_get_subrequest(struct netfs_io_subrequest *subreq)
> -{
> -	refcount_inc(&subreq->usage);
> -}
> -
> -static void __netfs_put_subrequest(struct netfs_io_subrequest *subreq,
> -				   bool was_async)
> -{
> -	struct netfs_io_request *rreq = subreq->rreq;
> -
> -	trace_netfs_sreq(subreq, netfs_sreq_trace_free);
> -	kfree(subreq);
> -	netfs_stat_d(&netfs_n_rh_sreq);
> -	netfs_put_request(rreq, was_async);
> -}
> -
>  /*
>   * Clear the unread part of an I/O request.
>   */
> @@ -558,7 +442,7 @@ static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
>  	netfs_rreq_completed(rreq, was_async);
>  }
>  
> -static void netfs_rreq_work(struct work_struct *work)
> +void netfs_rreq_work(struct work_struct *work)
>  {
>  	struct netfs_io_request *rreq =
>  		container_of(work, struct netfs_io_request, work);
> 
> 

Reviewed-by: Jeff Layton <jlayton@redhat.com>

