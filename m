Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DE25AD5BF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbiIEPG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238513AbiIEPGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:06:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70771357F9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662390404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dgfFwixXVehi1PSvEZVFU5vKRx86AcuJqWkFha0PYcg=;
        b=gunWS/hJ/UPUi1glXfNGWU86nXA3pWKALEgZ75veQmprh7S4g5yqR7N+rwFPPSMtRyS1i0
        dOFt6ecJrPko6FOk0BRf05YdEhCwJtd0ALz/jwfLyzOwQp3JcaARLhQhA+DWm5URHZK1vB
        Sco3HmqqHPr5WVzrxKSw+Z+CpJhVUHU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-578-I8SrJWGROD6jbOsjoryd7Q-1; Mon, 05 Sep 2022 11:06:34 -0400
X-MC-Unique: I8SrJWGROD6jbOsjoryd7Q-1
Received: by mail-qk1-f199.google.com with SMTP id bk21-20020a05620a1a1500b006be9f844c59so7035670qkb.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 08:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=dgfFwixXVehi1PSvEZVFU5vKRx86AcuJqWkFha0PYcg=;
        b=spGIeKXailPToqnsuPLh20XPgoJxYIcGyxah+Ys7dhQ9MIpHiYslBXxMeM9wh1MqM6
         9VGAhbhne3TPcwPqbFkVTFzsK93+t+tzZ09uC0LwOgKEanI4jLzy6rWTePPrLYyx9wLl
         TsRM/6Z1hblB/eUoXVkO4aL7Qinx0Cs0/JaCNXFNLdsAShNEpBGI9u1O71KzStW7Ycqg
         sRLAK2L7D+xqfk4lsFEC57ppLL6kYNC7+pVvR/H6IAbFV+P1RbT5l9dFAd/npAly3Y4L
         /2WD44iIi5R1+ngzXJyL2v9MI04ozfauLqoe+Nwl8OioggbXJbZ7d1F2DkAIkbV6Pr9n
         xKeA==
X-Gm-Message-State: ACgBeo1PRsbLQPeCEGogWM9IkxuaDb79cTGYuYzmfWZlLNBlw9ghfxC1
        7uOGdxLagkILJDlzjvRmX/BeasELLb40gOtfi1cSDBgMK8YginDTXSYByQ9c8zmpiSpdBAhzMhb
        cxb97rZkVB1Z9grgXuqZGbXdO
X-Received: by 2002:a37:a02:0:b0:6bb:17af:a8e6 with SMTP id 2-20020a370a02000000b006bb17afa8e6mr32109761qkk.80.1662390393319;
        Mon, 05 Sep 2022 08:06:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7CQVvjjHeLNOC3yz5M2uqgjeZSamPDWorBe07HjcMAA8/ZIsc8Dps/cJhhfRyfe0dYQiU+8Q==
X-Received: by 2002:a37:a02:0:b0:6bb:17af:a8e6 with SMTP id 2-20020a370a02000000b006bb17afa8e6mr32109742qkk.80.1662390393051;
        Mon, 05 Sep 2022 08:06:33 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id b5-20020ac812c5000000b00344883d3ef8sm7135554qtj.84.2022.09.05.08.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 08:06:32 -0700 (PDT)
Date:   Mon, 5 Sep 2022 08:06:30 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 2/2] iova: Remove magazine BUG_ON() checks
Message-ID: <20220905150630.boe7zy2nwcgb5jb6@cantor>
References: <1662369083-238529-1-git-send-email-john.garry@huawei.com>
 <1662369083-238529-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662369083-238529-3-git-send-email-john.garry@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 05:11:23PM +0800, John Garry wrote:
> Two of the magazine helpers have BUG_ON() checks, as follows:
> - iova_magazine_pop() - here we ensure that the mag is not empty. However we
>   already ensure that in the only caller, __iova_rcache_get().
> - iova_magazine_push() - here we ensure that the mag is not full. However
>   we already ensure that in the only caller, __iova_rcache_insert().
> 
> As described, the two bug checks are pointless so drop them.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com

> ---
>  drivers/iommu/iova.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 580fdf669922..8aece052ce72 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -694,8 +694,6 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
>  	int i;
>  	unsigned long pfn;
>  
> -	BUG_ON(iova_magazine_empty(mag));
> -
>  	/* Only fall back to the rbtree if we have no suitable pfns at all */
>  	for (i = mag->size - 1; mag->pfns[i] > limit_pfn; i--)
>  		if (i == 0)
> @@ -710,8 +708,6 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
>  
>  static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
>  {
> -	BUG_ON(iova_magazine_full(mag));
> -
>  	mag->pfns[mag->size++] = pfn;
>  }
>  
> -- 
> 2.35.3
> 

