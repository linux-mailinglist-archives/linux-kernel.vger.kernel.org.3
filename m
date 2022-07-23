Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0389457EF63
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbiGWOL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbiGWOLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:11:24 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2067.outbound.protection.outlook.com [40.107.212.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2A61A800
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 07:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gy1u26faj/BzvnLItrAVTb+/c2ecnOki27Qu2PP5oRxiVO5UN7i/sCLWNGn6AVNUut3Xrw/S4T0h9sUaqnyY4Vwob3Tvuu1Y9T+/hgs9ZCVEyXRNSU+9hV8981isTst6c5HX10GEc1haSID1hmxbxhuNrwIFLo+FgJOmFZyiTyR/X6+0HuUcHls0j1x4eSmkzuWGp9Ex1uF8F/1cIwISH7zjC580Gk7kTV+QuAvigl6OwfuTHqHXB9PbIsKJ7TlUWPkRPy7vT0HK3cxmTiT9sZJ3CZORQxcMbg0HPS9ILuX/5sAxdXISsHCPGGX0O7ZbzeOrDHk8V279cuBryuIO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iyor+0wZTFFH+bvbf33vjY1oyj5qiUzGrKMCh6Ds1qg=;
 b=N0gnlWL5fRSFWxJwu9D22MUI13/FbUZthqcveODbQY5Cd76N7X9LBFZajEYjzsXIXV0/bWkIobi5a0Ai5GY2954xpXKTAnnSAq5ojFnLPY8VO8dhi5qkp3H2sUHkC8IXEX5lFhsj6bw6Gl7WPIovEX1tGQEAVsXzuGd3QCnklyh1JZNkJJ1EPyc9YlEumAn3DQIqM2Nx+2wyPRwrPHiQphkQznugZAsEwvJYG86o//NP214IhrHvIFEq9fbtqGuptENM2d7sBIaQ9X7K7CkgfMu9JWOyUkorjbuyYLa41p05rHbd3ehrIHgtjNGLkkbSYQMSLv4LJW+gn9iPZlGGxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iyor+0wZTFFH+bvbf33vjY1oyj5qiUzGrKMCh6Ds1qg=;
 b=IVqq9k+1mAOeErxNg+BaCX0Z0l1KDDEuDVE/fZnO0S1EhmlGc6F2K+OZrasG59RzXrfpzGRW0WKS1Fq8nChHcBt598G9hH6CllTIRCebB34HMuoQHIyMQLmW+EIVmwN6QDgtUoZyJ3JeWrPlzVjt5fjvlzK5nwRAy6TiHoqYLxNzzGmFXTXQKjotPejNoOPjGiQ537LLmU3Vm1YDu/ff3ZrZEXA9MevjB75UsYYT2V4N2NlcdR7qtnCGs3nQWJd+dqvygAtXSQ3oDlZSAq624oR+q/N+CSt2n5fsTfup1Je0b0xUzun1fYYvMt7QdWeNHeirRoRqoTRC8ystOzhOOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4601.namprd12.prod.outlook.com (2603:10b6:5:163::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Sat, 23 Jul
 2022 14:11:21 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5458.021; Sat, 23 Jul 2022
 14:11:21 +0000
Date:   Sat, 23 Jul 2022 11:11:18 -0300
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
Subject: Re: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Message-ID: <20220723141118.GD79279@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705050710.2887204-5-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0290.namprd04.prod.outlook.com
 (2603:10b6:303:89::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f87cbbb-e2fd-480c-147c-08da6cb537d6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4601:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9atXFRCGJXAOeu+WtGFjh8M1HMzMhHJLueXPUEZGJbOmMzuGjpiNqpPMT7dHL3OWarKxx+ncxR3kxAMtBLmjldmLDfEgaFGCLjax4LU4o8FpXEBJ8uzNoFUIg6Y1G1WU4eijxxTFx2WHQ0KgwURErsZH+0+pFXRqZDlj+7w7cV1q/4//Jw2AndMNjdjJt5q8NHOExuSfmt/XWan98D1ctjPB0io3uLBKA0ojKAuLb3iGtCnYkcmhmfOB2F0ZhIBShhaIzuhHotY7K7nVCHmvS4F/HBUx08RxdOIuqnOJIHDt+si/3IVC4Ea6XFk8x2Zlw8qZaff5GjEffuBFL29EgT3kpYBx7SSoIp2pI3RkBB1MXKld/dgf4zOcV4le00KaZhvIbTLvoOBMfiQd+gdahr+gKyeueCRSLEer/Dwji4H1cOixiDuHP0l9fl3/bHCf7nAz8MwoCDdTifiqZBkCCKZtaU/1psQFiipQirgXVP3c057ngs0TsD3ofQiEn9+g9u8mxoX+SUeStMtT56oSsnELwFFeeC/RSHJU0G12TtDqR9p0iDYmczumVwycwcEeSGTjQnPmGkaVxXQSQ/SgKK3MnYCv5KNdE+i3mjQgYCJUl2UYWZn5S4PyhZZid31ojTqc2bSxM5Z7/rlATm7Wd+d/6qgFdtAaSeytDsYYCy3pGCpaUgst3oZqo5ruJukxalTQc5iakjG2hh9XTejigKx+bNGs/CDSSUaHLxghU28I105GORW4AA7pqWa1S0fQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(8936002)(36756003)(4326008)(1076003)(33656002)(5660300002)(41300700001)(2616005)(478600001)(54906003)(6916009)(316002)(7416002)(186003)(83380400001)(6506007)(6666004)(38100700002)(6486002)(26005)(2906002)(8676002)(66556008)(86362001)(6512007)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e4M6O8sYbo5jh0Aw7dqf7fBWtjjtzYVJpsOhZTmYvABSHm2ygGLKWHMv6RJN?=
 =?us-ascii?Q?7PXmoqE38CKSwvmSHSHlKC3oP189TV2Af6s73j+l3GtdSoK70BV87kxNLLU+?=
 =?us-ascii?Q?/PH9ocsYNgK3v5RXgLv12eIFme9TSo7FNgxdy5gGyAg8gSJ8Gbmo0BZ7Tlfa?=
 =?us-ascii?Q?4HJmZg5mt35Cn6mU5NwnlK0NYZfCoYV2n69Qhl+mHu+PPFBICwAfiJ8YXsu0?=
 =?us-ascii?Q?kbmTLL9/rGcwBzotr8j+6T3/Ya2yXb6euXKiBRBgw2VLFuyX7Kt+56hZ30sp?=
 =?us-ascii?Q?NsqzWTy2S1//eM5fQKmdaIWWtu6yMAn8pkBk6rNOBPsPGBTIUlDzuj7prnI/?=
 =?us-ascii?Q?NfOqTRToa+i+Ec6g81Jfy+CbcD+coMuSs5kzKBn7bG6Mptka6r+U0HiR89gI?=
 =?us-ascii?Q?zs16Gj5IyApInYGlOonKGoDX5NdnoOyfsTubyoZjH1xZ2gAR3SY/3RAlonBn?=
 =?us-ascii?Q?xPZ3Y64JOqJbanyueWSunn5qLnOKuSps5BAzViYRVyV+rHxEjJapSLFYywuE?=
 =?us-ascii?Q?tQgTzFOJpDEMtFYjKgEh62m/ST4yCGewNMQKxCNqe7NtE5CFdq8tGpfQRAO0?=
 =?us-ascii?Q?B933LU+C+WtS1EfYcv7Xe+zsXysJ2yf8dC1ml260LLg86numXezyi5A2PVAc?=
 =?us-ascii?Q?uQtuNg4znZiove5scCkj4hTf9UwcJESAt0vrHsyGsEfrxoXQPoh9MTgwdNKs?=
 =?us-ascii?Q?34XhRGwKEwqKjGjMfvG1BH/oXH3f1UCASmuO74o9KSFbTyKGrigHltj4J7Hh?=
 =?us-ascii?Q?ljPJJdq8WJV9zJ9ZMuCxLW+WJocugFmaKHubE/o805XW4mSiVvJpZ2tbS7Fc?=
 =?us-ascii?Q?sPTLRwCJuhWhmVBXUzSXL1kuHmUDriLI9ONdW4JicM1mR47NxLA0PdRnRm6g?=
 =?us-ascii?Q?mE1z3DkcWquZ+FpeBoGlu6+4VzmRJEVRNbummYyRaV8SVIzH+5PMeiHYI+Kb?=
 =?us-ascii?Q?XZlnMwyoKxM0quVnucHx2SORdVXJa1p1toqS0F7B2dc9feZmoCUijvCBdXv/?=
 =?us-ascii?Q?FbSzWVstJLt3EDz909VaNTbeskwmkMvdKY7eNwpjeCApmOTWC9HmR2zrRuBJ?=
 =?us-ascii?Q?U3ugV0sLCMXlfN/hFF2oc8c0pP4KrBn9MxQ3r4mV/SXEyU7qID0Ca4JEFFcx?=
 =?us-ascii?Q?uvQEqUOsI3oJGPbh9CiZCVyIo2cOVKikvUn8I76FDxrvJ9kiFpkzag0H59lg?=
 =?us-ascii?Q?gNl4YTVoXqlo818U3uQjEJr8MyCN3LvC0Qv4cOR+YFa27qw3aOWSwn1/5lK0?=
 =?us-ascii?Q?Rd3on9920jtyo6wCMbHVmvcWor1PUZAfg+tCLsXvxtum0cc7Xqxdv471CTqn?=
 =?us-ascii?Q?HhBnTSJH9IeJvrYmqjSEkptbXjZ6f+llVyH/1VzV4X01PjVJIg+Pa0YSIpEf?=
 =?us-ascii?Q?ZqlRYpyZYydL2Cdi1fEwCjW++hBlP5EG+61uaDo33SuRuii+d7r/GzbBt10N?=
 =?us-ascii?Q?E1S4CtqgPXw1E16WjX1Qw5b1ynPKshmHB5k35XQX2PKEWrX75/pWtUQ2cBkN?=
 =?us-ascii?Q?0rRVkgq1SB7UtUwLH5z18R9YLZAwu7O551cC+6QhaCnFT9cd1E1g/JA2AMi0?=
 =?us-ascii?Q?yNTkLzq25rB64pv1pngSCxENb2onA7riRG61dZ0r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f87cbbb-e2fd-480c-147c-08da6cb537d6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 14:11:20.9086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZBbu53uAYEYY+vonoKNjRHMAoHIkhfztpoeLJMC55IwgWMKiEmd9kFKiEe3yhbL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4601
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 01:07:02PM +0800, Lu Baolu wrote:
> Attaching an IOMMU domain to a PASID of a device is a generic operation
> for modern IOMMU drivers which support PASID-granular DMA address
> translation. Currently visible usage scenarios include (but not limited):
> 
>  - SVA (Shared Virtual Address)
>  - kernel DMA with PASID
>  - hardware-assist mediated device
> 
> This adds a pair of domain ops for this purpose and adds the interfaces
> for device drivers to attach/detach a domain to/from a {device, PASID}.
> Some buses, like PCI, route packets without considering the PASID
> value.

Below the comments touch on ACS, so this is a bit out of date

> +static bool iommu_group_immutable_singleton(struct iommu_group *group,
> +					    struct device *dev)
> +{
> +	int count;
> +
> +	mutex_lock(&group->mutex);
> +	count = iommu_group_device_count(group);
> +	mutex_unlock(&group->mutex);
> +
> +	if (count != 1)
> +		return false;
> +
> +	/*
> +	 * The PCI device could be considered to be fully isolated if all
> +	 * devices on the path from the device to the host-PCI bridge are
> +	 * protected from peer-to-peer DMA by ACS.
> +	 */
> +	if (dev_is_pci(dev))
> +		return pci_acs_path_enabled(to_pci_dev(dev), NULL,
> +					    REQ_ACS_FLAGS);

You might want to explain what condition causes ACS isolated devices
to share a group in the first place..

> +
> +	/*
> +	 * Otherwise, the device came from DT/ACPI, assume it is static and
> +	 * then singleton can know from the device count in the group.
> +	 */
> +	return true;
> +}

I would be happer if probe was changed to refuse to add a device to a
group if the group's pasid xarray is not empty, as a protective
measure.

> +int iommu_attach_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			      ioasid_t pasid)
> +{
> +	struct iommu_group *group;
> +	void *curr;
> +	int ret;
> +
> +	if (!domain->ops->set_dev_pasid)
> +		return -EOPNOTSUPP;
> +
> +	group = iommu_group_get(dev);
> +	if (!group || !iommu_group_immutable_singleton(group, dev)) {
> +		iommu_group_put(group);
> +		return -EINVAL;

goto error below

> +	}
> +
> +	mutex_lock(&group->mutex);

Just hold the group->mutex a few lines above and don't put locking in
iommu_group_immutable_singleton(), it is clearer

> +void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			       ioasid_t pasid)
> +{
> +	struct iommu_group *group = iommu_group_get(dev);
> +
> +	mutex_lock(&group->mutex);
> +	domain->ops->block_dev_pasid(domain, dev, pasid);

I still really this OP, it is nonsense to invoke 'block_dev_pasid' on
a domain, it should be on the iommu ops and it should not take in a
domain parameter. This is why I prefer we write it as

domain->ops->set_dev_pasid(group->blocking_domain, dev, pasid);

> +	xa_erase(&group->pasid_array, pasid);

It is worth checking that the value returned from xa_erase is domain
and WARN_ON if not, since we are passing domain in..

Jason
