Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694915A1C71
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiHYWcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbiHYWcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7385B941E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661466763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oy2aubXb5hLNj8VJ/ILuyIzESlVY8G+jddCf/KXjxGU=;
        b=IL1R783ivUVb0Ucqh0UsRmD9t0HW5aENVgfYzR+yt7zElUtHU5e0/KI8Agsv06b+2LXRy1
        riMq3fO+I8ovsh+TUnJdH7coZO/GkoO2R/xXL4KH5ecYh3HCqRU66OLoJ9NOXguNEXjdtW
        X0Sx6Hpp6TFku6dmTLaRk6xiyhaDPSM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-628-Ko_3sHnRMsC0CMh41k7E8A-1; Thu, 25 Aug 2022 18:32:42 -0400
X-MC-Unique: Ko_3sHnRMsC0CMh41k7E8A-1
Received: by mail-io1-f71.google.com with SMTP id b16-20020a5d8950000000b006891a850acfso11919039iot.19
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc;
        bh=Oy2aubXb5hLNj8VJ/ILuyIzESlVY8G+jddCf/KXjxGU=;
        b=wPr9DNS7BZ6dTAoULZ6MgJX118G6y8HyBC8giDskxEal/1FBca3CatPN6EprSkdu+d
         UYK4Y7l0bqGsfOs9Wx78gTyt2GsHhCDGq6X1BqaXjX0J6j/2I8Atm/Hbh1a7jtkfwVeR
         CNW2II05YZBc3C2XqLufmDnqJJnNDENrLTmAO8ETI+ncESLAAIALeFwB4ycyuuwi+VyV
         tjHt/Q47GuNDISk+IpXD3upQTmw+U8S8gOqMmYc/zQGEjIorAb2+FVyfV7slFD3xkKlW
         k5x6W5YqKaWkDSaP2Abc27ZOY7jSqRmmlKhQ0V414uaN6xyevUul0T4PmWe2Ho8NGZyn
         y6zA==
X-Gm-Message-State: ACgBeo1whAeBo9xepMzhk/AXC1F/6JlWXcIZGx9sHS6uYGnr/1a/xRPd
        xzjmAxTWi+OSc6edqo31gv9jELkqK8BPW+q1JEbBLsKhMOIrC9K/xNjC86MMTlvzKV4HvFITaHE
        +icSQwEJevybFVTT75dG/m8i0
X-Received: by 2002:a02:1d09:0:b0:33b:a8cc:17d3 with SMTP id 9-20020a021d09000000b0033ba8cc17d3mr2742327jaj.25.1661466762088;
        Thu, 25 Aug 2022 15:32:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5DxfwLwJkfemFe6fofZO7Sa2Jt0xLr+PHGNw1XLZEm3kULrHFXM6KOQKsSVRF5mDTKeRkUZg==
X-Received: by 2002:a02:1d09:0:b0:33b:a8cc:17d3 with SMTP id 9-20020a021d09000000b0033ba8cc17d3mr2742320jaj.25.1661466761898;
        Thu, 25 Aug 2022 15:32:41 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id t14-20020a056e02010e00b002e93764c9e3sm278115ilm.54.2022.08.25.15.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 15:32:41 -0700 (PDT)
Date:   Thu, 25 Aug 2022 16:32:40 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Abhishek Sahu <abhsahu@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Kevin Tian <kevin.tian@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 5/5] vfio/pci: Implement
 VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY_WITH_WAKEUP
Message-ID: <20220825163240.274950c8.alex.williamson@redhat.com>
In-Reply-To: <62e6d510-8e7c-8a31-fb7f-905bb13afe67@nvidia.com>
References: <20220817051323.20091-1-abhsahu@nvidia.com>
        <20220817051323.20091-6-abhsahu@nvidia.com>
        <Yvzy0VOfKkKod0OV@nvidia.com>
        <5363303b-30bb-3c4a-bf42-426dd7f8138d@nvidia.com>
        <Yv0oH23UYbI/LI+X@nvidia.com>
        <62e6d510-8e7c-8a31-fb7f-905bb13afe67@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 22:31:03 +0530
Abhishek Sahu <abhsahu@nvidia.com> wrote:

> On 8/17/2022 11:10 PM, Jason Gunthorpe wrote:
> > On Wed, Aug 17, 2022 at 09:34:30PM +0530, Abhishek Sahu wrote:  
> >> On 8/17/2022 7:23 PM, Jason Gunthorpe wrote:  
> >>> On Wed, Aug 17, 2022 at 10:43:23AM +0530, Abhishek Sahu wrote:
> >>>  
> >>>> +static int
> >>>> +vfio_pci_core_pm_entry_with_wakeup(struct vfio_device *device, u32 flags,
> >>>> +				   void __user *arg, size_t argsz)  
> >>>
> >>> This should be
> >>>   struct vfio_device_low_power_entry_with_wakeup __user *arg
> >>>  
> >>
> >>  Thanks Jason.
> >>
> >>  I can update this.
> >>
> >>  But if we look the existing code, for example
> >>  (vfio_ioctl_device_feature_mig_device_state()), then there it still uses
> >>  'void __user *arg' only. Is this a new guideline which we need to take
> >>  care ?  
> > 
> > I just sent a patch that fixes that too
> >   
> 
>  Thanks for the update.
>  I will change this. 
> 
> >>  Do we need to keep the IOCTL name alphabetically sorted in the case list.
> >>  Currently, I have added in the order of IOCTL numbers.  
> > 
> > It is generally a good practice to sort lists of things.
> > 
> > Jason  
> 
>  Sure. I will make the sorted list.

The series looks good to me, so I'd suggest to rebase on Jason's
patches[1][2] so you can easily sort out the above.  Thanks,

Alex

[1]https://lore.kernel.org/all/0-v1-da6fc51ee22e+562-vfio_pci_priv_jgg@nvidia.com/
[2]https://lore.kernel.org/all/0-v1-11d8272dc65a+4bd-vfio_ioctl_split_jgg@nvidia.com/

