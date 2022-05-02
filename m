Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346C451701F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359372AbiEBNVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385219AbiEBNVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:21:20 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD18B7DB
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:17:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmJ0b7Yb7F86+vK00bFoqqZjUofmchKFARv9xLznSHXqkxHoqfNAZWnaNGA81TX7w86aSTWlB3WMCk429FsHHBMrghTFB5K7FNdo2Xn9TRqB1y+xUsgSex+axdMPpZ7X9P/2CMaaLQiVCrCVNwYpBY9yEOcUXv0xhq8K+JCcLnXv08cPUq2cBxULmNseaM0rtpDGFYdo5ZniAY6ZDTgA7rotvtnE8fJWv65BS8walglmuTm+WHGW0zJb9dWT2UjKIZEWupETA6gEtFxy4WBXiu+10oiOiPXWlK5Y/RnxhJfYEtqmYRFFz/Nnb0ijLY0nBka/ZzlcmYgxGulGrx3E4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arye5+VMbcqJ0y+iYaCcf/471wTNKXplpmjEaQMs45U=;
 b=USwHtGrS5bRL7aiZKOVSBenYj4ykQs2bX8gJKCMmr0vcfeuGz69HZYfdBKVZTlH53W9B0b8ux4wsqhDWmn6Yk2onS1GJ6z/2eQY2yRjuf7U9xukKIM74Mnm4uUwVuV2ks1boRqnFZr1UrPqohl5oG1rdzky3U3xpZQ+pTdph1zsp4zxECpJTp57F/iaTcbQem/9uIcoMxd/EEdPpc25nZWz0nwbGlm1cAJWpLEkvMfL66Iz4WLWal+L8zsetgMk9FHBGAyR354eRXesEjhKw0XutuzGt+a3Tr+VC7ILc/aW+yGrWn72qwnTzp1Xqk07V/mHfUqmLeUEZ0ZpiM/Mquw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arye5+VMbcqJ0y+iYaCcf/471wTNKXplpmjEaQMs45U=;
 b=NZK+jQREMtLXAIUWWaEb5PMqBc5FcK+zYd3w0YziAjLAANo9gqoFthntdZiNuOfAsMg7G8Gj1lVJwheEytqiF6xe1pdPBLWZsWvVZXFjPkCkRty8Ez5/uMqf1aOjmp1Z/uwm4nJ0CG2ZPGGghMcEFVKxNkV4BNwksGgfi6hJ9SD9vTXxWcUUw0mPDKxjp8SIy8RadItglrM/4FLgRvGri0J3DbGRLvFwN8QIiVq9wJuEwIMeuG/nMUm35i+Z7nwxWb+Yp/5TdfWQAig5bNym01UQUomVATsF7eLRjPemZMik6EJrOGNOX0OVJqcxSJ1kbtHoeECehMXDVriVTdH3dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB3798.namprd12.prod.outlook.com (2603:10b6:610:23::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Mon, 2 May
 2022 13:17:48 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.024; Mon, 2 May 2022
 13:17:48 +0000
Date:   Mon, 2 May 2022 10:17:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iommu/vt-d: Check domain force_snooping against
 attached devices
Message-ID: <20220502131747.GJ8364@nvidia.com>
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
 <20220501112434.874236-4-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501112434.874236-4-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR01CA0005.prod.exchangelabs.com (2603:10b6:208:10c::18)
 To MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e1ffe83-f0e5-4c7d-4d7a-08da2c3e274c
X-MS-TrafficTypeDiagnostic: CH2PR12MB3798:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3798F85A586A4048D959A095C2C19@CH2PR12MB3798.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /FOtB7CuQTDHyyls5u7Cp96Ojts5F2G9qCikw9eSQuz2aAcZ+9k40JertCtUAT2t64JY8i1dP9Ew2luzFcdPRPs8Tz83m9srgAQkTP1e/P7hBQ/yN0dP/zvMrjeMC/IQqTs8xARbWsSGLQOO3o34viOyAAFC8cuB9jDBOrPK1N6T/G37BiuxnPQtxtj0MlTxLWj5jdpCKpTJzpUE2KiadR7QEOOPBIoKj+y/XoGjK0fnVRCnw4JnSAtFxfjToYp+bjabDPW6PaDsHhHBZvMCJqqh2ohOgBEv3U2WBxbq9GIKR8mbjJcN6cMxd5uDHv49SRrYcb1QXnJms0sz6fl7pA4is3SIuES62FTiX1vVM9SC4qFxl4HoWdmXwnsUhudSgwVB1nQLklPIkzuTMVMRNt7Tu1BVS1+Epmvdsd+hPe59iF5ivyRGGGU1b4BaeOfDvFibLvdoNrPrIoj4Pnt3bSRjUq6P9EJjXI6uQILhKcSfBaBiPgKjEuFkfAhzPAo/I18ODQb/Rm2Bc+ouK+s5SFisMkxsjn6INw36u8q3/kE7iOQbydMjLYX0fuaonK8EVFY0ZO122bXztKKPnTqZ4NNnKyx2y21eRPjWSbxs5YaWWT8jaDcbwkVPUt+aMUbHzQ7BxViH3GCgz+GA8H21Xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(6506007)(83380400001)(5660300002)(6512007)(38100700002)(316002)(86362001)(186003)(2616005)(8936002)(1076003)(36756003)(4326008)(33656002)(6916009)(8676002)(66556008)(54906003)(2906002)(508600001)(66946007)(66476007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p8CHKvlnBeU09sijha3BOZHDUoi98kwXruqEGxLUXAfVyIGbKLRrI3MHjwiv?=
 =?us-ascii?Q?O2fmjd+8Aig5vkoW02AeDS7wPNVFHjo+/PudVmStDa0elPdTJlErc+Y9Z/FO?=
 =?us-ascii?Q?1j6dA9tFKtlnADaUCu8TVr36qYmZzk0NZiIaKZ4nz01pyvg07ZfALBKqV1R3?=
 =?us-ascii?Q?G3AGvWLt/pZm60K9wZiDi5yrSXXeCLt03bMVz0cEUoOygg19H/bmQqBVCCzH?=
 =?us-ascii?Q?yctiRkdpLTZG2PCwe6+wELZfM4cZN/O47jBhEH1FsSNNtUlNswWxh2sVNM6i?=
 =?us-ascii?Q?d7cfm10Pfo5Wy3otjvlnSQlUbHx+Bpf2OOVV+PuH5zff5IdP+hI02vXG0TaS?=
 =?us-ascii?Q?W/hvxe2rxECYwscxj8dujlh1S2aOoj91wgcePG4qxMAGHfBfNVcLceWmkvkF?=
 =?us-ascii?Q?1n5LTlRUxcAbQNk682cB4XfNlBljyVdtOsvfHAncyNmeiZfrpsLl++w33KHa?=
 =?us-ascii?Q?HjyPh9zkfgA6x7Bk21efubQKpqps2O3KOgT4Wr45EpWrDPXm9q98rEXigCv+?=
 =?us-ascii?Q?Z8/0hvwyJxokCQtVwFzVMpHoEyfnTzLJiTkUfVrAh4nJ5uU6kTFqlwJzVGM7?=
 =?us-ascii?Q?8OAqk9omIRaUlZng7DadMZnP8I9jBzekXMYkAnGf4J6Hp/tEUAomt59nO16m?=
 =?us-ascii?Q?TQzFhfUw0RcLSqoBhR99Cu5K5NSTHwLPkBEyQRzat1m3fe04nZsnoSh24HY/?=
 =?us-ascii?Q?qqbjMb6fAsBR91N8MeSu2iEuhf80Dk8tV+dUp18TEmlvTbnHPB0TmNtYSzBn?=
 =?us-ascii?Q?TgweXdB8oJ0XJsc2a55UKN1wswpHR1k0MmxVxsszSTnU1cDTs7C/dDyZnfMN?=
 =?us-ascii?Q?sypxuW0rjDFJxnZs1wIeD8OBoqPfOeR6lBiqHWu76gDDH+CPacbBxILi4YbB?=
 =?us-ascii?Q?Za8pNrhnO4fcB2xfij0gDScG90axCO3e4gxyoTxta+ksy3aKkONehXU5ai4F?=
 =?us-ascii?Q?sKzMLOBhdGpEp1K8VMqFeFNHb0Je3S1f8dO79NkE0Jny9QuW2jfIXRt5RYgS?=
 =?us-ascii?Q?S3ISHvQYkMRRSozOj9767qwm6U1qK7eMHbznXLzrvuyR4cKqrV3zocVN0gqQ?=
 =?us-ascii?Q?tLtMAOqQVX5MO8q+Ig98hrldcBGbS9pWxwXk2uNOvwku6UqOn/MbjkBzA34r?=
 =?us-ascii?Q?6Y3pHAE3W31kZ46CkBvTT/4CWVyIDlvdJruezqSWqU4qsCW1qjpRdcKmd6sp?=
 =?us-ascii?Q?ibHWa9kWOmNPK23YfMzyI+RltalW1JxcsH1BK1X5oSoReHxlr8F0YElnjAe5?=
 =?us-ascii?Q?zaljLc0GOVo6ZwBL9ybov8/4PKnDw6JVx5ecSSVStTt7KQYe0l88FDlejgaO?=
 =?us-ascii?Q?4OckfHEagnipgkgvzv4FsEvOOybo091rNr4y/UsuLET3eCEOGQ4VqSmPLEBc?=
 =?us-ascii?Q?Abob7taF24WaKGHvl6OnpYB6fzW4raw+8qetO1lGLjYqi81zfA3z78umK5Zk?=
 =?us-ascii?Q?JYVOq8ErskJmSfg6Ht449+Uuffs8FMlnBX/gQUPWsR6fRyBxJbByaTtiOqEG?=
 =?us-ascii?Q?rY6N87kVAyiGo0CW8w40ObBbEh9Rxp1090TJaQHCvkT1gsCmFmKXzgFmMS82?=
 =?us-ascii?Q?kVlv5KDu8kz/fuhscNWvF5nYVWdXZQIqg3B+KPGCRn3CGsrTTaOGfRJDYt0b?=
 =?us-ascii?Q?tbsjygzJvyJYArWETlUefLLeMRNiHbFadzoYKe+pDuCDT9UtyYYERRZGjBT0?=
 =?us-ascii?Q?KuBKzv29xDJ4p401TGqQUzdFV0JZWN0WsdTJbLj7z+/xGZQ6FkY/AAoEC7EG?=
 =?us-ascii?Q?Knzas90YSg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1ffe83-f0e5-4c7d-4d7a-08da2c3e274c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 13:17:48.6502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDlMqMVKaw3OFQTuqVQBCCkXCmDh6uus4mNyq9YiAUffIIiPhc9KjBnYiDpB0ufY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3798
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 07:24:32PM +0800, Lu Baolu wrote:
> +static bool domain_support_force_snooping(struct dmar_domain *domain)
> +{
> +	struct device_domain_info *info;
> +	unsigned long flags;
> +	bool support = true;
> +
> +	spin_lock_irqsave(&device_domain_lock, flags);
> +	if (list_empty(&domain->devices))
> +		goto out;

Why? list_for_each_entry will just do nothing..

> +	list_for_each_entry(info, &domain->devices, link) {
> +		if (!ecap_sc_support(info->iommu->ecap)) {
> +			support = false;
> +			break;
> +		}
> +	}
> +out:
> +	spin_unlock_irqrestore(&device_domain_lock, flags);
> +	return support;
> +}
> +
> +static void domain_set_force_snooping(struct dmar_domain *domain)
> +{
> +	struct device_domain_info *info;
> +	unsigned long flags;
> +
> +	/*
> +	 * Second level page table supports per-PTE snoop control. The
> +	 * iommu_map() interface will handle this by setting SNP bit.
> +	 */
> +	if (!domain_use_first_level(domain))
> +		return;
> +
> +	spin_lock_irqsave(&device_domain_lock, flags);
> +	if (list_empty(&domain->devices))
> +		goto out_unlock;
> +
> +	list_for_each_entry(info, &domain->devices, link)
> +		intel_pasid_setup_page_snoop_control(info->iommu, info->dev,
> +						     PASID_RID2PASID);
> +
> +out_unlock:
> +	spin_unlock_irqrestore(&device_domain_lock, flags);
> +}
> +
>  static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
>  {
>  	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>  
> -	if (!domain_update_iommu_snooping(NULL))
> +	if (!domain_support_force_snooping(dmar_domain))
>  		return false;

Maybe exit early if force_snooping = true?

> +	domain_set_force_snooping(dmar_domain);
>  	dmar_domain->force_snooping = true;
> +
>  	return true;
>  }
>  
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index f8d215d85695..815c744e6a34 100644
> +++ b/drivers/iommu/intel/pasid.c
> @@ -762,3 +762,21 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
>  
>  	return 0;
>  }
> +
> +/*
> + * Set the page snoop control for a pasid entry which has been set up.
> + */

So the 'first level' is only used with pasid?

> +void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
> +					  struct device *dev, u32 pasid)
> +{
> +	struct pasid_entry *pte;
> +	u16 did;
> +
> +	pte = intel_pasid_get_entry(dev, pasid);
> +	if (WARN_ON(!pte || !pasid_pte_is_present(pte)))
> +		return;
> +
> +	pasid_set_pgsnp(pte);

Doesn't this need to be done in other places too, like when a new attach
is made? Patch 5 removed it, but should that be made if
domain->force_snooping?

Jason
