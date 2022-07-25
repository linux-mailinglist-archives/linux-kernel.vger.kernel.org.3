Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFD95800DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbiGYOkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGYOkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:40:12 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332B5FCC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:40:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3/HL2qLlKzB2U0m/C89tvXkqvoa9hHns9KlIhJFutKavvKqNXkQWyP/N6FYsIQeTRsFLh/XCRORZW2kcCpTMyuj+0v2xtfRlxoLNmqhC0WIrbR3Uf7j7meQFhlwA4nEqX5XqpONmVAMVoGgPiOg/wWKuILv3g3IKp6ru+iVFfwg/N3bPePRKlYnxxink64EtG5Nqd8aDjCeGEh+5boqBOrdynI4dTzevgqjxShqHt/ga3ojCgYtkMlkZ+bLRFIf3EquxvVRUGIjEqy6/NhA4nsEvnZxYU8K4TFlAaoznnr+F4Hk5G2FFoMLD5tNXavqG8EK/+yYW3S9peRFCSNNBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQvv3RXO224ANy2vR7dUun8ZHG/shvt8FT2F4wnd4pA=;
 b=gf+RHT2lpAM+L9EcB8zfXn2NiPVCoAX6Js9PCBkUrBBUmxR/k2DtODny7uc2vt20d/AmZ0zrxGmobiRQzdGEr2ioPBembprYOAbpFZfp2HpW8H9s8lbXinEe6wY+QHWm/BLw12TEr44MJ8jNIj31UA+z8XqmG1QwwsCkBR7h91QS5PuvXeaNedp7RIkapSWpOSPjbpJ2aOaV3KyShI3Sl8UqII8fr4MKacjaFlxSHvyggl/1uxfRxQv5Q4BFtwl8xIqyOCFYc8z71LSSnlQe5oZALtPv8y6OPKI27NgxXKqyo9e2wnvfM3edkfl6LPMlG883Yj8WxzdwveabjiiRTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQvv3RXO224ANy2vR7dUun8ZHG/shvt8FT2F4wnd4pA=;
 b=glrotejDlCNvACBMn8j3fJ0AvUKQMlhuagqSe5Kf7T0CBzLIFWoTHyMyV4Tw3jbNLgVoWgRw/WuYUBZLXMPyeOx62gWRb086F7oLfuKDen8mHpdAKN05sBOnZu84TunHyDIkeQl5WqC6lHvbzKABS+9ms1Alz64s6XVbIar30aWi5tDpAJb6w7vWM5G/MTSY2oDDohXjysCbR5tBIV3QjdTD7/vcZdhKeH6Oj7bplMPPT6kKQWkGBN5bb+2kid1NbIrti5ZwHhO8ID6JJ3wXtt6GBBF9W3N9l736orPfLQHR29bkUi8+8Zs0JJCLnDhyZgDAU/ZXFg3iyOfrhEkAeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Mon, 25 Jul
 2022 14:40:08 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 14:40:08 +0000
Date:   Mon, 25 Jul 2022 11:40:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
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
Message-ID: <20220725144005.GE3747@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
 <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:303:6b::18) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73c045c8-947b-4ed8-6b6d-08da6e4b9200
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7gLrh1ilnupve8g0NPhfFLmLEOWnX7xVlT70ICAxvrUKcxd/92nDkMNMIaK7nBs+7wqOmph8pQEtIWcbv6ex5rIT39xp5195cUIAWx1eWMLZTf0IjJ3DruEfc0m03A96H3M9osYgv8zPseeJtHcCAYuypTQf0JX0uySu3O9WBPsQhm2RKu+SlApEpfMpdN/KrzxhWZiPkhnW49/HH2bFdKZ2QT/qQSurgqbxX311E5pBcke+hy6ZHqznUe7yEFULd/Ja0RX6SHmAZ2Rhdkza96RJo3BcoW7aN9bvFZ8uZiOnENUCn+LHvYSN35hyAOqYjDOBJLuOHFIL/QZzCfvfelsqlpTpY9v6iQmGLyjX77iysL586APk7M+Yw2KHuGRVSIfAzyOpEyYJ5AirFK7rEvBkWqR0qtJMvcb+gsLfg1NljEBECLsnRh6qFwAcUAUJn+pYWcMc4s/CfHGFx6OCfaQE1Dcw1/PAAdH8gml45ZlHE8eEVSPdCcw+8bc8QAwsb5+WPOQKmPdwFQjtSr14ZuY9AXTMzHlL4yyVs4Rk4lAWT/AlEHxxK67TixJcvlb3ViTJ6Wmx9Nb5Wfbr+GUFEbzAyvUj/pfdh/nE4A0dc6vgsZbcYma0Gn44HdjgK6RMbZpcUTXe8yJXkiiEb+7ZYj8fNfBdPh/RjTMvGoCIsXvBiT590Aijs2f1bZEPe74tH1G4FisUPrUqlZoCWpqJ+JlVc3quwRzKQEqCa9FYu2z5lQRHjFiuMYklrw46BlJt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(54906003)(41300700001)(316002)(6512007)(6916009)(6506007)(6666004)(26005)(6486002)(478600001)(66556008)(2906002)(66946007)(7416002)(2616005)(8676002)(5660300002)(66476007)(4326008)(33656002)(36756003)(86362001)(38100700002)(1076003)(186003)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w5UxRcPTGasYxFxGRqK7CSQADf1C9skfwpMwvK6fBo3tHGBjB8HsXJ7viBzC?=
 =?us-ascii?Q?Bn7DL+8bbzB3yxh4ecZhpym0LH9ujlmNgU9ne8iTpfUzmTLwo6sM7FdpfOnb?=
 =?us-ascii?Q?V8JFzuVeexglj4R/N18gkTKOJr0rrbkgaG9Yvm9VRdlR38sPugi9Nemc9UCz?=
 =?us-ascii?Q?Zc6ueM5LRYq1YhGDVmEVSQvyRz8CrJwgapkv/mbyj4spfiEkHMns0MoreOL1?=
 =?us-ascii?Q?503B5KyBSNHQbFLnQIY+CAyJUufUEr4npYahXlKxjZbxcFtJqyVCpMOMqzlk?=
 =?us-ascii?Q?YX5mCYfREwyk2WpC3TAjLJY47Px32qC2i4+fhEjrO3En68qULtRGLsvEOJN3?=
 =?us-ascii?Q?g9QlbmGY4vvRgfPCP5SH/P+W/A94SegmMBOIMoRJQUIaqa36tJ8PnM9bF22v?=
 =?us-ascii?Q?qDM1zG2vUzCgGGzNV+oEuyoR5e8eYHBIHZmtRF3JEmDrNdXkjoNX9f9LkRQN?=
 =?us-ascii?Q?LSEYKDqb6Oe1RYNIOICVlu69GmbV47MU+rKRzKk0Q0/Q5yodFTfYVkqS/5T5?=
 =?us-ascii?Q?Uj4UXynUpsJH2C0SoiR8m6TFpy6Ljtm9RtLwT3afiIf1t3oLUhzcksXEQhMt?=
 =?us-ascii?Q?zGQlKV4VZLC8AT+DZeRhHNog4+fYD6rE3qg89hZG5wbRyt91EuIbw9L9Kk/W?=
 =?us-ascii?Q?dBsjEccuUffdBGlPfFWE+jEDV1cd2t5Ot7Z00NOuonN9JQfJmnUUUf4lzq6O?=
 =?us-ascii?Q?0WX+a29PuNBmsAI5OWaxHq21tOFDzda1dLk/w/m6zzTvsDi9uHYDxsGZc86u?=
 =?us-ascii?Q?kPqHziHpkYrdRjbhqBAJvrXnDeRz8GughPXfFkz71cLkYMfMp2ciG1f6cVwg?=
 =?us-ascii?Q?EESwx9y7vvUPqenxXYUFReWBVLd4gGDKPKqrr8QTWVfMNlBH2DsvKIq70G09?=
 =?us-ascii?Q?VH0PUtHFmANdqVxCJ/XbAv0bNXaZQAii5qYQa+v3ZPNgiEscbJ06lJKP6sMo?=
 =?us-ascii?Q?fxdLmYJIJmHADlivQOEjrFoKoUuBETW1qty/kCE4fPMn6PgNZoN1RZYuK/DA?=
 =?us-ascii?Q?rSV1tuZH0s19vFJ/TKMlqNYQyz0Gb2m5QhNzzl9Krz4L9NJBGAcaagf5c/MK?=
 =?us-ascii?Q?ZyXRmTnHLtzrjWStVxg6DBjX+vyG0EcifTMzbGdZ3Chf8D7KCZjHKQHsvtGY?=
 =?us-ascii?Q?DpxAb1Ou1BL/etUox8g8s82yWa/R7w8ig3MySXJIOoDT8fwjjJLwc7mYa/ek?=
 =?us-ascii?Q?utiaXRj62xRaF1D4rXQdApd1ta8VDlKXKwM8bDbBSAVBWVa2Y1dar6Z/FuDs?=
 =?us-ascii?Q?SX4XbnEtuMSGyxWIitsGs2CwFoTjIVw7WQldv45Mh0sqfYxCzjfpz183FUgR?=
 =?us-ascii?Q?zWXX9wTmc5Q/9557BD8r/qzPRiZJttC128jCohi7+knefJWKrltQ3MoUo0lf?=
 =?us-ascii?Q?/pgZuJT4yu++pZYsTGofe12THydh+Sur2vyOjwQzeEce4wuqleYEvr52ahE2?=
 =?us-ascii?Q?9Dd/Q3uQCP/eGLpQK23p7Q2wPe7nwiN5ogZhMaqiZz+FTXGtciddrtH/KZZw?=
 =?us-ascii?Q?83qRAO5yh0ZofNRZxrO1moUFLz3GI53A5PIZletdyyzxnlo7vCTcoRotYfBO?=
 =?us-ascii?Q?2mrPVWmrX509Bv/c3hA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c045c8-947b-4ed8-6b6d-08da6e4b9200
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 14:40:07.9325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMMc6Vh8ZcqxxALNHHBNdbWGWHArReQP4RAkEzVvepx3NOGSLMFOyrxm7T77XGAi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2900
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 03:03:16PM +0800, Baolu Lu wrote:

> How about rephrasing this part of commit message like below:
> 
> Some buses, like PCI, route packets without considering the PASID value.
> Thus a DMA target address with PASID might be treated as P2P if the
> address falls into the MMIO BAR of other devices in the group. To make
> things simple, these interfaces only apply to devices belonging to the
> singleton groups.

 
> Considering that the PCI bus supports hot-plug, even a device boots with
> a singleton group, a later hot-added device is still possible to share
> the group, which breaks the singleton group assumption. In order to
> avoid this situation, this interface requires that the ACS is enabled on
> all devices on the path from the device to the host-PCI bridge.

But ACS directly fixes the routing issue above

This entire explanation can be recast as saying we block PASID
attachment in all cases where the PCI fabric is routing based on
address. ACS disables that.

Not sure it even has anything to do with hotplug or singleton??

Jason
