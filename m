Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5460E513775
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbiD1O5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiD1O5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:57:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71539B1AB2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:53:56 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j15so7157732wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XB6h972j5Zc5Yul0kh9vlaIZfxycg9OQhkbmMJ/20t8=;
        b=c/ri+iwJu54XxDDUxjRAyyeZXQg/x1z/8UR7R7qAnFzlIKkGhpuZSRtt5g+hSLafJB
         eR7InkulNarobbYa+axDXjKwE4ictyyHFKt4f+/zQXhYz73cWLBD+LK8/ForutsXBl0C
         JIRRMq6/jfDigNP7R6bS5UJMUf19Ki2MAmxeFjC4GXvxZnEwK6up3bFvn56+fgj+jdGO
         mgwO+zZ7ZHpSYDD8pV8IY9EiC1X6v1FiDD49K/a/165zmInJQANi3nYO5NigmcbdZDpm
         6RyZxKMGbEhh8JbJI+xkQAw3AJJrIdAFk98aq6I+qyEKnzT/TLU41K+KI2mPmdh8MvOc
         iDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XB6h972j5Zc5Yul0kh9vlaIZfxycg9OQhkbmMJ/20t8=;
        b=LN6pdE4Ls30s9vQih5PZnufHiVam7YWLccqBvuFwK9XNf6xZNjh0UKsZNHtxEMTQFc
         hkgsXag6iT/+awDJsUi0ONnImH5Y08kgiPgelqJvjkdZQniJlCBt+kAFmP4b6AP+nQQt
         HP/Svj5Nq9/Xfyy/JFE+AB7y+cSa3ntO5nYgBDykbtboaA1QM4+n6OkmxbtCqmYxBOLK
         511CAIBpZCEBeAeSImJRvRBjvR0P0XeKfA9/VNfpFKm3FeGyNBI789m9tZOz3kNC1kLK
         hEgqHFAGkoglglpFe87toWivKGHXI4KGRBxkdF70iIrQTl7j+fNgg5aja4xXxo16/pcw
         NGuQ==
X-Gm-Message-State: AOAM533rtxp+7Ci3Xcwz5VJ08h5tENA4NjMMVs2Q0NIvQL6m1W+sWLIS
        4XtbDjncnU30IsBJ5hTc8iPVBQ==
X-Google-Smtp-Source: ABdhPJwpsxclCmp4KjVr6hySleD4JiRE2eyEIgPLnb1Xk0MUhP3G+i76OcP8pfdXW7USyRywbuGapQ==
X-Received: by 2002:adf:d1ea:0:b0:20a:2823:9e22 with SMTP id g10-20020adfd1ea000000b0020a28239e22mr27163586wrd.332.1651157635031;
        Thu, 28 Apr 2022 07:53:55 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id f10-20020adff98a000000b0020af37b8d62sm43481wrr.113.2022.04.28.07.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 07:53:54 -0700 (PDT)
Date:   Thu, 28 Apr 2022 15:53:29 +0100
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
Subject: Re: [PATCH v4 03/12] iommu: Add attach/detach_dev_pasid domain ops
Message-ID: <YmqqaXtqev9FUJo7@myrica>
References: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
 <20220421052121.3464100-4-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421052121.3464100-4-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 01:21:12PM +0800, Lu Baolu wrote:
> Attaching an IOMMU domain to a PASID of a device is a generic operation
> for modern IOMMU drivers which support PASID-granular DMA address
> translation. Currently visible usage scenarios include (but not limited):
> 
>  - SVA (Shared Virtual Address)
>  - kernel DMA with PASID
>  - hardware-assist mediated device
> 
> This adds a pair of common domain ops for this purpose and adds helpers
> to attach/detach a domain to/from a {device, PASID}. Some buses, like
> PCI, route packets without considering the PASID value. Thus a DMA target
> address with PASID might be treated as P2P if the address falls into the
> MMIO BAR of other devices in the group. To make things simple, these
> interfaces only apply to devices belonging to the singleton groups, and
> the singleton is immutable in fabric i.e. not affected by hotplug.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
[...]
> +/*
> + * Use standard PCI bus topology, isolation features, and DMA
> + * alias quirks to check the immutable singleton attribute. If
> + * the device came from DT, assume it is static and then
> + * singleton can know from the device count in the group.
> + */
> +static bool device_group_immutable_singleton(struct device *dev)
> +{
> +	struct iommu_group *group = iommu_group_get(dev);
> +	int count;
> +
> +	if (!group)
> +		return false;
> +
> +	mutex_lock(&group->mutex);
> +	count = iommu_group_device_count(group);
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);
> +
> +	if (count != 1)
> +		return false;
> +
> +	if (dev_is_pci(dev)) {
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +
> +		/*
> +		 * The device could be considered to be fully isolated if
> +		 * all devices on the path from the device to the host-PCI
> +		 * bridge are protected from peer-to-peer DMA by ACS.
> +		 */
> +		if (!pci_acs_path_enabled(pdev, NULL, REQ_ACS_FLAGS))
> +			return false;
> +
> +		/* Filter out devices which has any alias device. */
> +		if (pci_for_each_dma_alias(pdev, has_pci_alias, pdev))
> +			return false;

Aren't aliases already added to the group by pci_device_group()?  If so
it's part of the count check above

> +
> +		return true;
> +	}
> +
> +	/*
> +	 * If the device came from DT, assume it is static and then
> +	 * singleton can know from the device count in the group.
> +	 */
> +	return is_of_node(dev_fwnode(dev));

I don't think DT is relevant here because a platform device enumerated
through ACPI will also have its own group. It should be safe to stick to
what the IOMMU drivers declare with their device_group() callback. Except
for PCI those groups should be immutable so we can return true here.

Thanks,
Jean

