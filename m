Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B084BE28A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377169AbiBUN7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:59:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347740AbiBUN7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:59:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A7261A3A4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645451934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xBPVmy9fmCDwEkrGiGuWioYXUdSe9l6BOeMmRrZgnjA=;
        b=QjK8qogaHaIeJ7LFVMgr6Jy8es0RSp5ywhNiUudq3aOMJoogwTFpfVPcrEGPISyxhAINLF
        LbuNV+632tqcoXXC+85sEeMkYPmg3oUd0+wItLNLXQn6B0Nqkd8NEXH71j/Ut7c+4X7ciV
        UASApNqp1h2Cv9NySWsiHXdnwWCCRE0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-VxbPxpy_ONO1WSP8OgeEVA-1; Mon, 21 Feb 2022 08:58:53 -0500
X-MC-Unique: VxbPxpy_ONO1WSP8OgeEVA-1
Received: by mail-wm1-f72.google.com with SMTP id r11-20020a1c440b000000b0037bb51b549aso7279669wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:58:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xBPVmy9fmCDwEkrGiGuWioYXUdSe9l6BOeMmRrZgnjA=;
        b=3LN9WjBTXlm06lrIsGv/2YC9bYndZI2pd5yvFx01HQddm0+TlLVc5zW/39hjf8gvVG
         ivswEPk4OiWr9M88mxHiJrx7mcVco5/MJyQmUhGaSyPuKm8dmGyab4lB02f534WAViEc
         oMCmH+Pckvn/Sv/vn6OYjYFhaViAQGXQ2Bp9W91ryZ2wlDMG78BB4XLe7q2fmXx72hq3
         vJP3GEdQi0anZwvrGiVYYzsoniX3nnRXYuA/Ml5Jnp6I/9s6D2P3FFyYhigV9CosQu1y
         zjpuB/2Dyzx7mIWLlHrckBmyWH+PCmLJQIEqQBc7wmM0nuNMU2lS5l+bC+PMLLK8hFK3
         +8mg==
X-Gm-Message-State: AOAM533nVACxGqrv94ytG/G3AmYkEcsX0rbrlZSo4J5REkvl9xmvtxUm
        2MuQHJUE1QBgnKjolw0blvG5qgi3jHuf7s4komGLcW0mrAUu1DSp1WFwHo+uxClZbxQQm8xLm5R
        nTkkxDz3N6Gto6Sz2SrRo+yL4
X-Received: by 2002:a05:6000:1248:b0:1e4:a4bf:d92c with SMTP id j8-20020a056000124800b001e4a4bfd92cmr15786330wrx.260.1645451932027;
        Mon, 21 Feb 2022 05:58:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzlqSTR4CvqmnEwxIUtuXhdACHuE64yUfm1Nc7gzxMNJD0YYknE0/be5Q3qTJLw01bnPsm0BA==
X-Received: by 2002:a05:6000:1248:b0:1e4:a4bf:d92c with SMTP id j8-20020a056000124800b001e4a4bfd92cmr15786319wrx.260.1645451931778;
        Mon, 21 Feb 2022 05:58:51 -0800 (PST)
Received: from redhat.com ([2.55.129.240])
        by smtp.gmail.com with ESMTPSA id v9sm10244169wrx.27.2022.02.21.05.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 05:58:50 -0800 (PST)
Date:   Mon, 21 Feb 2022 08:58:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
Message-ID: <20220221085709-mutt-send-email-mst@kernel.org>
References: <20220221040745.1177-1-hdanton@sina.com>
 <20220221085227.1356-1-hdanton@sina.com>
 <20220221101538.1415-1-hdanton@sina.com>
 <20220221130022.1494-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221130022.1494-1-hdanton@sina.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 09:00:22PM +0800, Hillf Danton wrote:
> On Mon, 21 Feb 2022 05:48:48 -0500 Michael S. Tsirkin wrote:
> > On Mon, Feb 21, 2022 at 06:15:38PM +0800, Hillf Danton wrote:
> > > On Mon, 21 Feb 2022 04:17:02 -0500 Michael S. Tsirkin wrote:
> > > > On Mon, Feb 21, 2022 at 04:52:27PM +0800, Hillf Danton wrote:
> > > > > Another round of attempts to quiesce the
> > > > > WARNING: CPU: 1 PID: 4069 at drivers/vhost/vhost.c:715 after the
> > > > > BUG at drivers/vhost/vhost.c:2337 went home.
> > > > 
> > > > Could you pls clarify what do you mean by "went home" here?
> > > 
> > > The reproducer failed to trigger it.
> > > 
> > > Hillf
> > 
> > You mean this patch?
> 
> No, it is part of the first round.
> > 
> > @@ -2207,7 +2209,10 @@ int vhost_get_vq_desc(struct vhost_virtq
> >         __virtio16 avail_idx;
> >         __virtio16 ring_head;
> >         int ret, access;
> > +       bool was_set = !!(vq->used_flags & VRING_USED_F_NO_NOTIFY);
> > 
> > +       if (!was_set)
> > +               return -EINVAL;
> >         /* Check it isn't doing very strange things with descriptor numbers. */
> >         last_avail_idx = vq->last_avail_idx;
> > 
> > 
> > However, I do not understand how do we enter vhost_get_vq_desc
> > with vq->used_flags & VRING_USED_F_NO_NOTIFY being clear.
> > Do you?
> 
> The diff below turned BUG in to WARNING, and you can see it in one of the
> mails in your inbox as you are on the Cc list.

Right. So it's not a fix, it's just a work around, and we still need to
understand how we can get into this state.

> Hillf
> ---<---
> 
> The re-trigger of the BUG_ON sends us to the start point and looks like it
> could not be solved without a mind refresh.

I don't understand this sentence btw. How does BUG_ON send us to the
start point? what is the start point? and what is a mind refresh?

> Add a flag to vsock and set it before work flush upon release, and no more
> works will be queued with it turned on.
> 
> Hillf
> 
> >>#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ f71077a4d84b 
> 
> --- x/drivers/vhost/vsock.c
> +++ y/drivers/vhost/vsock.c
> @@ -55,6 +55,7 @@ struct vhost_vsock {
>  	struct list_head send_pkt_list;	/* host->guest pending packets */
>  
>  	atomic_t queued_replies;
> +	int cleanup;
>  
>  	u32 guest_cid;
>  	bool seqpacket_allow;
> @@ -262,6 +263,9 @@ vhost_transport_do_send_pkt(struct vhost
>  out:
>  	mutex_unlock(&vq->mutex);
>  
> +	if (vsock->cleanup)
> +		return;
> +
>  	if (restart_tx)
>  		vhost_poll_queue(&tx_vq->poll);
>  }
> @@ -678,6 +682,7 @@ static int vhost_vsock_dev_open(struct i
>  	}
>  
>  	vsock->guest_cid = 0; /* no CID assigned yet */
> +	vsock->cleanup = 0;
>  
>  	atomic_set(&vsock->queued_replies, 0);
>  
> @@ -741,6 +746,8 @@ static int vhost_vsock_dev_release(struc
>  {
>  	struct vhost_vsock *vsock = file->private_data;
>  
> +	vsock->cleanup = 1;
> +
>  	mutex_lock(&vhost_vsock_mutex);
>  	if (vsock->guest_cid)
>  		hash_del_rcu(&vsock->hash);
> --

