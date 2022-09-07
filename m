Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5ED55B08AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiIGPhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiIGPho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:37:44 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A900C81B37
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:37:43 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id bg5-20020a05600c3c8500b003a7b6ae4eb2so879890wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 08:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=BHH6C0MUaJBB869uVqxXVXUx/Qb6hgtg09Hc0S0gRlE=;
        b=fmAVErYkQX071cLsx9F39Ti7u+NaH5nA5kS00lXR3MVqHtL3FNz2nmH5D2zNicV8hT
         aNhwWld4iVLs0KfgwZIcoU32p1cykSzWtx++QDNPPf0An7+3XSkHReXHGjVNLzA2FFmV
         YCKMsex/6UCYEjBoh4S9ib3j0aDc7XiZWTvBkDhyvsipuEGKZZxxAM4VnDuENETHESut
         3GvAnFflx9mRUa8RhybiY2oWRlBwHMAv2/1v/qerdDLYvNtlnU0JVIaf1QgSjpQfGnX/
         lFq8AGck95Jh5He4NNsC7zI9N8p2wW4XoFUPM8DxwGR1dT+q+sWczy50nNML1ydpZEz4
         RIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=BHH6C0MUaJBB869uVqxXVXUx/Qb6hgtg09Hc0S0gRlE=;
        b=n1WyK/cwy/TYOnIgBgSjXiLdEyMTKnrONrq4ty5wbKLJTiNBtz+cHFxyGb9O5ixXT2
         UbBfOMw0vbX8FDrRVDNMHt6T0ZRb3nZWU/d+m0E+EFRVGbCzgV0Wn5amuADWCi953Ur9
         IhZx0/QJGyCW/+gyG3pNzGRZrJVBi2QcSsOXXB+b1PFmsC2ixo1UOkhNDrITGJ627vU3
         hMyKD4fS+uWPlEZJ9nuLKIvwXGrVhMksd3uYz+NJ47j9pLmXpEKHsoiohCOZAnlcmQO9
         VMsQ8pj0ysMhw6+4OmR2m9BIk+G7Peo0LUFG/ZZVks5MeN7iNqWKn9sjQuAUzOsoHRvv
         /gtQ==
X-Gm-Message-State: ACgBeo3OmBRkXoPqi5O6QPLxJGiVkIzFfERqo4jQzgM30e8TTmZ+jWZQ
        7IggqkZYeTMLRAH8ASnN0AH63wvrgpD/aV3F
X-Google-Smtp-Source: AA6agR4ofgU8cPouQN9kizhK4U/lWO9bgN6PyukytEIk8MDxkvAGlGOMwR9R7FY7qaZk1ueOehi9iw==
X-Received: by 2002:a05:600c:2f88:b0:3a5:4014:4b47 with SMTP id t8-20020a05600c2f8800b003a540144b47mr16977056wmn.96.1662565062164;
        Wed, 07 Sep 2022 08:37:42 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id bp6-20020a5d5a86000000b00228692033dcsm13011401wrb.91.2022.09.07.08.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 08:37:41 -0700 (PDT)
Date:   Wed, 7 Sep 2022 16:37:37 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/virtio: Fix compile error with viommu_capable()
Message-ID: <Yxi6wXDVU3h83Np2@myrica>
References: <20220907151154.21911-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907151154.21911-1-joro@8bytes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 05:11:54PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> A recent fix introduced viommu_capable() but other changes
> from Robin change the function signature of the call-back it
> is used for.
> 
> When both changes are merged a compile error will happen
> because the function pointer types mismatch. Fix that by
> updating the viommu_capable() signature after the merge.
> 
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/virtio-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index da463db9f12a..1b12825e2df1 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -1005,7 +1005,7 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  	return iommu_fwspec_add_ids(dev, args->args, 1);
>  }
>  
> -static bool viommu_capable(enum iommu_cap cap)
> +static bool viommu_capable(struct device *dev, enum iommu_cap cap)
>  {
>  	switch (cap) {
>  	case IOMMU_CAP_CACHE_COHERENCY:
> -- 
> 2.36.1
> 
