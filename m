Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B387A55CF90
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245505AbiF1G1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235939AbiF1G1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:27:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 635BF23172
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656397669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k5bFsoQngAxp3TXw51vK/qB4xzeK8TUFy/Ho2j7Rrbc=;
        b=HyhsO4jG0i378v5sibn/pZ0y06/sPYMBuPcWGkdMaOksEvFEPkD4E84RBFF804tchmKZHc
        DVmXj/FBG7bBCoLQnc3YpVBbtZuVsRdjGmt3aciEUTDif0r6Rki43L0d5RDdOZYqaRvVqB
        3CauYr+HAQ6pL2rHbDi2IwmuP3kSx5Q=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-7Fq00qtWOKW0x2NM2GnkNg-1; Tue, 28 Jun 2022 02:27:47 -0400
X-MC-Unique: 7Fq00qtWOKW0x2NM2GnkNg-1
Received: by mail-lf1-f71.google.com with SMTP id p36-20020a05651213a400b004779d806c13so5779236lfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k5bFsoQngAxp3TXw51vK/qB4xzeK8TUFy/Ho2j7Rrbc=;
        b=FLDZfcy+QO+XO+gQkmzi+abDSL/9N9gRZepK2aNSwAvJTp2uDXZNhUwpSRVMAkqYcb
         QU2wSoMjEgIZ5IP3kPVoxiBPMatK/+hZPXtZBH4ydZV3phVyH0mnx4lCFqCDwYa2e8cP
         c7Vat1DvroLoI4ahnxuUynC2ziw8Uo8eE9BFweVdFOP2xNzk04XvyhkGTbyoWvGoqMDz
         aRbVqxSNL4mQnG3Jgf+fhnep2L0aQNCkqcJSVERz0Yg0AJyN3OOeVj0fJKNkgvHtSrZY
         2f5SWMCVUkqtRKgUI9FUKI0//JMlLPYmuqyV1yMknbZWoEYAZaSPjodZkf0TeVXPIKTG
         9wfQ==
X-Gm-Message-State: AJIora/mIr8OV094Rh6L+ahKkIqBuhyrEexDN30j6ghDu85JsLmjc2Wj
        zESeEjITlij1TdUKytmQc5+reed/4B9QY0tcuyxMmnHw6T+z0zXKjlqWSBkdOlBlrQgXusLMXpv
        jQza7NvdpTubr8CGM0D9gMiYOXxdDosMSRgnGovli
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id y15-20020a0565123f0f00b0047f6f890326mr10314027lfa.124.1656397665894;
        Mon, 27 Jun 2022 23:27:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u1z1dAYPVM0nvBtnQ2zRPXMRcTjpEiS50NgGR0Cgnwq0C0EV9VgTFyEXO5QUvQ89CR/UlEk+CKvKktsPeTF0U=
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr10314018lfa.124.1656397665651; Mon, 27
 Jun 2022 23:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220626055420-mutt-send-email-mst@kernel.org>
 <CACLfguVMfqAiCVoNVr7J8ooQa35tNJOSK-XHqsdE3hdXsfOZ+A@mail.gmail.com>
 <20220627055826-mutt-send-email-mst@kernel.org> <CACGkMEugJQY-QsnekKHWSdaG0H03qFxdmu+O1tQKMge65bFmHw@mail.gmail.com>
 <20220628014642-mutt-send-email-mst@kernel.org> <CACGkMEvt9QVvZb+gEuynazGmEM-j22QdiEH_V-oWD1=NZQS+5g@mail.gmail.com>
 <20220628020622-mutt-send-email-mst@kernel.org> <CACGkMEvAnmaS11JYXwsMmk9GaE_Q+Egz9nzk3H-rZF+DCs8Mow@mail.gmail.com>
 <20220628021443-mutt-send-email-mst@kernel.org> <CACGkMEt6aH-Xfd7nHJ1217ybQaGEvAmYXH_qunybmqVUN2PdEw@mail.gmail.com>
 <20220628022458-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220628022458-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 28 Jun 2022 14:27:34 +0800
Message-ID: <CACGkMEt01HdOyNMSe3_eBiZ4tw71K020XHLY--6RAWt0vqJgcA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] vhost: Add rbtree vdpa_mem_tree to saved the
 counted mem
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Cindy Lu <lulu@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 2:25 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jun 28, 2022 at 02:18:55PM +0800, Jason Wang wrote:
> > On Tue, Jun 28, 2022 at 2:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Jun 28, 2022 at 02:10:38PM +0800, Jason Wang wrote:
> > > > On Tue, Jun 28, 2022 at 2:07 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Tue, Jun 28, 2022 at 02:03:38PM +0800, Jason Wang wrote:
> > > > > > On Tue, Jun 28, 2022 at 1:58 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Tue, Jun 28, 2022 at 11:54:27AM +0800, Jason Wang wrote:
> > > > > > > > On Mon, Jun 27, 2022 at 6:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Jun 27, 2022 at 04:12:57PM +0800, Cindy Lu wrote:
> > > > > > > > > > On Sun, Jun 26, 2022 at 6:01 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Sun, Jun 26, 2022 at 05:04:08PM +0800, Cindy Lu wrote:
> > > > > > > > > > > > We count pinned_vm as follow in vhost-vDPA
> > > > > > > > > > > >
> > > > > > > > > > > > lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > > > > > > > > > > > if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
> > > > > > > > > > > >          ret = -ENOMEM;
> > > > > > > > > > > >          goto unlock;
> > > > > > > > > > > > }
> > > > > > > > > > > > This means if we have two vDPA devices for the same VM the pages
> > > > > > > > > > > > would be counted twice. So we add a tree to save the page that
> > > > > > > > > > > > counted and we will not count it again.
> > > > > > > > > > > >
> > > > > > > > > > > > Add vdpa_mem_tree to saved the mem that already counted.
> > > > > > > > > > > > use a hlist to saved the root for vdpa_mem_tree.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > >  drivers/vhost/vhost.c | 63 +++++++++++++++++++++++++++++++++++++++++++
> > > > > > > > > > > >  drivers/vhost/vhost.h |  1 +
> > > > > > > > > > > >  2 files changed, 64 insertions(+)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > > > > > > > > > index 40097826cff0..4ca8b1ed944b 100644
> > > > > > > > > > > > --- a/drivers/vhost/vhost.c
> > > > > > > > > > > > +++ b/drivers/vhost/vhost.c
> > > > > > > > > > > > @@ -32,6 +32,8 @@
> > > > > > > > > > > >  #include <linux/kcov.h>
> > > > > > > > > > > >
> > > > > > > > > > > >  #include "vhost.h"
> > > > > > > > > > > > +#include <linux/hashtable.h>
> > > > > > > > > > > > +#include <linux/jhash.h>
> > > > > > > > > > > >
> > > > > > > > > > > >  static ushort max_mem_regions = 64;
> > > > > > > > > > > >  module_param(max_mem_regions, ushort, 0444);
> > > > > > > > > > > > @@ -49,6 +51,14 @@ enum {
> > > > > > > > > > > >  #define vhost_used_event(vq) ((__virtio16 __user *)&vq->avail->ring[vq->num])
> > > > > > > > > > > >  #define vhost_avail_event(vq) ((__virtio16 __user *)&vq->used->ring[vq->num])
> > > > > > > > > > > >
> > > > > > > > > > > > +struct vhost_vdpa_rbtree_node {
> > > > > > > > > > > > +     struct hlist_node node;
> > > > > > > > > > > > +     struct rb_root_cached vdpa_mem_tree;
> > > > > > > > > > > > +     struct mm_struct *mm_using;
> > > > > > > > > > > > +};
> > > > > > > > > > > > +static DECLARE_HASHTABLE(vhost_vdpa_rbtree_hlist, 8);
> > > > > > > > > > > > +int vhost_vdpa_rbtree_hlist_status;
> > > > > > > > > > > > +
> > > > > > > > > > > >  #ifdef CONFIG_VHOST_CROSS_ENDIAN_LEGACY
> > > > > > > > > > > >  static void vhost_disable_cross_endian(struct vhost_virtqueue *vq)
> > > > > > > > > > > >  {
> > > > > > > > > > >
> > > > > > > > > > > Are you trying to save some per-mm information here?
> > > > > > > > > > > Can't we just add it to mm_struct?
> > > > > > > > > > >
> > > > > > > > > > yes, this is a per-mm information, but I have checked with jason before,
> > > > > > > > > > seems it maybe difficult to change the mm_struct in upstream
> > > > > > > > > > so I add an to add a hlist  instead
> > > > > > > > > > Thanks
> > > > > > > > > > Cindy
> > > > > > > > >
> > > > > > > > > Difficult how?
> > > > > > > >
> > > > > > > > It is only useful for vDPA probably. Though it could be used by VFIO
> > > > > > > > as well, VFIO does pinning/accounting at the container level and it
> > > > > > > > has been there for years.
> > > > > > >
> > > > > > > Yes it's been there, I'm not sure this means it's perfect.
> > > > > > > Also, rdma guys might be interested too I guess?
> > > > > >
> > > > > > It looks to me they plan to go to iommufd as well.
> > > > > >
> > > > > > >
> > > > > > > > vDPA have an implicit "container" the
> > > > > > > > mm_struct, but the accounting is done per device right now.
> > > > > > > >
> > > > > > > > In the future, when vDPA switches to iommufd, it can be then solved at
> > > > > > > > iommufd level.
> > > > > > >
> > > > > > > So is it even worth fixing now?
> > > > > >
> > > > > > Not sure, but I guess it's better. (Or we need to teach the libvirt to
> > > > > > have special care on this).
> > > > >
> > > > > It already has to for existing kernels.  Let's just move to iommufd
> > > > > faster then?
> > > >
> > > > This is fine, Cindy, any idea on this?
> > > >
> > > > >
> > > > > > >
> > > > > > > > And if we do this in mm, it will bring extra overheads.
> > > > > > > >
> > > > > > > > Thanks
> > > > > > >
> > > > > > > Pointer per mm, not too bad ...
> > > > > >
> > > > > > Unless we enable it unconditionally, it requires a lot of tree
> > > > > > operations at least.
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > Not sure I understand.
> > > >
> > > > I mean in order to not count pinned pages multiple times we need to
> > > > keep track of the pages that are already pinned in an rbtree with
> > > > refcounts. This means we need to populate the tree when userspace
> > > > pin/unpin pages.
> > > >
> > > > Thanks
> > >
> > > Yep. In fact, if you are going to try and fix accounting you should
> > > probably find a way to fix a mix of vdpa and -realtime mlock=on as well
> > > as a mix of vfio and vdpa.
> >
> > I think iommufd could be a way. E.g VFIO and vDPA can share an iommufd
> > address space.
> >
> > Thanks
>
> And maybe -realtime mlock=on could use iommufd too ..

Probably, since iommufd is under development we can ask/code for new features.

Thanks

>
> > >
> > >
> > > > >
> > > > > > >
> > > > > > > > > You get more scrutiny if you try, for sure,
> > > > > > > > > and you need to need to generalize it enough that it looks
> > > > > > > > > useful outside the driver. But I guess that's good?
> > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > @@ -571,6 +581,51 @@ static void vhost_detach_mm(struct vhost_dev *dev)
> > > > > > > > > > > >       dev->mm = NULL;
> > > > > > > > > > > >  }
> > > > > > > > > > > >
> > > > > > > > > > > > +struct rb_root_cached *vhost_vdpa_get_mem_tree(struct mm_struct *mm)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +     struct vhost_vdpa_rbtree_node *rbtree_root = NULL;
> > > > > > > > > > > > +     struct rb_root_cached *vdpa_tree;
> > > > > > > > > > > > +     u32 key;
> > > > > > > > > > > > +
> > > > > > > > > > > > +     /* No hased table, init one */
> > > > > > > > > > > > +     if (vhost_vdpa_rbtree_hlist_status == 0) {
> > > > > > > > > > > > +             hash_init(vhost_vdpa_rbtree_hlist);
> > > > > > > > > > > > +             vhost_vdpa_rbtree_hlist_status = 1;
> > > > > > > > > > > > +     }
> > > > > > > > > > > > +
> > > > > > > > > > > > +     key = jhash_1word((u64)mm, JHASH_INITVAL);
> > > > > > > > > > > > +     hash_for_each_possible(vhost_vdpa_rbtree_hlist, rbtree_root, node,
> > > > > > > > > > > > +                            key) {
> > > > > > > > > > > > +             if (rbtree_root->mm_using == mm)
> > > > > > > > > > > > +                     return &(rbtree_root->vdpa_mem_tree);
> > > > > > > > > > > > +     }
> > > > > > > > > > > > +     rbtree_root = kmalloc(sizeof(*rbtree_root), GFP_KERNEL);
> > > > > > > > > > > > +     if (!rbtree_root)
> > > > > > > > > > > > +             return NULL;
> > > > > > > > > > > > +     rbtree_root->mm_using = mm;
> > > > > > > > > > > > +     rbtree_root->vdpa_mem_tree = RB_ROOT_CACHED;
> > > > > > > > > > > > +     hash_add(vhost_vdpa_rbtree_hlist, &rbtree_root->node, key);
> > > > > > > > > > > > +     vdpa_tree = &(rbtree_root->vdpa_mem_tree);
> > > > > > > > > > > > +     return vdpa_tree;
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > > +void vhost_vdpa_relase_mem_tree(struct mm_struct *mm)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +     struct vhost_vdpa_rbtree_node *rbtree_root = NULL;
> > > > > > > > > > > > +     u32 key;
> > > > > > > > > > > > +
> > > > > > > > > > > > +     key = jhash_1word((u64)mm, JHASH_INITVAL);
> > > > > > > > > > > > +
> > > > > > > > > > > > +     /* No hased table, init one */
> > > > > > > > > > > > +     hash_for_each_possible(vhost_vdpa_rbtree_hlist, rbtree_root, node,
> > > > > > > > > > > > +                            key) {
> > > > > > > > > > > > +             if (rbtree_root->mm_using == mm) {
> > > > > > > > > > > > +                     hash_del(&rbtree_root->node);
> > > > > > > > > > > > +                     kfree(rbtree_root);
> > > > > > > > > > > > +             }
> > > > > > > > > > > > +     }
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > >  /* Caller should have device mutex */
> > > > > > > > > > > >  long vhost_dev_set_owner(struct vhost_dev *dev)
> > > > > > > > > > > >  {
> > > > > > > > > > > > @@ -605,6 +660,11 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
> > > > > > > > > > > >       err = vhost_dev_alloc_iovecs(dev);
> > > > > > > > > > > >       if (err)
> > > > > > > > > > > >               goto err_cgroup;
> > > > > > > > > > > > +     dev->vdpa_mem_tree = vhost_vdpa_get_mem_tree(dev->mm);
> > > > > > > > > > > > +     if (dev->vdpa_mem_tree == NULL) {
> > > > > > > > > > > > +             err = -ENOMEM;
> > > > > > > > > > > > +             goto err_cgroup;
> > > > > > > > > > > > +     }
> > > > > > > > > > > >
> > > > > > > > > > > >       return 0;
> > > > > > > > > > > >  err_cgroup:
> > > > > > > > > > > > @@ -613,6 +673,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
> > > > > > > > > > > >               dev->worker = NULL;
> > > > > > > > > > > >       }
> > > > > > > > > > > >  err_worker:
> > > > > > > > > > > > +     vhost_vdpa_relase_mem_tree(dev->mm);
> > > > > > > > > > > >       vhost_detach_mm(dev);
> > > > > > > > > > > >       dev->kcov_handle = 0;
> > > > > > > > > > > >  err_mm:
> > > > > > > > > > > > @@ -710,6 +771,8 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> > > > > > > > > > > >               dev->worker = NULL;
> > > > > > > > > > > >               dev->kcov_handle = 0;
> > > > > > > > > > > >       }
> > > > > > > > > > > > +
> > > > > > > > > > > > +     vhost_vdpa_relase_mem_tree(dev->mm);
> > > > > > > > > > > >       vhost_detach_mm(dev);
> > > > > > > > > > > >  }
> > > > > > > > > > > >  EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
> > > > > > > > > > > > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > > > > > > > > > > > index d9109107af08..84de33de3abf 100644
> > > > > > > > > > > > --- a/drivers/vhost/vhost.h
> > > > > > > > > > > > +++ b/drivers/vhost/vhost.h
> > > > > > > > > > > > @@ -160,6 +160,7 @@ struct vhost_dev {
> > > > > > > > > > > >       int byte_weight;
> > > > > > > > > > > >       u64 kcov_handle;
> > > > > > > > > > > >       bool use_worker;
> > > > > > > > > > > > +     struct rb_root_cached *vdpa_mem_tree;
> > > > > > > > > > > >       int (*msg_handler)(struct vhost_dev *dev, u32 asid,
> > > > > > > > > > > >                          struct vhost_iotlb_msg *msg);
> > > > > > > > > > > >  };
> > > > > > > > > > > > --
> > > > > > > > > > > > 2.34.3
> > > > > > > > > > >
> > > > > > > > >
> > > > > > >
> > > > >
> > >
>

