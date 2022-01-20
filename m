Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F254945EF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 03:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358247AbiATC7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 21:59:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:22476 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231514AbiATC7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 21:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642647585; x=1674183585;
  h=cc:subject:to:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=/heb/BurK2PbaDI5nZrzWaFOjKv5NZGtP7I5Cv9foiw=;
  b=MTdSXzmLjCWwBUKj3uio8SrJ/9R7KgT8wxGQ0xF7nAdwnqPsIQI93Yf6
   rDmpjTmgAMc8vozPDaUw6TdrdYPOmO2KeLsygkYlGA4jgl4NKI2mZFZcT
   A+RDKDi1zgOMeJqqOY+vhHdpgCYVIad8S4Pq8DIYeX+pDkju0mBvgr5pW
   dofk0y6ESKtxwvXxP4uaC14VyJfO3/3bsbgxIFXnAfaf47J/6ArdoQdWT
   LGhzHDX8qIEITCasnvxxW3EJ2AGm9OzV5Z8rYCpwauqDnhzXugGMnT8ZM
   qh7zlP3fs5vc5dZmeSI7tFvvIuLl+sBNul5DhJwwBM68UND2nvYr/WCq8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="232620590"
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; 
   d="scan'208";a="232620590"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 18:59:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; 
   d="scan'208";a="532587638"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 19 Jan 2022 18:59:43 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Do not dump pasid table entries in kdump
 kernel
To:     Zelin Deng <zelin.deng@linux.alibaba.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <1642583260-21095-1-git-send-email-zelin.deng@linux.alibaba.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <846c0ff6-32b1-73a4-0510-f1e809684991@linux.intel.com>
Date:   Thu, 20 Jan 2022 10:58:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1642583260-21095-1-git-send-email-zelin.deng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/22 5:07 PM, Zelin Deng wrote:
> In kdump kernel PASID translations won't be copied from previous kernel
> even if scalable-mode is enabled, so pages of PASID translations are

Yes. The copy table support for scalable mode is still in my task list.

> non-present in kdump kernel. Attempt to access those address will cause
> PF fault:
> 
> [   13.396476] DMAR: DRHD: handling fault status reg 3
> [   13.396478] DMAR: [DMA Read NO_PASID] Request device [81:00.0] fault addr 0xffffd000 [fault reason 0x59] SM: Present bit in PA$
> [   13.396480] DMAR: Dump dmar5 table entries for IOVA 0xffffd000
> [   13.396481] DMAR: scalable mode root entry: hi 0x0000000000000000, low 0x00000000460d1001
> [   13.396482] DMAR: context entry: hi 0x0000000000000008, low 0x00000010c4237401
> [   13.396485] BUG: unable to handle page fault for address: ff110010c4237000
> [   13.396486] #PF: supervisor read access in kernel mode
> [   13.396487] #PF: error_code(0x0000) - not-present page
> [   13.396488] PGD 5d201067 P4D 5d202067 PUD 0
> [   13.396490] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   13.396491] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0-rc6-next-20211224+ #6
> [   13.396493] Hardware name: Intel Corporation EAGLESTREAM/EAGLESTREAM, BIOS EGSDCRB1.86B.0067.D12.2110190950 10/19/2021
> [   13.396494] RIP: 0010:dmar_fault_dump_ptes+0x13b/0x295
> 
> Hence skip dumping pasid table entries if in kdump kernel.

This just asks dmar_fault_dump_ptes() to keep silent. The problem is
that the context entry is mis-configured. Perhaps we should disable
copy table for scalable mode for now. How about below change?

--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3337,10 +3337,11 @@ static int __init init_dmars(void)

                 init_translation_status(iommu);

-               if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
+               if (translation_pre_enabled(iommu) &&
+                   (!is_kdump_kernel() || sm_supported(iommu))) {
                         iommu_disable_translation(iommu);
                         clear_translation_pre_enabled(iommu);
-                       pr_warn("Translation was enabled for %s but we 
are not in kdump mode\n",
+                       pr_warn("Translation was enabled for %s but we 
are not in kdump mode or copy table not supported\n",
                                 iommu->name);
                 }

> 
> Fixes: 914ff7719e8a (“iommu/vt-d: Dump DMAR translation structure when DMA fault occurs”)
> Signed-off-by: Zelin Deng <zelin.deng@linux.alibaba.com>
> ---
>   drivers/iommu/intel/iommu.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 92fea3fb..f0134cf 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1074,6 +1074,12 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
>   	if (!sm_supported(iommu))
>   		goto pgtable_walk;
>   
> +	/* PASID translations is not copied, skip dumping pasid table entries
> +	 * otherwise non-present page will be accessed.
> +	 */
> +	if (is_kdump_kernel())
> +		goto pgtable_walk;
> +
>   	/* get the pointer to pasid directory entry */
>   	dir = phys_to_virt(ctx_entry->lo & VTD_PAGE_MASK);
>   	if (!dir) {
> 

Best regards,
baolu
