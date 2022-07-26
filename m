Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8FC581675
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbiGZPcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiGZPcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8425B7C6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658849551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o3OZWp+Xqi4z0H2oNSiwUoH1tGXNHUeblQL65iP9Ri4=;
        b=WY3Mba0QSS6pzj7f+iNxisKt/vk55q2PXj7N0f4pRA7A1oph7RfcHzVkjhs9wQvGraOR0l
        qeHMiO/18daVQUR4LDBvnvVgSejC0ns/1zJleykxfi+g3yodJpLNpqzCCY5sT2vdnxR/m7
        67BT5APqS6oWyKuEA8xGHnRZeuF5QiI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-yIxYVHjgOUCT1t9gC9lacA-1; Tue, 26 Jul 2022 11:32:30 -0400
X-MC-Unique: yIxYVHjgOUCT1t9gC9lacA-1
Received: by mail-qk1-f200.google.com with SMTP id v13-20020a05620a0f0d00b006b5f0ec742eso12260509qkl.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o3OZWp+Xqi4z0H2oNSiwUoH1tGXNHUeblQL65iP9Ri4=;
        b=EG3a3S2M4wU8K1oXjTmxZaLM+Bb5zN9o3FC4HJjL3DwSC9Ac5jkcfxtyuLNmy4uXcH
         V7Hdr1Eok3tqALm2yP8NoF6Ph81GDKV8OyJwd+bgBHypBNfrIUE2/OeJLGxHJ+EQ0nOk
         lQokildlrvcMZKFEcS6ZLF1+7KHDC81uUe8ruFGdEO3GW4FCEtzjsUTbEJXN6X+fPQ8n
         Q9aojlQCWjj/KCHfOw9khoPTuACFC90XpN+DHUx8JFXTDJ8l1NgRfrdkaJgPrOjuZT9V
         bcPTslyVsp1h1KmENfJxzfrvsaufENc+vTAv1uhDtgJkHPmznk9R+j5wjd6Z9qMIIlDN
         8cYQ==
X-Gm-Message-State: AJIora9ukqFLB1Hoji6NvHrBQKHyqVDQeOXFZhR5HmsQm4feDsHr9xmP
        qw+w8mYECgIp8SE+wUjXX/N9JwY27sy9u+d0toscxgXshshBVpsioP3u0RnqJswaLKlywOiOZY4
        2eLV7i3wVYShkCeuaIkrr5ua4
X-Received: by 2002:ad4:5fcb:0:b0:474:1b28:b30a with SMTP id jq11-20020ad45fcb000000b004741b28b30amr14943900qvb.55.1658849549399;
        Tue, 26 Jul 2022 08:32:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uQEi/c32h/TJaYnrFTO5628e9fk6qo37ezvNTiISSjPrm/nohsOryfPOBTYbG8Yb3pHTr1pw==
X-Received: by 2002:ad4:5fcb:0:b0:474:1b28:b30a with SMTP id jq11-20020ad45fcb000000b004741b28b30amr14943851qvb.55.1658849549015;
        Tue, 26 Jul 2022 08:32:29 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id t2-20020ac85882000000b0031eb02307a9sm9267411qta.80.2022.07.26.08.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:32:28 -0700 (PDT)
Date:   Tue, 26 Jul 2022 08:32:27 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        joro@8bytes.org, will@kernel.org, vasant.hegde@amd.com,
        jon.grimm@amd.com
Subject: Re: [PATCH 2/2] iommu/amd: Add support for AVIC when SNP is enabled
Message-ID: <20220726153227.caqf6hagmwu727ls@cantor>
References: <20220726134348.6438-1-suravee.suthikulpanit@amd.com>
 <20220726134348.6438-3-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726134348.6438-3-suravee.suthikulpanit@amd.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 08:43:48AM -0500, Suravee Suthikulpanit wrote:
> In order to support AVIC on SNP-enabled system, The IOMMU driver needs to
> check EFR2[SNPAVICSup] and enables the support by setting SNPAVICEn bit
> in the IOMMU control register (MMIO offset 18h).
> 
> For detail, please see section "SEV-SNP Guest Virtual APIC Support" of the
> AMD I/O Virtualization Technology (IOMMU) Specification.
> (https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf)
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Is this a typo in the 3.06 spec for SNPAVIC_EN?

"001b-111b = Reserved."

Or I guess maybe there is a newer revision that isn't available yet
that describes 001b?

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/amd_iommu_types.h |  7 +++++++
>  drivers/iommu/amd/init.c            | 11 ++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 3c1205ba636a..5b1019dab328 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -103,6 +103,12 @@
>  #define FEATURE_GLXVAL_SHIFT	14
>  #define FEATURE_GLXVAL_MASK	(0x03ULL << FEATURE_GLXVAL_SHIFT)
>  
> +/* Extended Feature 2 Bits */
> +#define FEATURE_SNPAVICSUP_SHIFT	5
> +#define FEATURE_SNPAVICSUP_MASK		(0x07ULL << FEATURE_SNPAVICSUP_SHIFT)
> +#define FEATURE_SNPAVICSUP_GAM(x) \
> +	((x & FEATURE_SNPAVICSUP_MASK) >> FEATURE_SNPAVICSUP_SHIFT == 0x1)
> +
>  /* Note:
>   * The current driver only support 16-bit PASID.
>   * Currently, hardware only implement upto 16-bit PASID
> @@ -165,6 +171,7 @@
>  #define CONTROL_GAINT_EN	29
>  #define CONTROL_XT_EN		50
>  #define CONTROL_INTCAPXT_EN	51
> +#define CONTROL_SNPAVIC_EN	61
>  
>  #define CTRL_INV_TO_MASK	(7 << CONTROL_INV_TIMEOUT)
>  #define CTRL_INV_TO_NONE	0
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 4cd94d716122..6bbaf6b971e8 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2794,13 +2794,22 @@ static void enable_iommus_vapic(void)
>  		return;
>  	}
>  
> -	/* Enabling GAM support */
> +	if (amd_iommu_snp_en &&
> +	    !FEATURE_SNPAVICSUP_GAM(amd_iommu_efr2)) {
> +		pr_warn("Force to disable Virtual APIC due to SNP\n");
> +		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
> +		return;
> +	}
> +
> +	/* Enabling GAM and SNPAVIC support */
>  	for_each_iommu(iommu) {
>  		if (iommu_init_ga_log(iommu) ||
>  		    iommu_ga_log_enable(iommu))
>  			return;
>  
>  		iommu_feature_enable(iommu, CONTROL_GAM_EN);
> +		if (amd_iommu_snp_en)
> +			iommu_feature_enable(iommu, CONTROL_SNPAVIC_EN);
>  	}
>  
>  	amd_iommu_irq_ops.capability |= (1 << IRQ_POSTING_CAP);
> -- 
> 2.34.1
> 

