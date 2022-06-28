Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B6955D272
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245264AbiF1GZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244453AbiF1GZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:25:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2938E64
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656397551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E769zih15iNpjlIqzqJ/NlBaBfoFXP2GblGI/gWTxs8=;
        b=gz6PQIKgSRYxG74qTiMFJpdUy7lp+6YTETWBCNZMjAmtj0pvnSP3iepoMYtgKv/Q1GFkl+
        ZOsfbGLeJdlM73l4bZOmMdRwU+oaKgemMHBhYEisg3WbpGKLgqrDIP3LKIowZOqXqTfsoP
        nj6rvAJRgd3uBde7dGYl5BXrO5B4kUk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-xKYzKuLjMUuWk-8j_p1mbg-1; Tue, 28 Jun 2022 02:25:49 -0400
X-MC-Unique: xKYzKuLjMUuWk-8j_p1mbg-1
Received: by mail-wm1-f70.google.com with SMTP id n15-20020a05600c4f8f00b0039c3e76d646so6715339wmq.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E769zih15iNpjlIqzqJ/NlBaBfoFXP2GblGI/gWTxs8=;
        b=caAbQXX8IgAt6D7YacR+r/FPIeG5V3Qxy/WPQA5qyWOyDnxJqa2LADSI3wxMJfL6Qv
         v0HWI9BtvJ2VHM4UMzv0uL/Wiiif6co3LsvUycZvjvCBWbe84QK/FKWT1EWjSQdorKSZ
         WBR7BgcDz0RwdqY/+rGQzeNwYqYhyUBrJz69YzVPz3VkjPvoTv4xWqECVZuW92kboQDv
         WxqGs9JKKlQbzVHcWbcQMdX9kGCa6m+2m421pr8revbNJZYTJK0H+7o5Dh9zTkWF/0N8
         hxl8kvVVdEO5yfQC/uAYCSVkIjGjRNOm7r9EL8rhZ/R+hXG6fHf4cIeYtk+A9JKcMwNV
         OMYw==
X-Gm-Message-State: AJIora/fln3oYuEen4gv7h48JXxTtnbARcwyJgmSPA8YEN62gMRwPq1k
        E+0//E5MCVWjQfThSWu2/Tn257nfBnsZiKuDeTFdX1OhPg+wkGllvydkAgk8CO0OS03nIEmVow+
        QVeAt0D4Zh4rfkN/vdxvS1slS
X-Received: by 2002:a05:600c:4ed0:b0:3a0:5263:cf09 with SMTP id g16-20020a05600c4ed000b003a05263cf09mr2245602wmq.6.1656397548246;
        Mon, 27 Jun 2022 23:25:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vGsoqW/En9bc4KE5LLMov+hPWJrUIP8o60DeOHge0Q+bwgSSNoSmuQLfj+vaHdEy7NXeJl4A==
X-Received: by 2002:a05:600c:4ed0:b0:3a0:5263:cf09 with SMTP id g16-20020a05600c4ed000b003a05263cf09mr2245572wmq.6.1656397547971;
        Mon, 27 Jun 2022 23:25:47 -0700 (PDT)
Received: from redhat.com ([2.52.23.204])
        by smtp.gmail.com with ESMTPSA id ay4-20020a05600c1e0400b003a047dccfffsm8363278wmb.42.2022.06.27.23.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 23:25:47 -0700 (PDT)
Date:   Tue, 28 Jun 2022 02:25:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Cindy Lu <lulu@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] vhost: Add rbtree vdpa_mem_tree to saved the
 counted mem
Message-ID: <20220628022458-mutt-send-email-mst@kernel.org>
References: <20220626055420-mutt-send-email-mst@kernel.org>
 <CACLfguVMfqAiCVoNVr7J8ooQa35tNJOSK-XHqsdE3hdXsfOZ+A@mail.gmail.com>
 <20220627055826-mutt-send-email-mst@kernel.org>
 <CACGkMEugJQY-QsnekKHWSdaG0H03qFxdmu+O1tQKMge65bFmHw@mail.gmail.com>
 <20220628014642-mutt-send-email-mst@kernel.org>
 <CACGkMEvt9QVvZb+gEuynazGmEM-j22QdiEH_V-oWD1=NZQS+5g@mail.gmail.com>
 <20220628020622-mutt-send-email-mst@kernel.org>
 <CACGkMEvAnmaS11JYXwsMmk9GaE_Q+Egz9nzk3H-rZF+DCs8Mow@mail.gmail.com>
 <20220628021443-mutt-send-email-mst@kernel.org>
 <CACGkMEt6aH-Xfd7nHJ1217ybQaGEvAmYXH_qunybmqVUN2PdEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEt6aH-Xfd7nHJ1217ybQaGEvAmYXH_qunybmqVUN2PdEw@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 02:18:55PM +0800, Jason Wang wrote:
> On Tue, Jun 28, 2022 at 2:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jun 28, 2022 at 02:10:38PM +0800, Jason Wang wrote:
> > > On Tue, Jun 28, 2022 at 2:07 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Jun 28, 2022 at 02:03:38PM +0800, Jason Wang wrote:
> > > > > On Tue, Jun 28, 2022 at 1:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Jun 28, 2022 at 11:54:27AM +0800, Jason Wang wrote:
> > > > > > > On Mon, Jun 27, 2022 at 6:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Jun 27, 2022 at 04:12:57PM +0800, Cindy Lu wrote:
> > > > > > > > > On Sun, Jun 26, 2022 at 6:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Sun, Jun 26, 2022 at 05:04:08PM +0800, Cindy Lu wrote:
> > > > > > > > > > > We count pinned_vm as follow in vhost-vDPA
> > > > > > > > > > >
> > > > > > > > > > > lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > > > > > > > > > > if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
> > > > > > > > > > >          ret = -ENOMEM;
> > > > > > > > > > >          goto unlock;
> > > > > > > > > > > }
> > > > > > > > > > > This means if we have two vDPA devices for the same VM the pages
> > > > > > > > > > > would be counted twice. So we add a tree to save the page that
> > > > > > > > > > > counted and we will not count it again.
> > > > > > > > > > >
> > > > > > > > > > > Add vdpa_mem_tree to saved the mem that already counted.
> > > > > > > > > > > use a hlist to saved the root for vdpa_mem_tree.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  drivers/vhost/vhost.c | 63 +++++++++++++++++++++++++++++++++++++++++++
> > > > > > > > > > >  drivers/vhost/vhost.h |  1 +
> > > > > > > > > > >  2 files changed, 64 insertions(+)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > > > > > > > > index 40097826cff0..4ca8b1ed944b 100644
> > > > > > > > > > > --- a/drivers/vhost/vhost.c
> > > > > > > > > > > +++ b/drivers/vhost/vhost.c
> > > > > > > > > > > @@ -32,6 +32,8 @@
> > > > > > > > > > >  #include <linux/kcov.h>
> > > > > > > > > > >
> > > > > > > > > > >  #include "vhost.h"
> > > > > > > > > > > +#include <linux/hashtable.h>
> > > > > > > > > > > +#include <linux/jhash.h>
> > > > > > > > > > >
> > > > > > > > > > >  static ushort max_mem_regions = 64;
> > > > > > > > > > >  module_param(max_mem_regions, ushort, 0444);
> > > > > > > > > > > @@ -49,6 +51,14 @@ enum {
> > > > > > > > > > >  #define vhost_used_event(vq) ((__virtio16 __user *)&vq->avail->ring[vq->num])
> > > > > > > > > > >  #define vhost_avail_event(vq) ((__virtio16 __user *)&vq->used->ring[vq->num])
> > > > > > > > > > >
> > > > > > > > > > > +struct vhost_vdpa_rbtree_node {
> > > > > > > > > > > +     struct hlist_node node;
> > > > > > > > > > > +     struct rb_root_cached vdpa_mem_tree;
> > > > > > > > > > > +     struct mm_struct *mm_using;
> > > > > > > > > > > +};
> > > > > > > > > > > +static DECLARE_HASHTABLE(vhost_vdpa_rbtree_hlist, 8);
> > > > > > > > > > > +int vhost_vdpa_rbtree_hlist_status;
> > > > > > > > > > > +
> > > > > > > > > > >  #ifdef CONFIG_VHOST_CROSS_ENDIAN_LEGACY
> > > > > > > > > > >  static void vhost_disable_cross_endian(struct vhost_virtqueue *vq)
> > > > > > > > > > >  {
> > > > > > > > > >
> > > > > > > > > > Are you trying to save some per-mm information here?
> > > > > > > > > > Can't we just add it to mm_struct?
> > > > > > > > > >
> > > > > > > > > yes, this is a per-mm information, but I have checked with jason before,
> > > > > > > > > seems it maybe difficult to change the mm_struct in upstream
> > > > > > > > > so I add an to add a hlist  instead
> > > > > > > > > Thanks
> > > > > > > > > Cindy
> > > > > > > >
> > > > > > > > Difficult how?
> > > > > > >
> > > > > > > It is only useful for vDPA probably. Though it could be used by VFIO
> > > > > > > as well, VFIO does pinning/accounting at the container level and it
> > > > > > > has been there for years.
> > > > > >
> > > > > > Yes it's been there, I'm not sure this means it's perfect.
> > > > > > Also, rdma guys might be interested too I guess?
> > > > >
> > > > > It looks to me they plan to go to iommufd as well.
> > > > >
> > > > > >
> > > > > > > vDPA have an implicit "container" the
> > > > > > > mm_struct, but the accounting is done per device right now.
> > > > > > >
> > > > > > > In the future, when vDPA switches to iommufd, it can be then solved at
> > > > > > > iommufd level.
> > > > > >
> > > > > > So is it even worth fixing now?
> > > > >
> > > > > Not sure, but I guess it's better. (Or we need to teach the libvirt to
> > > > > have special care on this).
> > > >
> > > > It already has to for existing kernels.  Let's just move to iommufd
> > > > faster then?
> > >
> > > This is fine, Cindy, any idea on this?
> > >
> > > >
> > > > > >
> > > > > > > And if we do this in mm, it will bring extra overheads.
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > > Pointer per mm, not too bad ...
> > > > >
> > > > > Unless we enable it unconditionally, it requires a lot of tree
> > > > > operations at least.
> > > > >
> > > > > Thanks
> > > >
> > > > Not sure I understand.
> > >
> > > I mean in order to not count pinned pages multiple times we need to
> > > keep track of the pages that are already pinned in an rbtree with
> > > refcounts. This means we need to populate the tree when userspace
> > > pin/unpin pages.
> > >
> > > Thanks
> >
> > Yep. In fact, if you are going to try and fix accounting you should
> > probably find a way to fix a mix of vdpa and -realtime mlock=on as well
> > as a mix of vfio and vdpa.
> 
> I think iommufd could be a way. E.g VFIO and vDPA can share an iommufd
> address space.
> 
> Thanks

And maybe -realtime mlock=on could use iommufd too ..

> >
> >
> > > >
> > > > > >
> > > > > > > > You get more scrutiny if you try, for sure,
> > > > > > > > and you need to need to generalize it enough that it looks
> > > > > > > > useful outside the driver. But I guess that's good?
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > @@ -571,6 +581,51 @@ static void vhost_detach_mm(struct vhost_dev *dev)
> > > > > > > > > > >       dev->mm = NULL;
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > +struct rb_root_cached *vhost_vdpa_get_mem_tree(struct mm_struct *mm)
> > > > > > > > > > > +{
> > > > > > > > > > > +     struct vhost_vdpa_rbtree_node *rbtree_root = NULL;
> > > > > > > > > > > +     struct rb_root_cached *vdpa_tree;
> > > > > > > > > > > +     u32 key;
> > > > > > > > > > > +
> > > > > > > > > > > +     /* No hased table, init one */
> > > > > > > > > > > +     if (vhost_vdpa_rbtree_hlist_status == 0) {
> > > > > > > > > > > +             hash_init(vhost_vdpa_rbtree_hlist);
> > > > > > > > > > > +             vhost_vdpa_rbtree_hlist_status = 1;
> > > > > > > > > > > +     }
> > > > > > > > > > > +
> > > > > > > > > > > +     key = jhash_1word((u64)mm, JHASH_INITVAL);
> > > > > > > > > > > +     hash_for_each_possible(vhost_vdpa_rbtree_hlist, rbtree_root, node,
> > > > > > > > > > > +                            key) {
> > > > > > > > > > > +             if (rbtree_root->mm_using == mm)
> > > > > > > > > > > +                     return &(rbtree_root->vdpa_mem_tree);
> > > > > > > > > > > +     }
> > > > > > > > > > > +     rbtree_root = kmalloc(sizeof(*rbtree_root), GFP_KERNEL);
> > > > > > > > > > > +     if (!rbtree_root)
> > > > > > > > > > > +             return NULL;
> > > > > > > > > > > +     rbtree_root->mm_using = mm;
> > > > > > > > > > > +     rbtree_root->vdpa_mem_tree = RB_ROOT_CACHED;
> > > > > > > > > > > +     hash_add(vhost_vdpa_rbtree_hlist, &rbtree_root->node, key);
> > > > > > > > > > > +     vdpa_tree = &(rbtree_root->vdpa_mem_tree);
> > > > > > > > > > > +     return vdpa_tree;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > > +void vhost_vdpa_relase_mem_tree(struct mm_struct *mm)
> > > > > > > > > > > +{
> > > > > > > > > > > +     struct vhost_vdpa_rbtree_node *rbtree_root = NULL;
> > > > > > > > > > > +     u32 key;
> > > > > > > > > > > +
> > > > > > > > > > > +     key = jhash_1word((u64)mm, JHASH_INITVAL);
> > > > > > > > > > > +
> > > > > > > > > > > +     /* No hased table, init one */
> > > > > > > > > > > +     hash_for_each_possible(vhost_vdpa_rbtree_hlist, rbtree_root, node,
> > > > > > > > > > > +                            key) {
> > > > > > > > > > > +             if (rbtree_root->mm_using == mm) {
> > > > > > > > > > > +                     hash_del(&rbtree_root->node);
> > > > > > > > > > > +                     kfree(rbtree_root);
> > > > > > > > > > > +             }
> > > > > > > > > > > +     }
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > >  /* Caller should have device mutex */
> > > > > > > > > > >  long vhost_dev_set_owner(struct vhost_dev *dev)
> > > > > > > > > > >  {
> > > > > > > > > > > @@ -605,6 +660,11 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
> > > > > > > > > > >       err = vhost_dev_alloc_iovecs(dev);
> > > > > > > > > > >       if (err)
> > > > > > > > > > >               goto err_cgroup;
> > > > > > > > > > > +     dev->vdpa_mem_tree = vhost_vdpa_get_mem_tree(dev->mm);
> > > > > > > > > > > +     if (dev->vdpa_mem_tree == NULL) {
> > > > > > > > > > > +             err = -ENOMEM;
> > > > > > > > > > > +             goto err_cgroup;
> > > > > > > > > > > +     }
> > > > > > > > > > >
> > > > > > > > > > >       return 0;
> > > > > > > > > > >  err_cgroup:
> > > > > > > > > > > @@ -613,6 +673,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
> > > > > > > > > > >               dev->worker = NULL;
> > > > > > > > > > >       }
> > > > > > > > > > >  err_worker:
> > > > > > > > > > > +     vhost_vdpa_relase_mem_tree(dev->mm);
> > > > > > > > > > >       vhost_detach_mm(dev);
> > > > > > > > > > >       dev->kcov_handle = 0;
> > > > > > > > > > >  err_mm:
> > > > > > > > > > > @@ -710,6 +771,8 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> > > > > > > > > > >               dev->worker = NULL;
> > > > > > > > > > >               dev->kcov_handle = 0;
> > > > > > > > > > >       }
> > > > > > > > > > > +
> > > > > > > > > > > +     vhost_vdpa_relase_mem_tree(dev->mm);
> > > > > > > > > > >       vhost_detach_mm(dev);
> > > > > > > > > > >  }
> > > > > > > > > > >  EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
> > > > > > > > > > > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > > > > > > > > > > index d9109107af08..84de33de3abf 100644
> > > > > > > > > > > --- a/drivers/vhost/vhost.h
> > > > > > > > > > > +++ b/drivers/vhost/vhost.h
> > > > > > > > > > > @@ -160,6 +160,7 @@ struct vhost_dev {
> > > > > > > > > > >       int byte_weight;
> > > > > > > > > > >       u64 kcov_handle;
> > > > > > > > > > >       bool use_worker;
> > > > > > > > > > > +     struct rb_root_cached *vdpa_mem_tree;
> > > > > > > > > > >       int (*msg_handler)(struct vhost_dev *dev, u32 asid,
> > > > > > > > > > >                          struct vhost_iotlb_msg *msg);
> > > > > > > > > > >  };
> > > > > > > > > > > --
> > > > > > > > > > > 2.34.3
> > > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> >

