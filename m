Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52070558A36
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiFWUf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiFWUf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2863460E2D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656016556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jBmUQROEGSBi6KZ4o9E9bBpH1DEN5yNQ4K8Bp+Z/iq4=;
        b=CPzm4RqyO4RL06TxxQKf9e7y7T4S0v1ZjCJwe3FuMIVccdIILiEf4v19uGvtyeV0/5j1xJ
        HVeOUDjgxTz+jFE2JF9KdWosM9+Pv+qZNiF+T4qi5lVqhgGDYG6nqy/ugWzcjzw8aY9Xyl
        wOqFFrpxYWEbyHmjF9pR8q5tKSbPbk8=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-x6QI4IYIOTyssVoNp3rUMw-1; Thu, 23 Jun 2022 16:35:54 -0400
X-MC-Unique: x6QI4IYIOTyssVoNp3rUMw-1
Received: by mail-io1-f71.google.com with SMTP id o11-20020a6bcf0b000000b0067328c4275bso286353ioa.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=jBmUQROEGSBi6KZ4o9E9bBpH1DEN5yNQ4K8Bp+Z/iq4=;
        b=iT9MkKgKi7O4H5VLZcm9I9x5tLjtsj9qKP1VIrIHf7gcBLq2FfBBy5QSe+zOUw67b5
         DOt+3NZKdpjRkCvFIO3Cc99ubBH8XN2rYn0lBiA0tpDePRK6I/Izj9Yjvpm38PxtJGwC
         oHf1R+9DPRU75mKP93Jjgw4S8cmCrzO6QyUynysbtS1rKnROR2vr9YbDO9yqCjdfDPUQ
         AHr3+E47Ypr3Pxh/cFeadqv8eD5BPOign4tk95En/gF7T0QOQCmP5PU1KvGV52t1v8a/
         pkv3cGxMG0GA1zABynXh6jpv8gbRsYdoK/ezLMhLGCepmnjZ+5VF2syNrYT31ffI7VA2
         zLSw==
X-Gm-Message-State: AJIora8LBxst8hxSeYLr82oAiCAiZeRJz07ZLq+hXNk0+Ui4uhHb1Sml
        gaeb/x52k/vJ6NPCcQZFwFh7tk7TU3QIT0ttJVFp8rdU22e6JPks0xAmkotdwUKTHcgH/v3ENfh
        ydMqVKw+DhxqF+pBrFU0yO+Xb
X-Received: by 2002:a02:c503:0:b0:339:ec67:b0a4 with SMTP id s3-20020a02c503000000b00339ec67b0a4mr2600643jam.27.1656016554289;
        Thu, 23 Jun 2022 13:35:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uY4A4ulPkvl+0HkPHVJxiXM5mroTpWUdfuh0+GS53HXI+mhS1f3l3m2WS35NzqHwDBGAYR9g==
X-Received: by 2002:a02:c503:0:b0:339:ec67:b0a4 with SMTP id s3-20020a02c503000000b00339ec67b0a4mr2600627jam.27.1656016553968;
        Thu, 23 Jun 2022 13:35:53 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id w16-20020a02cf90000000b00339c3906b08sm151280jar.177.2022.06.23.13.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 13:35:53 -0700 (PDT)
Date:   Thu, 23 Jun 2022 14:35:52 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] vfio/type1: Simplify bus_type determination
Message-ID: <20220623143552.634779e0.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB5276A79834CCB5954A3025DF8CB59@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <b1d13cade281a7d8acbfd0f6a33dcd086207952c.1655898523.git.robin.murphy@arm.com>
        <20220622161721.469fc9eb.alex.williamson@redhat.com>
        <BN9PR11MB5276A79834CCB5954A3025DF8CB59@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: Red Hat
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

On Thu, 23 Jun 2022 08:46:45 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Thursday, June 23, 2022 6:17 AM
> >   
> > >
> > >  	ret = -EIO;
> > > -	domain->domain = iommu_domain_alloc(bus);
> > > +	domain->domain = iommu_domain_alloc(iommu_api_dev->dev-
> > >bus);  
> > 
> > It makes sense to move away from a bus centric interface to iommu ops
> > and I can see that having a device interface when we have device level
> > address-ability within a group makes sense, but does it make sense to
> > only have that device level interface?  For example, if an iommu_group
> > is going to remain an aspect of the iommu subsystem, shouldn't we be
> > able to allocate a domain and test capabilities based on the group and
> > the iommu driver should have enough embedded information reachable
> > from
> > the struct iommu_group to do those things?  This "perform group level
> > operations based on an arbitrary device in the group" is pretty klunky.
> > Thanks,
> >   
> 
> This sounds a right thing to do.
> 
> btw another alternative which I'm thinking of is whether vfio_group
> can record the bus info when the first device is added to it in
> __vfio_register_dev(). Then we don't need a group interface from
> iommu to test if vfio is the only user having such requirement.

That might be more simple, but it's just another variation on vfio
picking an arbitrary device from a group to satisfy the iommu interface
rather than operating on an iommu subsystem provided object.  Thanks,

Alex

