Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83E655CBCF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243852AbiF1Dyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbiF1Dyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 692FC27B18
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656388482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X9iggUVanCJQJ6yYUNcs4dB4JWtXgkk9igeD1ILYlyU=;
        b=fEODyaM9ORPN7e/Sz1a44FNaUXYwsa6q0mkWqDh79kyZ1AG5RpvGxaOy2cJ/ssQmyPviSz
        W4en8xLmH+lyt54j4lTV2iVrk4HBQUfY4xNsHdSnQl8kxpA9g8kI//RcshgD50BrfKL74s
        L7liMM6Y9p1IXd/OMzDXRXyUY3GQyic=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-MkOxd_ctN-OjPEegYNKYBg-1; Mon, 27 Jun 2022 23:54:40 -0400
X-MC-Unique: MkOxd_ctN-OjPEegYNKYBg-1
Received: by mail-lf1-f70.google.com with SMTP id j7-20020a056512398700b004811ba582d2so2028422lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X9iggUVanCJQJ6yYUNcs4dB4JWtXgkk9igeD1ILYlyU=;
        b=xNMhar37PO6nphbs7lyHCqX7XOUE1uc9r9CB9iotT9HnLIurPq9oDaEJ8qDOfEGGnq
         x/8VOZnZk+dwk+Omv5KEQdBMXX9+/r3RyP3Xf2mzVrLaODpvZiO+d7ZeWqrdOan04eeO
         LeBHpJ6/qpR9vgRLVLvwvkkSvwR2xpWo0fXoByHIeNkmDEUY+HhnCl6N9Gsx5Ii6Bx74
         49l81dsQZGBRD8rulWTBiMrxb9NOKx+pcT4KHavJnJDbxvIbsgZsH15RZYH+6E8UNROa
         UzyiYxJ2m+GFrKUmn3C9pngSnnf6IY1HQc92WEXMXo98TIBWAvTqILelNxAJ3ZGGYYVv
         xw6w==
X-Gm-Message-State: AJIora89KIdr33Z8AHPfyFnw6DmJ/a0OOUpPsvnpbwsEJhkP/YOsOaTg
        iwGsI78oS4bpwDl4JlY6ysIGgpGh6an+y2F5kxK3YBwGcXvL+aafmS9gIhiC7enCweKDdoxswCI
        P7OiuIckXY9iQ+QRWqq+1E9+feSay8sySVggLXKGX
X-Received: by 2002:a05:6512:ba1:b0:47f:c0bd:7105 with SMTP id b33-20020a0565120ba100b0047fc0bd7105mr10782518lfv.641.1656388479288;
        Mon, 27 Jun 2022 20:54:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1su2oGnL3s/JHts5q15dCkUUdGCBYUTiQ3t4omsn9Xy5tzNWEJ/ZMtN4q5rqnJ98ddhKPFce9uHkVjkoblj5XI=
X-Received: by 2002:a05:6512:ba1:b0:47f:c0bd:7105 with SMTP id
 b33-20020a0565120ba100b0047fc0bd7105mr10782503lfv.641.1656388479048; Mon, 27
 Jun 2022 20:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220626090409.1011144-1-lulu@redhat.com> <20220626055420-mutt-send-email-mst@kernel.org>
 <CACLfguVMfqAiCVoNVr7J8ooQa35tNJOSK-XHqsdE3hdXsfOZ+A@mail.gmail.com> <20220627055826-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220627055826-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 28 Jun 2022 11:54:27 +0800
Message-ID: <CACGkMEugJQY-QsnekKHWSdaG0H03qFxdmu+O1tQKMge65bFmHw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] vhost: Add rbtree vdpa_mem_tree to saved the
 counted mem
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Cindy Lu <lulu@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 6:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jun 27, 2022 at 04:12:57PM +0800, Cindy Lu wrote:
> > On Sun, Jun 26, 2022 at 6:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Sun, Jun 26, 2022 at 05:04:08PM +0800, Cindy Lu wrote:
> > > > We count pinned_vm as follow in vhost-vDPA
> > > >
> > > > lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > > > if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
> > > >          ret = -ENOMEM;
> > > >          goto unlock;
> > > > }
> > > > This means if we have two vDPA devices for the same VM the pages
> > > > would be counted twice. So we add a tree to save the page that
> > > > counted and we will not count it again.
> > > >
> > > > Add vdpa_mem_tree to saved the mem that already counted.
> > > > use a hlist to saved the root for vdpa_mem_tree.
> > > >
> > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > ---
> > > >  drivers/vhost/vhost.c | 63 +++++++++++++++++++++++++++++++++++++++++++
> > > >  drivers/vhost/vhost.h |  1 +
> > > >  2 files changed, 64 insertions(+)
> > > >
> > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > index 40097826cff0..4ca8b1ed944b 100644
> > > > --- a/drivers/vhost/vhost.c
> > > > +++ b/drivers/vhost/vhost.c
> > > > @@ -32,6 +32,8 @@
> > > >  #include <linux/kcov.h>
> > > >
> > > >  #include "vhost.h"
> > > > +#include <linux/hashtable.h>
> > > > +#include <linux/jhash.h>
> > > >
> > > >  static ushort max_mem_regions = 64;
> > > >  module_param(max_mem_regions, ushort, 0444);
> > > > @@ -49,6 +51,14 @@ enum {
> > > >  #define vhost_used_event(vq) ((__virtio16 __user *)&vq->avail->ring[vq->num])
> > > >  #define vhost_avail_event(vq) ((__virtio16 __user *)&vq->used->ring[vq->num])
> > > >
> > > > +struct vhost_vdpa_rbtree_node {
> > > > +     struct hlist_node node;
> > > > +     struct rb_root_cached vdpa_mem_tree;
> > > > +     struct mm_struct *mm_using;
> > > > +};
> > > > +static DECLARE_HASHTABLE(vhost_vdpa_rbtree_hlist, 8);
> > > > +int vhost_vdpa_rbtree_hlist_status;
> > > > +
> > > >  #ifdef CONFIG_VHOST_CROSS_ENDIAN_LEGACY
> > > >  static void vhost_disable_cross_endian(struct vhost_virtqueue *vq)
> > > >  {
> > >
> > > Are you trying to save some per-mm information here?
> > > Can't we just add it to mm_struct?
> > >
> > yes, this is a per-mm information, but I have checked with jason before,
> > seems it maybe difficult to change the mm_struct in upstream
> > so I add an to add a hlist  instead
> > Thanks
> > Cindy
>
> Difficult how?

It is only useful for vDPA probably. Though it could be used by VFIO
as well, VFIO does pinning/accounting at the container level and it
has been there for years. vDPA have an implicit "container" the
mm_struct, but the accounting is done per device right now.

In the future, when vDPA switches to iommufd, it can be then solved at
iommufd level.

And if we do this in mm, it will bring extra overheads.

Thanks

> You get more scrutiny if you try, for sure,
> and you need to need to generalize it enough that it looks
> useful outside the driver. But I guess that's good?
>
> > >
> > >
> > > > @@ -571,6 +581,51 @@ static void vhost_detach_mm(struct vhost_dev *dev)
> > > >       dev->mm = NULL;
> > > >  }
> > > >
> > > > +struct rb_root_cached *vhost_vdpa_get_mem_tree(struct mm_struct *mm)
> > > > +{
> > > > +     struct vhost_vdpa_rbtree_node *rbtree_root = NULL;
> > > > +     struct rb_root_cached *vdpa_tree;
> > > > +     u32 key;
> > > > +
> > > > +     /* No hased table, init one */
> > > > +     if (vhost_vdpa_rbtree_hlist_status == 0) {
> > > > +             hash_init(vhost_vdpa_rbtree_hlist);
> > > > +             vhost_vdpa_rbtree_hlist_status = 1;
> > > > +     }
> > > > +
> > > > +     key = jhash_1word((u64)mm, JHASH_INITVAL);
> > > > +     hash_for_each_possible(vhost_vdpa_rbtree_hlist, rbtree_root, node,
> > > > +                            key) {
> > > > +             if (rbtree_root->mm_using == mm)
> > > > +                     return &(rbtree_root->vdpa_mem_tree);
> > > > +     }
> > > > +     rbtree_root = kmalloc(sizeof(*rbtree_root), GFP_KERNEL);
> > > > +     if (!rbtree_root)
> > > > +             return NULL;
> > > > +     rbtree_root->mm_using = mm;
> > > > +     rbtree_root->vdpa_mem_tree = RB_ROOT_CACHED;
> > > > +     hash_add(vhost_vdpa_rbtree_hlist, &rbtree_root->node, key);
> > > > +     vdpa_tree = &(rbtree_root->vdpa_mem_tree);
> > > > +     return vdpa_tree;
> > > > +}
> > > > +
> > > > +void vhost_vdpa_relase_mem_tree(struct mm_struct *mm)
> > > > +{
> > > > +     struct vhost_vdpa_rbtree_node *rbtree_root = NULL;
> > > > +     u32 key;
> > > > +
> > > > +     key = jhash_1word((u64)mm, JHASH_INITVAL);
> > > > +
> > > > +     /* No hased table, init one */
> > > > +     hash_for_each_possible(vhost_vdpa_rbtree_hlist, rbtree_root, node,
> > > > +                            key) {
> > > > +             if (rbtree_root->mm_using == mm) {
> > > > +                     hash_del(&rbtree_root->node);
> > > > +                     kfree(rbtree_root);
> > > > +             }
> > > > +     }
> > > > +}
> > > > +
> > > >  /* Caller should have device mutex */
> > > >  long vhost_dev_set_owner(struct vhost_dev *dev)
> > > >  {
> > > > @@ -605,6 +660,11 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
> > > >       err = vhost_dev_alloc_iovecs(dev);
> > > >       if (err)
> > > >               goto err_cgroup;
> > > > +     dev->vdpa_mem_tree = vhost_vdpa_get_mem_tree(dev->mm);
> > > > +     if (dev->vdpa_mem_tree == NULL) {
> > > > +             err = -ENOMEM;
> > > > +             goto err_cgroup;
> > > > +     }
> > > >
> > > >       return 0;
> > > >  err_cgroup:
> > > > @@ -613,6 +673,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
> > > >               dev->worker = NULL;
> > > >       }
> > > >  err_worker:
> > > > +     vhost_vdpa_relase_mem_tree(dev->mm);
> > > >       vhost_detach_mm(dev);
> > > >       dev->kcov_handle = 0;
> > > >  err_mm:
> > > > @@ -710,6 +771,8 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> > > >               dev->worker = NULL;
> > > >               dev->kcov_handle = 0;
> > > >       }
> > > > +
> > > > +     vhost_vdpa_relase_mem_tree(dev->mm);
> > > >       vhost_detach_mm(dev);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
> > > > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > > > index d9109107af08..84de33de3abf 100644
> > > > --- a/drivers/vhost/vhost.h
> > > > +++ b/drivers/vhost/vhost.h
> > > > @@ -160,6 +160,7 @@ struct vhost_dev {
> > > >       int byte_weight;
> > > >       u64 kcov_handle;
> > > >       bool use_worker;
> > > > +     struct rb_root_cached *vdpa_mem_tree;
> > > >       int (*msg_handler)(struct vhost_dev *dev, u32 asid,
> > > >                          struct vhost_iotlb_msg *msg);
> > > >  };
> > > > --
> > > > 2.34.3
> > >
>

