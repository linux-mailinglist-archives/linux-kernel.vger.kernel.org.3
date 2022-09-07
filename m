Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093C85B05A7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiIGNso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiIGNsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:48:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DDFBF4F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:48:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ux5M9AeNG/srNWp8y4MQ80R9Wuu1/GxzdHTYB97IeLcSkVhc3L1cKsedRaH38A8ea367+Pm1SiZUScGxTXHK/+1mPhzJS2iRX7HogDS9OINB20i2Zv3mcn+ag/mcGHLLs7TlyFHPrAShlGAkIRiwcjCAIuze0mDh+wD2R5Q1PTWnn+pZwDz5YZR3fXvjakSvdiWTM94nLE9bR+8xc9nDTFk9K2+lRw5VqzFcd8NSnRCDZDYXrUe2Sa4KMP+ay9E01UO6aMTLdUrU9x6fe+g4JMFo2aTPujRPnCNMReUD+Ip2c6cmz628MH7gU+3sFgQ/2d5OUWNtLJtVLU+wBca+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49mzpJyI4raMY06nPTEoT/DHLNWwXMDTsH9fOWzhwgY=;
 b=VFevFSrNK8/VniR68xjN+vYQ9OKWZwBsUnvoMg05IB8GEokh/2Is+ATG9tLk2Z/8uBk1wh4N1SG4ELwcNQTnNWV6w2UfITqayCwlitH/GJbMP52cdwfwgLsH3cOtzN0IUXi8qdlKmbEDB8HyaE5vin/iVMPjF68JktZkjcYWi0HsNKDVV/tNPxQDX3AbDo5yh10mQrnFP8sYbfIIs2iUGds/teJVHd3a+IWXV5FJSKi68G8vcHhAQb43T9BJsYnkbLbLTefqprCPz9NzHH1l3LbiNm3iEAJ4YBn36zKGUucyVOUXUMsLULGZFMVbYQ4/rZIq6FcopZUB0QiK3nORfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49mzpJyI4raMY06nPTEoT/DHLNWwXMDTsH9fOWzhwgY=;
 b=BNM8nqp64Wsn+Z4dolYL6vuRZunQsCrNX2dXbEEkNTcqtI4zRSL1bRYo6kThni6GCTyHGXsYfpKcKJgkz+64Pziq7WgL/gY7jZ4u4z+hDhzWcqoNoA1Sx5edgLW6dni1cVfD+e2VLC/QalGauBq3gYOMxi3eYnTMm54oYJIF1+Y2KK5gm7V94ZrjvDVsJEHB/Hgbx0LG6nWH0LJ/wzvL6Tm9mB8Tv/uN7nwtuWOI69l3HH7drb5D3GYSkRvuj43r9hzOk9/fhnFs+t4x41NM99kVTDDNmoVII2l/+MCo9R9PrzemZ5Afnv0BJVPeQME3GOO3kSvABIXPm4v6V0GUGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 13:48:34 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 13:48:34 +0000
Date:   Wed, 7 Sep 2022 10:48:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION 5.19.x] AMD HD-audio devices missing on 5.19
Message-ID: <YxihMchpLRPAqNWx@nvidia.com>
References: <874jy4cqok.wl-tiwai@suse.de>
 <20220823010021.GA5967@nvidia.com>
 <87h723sdde.wl-tiwai@suse.de>
 <87ilmjqj1f.wl-tiwai@suse.de>
 <20220823202824.GA4516@nvidia.com>
 <87bkrrl3eo.wl-tiwai@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkrrl3eo.wl-tiwai@suse.de>
X-ClientProxiedBy: BL0PR02CA0096.namprd02.prod.outlook.com
 (2603:10b6:208:51::37) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5099cdc7-fd7e-471d-6f5b-08da90d7a86a
X-MS-TrafficTypeDiagnostic: MN0PR12MB6103:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MGFGOymQzET8QdyjQBQT8C3Lk3lPSgX9/ORb+LhWIZ3AKFjr7Tv6t2/ywYTh3OPzhD0AqgR3zmurR9H+PvKqGWmzvRP+7Idw39QMSrzWZPVIrwsRklfcDSwenLYVp8LJZs8dFDuoLVPFsLiJJETjsN6jcGPlSP20TJqmCsOMbPLLkVcieIxJiTewANvFRbEpWh89u3H+d310ufwRY0HMfFe15rLxu4ft8NHQLdOkfbQiy0p+9DkM2ofHC4+f11M5WCRujHilPHtNrljHIYfRLAUkLRmEjAUqaoyqAP/3hdZTyMOOjYa7ZAPeqq5pZdG6Q2l9BuOlpqGIwS9guot7Kd5LE0R6U6JtUtnNu8O3D1YmgbhzxZ7z5jV09bn7VcwjSejH73oRpmluUfZg1F40JPF26NZOA1bGaW2wL70JVvBkruzQhBBWuiAczFpCna31wa4e6IIJYlQEqPAX4iWBZ8PU7GRllugEVc10DNRVLu2YEXnqaVvah7frou0imy977dYlOFvZFZVuS7FweutiROrO/gvhz9Znvd089fFq9QmaTI6nkkaB13PVlJqkQsemt88/KHArBLZKxJv71SvvYqzmrW4FZWu3uOmHy3AvrEdxTrVhbfTA7CxaY2a82z9N774f8q8QMcjUoT89JUlaBhd3O+wo8ULx20m+FofTSAB+feKsCv5qG7s0LnbRefEOlxhaL1VEBjKjsQmSnSD6sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(38100700002)(316002)(6916009)(54906003)(5660300002)(4744005)(8936002)(66946007)(66476007)(8676002)(4326008)(2906002)(66556008)(186003)(2616005)(83380400001)(41300700001)(478600001)(6486002)(6506007)(6512007)(86362001)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tm0Yuj6srJ+A6YD0WT1VBtQ9+Ibi0S5GG54ZxUd/k++cEmdsrtvIVMI72UYf?=
 =?us-ascii?Q?UbB5JXh5AwvC6vN1W3PcBE8UGKQtMbZZFdmBd7aS42IccypC0+kDLM6IBxAo?=
 =?us-ascii?Q?ZWWFj9sbOpXTKqBp6VCd21R7wdMFB63gCWKpNJh0UczeYI2vRExIcohKUkAF?=
 =?us-ascii?Q?kHiM72d88UApZXtAwfc9XrbndIzH60rUtOh2CrXd9JgJWg6+G7FhtJ6Od9Qw?=
 =?us-ascii?Q?vkC/d1L+PGbvsi81UGX0Di25hQbMiutNADw8/G1q6khUU0cTHX1/VgCcjgsu?=
 =?us-ascii?Q?3OcpvRVfEH6n3FYXLsKCPMgRWJlQDv8TjxbjozF8+mCLfgsNoo9iWj0TO4TI?=
 =?us-ascii?Q?D/jZAzIvLtrWFunakpjqX115ZwEPVDLx/fCUBJR+/xiPZMQopDYKjrqsnJQn?=
 =?us-ascii?Q?JUHWn121cU0ZOScQPu/3SWq78V18jXaCiBoBMQOJv8i+iwr9RrIbGmMl/b92?=
 =?us-ascii?Q?3rx4vIOiLbmzigSmF3bAnY/cZKJWk3f6G6xV8+XGnnWFa84zBxvjc6Iar/lx?=
 =?us-ascii?Q?NBZNt1MmeSWFg5aIoZsegnOxCRF+cIUOXcY3n35pJ1Gjj+xY4pUZkOnzCZ47?=
 =?us-ascii?Q?TUoR2dpkwSfZQ7FLvR2qjjXvGxuTAG12mg81mhbn+Hb8dkazY/BjqA/k0tAx?=
 =?us-ascii?Q?oXVG20rZXnfipOmX7Mf07bGnZHWEp29yNfGrvAk1kF3M6O/h+pZoeKSRwbnN?=
 =?us-ascii?Q?HAlZONiMPtb5XlITusil7JjciWC3YrISriladF5QeIYn8lkuajl66u/ueEbU?=
 =?us-ascii?Q?0sOvMsM0Ehut3lNwG9WfkSnDq3MWrxJHTVwbcDsX3dw+rgpSfFmYgE5zV1sI?=
 =?us-ascii?Q?/2wEGk+B+guQAFk/iX1LUuYKm0J9+fihc3Uaa1tq920IlzQKcElclZ70SHoy?=
 =?us-ascii?Q?nlxf2YjUAHbZ7t8dQTbUO6at3W30ZUyfeRU/1GS2PRWOU5GJv3CfibAq2drg?=
 =?us-ascii?Q?LN4vooHe+LbNKCu+vg15YjIPLd2cd4j2H+x+j/xFxc0M24n6zcgPqMzU8wnZ?=
 =?us-ascii?Q?fA8i4qL9WfhLfv0Ajn1to7piDdTMppqzVqIRClWJGXTJI8Xdo9NVglxCQaD8?=
 =?us-ascii?Q?AX1+vahE5KEIic9wL3Fq1fQaOikUMZNj6zIGm4nAT8Ot0FaQxie4GkFM++hc?=
 =?us-ascii?Q?qqeB/UhesnvS8O9ea28EPIe2F9Co/ouVYTjHrn51e0pDaltGaZrq3BOAc2Bc?=
 =?us-ascii?Q?Azg4NKaC8HCYvtZrpDYFpW5wPOlZmyZV5JI/8WyL84eFboAkdjoMRziN02UW?=
 =?us-ascii?Q?HQ0s1YknAH0OcUmA2fXr9LyQtIHPgnvISqYcQF7Xs12A38p+5gLSn4wWiU+h?=
 =?us-ascii?Q?Oa+iQBVURvfO7PciYhlBipRaGFPFL9PQCQreVmIyoL0HcelqqE/ZtI3mc9mR?=
 =?us-ascii?Q?B1C7iAmSIHSNSA6GjfecGUzYpptKuLIqP02neNGcjl+SArfj+Yc0ZF/DHK5e?=
 =?us-ascii?Q?460MRDJ3UgiSqX9cECHPLp6B+58PBUUESHNcLVLQWmq4pVXEzlYjgl1/Dwjl?=
 =?us-ascii?Q?6VbfqHjacfDYs1ajtKkdObQwkzizEetO4mZB6XJQosPY2nNToxY6VQ3TcFBI?=
 =?us-ascii?Q?e6kZkTHNYKx+wJjSXe8CFDzmUlPHEKxe9wbnSNBW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5099cdc7-fd7e-471d-6f5b-08da90d7a86a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 13:48:34.5043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UariDeMcgGG9F7v4pP18dGdoFmB2A6BjZqiIZh+sdO+dMgSCUhUJNoYvFTsFyQyN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 03:28:31PM +0200, Takashi Iwai wrote:
> >  /**
> >   * iommu_device_use_default_domain() - Device driver wants to handle device
> >   *                                     DMA through the kernel DMA API.
> > @@ -3094,8 +3112,7 @@ int iommu_device_use_default_domain(struct device *dev)
> >  
> >  	mutex_lock(&group->mutex);
> >  	if (group->owner_cnt) {
> > -		if (group->domain != group->default_domain ||
> > -		    group->owner) {
> > +		if (group->owner || iommu_is_default_domain(group)) {
> 
> Isn't this rather 
> 		if (group->owner || !iommu_is_default_domain(group)) {
> ?
> 
> I'll rebuild the kernel with this change and ask reporters again.

Oh yes, good eyes, that probably crashes on boot too

Jason
