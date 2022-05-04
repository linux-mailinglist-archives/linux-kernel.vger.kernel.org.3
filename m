Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2081519EF7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349310AbiEDMMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349160AbiEDMMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:12:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6E5C1EAF8
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 05:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651666145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PaKDp0AYChF2TvU0gnmgAfapbqSSfeuarNmx4DaDCMY=;
        b=Fin0CAAMThFakBO72tNJNbMtKS435o4Sjk11NGi++eouVMTL2A8LKdpkM+BjxyXc9IGD/0
        DXFgTryD7HK4slJ1J2wExiSAKlP046yeua26M+Jq0gdgepB13cAmLEw5bHmuAzfviV4yVT
        ckMJChAGnwi0uCZISkOOIR87Uj5Wz+w=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-JWPdbUmDMxWs0ShBRo0ZOg-1; Wed, 04 May 2022 08:09:01 -0400
X-MC-Unique: JWPdbUmDMxWs0ShBRo0ZOg-1
Received: by mail-lf1-f69.google.com with SMTP id bp17-20020a056512159100b00472631eb445so532085lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 05:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PaKDp0AYChF2TvU0gnmgAfapbqSSfeuarNmx4DaDCMY=;
        b=BPjqzXr/kGHj3sxO9N/jl9eFDzjggw9iCVs/sOyCq9p9+htTp2TnWQG9aqtCy8S9+4
         FlB9vxB53ttq8Eu37fdgN+iExUdrG9aQ2dpNA0PyLcbI1FFRWCJJ4OeDUe+5EfnJ/L9H
         PQ2ptLnYeD1TfwaFIOBmlapVP7U3g2AfHKsMVwvhgfkOeCVzzYd72TJvm4uhI8EnQDc9
         c5ishCoYveWG/cmBth3sKXMeaOp+ZISoH5iHdtryfPul6IbP480bAaLTXeHMoYZwCWeI
         5me6TSyGj0F7EjzlhPIrpVG2HrVUL7GV/+PwVxPBytmWh4eOvEk4fgS1WVFq0WtPvK1P
         t2Tg==
X-Gm-Message-State: AOAM530+1u2aXmt1Wam25RofMOQqc0XvOCLUzTkMIJy7xxBDuj89DiuV
        O6Ado+xzbR1JTZqWOhwJpze6cyVyrJdCiegAOWG1/EkkftQrt2RiwnyR+tfaNhZAr2Jdfdie3EK
        XwCFjghvuh4j4eI7xKOh4Ejdzq7aMdbDF71YcvfBy
X-Received: by 2002:a19:640d:0:b0:472:75e:7373 with SMTP id y13-20020a19640d000000b00472075e7373mr13561741lfb.46.1651666139920;
        Wed, 04 May 2022 05:08:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwP4/TVUhuStPAtOdkhRDyMe0PvYAgIbFywWQjkb0/8vXRf7mlfrFI8l+7CxK/ewd/JXpCbla/6BaNya6gu4bQ=
X-Received: by 2002:a19:640d:0:b0:472:75e:7373 with SMTP id
 y13-20020a19640d000000b00472075e7373mr13561730lfb.46.1651666139723; Wed, 04
 May 2022 05:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220216025249.3459465-1-baolu.lu@linux.intel.com>
 <20220216025249.3459465-8-baolu.lu@linux.intel.com> <20220504075356.GA2361844@janakin.usersys.redhat.com>
 <8d6c30e0-dcf7-56f8-c44b-2d8bdb1dc04c@arm.com>
In-Reply-To: <8d6c30e0-dcf7-56f8-c44b-2d8bdb1dc04c@arm.com>
From:   Jan Stancek <jstancek@redhat.com>
Date:   Wed, 4 May 2022 14:08:43 +0200
Message-ID: <CAASaF6zc=6Mxo6uq1m7OMkXGPHmqeb=92uE8uERo9ze-GLndfg@mail.gmail.com>
Subject: Re: [bug] NULL pointer deref after 3f6634d997db ("iommu: Use right
 way to retrieve iommu_ops")
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bruno Goncalves <bgoncalv@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 1:14 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-05-04 08:53, Jan Stancek wrote:
> [...]
> > Hi,
> >
> > I'm getting panics after hunk above was applied in this patch
> > on ppc64le KVM guest, dev->iommu is NULL.
>
> Oof, this can probably be hit with vfio-noiommu too, and by the look of
> things, `echo auto > /sys/kernel/iommu_groups/0/type` would likely blow
> up as well. Does the patch below work for you?

Thanks for quick reply. Yes, it does.

# cat /sys/kernel/iommu_groups/0/reserved_regions
# echo auto > /sys/kernel/iommu_groups/0/type
-bash: echo: write error: Invalid argument

Tested-by: Jan Stancek <jstancek@redhat.com>

>
> Thanks,
> Robin.
>
> ----->8-----
>  From abf0a38563bb2922a849e235d33d342170b5bc90 Mon Sep 17 00:00:00 2001
> Message-Id: <abf0a38563bb2922a849e235d33d342170b5bc90.1651662442.git.robin.murphy@arm.com>
> From: Robin Murphy <robin.murphy@arm.com>
> Date: Wed, 4 May 2022 11:53:20 +0100
> Subject: [PATCH] iommu: Make sysfs robust for non-API groups
>
> Groups created by VFIO backends outside the core IOMMU API should never
> be passed directly into the API itself, however they still expose their
> standard sysfs attributes, so we can still stumble across them that way.
> Take care to consider those cases before jumping into our normal
> assumptions of a fully-initialised core API group.
>
> Fixes: 3f6634d997db ("iommu: Use right way to retrieve iommu_ops")
> Reported-by: Jan Stancek <jstancek@redhat.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/iommu.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 29906bc16371..41ea2deaee03 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -510,6 +510,13 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
>         list_for_each_entry(device, &group->devices, list) {
>                 struct list_head dev_resv_regions;
>
> +               /*
> +                * Non-API groups still expose reserved_regions in sysfs,
> +                * so filter out calls that get here that way.
> +                */
> +               if (!device->dev->iommu)
> +                       break;
> +
>                 INIT_LIST_HEAD(&dev_resv_regions);
>                 iommu_get_resv_regions(device->dev, &dev_resv_regions);
>                 ret = iommu_insert_device_resv_regions(&dev_resv_regions, head);
> @@ -2977,7 +2984,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
>         if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
>                 return -EACCES;
>
> -       if (WARN_ON(!group))
> +       if (WARN_ON(!group) || !group->default_domain)
>                 return -EINVAL;
>
>         if (sysfs_streq(buf, "identity"))
> --
> 2.35.3.dirty
>

