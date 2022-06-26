Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17DF55B0FE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 12:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbiFZKBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 06:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiFZKBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 06:01:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADB05EE0B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 03:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656237708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aGRXKmqSxDtj1hckKrQgcnRl/49ZwsnnCJ2CdZjop+w=;
        b=WfBTMpD76KdAe7wUjxQrW6SbMzXy+xNzhl1p8wWV/rD72fkp2ELejp/p40dM1Sj/GkHGrc
        VFCFERv3pRDRpYc4arvPsyfXSvvpVq8rByiqwICcURmFQu86Myuy+JOHGaAP9n0R8RTIsl
        1Feyfs+1bS1IFMtgGXg7F5KtQdiG0ZE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-JV4ZlUzzPjuVeRKghDU-cg-1; Sun, 26 Jun 2022 06:01:46 -0400
X-MC-Unique: JV4ZlUzzPjuVeRKghDU-cg-1
Received: by mail-ed1-f70.google.com with SMTP id r12-20020a05640251cc00b00435afb01d7fso5075479edd.18
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 03:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aGRXKmqSxDtj1hckKrQgcnRl/49ZwsnnCJ2CdZjop+w=;
        b=JAfQRQlJnCHdhmVVxbNzH1fkcN9mxEWn9h2ZznSdPrbwpQ8vYPB4lIm7Rvxh4iDbRK
         6tk5dCLXWv8Sven57ztzFav0g9DQwM9cISxQk+30CLlRBJJhF2KaOW8NXJjCQrq2vwAj
         rWxrnNp+J2Dsi3K8SSxNo7NlTB9uUb2LJA2sdwMjvcOso9WorAOtzB4exvWXBf73lvC4
         z06hU6GWz9+9rjEOEOrf/YI2Uk37EsDEwx1oKq8TmwhDMQhsWh0jG1I9bv0BOOBi9a0Y
         RSkXde6nZTtC5hHKPzksJ143e79NtfGqQoX7mCGy5+4oKcUblQM6P0x5TNKoFpOnjCxb
         5+eg==
X-Gm-Message-State: AJIora8M6JbB5tcH7rS76H819vE4Cckuou6xI/ixgelu8sPjq5E7m59r
        aCPLHa5dazKAuGL6JaB8hP5VIWRJpGI+ROHKIepJzrr9jtM9gDTc+BAYak9WFiTtiQBmEYFSCXM
        AV1cYIOK4LltgPBQHOA0AYaL+
X-Received: by 2002:a17:907:1c01:b0:6f4:2692:e23 with SMTP id nc1-20020a1709071c0100b006f426920e23mr7265535ejc.243.1656237705083;
        Sun, 26 Jun 2022 03:01:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vzneybgFRlHz5QAI5O/BC0DJ2foBJhXk1XUb/VF1+f0prhtW/kY8X0TARuHTVpptEZSfiY2g==
X-Received: by 2002:a17:907:1c01:b0:6f4:2692:e23 with SMTP id nc1-20020a1709071c0100b006f426920e23mr7265509ejc.243.1656237704807;
        Sun, 26 Jun 2022 03:01:44 -0700 (PDT)
Received: from redhat.com ([2.54.171.2])
        by smtp.gmail.com with ESMTPSA id f20-20020a17090660d400b00711edab7622sm3595385ejk.40.2022.06.26.03.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 03:01:44 -0700 (PDT)
Date:   Sun, 26 Jun 2022 06:01:39 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cindy Lu <lulu@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] vhost: Add rbtree vdpa_mem_tree to saved the
 counted mem
Message-ID: <20220626055420-mutt-send-email-mst@kernel.org>
References: <20220626090409.1011144-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626090409.1011144-1-lulu@redhat.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2022 at 05:04:08PM +0800, Cindy Lu wrote:
> We count pinned_vm as follow in vhost-vDPA
> 
> lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
>          ret = -ENOMEM;
>          goto unlock;
> }
> This means if we have two vDPA devices for the same VM the pages
> would be counted twice. So we add a tree to save the page that
> counted and we will not count it again.
> 
> Add vdpa_mem_tree to saved the mem that already counted.
> use a hlist to saved the root for vdpa_mem_tree.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c | 63 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/vhost/vhost.h |  1 +
>  2 files changed, 64 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 40097826cff0..4ca8b1ed944b 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -32,6 +32,8 @@
>  #include <linux/kcov.h>
>  
>  #include "vhost.h"
> +#include <linux/hashtable.h>
> +#include <linux/jhash.h>
>  
>  static ushort max_mem_regions = 64;
>  module_param(max_mem_regions, ushort, 0444);
> @@ -49,6 +51,14 @@ enum {
>  #define vhost_used_event(vq) ((__virtio16 __user *)&vq->avail->ring[vq->num])
>  #define vhost_avail_event(vq) ((__virtio16 __user *)&vq->used->ring[vq->num])
>  
> +struct vhost_vdpa_rbtree_node {
> +	struct hlist_node node;
> +	struct rb_root_cached vdpa_mem_tree;
> +	struct mm_struct *mm_using;
> +};
> +static DECLARE_HASHTABLE(vhost_vdpa_rbtree_hlist, 8);
> +int vhost_vdpa_rbtree_hlist_status;
> +
>  #ifdef CONFIG_VHOST_CROSS_ENDIAN_LEGACY
>  static void vhost_disable_cross_endian(struct vhost_virtqueue *vq)
>  {

Are you trying to save some per-mm information here?
Can't we just add it to mm_struct?



> @@ -571,6 +581,51 @@ static void vhost_detach_mm(struct vhost_dev *dev)
>  	dev->mm = NULL;
>  }
>  
> +struct rb_root_cached *vhost_vdpa_get_mem_tree(struct mm_struct *mm)
> +{
> +	struct vhost_vdpa_rbtree_node *rbtree_root = NULL;
> +	struct rb_root_cached *vdpa_tree;
> +	u32 key;
> +
> +	/* No hased table, init one */
> +	if (vhost_vdpa_rbtree_hlist_status == 0) {
> +		hash_init(vhost_vdpa_rbtree_hlist);
> +		vhost_vdpa_rbtree_hlist_status = 1;
> +	}
> +
> +	key = jhash_1word((u64)mm, JHASH_INITVAL);
> +	hash_for_each_possible(vhost_vdpa_rbtree_hlist, rbtree_root, node,
> +			       key) {
> +		if (rbtree_root->mm_using == mm)
> +			return &(rbtree_root->vdpa_mem_tree);
> +	}
> +	rbtree_root = kmalloc(sizeof(*rbtree_root), GFP_KERNEL);
> +	if (!rbtree_root)
> +		return NULL;
> +	rbtree_root->mm_using = mm;
> +	rbtree_root->vdpa_mem_tree = RB_ROOT_CACHED;
> +	hash_add(vhost_vdpa_rbtree_hlist, &rbtree_root->node, key);
> +	vdpa_tree = &(rbtree_root->vdpa_mem_tree);
> +	return vdpa_tree;
> +}
> +
> +void vhost_vdpa_relase_mem_tree(struct mm_struct *mm)
> +{
> +	struct vhost_vdpa_rbtree_node *rbtree_root = NULL;
> +	u32 key;
> +
> +	key = jhash_1word((u64)mm, JHASH_INITVAL);
> +
> +	/* No hased table, init one */
> +	hash_for_each_possible(vhost_vdpa_rbtree_hlist, rbtree_root, node,
> +			       key) {
> +		if (rbtree_root->mm_using == mm) {
> +			hash_del(&rbtree_root->node);
> +			kfree(rbtree_root);
> +		}
> +	}
> +}
> +
>  /* Caller should have device mutex */
>  long vhost_dev_set_owner(struct vhost_dev *dev)
>  {
> @@ -605,6 +660,11 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>  	err = vhost_dev_alloc_iovecs(dev);
>  	if (err)
>  		goto err_cgroup;
> +	dev->vdpa_mem_tree = vhost_vdpa_get_mem_tree(dev->mm);
> +	if (dev->vdpa_mem_tree == NULL) {
> +		err = -ENOMEM;
> +		goto err_cgroup;
> +	}
>  
>  	return 0;
>  err_cgroup:
> @@ -613,6 +673,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>  		dev->worker = NULL;
>  	}
>  err_worker:
> +	vhost_vdpa_relase_mem_tree(dev->mm);
>  	vhost_detach_mm(dev);
>  	dev->kcov_handle = 0;
>  err_mm:
> @@ -710,6 +771,8 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>  		dev->worker = NULL;
>  		dev->kcov_handle = 0;
>  	}
> +
> +	vhost_vdpa_relase_mem_tree(dev->mm);
>  	vhost_detach_mm(dev);
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index d9109107af08..84de33de3abf 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -160,6 +160,7 @@ struct vhost_dev {
>  	int byte_weight;
>  	u64 kcov_handle;
>  	bool use_worker;
> +	struct rb_root_cached *vdpa_mem_tree;
>  	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
>  			   struct vhost_iotlb_msg *msg);
>  };
> -- 
> 2.34.3

