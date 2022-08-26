Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497CE5A2B56
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiHZPey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiHZPev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:34:51 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BC325F6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:34:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbvvUPkOmTWych1Zxd5uLAaGJPQtuaKOHHz7LEiwDdp0AW1vGyaJoReNbWYs46LhYTfoBkbWvI1rj44oJl7CYhQUeG/+TLEkX5czeTR96qzBpMGergD3AobOROSiNib67cGmhblvl2Bmw33WCVSTCUe6WF6hbRmacNFji8UF3ALoYKxz6vPKd5Llr+wHiMcEoUdktTkvoOZeoW7VM0iQqC5gsdmd8vnQRJidWVfBBqKoZ0zMel3kZAv/vnRizoBKv6aSyYq2WwOsY654NfSEySrQU7xRRGsDryuI7t5pwW/t1nQdkPus4NHvx/IgS/yq+LkCVCHrQL55XBil7B0t0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjOjCL3nviISgJhBJLShAB3YFQHCP8jvmiSlfAW3mBQ=;
 b=l14EVfZ7yghDtIg6y2BJkbXsWQEK1DpPSqh4HG8u1Gy+UbJ4xYwqSFySkBFByaAyK/KsWGZkvvt7GMNpWPUuvEs6E9GtqWtPUsykmREaQnlvg4tjl3LG0+fcwQnL0lR4y8ihXWo16mqNVwzR1AlE3HfSVp5xmP6IdJaVb4RAMkOPd1bl5cYrRhdGJs27Jcf7TEv2VcjcI7mqpbr3VtTjpaTtRLi8VJEwphWj2Q/+fBQOlnAyyEHa0wb8PkJN+vy4O/kDZGAc7YOHGoesFqd13Eq6iNIe8h6m2bFhgp4pUgUfxCdLcvI+LjUdJjUhWWL22Pchp98IH0kmhbUP4W0Y1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjOjCL3nviISgJhBJLShAB3YFQHCP8jvmiSlfAW3mBQ=;
 b=p6ivtNl67YvYoJHTIuy0dw6zriWIyoHg7DjconZLRpHiKdbFnEWePHTusEVY7QALwrF1BwUNipX78oSvMCdueR6ao958Mi5O1cwJxgOu0VtmE0cz8JQWvS4jeU3w0O6pbnBXuepfvbNJIF1wPSwXsCEgC7diGSyIXGU2H8ATop/NkSnhSgRaZgSb/Hd5W0UwoulquT2k3mvbgyFU1csUJbhHGDEsI93M5i/vsc6C191aDTbr145gd1b3q7SCNAUjBwbYvo09NaRMLLQJlPketTcGBpS70efXGg8WbxdWVENeQOA/m/sKKoAZjG4jWf2ygqLdg9ScJ9zCHudP9aE90A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB1419.namprd12.prod.outlook.com (2603:10b6:3:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Fri, 26 Aug
 2022 15:34:46 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 15:34:46 +0000
Date:   Fri, 26 Aug 2022 12:34:45 -0300
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
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iommu: Replace detach_dev with real blocking
 domains
Message-ID: <YwjoFXLFIGo8s2YH@nvidia.com>
References: <20220826123014.52709-1-baolu.lu@linux.intel.com>
 <20220826123014.52709-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826123014.52709-2-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:208:32d::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 639a4842-6a12-4d22-338c-08da87788139
X-MS-TrafficTypeDiagnostic: DM5PR12MB1419:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lJkiYbUnZMxiidSbRecOij9UBB4THLZKLnUJaTQjtacjoIEUaSI+J8sOjzdN2hZ5mzZ2DYwIIlqagkDNEtlkdr26Lvm4HZ9o47aaGKtzWvGBgvJHok/9ApSdInhxzjal8g4Lm1hEmvKK3i8WTKw8i6LYTcjZ2e82IrjVnAxqOoTMcXc0R6POz2Uwq31o4oleWFzOgL/urqeIKf9okkg/K4qpsxGbbHeijfbWncByJCNZTGAO1NDr/GBoTjQRr0STECnobN+j7NqzvkxCd4BfFVx5h2gb8p10u3Ko+jBiMLvXg61RYOcdrT4TzIZNGthMon65UDlnXem6J7aGdWIII0ep8fIIXF5ceQHC7Esq2Uh79zY9rFPki8IV3Jzf4P4HJ9UNBFGrqrYvBeGrM/gOnjkv/H+qY3YUu9YQItPX4LkPeNaciwx9e29qsnDaj+D81q3vVGcHlmBJjjV7rT8+ypSjZWNZN1Pr2L9ykEecgOfYT8XkuLeMX3YnMyUy0Evc+AKu+0V67+aAbH/q8KllvuVsrtWoNgamEm/fk7YDPE194w+HRz4AQ2DhY75UJ5GXqsD4qum41HyObtg9TjoO5yYcF4jEpmbQDAcp6kV5R7zNYksKfO2MAS04yY8hJhEEiHQKmnX8kSk1xW9vp/CqhB6Z0aXQbzECMo9zGf2RmCPTyQWi3NaFlP7cpW8KoDsPc3MKfgJ7PaatrtuakmBxbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(2906002)(7416002)(8936002)(2616005)(83380400001)(6486002)(478600001)(5660300002)(36756003)(8676002)(38100700002)(186003)(66476007)(66556008)(6916009)(54906003)(4326008)(6512007)(26005)(86362001)(41300700001)(316002)(66946007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GOra3UM5Bn68h5defRMtGGYTj1UUJz92OrLX/e3ozvUbMbxgI3v2cR/KGiIr?=
 =?us-ascii?Q?BJlg84ThjkteDRtNm4Lv41Q6GQ/h4BUKu2AvB9vM+keyQxjCInTdvy6JTPc+?=
 =?us-ascii?Q?tzIyQdiBSyd/MuqjcN2q/pGKy0rykv5KZBS4dSw6H5AR0MIC9mE7/8pfYBDk?=
 =?us-ascii?Q?s3CIqYbC0l/2xraKH/EKu6txx8gx5WhqAU0IIr26wUvjJ5aVdp/P6or3t0em?=
 =?us-ascii?Q?eI9BAIZdDKpIt2b5CbX5pmRMZtKtNYjMRmNPJS+H0juI2v9A+bE1KOQgkk3u?=
 =?us-ascii?Q?wEGwr6dKG9GCAb274wzeacEzq/i8wugL2YBQrgTZgi11AzD7r8iJmBEsVLX6?=
 =?us-ascii?Q?rbS5Rj8GKJU6d+L5LnFmd+eej15qmFsDF32OXJfQlOheWUp0kUlVfjYemB8y?=
 =?us-ascii?Q?qTUJg0luTXp1K1lUbpPkLJLlIs04f4dKEiO5orDB+DSVjqsop2D8xIZ4ViE/?=
 =?us-ascii?Q?e7UuuJvmXWJWCUyILCLUAhuM1pYCLbjmFGuppOWnMifjOgniKjqAJgelyeeH?=
 =?us-ascii?Q?Pfh9CQUK/aPxF3mgUPN7dGaxhoeuM/sksO4hM1yk0aZsEaZrdA3hcl55sda3?=
 =?us-ascii?Q?dptTvfXslivrdhr9zRBNvDtN/384qoBTzUfFwFsJrfL570G2zBdqEaG5g0KS?=
 =?us-ascii?Q?Gx9VLb7iuUDsscMMlRk+1h54I8kJu5YEmFIN9363pd3jawt1iCk8N08fMn24?=
 =?us-ascii?Q?dApWhfVRrMQ36rTKS2SPAulXCySY75zUuQGEq75wZBXi73xUK4GQnHGIsTC6?=
 =?us-ascii?Q?f665wqauAgsLc755i6CMHLu/VhGYop7jJqRgGD+gcOCcfv4NpkEc3+aCw71j?=
 =?us-ascii?Q?UPuV+LUNjR9m1OyR7Ae2dXEqmBZhfKV6/1VQOQ8qelvwLj+VjLaPXKYWVrnM?=
 =?us-ascii?Q?XIzT1fRL++RhkDXh8bVWKmZPuhzIHZ+edLM4iNDjXC0VYUC4V33G8cwXvys5?=
 =?us-ascii?Q?vzaOEziGZy4E4A/xSNXeqkueqPwvBI05fhLMiDraR8o8Dp/w+UIiBwFS6X9w?=
 =?us-ascii?Q?3ozWz3ZElEe4TjU36TQHsQHI6ilepEealn3Z2gnDmXCsS0FGjVt9kiwKGhbk?=
 =?us-ascii?Q?97zYNUTjaI/mGkiu/kZ3AojMCFTDi3SHPfQzbQk8rLPorCA0wVFtNJ31Uwok?=
 =?us-ascii?Q?cKxsMdZcyqgMscJGL4uU2VyhqBEgPvIu1+xpklCGX9L54wdVwdfw3IJO+vAY?=
 =?us-ascii?Q?CFTMWMLTl6ia8Aw2gyH/V2cXKwlcnGVdC5MtZKF6bRf7v77faaPq7oWiRcZ9?=
 =?us-ascii?Q?pIW+vsW052/uB596zkYtaIQ+yq35t/igr/huSL0VzUOVhuPF3FpxEpe6EjUL?=
 =?us-ascii?Q?ZdM0JcQbb99fE9i6lnOZqY6nrgEPzD/X931jJRmo321/noRiS7BIfGQMzGvc?=
 =?us-ascii?Q?OPp1IMjqFxg7iBOhjzTvlgK2j14i33BGlaV9eckRO9HGDs1rfnP9zn/XNrUs?=
 =?us-ascii?Q?eJesEBYb2zptxBDKNL9z9vEGIech7hi7ULa1FUPFt+kyp737jxxxmiD2S52N?=
 =?us-ascii?Q?IJvxCGOtJysHr9Hw92iPsV1tTYwNqjyp85+d29SxXUaB8Ck/k4fuXLVzhWQi?=
 =?us-ascii?Q?qq4swrsachTmg9rcWDt1WsKIjre5X53ZmemZW+62?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639a4842-6a12-4d22-338c-08da87788139
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 15:34:46.2530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quLBBu9QLT/g6gIjXIu0rBpfDL7vx0Pg21bIS2sRGryDeanR5lIQwef99mpldU3f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1419
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 08:30:12PM +0800, Lu Baolu wrote:
> From iommu core's point of view, detaching a domain from a device is
> equal to attaching the group's blocking domain to the device. This
> repalces all detach_dev callbacks in the IOMMU drivers with a real
> blocking domain and handles detaching domain through it.

There is a subtly here, where detach_dev() is not *always* going to a
blocking domain. Recall we made this mistaken when building the owner
series and it is why the blocking domain was introduced.

The challenge with this work is to be sure that the code you assigned
to the blocking domain doesn't actually set an identity domain or
set things to use the platform DMA ops.

> +static int blocking_domain_attach_dev(struct iommu_domain *_domain,
> +				      struct device *dev)
> +{
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +
> +	s390_iommu_detach_device(domain, dev);
> +
> +	return 0;
> +}

For instance, I know that this is returning the group back to the
platform DMA ops.

To really make progress on this I would suggest

1) Remove detach_dev from drivers that don't use it. This is any
   driver that provides a default domain, if a default domain is set
   then we always use attach_dev(default_domain) and never detach_dev

2) Of those drivers in #1 audit and try to determine if their
   detach_dev is doing blocking domain behavior and if yes give them a
   real blocking domain. Otherwise just delete the code.

3) The remaining drivers are not using default_domain. Rename
   'detach_dev' to iommu_ops->set_platform_dma(dev) to make it clear
   that what it is doing is returning control back to the platform DMA
   ops.

I would do one patch per driver on the blocking domain conversions and
get acks from the driver owners. Do as many as can be acked, delete
the rest.

Make it clear to driver owners checking that blocking domain must halt
all DMA, and it must not be a passthrough or identity behavior.

When last I looked several of the drivers looked like they were
setting an identity domain on the detach_dev - eg back to a boot time
behavior where the iommu is bypassed. It is really important these not
be converted to blocking :) Arguably if they can be found they should
be converted to identity domains instead.

Jason
