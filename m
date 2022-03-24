Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A904A4E5E95
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 07:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348123AbiCXGSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 02:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237823AbiCXGSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 02:18:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9AE696818
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 23:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648102636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=53m2WvLnFOrK1vOidSiYVGB20NoBpxGzjS+etvQOv60=;
        b=d1yqbRI8QKXz2bZWXUrpfnPEa/gRLUpgUS4CzcBCbQnmRUNsSk1G0Cf/LN1sJPUPss9/FD
        6D/p5ehre6vSTyqYFI/c1TmKheW3ZZ4MJu0rfJuTYNE/3ew82DbjX0ITgcDYEgDBHNJS91
        hmv4y8SFObBsbIkUtlFV3X0ZIgaWknM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-XRJaDjU9O0qMertjiLO04Q-1; Thu, 24 Mar 2022 02:17:12 -0400
X-MC-Unique: XRJaDjU9O0qMertjiLO04Q-1
Received: by mail-wr1-f69.google.com with SMTP id p9-20020adf9589000000b001e333885ac1so1319245wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 23:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=53m2WvLnFOrK1vOidSiYVGB20NoBpxGzjS+etvQOv60=;
        b=2MmHWm8rlFeGNlSfOKMkzsacry9KE15VrGTU85yZjcSeRVaUnr2jOf+xpEpcTITExl
         pNnAhfVk/ctUZECO7N5enxttcwpulzbArRWeOc0msOW+othXi5l+mC+FnWbtFAGiv3yD
         18+POluTArpNAncLg3YTXTGROhcHpV9AVANTTL1x8UlLFM0G5WuKBidsdCRBLzbrKqgS
         2/ZfZAy36JmTSAFZBC3OGkIFbOxC+D4VR/1IZvHNRt6E3JyyyHYAp5UoZNuZSnmVKua3
         ACR8AzXlesOW+maKFZcjjdZxXC4/dDHwhWC4AWF0OZHJPhK+FYZxxMh2Uex3xKpJBA8k
         PEhQ==
X-Gm-Message-State: AOAM5317iJRQq6DgGS9TxDB1L0hrgyKgtbSEcQ1RMS9x2qyn+WTHSmiq
        CGDXytnicx01mCAPfCVCtE7O2X65TnGqIhsqneW9Ea55RbeuoE8SAoT4OofGpDc2GOS+IJV0i06
        gdpIteAApFd5qNIzoSrBxBS8s
X-Received: by 2002:a7b:c74c:0:b0:38c:7645:9896 with SMTP id w12-20020a7bc74c000000b0038c76459896mr3188751wmk.83.1648102631081;
        Wed, 23 Mar 2022 23:17:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNpbpIY6OFcNpNhBfa3hiIGIN9fKrPWqwXIYUh7bV8cTPJDX41Bs0bYRwnNyk/WLWFPbVQhg==
X-Received: by 2002:a7b:c74c:0:b0:38c:7645:9896 with SMTP id w12-20020a7bc74c000000b0038c76459896mr3188730wmk.83.1648102630825;
        Wed, 23 Mar 2022 23:17:10 -0700 (PDT)
Received: from redhat.com ([2.55.151.118])
        by smtp.gmail.com with ESMTPSA id m41-20020a05600c3b2900b0038cd120f9c9sm510521wms.0.2022.03.23.23.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 23:17:09 -0700 (PDT)
Date:   Thu, 24 Mar 2022 02:17:06 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
Message-ID: <20220324021428-mutt-send-email-mst@kernel.org>
References: <20220321060429.10457-1-jasowang@redhat.com>
 <20220321085317.3148-1-hdanton@sina.com>
 <CACGkMEvF80FuU0uD+RZMOrySQ0K2RZVh7Pmn4UhNtz_Exs3c2w@mail.gmail.com>
 <CACGkMEvLqox3QZxpxeQdrjBnM6zRr_wGfddoN45RUSsZEOe=bQ@mail.gmail.com>
 <20220321123420.3207-1-hdanton@sina.com>
 <CACGkMEt-PRCsBQ+EJVGeWGikJfLk-0M1dRPMqnp9YC5R4HYAjQ@mail.gmail.com>
 <20220324005345.3623-1-hdanton@sina.com>
 <20220324060419.3682-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324060419.3682-1-hdanton@sina.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 02:04:19PM +0800, Hillf Danton wrote:
> On Thu, 24 Mar 2022 10:34:09 +0800 Jason Wang wrote:
> > On Thu, Mar 24, 2022 at 8:54 AM Hillf Danton <hdanton@sina.com> wrote:
> > >
> > > On Tue, 22 Mar 2022 09:59:14 +0800 Jason Wang wrote:
> > > >
> > > > Yes, there will be no "infinite" loop, but since the loop is triggered
> > > > by userspace. It looks to me it will delay the flush/drain of the
> > > > workqueue forever which is still suboptimal.
> > >
> > > Usually it is barely possible to shoot two birds using a stone.
> > >
> > > Given the "forever", I am inclined to not running faster, hehe, though
> > > another cobble is to add another line in the loop checking if mvdev is
> > > unregistered, and for example make mvdev->cvq unready before destroying
> > > workqueue.
> > >
> > > static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *dev)
> > > {
> > >         struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
> > >         struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
> > >         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > >
> > >         mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> > >         destroy_workqueue(mvdev->wq);
> > >         _vdpa_unregister_device(dev);
> > >         mgtdev->ndev = NULL;
> > > }
> > >
> > 
> > Yes, so we had
> > 
> > 1) using a quota for re-requeue
> > 2) using something like
> > 
> > while (READ_ONCE(cvq->ready)) {
> >         ...
> >         cond_resched();
> > }
> > 
> > There should not be too much difference except we need to use
> > cancel_work_sync() instead of flush_work for 1).
> > 
> > I would keep the code as is but if you stick I can change.
> 
> No Sir I would not - I am simply not a fan of work requeue.
> 
> Hillf

I think I agree - requeue adds latency spikes under heavy load -
unfortunately, not measured by netperf but still important
for latency sensitive workloads. Checking a flag is cheaper.

-- 
MST

