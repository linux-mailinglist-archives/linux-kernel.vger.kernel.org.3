Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01C6558B82
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 01:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiFWXA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 19:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiFWXA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 19:00:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E555B5D122
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656025253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K2a+ZoO+OyFnk1IwsI6/2cGromoSIiCUd/MQu22EaXU=;
        b=JakHaCEIUbYZNxBJ2rHX25ShyxlLXkZGEbEwx2VcEob0CPXoDXHLsQZnjd9IgFNeB20OVE
        GjjthNd3e5TH0s4aqnp92cTCifWuSsG0P8h/a+YCAER4fyf4wkYnz7Bnor1ATXHYKA2krf
        xKl4eoS87DWmyksZC6uhz0LanFHVGXI=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-3ljQnbYMO96K6Jm5LKxlzA-1; Thu, 23 Jun 2022 19:00:48 -0400
X-MC-Unique: 3ljQnbYMO96K6Jm5LKxlzA-1
Received: by mail-io1-f70.google.com with SMTP id n85-20020a6b8b58000000b00672792497b8so450287iod.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K2a+ZoO+OyFnk1IwsI6/2cGromoSIiCUd/MQu22EaXU=;
        b=yWQrWUpXEFVwsRpoxWZPQjuskWpEU0XUQJ+zGdW6xj65UhYlq9P0W+y/QvQHHw5Owt
         Av4RFsDPzdcrAekFVFLbCl5aUC7ZSnM56TpIRTpwwCj6zjxypUIFLMF+C6h2LyjwEt6n
         VY4sSACdkHCWe34fHp1C5yC1A1b2u3AvvejyWBNBHHIC5LevgUDzt39aD0Y1SHo8Asdj
         6Wxb0lgZi0dk3KgwGCduwZ7YC8XA5Y5QLBW4NHADb7OgKcAUi1KRszCG8uogI0NAkiv4
         K0SOC6XznyFYFd309SibE185vD+isgjZRrvQRCIwRkAT4BsHsIL46JqXQX5P4apP4SnW
         h6Ag==
X-Gm-Message-State: AJIora+x8RfOCfYSuyjS8b7Ko5uEJ7BHiroMGR0ilJHnUt6zuAnFqrvh
        3SchduK8KAbwwzYbmF/p+3XvqZW6PuVqjTCLMZaXq+c4sGaoB/C8V64c+Gk5v1TkeScGQ96KVyi
        BNjTbTVK1rEBn59FfLqQKJRB2
X-Received: by 2002:a05:6602:3311:b0:669:d9d7:1026 with SMTP id b17-20020a056602331100b00669d9d71026mr5845181ioz.3.1656025247390;
        Thu, 23 Jun 2022 16:00:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s4e7FapPhiWbwyg7k9pxgE/9jBqkSjaoFx8Qxcthe61Ap3+36D6aUVxzWKfQ185aqMc4RTqg==
X-Received: by 2002:a05:6602:3311:b0:669:d9d7:1026 with SMTP id b17-20020a056602331100b00669d9d71026mr5845165ioz.3.1656025247044;
        Thu, 23 Jun 2022 16:00:47 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id f63-20020a0284c5000000b00339c2c0d123sm300924jai.116.2022.06.23.16.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 16:00:46 -0700 (PDT)
Date:   Thu, 23 Jun 2022 17:00:44 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     cohuck@redhat.com, jgg@nvidia.com, iommu@lists.linux.dev,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] vfio/type1: Simplify bus_type determination
Message-ID: <20220623170044.1757267d.alex.williamson@redhat.com>
In-Reply-To: <68263bd7-4528-7acb-b11f-6b1c6c8c72ef@arm.com>
References: <b1d13cade281a7d8acbfd0f6a33dcd086207952c.1655898523.git.robin.murphy@arm.com>
        <20220622161721.469fc9eb.alex.williamson@redhat.com>
        <68263bd7-4528-7acb-b11f-6b1c6c8c72ef@arm.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 13:23:05 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2022-06-22 23:17, Alex Williamson wrote:
> > On Wed, 22 Jun 2022 13:04:11 +0100
> > Robin Murphy <robin.murphy@arm.com> wrote:
> >   
> >> Since IOMMU groups are mandatory for drivers to support, it stands to
> >> reason that any device which has been successfully be added to a group  
> > 
> > s/be //  
> 
> Oops.
> 
> >> must be on a bus supported by that IOMMU driver, and therefore a domain
> >> viable for any device in the group must be viable for all devices in
> >> the group. This already has to be the case for the IOMMU API's internal
> >> default domain, for instance. Thus even if the group contains devices on
> >> different buses, that can only mean that the IOMMU driver actually
> >> supports such an odd topology, and so without loss of generality we can
> >> expect the bus type of any device in a group to be suitable for IOMMU
> >> API calls.
> >>
> >> Replace vfio_bus_type() with a simple call to resolve an appropriate
> >> member device from which to then derive a bus type. This is also a step
> >> towards removing the vague bus-based interfaces from the IOMMU API, when
> >> we can subsequently switch to using this device directly.
> >>
> >> Furthermore, scrutiny reveals a lack of protection for the bus being
> >> removed while vfio_iommu_type1_attach_group() is using it; the reference
> >> that VFIO holds on the iommu_group ensures that data remains valid, but
> >> does not prevent the group's membership changing underfoot. Holding the
> >> vfio_device for as long as we need here also neatly solves this.
> >>
> >> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >> ---
> >>
> >> After sleeping on it, I decided to type up the helper function approach
> >> to see how it looked in practice, and in doing so realised that with one
> >> more tweak it could also subsume the locking out of the common paths as
> >> well, so end up being a self-contained way for type1 to take care of its
> >> own concern, which I rather like.
> >>
> >>   drivers/vfio/vfio.c             | 18 +++++++++++++++++-
> >>   drivers/vfio/vfio.h             |  3 +++
> >>   drivers/vfio/vfio_iommu_type1.c | 30 +++++++++++-------------------
> >>   3 files changed, 31 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> >> index 61e71c1154be..73bab04880d0 100644
> >> --- a/drivers/vfio/vfio.c
> >> +++ b/drivers/vfio/vfio.c
> >> @@ -448,7 +448,7 @@ static void vfio_group_get(struct vfio_group *group)
> >>    * Device objects - create, release, get, put, search
> >>    */
> >>   /* Device reference always implies a group reference */
> >> -static void vfio_device_put(struct vfio_device *device)
> >> +void vfio_device_put(struct vfio_device *device)
> >>   {
> >>   	if (refcount_dec_and_test(&device->refcount))
> >>   		complete(&device->comp);
> >> @@ -475,6 +475,22 @@ static struct vfio_device *vfio_group_get_device(struct vfio_group *group,
> >>   	return NULL;
> >>   }
> >>   
> >> +struct vfio_device *vfio_device_get_from_iommu(struct iommu_group *iommu_group)
> >> +{
> >> +	struct vfio_group *group = vfio_group_get_from_iommu(iommu_group);
> >> +	struct vfio_device *device;  
> > 
> > Check group for NULL.  
> 
> OK - FWIW in context this should only ever make sense to call with an 
> iommu_group which has already been derived from a vfio_group, and I did 
> initially consider a check with a WARN_ON(), but then decided that the 
> unguarded dereference would be a sufficiently strong message. No problem 
> with bringing that back to make it more defensive if that's what you prefer.

A while down the road, that's a bit too much implicit knowledge of the
intent and single purpose of this function just to simply avoid a test.

> >> +
> >> +	mutex_lock(&group->device_lock);
> >> +	list_for_each_entry(device, &group->device_list, group_next) {
> >> +		if (vfio_device_try_get(device)) {
> >> +			mutex_unlock(&group->device_lock);
> >> +			return device;
> >> +		}
> >> +	}
> >> +	mutex_unlock(&group->device_lock);
> >> +	return NULL;  
> > 
> > No vfio_group_put() on either path.  
> 
> Oops indeed.
> 
> >> +}
> >> +
> >>   /*
> >>    * VFIO driver API
> >>    */
> >> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> >> index a67130221151..e8f21e64541b 100644
> >> --- a/drivers/vfio/vfio.h
> >> +++ b/drivers/vfio/vfio.h
> >> @@ -70,3 +70,6 @@ struct vfio_iommu_driver_ops {
> >>   
> >>   int vfio_register_iommu_driver(const struct vfio_iommu_driver_ops *ops);
> >>   void vfio_unregister_iommu_driver(const struct vfio_iommu_driver_ops *ops);
> >> +
> >> +struct vfio_device *vfio_device_get_from_iommu(struct iommu_group *iommu_group);
> >> +void vfio_device_put(struct vfio_device *device);
> >> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> >> index c13b9290e357..e38b8bfde677 100644
> >> --- a/drivers/vfio/vfio_iommu_type1.c
> >> +++ b/drivers/vfio/vfio_iommu_type1.c
> >> @@ -1679,18 +1679,6 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
> >>   	return ret;
> >>   }
> >>   
> >> -static int vfio_bus_type(struct device *dev, void *data)
> >> -{
> >> -	struct bus_type **bus = data;
> >> -
> >> -	if (*bus && *bus != dev->bus)
> >> -		return -EINVAL;
> >> -
> >> -	*bus = dev->bus;
> >> -
> >> -	return 0;
> >> -}
> >> -
> >>   static int vfio_iommu_replay(struct vfio_iommu *iommu,
> >>   			     struct vfio_domain *domain)
> >>   {
> >> @@ -2159,7 +2147,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
> >>   	struct vfio_iommu *iommu = iommu_data;
> >>   	struct vfio_iommu_group *group;
> >>   	struct vfio_domain *domain, *d;
> >> -	struct bus_type *bus = NULL;
> >> +	struct vfio_device *iommu_api_dev;
> >>   	bool resv_msi, msi_remap;
> >>   	phys_addr_t resv_msi_base = 0;
> >>   	struct iommu_domain_geometry *geo;
> >> @@ -2192,18 +2180,19 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
> >>   		goto out_unlock;
> >>   	}
> >>   
> >> -	/* Determine bus_type in order to allocate a domain */
> >> -	ret = iommu_group_for_each_dev(iommu_group, &bus, vfio_bus_type);
> >> -	if (ret)
> >> +	/* Resolve the group back to a member device for IOMMU API ops */
> >> +	ret = -ENODEV;
> >> +	iommu_api_dev = vfio_device_get_from_iommu(iommu_group);
> >> +	if (!iommu_api_dev)
> >>   		goto out_free_group;
> >>   
> >>   	ret = -ENOMEM;
> >>   	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> >>   	if (!domain)
> >> -		goto out_free_group;
> >> +		goto out_put_dev;
> >>   
> >>   	ret = -EIO;
> >> -	domain->domain = iommu_domain_alloc(bus);
> >> +	domain->domain = iommu_domain_alloc(iommu_api_dev->dev->bus);  
> > 
> > It makes sense to move away from a bus centric interface to iommu ops
> > and I can see that having a device interface when we have device level
> > address-ability within a group makes sense, but does it make sense to
> > only have that device level interface?  For example, if an iommu_group
> > is going to remain an aspect of the iommu subsystem, shouldn't we be
> > able to allocate a domain and test capabilities based on the group and
> > the iommu driver should have enough embedded information reachable from
> > the struct iommu_group to do those things?  This "perform group level
> > operations based on an arbitrary device in the group" is pretty klunky.  
> 
> The fact* is that devices (and domains) are the fundamental units of the 
> IOMMU API internals, due to what's most practical within the Linux 
> driver model, while groups remain more of a mid-level abstraction - 
> IOMMU drivers themselves are only aware of groups at all in terms of 
> whether they can physically distinguish a given device from others. The 
> client-driver-facing API is already moving back to being device-centric, 
> because that's what fits everyone else's usage models, and we concluded 
> that exposing the complexity of groups everywhere was more trouble than 
> it's worth.
> 
> So yes, technically we could implement an iommu_group_capable() and an 
> iommu_group_domain_alloc(), which would still just internally resolve 
> the IOMMU ops and instance data from a member device to perform the 
> driver-level call, but once again it would be for the benefit of 
> precisely one user. And I really have minimal enthusiasm for diverging 
> any further into one IOMMU API for everyone else plus a separate special 
> IOMMU API for VFIO type1, when type1 is supposed to be the 
> VFIO-to-IOMMU-API translation layer anyway! To look at it another way, 
> if most of the complexity of groups is for VFIO's benefit, then why 
> *shouldn't* VFIO take responsibility for some of the fiddly details that 
> don't matter to anyone else?


Hmm, I agree, but I can't get past vfio-core exporting a function to
select an arbitrary vfio_device from an iommu_group.  What if type1 was
passed an opaque vfio_group pointer and vfio exported a function to
iterate each vfio_device in that vfio_group?  We'd need to export
vfio_device_try_get() and vfio_device_put() and type1 itself would stop
on the first vfio_device object it can get.  Sort of the v1 approach,
but with a vfio iterator rather than iommu.

I'd lean towards Kevin's idea that we could store bus_type on the
vfio_group and pass that to type1, with the same assumptions we're
making in the commit log that it's consistent, but that doesn't get us
closer to the long term plan of dropping the bus_type interfaces AIUI.
Thanks,

Alex

