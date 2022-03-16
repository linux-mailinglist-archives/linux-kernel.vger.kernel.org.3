Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED54E4DB227
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346322AbiCPOJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346142AbiCPOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:09:07 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2059.outbound.protection.outlook.com [40.107.96.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECACBDEBB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:07:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UB/EddL27En3adrJuVfApInXOPciMx0+oDMElRLE1KoaKmwTC6lYkZLu2oSFq2gXQ35VRq7M9jo6ltvn2zpSIf0+70zZry74cHvM/ecWywVc1E0Tf4sVxqTwtiNKYwDfxaVTX6jn6pClyoInSwcC6mZch3LJWztVgtyVS87mcML/Ytz/l/eY9ooX+MHE39LmIXIs2eSUWm0O4fZmIiYyt6p5CS7PXHVffQ2nJgPofCEv7zn1aJZV9a6OzJIit/4w5MWG3bu8/5nnko8bh81TPPgyjdaVEnR/yLqhaN/x3MTvI4d77LBU1x7WnN06ZfeLmgXLZDzxbmOx+ekYHoHaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYb937HCOWyzWfTVYC7AYKPtPhxoMCyIVwcVhSDw6fA=;
 b=Hts04P2IfvJ4WdggcYrV+NJ7Ff4bMq2YkIVUAdjZ+Ws192q0apFgHdb5d4bfj6T+fEbAz+bmGpBtmbvTKcQEpZCiwcft8HEi+qJAqY0qTDJOWqjg+DGYuEMLTYKExDo45Lb8kYF0AnivKC7zJMe11CjDnSttoMAyUuN5WM/H6xNb3Iv2PaN9TQVBRGP0H9NvivXGZn9GjVwwsyHDVFmrrwlYthFY43nyb5IdSeqcGwxXZ7ES4BlzWShSFGwIsj+gL19Jqew80UTPx8T697x7U46Mvb5hDYARVjs8PhLfmHRUY+Z3MhExlvKNL4xwnHI2nRIaCL4pSRKTM6X2h6kdpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYb937HCOWyzWfTVYC7AYKPtPhxoMCyIVwcVhSDw6fA=;
 b=CRNiRgPVn4Fjb6BmEfheu8ZPDU6rFXJ/rr93oYDF/rK2xyNkTBZ7uq4/Ym5sn571QXNbA15yh6ztBCwfbyHK/Dm9xSCw92ip4jpPivTBkkrbOxErcsF9mCT8in1GbLmw17iI37LFCIt79e8pkLh29rla1hMY0eEC/tb6GpWU2zjQHO47JH1i8neO+Dp86/DQpC0KYjUrwTNnf3P8wYIogkXSH44JU2y0CwxNwJ6zIFohfZMK+1Dctj4AqnatkuhZ2c8K+93iZ9VTV5isK3YvZYLj0KsLM03PRbWdCirbj7UpLLBlhzAn7NL3uZi3jfRJNKlVvSedQc8pfc6u90RZMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB5545.namprd12.prod.outlook.com (2603:10b6:610:67::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 16 Mar
 2022 14:07:50 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 14:07:50 +0000
Date:   Wed, 16 Mar 2022 11:07:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 5/8] iommu: Add PASID support for DMA mapping API users
Message-ID: <20220316140748.GF11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-6-jacob.jun.pan@linux.intel.com>
 <00286dbb-fe73-3604-4dec-340eb91912c3@arm.com>
 <20220315142216.GV11336@nvidia.com>
 <BN9PR11MB527697CA21B1D28BBD0BE0DC8C119@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527697CA21B1D28BBD0BE0DC8C119@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:208:23b::10) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddbfc6a7-8b56-47b4-20eb-08da07565afd
X-MS-TrafficTypeDiagnostic: CH2PR12MB5545:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB55453784ED84462F1B3C3A87C2119@CH2PR12MB5545.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJpHNKva9LZW7S0MnUBVLzDyuQW4cI4XNz5lX4PFzV1st0pP1oTqXsHpOFZtjpva1L/UpaSisIsrl/K+87rtTz0/MXTLFPOOexVcTL+3e9BC+RCBzMlrT9i5BqwEJPPJB6+FdpY/Il1vqVXg5gKFBs1OgkMhGuNT0H2xmDUMUEP6D7pUnIlXV5EeOhTQNjqx6QC0NM8hAzuH3+6bS+ZTTBKRpIP6XCcBwL309tdPLJ3qPcFZmkluLYhKPh/Q6JvJ+gYW1K/G1lFlv2cwStcqpPlu5yMG0U9v9DFfXI0IfOgRsA1caLKTGlc3HVD7oSSpH4vwWMFDOR0wpjwNXMedxYcXJN11KEWfbyjQ44icsky9Cy28lwfHFvuuMUyGuNVJnjxuJj54olQf+0JaCIyniv1Eeg7Gh6idZ7Y+1ubElla1QgP7MO/JAoBsmDpTpJ8A7Q4hel0ToJIUh6PEx/YYfx8LBuNJAEHZd4gfsiBFGVmxYIEugQeptcAF4QoYl/UzQdDWTH+9bIA1MWDVLGU8434XDiuQNuH2ClWqizdPP5ORvjqBN3au+9wVanXTuTFb8jqz/wWuy39e0ZVs/GupXytzzXczMB7olAxZaTYNEVh5AeHLpTgjz+XVV0zUcv2cHmbkGZT+j0yOfAP8uoYXButgNd9fTMiMW/zLoRs/eqlEwBfn5CfHUGANcKtrfRcE/s0heUEWc340I2ODwpNG68/rxi91U+DiFuRmvr1Bz4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(83380400001)(508600001)(38100700002)(6512007)(7416002)(5660300002)(6506007)(33656002)(6486002)(8936002)(1076003)(2906002)(316002)(2616005)(26005)(186003)(54906003)(6916009)(86362001)(8676002)(66946007)(66556008)(66476007)(36756003)(26730200005)(19860200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AL6ZPSGl3wf+JOngQq/BAUzI1rdF7eUnGXC4Hb6VRE5Da0Hy0iijpYpUL8X7?=
 =?us-ascii?Q?P1evcG27AQ9WLiLfGtFOzJWMpKZum8xHIVniPONawBfqHqih6pvB98WK3EKu?=
 =?us-ascii?Q?ehfdbsrAeDh4wGXdTpA+xevgLoR+nR9EwstaPCGhbXexbyPL/r7X/odmdckA?=
 =?us-ascii?Q?+UNInSlCMv9bI59iC4+ZImv7Mie3XPfBWGgQKE9bxoggt+EiuVUUfR5VCB5b?=
 =?us-ascii?Q?bF/MrFF+j/uWr+brDXjdWz3Vcku00ATG0+a5ylG2KAPyLU5lea0KPMc59LdC?=
 =?us-ascii?Q?ra96207p81PGQhilpzOfQekLefY2WU2W/rT8Uv6+P5fSbY4H00bVVyfOPoGe?=
 =?us-ascii?Q?pWN+FFhJaNvbH31WtoiaVoMowfJ/4+e2N12VOddk4z93nK4pQ/JQWxxJOLZ1?=
 =?us-ascii?Q?WEdWP6qXfbd4QT++DdQrq05M2vOT5eCYKugkqNBPLS7ks4MCvPLOFCF3e1+k?=
 =?us-ascii?Q?tHcf8VUs+N83klJ8WcJHuoyV/EPIMFX0Pi2N66i6199JnCokXAosRbclekRw?=
 =?us-ascii?Q?X8MmQK/pbTNhXqI2Rst7AB8T3eRnmk3azM00UNN//lymCMMedCIWHGVtuFzr?=
 =?us-ascii?Q?QpHLHcZijAgDPoZJnNp6mlduTgMbbpvWD+7WnVCVDNIwfpaVQihydTQmERz3?=
 =?us-ascii?Q?artvtnPwsnvCywEzcwsee5fT3nKah9hT5EA5rsdKwnKVxO2eqMne8RU228u/?=
 =?us-ascii?Q?+9cH02YxCANpHrQhW05xOs/mAOYdZGS+qt0YFMS/Yl2LNWT4NWQyJlkYCcEZ?=
 =?us-ascii?Q?nQfeVQNnqUfDoKX7HbmaehC3w6yoW92/tgzE28BC0uBekFpKBStzKFhnhmQ7?=
 =?us-ascii?Q?JCqDgqZ9LjfralrBOdnS8xgDyHyrExGrb475UCB1O1Q5pdPsNGS1oX/Z03gc?=
 =?us-ascii?Q?OGKVc86TOxaervYxqyni0Lphn7H1AcXAaigaTpB7ObGbSfDWB8BbAbX/Y+9M?=
 =?us-ascii?Q?2m12+2OQ8IECWIYzsMRDgGOqtt5c7vjKcGDql0Xxf0CpvbbZzDPfvzYI/axi?=
 =?us-ascii?Q?ihl0QHulSLp8NdK4Vbn/a3NVyFO5N8b0Sn+pL+9yeYtEXw5FAglocK1Y4FQJ?=
 =?us-ascii?Q?IQskIVo3RZC0eFOKMiULwAJ2uAyK9dbbxMCTan+JiKnCCiuPcvcDD5Ne4p5I?=
 =?us-ascii?Q?Bp/r6V0snFq/Seb/2GS5RSyiXNdmUsttXvj0WIudSXobGCflOoujik+IymAk?=
 =?us-ascii?Q?f/7vlL1ptkwawwg29lkm1I8IknFnIXfh5bT5KdYOVjbKV/9OkU4FjJyDEGZ7?=
 =?us-ascii?Q?qaP82IktVqg3VmnZpPb986gLQ43BWT5rMgZj5yngbdQApfMfC3GhSw8VpeeB?=
 =?us-ascii?Q?HtLeztDqPa3dUDJdbaHWKKQOIYDn1SUDgpXFD6cuKbyvesrIHBywFsEldycY?=
 =?us-ascii?Q?9XgdaEb0YV2heGu+uIFvdJxSVT5zmVi8SVndWiWCR4FHDnCmlLlM9mxNw+vL?=
 =?us-ascii?Q?eyJUXM89d7RQSpakijQ6yhcNp1B3hjQK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbfc6a7-8b56-47b4-20eb-08da07565afd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 14:07:50.3497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTbLXn6KAmSGypI2RIwASd4KvMmEG3bnm/BynUceQP+ijFZq9Qhpwlw5wqQE4c6H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5545
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 08:41:27AM +0000, Tian, Kevin wrote:

> 1) When the kernel wants a more scalable way of using IDXD e.g. having
> multiple CPUs simultaneously submitting works in a lockless way to a 
> shared work queue via a new instruction (ENQCMD) which carries
> PASID.

IMHO the misdesign is the CPU can't submit work with ENQCMD from
kernel space that will do DMA on the RID.

> 2) When the host wants to share a workqueue between multiple VMs.
> In that case the virtual IDXD device exposed to each VM will only support
> the shared workqueue mode. Only in this case the DMA API in the
> guest must be attached by a PASID as ENQCMD is the only way to submit
> works.

It is the same issue - if ENQCMD had 'excute on the RID' then the
virtualization layer could translate that to 'execute on this PASID
setup by the hypervisor' and the kernel would not see additional
differences between SIOV and physical devices. IMHO mandatory kernel
PASID support in the guest just to support the kernel doing DMA to a
device is not nice.

Jason
