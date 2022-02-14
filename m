Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EC34B528C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354836AbiBNOAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:00:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354803AbiBNOAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:00:52 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2048.outbound.protection.outlook.com [40.107.95.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DCE13E31
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:00:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kggQ5+47nCu7mdHEyGxq7p3hF27hAslckHiUk5Fw6Pt42+UOPHw2HEPWZAo2r6PneWxC01m+xde3wx7ettSweyIWmGcYBgsmNQoYLMJHJsjSt1X4elIlWpQMiUTB0j0wQvBG2r4dg1yNbHIkel6b93BLdiNUuSbbTBseufmekDu8qAG9q4zZdrQQ7saOvJA+Jue2OYAThUOQEsToQwH7/1uv7RP8glqmGGZVG91ZDyZxZrJSJsRP8RZw0Go22jJ63J5qg6Vb2/95H8MJw1bA86cD9FSG+ayj9okRLq3t7gkWOG9LjWsQnXvDeB3Egn4+ap/VwGpKsWJc5b3sDmO5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnjz4CB/IO3eIgwCv8nFO82NZkL/XAnZEtKlaFLjQ0Y=;
 b=YCcN/3i9gT6aZVSDvusw+qc0x0esJh+TLhH34+YklGlFMbERFaRdpoxNueQmV6/TS3IP6AD+a0n/zbtMGPYflnPsIAt6PhzEMTa32rXvjBRAe5OauYuIW0rtt1w6ZlfPSYTGZ2MAKUI5bxbe6La60o1/a76W/q8UoutupXYAnJ78kYpkC7FEwrvL2QXeDBmhhngQDOb6nQGkXozeA1BeXgrLM+kNdyv+X5HlL2YWd4nq9WCPQfAv85kw9hVXSfaddpwmAQ7n9Qj0ABnRaChUQSHOW4Njc647JKWczeeV5t/FdwVQ+jc740XIwohDRTc9e9TCHhXzYQYYxA1quTvq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnjz4CB/IO3eIgwCv8nFO82NZkL/XAnZEtKlaFLjQ0Y=;
 b=MXyga6ewHuwWUqFkeh73rGEkOeTJ9CiWAmQm1k0Ec0i0yFH2PD+CjBc0qzQmwDvq8HydOrYTOHSLqIym/Os3U0mbXjFqsQMc5EMe8997z9KxS/qHfglIHlf1eU/ZlZcc7jDlZz6QJpQJHDAYq/43G0IhUo+gXEru3e7ggA1/kNOrS7hDrKwLvnk8mT6U3piRL68ge7FTa+yfEzshHqrtEOo+CetFEij+tzXWzwthgmyQ4gKHSno0RA1IHYE+AuPW/XHt70Fqqe0ekpmGZFUfr9RizTbXh9na1uCOtLOYgHdZ7jnT/oSPuXINrVML4xKMUAddgtetKF387jB4s1MW1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR1201MB0255.namprd12.prod.outlook.com (2603:10b6:301:4f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Mon, 14 Feb
 2022 14:00:39 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 14:00:39 +0000
Date:   Mon, 14 Feb 2022 10:00:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/11] iommu/vt-d: Use xarray for global
 device_domain_info
Message-ID: <20220214140038.GB4160@nvidia.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-11-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214025704.3184654-11-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:23a::17) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4df66a9-f3c5-4099-e404-08d9efc261d4
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0255:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB02559FCE9383E704F4CD47CEC2339@MWHPR1201MB0255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y8PkYzi++iS5rRY6M6hR0KxWVESElx25pi4OIqBmEQb5tNIk+oOKweAYbMOB3Ni2bgoGqlVJHks0P0EZB0Krb1DmMpeO2uWlBD4dn7z9mlH/SwzedmH5+09GMuFIBS6J9GcBQFkensSQ7Tsvmp+zCKtvzm7+EeWdHxW1MpY2XMv7rX9M6w49Kb4CYl9dBEk7g2eFqjuyMLLKf2IM2bRSs0y32UrKFZDh286Yd1Xbix0RTlQQDCl64SzTfi5EHCaXl6sE/m3l2zmdpH5iCDLI8+8BOCUs1/Iz2ILm9rrfrt6wYgrXzBDal4we4tMCKEmrN79xW41qOViHrj9lIBLugn2/yxcC1SsfFOonrAyrGCUU1KaK04v7mBfNu3YQ5f4Rr/LINMkfrIj6KjToOwK3w1GgmbyY5pebFulttQ5qqdDlUJ/rb9P5aNgYI7fn3XNzqHiYpaktN+MFyNqxzeb609uAfmXD9/ZijG306VLrZbebXVGNfoaDd3FCrT9f8e/uSGMZauyt8GEvvhOQ7Ej/jx+HqkgIjuNNGSCET1sghDV3tRtoncR6JEQvmZYh5odguAP4q+KhNELWg/aoeOEf9lETQKYZHwtxLkojMaTXwSFoR95ycylkYfio9W0zdFRr3dC41sdV+z0JJwQEtgSLcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(4326008)(83380400001)(2906002)(186003)(7416002)(8936002)(5660300002)(36756003)(33656002)(508600001)(66476007)(54906003)(6916009)(6486002)(66946007)(2616005)(6506007)(1076003)(66556008)(26005)(8676002)(6512007)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9PesXHtYZAZnVkOmmFoarmFYNoi2wiycT96WqL8fuZ/a5hAiKR9bCrn4f++L?=
 =?us-ascii?Q?NsUN6t9Z9HJ3zHUs9uA8M6nAjGYV+GTuwTb+zPzOaxew/CSmeuiDfeCd+BTA?=
 =?us-ascii?Q?MDNm9mzA3ZaeSS4jjqAKoBA+asvAFhYEBUWwFp6MAR6tARItavN0vnZ1fblH?=
 =?us-ascii?Q?h//i6D1M8cgg/bscEl8vLreeX0l5CkEMLpKkKSJmGYsp8WbQ5a/OdpKhQ6Qx?=
 =?us-ascii?Q?LxFuR9M2m6a5k+6dWzMGEgJYhF9hUJKovKzzoUHpxsiIfqE5VPYcw40H8/Ej?=
 =?us-ascii?Q?RRUqAfmpq5WTkncccwBe3GF/KEvAfHipM1sInbvNJ2MxLm80q/iwguYZJbNJ?=
 =?us-ascii?Q?L9M20vnPX7WLM8mLS/AwmsiPK74BvLJ03LrOSDMhW2o9gijm/HPf3CT63VSg?=
 =?us-ascii?Q?bofUa3Akg+S6mI2NocauAAoyfiY0ED+hQpBrLpTDqDuGJsLkDvoEmxSij52X?=
 =?us-ascii?Q?kvzBRWKrPjWx8f9nYuvhp9otyK/bMK4PkuN9ySjgXfgC5vfV18VTUINiqcvS?=
 =?us-ascii?Q?VXJOFK95LFFm9lNg1pdxGVJfc6ocvJy+1Xv1aosV/xG6Yl9LND9YveKzeS96?=
 =?us-ascii?Q?BgB4DUzTwdQZCop5yzfdTOJCnmBGEmttkdl8D4nNySAEbjHc8zZPtB+3sMBv?=
 =?us-ascii?Q?PJx96YB36oEAqRmlDRSDi/2LXzuT8IYMsrm8PARibtiXUiEm+00OH12k6SGQ?=
 =?us-ascii?Q?l7ZLBaSGnThS660nc9i+m9zgm7Hpl0DrFtJU01yKRQXn9LSLyN2WQmCBM86S?=
 =?us-ascii?Q?TIPUR3acTVMGi42hpNWy2xVR+LT7Qm3csBXiuQEdpU0QAjh8DdYJBXF0jW6r?=
 =?us-ascii?Q?NT2LiMa49XeQ+AJqZ25jDAPmu0Q/PYJ43P/whsfcq1e333/sImjC21nG3C8G?=
 =?us-ascii?Q?DmPzBHALaB1gDyzalvEA7qybbQWCJ+i1uDjyDUP2VjY7CLerNG0ewg0b1pq4?=
 =?us-ascii?Q?kGqv+1viMc06DlUns0GhPSPmFvA1n7cBdVghiqI/TNv0Q0meFU9d9XMpflIj?=
 =?us-ascii?Q?a/KyL2gCijJG7qqWkVLTw3/dIvqNi0+F6NmvBpt5w3afYQgtaJn12Xwmb4wo?=
 =?us-ascii?Q?idp/y/1gOV9GUUboRLNifdZzFwqLsF7Gs6St3HKITLD3NCrzXnzrqFq0pCj0?=
 =?us-ascii?Q?0iXQS94C5SOiZTmQjgTmGidBgGeGMmt8EQfme7Jfj9Pp3NBJmRlAO7yFEplx?=
 =?us-ascii?Q?YPxAch5rdkkcvO3jb6M7Q+BZIOO5jEfR+M1f+O6Q1K881kpsTiItu0dZf2Nx?=
 =?us-ascii?Q?UwprhqGEt/eLGFIeEihoMdxqKgNJcYZ39ev/LmxlLhTmgzEtlRCIJXylPmgf?=
 =?us-ascii?Q?ayzqpgZmfblLWvnJ1PFaun80xegZiZ+BL7MEr1QtakzWhef4yLHcf0JYTFGu?=
 =?us-ascii?Q?xS3P7TyqUibhVp2uT3HA3KSC/iD0PCwbVNnwDUi+0UMMfCFb0bXQSpEjRf+0?=
 =?us-ascii?Q?prkuH06k1L8IcYDR78KzrJwEZoHg+IL6qnzVWyFqMPT2QqICWPEgAP6gySzI?=
 =?us-ascii?Q?L7fsNdgqCLGHRTP5mvsSTdwHh7cBy0NdKM0Cqpn/bm/60Pz1gN3JDYxtRiCQ?=
 =?us-ascii?Q?vYkHw8M/KvBVlHt9Ec4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4df66a9-f3c5-4099-e404-08d9efc261d4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 14:00:39.6014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDP90rYovIhCZ54Pr72or1G6ncEmi+A6jj8RkTdGgSXala+zKuS3/ma1JOvKiFrc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0255
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 10:57:03AM +0800, Lu Baolu wrote:
> Replace the existing global device_domain_list with an array so that it
> could be rapidly searched. The index of the array is composed by the PCI
> segment, bus and devfn. Use RCU for lock protection.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>  include/linux/intel-iommu.h |  1 -
>  drivers/iommu/intel/iommu.c | 72 ++++++++++++++++++-------------------
>  2 files changed, 34 insertions(+), 39 deletions(-)
> 
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 03f1134fc2fe..aca1c1cc04a8 100644
> +++ b/include/linux/intel-iommu.h
> @@ -610,7 +610,6 @@ struct intel_iommu {
>  /* PCI domain-device relationship */
>  struct device_domain_info {
>  	struct list_head link;	/* link to domain siblings */
> -	struct list_head global; /* link to global list */
>  	struct list_head table;	/* link to pasid table */
>  	u32 segment;		/* PCI segment number */
>  	u8 bus;			/* PCI bus number */
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index fb17ed8c08f3..ecec923ce191 100644
> +++ b/drivers/iommu/intel/iommu.c
> @@ -131,8 +131,6 @@ static struct intel_iommu **g_iommus;
>  
>  static void __init check_tylersburg_isoch(void);
>  static int rwbf_quirk;
> -static inline struct device_domain_info *
> -dmar_search_domain_by_dev_info(int segment, int bus, int devfn);
>  
>  /*
>   * set to 1 to panic kernel if can't successfully enable VT-d
> @@ -318,30 +316,34 @@ int intel_iommu_gfx_mapped;
>  EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
>  
>  DEFINE_SPINLOCK(device_domain_lock);
> -static LIST_HEAD(device_domain_list);
> +static DEFINE_XARRAY_ALLOC(device_domain_array);

The 'device_domain_lock' should be replaced by the internal xarray
spinlock, no reason to have two locks.

> +
> +/* Convert device source ID into the index of device_domain_array. */
> +static inline unsigned long devi_idx(unsigned long seg, u8 bus, u8 devfn)
> +{
> +	return (seg << 16) | PCI_DEVID(bus, devfn);
> +}
>  
>  /*
> - * Iterate over elements in device_domain_list and call the specified
> + * Iterate over elements in device_domain_array and call the specified
>   * callback @fn against each element.
>   */
>  int for_each_device_domain(int (*fn)(struct device_domain_info *info,
>  				     void *data), void *data)
>  {
> -	int ret = 0;
> -	unsigned long flags;
>  	struct device_domain_info *info;
> +	unsigned long index;
> +	int ret = 0;
>  
> -	spin_lock_irqsave(&device_domain_lock, flags);
> -	list_for_each_entry(info, &device_domain_list, global) {
> +	rcu_read_lock();
> +	xa_for_each(&device_domain_array, index, info) {
>  		ret = fn(info, data);
> -		if (ret) {
> -			spin_unlock_irqrestore(&device_domain_lock, flags);
> -			return ret;
> -		}
> +		if (ret)
> +			break;

And you probably shouldn't try to use RCU. It is really unclear how
this function can be useful while racing against
intel_iommu_release_device(), eg today the only user of this function
does:

static int search_pasid_table(struct device_domain_info *info, void *opaque)
{
	struct pasid_table_opaque *data = opaque;

	if (info->iommu->segment == data->segment &&
	    info->bus == data->bus &&
	    info->devfn == data->devfn &&

And even if you kfree_rcu(info) then 'info->iommu->' is still racy
unlocked.

RCU is complicated to use, it is not just a drop in replacement for a
spinlock.

Jason
