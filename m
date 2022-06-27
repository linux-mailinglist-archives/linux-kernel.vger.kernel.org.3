Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CBA55D4A8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbiF0INn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiF0INm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 995826265
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656317619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5cRJhWQ6pPJoiF0hS85ovyiHln2URe6Nx8n381Rpupc=;
        b=IUeXTW2MI5aIWFDOj5ySDFPjEFeszx+vuZgadx5Tu2JGnJjv1+KgmrNn/Wjixsf985W/to
        jH9C/Na8bYRmSO4tBsSkwHL9jcj2A9hg+ntLv0nD9zmn9nHO09/TQsbPMraHsReLi4lWgL
        4AEPe6SZDvU4/Wiso3uR8VJf5IPXrf8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-lLrZ4CFpM6Kqb8fR6FLqVQ-1; Mon, 27 Jun 2022 04:13:37 -0400
X-MC-Unique: lLrZ4CFpM6Kqb8fR6FLqVQ-1
Received: by mail-ed1-f69.google.com with SMTP id y5-20020a056402358500b0043592ac3961so6545808edc.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5cRJhWQ6pPJoiF0hS85ovyiHln2URe6Nx8n381Rpupc=;
        b=PmN5esAh8u2Tc34bO4asWJ7r+yk6O+8gnnCbEH8coX1GC9QCoG+W3oYkm3on7OxEcu
         5XjfYs8dBMhhTLr8nBFkGojt4WJWitmZfXFDYAeG2iJh6NbJ50AX02UQOUwsGM6JU009
         Wui6mYWJOP92v8lpCNdMPzOL75mz631bfIhiFMO9B2AkewpvDlOocYtd6YL3Y9Y3rwwC
         AaJORK5LtxfzrhgGSR9CuLz3urh/FKlyYfAFTjSVVJhRDsjYHXRRdMuONbsYSP7Atgo1
         2/3E2vdSwR6CHftW2z5vhwQyFLchbGYgCvD6MjsY6THTjxVYxHmd07wu+gqO8Q9W8mLo
         fisw==
X-Gm-Message-State: AJIora93JYUXy2c3jEqSmaxTQSYTHjxVUXlB2tBqXrK2YVZXMr2iyIoe
        r4Ar4oHhe7NXjq9AfZJDd8pbNGSiY1XdWdRlvIToKIO6EPb0uDtCtehTQK0EG2GJncJBj44Fzh8
        swAF5PPgAPGNb4aNnzrb4sJbgfdZach1cCIsa2+FN
X-Received: by 2002:a05:6402:3708:b0:433:2d3b:ed5 with SMTP id ek8-20020a056402370800b004332d3b0ed5mr15010278edb.246.1656317616157;
        Mon, 27 Jun 2022 01:13:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1toJpVBYfZ36upWpt3m72aYCqv4Xc39rlc2nQxc+x2hYTcFFuKUKu4M8LKBeVGB1J5tuoes8a4Gtct1/TA6qaY=
X-Received: by 2002:a05:6402:3708:b0:433:2d3b:ed5 with SMTP id
 ek8-20020a056402370800b004332d3b0ed5mr15010264edb.246.1656317615931; Mon, 27
 Jun 2022 01:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220626090409.1011144-1-lulu@redhat.com> <20220626055420-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220626055420-mutt-send-email-mst@kernel.org>
From:   Cindy Lu <lulu@redhat.com>
Date:   Mon, 27 Jun 2022 16:12:57 +0800
Message-ID: <CACLfguVMfqAiCVoNVr7J8ooQa35tNJOSK-XHqsdE3hdXsfOZ+A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] vhost: Add rbtree vdpa_mem_tree to saved the
 counted mem
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
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

On Sun, Jun 26, 2022 at 6:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sun, Jun 26, 2022 at 05:04:08PM +0800, Cindy Lu wrote:
> > We count pinned_vm as follow in vhost-vDPA
> >
> > lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
> >          ret = -ENOMEM;
> >          goto unlock;
> > }
> > This means if we have two vDPA devices for the same VM the pages
> > would be counted twice. So we add a tree to save the page that
> > counted and we will not count it again.
> >
> > Add vdpa_mem_tree to saved the mem that already counted.
> > use a hlist to saved the root for vdpa_mem_tree.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vhost.c | 63 +++++++++++++++++++++++++++++++++++++++++++
> >  drivers/vhost/vhost.h |  1 +
> >  2 files changed, 64 insertions(+)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 40097826cff0..4ca8b1ed944b 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -32,6 +32,8 @@
> >  #include <linux/kcov.h>
> >
> >  #include "vhost.h"
> > +#include <linux/hashtable.h>
> > +#include <linux/jhash.h>
> >
> >  static ushort max_mem_regions = 64;
> >  module_param(max_mem_regions, ushort, 0444);
> > @@ -49,6 +51,14 @@ enum {
> >  #define vhost_used_event(vq) ((__virtio16 __user *)&vq->avail->ring[vq->num])
> >  #define vhost_avail_event(vq) ((__virtio16 __user *)&vq->used->ring[vq->num])
> >
> > +struct vhost_vdpa_rbtree_node {
> > +     struct hlist_node node;
> > +     struct rb_root_cached vdpa_mem_tree;
> > +     struct mm_struct *mm_using;
> > +};
> > +static DECLARE_HASHTABLE(vhost_vdpa_rbtree_hlist, 8);
> > +int vhost_vdpa_rbtree_hlist_status;
> > +
> >  #ifdef CONFIG_VHOST_CROSS_ENDIAN_LEGACY
> >  static void vhost_disable_cross_endian(struct vhost_virtqueue *vq)
> >  {
>
> Are you trying to save some per-mm information here?
> Can't we just add it to mm_struct?
>
yes, this is a per-mm information, but I have checked with jason before,
seems it maybe difficult to change the mm_struct in upstream
so I add an to add a hlist  instead
Thanks
Cindy

>
>
> > @@ -571,6 +581,51 @@ static void vhost_detach_mm(struct vhost_dev *dev)
> >       dev->mm = NULL;
> >  }
> >
> > +struct rb_root_cached *vhost_vdpa_get_mem_tree(struct mm_struct *mm)
> > +{
> > +     struct vhost_vdpa_rbtree_node *rbtree_root = NULL;
> > +     struct rb_root_cached *vdpa_tree;
> > +     u32 key;
> > +
> > +     /* No hased table, init one */
> > +     if (vhost_vdpa_rbtree_hlist_status == 0) {
> > +             hash_init(vhost_vdpa_rbtree_hlist);
> > +             vhost_vdpa_rbtree_hlist_status = 1;
> > +     }
> > +
> > +     key = jhash_1word((u64)mm, JHASH_INITVAL);
> > +     hash_for_each_possible(vhost_vdpa_rbtree_hlist, rbtree_root, node,
> > +                            key) {
> > +             if (rbtree_root->mm_using == mm)
> > +                     return &(rbtree_root->vdpa_mem_tree);
> > +     }
> > +     rbtree_root = kmalloc(sizeof(*rbtree_root), GFP_KERNEL);
> > +     if (!rbtree_root)
> > +             return NULL;
> > +     rbtree_root->mm_using = mm;
> > +     rbtree_root->vdpa_mem_tree = RB_ROOT_CACHED;
> > +     hash_add(vhost_vdpa_rbtree_hlist, &rbtree_root->node, key);
> > +     vdpa_tree = &(rbtree_root->vdpa_mem_tree);
> > +     return vdpa_tree;
> > +}
> > +
> > +void vhost_vdpa_relase_mem_tree(struct mm_struct *mm)
> > +{
> > +     struct vhost_vdpa_rbtree_node *rbtree_root = NULL;
> > +     u32 key;
> > +
> > +     key = jhash_1word((u64)mm, JHASH_INITVAL);
> > +
> > +     /* No hased table, init one */
> > +     hash_for_each_possible(vhost_vdpa_rbtree_hlist, rbtree_root, node,
> > +                            key) {
> > +             if (rbtree_root->mm_using == mm) {
> > +                     hash_del(&rbtree_root->node);
> > +                     kfree(rbtree_root);
> > +             }
> > +     }
> > +}
> > +
> >  /* Caller should have device mutex */
> >  long vhost_dev_set_owner(struct vhost_dev *dev)
> >  {
> > @@ -605,6 +660,11 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
> >       err = vhost_dev_alloc_iovecs(dev);
> >       if (err)
> >               goto err_cgroup;
> > +     dev->vdpa_mem_tree = vhost_vdpa_get_mem_tree(dev->mm);
> > +     if (dev->vdpa_mem_tree == NULL) {
> > +             err = -ENOMEM;
> > +             goto err_cgroup;
> > +     }
> >
> >       return 0;
> >  err_cgroup:
> > @@ -613,6 +673,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
> >               dev->worker = NULL;
> >       }
> >  err_worker:
> > +     vhost_vdpa_relase_mem_tree(dev->mm);
> >       vhost_detach_mm(dev);
> >       dev->kcov_handle = 0;
> >  err_mm:
> > @@ -710,6 +771,8 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> >               dev->worker = NULL;
> >               dev->kcov_handle = 0;
> >       }
> > +
> > +     vhost_vdpa_relase_mem_tree(dev->mm);
> >       vhost_detach_mm(dev);
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
> > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > index d9109107af08..84de33de3abf 100644
> > --- a/drivers/vhost/vhost.h
> > +++ b/drivers/vhost/vhost.h
> > @@ -160,6 +160,7 @@ struct vhost_dev {
> >       int byte_weight;
> >       u64 kcov_handle;
> >       bool use_worker;
> > +     struct rb_root_cached *vdpa_mem_tree;
> >       int (*msg_handler)(struct vhost_dev *dev, u32 asid,
> >                          struct vhost_iotlb_msg *msg);
> >  };
> > --
> > 2.34.3
>

