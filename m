Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BCD55DF6B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242057AbiF0WIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242691AbiF0WH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:07:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 390951EAC9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656367605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HZ/0VFUsE1d9kZvm1sE1gAvxnVwUtDWBiRbGTRNr4sc=;
        b=EW2hKCpi30yFeiycX5DyK3XzA6LNiN8Qro9CBrEvwnJfFMKLOTifiPx8x1IZ8SjMEZFkzM
        uO0Y4hMfJWWzcSiJxaN7m1+httG0eJ1bZuPoApnm7YPxEZK673SfnX2gBB+gvLBWuBrdBV
        yYaFwoRPLBxLGEhPFqGFkwx76lFI4Xg=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-6WXn6AwWOmyFqXXvUPK03w-1; Mon, 27 Jun 2022 18:06:43 -0400
X-MC-Unique: 6WXn6AwWOmyFqXXvUPK03w-1
Received: by mail-io1-f71.google.com with SMTP id n19-20020a056602341300b0066850b49e09so6292162ioz.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=HZ/0VFUsE1d9kZvm1sE1gAvxnVwUtDWBiRbGTRNr4sc=;
        b=PeXY8IkQLSuOrytb/bHzZyjAPNU4GeUQaDwPAlAFOxeBauODPJ1bXU1Q792K39AQKO
         l/JFh/0lK6tdB+j3WY3bPbh+pb0lmNvTJPAbCmB2c2XH62svEp0S157ncdJObYgak1UJ
         gU9wL94TBCEj9tJKx6b+8wQZO0gqH+1es27zW25RoOl0PTBK6ZGjtV8hTvnrkpKw/O6n
         62HXwXhcc+79Vcbi6OvuYnC5hp/AshYGlFjSgeyfc0SBvl30sAQiX3smHiv0Sf84UdUa
         A6KRnUfwf8gNMZ24UreCUwVg874VfAaObDW/MvhvsOFuIiHWROsxy1XdTLdaGBP+WlOX
         s+wg==
X-Gm-Message-State: AJIora+wnGXaAy0+eeahmRC6Y3uDMT3yeojd9jig26v8wqm17K118rIe
        nQf2v+EzfTmtlcuNXz6GLa+FX4FAo1AcXdRdSGJnK6awLKCZq4yB7e/fRZCjPbAzia14jhOe0Sm
        3CKwW2ui1lHGqNBYT1774+Yyy
X-Received: by 2002:a02:c503:0:b0:339:ec67:b0a4 with SMTP id s3-20020a02c503000000b00339ec67b0a4mr9354415jam.27.1656367602698;
        Mon, 27 Jun 2022 15:06:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vJu+p7efIp5RqCbZdmaWIB31YUy2oUvJlHvKxzgXHmLMwAfmlwT6tRQqUEqSDaByl6KgI3JA==
X-Received: by 2002:a02:c503:0:b0:339:ec67:b0a4 with SMTP id s3-20020a02c503000000b00339ec67b0a4mr9354407jam.27.1656367602497;
        Mon, 27 Jun 2022 15:06:42 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id d137-20020a02628f000000b00339c5bff7c0sm5155314jac.134.2022.06.27.15.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:06:42 -0700 (PDT)
Date:   Mon, 27 Jun 2022 16:06:40 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Steve Sistare <steven.sistare@oracle.com>
Cc:     lizhe.67@bytedance.com, cohuck@redhat.com, jgg@ziepe.ca,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com
Subject: Re: [PATCH] vfio: remove useless judgement
Message-ID: <20220627160640.7edca0dd.alex.williamson@redhat.com>
In-Reply-To: <20220627035109.73745-1-lizhe.67@bytedance.com>
References: <20220627035109.73745-1-lizhe.67@bytedance.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hey Steve, how did you get around this for cpr or is this a gap?
Thanks,

Alex

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
> 
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

