Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F0F5AD5B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbiIEPGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiIEPGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:06:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C5425590
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662390368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=baWRHv65JoZKVmoERU+nz7rnlnje9QiEDNwQTaeNASE=;
        b=NSKMhAbFUJ/HKVLR4+LLNclJ3voqyKWS0ER1n2j0qRsRB+r+7pQ/qGNf2Q29hTo05nP0ls
        rRQOU4ZWmr44tn/oMDo8GRWnFqvIjrnLyU74cw27SdunveUlUmzealEAGnAWb4k+yBjCHU
        XjnKIjqcT03wdguERUecL+Ll3gfBUdY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-18-9vgHtrp0MoWnYw1CcgtilA-1; Mon, 05 Sep 2022 11:06:07 -0400
X-MC-Unique: 9vgHtrp0MoWnYw1CcgtilA-1
Received: by mail-qv1-f72.google.com with SMTP id lx4-20020a0562145f0400b00496ecf45ac4so5970619qvb.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 08:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=baWRHv65JoZKVmoERU+nz7rnlnje9QiEDNwQTaeNASE=;
        b=2oRQNWNxzMLaUguBIil5BzReoZj8aOO/23sa+/CFUGRD2DijyzmbA2j6TGIIRwbvcf
         BLJWbKJA/jkQjYKe80oDuHp+EZtJ6/ElU+2v5Ii6ypiTdr8UxryAGyGkT6lFG9esA6B/
         KFOOj0X7h9EOn48pHC8cpSb3Mzm/4kfD9seEuFMhspMIly6nNXmh5YlN0vNFBz4ANEKx
         nmS5PZGe0/HQofsXBpthEjkXwMZMyabYRkQhP2uC/rLvfEbjp51WV83sKAR2I8FNT+8R
         j5fgnA4d0BDis9XtYK/Fdk7qZKy41oLCKA1SJI8uV2wxpC9qsvSkj7U/weDGyfaJlmcx
         CuXA==
X-Gm-Message-State: ACgBeo3JYE8YTHGA+syPU2Ah5asjXLgWZimMf+edddciaBds+B6gW0Qu
        XRtLksT74WvJ00Q5QmMDQV3rN3ZP1bQEcAW1XZayGRHumwEc++1pvXyvoimFuTISFw/TGnvPHAk
        Q31+aiI6jjiudBxyNmmabN4/2
X-Received: by 2002:a05:622a:104c:b0:343:587c:1bc8 with SMTP id f12-20020a05622a104c00b00343587c1bc8mr39900910qte.484.1662390366687;
        Mon, 05 Sep 2022 08:06:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR41Ha0F7IAhih0139Y0sukA7FAGbI5WVrHQG6qV3+58gFOIj4YCcPxlSN/QaIfa4iG1ozbROw==
X-Received: by 2002:a05:622a:104c:b0:343:587c:1bc8 with SMTP id f12-20020a05622a104c00b00343587c1bc8mr39900876qte.484.1662390366391;
        Mon, 05 Sep 2022 08:06:06 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id i1-20020a05620a248100b006b8e63dfffbsm8588663qkn.58.2022.09.05.08.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 08:06:06 -0700 (PDT)
Date:   Mon, 5 Sep 2022 08:06:04 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 1/2] iova: Remove some magazine pointer NULL checks
Message-ID: <20220905150604.7bijcbeuuyw44rkl@cantor>
References: <1662369083-238529-1-git-send-email-john.garry@huawei.com>
 <1662369083-238529-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662369083-238529-2-git-send-email-john.garry@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 05:11:22PM +0800, John Garry wrote:
> Since commit 32e92d9f6f87 ("iommu/iova: Separate out rcache init") it
> has not been possible to have NULL CPU rcache "loaded" or "prev" magazine
> pointers. As such, the checks in iova_magazine_full(),
> iova_magazine_empty(), and iova_magazine_free_pfns() may be dropped.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com

> ---
>  drivers/iommu/iova.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 47d1983dfa2a..580fdf669922 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -661,9 +661,6 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>  	unsigned long flags;
>  	int i;
>  
> -	if (!mag)
> -		return;
> -
>  	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
>  
>  	for (i = 0 ; i < mag->size; ++i) {
> @@ -683,12 +680,12 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>  
>  static bool iova_magazine_full(struct iova_magazine *mag)
>  {
> -	return (mag && mag->size == IOVA_MAG_SIZE);
> +	return mag->size == IOVA_MAG_SIZE;
>  }
>  
>  static bool iova_magazine_empty(struct iova_magazine *mag)
>  {
> -	return (!mag || mag->size == 0);
> +	return mag->size == 0;
>  }
>  
>  static unsigned long iova_magazine_pop(struct iova_magazine *mag,
> -- 
> 2.35.3
> 

