Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F8456ADB5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbiGGVcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbiGGVcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:32:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB5EB33E0F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 14:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657229572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d2+xyR5a4mUJvqlnt1FauNhNLGIeoTozhZJ4XCk77AM=;
        b=Ss8gk1wRRfSrvIE/tn8GFly3byxREi4ie48z+H7DzlgvolvXYNGQgELnV2BR5W8ERZkvQw
        znv3kM5mTNN6QqEFq0ttf9faIMn8ELzfyIAaMza7KnH/8OocIM/MMO/bLJQvOhmNPfhDIx
        EOarpkFWqlBrhUnKBYyMMw+BRPgrDKw=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-PFQEapUfMpSFoo_XKMx-nA-1; Thu, 07 Jul 2022 17:32:44 -0400
X-MC-Unique: PFQEapUfMpSFoo_XKMx-nA-1
Received: by mail-il1-f197.google.com with SMTP id j17-20020a056e02219100b002dc4e721203so975380ila.22
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 14:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=d2+xyR5a4mUJvqlnt1FauNhNLGIeoTozhZJ4XCk77AM=;
        b=02j3vT7nRxVROG58ubnnKpZWkA1lliEJcHh8UikcGi0QyVV0h2PePCSQZ26ibUWrMh
         hXVO5TmbsyLoRtejT4LCM5hdnqTHe9wnjNvN/d6iDiiwkao5JVp0JppVpHVURZ5+szLK
         fdba3Zk3O+Y43PacasLWJDdO8MsOxGqoJYBkMEAzZZOEA9q9bh8RVQJLXdkxQL0VRQ5k
         7fFGg5BvmKbq4Bftc2SLfRJFee37r0omblF+Ymps9w8Bo4rPGlLOHfj8HIAJ3RGqaSxP
         X7TM0wOUI/LQNkL7GqtLuT5ndL6IXW7+LySsVU3QPRfaiVQzv8zGv74dN7jrcEGHvKVY
         KLUQ==
X-Gm-Message-State: AJIora8tiVicsQn7R5Gp75Oq12Z1zESj8Bpp+DtImSdGEn3Xwf4w6qlc
        hIqH4FfY1nlzUfJr9q1yS6DjnXEY9cxiH5LwO3TjN5ou8rY35z6l11R6pA3vRkEntcpaJXlp5Z0
        O5iGFB1HwZBxXOdzETB6X1kW8
X-Received: by 2002:a05:6e02:20cb:b0:2dc:28d0:b8a5 with SMTP id 11-20020a056e0220cb00b002dc28d0b8a5mr100345ilq.160.1657229564158;
        Thu, 07 Jul 2022 14:32:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tnft79Cj9IXsNUC+8aNdUeQV7Pc2Bwf1sHYWS6Jb58lqJwdDf7s/G16wSqvHaehBRsVVqn9A==
X-Received: by 2002:a05:6e02:20cb:b0:2dc:28d0:b8a5 with SMTP id 11-20020a056e0220cb00b002dc28d0b8a5mr100336ilq.160.1657229563936;
        Thu, 07 Jul 2022 14:32:43 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id d11-20020a056e020c0b00b002dae42fa5f2sm7704054ile.56.2022.07.07.14.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 14:32:43 -0700 (PDT)
Date:   Thu, 7 Jul 2022 15:32:42 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     <cohuck@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio/spapr_tce: Remove the unused parameters container
Message-ID: <20220707153242.3f8b3e54.alex.williamson@redhat.com>
In-Reply-To: <20220702064613.5293-1-wangdeming@inspur.com>
References: <20220702064613.5293-1-wangdeming@inspur.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Jul 2022 02:46:13 -0400
Deming Wang <wangdeming@inspur.com> wrote:

> The parameter of container has been unused for tce_iommu_unuse_page.
> So, we should delete it.
> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Applied to vfio next branch for v5.20.  Thanks,

Alex

> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index 708a95e61831..ea3d17a94e94 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -378,8 +378,7 @@ static void tce_iommu_release(void *iommu_data)
>  	kfree(container);
>  }
>  
> -static void tce_iommu_unuse_page(struct tce_container *container,
> -		unsigned long hpa)
> +static void tce_iommu_unuse_page(unsigned long hpa)
>  {
>  	struct page *page;
>  
> @@ -474,7 +473,7 @@ static int tce_iommu_clear(struct tce_container *container,
>  			continue;
>  		}
>  
> -		tce_iommu_unuse_page(container, oldhpa);
> +		tce_iommu_unuse_page(oldhpa);
>  	}
>  
>  	iommu_tce_kill(tbl, firstentry, pages);
> @@ -524,7 +523,7 @@ static long tce_iommu_build(struct tce_container *container,
>  		ret = iommu_tce_xchg_no_kill(container->mm, tbl, entry + i,
>  				&hpa, &dirtmp);
>  		if (ret) {
> -			tce_iommu_unuse_page(container, hpa);
> +			tce_iommu_unuse_page(hpa);
>  			pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%ld\n",
>  					__func__, entry << tbl->it_page_shift,
>  					tce, ret);
> @@ -532,7 +531,7 @@ static long tce_iommu_build(struct tce_container *container,
>  		}
>  
>  		if (dirtmp != DMA_NONE)
> -			tce_iommu_unuse_page(container, hpa);
> +			tce_iommu_unuse_page(hpa);
>  
>  		tce += IOMMU_PAGE_SIZE(tbl);
>  	}

