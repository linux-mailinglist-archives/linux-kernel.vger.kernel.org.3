Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3DE4EE7CE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 07:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245116AbiDAFf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 01:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbiDAFfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 01:35:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 357EC1A7777
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 22:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648791244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ZrEiqd3tAJKBaALKs2s4EScbWvKu6clAxdnZGsMzbU=;
        b=L0F6mP60j2o8spZTsjXOYPr01NxAsWRNd1dFMRxsEbwP1ddYHtfIC/Qi72n9LV4zmxjf8R
        glLs352rrjjRkNy3QEDSp+F3oBT1XI6gmBbsWm/ZGZYqOLBj8hq+IVqf52tlz3za0MAsOp
        KQoh4w+KPS6gagZgahJcMj6T4mfqa5E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-TG_Vr5jIN1e0OYOGnsawcg-1; Fri, 01 Apr 2022 01:34:03 -0400
X-MC-Unique: TG_Vr5jIN1e0OYOGnsawcg-1
Received: by mail-ej1-f71.google.com with SMTP id x2-20020a1709065ac200b006d9b316257fso955772ejs.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 22:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7ZrEiqd3tAJKBaALKs2s4EScbWvKu6clAxdnZGsMzbU=;
        b=1PwIiyv/Ik6scQL7RVhdiC5cZ7DvPcHolPvdbRk5FeA0l1LdQqLTlRv5pY5ddUDE4e
         QvXC40zHKi6bmahro/R0TraDQzXJCdxWisZWT6g7OLCZcLRdSVNy+d6Ssjny+Xhg3A7q
         SOf87dhDB/O1EpUy+spNZTiQhWVkB+bFJFAv0+srwc0jE/7xp4PjiQqvggLJK2Cq8lO3
         r5IwGZz8w25kCEfsA8H6KQVC4imkgz0jpTleLdXLGO6Bo3w39HRax8WeJCLwlO59Emlb
         u2JQ3SOpSRJh/A6/IwmMKOKNZ0h7+jblSRTiBi7/lcymhnNyP6/fkt/Fow0vWHUlBUMj
         +PhQ==
X-Gm-Message-State: AOAM530RncFBO/77cLzbw5p2w0tpnXldTtesv1TJmjOaE/49ZRIszREJ
        igIBrKHMvLQSRYvGSz4YiX7XG4iuTg2dFkQcfjXGQ4tFW8mDXMU6qUqYEIyTOFKt0UN0yROqCgk
        5ZN2/YwzbfuUN1jeuuor573ay
X-Received: by 2002:a17:907:8a1a:b0:6df:db53:3489 with SMTP id sc26-20020a1709078a1a00b006dfdb533489mr7840520ejc.674.1648791241854;
        Thu, 31 Mar 2022 22:34:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwL9FUIiLoJgbgAXsBqiv0HrM3bhlP2ngYVXXxPfqpMZMvjDguEiqCSdc+dD0hCLhOU6LH2EA==
X-Received: by 2002:a17:907:8a1a:b0:6df:db53:3489 with SMTP id sc26-20020a1709078a1a00b006dfdb533489mr7840506ejc.674.1648791241608;
        Thu, 31 Mar 2022 22:34:01 -0700 (PDT)
Received: from redhat.com ([2.55.151.201])
        by smtp.gmail.com with ESMTPSA id d4-20020a056402000400b00412d60fee38sm713274edu.11.2022.03.31.22.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 22:34:00 -0700 (PDT)
Date:   Fri, 1 Apr 2022 01:33:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
Cc:     Yao Hongbo <yaohongbo@linux.alibaba.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        alikernel-developer@linux.alibaba.com, gang.cao@intel.com
Subject: Re: [PATCH RESEND] uio/uio_pci_generic: Introduce refcnt on
 open/release
Message-ID: <20220401013248-mutt-send-email-mst@kernel.org>
References: <1648693432-129409-1-git-send-email-yaohongbo@linux.alibaba.com>
 <20220331162952-mutt-send-email-mst@kernel.org>
 <eb284c91-dbcf-d034-dce7-6eedaa055552@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb284c91-dbcf-d034-dce7-6eedaa055552@linux.alibaba.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 11:26:25AM +0800, guanghui.fgh wrote:
> 
> 在 2022/4/1 4:30, Michael S. Tsirkin 写道:
> > On Thu, Mar 31, 2022 at 10:23:52AM +0800, Yao Hongbo wrote:
> > > If two userspace programs both open the PCI UIO fd, when one
> > > of the program exits uncleanly, the other will cause IO hang
> > > due to bus-mastering disabled.
> > With two programs poking at the same device, how is this ever
> > supposed to work even while both are alive?
> 
> When using dpdk/spdk, there may be one primary process with multiple
> secondary processes while they can use same virtual address to access
> the same hugepage memory and device BAR(the primary process mmap hugepge
> and device BAR, record the relation between virtual and physical address,
> then the multi secondary processes will do the MAP_FIXED mmap). With this
> method, we can solve many troublesome problems. So there may be many
> processes own the same deivce at the same time.
> 
> The SPDK links:
> https://spdk.io/doc/app_overview.html
> 
> "Multi process mode
> When --shm-id is specified, the application is started in multi-process
> mode.
> 
> Applications using the same shm-id share their memory and NVMe devices.
> 
> The first app to start with a given id becomes a primary process, with the
> rest,
> 
> called secondary processes, only attaching to it. When the primary process
> exits,
> 
> the secondary ones continue to operate, but no new processes can be attached
> 
> at this point. All processes within the same shm-id group must use the same
> --single-file-segments setting."
> 
> > > It's a common usage for spdk/dpdk to use UIO. So, introduce refcnt
> > > to avoid such problems.
> > > 
> > > Fixes: 865a11f("uio/uio_pci_generic: Disable bus-mastering on release")
> > > Reported-by: Xiu Yang <yangxiu.yx@alibaba-inc.com>
> > > Signed-off-by: Yao Hongbo <yaohongbo@linux.alibaba.com>
> > > ---
> > >   drivers/uio/uio_pci_generic.c | 16 +++++++++++++++-
> > >   1 file changed, 15 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/uio/uio_pci_generic.c b/drivers/uio/uio_pci_generic.c
> > > index e03f9b5..8add2cf 100644
> > > --- a/drivers/uio/uio_pci_generic.c
> > > +++ b/drivers/uio/uio_pci_generic.c
> > > @@ -31,6 +31,7 @@
> > >   struct uio_pci_generic_dev {
> > >   	struct uio_info info;
> > >   	struct pci_dev *pdev;
> > > +	atomic_t refcnt;
> > >   };
> > >   static inline struct uio_pci_generic_dev *
> > > @@ -39,6 +40,14 @@ struct uio_pci_generic_dev {
> > >   	return container_of(info, struct uio_pci_generic_dev, info);
> > >   }
> > > +static int open(struct uio_info *info, struct inode *inode)
> > > +{
> > > +	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
> > > +
> > > +	atomic_inc(&gdev->refcnt);
> > > +	return 0;
> > > +}
> > > +
> > >   static int release(struct uio_info *info, struct inode *inode)
> > >   {
> > >   	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
> > > @@ -51,7 +60,9 @@ static int release(struct uio_info *info, struct inode *inode)
> > >   	 * Note that there's a non-zero chance doing this will wedge the device
> > >   	 * at least until reset.
> > >   	 */
> > > -	pci_clear_master(gdev->pdev);
> > > +	if (atomic_dec_and_test(&gdev->refcnt))
> > > +		pci_clear_master(gdev->pdev);
> > > +
> > >   	return 0;
> > >   }
> > > @@ -92,8 +103,11 @@ static int probe(struct pci_dev *pdev,
> > >   	gdev->info.name = "uio_pci_generic";
> > >   	gdev->info.version = DRIVER_VERSION;
> > > +	gdev->info.open = open;
> > >   	gdev->info.release = release;
> > >   	gdev->pdev = pdev;
> > > +	atomic_set(&gdev->refcnt, 0);
> > > +
> > >   	if (pdev->irq && (pdev->irq != IRQ_NOTCONNECTED)) {
> > >   		gdev->info.irq = pdev->irq;
> > >   		gdev->info.irq_flags = IRQF_SHARED;

I think we should use something like kref or refcount, and
think hard about handling the overflow here.


> > > -- 
> > > 1.8.3.1

