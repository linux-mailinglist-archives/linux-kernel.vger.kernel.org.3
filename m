Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3522513787
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348669AbiD1PA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243847AbiD1PA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:00:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EACC6D4F7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:57:43 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id m20so10073157ejj.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+Oatp214EwoNcQfNGb/ga75M/gnCMQvp4FQ1OdCp+0E=;
        b=XGccVBbYbqQHavxmDFlET858W8/jpfKwAvu1iXwcz1UiPEkSDm4RDz9Eu5dw1AhpzT
         S18Q+f+L9h8jeW7AaNE5yH9d0DBvna/nIClQHP/oUVdE+fveKG2Vo8Vjkb65yaiY2lDo
         GLFbb4SKTTewbGyXbWZvT/y+IZobtPOV7LtbOmSSHyGh+hgJLcUX7gA6jWZVdcLut3Hg
         doYBJ9b573W3HowU4BG64IaVxziqIeSesfP2EGnXBsVwNoBgibOfC9ADDsLCWsF89YbO
         h3SVONb7e6Cl7zhLd0ruB5rns3Zc3vA90/KYWaMMtxMpPlkIv8cNVK2RsrBJorLEFytG
         lbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Oatp214EwoNcQfNGb/ga75M/gnCMQvp4FQ1OdCp+0E=;
        b=L3+jVGEN1l8bjxXdwTDetufnjil6PX6DpXaDo/I6lLC9PyTyFgMKRL31jVVPXayAck
         pUYUJeB/WcT2mpGzAhHN1GAV1Cg5ZJ0toarrhqxxAxlbHWCR62tgbpvobRym0ChzScCR
         9nbgbb2NsCin0dJNPmwnPhtL4atkbtE6OHD46Qcv+Px0KvGZ5Z+g7W3sFfLbaeBhPbOz
         6to0kZ0HU5q1yctmy6F3Rl+IWGXr0Oz1SD4KGGrjYa5D5DJ/VvyywBp0/oZWk+3GYmoC
         v7AUnbz4I7+OtMMjq//wTI+sWp2zVEpyPuIvoDbtYhl2eXAqH43DpXz02zoyc5nFcEfo
         BEXw==
X-Gm-Message-State: AOAM5304sD0GJDBamF7yrLwa8etNm5RoxCqJT9EikUu1lp9j87GiON3i
        ErUOqP2QdwIKSxcUZwU1vB5uaw==
X-Google-Smtp-Source: ABdhPJyCs5GoHd6/3JIGfBLDqAf/IOHLs+yHhomAVfDQjADxQpL1I8V6bW4kdozw9pGdsWMQrdIGew==
X-Received: by 2002:a17:907:6d17:b0:6f3:e4ef:cd4a with SMTP id sa23-20020a1709076d1700b006f3e4efcd4amr2947973ejc.646.1651157861714;
        Thu, 28 Apr 2022 07:57:41 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id l21-20020a056402345500b0042617ba6393sm1706454edc.29.2022.04.28.07.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 07:57:41 -0700 (PDT)
Date:   Thu, 28 Apr 2022 15:57:16 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/12] iommu: Per-domain I/O page fault handling
Message-ID: <YmqrTGcHotvhhaT2@myrica>
References: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
 <20220421052121.3464100-12-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421052121.3464100-12-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 01:21:20PM +0800, Lu Baolu wrote:
>  static void iopf_handle_group(struct work_struct *work)
>  {
>  	struct iopf_group *group;
> @@ -134,12 +78,23 @@ static void iopf_handle_group(struct work_struct *work)
>  	group = container_of(work, struct iopf_group, work);
>  
>  	list_for_each_entry_safe(iopf, next, &group->faults, list) {
> +		struct iommu_domain *domain;
> +
> +		domain = iommu_get_domain_for_dev_pasid_async(group->dev,
> +				iopf->fault.prm.pasid);

Reading the PCIe spec again (v6.0 10.4.1.1 PASID Usage), all faults within
the group have the same PASID so we could move the domain fetch out of the
loop. It does deviate from the old behavior, though, so we could change
it later.

Thanks,
Jean

> +		if (!domain || !domain->iopf_handler)
> +			status = IOMMU_PAGE_RESP_INVALID;
> +
>  		/*
>  		 * For the moment, errors are sticky: don't handle subsequent
>  		 * faults in the group if there is an error.
>  		 */
>  		if (status == IOMMU_PAGE_RESP_SUCCESS)
> -			status = iopf_handle_single(iopf);
> +			status = domain->iopf_handler(&iopf->fault,
> +						      domain->fault_data);
> +
> +		if (domain)
> +			iommu_domain_put_async(domain);
>  
>  		if (!(iopf->fault.prm.flags &
>  		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
