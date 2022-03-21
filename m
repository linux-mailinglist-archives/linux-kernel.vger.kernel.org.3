Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56604E25CD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346979AbiCUL6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347063AbiCUL6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:58:07 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0162AFB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCR+j1Ocd/9UtER5NxgO4itfuze3BFYP9GvV2GxRaHOrV45HpckVP+InafwWHymoZ5KmkxkfblEGKMYN4FxkBcrkKwKuV3cP2PQKWSUc63104MqQLU9UzDyu6MQFhYTsKv69VWIJcH5wOCbELYAgDQ4YjstC4lcvTOdR64oVV7KIum3GbCqXEp6assx6rRZN/agBHv4ouwA92MUJ/0dc6tVNjGLYW/Sy3AHntb8L3tBuv1dRKq7CzNTdeon2oW4sSkNljEfY+5Zs8dJ2j/BnNelllpzg4Sn30efG3JE/UoaqfDYw3RK+kIdC/8EJ4Frt+nZj6D1wYy/FcmejjQuopQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zxVAMbYtX6BVtlsv6yF81f46bQhKpLboVV5huRjNn8=;
 b=j5MIBGQCFRvEaCzb54pgfKSRyQgtM/+1CG45y7jR4DliVUqfHsMTXXx3KnDwLB/lFmJ9Z5kAWt1s1jZeEWl2rGS3fv6FqIFxd4X4UWeOjHa5tfCW+rE72CeLNzTFc3vFh0g926zapArnG2bLWeVNDX1yDC3aFGHm5x9b1dfbQ0Hx2ddg4KFTW6c+aTNQWmO6Wm/rB77U6LfOUEsiqIaBDPEC8yvJS19D7HjxgBbaB+V6jEukEP4sZKEDhcZP3Ty6eCc3CGLR64EsgU44uMCIyWdlN8lGIAPwRkF0WPhE/1sMhKk7fr99lnMpiaKriit4FXWv8mejhxVSPRUF+UUY+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zxVAMbYtX6BVtlsv6yF81f46bQhKpLboVV5huRjNn8=;
 b=GpMmBagDJRlZ80AAWXTkqHvg6L/Thenm05rPUWGTuT24/WljrkIoQDrJ2zjJH1AYzFUwYMClyWG5L7Isae+xZpydOKk42PD2PhVxHJuCAuxfXnf/vVYqQxVNhLyz8DY3h5Be2RtSyxcCj/ZGohXfC3E1b8G/+drXSDO1C2S+a8wUb1XtrbLstNFwupXlAFXQRALmv8P926AYzfb0y3ey9/keSu25gc4Nejd5DWKC08zcTCQT7h2zXk1u64Ha7ax3PjydfvJETCIHCpUHBl8L/uo6Qb/S9wZ3Kz+90DlGL6N6k0YXAcWZ04lUH3JtN/mR7qny0QfxKx7ByomFn02gxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB2933.namprd12.prod.outlook.com (2603:10b6:a03:138::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 11:56:38 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 11:56:38 +0000
Date:   Mon, 21 Mar 2022 08:56:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 04/11] iommu/vt-d: Add SVA domain support
Message-ID: <20220321115637.GK11336@nvidia.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-5-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320064030.2936936-5-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0438.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 918ce308-a607-4809-b6ce-08da0b31db00
X-MS-TrafficTypeDiagnostic: BYAPR12MB2933:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2933D059857DE9E87265511CC2169@BYAPR12MB2933.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/q1SMYV56Gw2UrdDl+dvFUGOp1EjiPCOz/Q5Yf7KwUtz2jOJ2AMa7YKQaJ3RAg8wg/S1sxyHvz21+0R3V9KGlM/x/de2dKG4vHJyyAxYJUOFzFvNkYSx+wnf/sdSZIQ9H35s1xPbt2KWW6u+dLqBfD8a4X9AbJBitNFTb0fRBxXTgmunc9ZRODUkoDJ5twbOTWE+JXa7daiRuyuqj3iuAMV0BbzyM04FIwqx+G2Zb6lAP6T4clp+brk5Zr4lbUZyfmzzXpuMPogBjadCHkOdfV4l1GonCc4X5VC1AlPMtwCLY0v5A5ZXbj7blAMxwYgV2/HSaP+AGgW2BCBEmX6y7DUtTw16ng2KKoB+h9bkWCi272Tygs7wHoe9FqZsUI0M/ZMRLHLBLRPL56JJww+vRwBs3sLPbGWhdgQiAy+h9jn3X0hc7Oa/4NT+C1z3Mm8Qx/3xXvlhuUSkuZrsYT7u/4WkIb9FfahEdVvkfupyGk0oV96vyeqslc02/KdfIE3fWpB78dU42Cl+56euuwyHBxh40XtnYZx5eQSE6YAdqmUIYjXgZaJLHYABc8kdqkNyIGo7zH3/b13QGh9a05K9tW0bUAgpCyaoDQUPl6P/BR6tYTmhF/UaQt3NCh4ZOuPq4RzGPqnNLgdjUn5baUOOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6512007)(1076003)(2616005)(26005)(6486002)(36756003)(2906002)(33656002)(86362001)(4326008)(316002)(38100700002)(8676002)(66556008)(66946007)(66476007)(8936002)(7416002)(5660300002)(6916009)(54906003)(83380400001)(6506007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rxPonA27HdpcUQU0eVPHPo9Qr2xbGhz1byvP+mb/kTXEzxq7WFWChLfsx+M4?=
 =?us-ascii?Q?KjcsnVs/1gl0TsPfbUPj1Mm9CrieXwZXmFCF320X0IK0rmAMndqBHM8FqLqi?=
 =?us-ascii?Q?C3aKgbOlLKTCI/2DDGAYmat6KSBsumJkaY4SRh6eOWXCzW5BSK3HUI1DsWal?=
 =?us-ascii?Q?Fn5MDOyt2AyZRewCBN3zony1C6ggp6RJoUCSBeVcJz2uXxOEtntYtsY5efXj?=
 =?us-ascii?Q?HZewBFD+5CSU18MRHaJj/3KEADPHeD6hg7ibgVOhI+C7QaRSeGzviVLvv2Lu?=
 =?us-ascii?Q?XSwve5Dx9CoE/QdQBvee5WJAC/RYNLe2l4kOXCj+Z2HFdB/lgwMRAxLninu8?=
 =?us-ascii?Q?/ffnvHoEUZTmvFvzFG+xsBujM4rpjdsCg3c9wsUvCtNFiot/VbpuYaDmOAFe?=
 =?us-ascii?Q?FS03Iz9rMhdSdl8JT3d6Pr3pyqh/nW1+jChMoR60MvxitidGJGJ/hJt/9orT?=
 =?us-ascii?Q?9Wc3Nt+3xI9ke50gqpMMkDuir5yqB3L84qSnkBSk0EWqEYuPXUbA5ljfFz4s?=
 =?us-ascii?Q?fwSSP7VjU3Pnz45Vt6v2DlgBp6GWYen4V0VrITh27PsTWEOjzxA+G2Vk6MnJ?=
 =?us-ascii?Q?AKpqusZlNLuLsw7YgmBZm3DMs+C8lspDALGhM3nVQKx+jEvQIezNS4gVd4Al?=
 =?us-ascii?Q?sWKsOcad6rTPDLJg5SEmxUuro01nHDwToLr4NYd0XKazS8fJIr2ZuBkrRWge?=
 =?us-ascii?Q?W1Ws4/TrKFQ0Wj1/KXxVaqhE2T6p0t7eTZnZ0jM/v6SvJ+oGGkPg1K1BKMMz?=
 =?us-ascii?Q?0fXRU1mpSs3BjKeY8S+3ibadN50kGH08cd215u0EgLlWZ3V02+q+8217ewpq?=
 =?us-ascii?Q?C2Sykie5VhbsDSAdSSR9cPyYF9renXHsCj0jW2aTsWTKQW0PbvojHq03V54X?=
 =?us-ascii?Q?btbUUJCYGkAIvCQHucHLgIwvEWwcEdeMGoDfH0X3yKgiOdTQ+pMLl1G9RXoT?=
 =?us-ascii?Q?FNbu9k5qxAiImb0pI3kpKKETP7o2Yp/ffRlj/abaOOisCaxSfOBRgIYZr2Mt?=
 =?us-ascii?Q?I6HrSoxIh5hv2ej//qWZwdjBjq2c45r+KdLCHyh95MwXXi0iuXTlBaDyueKN?=
 =?us-ascii?Q?UVJDc87ZzSwEDf14efKOSpOQp7AgVLN/DqdEvbLpP9vEsnfz0aW0vOowyqYm?=
 =?us-ascii?Q?u+ZbHUGBmqL/6I6lDRBwbJDhwOym+VqkSNxnEA+k4T5LDiAv6ilTcKisNocY?=
 =?us-ascii?Q?0acf3WWPb+XVIX9HUqsl8h3WSlc+z9wNPlEAtYNfzLx8fTvZ4j2QMyQh/VBP?=
 =?us-ascii?Q?Jz1ZJsk7nRciQMknobHSG28r861fFhoytRPX8vLsuPj3nZCfBulg/0EghFs1?=
 =?us-ascii?Q?nicF80LDMy6iV3UgqJqRh1We+9RRDR06td5B3Z/1gzDtJCob3CYYikKjhQ6G?=
 =?us-ascii?Q?gjxdBVri6WsWj3IKi/2r8GfKEdJsZUQxSO7MbWL8avr6hhRWozVPSkKbasyK?=
 =?us-ascii?Q?qfRhLH42tc6pduYs5daEjolr1HV/o99m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918ce308-a607-4809-b6ce-08da0b31db00
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 11:56:38.3468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0Tg3xJMojq+2g2fTSrG0mBavLmz1MI4GhPA5qiv2AAFftV5DnXqu8QjiwWrG7AO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2933
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 02:40:23PM +0800, Lu Baolu wrote:
> Add support for SVA domain allocation and provide an SVA-specific
> iommu_domain_ops.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>  include/linux/intel-iommu.h |  1 +
>  drivers/iommu/intel/iommu.c | 12 ++++++++++++
>  drivers/iommu/intel/svm.c   | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+)
> 
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 2f9891cb3d00..c14283137fb5 100644
> +++ b/include/linux/intel-iommu.h
> @@ -744,6 +744,7 @@ void intel_svm_unbind(struct iommu_sva *handle);
>  u32 intel_svm_get_pasid(struct iommu_sva *handle);
>  int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
>  			    struct iommu_page_response *msg);
> +extern const struct iommu_domain_ops intel_svm_domain_ops;
>  
>  struct intel_svm_dev {
>  	struct list_head list;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index c1b91bce1530..d55dca3eacf8 100644
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4318,6 +4318,18 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
>  		return domain;
>  	case IOMMU_DOMAIN_IDENTITY:
>  		return &si_domain->domain;
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +	case IOMMU_DOMAIN_SVA:
> +		dmar_domain = alloc_domain(type);
> +		if (!dmar_domain) {
> +			pr_err("Can't allocate sva domain\n");

Don't put random pr_err's/etc in drivers. At least try to use dev_err

> +			return NULL;
> +		}
> +		domain = &dmar_domain->domain;
> +		domain->ops = &intel_svm_domain_ops;
> +
> +		return domain;
> +#endif /* CONFIG_INTEL_IOMMU_SVM */
>  	default:
>  		return NULL;
>  	}
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index ee5ecde5b318..b9f4dd7057d1 100644
> +++ b/drivers/iommu/intel/svm.c
> @@ -932,3 +932,37 @@ int intel_svm_page_response(struct device *dev,
>  	mutex_unlock(&pasid_mutex);
>  	return ret;
>  }
> +
> +static int intel_svm_attach_dev_pasid(struct iommu_domain *domain,
> +				      struct device *dev, ioasid_t pasid)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct mm_struct *mm = domain->sva_cookie;
> +	struct intel_iommu *iommu = info->iommu;
> +	struct iommu_sva *sva;
> +
> +	mutex_lock(&pasid_mutex);
> +	sva = intel_svm_bind_mm(iommu, dev, mm);
> +	mutex_unlock(&pasid_mutex);
> +
> +	return IS_ERR_OR_NULL(sva);

Never use IS_ERR_OR_NULL(), fix whatever is wrong in intel_svm_bind_mm()
that it can return NULL on failure.

> +const struct iommu_domain_ops intel_svm_domain_ops = {
> +	.attach_dev_pasid	= intel_svm_attach_dev_pasid,
> +	.detach_dev_pasid	= intel_svm_detach_dev_pasid,

Lets have consistent language either this is called SVA or SVM but not
both.

Jason
