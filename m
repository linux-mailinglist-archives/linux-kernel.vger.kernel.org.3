Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F32357EF8D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbiGWOVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237950AbiGWOVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:21:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386C5DAB
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 07:20:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NC6KbM+GYAy0Rpop+hV/y5xixiLz8XeRlclRx9Y0cy/J+QjenzW/XTPnJiarkWDGsXJm7uObRTL1vE18UW+l9lqZh5S/DVNMOcybcUyxbi0Go6gsC7rPdTKBqboV5X/gq8wwcQkRA/Lkho9oU+Ye3BkNfQX+Sk68ytM8jdscheoJ81AtehT4FKtJLddLyWQ81uhqdSz0O2lB5uNdU/6GwMMPOIP7w4g9cuuhhh4Bq0TEsYm7TtW4cFCvKBglqNU2t2n1b/i9XjNhqH4DBFAfeADGJxMj5hqGh43563Y+4IZTkqOd/SlbnI+FGitxmuhPQe4o3Xwv43e9C/ibr9VlYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoSeOPqvt1XnMlfQg/0Lf9tU7QtVvrVIHGr+hOePtV8=;
 b=DU1MgTPH/AQSDiiSp289WRWO1S/Z2rcldWliBpGoFUVYSRAeyhi66aYRKSxdnyIhxQy1GEZwCnDxEVieEtcuYcAWG/MQK4hyaUAPG0GiN5Z50ksVjfngrGUz/cCxUbITkv+yk+iKxupJpQjCHzcaW/k2x2SNOOschgSjZP9zoOyjL+nOhZX4fGd2OpPBcQA/pRWXE0+EGl3arVnczxNU+umHri9FeXMgFpU/7ZQWqwNhfcAOw20ImnQ8oNK3quegrRTgg2KQCXsWjxyZycDYNqwRkg9bGQ4iXoT6dO5iyXPAALp1mh8dn2vm8K74w7mdsQYbT8NgHviAAq01/2ODuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoSeOPqvt1XnMlfQg/0Lf9tU7QtVvrVIHGr+hOePtV8=;
 b=XVFe2QBRy3ZZb6VF8tnm54Ck0gxm3p+mBZDmOVWtQcKp/S1fkfXobyKLEqLnOkckpr0pNRQfIbVJanXUTMHZCqGwEnrbMO5hu2yqrSmmsqcHYNBXMHe0zcGescsQ0H72s2G1M9KX8woX61Um87qfvJah3ZmqBUV85vg8vr8cAmgZ807tqlZQVteXv1V7D20NQJCTmRckRU+ImpROtM1Jyg6Ej4fRD/ItQAEM5f8fNn9foUjj63FLMcnYbzLfn/KXywmFofiLTt7AXnU/1tKSrac/AmhUFUux3obV9pjMwxYLy1DINo6ID12sOOxPM8oF1o3j0Ta0xr6H75nhsDFOhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Sat, 23 Jul
 2022 14:20:11 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5458.021; Sat, 23 Jul 2022
 14:20:11 +0000
Date:   Sat, 23 Jul 2022 11:20:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
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
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 07/12] arm-smmu-v3/sva: Add SVA domain support
Message-ID: <20220723142009.GG79279@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-8-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705050710.2887204-8-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0189.namprd04.prod.outlook.com
 (2603:10b6:303:86::14) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64325e67-7c80-4e7d-2645-08da6cb6741e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3308:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MyElf92Ms08Yp6ZJUt2hjPv5PdzwfE4HogWRr3CWvI0ldWHUiNqrSb0E+49BLVatF17AM7aVSd800MhIOnU4KnvG6OZroSQaQP13gOHkraE8zyvPVG/NIfSTwNTT3HNgUly7pBPtrODbDdDWywG9h/r62XnKfhl02HAwWdx4qLPCY94Qk8CfFVwGUwHSlJad9siwUN0vUnPwBZE5RSN81CIeUU41dGQZAQoNj9rjXWfFJtfzFN493+pjPohWbi2xoYf/rO+Nr6ncoZEXoV3jEKYqVu+iIAwLxCGKAiMBtYfce1JWcEttRBI51hK7TMfWu96NK/G3SJ5OsYrT0A0oCH4S+2TkWFHDGoLGpvflTsExSVQ3FtGkvOBwrE0NedKacpH3MC5HB23YmbTyDAWA1Pm/iN8TxAZBza6MXiU571dOdO09OvQQOTnF7nI/33TiRBJ5PAYfTF7f47iolqkvR9/Th82Tlwp1JoBcZPppKNgBEfjD5nzeMEfNy5hByVEPfhtU4Q/pZqDiIE/er4Cv8Sj/kMMU8zGRC/zvXEsyiAiRDo1AH9EvMgNx6BJXF8au+mwSFUd+TW+RPNGOOcbzh8mUID7qPHEKJDFqZ96DgIE2G3OoQVyMFgnd50KrjZ2W/UAryX/TzwMFUgVxYLvmKJtsxh1KrYby2QQwnNdTGsCC5vgZ2nkzmQF9570D/erVtNfubZSEP4mlJzvKzAwtznWJ/ye0kAq+09U7C5f7DdrLZS4OHTZeQ9x2Mi4/vB3I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(316002)(36756003)(38100700002)(4326008)(5660300002)(66476007)(8676002)(66556008)(54906003)(33656002)(6916009)(66946007)(2906002)(6486002)(83380400001)(26005)(478600001)(41300700001)(6512007)(6506007)(7416002)(1076003)(86362001)(2616005)(186003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p8HHGoT8xXmTTn5rKNiNplFsPGTACmUCGNRxZf0qoDlz92WZWqixlviT1hDE?=
 =?us-ascii?Q?uYrOh+neikjLLObyTLYmgxDqOhehlasHYTXvwhHbWIvlRtFBsDrzFfoV6jwR?=
 =?us-ascii?Q?NphVAaoui1wMKig0fP6Rom1Ibhqk5Qeric2PrftZcoRLbULkrj8d0tPzghXs?=
 =?us-ascii?Q?S1HoULBb64Skykgi7l005VWMuRioiuzXMUv4eglZLthfhHD8j57BLbAAU9uW?=
 =?us-ascii?Q?RZ46WXR7iR7JhTPjJaiEindHpIi1g5ZaTm6aKl7Wjoljlj9qDUzTwZ0FMHfU?=
 =?us-ascii?Q?3wEMOt/1z/I6xKesnzOOf6hQV3piiDvQdvMCNc3FPv/Y+qsqn3kUva/gUwhK?=
 =?us-ascii?Q?ImmQYKTJRGY54hoZwdcYXmlbfWXy5dRtM/bHqO8rt7c/A7M2CsBPakpCAetz?=
 =?us-ascii?Q?8qChL7P4JwDV7LywHpF9G64wZC7c/+rLhO/pLTTbcYF+ONe+mZh5dLDTTr09?=
 =?us-ascii?Q?zSttiqgvTya96En1WMQVLfLPfiM/S272SHb90eq/KCsdU+P36/NRWmRzliDE?=
 =?us-ascii?Q?enR7oxxxgNvilKLnZkd4KvLK2Cw3ASfPlpl6m+qhM/BQmPjJuEPT9Elg2mIE?=
 =?us-ascii?Q?n7XjWJ0uVWU8+37eLCYUj8r22L0M0qaG7tjmylgjmqos+ABigWT9zriTW9e3?=
 =?us-ascii?Q?AxNIz4KyEUpGmq008l3hO7x4t0nrQSO93ePlZk4wmGrSheKwl7C0LfMyGlkb?=
 =?us-ascii?Q?ls4Uyp9XCeL6j+qzbRZiabzVsUejQesyjv3+eCLPmt5g6Mn25zAFBnF2Sg5I?=
 =?us-ascii?Q?/VfRBYr6UnOp5TcL6GsbqRtjvkw/8KVGqypu1V7MdmssAFPv2Zaax7d74+uv?=
 =?us-ascii?Q?dMeEmkVoJGaK50IZDWdSTaiKnxK6rsEe4C4WAZT8AJaiebqz2bSVv6fey9+5?=
 =?us-ascii?Q?ftMuf8M6Mr+UX7al0DlFG1o34AhyILS+1Gl0R3l4F7lIUV2xlLwa7fH0FtDB?=
 =?us-ascii?Q?uUe8kqHPlMpEU8g2onhUNjZ9I/+HtDD/8HtpqVxEg6WmKnfaw+LNoR0sAp3g?=
 =?us-ascii?Q?8Pwv5rpWmnJi58lK7Po0w9F+zdIbVsI2+5mRvweqPhwEmUjYJGV+lTpM1MbQ?=
 =?us-ascii?Q?yRghZWAS03sMpWUEdk1/nrWH6kzafr+SzwEA48DJkxbAU9ERpv6l86TQV3sg?=
 =?us-ascii?Q?eNEs+X1U6p7/LnYiwC3cfR32vCyh5yglbbsrBBoAs9vNJNGiHGT4m78brJtj?=
 =?us-ascii?Q?znzIv1bYKAUjYroGjodexSsxvUewaDFOTVggnkpAX+B/iDESww6cZkuWR098?=
 =?us-ascii?Q?XB5VEDYUkzBmS9mOf9rBkrtzDLHm6/rr8x1KJp7/zv8l8eYLMqzP7EAMN4JH?=
 =?us-ascii?Q?m2tSw2PyyaMdXAj7h1pnizUMGWQrFoZEHFPPqhR0FDlRGB/4BHms+KdxByOJ?=
 =?us-ascii?Q?cazPdOodk/Bo0Wz8W6wycUe+FZ2wUekIPSa251h+DDb8v5EYSFurk8XNzzMt?=
 =?us-ascii?Q?+Q8IEqu5J1CcxHnK7WOkp5igIJAmtWlLn79AMleJUz8QoQEIsvFerfZ9/vh/?=
 =?us-ascii?Q?wMFP9zsxNSEJKz0s5Nk+yW2rYLT5CjfOfyoQ9/8pCVVKtFNArdJmNvqWdXz6?=
 =?us-ascii?Q?bMTtDYoFZ9xZ8K+Wdi6CO5fsOo0aPin19TY/R3Eb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64325e67-7c80-4e7d-2645-08da6cb6741e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 14:20:11.5264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1TpeSAbfr7w8WMOKFLWq6tNdANPvsL4F43x/0eU0knF+6SefzfuzW5ZjHBM0HwW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3308
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 01:07:05PM +0800, Lu Baolu wrote:
> Add support for SVA domain allocation and provide an SVA-specific
> iommu_domain_ops.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  6 ++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 69 +++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  3 +
>  3 files changed, 78 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index d2ba86470c42..96399dd3a67a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -758,6 +758,7 @@ struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm);
>  void arm_smmu_sva_unbind(struct iommu_sva *handle);
>  u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
>  void arm_smmu_sva_notifier_synchronize(void);
> +struct iommu_domain *arm_smmu_sva_domain_alloc(void);
>  #else /* CONFIG_ARM_SMMU_V3_SVA */
>  static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>  {
> @@ -803,5 +804,10 @@ static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
>  }
>  
>  static inline void arm_smmu_sva_notifier_synchronize(void) {}
> +
> +static inline struct iommu_domain *arm_smmu_sva_domain_alloc(void)
> +{
> +	return NULL;
> +}
>  #endif /* CONFIG_ARM_SMMU_V3_SVA */
>  #endif /* _ARM_SMMU_V3_H */
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index f155d406c5d5..fc4555dac5b4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -549,3 +549,72 @@ void arm_smmu_sva_notifier_synchronize(void)
>  	 */
>  	mmu_notifier_synchronize();
>  }
> +
> +static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
> +				      struct device *dev, ioasid_t id)
> +{
> +	int ret = 0;
> +	struct mm_struct *mm;
> +	struct iommu_sva *handle;
> +
> +	if (domain->type != IOMMU_DOMAIN_SVA)
> +		return -EINVAL;

Not needed, this function is only called from the sva ops, other
domain types are impossible, we don't need sanity tests in drivers

> +	mm = domain->mm;
> +	if (WARN_ON(!mm))
> +		return -ENODEV;

Also guarenteed by core code, don't need sanity tests

> +static void arm_smmu_sva_block_dev_pasid(struct iommu_domain *domain,
> +					 struct device *dev, ioasid_t id)
> +{
> +	struct mm_struct *mm = domain->mm;
> +	struct arm_smmu_bond *bond = NULL, *t;
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +
> +	mutex_lock(&sva_lock);
> +	list_for_each_entry(t, &master->bonds, list) {
> +		if (t->mm == mm) {
> +			bond = t;
> +			break;

This doesn't seem like what I would expect, the domain should be used
at the key in these datastructures, not the mm..

> index ae8ec8df47c1..a30b252e2f95 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1999,6 +1999,9 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>  {
>  	struct arm_smmu_domain *smmu_domain;
>  
> +	if (type == IOMMU_DOMAIN_SVA)
> +		return arm_smmu_sva_domain_alloc();

If no drivers are sharing any code with their other alloc paths perhaps we
should have a dedicated op for SVA?

Jason
