Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123484ECCD9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 21:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350406AbiC3TDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 15:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350394AbiC3TDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 15:03:50 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2067.outbound.protection.outlook.com [40.107.95.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9807E5AF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 12:02:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zjd41Pqt6POHA5YnxZ/xtqd6yqLp/im/wlq6aNo8Yh8bCMCPEVrPCQb43XKLlrfqvvmAdJF2mkdZVh/CVsZpDAfgTBjanL9gZB4tz1FiymVWpQHut2f81560Gzc7u1ks6Pd3NUG/ezfzknolqLYyvW5EZFYyHp+ToO5qIarImqUNYZNR9jG7zY5mCGClCYw9fgxWFLO5+1u5ne5ojcKu9gn59O9QiAc8FDHkopHMA9YsYzgXCCWrZXA4oJfc2VnVTb+tD6tCCal5F0cNET2mZCJyaQ9jzUjwrTD1fmMq3x5anvmhwUJgwwYteYIwZMjSrvbhVJ1djLt45cxXepDq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/7yQCyna6xZ5yWZ90NN9IRg8pofbOWHqeVjpvTSIlU=;
 b=MmzNR0Ro6mPXh4TVJVnW+LbltuQjYQpDsSxmfGhdY5cEiv4e0N8TeqILSwFcFiOaFImk+sZ+qwiI0AAbNzzaT6v9e6bB4uRWQlrvowTHqBD5SwFTLLbbckkrScQXy1Pa3wBZuMDNHHsoZiZQeFqLnwzny9F9CeVQy81kS4Fpn6M9E0X6z+cEW2WkmRAivxP0Ni8gfE9lOb2mRCxSbtACf+mEHujURpJAhVLlPTLLr8cFHfmX/dRLlWOnBWLncP8NeBR18tjFgWUrW1rB+hPSL0QffnsnjiYBUPlcGsygcIwnoZBVgupbCaipvDoJzdjcYOOKFw44YRQH2b6dv2sCpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/7yQCyna6xZ5yWZ90NN9IRg8pofbOWHqeVjpvTSIlU=;
 b=Y//Fq620Y95VPZaU2wwkI8HGJo1tnk0aScJSc2HEH/lo1thRWXo2xs6pr0MOTL1eabxUqTqsbNbtxjERpN4+khzh2WluWA6qoIkCoKA6MYF02aasGKxl1DEf0LSP/CjBBMXBwa3j9vIbaCt5UYWfqPOG4RPgWK/ySq+y0WW7K6AxPpQVZX4+SYyLJ4iKgprYQtSXbv9PWZfhwQ+V8qVc+755dn/6OUwdPSVub57IxgM2fRo+djpNLf4AEf6fjHS2g2M7W5/W3z61LP8Q5dVWAXOS+S/N15DTH4ZApzNkTSNtaVExblR9F8m+mE0iR0xW7OrVM/O/Cc0toWZmLZBQLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB2943.namprd12.prod.outlook.com (2603:10b6:208:ad::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Wed, 30 Mar
 2022 19:02:02 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.027; Wed, 30 Mar 2022
 19:02:02 +0000
Date:   Wed, 30 Mar 2022 16:02:01 -0300
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
Subject: Re: [PATCH RFC v2 03/11] iommu/sva: Add iommu_domain type for SVA
Message-ID: <20220330190201.GB2120790@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-4-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329053800.3049561-4-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:208:329::20) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4f7a1f9-7f2f-4e22-c25c-08da127fc67f
X-MS-TrafficTypeDiagnostic: MN2PR12MB2943:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB29437348A52BC46A9046E1DDC21F9@MN2PR12MB2943.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qI3h6Z++jBj9sIcdGS7RjqAFAxSH+8icv4bvMQppZXLJSfNO4WBD+8DBNBF/fCTqIrS8IzbcrfbYuTHnUXV82GZmpDr9WdKU8dRdtY7MFN/NOoP1bEZpuwsAWTkEA/I7lLn+cYsteHaCiyDSkPTfC2jf0z02QDNNMPnti7V0F7NJ5fa8HrsChJhN1sukyGwriAqwcJt6dTS9XA9VOhdHgHiy2r9Y4i+HUiFeF+x18SmIFks9Bi/ybuQygskuInuJ3mK7FJ/KPWJ3Y2SPnO0ShExRvIlKLywmx2Ku4vJ7iGSU4vjhVcXuTq+Sxx35uvtDpRELZm/002qsEtYVqICbHxGSHjyqyTfq6aC8kmngv0Hpeu9J7gE37jLDuDiuQ+vDKxZNU2ULydF59/H5xVyeVADwZX5dSmvwyAslqG5Yj/J+TBzUo69WRFC42xelqn55JuHcPiGoqJta0LrZhoXbwsL0wWrW5jBUM0fsTeTO0ft2K+pwRBjjp1NwBt6QmxjNolZS57XByRb8Zitr3587X9yErYT5ebRM+/szpJ2IKYmXyN68Ud5aWEV51I9ZSW5xAsiUYe6R+5Vxc8G2aQWTo6zeE43Lvpyw0b/ymqrMAGr1EgbAp2uWA90o10enYAGbvTFCaX2wdRvMv2pQouPfJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(186003)(36756003)(83380400001)(6512007)(316002)(7416002)(1076003)(6916009)(26005)(5660300002)(38100700002)(8936002)(54906003)(33656002)(6486002)(2616005)(86362001)(8676002)(4326008)(66476007)(6506007)(66946007)(508600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S2TxC5UCqkyTXPR7ZT1ltYXG8Iwp2n66Mp3M3TCebz9f0qPl5DY2opiV/0Lf?=
 =?us-ascii?Q?AlTaMBpjGpCekk36z7cstDWei5rThK5JcO8FZdGBNxf4FbCLXU5MJIW6DxIT?=
 =?us-ascii?Q?BD9AF8cYcgMbq9eXYFjHDNWcEnQRNY41yCHWOYZKvMSE3myI5s7Z2YHAfv8I?=
 =?us-ascii?Q?J1zWLlOHS2rOJYf7ZtHyoVJmURUHj39kGfVurymP3SGgB2MLfWLov+DugU2G?=
 =?us-ascii?Q?HBniK863BDaN2A+b/XaSsj3Ib6uix69T0NpIBASvPsjvBAfsnLcDRlRCLXCK?=
 =?us-ascii?Q?iqzJ2f7IXXn+h/ZiFNGzpFjJ9OBeifDyWIRzBD6NLwOD7cckl78SLy95NAAT?=
 =?us-ascii?Q?7nValyvvlI+SBMS7tBMBni0i5qj3iYOSN7uDVu1kTwaSXhT2hBu+MWdpDqcS?=
 =?us-ascii?Q?j5hrqOxbC3ygblTCe/2IluYuZNfLLyGkrn9rc19Xu1BHcAbvWsYMioZhyUIx?=
 =?us-ascii?Q?voyZwhCo0SfQ1IdqrrONjDbOb+z9KVMQQLYrgV/mLdEIb1J8zck1z7yP7FI8?=
 =?us-ascii?Q?SkhblZ9YZxc6K3Xjcvwxkxy+Nh+/Egwul2x0lLXgjGL9It1GDTY5zpv0eJKs?=
 =?us-ascii?Q?3GFZGgMPtRwlU9nBNYQTI0jvpfBzFqeKXLojRCfLCtfv8Cyor7MeY2QqIl9W?=
 =?us-ascii?Q?pg3tZ9nfaDwgPtsKjCB+spcZuAgZk7SHxVehL4rEV5jnVw3w6ZODU550/ErV?=
 =?us-ascii?Q?XamxGVvu2PquQTv3baWl84Xyzl+5JqBiyu0ICSVukEeZcuyubPp6YuWhoriC?=
 =?us-ascii?Q?42ALrgG0wj1IBDDCngHCO0VlQdO9c9zsmltCl4zdA2u6GLMka2/yJKJaJeIB?=
 =?us-ascii?Q?H5FXRykfRS+wKyQjwNOwx3B5MQhF7aZ7Tac3ZGtiUxw407SGjN6vqMD0/HRd?=
 =?us-ascii?Q?JoARD6ZU1WNlshBl8oOdggMJdmsxW5huDWzFJx5/hdO0RdDIz+w4fihESYbY?=
 =?us-ascii?Q?haM+wL8fC8wgJoFWtu71I4KmKnfNBJLaLXISlZwJOxjGmAUKlJR3sC6uWhi/?=
 =?us-ascii?Q?WKzKzHXme7U9NZQEvelcum6QxIh6yW1IN/uR/lbKk2Pl8rIOXlsy24i+0hHQ?=
 =?us-ascii?Q?Bx41wtarny3nbbCVEkZJe/DoQdD+bBFEBLKr1+crSJfQALHujBIRz4xsABwl?=
 =?us-ascii?Q?XUkt+EoFBsyt2xMxDDUwKa0YlF8ol6zZXMZnqjPrl6CDs4bqxEopihAc5H6E?=
 =?us-ascii?Q?eMhstF64HOGyNvT7nOco+oSmLEWKYFo4yQPiWdU8HLKcAjsrQ+W5/iMPkdcF?=
 =?us-ascii?Q?Vy3byDmNIJT2vj7J+95pi5n1MuT1GYBG0XvjIiyYmUYxvWA1zh7YoBfEdcFB?=
 =?us-ascii?Q?zwsFdZCvxHXpIKFnrpp5Hq0V0SJWKJnhVYBL42XhQeHF6EXqDWuuPlLOxEQm?=
 =?us-ascii?Q?gRrcbrGlwFWjcgniLJfGDLdkJiR6EBk86CfUqya+9xa00hlej7ykSX9wqMCR?=
 =?us-ascii?Q?Kg7OvdwxKVL99uwAja0Vd2JemRBXBulTJRxALvoC5W2OmU06pSdPg0b3Pk7Y?=
 =?us-ascii?Q?KI8UuW7ZsEyEv3ETTy1pt2khE4ORXmbywC9Z3p6xAX3aPCg1Sa0SKKf0NieZ?=
 =?us-ascii?Q?eOkoG7EXTn5kKLT/txAcCXJrF/31tKRpQSgMFbzOvY19CXQ05uMzRoYL8OZy?=
 =?us-ascii?Q?t2LL5E1wZ2gHtUO5RSi2cKmHU8AJJmLeLMhmzedCmAJgsPWkzm2nu7zO+Nga?=
 =?us-ascii?Q?L1gi8Z2lk+ay5YspjrOtWAsH7isxR8i7qNyQbv2IJx+U41O+PUGrrU9f494n?=
 =?us-ascii?Q?xKldwYWZgw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f7a1f9-7f2f-4e22-c25c-08da127fc67f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 19:02:02.8316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KRBBUforC8wWAztlsOTSjukXQpFk9OQ6kc4RIkEk0XM2kwCLDzmyeiTH7eGoPXT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2943
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 01:37:52PM +0800, Lu Baolu wrote:
> @@ -95,6 +101,7 @@ struct iommu_domain {
>  	void *handler_token;
>  	struct iommu_domain_geometry geometry;
>  	struct iommu_dma_cookie *iova_cookie;
> +	struct iommu_sva_cookie *sva_cookie;

Cookie is still the wrong word to use here

> +struct iommu_sva_cookie {
> +	struct mm_struct *mm;
> +	ioasid_t pasid;
> +	refcount_t users;

Really surprised to see a refcount buried inside the iommu_domain..

This design seems inside out, the SVA struct should 'enclose' the domain, not
be a pointer inside it.

struct iommu_sva_domain {
       struct kref_t kref;
       struct mm_struct *mm;
       ioasid_t pasid;

       /* All the domains that are linked to this */
       struct xarray domain_list;
};

And then you could have a pointer to that inside the mm_struct instead
of just the naked pasid.

> +static __maybe_unused struct iommu_domain *

Why maybe unused?

> +iommu_sva_get_domain(struct device *dev, struct mm_struct *mm)
> +{
> +	struct iommu_domain *domain;
> +	ioasid_t pasid = mm->pasid;
> +
> +	if (pasid == INVALID_IOASID)
> +		return NULL;
> +
> +	domain = xa_load(&sva_domain_array, pasid);
> +	if (!domain)
> +		return iommu_sva_alloc_domain(dev, mm);
> +	iommu_sva_domain_get_user(domain);

This assumes any domain is interchangeable with any device, which is
not the iommu model. We need a domain op to check if a device is
compatiable with the domain for vfio an iommufd, this should do the
same.

It means each mm can have a list of domains associated with it and a
new domain is auto-created if the device doesn't work with any of the
existing domains.

Jason
