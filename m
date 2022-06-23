Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E635C55754C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiFWIWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiFWIWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:22:44 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC7F488A5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:22:41 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 40B0B447; Thu, 23 Jun 2022 10:22:40 +0200 (CEST)
Date:   Thu, 23 Jun 2022 10:22:38 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com, ashish.kalra@amd.com, vasant.hegde@amd.com,
        thomas.lendacky@amd.com
Subject: Re: [PATCH v3 1/7] iommu/amd: Warn when found inconsistency EFR mask
Message-ID: <YrQizrI5lR3ki37B@8bytes.org>
References: <20220622171131.11870-1-suravee.suthikulpanit@amd.com>
 <20220622171131.11870-2-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622171131.11870-2-suravee.suthikulpanit@amd.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 12:11:25PM -0500, Suravee Suthikulpanit wrote:
>  #ifdef CONFIG_IRQ_REMAP
> +/*
> + * Iterate through all the IOMMUs to verify if the specified
> + * EFR bitmask of IOMMU feature are set.
> + * Warn and return false if found inconsistency.
> + */
>  static bool check_feature_on_all_iommus(u64 mask)
>  {
>  	bool ret = false;
>  	struct amd_iommu *iommu;
>  
>  	for_each_iommu(iommu) {
> -		ret = iommu_feature(iommu, mask);
> -		if (!ret)
> +		bool tmp = iommu_feature(iommu, mask);
> +
> +		if ((ret != tmp) &&
> +		    !list_is_first(&iommu->list, &amd_iommu_list)) {
> +			pr_err(FW_BUG "Found inconsistent EFR mask (%#llx) on iommu%d (%04x:%02x:%02x.%01x).\n",
> +			       mask, iommu->index, iommu->pci_seg->id, PCI_BUS_NUM(iommu->devid),
> +			       PCI_SLOT(iommu->devid), PCI_FUNC(iommu->devid));
>  			return false;
> +		}
> +		ret = tmp;

It is better to implement this by introducing a global feature mask,
which represents the minial set of features supported by any IOMMU in
the system.

The warning is then something like:

	if ((global_feature_mask & iommu_features) != global_feature_mask)
		pr_warn(...);

This also makes the global variable to track SNP support obsolete.

Regards,

	Joerg
