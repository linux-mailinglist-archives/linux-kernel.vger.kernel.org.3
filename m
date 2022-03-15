Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049DE4D9FE8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350018AbiCOQXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239900AbiCOQXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B512056743
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647361325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPCxMOruGP4ECg9p3MjkBdYqTpnkjCbZPqgHjAnjze0=;
        b=PLsiNrFto2tQBPwikAoazl8lWrTtM5z1cXB+lQtsueFcqBxUwPXcYSZOJJZNgJRbLNr40K
        CWX0m+CufLXz4tDYInqfTBLtxbYt2qfFYk3lkel3D3N/y6ec3PGsr/y4gyjPnfm6DRkAYr
        KTPS9xjrYctiW50I8VSjSQc2eRMPVaA=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-kX5gxdXSPbKtbIGU-ZEBMA-1; Tue, 15 Mar 2022 12:22:04 -0400
X-MC-Unique: kX5gxdXSPbKtbIGU-ZEBMA-1
Received: by mail-il1-f200.google.com with SMTP id b7-20020a056e020c8700b002c7c2711fa1so927109ile.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=EPCxMOruGP4ECg9p3MjkBdYqTpnkjCbZPqgHjAnjze0=;
        b=XAREoRfH2+TExdyfnbgQGNVQR+UCZz+zFmyJxleFKJPH8ZoyP0g8SpButFQe67lJPi
         RHYRYj+0eqwviKXJ1P1oeYk1fdty7cIubmGvq2tv4ZUBJibN9gNE9mmqqz2JM09HJOTm
         yOkSTCAbJPwb3Cyl+nkScZXf1fLAbRnyf+OoHIIrHgsnOGBnq+/nGppbGQPzvd5xfD40
         pWF9yS5HTMM7513SZShvJNUjlsolLrbR6RIn+I2YQpIK/7ms3Mm3l9W6uiRzo6rflnjd
         Lx82GprKwECYLSlKhp78dk8D480kbe7mBwVc5ewxQgnZzITYJno160nUBe/O14dlWqCZ
         4fRg==
X-Gm-Message-State: AOAM531SZi3FDEYBbe4N+qUzgyDV+buxOsZaJv7NCI3Bw+YRH0fR2oSI
        LZk/CLxEsLHCiQrQgvOZ591p52pnSPvD/qEjfWX6lUX4h+XkUr+ehwO5FW6DscdhajpoYiW1G+1
        2G02bFNiNihv65ZT0NIy099AY
X-Received: by 2002:a05:6602:3c5:b0:613:8644:591c with SMTP id g5-20020a05660203c500b006138644591cmr22941613iov.161.1647361323356;
        Tue, 15 Mar 2022 09:22:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6rk4BbKzeOLEUR+UXUmdhhJiZZFfUw0L0hpIM8fKgHXE7IUVbAFDE8s/iV9SZ6Qqtf5DcWw==
X-Received: by 2002:a05:6602:3c5:b0:613:8644:591c with SMTP id g5-20020a05660203c500b006138644591cmr22941597iov.161.1647361323164;
        Tue, 15 Mar 2022 09:22:03 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id k1-20020a056e021a8100b002c64cf94399sm11683708ilv.44.2022.03.15.09.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 09:22:02 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:22:00 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, shameerali.kolothum.thodi@huawei.com,
        kevin.tian@intel.com, yishaih@nvidia.com,
        linux-doc@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH v3] vfio-pci: Provide reviewers and acceptance criteria
 for vendor drivers
Message-ID: <20220315102200.15a86b16.alex.williamson@redhat.com>
In-Reply-To: <20220315155304.GC11336@nvidia.com>
References: <164728932975.54581.1235687116658126625.stgit@omen>
        <87a6drh8hy.fsf@redhat.com>
        <20220315155304.GC11336@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 12:53:04 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Mar 15, 2022 at 10:26:17AM +0100, Cornelia Huck wrote:
> > On Mon, Mar 14 2022, Alex Williamson <alex.williamson@redhat.com> wrote:
> >   
> > > Vendor or device specific extensions for devices exposed to userspace
> > > through the vfio-pci-core library open both new functionality and new
> > > risks.  Here we attempt to provided formalized requirements and
> > > expectations to ensure that future drivers both collaborate in their
> > > interaction with existing host drivers, as well as receive additional
> > > reviews from community members with experience in this area.
> > >
> > > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > > Cc: Yishai Hadas <yishaih@nvidia.com>
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > Acked-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>  
> > 
> > (...)
> >   
> > > diff --git a/Documentation/driver-api/vfio-pci-vendor-driver-acceptance.rst b/Documentation/driver-api/vfio-pci-vendor-driver-acceptance.rst
> > > new file mode 100644
> > > index 000000000000..3a108d748681
> > > +++ b/Documentation/driver-api/vfio-pci-vendor-driver-acceptance.rst  
> > 
> > What about Christoph's request to drop the "vendor" name?
> > vfio-pci-device-specific-driver-acceptance.rst would match the actual
> > title of the document, and the only drawback I see is that it is a bit
> > longer.  
> 
> I agree we should not use the vendor name
> 
> In general I wonder if this is a bit too specific to PCI, really this
> is just review criteria for any driver making a struct vfio_device_ops
> implementation, and we have some specific guidance for migration here
> as well.
> 
> Like if IBM makes s390 migration drivers all of this applies just as
> well even though they are not PCI.

Are you volunteering to be a reviewer under drivers/vfio/?  Careful,
I'll add you ;)

What you're saying is true of course and it could be argued that this
sort of criteria is true for any new driver, I think the unique thing
here that raises it to a point where we want to formalize the breadth
of reviews is how significantly lower the bar is to create a device
specific driver now that we have a vfio-pci-core library.  Shameer's
stub driver is 100 LoC.  I also expect that the pool of people willing
to volunteer to be reviewers for PCI related device specific drivers is
large than we might see for arbitrary drivers.

> > > +New driver submissions are therefore requested to have approval via
> > > +Sign-off/Acked-by/etc for any interactions with parent drivers.  
> > 
> > s/Sign-off/Reviewed-by/ ?
> > 
> > I would not generally expect the reviewers listed to sign off on other
> > people's patches.  
> 
> It happens quite a lot when those people help write the patches too :)

This is what "etc" is for, the owners are involved and have endorsed it
in some way, that's all we care about.  Thanks,

Alex

