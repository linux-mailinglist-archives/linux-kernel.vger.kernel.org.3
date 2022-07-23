Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25E357EF55
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 15:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbiGWN5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 09:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236419AbiGWN5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 09:57:51 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24441C10A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 06:57:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNqtuh/Gf54FOTyg1+ca86/+u/rB/d7zbz3X9NMwGnjHZWA5NPLeWAgMoGAyWzxd7HXqjVkqI99xiu48GjPrvQZvq3dm6S/XWRmUdXowe2YYUjeQ+vxGb+p6xXWgO4C0pj2842D9YD/EZctMraXvokTR603YTKrIPgF3LUzi21zj345DIg7Ep+qg10tkdRv3tqoNMiELXx7KqLNbkUmXAZz3WI0sSOb6kzUu8wn8A7sE4XIcSiIKII3KdAE2FBX0wk0+8qmtrErdl8hakCQFpW4VN7L8TZ+QLnM25wkic1jiwsD6YwCspkvncSz+wOU2H2RYWs+5QHHr5ZeP9BOMfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2bF5oiHas3R63Vh3TzSEX5sSY11dk0zJSxwt2DdtXc=;
 b=HJ6zc88wcC8KZdTHSfoxqA207kXDRB2npTruCxee1Pkho4MLQQtIETb53NZWLIlGDw5dc7XH5ij14EBOqIN6d2FsASK13wre5JAXCyImA899KHeIYWfLAJdMHqUU3EbWFxisOK13uXZYawj8+aAQMyv/tiLFpAKT9anwQEqXN8+/eMGLpJHUxLgivMVgbJ45RlNH5+BXTH0OrYYuYPeSYri7eXqcurJGb2RzpSCeKHsn5X6bzUnaUpSlW9o0btORGr1xyz71jGiEvVPKrHkGRNXAGjYyGyxvFyDLkjYVrs7uvBranvqz5ANT0w9yZAChjpYZNjnVBkBq5/7Q6tPuJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2bF5oiHas3R63Vh3TzSEX5sSY11dk0zJSxwt2DdtXc=;
 b=orGV1Bnp4XYZMf8lW8QMQx9zhcOAXDMLRZi6mvgnrh5FxGSRqp7Xt1M172cpyukRcZIfaejg93rir/ykhqKYDNfIs0XXcVRlQfMUPUKGOsooK25JY3MIw4dbdYbTQwxmJIdycPptmcBN7Je6vgDtsm8ffvNbRMyQyaIXm0ZGu6gsK5CT/FtrAIBP6kJkw9Cotx66cDwKchs9YImXQ/jzHhTD3qgif2czzwPq38makR4Xa47ZWS01DW3H7WRZulPV6l7LL0doUX9WAAVwHG7BvJLWrzSoEhPr3MpOHYSBYQCiHI7vrZJOV3P1OdLKAoiE1qopzTT66oo/Ns8wtJAWxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Sat, 23 Jul
 2022 13:57:48 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5458.021; Sat, 23 Jul 2022
 13:57:48 +0000
Date:   Sat, 23 Jul 2022 10:57:46 -0300
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
Subject: Re: [PATCH v10 01/12] iommu: Add max_pasids field in struct
 iommu_device
Message-ID: <20220723135746.GB79279@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705050710.2887204-2-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0188.namprd03.prod.outlook.com
 (2603:10b6:303:b8::13) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf13690e-456e-492d-324d-08da6cb353c2
X-MS-TrafficTypeDiagnostic: DM6PR12MB2761:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Lo3FuLxWGA5H0aWYIhiRQgdH5DkJiFSkGyr9tnTAez95ZUbzW0/oeIt2pbbUlafj+savKEXPk/gYSagQdIMTSUVLRr/HnhHfX1jvoF8+hk3WPZ300lNG1i2NMIp1SSINdNo5vb8rOdpOLj2eoc3qRiqeyJaldw58kNGLrwRcWnAa1GhQ/l6DEAO2EltPUz33Ze/NO7g/xy8Dij2zUNtZqkEV9b+XCX7Elp4ukhMpAisOo/cRTsOZh5gxNvhBYXjtQMaMaoYsnkNgyosgTtXRVwqL8RID0kK7T/CXHenMFT7IXxRNxtrG5/ANZ9CojFOhMx+klB6rEYt1VZgr0LWey9zuD0Zh/PIB3NO6gryVp9ge6quOv3LGY694GOL56pSJ++AuHTQU1NGupGbyECGKWaZj1JcWrqLqq2OGGl6AwF85x8E8QaRQTHJn3qEmkelH6bv+vtxZeNUwYa2JWFTApwUNSZfnvFqMCSDG86qsxd97UEv0zD47nXv9a7YrClCQSJpmFUJr/YuyqpHI+S6jvHFZMB21QKqdsFMAlwKka8vVF9c7PInWoM6fxhpyd8MezpKxwy6md1briKKvjQEnBX/yuRnV3dVuH+gwz5aArviQVK2bZ2iB6td+4JhMy2ZX+4mC8xeTDE+ycN6IbzY92n5z0DFKYscnD2X7QkVdvaoJDKGKwMYu0C8zOmB56Cmi83xY1ggR77GnAV4FtkFuSASivTO5nUz3hWrKrG5942LilN+8lZAzr73emMJ497V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(6512007)(4326008)(66556008)(2616005)(66946007)(8676002)(66476007)(33656002)(6506007)(1076003)(41300700001)(26005)(36756003)(478600001)(83380400001)(6486002)(7416002)(186003)(316002)(6916009)(2906002)(38100700002)(5660300002)(8936002)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UFzC2tZrbj13qDU+M9OJOjEJaahfvIbNvzJLyJUmZhUyFXtzVfSnsNhsGzlf?=
 =?us-ascii?Q?WteCFIyMAfX95JQ1SP9uCHqr4DkSuCbPT7c5H9cXMqWB+Wf2wGxao4jAXkVz?=
 =?us-ascii?Q?v5ySLjvALyWZHaMcl6qBnJD9cuoqvXRP9rn8svnTPY8WmfS6J+QtsxccIRDv?=
 =?us-ascii?Q?C+BXEqEYofVFkYaXnUlSOp4qhebH1lwz4+S4/s0a9Mc3zlFc8Pg9GWoSRP3F?=
 =?us-ascii?Q?NezsCz7NkJj4i7GSX50WXQRuDI9fH7kb0a9gklSWHduqhL870VHZHgVu5fOl?=
 =?us-ascii?Q?Ff6G2CHn0rUO/IP9wTpB+9UTRQvW3D/tnVtLdu0mkK+0esm5ZX4cKV6tXyAu?=
 =?us-ascii?Q?ULo4XqT4tAMYJYe6P0H00Mq5YuRPlkTJvTTUWJWTWJlOY27dfPYv+t67FnFR?=
 =?us-ascii?Q?BiBjmiZP9RCDqk253vxO4PPkZknT03Fe73pl4W3HeSNoTp8F2BJMQLgof/tt?=
 =?us-ascii?Q?+lWQC8O1goZmKWweoBZqH0Gf2zzOC1OTFk3ojIWpU58ypgqDIg7YqfqEv6J+?=
 =?us-ascii?Q?FGeBF9Za2sgGxhTt9Fv05pIBaNN0JN9H8LgecacFRAcZyMPF/3gREjQu4lTt?=
 =?us-ascii?Q?X9MsO9ziNspV7c6+/AvQeuGIYdS0+wYlHLamL+YphZZ8UQgV6lWYXnnZOp0t?=
 =?us-ascii?Q?+zP0h5KTMZfDsIf+XOnkU1i9ti+XW5Dp7ysjJxOL9Qo+lvA2hiwFuOo8WpDx?=
 =?us-ascii?Q?Xz5d3Vj0zZP/czVys/uPB7SI1sP80WyPZTEIO3bxiJim3JFrP28xuZAOT2IT?=
 =?us-ascii?Q?zAcB3/DwhuwBqasILIJjakP8ymEG2uxEiFEGRY6h/9z81P+JCF46Jbr06WF0?=
 =?us-ascii?Q?H1Qpid50e6TsBxfwiubpwtwCtf4TJAsXJDx/+WBIZo91ZebOvPjNH19JF9Oa?=
 =?us-ascii?Q?gRNiF49acjS+SP9uw2wAB8uAiB4JipDUdJ+wOL1s1q0MkKItCylKmZmbJCjd?=
 =?us-ascii?Q?6AEeVnekK+bwxaL2PSh1++2jTHxcMwQyX/XBcXaI7mOZS9ebsdOSankAjXBP?=
 =?us-ascii?Q?HOjfOv5ZN640N4Fl8yCqIJhg4QugY/q5kXvXwVfX0Vvzu29BdCwHuFBii/jQ?=
 =?us-ascii?Q?rvZ6oDJUQeYWu7wTXzp8V+opxBOGCzhnKIBVbpe/BTH9PXcFezHof+UsjizH?=
 =?us-ascii?Q?F3lnpRS+j5CW6CTcdWYixTPPso8tgVzO0BFlv2DR1j1VZmeWR9JrBLlKkguc?=
 =?us-ascii?Q?DvN56KNbZx2mIzhlggB9NJcYdYjfLtqV+YxAJsoovcVgHAujQ90DBvCN7/yI?=
 =?us-ascii?Q?8O8tEgyktWgeVxdhKG4FC7LS2k05kEKcbIs9B/px05GR2LGpuVdFDx0H4Bsv?=
 =?us-ascii?Q?vgKBQvXRT9QsVA2al/t8dHnuFzgZgX6FeCIzajBtzblss0BvvzSjT5zZuRJV?=
 =?us-ascii?Q?V+auaHX1ZISQDOTyafA5Ji8MqOwJ5iET7ez7oFQ2IXNH0aEvH9R/y3WxZwWF?=
 =?us-ascii?Q?crHU/c9yv/mB1zhprXYfh9JuCJDxxFxcW5EmbY+SZk9xR4uexm3iMYGALdB8?=
 =?us-ascii?Q?Ae2qW4YSe8WDFGRQSPwfLkot1Lw+bcAqLL15GJydZ0AFpOUrpptBeXwz/Wwh?=
 =?us-ascii?Q?dwe9JKiYSV3c1THN2m5id/yMDGUcVlQit3QVQsq/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf13690e-456e-492d-324d-08da6cb353c2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 13:57:48.7621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdVMcNcgdEzpg+W7SYFjNm6/WtoIYMNQ0IDQgRA2EXoIM2Z2iK4CfQMG6knp+FWU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2761
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 01:06:59PM +0800, Lu Baolu wrote:
> Use this field to keep the number of supported PASIDs that an IOMMU
> hardware is able to support. This is a generic attribute of an IOMMU
> and lifting it into the per-IOMMU device structure makes it possible
> to allocate a PASID for device without calls into the IOMMU drivers.
> Any iommu driver that supports PASID related features should set this
> field before enabling them on the devices.
> 
> In the Intel IOMMU driver, intel_iommu_sm is moved to CONFIG_INTEL_IOMMU
> enclave so that the pasid_supported() helper could be used in dmar.c
> without compilation errors.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>  include/linux/intel-iommu.h                 | 3 ++-
>  include/linux/iommu.h                       | 2 ++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
>  drivers/iommu/intel/dmar.c                  | 7 +++++++
>  4 files changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
