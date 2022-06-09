Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35415544C86
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242625AbiFIMuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244058AbiFIMto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:49:44 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF2C13F417
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:49:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPrfkcXK2PXPzXHsP4b4CWgRuB/3l7icxQUQoV3HfWmgPw+/lAu9bvG8a06/5Duov4CfbimpXmSl3PigWAmLDHEdtLMIynOlHbva39MDPs/fcpw0ykwCBoVocBe1PPRKUhKwrjbK8aov/xkcIm/yPNukJ9jSLarsLABSQTZAKscVCvRewrLl0B2jlQkTNqFrYn8yeIJm/N7i32v6iZv6vB8Y4Ur7LaSZpOrdMKY9R5Zuxi3PZ5mFG8afomHK7FG3S8IYOT6rbWLMJYjBN03BU10fkZFge1CZbIDFFjIYYB367InghoeLXax3vdU2eQDugxL/iNVgpygGa3Wcywrr9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiR6t5+pSdKWrFKHBfimFDKnSYV6DsWMOHtkI9YFpG4=;
 b=HcdJVcTezDDTcjWzRc1Mu9DuD6cfjDFbbhtbXAGC33By55XG4Vf3GzwMt4dQPr/wmfw23+HsfZvGWoLhiwzBX8FS/baz4wPBL0my5z0k5n74ng+1gOKDvPx4HFEbdqhpMosdsAVRpto5sXStFoksLK8JY/p3ab+DH+g2icARzzdB4mvos/P8+rcan8BBJhT2+cCgO5niIFkNL1G3TcrQrmW49H6erDShJLKmuO2tIMj2yFOII2d2GX/lPArHg+jvfird9+rivmDWM8I9LqChv1VrZcXgkZTjmLERwrA1BesJXmZe1ZSP/5WghWI6Amb1ienGIT2gFp0NLUSCwvjr0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiR6t5+pSdKWrFKHBfimFDKnSYV6DsWMOHtkI9YFpG4=;
 b=Iwg5dWiN+/SfsrBAQIEo6tDxFbxcepcK28mmKY3dPC4w/cXcvLIRvucOjLNWyAvW1SpiOoTx/rhKZZ2i+faC/8LN7Iky4/HKdmoPtOxBtTa0JxN6Kys402RVDes4WLNgzujyRbvwRWdbbp1TTYmc44R6skwxBgUNHTTdDGJ2sr5MA+OzgSl2NlmEcwo/oyc1FcvieENXznXvWuf6fL4skAIr07ZTBEz08gcY+F6r4J8zhhyNBxoCrvs8sw0jd6EtqNirp2JkFkO7HLgmqP1WmJ0PafAk9T15iQLz+UQqOKAEbSOZbwVxEevjXNQT9aJpTr+Alw6SFeCfefA5+HaPbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB3414.namprd12.prod.outlook.com (2603:10b6:a03:aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 12:49:37 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 12:49:36 +0000
Date:   Thu, 9 Jun 2022 09:49:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCHES 1/2] iommu: Add RCU-protected page free support
Message-ID: <20220609124934.GZ1343366@nvidia.com>
References: <20220609070811.902868-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609070811.902868-1-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::20) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ef616b7-0835-42c2-0ae8-08da4a168269
X-MS-TrafficTypeDiagnostic: BYAPR12MB3414:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB341453438CF2D980B126062DC2A79@BYAPR12MB3414.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nUvcY8IsXq+0Ne1hcH9Crh2Ozbw4xWZcFeycYCmzooEaSI1cF+NG4Fp+cy4njAcDqD700rTZHxIAKZNh6VYeGMMeVAamTNi1HEc6STv8vcjXcpL3/pJmkVdOeSPqMYjLswnJTWilv7j0tPhWreQpWmzl8H2TqQFzGQtnC3EHXc2pXJpLHjvKSTisL4r297Nz+NqqmWKIQV2JdkvW94DsAxzJDbVu3YEXGcdzY3G9ogMW0FZQTv6JV9UmFBuV0bXxe8ngOtvt+lKwn+ClbdRKAhsJfULw07vLYtob4NHot2acHcdEza3wGbCSLXHyP2jAZ6xZH+yk8yVjBRIcCZSRvPo9b+w+D5By1Ym3W1gNZGtG3q5ixSUBfPM4ewHfNOMPVkbNB3CSehJiiX3LxeLac52+nTwOSuVo5+s+DksKnWTFR0SMWhEFag/S2kGnzlde2vlnYpF8odjnV5rOxW2Q+D0v6K7zbyYcjwa5X3oJ2wIZ/sZj/dJPRWy9CRUvnthnWgKlYxJFrQFyq7ieBiZqmfBS0B/7nY6QxFaUkDEpdHPbdDAYD+ADFyg6esAYAF8ANhO447VIymWy4NzaiDS0r8hMVTQD7AKNtzEQM9GsOOCYWVgB8SDdWfT99r0p/ka7hz4rXBsjlZlt6UgojoyJsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(6506007)(2906002)(5660300002)(26005)(8676002)(4326008)(36756003)(7416002)(33656002)(83380400001)(38100700002)(6486002)(316002)(8936002)(2616005)(508600001)(66476007)(66946007)(66556008)(186003)(54906003)(6916009)(1076003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vOwComiSHds8ey72HuXypSWNTIUTBNrCrDV67XDPedZ0Yb9ad/npTHZBj690?=
 =?us-ascii?Q?4syO8+JMzflK1HLWet7k/Iriyud8Ihs3cActKq290YST3B6UuXG1noD7SILc?=
 =?us-ascii?Q?vAgUYrg9J7vUfh8H2rhGRiExru43KuxVmQ/QSKovSUmwcSiwTIT875LMKduN?=
 =?us-ascii?Q?z+Cq41MX10RW32Qhkh/M1iZVR9cglovQtJ8Los8Mtc0Qj3U1lTw8P3VP1JCT?=
 =?us-ascii?Q?sb+tGV/WjSW9LQkEWRQhSyEW/aHhRgIl4V9OSGRq0zx8Mv+m95UIJuB34HWA?=
 =?us-ascii?Q?EjYW/fhpacekt/9y/dJoZ0nUPi+v4E77Io50Uq4MC8kiU0Mf4dRq73OUfqJ3?=
 =?us-ascii?Q?DOHpTPgjH9sjbk2fGbiH/lSOAxUeoQUUaXOITH2lXCRF7ImzSFdR9EPEjqVE?=
 =?us-ascii?Q?c6lwr5fympYaeONf8cwy8i5KI93xfiBaOGb5MmcWEquXSd/g5Z24YN79ok/R?=
 =?us-ascii?Q?JiR2iAiXAFHfJwuDx74E4n3BxDteMTq3uU/jeCFsVd/kaUAkpuY4G/ROqNz1?=
 =?us-ascii?Q?O5mldPySDOys2Ituw151WjKdF6pcVlu01L08zq/bKEl11TcZhrm+eJhml/3A?=
 =?us-ascii?Q?XYNw2xXakfvVfgc3ml66I8rLqTCfILgsghWO++NZTEe4h3qtCH+dlTt6wI+3?=
 =?us-ascii?Q?F4RG5PA8hYAsssb94uRZqp/m3vwdui/ZdET7XJvqoyxBhsRRd6/ah/5sjfDa?=
 =?us-ascii?Q?TDGswavPltWIQjsgC9f8TaCmd6CSbfErAUtaRiXjhZsRXYFr7C5Wca5y3nf1?=
 =?us-ascii?Q?vCMZScRlITPL2KQSKFtooTdSj8sy9Yo4vOd19Fhw980dR5k1C3szOZwSE9PA?=
 =?us-ascii?Q?THfAkITvrtguof8hQHzBP7hNqXNUzse/bXBz4YsHF+vqpZJiRDsziZiiVQuj?=
 =?us-ascii?Q?dCc9QbHuSIxDpqm7iIzWbO/jzI6e3wngVv3rrGO+sLgSYQBMIo8kDSHh+Uqw?=
 =?us-ascii?Q?0iihFKFxFixRuKJ388QJQQEkekMb8szc4UOcs7CGXj84/f4t6VPSS3NpMc3e?=
 =?us-ascii?Q?+fNgWUsTrRvHvGeIGLQSrclvbm64Mz+VOhEWYMcVLVxYIivIG/EmSHlguTfM?=
 =?us-ascii?Q?kjoBA125U2dr7/OpV2Lv4r9d2i+W6yq+smEwdrTXxjgKJYaASAjzJXxQ9eW2?=
 =?us-ascii?Q?5ZwuK043rTMDAONKeepYIwLHkJsC0zUGVQQR3C3U3fR73koLb67rTF1+n5oi?=
 =?us-ascii?Q?j4UCea8jKR7oTIiTRul4bWvQH9ysqYo6YpzwHtOtyGEHQKNTc4BxStyo09Wb?=
 =?us-ascii?Q?A1FAXu9ui8RIt7k5t9i+5Dk7Z11Bm3BUxINiRQDyIIkq4IBIk7OtfadyZ8bt?=
 =?us-ascii?Q?H5fSISbwpjCBirRD/x/mwGJ4s2QW/B+DOcJmiCBurj2qJgu5FV9Y4yYSuGpI?=
 =?us-ascii?Q?007pNDwVs3jq8IJ3cT/1Zjw94crfeIUxBFLGexMjNIRz9ZPGj/33gJnkmrF0?=
 =?us-ascii?Q?EVITFGhrMeMBeJCtcxe56l2GlEUnYQYa/N/21pnOyKsb3pIojKO6jQ7E9lbj?=
 =?us-ascii?Q?sXWW5M9xOiZPIk4TOFel3wPpI+5G4aZ1fi+2rVxH9i+sV4NFdR56EB9Hzofc?=
 =?us-ascii?Q?FvQJQVDD5ANYM5ZiZxU8+h8HitNIR/2lBbadSRb5QuDz+fQmFYrPMCgo9Pt6?=
 =?us-ascii?Q?GZcffSVTrmLpGd+5hLegBLQGmwzXxLbhyiwmspuM5EVUU0NdT9wld2swUMSF?=
 =?us-ascii?Q?BDUWSj7Kq/w6Zq5KtFvOzwV5iqE7gshw2aSmpDojpgjomcqyWZsNUrC06txD?=
 =?us-ascii?Q?d2tKX6Q7vQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef616b7-0835-42c2-0ae8-08da4a168269
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 12:49:36.5566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDjvT1+6AZfgeZ3JlworaWmdbkferehm07tNUrTB/WUOAq9+8qeGVHe0ycuIE0E5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3414
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 03:08:10PM +0800, Lu Baolu wrote:
> The IOMMU page tables are updated using iommu_map/unmap() interfaces.
> Currently, there is no mandatory requirement for drivers to use locks
> to ensure concurrent updates to page tables, because it's assumed that
> overlapping IOVA ranges do not have concurrent updates. Therefore the
> IOMMU drivers only need to take care of concurrent updates to level
> page table entries.
> 
> But enabling new features challenges this assumption. For example, the
> hardware assisted dirty page tracking feature requires scanning page
> tables in interfaces other than mapping and unmapping. This might result
> in a use-after-free scenario in which a level page table has been freed
> by the unmap() interface, while another thread is scanning the next level
> page table.
> 
> This adds RCU-protected page free support so that the pages are really
> freed and reused after a RCU grace period. Hence, the page tables are
> safe for scanning within a rcu_read_lock critical region. Considering
> that scanning the page table is a rare case, this also adds a domain
> flag and the RCU-protected page free is only used when this flat is set.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h |  9 +++++++++
>  drivers/iommu/iommu.c | 23 +++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 5e1afe169549..6f68eabb8567 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -95,6 +95,7 @@ struct iommu_domain {
>  	void *handler_token;
>  	struct iommu_domain_geometry geometry;
>  	struct iommu_dma_cookie *iova_cookie;
> +	unsigned long concurrent_traversal:1;
>  };
>  
>  static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
> @@ -657,6 +658,12 @@ static inline void dev_iommu_priv_set(struct device *dev, void *priv)
>  	dev->iommu->priv = priv;
>  }
>  
> +static inline void domain_set_concurrent_traversal(struct iommu_domain *domain,
> +						   bool value)
> +{
> +	domain->concurrent_traversal = value;
> +}

?? If you want it to be a driver opt in I would just add a flags to
the domain ops. "DOMAIN_FLAG_RCU_FREE_PAGES"

> +void iommu_free_pgtbl_pages(struct iommu_domain *domain,
> +			    struct list_head *pages)
> +{
> +	struct page *page, *next;
> +
> +	if (!domain->concurrent_traversal) {
> +		put_pages_list(pages);
> +		return;
> +	}
> +
> +	list_for_each_entry_safe(page, next, pages, lru) {
> +		list_del(&page->lru);
> +		call_rcu(&page->rcu_head, pgtble_page_free_rcu);
> +	}

It seems OK, but I wonder if there is benifit to using
put_pages_list() from the rcu callback

Jason
