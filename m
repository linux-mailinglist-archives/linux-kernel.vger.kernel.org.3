Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523F1562398
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbiF3Twm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbiF3Twh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7900244753
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656618755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E7rOXhTCpvGdfk96ClCh2SccjfQHroJxIT08aj32MKE=;
        b=JkznTSXMr/A7kabsz9O6AE0SX6Ado1coUuqDZQHkC73Kj/Bn37JULq135HMzAXyWuJ00Dj
        RsPdUDMeJzSVki3WjSWgFvpaWiGfBn8ijZ0taN/JWyjwoB0PHev8aCA3iyq8ymsO3bQC7O
        aqkP4BVNuqvPHZF33Y9n1zvWr/WeNvw=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-KvXcxZEhOp-WdJmeFKnDxQ-1; Thu, 30 Jun 2022 15:52:31 -0400
X-MC-Unique: KvXcxZEhOp-WdJmeFKnDxQ-1
Received: by mail-io1-f71.google.com with SMTP id x2-20020a6bda02000000b0067590503c08so113127iob.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=E7rOXhTCpvGdfk96ClCh2SccjfQHroJxIT08aj32MKE=;
        b=zqcdrSfMOQjpt2lGddBJeFFZNv1fz1REJ8R4E/+dpSQeZMj4ZVzwT3Q7UzP/LyB2G0
         05nfxt6xT/Jb5VHW1f0HSNppKATcelH2YTdPlmyQCFUGA4i4P0RjXNMIhHY573jfxR9j
         2kn2QwL6vSe5WAGMmr545BwyJVael7b0py5ON9dtKwmJEH12ifgJxe3RQplIavOku9l2
         YE9Lg+xNzC7AMrbauUyjJRuOCtOrxFS7jHFbFIGCay2DHKaMGNtaxX6896c1FVPTuvEF
         WtwWgdz7e14bqlxNeel/Q433m/wFkd/pBoXpQ/Ko1EhGqUrbbTjsEqyUvNgtL40sYs1O
         zsSg==
X-Gm-Message-State: AJIora9AQf2fft6nuup59jTVg5viT1UaUdrk1S3djxYTdHf9qLWzpyTI
        GVGhvtB4MXLoiQy+eTcUGC7p7qk6FZt+G4g/mVjkdoLEGu4Z1IdpF2n42fTtVz71ckTofedffwI
        X4e4bBkNlQuaFqmUWkRgS3hqs
X-Received: by 2002:a05:6638:1344:b0:331:f546:69e with SMTP id u4-20020a056638134400b00331f546069emr6718778jad.131.1656618751267;
        Thu, 30 Jun 2022 12:52:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1udFgWMSc1np3jhhSMYyX98gcjlMb7XGAKqrwR5gSW723kcaSbACutNnYXxxxcCKjyG+MZrVQ==
X-Received: by 2002:a05:6638:1344:b0:331:f546:69e with SMTP id u4-20020a056638134400b00331f546069emr6718764jad.131.1656618751071;
        Thu, 30 Jun 2022 12:52:31 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id x42-20020a0294ad000000b00330c5581c03sm8880286jah.1.2022.06.30.12.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 12:52:29 -0700 (PDT)
Date:   Thu, 30 Jun 2022 13:51:40 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     lizhe.67@bytedance.com
Cc:     cohuck@redhat.com, jgg@ziepe.ca, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com
Subject: Re: [PATCH] vfio: remove useless judgement
Message-ID: <20220630135140.5069b23c.alex.williamson@redhat.com>
In-Reply-To: <20220627035109.73745-1-lizhe.67@bytedance.com>
References: <20220627035109.73745-1-lizhe.67@bytedance.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2022 11:51:09 +0800
lizhe.67@bytedance.com wrote:

> From: Li Zhe <lizhe.67@bytedance.com>
> 
> In function vfio_dma_do_unmap(), we currently prevent process to unmap
> vfio dma region whose mm_struct is different from the vfio_dma->task.
> In our virtual machine scenario which is using kvm and qemu, this
> judgement stops us from liveupgrading our qemu, which uses fork() &&
> exec() to load the new binary but the new process cannot do the
> VFIO_IOMMU_UNMAP_DMA action during vm exit because of this judgement.
> 
> This judgement is added in commit 8f0d5bb95f76 ("vfio iommu type1: Add
> task structure to vfio_dma") for the security reason. But it seems that
> no other task who has no family relationship with old and new process
> can get the same vfio_dma struct here for the reason of resource
> isolation. So this patch delete it.
> 
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> Reviewed-by: Jason Gunthorpe <jgg@ziepe.ca>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 6 ------
>  1 file changed, 6 deletions(-)

Applied to vfio next branch for v5.20.  Thanks,

Alex

> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index c13b9290e357..a8ff00dad834 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1377,12 +1377,6 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
>  
>  		if (!iommu->v2 && iova > dma->iova)
>  			break;
> -		/*
> -		 * Task with same address space who mapped this iova range is
> -		 * allowed to unmap the iova range.
> -		 */
> -		if (dma->task->mm != current->mm)
> -			break;
>  
>  		if (invalidate_vaddr) {
>  			if (dma->vaddr_invalid) {

