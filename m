Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF10517927
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 23:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387679AbiEBVfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 17:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239512AbiEBVfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 17:35:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F52E09E
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 14:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651527143; x=1683063143;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G0FF9i1jLHjZ/yzasx+agtmTQl9xoAQw3ixOJN2ci8o=;
  b=dz7We7e+kF/k31RFE3cuiz4z2jAyl+enLi/JHSTbhc6Psyiw9m80sx+O
   HoCpmCrdJdCJAaPdB2NhhOxB5YpFbf4yuM0HKEOIHEwbgXm9XpIq68vub
   L8ZpYBhGOaDIF4XPAo6r5TG/BVWvwrQnxTHlcHXy8UEeOEpWgdIMMLoWg
   phtDGyUz9eOvWDjwe0QFMTSJnknHyTKH4sFfR4+W8gcRnqCUbW49jWfFH
   TJqKlDIprExlNAln8diHsOkcAwPh4vzPBxqxnRWRxjerY6fbC9kVJjTQt
   6GaktZ3hpQQvmAoOQglCrtPf6C++u3/TpnWKaCkwMe3187PNHTyTtil83
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="353769373"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="353769373"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 14:32:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="652997307"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 14:32:22 -0700
Date:   Mon, 2 May 2022 14:36:03 -0700
From:   Jacob Pan <jacob.jun.pan@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        jacob.jun.pan@intel.com
Subject: Re: [PATCH 4/5] iommu/vt-d: Remove domain_update_iommu_snooping()
Message-ID: <20220502143603.4143dd66@jacob-builder>
In-Reply-To: <20220501112434.874236-5-baolu.lu@linux.intel.com>
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
        <20220501112434.874236-5-baolu.lu@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi BaoLu,

On Sun, 1 May 2022 19:24:33 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> The IOMMU force snooping capability is not required to be consistent
> among all the IOMMUs anymore. Remove force snooping capability check
> in the IOMMU hot-add path and domain_update_iommu_snooping() becomes
> a dead code now.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 34 +---------------------------------
>  1 file changed, 1 insertion(+), 33 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 3c1c228f9031..d5808495eb64 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -533,33 +533,6 @@ static void domain_update_iommu_coherency(struct
> dmar_domain *domain) rcu_read_unlock();
>  }
>  
> -static bool domain_update_iommu_snooping(struct intel_iommu *skip)
> -{
> -	struct dmar_drhd_unit *drhd;
> -	struct intel_iommu *iommu;
> -	bool ret = true;
> -
> -	rcu_read_lock();
> -	for_each_active_iommu(iommu, drhd) {
> -		if (iommu != skip) {
> -			/*
> -			 * If the hardware is operating in the scalable
> mode,
> -			 * the snooping control is always supported
> since we
> -			 * always set PASID-table-entry.PGSNP bit if the
> domain
> -			 * is managed outside (UNMANAGED).
> -			 */
> -			if (!sm_supported(iommu) &&
> -			    !ecap_sc_support(iommu->ecap)) {
> -				ret = false;
> -				break;
> -			}
> -		}
> -	}
> -	rcu_read_unlock();
> -
> -	return ret;
> -}
> -
>  static int domain_update_iommu_superpage(struct dmar_domain *domain,
>  					 struct intel_iommu *skip)
>  {
> @@ -3593,12 +3566,7 @@ static int intel_iommu_add(struct dmar_drhd_unit
> *dmaru) iommu->name);
>  		return -ENXIO;
>  	}
> -	if (!ecap_sc_support(iommu->ecap) &&
> -	    domain_update_iommu_snooping(iommu)) {
> -		pr_warn("%s: Doesn't support snooping.\n",
> -			iommu->name);
> -		return -ENXIO;
> -	}
> +
Maybe I missed earlier patches, so this bit can also be deleted?

struct dmar_domain {
	u8 iommu_snooping: 1;		/* indicate snooping control
feature */

>  	sp = domain_update_iommu_superpage(NULL, iommu) - 1;
>  	if (sp >= 0 && !(cap_super_page_val(iommu->cap) & (1 << sp))) {
>  		pr_warn("%s: Doesn't support large page.\n",


Thanks,

Jacob
