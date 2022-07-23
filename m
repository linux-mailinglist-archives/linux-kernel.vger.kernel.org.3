Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C220157EF59
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbiGWOCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbiGWOCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:02:19 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4427FDF66
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 07:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je2nmW2MMgIQ3gTn8BY9KvAfzBo9Mc8aMB6EzukTIe4fDMxfkS3LnkqC1qFrpG0nkRzvh8CDu9gvqgyh97OFmNqb3VvT60FaY5IVuVbTLAvKx5j9su24OKUpV7BbdqmLdWkscP8kpTlr40kfpifnPz/0nNnstEV5EIAaVurBn8BcWAEjCpv4/ZXoc3WetS4xlocnDPr6bSjieWjGtg9f6xBjQxGfWVCYC/Ae/EOTFZxWsboqXxUooRLobpxe7xs2QPbPopnp1SztAWTHpXosIagelMdYUoToAIJDBr+hGOFKer39MoIowSuoA1Ovk9i3s2bPjZRky+nLLbfYmYKHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgRhrGB0rwjeKa9M3fd7biKpp8/l1C12d3Rquf/9pHU=;
 b=T5OJBXzlfcC+B/FbyYSuFqpIP3lhGtBgHVLjr1/QobE1uNwqF1BZMDIvP3q3f364sInL0QcCUVQ0bRT0bD5URi/ZVBVjG8HYI26hCZeGGb6+EB60GS/8y66W4PWA/jNQc3Q0SUg8zgrUCNnPFP/RI/YxGy6DZn+M9kmyrzhQveYmyFFd2qUfft9BuVc7jmYI1suz+gzbvrUWDEfMurQMEIPkf9rQ4eM1Si8VdO+q0PwTDEoWWaV0jF3TIqqUCmYN/MZeFdTQQzAn9YM3bOS4yVZnTfrrSsHsR8llt5NNgeyMeU/TDCEk1mhX5+AeSjq/lllsyJrTEwRA5LnwtIu2RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgRhrGB0rwjeKa9M3fd7biKpp8/l1C12d3Rquf/9pHU=;
 b=ggV6IRmICTWZK4vCYiY1JKIMX10tr/BzaUW0AI8AUBBUcXQlwinWpIKaq0b/Ti/YQByL1hEsUbnBMBW5FhlqfUza7auXpu1N6Z26Rk/hM545dOkEIlsdK19JDrUFeRFF0+Bb4t2aRQ953lk6ZXV7BI4AYJjUuRNhqFyiBLcpsDXs+qDOMldS150DWF5GBoJti2TKfjCtCA+FA1PNPM+kVyjxBQlKeuPdW0Bx2NqDKWKnSEXzb4hCRK7vg1NTW+q+qzqA6c0PS+2R9m8r9jMQDxqAtJTuTgEJDHBJB/DZBDO6H8nfTzV3oPPHJV/Ud5k2Bd5kXibSvIpGJGn7eGmQSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Sat, 23 Jul
 2022 14:02:15 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5458.021; Sat, 23 Jul 2022
 14:02:15 +0000
Date:   Sat, 23 Jul 2022 11:02:12 -0300
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 02/12] iommu: Add max_pasids field in struct dev_iommu
Message-ID: <20220723140212.GC79279@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-3-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705050710.2887204-3-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:303:8d::31) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38754652-0de0-43b1-65fb-08da6cb3f2d1
X-MS-TrafficTypeDiagnostic: DM6PR12MB2761:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oXgH9fIiszw+RicI7v0quIygNkJB+kSV2e0jv7M3zBAxL0SxEMdbK+JRVcMbZZ4FcIbY1hrSHOIxpEMSyCLPK3MUeeM5S1SIgHyCWtoFba+duZQ1BzD1vZoQUdsy04JY2VKAL8/kN86l1eqM3HYle2GWJfMy/baHkLpIKBwc3Lqrn/rZ6j5+I/xEDU346Kt/JFwFw1PnQgk2CqDbh7dTSQKgunY28YhcpTFYTGuNi1ct3qUlyQcxw0+Xy04OryjGcE8zmAOHbQYziuPG14XfRMXSrKW5jEQtNiKiaeqB9njpyOrXt03m/rs5NwNh9XpbbhLrixhbMe1OEtI9l53Ikh47twUn+FGKUuZn8LziXkOCFQsgbxfwgbam2R0adjF7L4kWVGujnemgdkyERog4xL2G5wiVwsI79hubhD3BCM8niQdTmKdo7r5/lIAqAgNE3dK/4JGvhnJTXKXJomXbFreEzFs82IcENUyYWtvUdSCTjdhRcMqcaESNphD6YgoRZwOcDB9hmTaoZMl0DFSiZT1eT2aSvfXezrH0PdPy6eEtDtJXM1UGKZuiZRdns3x2NCMBSbrbhUSQhVBQRIbalkPbyGbVwxRfTMzi24gvJoqLwkwkpwI5+Nxy+Ta1wPM6/x2+EmZp32hrPWdkjbWfXj1V2Gpj6Nn3Vqs33OYb838PE3Ohbn9EDB5KeIHzmFljlqXo0m7cDk6b50Zr3lODl464cSlH99Q/opWIm+KFCOEJAzBMFGR6EROZLv4S7kdB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(6512007)(4326008)(66556008)(6666004)(2616005)(66946007)(8676002)(66476007)(33656002)(6506007)(1076003)(41300700001)(26005)(36756003)(478600001)(6486002)(7416002)(186003)(316002)(6916009)(4744005)(2906002)(38100700002)(5660300002)(8936002)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SwjTI9B46zaDaGQBSSQdR68CK81qeO6tvca+b9EVBjdn7msYsPhR0Lt99O9G?=
 =?us-ascii?Q?otc7onGDZyDO314sWKtAiUWK4dgWJbLXQ6Xk6QrsNpakH0xUdZcqhPQwCEVE?=
 =?us-ascii?Q?cKC1LPsO6TkRP2UPpwMJhxNacpkLEaYSG0PQp8EoOMepY54Vc6pxUIheQmcc?=
 =?us-ascii?Q?0bLuFwJrsyporLHL5J0S8Ib0lLo1/4yxGjGb5Srq/YEtKZHdyHuSJQyTV5EK?=
 =?us-ascii?Q?wXaq8r/v3IfNL3oJS/+DzfmhqTFOWCm/bDQpCMokl5Ko3QOK4lsWkY0514nN?=
 =?us-ascii?Q?1nkh+3UHvu7RNehOOSfNGRubcZ8eOnj6/gJecSKpCAs4gkMX+Sy/Yg0uD7FU?=
 =?us-ascii?Q?IHrpdj9JNOctiu8lHaQHhMScigJAvjTZRkxGI8iJr9sIaev0+z0fw5kXamxn?=
 =?us-ascii?Q?MChLRREpvVUNMl8gibrHzEHvdEQtbcxvV+WY+ES1UsTd0ftZKUiAF063UGUE?=
 =?us-ascii?Q?EKLQl3cPyiQxz7I7xtfYQXZOc96D8X9JWnLT8G68ExB6O+KCJkjVTUyNyqEm?=
 =?us-ascii?Q?fvLnvq1SQ7lrO7jUCX2GydbLa/VX2g5dC4N8BSLDLNJMlCVU/QThEvaA2Y6P?=
 =?us-ascii?Q?4mQ1a2Rxty5a2PCDNBOQucsd8A3nYRZQztJdaCndiDR7XsWuGsiWhopE97E6?=
 =?us-ascii?Q?ZfLwtGpJer/jxy0LdQG2xoYxj8xQoVt4GuVmHq9sYiWLuu6EmH9WQukTQBg/?=
 =?us-ascii?Q?PlG1ddJq63OEba5CY4FBkPsfHgUZcs9skDp1qTVgTMy7uC0882g/49qSwPT9?=
 =?us-ascii?Q?ZcuSwtsaFXwAvY1Reyu1zO8rXSfg+lT/7fo5hMni+lvkD8EKk3u6mat1Mlay?=
 =?us-ascii?Q?qp/YvtJz1mlBKPIFdN+HjFk4SrjeWNZ+Ssydk3i4JXmXSngSJc+Kv5BTe5KB?=
 =?us-ascii?Q?FiP9pvquk4uodL9jVF/IuQBtz5lS7Y/Spl9787oNiznC1p4fHFS2LoZYPtCe?=
 =?us-ascii?Q?LQPCyoVWp4tbaWWmfWoyYFeObfq/O/1EEOHfPewdQr5RYl55V/HPtl5vK2yy?=
 =?us-ascii?Q?Ti7hrEDzPMn27ed/dkVzg7vNG0dhNcbzN+KmwIfGo0sXb/GsSgoxLRQQBTZZ?=
 =?us-ascii?Q?5BPupmlW4mKxehj3+8Cq27UNCdeipB6wmKdEZ9CLR5W9EW3AAXcCRpm3gzfP?=
 =?us-ascii?Q?bXW9/k6OQF/YUogB73Id4llzFquhsvU6tkwXd19i0Pr8FhKiorj/LhSB5tQx?=
 =?us-ascii?Q?Dyw8tN8DFMXCv6Bo0puqR6iddTnK54ERXEkUyTENlJZvii0SIRjIsCU7BzTZ?=
 =?us-ascii?Q?Qujtss04z640/QY71l6D1pbqyXRbgEQJ6ueoDDo90E1Ne9XA6k1yNoA8E9DR?=
 =?us-ascii?Q?24VRqX1rQy4ZKZcO6ASEznet40YIBXowDiqEEu6AXq7f95v/Rv95M9nD2Y57?=
 =?us-ascii?Q?//SL3jv0Pd9HOB3N6z1TuKSK2m9sw13lB1q+/PsWAm7WcpIBHiWMXK/lPG0U?=
 =?us-ascii?Q?Hpko2HIZfYjnKk+DauhfGNwGyEkiiF4thLqblYoZ/NPM6DERHd1JlMK9Ow5e?=
 =?us-ascii?Q?J1ZE52UV7FPWk7DppYN1HsadpRMK6Mv2ECASfI0oZztabY60ayJ2025eOIAm?=
 =?us-ascii?Q?kD8c4l2ScX9Cvld7NGw+OlJK4wYiD3xAkGwCJO5q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38754652-0de0-43b1-65fb-08da6cb3f2d1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 14:02:15.5882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgQ7mDt26hbhlRUlCW5p1KYga+cyacZO+MRUIM7d/65nMgAnSnIEYfMQScDMK5WW
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

On Tue, Jul 05, 2022 at 01:07:00PM +0800, Lu Baolu wrote:
> Use this field to save the number of PASIDs that a device is able to
> consume. It is a generic attribute of a device and lifting it into the
> per-device dev_iommu struct could help to avoid the boilerplate code
> in various IOMMU drivers.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>  include/linux/iommu.h |  2 ++
>  drivers/iommu/iommu.c | 20 ++++++++++++++++++++
>  2 files changed, 22 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
