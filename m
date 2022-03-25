Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DA64E6E57
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 07:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244851AbiCYGrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 02:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiCYGrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 02:47:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 000F7C55AD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 23:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648190735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Ps+162FjCw1COHBRdJjTCL/Gy1wv1H2La87XaBnoPc=;
        b=SmhiFPUP/cRI/uNUn0G2xD7fdnkj05Tvb/zxWtOQ7mLZU/LU0CnoD0ULj8QUq2OfnUeqtc
        BKo0VJFF9tg7PjCyXAFQBl5DGNVQFotU7sAoSkEIpIjrhgJdioZTKAn7z/6kuBnFH6Rlkh
        bUERy4ojEMl6jGR0jCX+L15m1xdho7Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-pToOcXLpPy62rLXJ0WRbHw-1; Fri, 25 Mar 2022 02:45:31 -0400
X-MC-Unique: pToOcXLpPy62rLXJ0WRbHw-1
Received: by mail-wm1-f72.google.com with SMTP id h127-20020a1c2185000000b0038c6f7e22a4so4824383wmh.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 23:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Ps+162FjCw1COHBRdJjTCL/Gy1wv1H2La87XaBnoPc=;
        b=T5kDEnw1GImbEyvKn3BeKUrteJRjgwqdE9hOi8IIgP735WuOh+Lcv9zYPhvtNsQWfM
         vbzYKktEp4MbOAbneRvT6nEt+5UlDmD0zvTk89tj+EdTI+Q4U8cZT2dE2+o77GUiw7Np
         UmdKtivkFPLn8l1v8IkXjuHrX1d9eUNGqirAzqrLDP2ylP9pUha8BfzwiGxbJ30GTTfv
         tY6oKvLm3jvQElrIZ/6HuJsCczUMlwVAjNKUdBaqnzpL0jgAEKpKST+pVInZ2iwAWjXV
         dWUHLSuGs7cQu138paLLFdgmfuj1dEhCo9lK48gtQfZzwTonEZrPU7SjtlMXrDSA/tj4
         /OFg==
X-Gm-Message-State: AOAM5325dWeHVVtRueL+iSDknZFIRBJlRRj0TdNNW9ENId9BL4QuGvM5
        4rFqM0kB9RYFRhHiT0L2d0CdsUNPQd/0MTNzXrWRn0FHhxGA7hJk30FRK+xYxXJedgqO6GwxqnX
        z5z2bpofarLb6nLMufy6upvc1
X-Received: by 2002:a05:600c:6020:b0:38c:d24c:5fbf with SMTP id az32-20020a05600c602000b0038cd24c5fbfmr5990681wmb.18.1648190729747;
        Thu, 24 Mar 2022 23:45:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCwwJ6vWbOVZe1BgwFRqeurkuzU2qwLOIN+1N59iBZ6Ho6QaMdgMF2gkk8YkYOr/nNxfLfIQ==
X-Received: by 2002:a05:600c:6020:b0:38c:d24c:5fbf with SMTP id az32-20020a05600c602000b0038cd24c5fbfmr5990669wmb.18.1648190729557;
        Thu, 24 Mar 2022 23:45:29 -0700 (PDT)
Received: from redhat.com ([2.55.151.118])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d5849000000b002058631cfacsm4455201wrf.61.2022.03.24.23.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 23:45:28 -0700 (PDT)
Date:   Fri, 25 Mar 2022 02:45:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Eli Cohen <elic@nvidia.com>, Hillf Danton <hdanton@sina.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
Message-ID: <20220325024324-mutt-send-email-mst@kernel.org>
References: <CACGkMEvF80FuU0uD+RZMOrySQ0K2RZVh7Pmn4UhNtz_Exs3c2w@mail.gmail.com>
 <CACGkMEvLqox3QZxpxeQdrjBnM6zRr_wGfddoN45RUSsZEOe=bQ@mail.gmail.com>
 <20220321123420.3207-1-hdanton@sina.com>
 <CACGkMEt-PRCsBQ+EJVGeWGikJfLk-0M1dRPMqnp9YC5R4HYAjQ@mail.gmail.com>
 <20220324005345.3623-1-hdanton@sina.com>
 <20220324060419.3682-1-hdanton@sina.com>
 <20220324021428-mutt-send-email-mst@kernel.org>
 <20220324120217.3746-1-hdanton@sina.com>
 <DM8PR12MB54004034A8A5DA1D2B6EA8D1AB199@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CACGkMEtVUqJcS1W2p1U9RCjQqQOSREu1J9zjmw37TbPBNqq7tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEtVUqJcS1W2p1U9RCjQqQOSREu1J9zjmw37TbPBNqq7tA@mail.gmail.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 11:22:25AM +0800, Jason Wang wrote:
> On Thu, Mar 24, 2022 at 8:24 PM Eli Cohen <elic@nvidia.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Hillf Danton <hdanton@sina.com>
> > > Sent: Thursday, March 24, 2022 2:02 PM
> > > To: Jason Wang <jasowang@redhat.com>
> > > Cc: Eli Cohen <elic@nvidia.com>; Michael S. Tsirkin <mst@redhat.com>; virtualization <virtualization@lists.linux-foundation.org>; linux-
> > > kernel <linux-kernel@vger.kernel.org>
> > > Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
> > >
> > > On Thu, 24 Mar 2022 16:20:34 +0800 Jason Wang wrote:
> > > > On Thu, Mar 24, 2022 at 2:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > On Thu, Mar 24, 2022 at 02:04:19PM +0800, Hillf Danton wrote:
> > > > > > On Thu, 24 Mar 2022 10:34:09 +0800 Jason Wang wrote:
> > > > > > > On Thu, Mar 24, 2022 at 8:54 AM Hillf Danton <hdanton@sina.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, 22 Mar 2022 09:59:14 +0800 Jason Wang wrote:
> > > > > > > > >
> > > > > > > > > Yes, there will be no "infinite" loop, but since the loop is triggered
> > > > > > > > > by userspace. It looks to me it will delay the flush/drain of the
> > > > > > > > > workqueue forever which is still suboptimal.
> > > > > > > >
> > > > > > > > Usually it is barely possible to shoot two birds using a stone.
> > > > > > > >
> > > > > > > > Given the "forever", I am inclined to not running faster, hehe, though
> > > > > > > > another cobble is to add another line in the loop checking if mvdev is
> > > > > > > > unregistered, and for example make mvdev->cvq unready before destroying
> > > > > > > > workqueue.
> > > > > > > >
> > > > > > > > static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *dev)
> > > > > > > > {
> > > > > > > >         struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
> > > > > > > >         struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
> > > > > > > >         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > > > > >
> > > > > > > >         mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> > > > > > > >         destroy_workqueue(mvdev->wq);
> > > > > > > >         _vdpa_unregister_device(dev);
> > > > > > > >         mgtdev->ndev = NULL;
> > > > > > > > }
> > > > > > > >
> > > > > > >
> > > > > > > Yes, so we had
> > > > > > >
> > > > > > > 1) using a quota for re-requeue
> > > > > > > 2) using something like
> > > > > > >
> > > > > > > while (READ_ONCE(cvq->ready)) {
> > > > > > >         ...
> > > > > > >         cond_resched();
> > > > > > > }
> > > > > > >
> > > > > > > There should not be too much difference except we need to use
> > > > > > > cancel_work_sync() instead of flush_work for 1).
> > > > > > >
> > > > > > > I would keep the code as is but if you stick I can change.
> > > > > >
> > > > > > No Sir I would not - I am simply not a fan of work requeue.
> > > > > >
> > > > > > Hillf
> > > > >
> > > > > I think I agree - requeue adds latency spikes under heavy load -
> > > > > unfortunately, not measured by netperf but still important
> > > > > for latency sensitive workloads. Checking a flag is cheaper.
> > > >
> > > > Just spot another possible issue.
> > > >
> > > > The workqueue will be used by another work to update the carrier
> > > > (event_handler()). Using cond_resched() may still have unfair issue
> > > > which blocks the carrier update for infinite time,
> > >
> > > Then would you please specify the reason why mvdev->wq is single
> > > threaded?
> 
> I didn't see a reason why it needs to be a single threaded (ordered).
> 
> > Given requeue, the serialization of the two works is not
> > > strong. Otherwise unbound WQ that can process works in parallel is
> > > a cure to the unfairness above.
> 
> Yes, and we probably don't want a per device workqueue but a per
> module one. Or simply use the system_wq one.
> 
> > >
> >
> > I think the proposed patch can still be used with quota equal to one.
> > That would guarantee fairness.
> > This is not performance critical and a single workqueue should be enough.
> 
> Yes, but both Hillf and Michael don't like requeuing. So my plan is
> 
> 1) send patch 2 first since it's a hard requirement for the next RHEL release
> 2) a series to fix this hogging issue by
> 2.1) switch to use a per module workqueue
> 2.2) READ_ONCE(cvq->ready) + cond_resched()
> 
> Thanks

Actually if we don't care about speed here then requeing with quota of 1
is fine, in that we don't have a quota at all, we just always requeue
instead of a loop.

It's the mix of requeue and a loop that I consider confusing.


> >
> > > Thanks
> > > Hillf
> >

