Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B879746FE3E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbhLJJ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbhLJJ66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:58:58 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCBEC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 01:55:23 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t9so13971346wrx.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 01:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W8FUODtsxIgRcCAdpogX9Uv8kSzYBLqxbGwgE8yOqHc=;
        b=vsDgL5lWIC1QJt5et+dAzzDtq2+Zo5yEeM+zRcvXvRo3M7HX0JPy5k3sDjLCH92VrB
         p/fZTUILZRFLXswagFeY4vjXWhahK9x02mvXkSOMdTqJPBK9DoDSqcfnPaFvy3c0J2NK
         +RXwTJX3YP4FoJye68ShO1/1ok3enMkj5ECAZpr6u8rvv0Gav+Yh5KuktY6M573YSwkE
         8zzUmtvssm64cieIW8UQnrCc8U0hTXI81IvrqEg3DOrRQvSBx0kS8iIeJZ2RBSzQuaMP
         W8uG0dgs0tsMYeLsA5+EENTv2nUEw9JCPjnt2dO5FURbpHcTfH2vVUK34XgpayGnvpWQ
         ixHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W8FUODtsxIgRcCAdpogX9Uv8kSzYBLqxbGwgE8yOqHc=;
        b=2lsFlux+6luPl0DY3Qbh6z4R+fqUsfMMaQj+tD9HOZuGAfWXTv15aWq/eujV+4rANr
         2RwniIiVQG8b+PMjHGj0GD46FdxIETv72g9GzCVtBxkX1Pfxs2hfR6ANz5oAJtVUqUEf
         of8OBVMPjWR1BgYordAV2thoOQJNDnsolDoxSWM1H6lKM+0MntNIlsc2oDw712nUAtT9
         U+5tkZfjsq4QkEetAxNnhBG7WXMW7oME615FYnAUJER/djIb66ukXQJL+x0zCxGcA8LR
         8INyh+BZqjD3nZjrdFPOv0zvItp9aYOfSr06F5WB6XEqFB8cGgly+dEXy9ZDZ6CfrIK+
         q3pQ==
X-Gm-Message-State: AOAM532bZVOQ5UFR69X3mzONavoxENtwgMC/svF4w75hr5c2/CzZM/zo
        afRcAW+6NJfvnDvpyu3Jq95+qA==
X-Google-Smtp-Source: ABdhPJzWhxWBlJvAwdV5dPSr/L6/G4eeC8jA44FTGzewKfVfxc1toGCSu36ebCmedWG97D7MdQX/sA==
X-Received: by 2002:a5d:64eb:: with SMTP id g11mr12991313wri.438.1639130121899;
        Fri, 10 Dec 2021 01:55:21 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id v2sm2248183wmc.36.2021.12.10.01.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 01:55:21 -0800 (PST)
Date:   Fri, 10 Dec 2021 09:54:59 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Eric Auger <eric.auger@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Constify arm_smmu_mmu_notifier_ops
Message-ID: <YbMj85nqwNCZ4mFg@myrica>
References: <20211204223301.100649-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211204223301.100649-1-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2021 at 11:33:01PM +0100, Rikard Falkeborn wrote:
> The only usage of arm_smmu_mmu_notifier_ops is to assign its address to
> the ops field in the mmu_notifier struct, which is a pointer to const
> struct mmu_notifier_ops. Make it const to allow the compiler to put it
> in read-only memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index ee66d1f4cb81..a737ba5f727e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -220,7 +220,7 @@ static void arm_smmu_mmu_notifier_free(struct mmu_notifier *mn)
>  	kfree(mn_to_smmu(mn));
>  }
>  
> -static struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
> +static const struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
>  	.invalidate_range	= arm_smmu_mm_invalidate_range,
>  	.release		= arm_smmu_mm_release,
>  	.free_notifier		= arm_smmu_mmu_notifier_free,
> -- 
> 2.34.1
> 
