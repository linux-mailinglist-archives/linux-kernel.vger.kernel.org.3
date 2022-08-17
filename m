Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1555973B2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240820AbiHQQHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240801AbiHQQHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:07:44 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20092.outbound.protection.outlook.com [40.107.2.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6A89F760;
        Wed, 17 Aug 2022 09:07:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQZjGAiQAuuSDFIO3oagTwN/S1ladg6IspEkoWlF9+paPe8cXr5PDTR/XUGqMHYY4YBCTyd3alnYGy3vIVtbAgimemR80F+0CKk9UGV5QDIcZrRMfaEmIlHeMtUyLy4IAEZtd8Co4meScN/opKL4Je90j9tiylCtCLqYPOThPSqBLaw4Y/JxF6NEOEpNGnOSYfZORI5RRTtONdZKFawdTcS/P716P/1eDlXw0NghhY4+fuzKo+gBgqRSw0kqaSCGiiXm0DYM/ITpWryww0dB+FdjZs1wl/yHR8VDuPZHsBdtQnBwlyKkjlReCKYNP6TvfdcamppKdkHw8eQM9LGlPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ByYR6M50kTTU9o1Nvwjbt37nEYkYBDUfwuS9ICHOjQ=;
 b=D0ox00Ij1pqtndPwUOfLLfXo/5kovYS7vVU9gRwdAp4/nQEVNqvFnFRfwPYNPgnJ7BNO9i1YZBGMyZlXzeXSAABYytvESHZk9ILtQQQ2BeIvl77LTMAjUgCdIhNsnF1zHECO16edaQsyhjAxK0V4eDrB4P7vz4kCzF3xcIIf20GC+ypP2tYygKjHkQfJTOgvWFPHWoAeKODHfggqRg92SRQ2YdiUrBE9Qzu+L1YsILO61hz/SElESFPrm+SGTb8f5qqy6vOrhd0DFJpMNV7iVtYRbGfc6ZzgdvYrYGdedWUw+nhZuM3MPzdOBSwjMKKsN2gJwKJ3UtS/0m8EGsYHtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ByYR6M50kTTU9o1Nvwjbt37nEYkYBDUfwuS9ICHOjQ=;
 b=yaZvCu3Zr8vw9791d9HG0Mtc4/QDxwRZ0+6p1P2p/m1p+43UOeoQubdW1UAhyZ/kSJwozeKnq5LbpQAZ+150AsZ2YhhiA9HBnWWAYwlmf39ZmEpAIvc/XbkGHySn/cGZwZXZH7GDWj8MptniZlnZJcMOlL4yyCHdgt20BMoX4FQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DBAP190MB0998.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1a6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Wed, 17 Aug
 2022 16:07:35 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::e99a:54eb:3b2a:5dcc]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::e99a:54eb:3b2a:5dcc%5]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 16:07:34 +0000
Date:   Wed, 17 Aug 2022 19:07:30 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Robin Murphy <robin.murphy@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>, iommu@lists.linux.dev,
        Mickey Rachamim <mickeyr@marvell.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix 2G limitation on AC5 SoC
Message-ID: <20220817160730.GA17202@plvision.eu>
References: <20220727164532.GA19351@plvision.eu>
 <20220801093044.GA22721@plvision.eu>
 <9a248303-7a27-e90e-76b3-c01a00be4e3d@intel.com>
 <20220808095237.GA15939@plvision.eu>
 <6c94411c-4847-526c-d929-c9523aa65c11@intel.com>
 <20220808122652.GA6599@plvision.eu>
 <3f96b382-aede-1f52-33cb-5f95715bdf59@intel.com>
 <3d16ebad-ea6c-555e-2481-ca5fb08a6c66@arm.com>
 <20220816205129.GA6438@plvision.eu>
 <94888b3b-8f54-367d-c6b4-5ebfeeafe4c4@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94888b3b-8f54-367d-c6b4-5ebfeeafe4c4@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: FR0P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::18) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63a0cd45-33fd-4284-7553-08da806a98df
X-MS-TrafficTypeDiagnostic: DBAP190MB0998:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vA059I7DVvuFGlmlPH0E0rT2Zexes3QeYnsEDEgRyOKB6OiW6RDuRAJI0CR7VjSSbprBf6B5jxXjhBNw1j6a4DP7Jts+sPyZNMhO2wWlOLgsxbaXDTt1gvQsqFu0q0AtfGoTPpbevxAsdOofxgDYxmEEnt5CgD0zneaerkug/+EGDBc1DmbUTIa/POAokPBRYibtLFuPCCgSyOQ0vkWaqoGMKL4sgUxAZ3mlTYVnpR1hzuLBja0QoZBLUlGihBrqaAaQvXGIpeXE3twPf5enRybekk6zcQF9Ymp7RzOUIkcJS+JpNpSoOYw1mHZnhppkvEJGjk3M4u72XlEpG/ipOR3r5L29eR3n+yP+tRZukizRAp4CVLa4qNV+A988cyQVcMq01MfBoPb9c9y1J7PvuO/mKl7ElC97BxGkF3egc31MJpPFe/LGkex7RDJBrPYRLgigG/aOox3e+uaxHo0C6nt7A5NL872RCs5adrseMdr2hKFZtHECvSkecK08aHaQ6iuhqZ1A02/wtKMyzOJrxYd1BO/9EhNrlujBAGrBu4PffOcxlZYyXzF8+hBLIkTLXwuSOGUX13UTBDeDC/62sPinry1VKq4EIbddbydKvWNxaa76fdbvB5FmJ7Xf9QF/1HjO6FBfzh3d0ijyYUg42BcryhDZOHVcnG3SvFcSeN/J9CKKl6xVu/dFmf3aDfax7jh3F+IQh4ayxyip2Ae0hRnuKwn0TUBkQARQuHXxThwThgm3/cg0jH5nUT18e73z8lCzngyBDDJS62VozJl9NZg94SAEbQ3wJbxsYGfMpJU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(39830400003)(34036004)(396003)(376002)(346002)(6512007)(53546011)(52116002)(6506007)(26005)(86362001)(2616005)(33656002)(1076003)(186003)(38100700002)(38350700002)(83380400001)(41320700001)(7416002)(5660300002)(36756003)(44832011)(6486002)(508600001)(66946007)(8936002)(8676002)(4326008)(66476007)(66556008)(2906002)(110136005)(41300700001)(54906003)(6666004)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wD0kSNSYOL99o47ZMR4PQG7wk45pRkIu1BgTfYd3ecSm+rFBaOb6yzH0J94s?=
 =?us-ascii?Q?VHHlz9mmy8xBy42hRW+0OSD3YANw5T4f0k3N3jiIXUdoAhNqCJgSqUY3ccpB?=
 =?us-ascii?Q?eXvjV3pzsPkb6tnOL6ljVWsllsHiFg6tkJtcbViRhcutpDCdOuJq8YbTyULB?=
 =?us-ascii?Q?KVAyvoNxi+OQ1MwAMDusqOVbEBUcItoXDoWqJu2GVqVNilv5+KFXJTW5rdWW?=
 =?us-ascii?Q?F07ce5zxWFST15PMSOGj+gDeQQgz+6akk1apEGAtqWov499g5uTjpJdGO8Zp?=
 =?us-ascii?Q?o5Gh8ShBWuy5SVIMluu4vm8+kDJAtd3x3Vs3KQyCHa2oi6O6mT+t9ueDSlmI?=
 =?us-ascii?Q?/Vk+g9jkpWCm78kS3A/nWnghqNflIXIJX23qqftPy4N6UlMBMlf38XD17MNj?=
 =?us-ascii?Q?cdd7MRbHf/tU/7GLnm7GviK99YgvxJgCrNGxCQwxGvqutUGfZ//hEqcdFXOw?=
 =?us-ascii?Q?YKV15a0dcVXdcRlcne1Dwz+trLtXqf2MjHwTeL7D1Q4fK99zUfQKD891M28P?=
 =?us-ascii?Q?jAz5ZRq+hrFWNYxoWJlG9r7qBQ9MIJkQv4fNB66YESd9SYU21GLijcFxnB8O?=
 =?us-ascii?Q?+tqRoBYHupgAGFURxWr1excE01B0SrpCGyWAi6jnhbYUFNT9sZ1ABenY57ec?=
 =?us-ascii?Q?IwKeOVoaQg1eZLXOTEHU691zWIzYU/rVz5o7DGpgflUNdZR1P6jNWvkMl7kS?=
 =?us-ascii?Q?II4QxvBFHUtGcGM6V4R2cD/fe+mF+MXev7PZdWFTLFU+08HsQKa5KmImLLtX?=
 =?us-ascii?Q?5ORJbjMhhauvzExPcROjKxz+VuF7NxKGSzjpRYHaM/4jj8DChR0uV+teZGz/?=
 =?us-ascii?Q?qUVLDBGwuAeAcWdnWYQwQR3UI6TUWJlt8EmcZt3VrODWpMiNhpbMt0oqLjMT?=
 =?us-ascii?Q?UQYDIZ+HvNfmOfW2P/Hs1JMuZ9V9EVwStzQoI3xoPTKSDZ0lRTWzmcjuxf8z?=
 =?us-ascii?Q?ia9H+K6+xBKW6BYB1rEzCSOzimX/kjPg2Ww7hu5asngcRlpuKpcmMcMAo94O?=
 =?us-ascii?Q?Bj58i0pjhc4mqBm/68LCM38f12BXeSIZ/0GeOzSC48PCY7oMglu6ZH+WGSOR?=
 =?us-ascii?Q?f1k5Zp+n5Z6OIXTUHgTetq+IIDFA5QtJQcrwVkT4DHPnQGyUs4mJN1yMYEIk?=
 =?us-ascii?Q?2nmYTLAkRKGHOWMHfICr1tXwkjGCg/FtioImNMdhZaXMdXTjILeif+BxzgbF?=
 =?us-ascii?Q?UPBXTv8eSbqmDRVdaERahQebHwyNwfJ7+P4T8ALrOvZI+l2ajpWxD8vCbAhP?=
 =?us-ascii?Q?Opr3pk0WD7KXzUcF4e+/shYftLf9LV3y3/3/GpbrdXQnygBau24GVQgAL2TU?=
 =?us-ascii?Q?qCDpvx/YLLA9eE78PT4QpzD0wkAOf5W5nSr0J/u5Ht30M64RCem7HO0vv6AU?=
 =?us-ascii?Q?/gCFs3Kg3LuTBSq7TS/7l+xL9yPSxacHkuADCynhdqTAoJ8/17AqDtg5KkKJ?=
 =?us-ascii?Q?lAdSNX5AT3hQF/QoPfxDZNNMHkHpbX+z7R2jDwil990hVbv9t5iGHlNDUXur?=
 =?us-ascii?Q?q0nd8u6Kme+rlCx0OXtjskgRaYlB64BPmq28KpR6v1nUAQxNJdtl4cy+WTdU?=
 =?us-ascii?Q?7TFhb3+sfxqx36Gp7wkbFziDDxFaz3a0ja4iV8kl8fRhhMVIvrvYT98vLeo3?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a0cd45-33fd-4284-7553-08da806a98df
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 16:07:34.7578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SR7pK2hKxAfxprWyxKnBryPpXW/qh5oYs3kTCXfZkXZ22dHUoAVYgebTyz32CujAjOmYXh7SeKTfFSkk3HMGI38Vqe4E6+pluQLOIJS+v7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0998
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin, Adrian,

On Wed, Aug 17, 2022 at 02:43:46PM +0100, Robin Murphy wrote:
> On 2022-08-16 21:51, Vadym Kochan wrote:
> [...]
> > > The one thing to watch out for is that SWIOTLB doesn't necessarily interact
> > > very well with DMA offsets. Given the intent of
> > > of_dma_get_max_cpu_address(), I think it ought to work out OK now for
> > > current kernels on DT systems if everything is described correctly, but
> > > otherwise it's likely that you end up with ZONE_DMA either being empty or
> > > containing all memory, so the SWIOTLB buffer ends up being allocated
> > > anywhere such that it might not actually work as expected.
> > > 
> > > Robin.
> > 
> > Hi Robin,
> > 
> > Thank you for the reply.
> > 
> > My understanding is that swiotlb is allocated (in case of arm64)
> > in the following cases:
> > 
> >     #1 when it is forced from the kernel cmdline
> > 
> >     #2 when max_pfn is greater than arm64_dma_phys_limit (and this is used
> >        as the end from which to allocate the swiotlb pool in the
> >        top-botom direction via memblock API).
> > 
> >     #3 using restricted dma-pool
> > 
> > Of course option #3 works fine because swiotlb is kind of forced to use
> > particulary this range of memory.
> > 
> > Both options #1 & #2 causes to use full memory mask even if to specify
> > dma-ranges in the DT:
> > 
> >      dma-ranges = <0x0 0x0 0x2 0x0 0x0 0x80000000>;
> > 
> > or if to specify the opposite:
> > 
> >      dma-ranges = <0x2 0x0 0x0 0x0 0x0 0x80000000>;
> > 
> >      just to make it lower than U32 to pass
> > 
> >          zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits)
> > 
> >      condition, but then it will be re-set in max_zone_phys() by:
> > 
> > 	if (phys_start > U32_MAX)
> > 		zone_mask = PHYS_ADDR_MAX;
> > 	else if (phys_start > zone_mask)
> > 		zone_mask = U32_MAX;
> 
> Ah, indeed I missed that, sorry. It seems that that change to stop assuming
> an offset kind of crossed over with the introduction of
> *_dma_get_max_cpu_address(), but now that that firmware property parsing
> *is* implemented, in principle it should be equally possible to evaluate the
> actual offsets as well, and decide whether an offset ZONE_DMA is appropriate
> or not. Either way, this is definitely the area which needs work if we want
> to to able to support topologies like this properly.
> 
> > So, currently I dont see how to pin swiotlb (I see it as a main problem) to some specific range of physical
> > memory (particulary to the first 2G of RAM).
> 
> Indeed, if ZONE_DMA and/or ZONE_DMA32 can't be set appropriately, then
> there's no way to guarantee correct allocation of any DMA buffers, short of
> hacking it with explicitly placed reserved-memory carveouts.
> 

I have sent some time ago a solution which binds restricted-dma pool to
the eMMC device, so Adrian, Robin do you think this can be acceptable as
a temporary solution (at least conceptually) ?

I was also thinking would it be OK to introduce something like
bounced-dma pool (similar to the restricted one) which will reserve
memory for the bounced buffers only ? It should not be hard as looks
like it will re-use existing interface between dma and swiotlb ? In that
case it would allow to map first 2G of memory to eMMC controller.

> Thanks,
> Robin.

Thanks,
Vadym
