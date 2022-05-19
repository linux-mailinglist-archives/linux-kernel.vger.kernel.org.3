Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174BA52D0A8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbiESKh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbiESKhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:37:52 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D502864713
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:37:51 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id q8so5906926oif.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=91RlCk313r8m40bIa9yHP69AdJe8s0O90hAGX9tfpQo=;
        b=IGROSZ9snA0E8moJpPnXXlZ+dVvo7Pn7LrcuG45gT2NMj0Ft/xuwojMxSci6m30Tpb
         /+VVqblq/P9RPYJr4EEmwIU97Qi6+E+yf3v4QCvn8OqlhyIAXXcNOcV5K4t6/w4G1uvM
         uEmQnlU2XcVwe/ZGt0z1yg6STGpDIjMg+qPFFfwAsg3K2NKtCuJW7jvqlLXGNCoahT2/
         NGDeqP7vUbd8MLT7ZPqZUmIwLxHVVF9dSSXYfUoUhTPDYL5mcFXQX1Q8mdpM0FckoFoE
         qBh+ed3PA9GGqzt4MmB7FjdMVUAOtRNTf7o+LN2mg0u/lZBWQ3NWKmSwIfUjvW2WYtQQ
         8dnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=91RlCk313r8m40bIa9yHP69AdJe8s0O90hAGX9tfpQo=;
        b=6ZBnQ/eDv8SjPCaR0su/+u0PREOJWsdTOmS1EfQeoGQQzwWrg4xNTcABKn8mDmUr2d
         cYPgJ5uMob+NNIsi6uBHneyLYrouNbVN399Al/tnbED+0zoI19x2Daa4Xq1kjwEyDQLP
         Jstjt/XDHSfQjGNxx9Xyi8UcfHdA4PichiQdZdTJWKS+hhOQxoqAYpDsN2BtqhJKMkBP
         7hvrJJ6w4seZXoucPgqZO3cYvRN/aErPlNFRlvFZ1CvYzbG+v3fZ1UOEy8BnrFwt86dI
         kyblJ/OadUeq/58kev1WicCzKorMGJWCP7rc8aVhcXGgyz3B23+1Kh21o8GFDB6W6j5N
         tGYg==
X-Gm-Message-State: AOAM532BV2Udch8inQ7QkdI8RaiEblsXmxZxdIGhCfLPdbTK4uS5jV1a
        K4Yg4XmZhlUQ+/QU4Jv1bc5gNw==
X-Google-Smtp-Source: ABdhPJzWa11doL7m+tx0uyc5KHyJXn8YmWpHNRBuh1zqQCcw7Ad9yphafujN9GeExD/pkeAAoJznEw==
X-Received: by 2002:a54:4513:0:b0:325:5f69:19ea with SMTP id l19-20020a544513000000b003255f6919eamr2197507oil.111.1652956671191;
        Thu, 19 May 2022 03:37:51 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id i62-20020aca3b41000000b00325cda1ff8esm1726727oia.13.2022.05.19.03.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 03:37:50 -0700 (PDT)
Date:   Thu, 19 May 2022 11:37:23 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/10] iommu: Add pasids field in struct iommu_device
Message-ID: <YoYd43JFXJcqngby@myrica>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519072047.2996983-2-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Thu, May 19, 2022 at 03:20:38PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 88817a3376ef..6e2cd082c670 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3546,6 +3546,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  	/* SID/SSID sizes */
>  	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
>  	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, reg);
> +	smmu->iommu.pasids = smmu->ssid_bits;

This should be 1UL << smmu->ssid_bits

Thanks,
Jean
