Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789C7536470
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 17:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353517AbiE0PA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 11:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353491AbiE0PAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 11:00:25 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ABE11E489
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 08:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/uto/Sg1rg0SMTBb/SaqkUmFzvaxfNCxuoYtYFcdjICWVpOZu8C+krTfVZgtS08UW3zw/N6oSnNk/kZzBqPlhFqFT6Xs1tNpHbk3cVVCFACHDksGoXQ3jI1byE3G+Sqjlb/nBGlBcd8sKDpJVVWjxZwU0F5OmMGMG/71lvOoE6htO5oNN7UcIBEzBpa56K8yA76X/dTCfC/LuJ+qku69ZxrP0/o3L/pN/uI196CQm23yo1heUAxpIPkTk0NBx3ljN6ZhwpJk42Ypuco8kq+wWnw4OiiXjWttvY9qxMdKXUQIUqJdU0Ih6rAsP5v+fiQ5fUpRSdOu7hW0sR/KHMsYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4tf6jicmts0ng6bZk0sL8lhS4JJVoxNYalJTv1mNl4=;
 b=WjS4hCE6RqtP7d7N7GueAihfKykQAYrI5/LwgPTPU3D5+tTQtGQxQT6M+k8Rhfd2r8EhSV6l/7OWG/lJnyNf60TOb5n/ICZkmQhK8cF3J2JIvabHxt8HYS8UWf1fyPZ9H/Nk7R3VmAr6H84fbtL3HMjoX/22PJrgLjb5PP68JE4CLbw3aMBkyLLHtaYrqQMcG0rVox7jrCga9tqS4MyP6axBFHGQnRNcEPsSfHwXJa0dKi/FMX7s+LlDfGi4HiyNmLD9lQj5w/JHtljxYW4ym/cKkqkebs70minvduH2+j392mK0xrZCLA29StwGnA3NXgiCTKx+f0ptUQ7FXTqNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4tf6jicmts0ng6bZk0sL8lhS4JJVoxNYalJTv1mNl4=;
 b=KPIaDic7/0nJTzV2Bv1PE2FxSdgjMFouav6gZW6v+g1MrC4HfQg32vcOZlKbCB+vZp+2Szk7MRq/UiwPYLiYxxR3ygNNV9ueO+8OSW53M3dXVCD83ni8B9/ibXwVr/KCoRGG0nBJuHaHHRA4gztghj4ZccrDt5q0NVWzeoypftYlL5VMhoUa3Q6uIV+fHuqWhikbCJUa9nXWdVCjKb+j6rTFyPMpswimwJV9TSlwYiPMNL/F6pv/JWIITqSbxOzThYuGeZzsnDwEgQYybEtDbcyZFKzOIV7kHYGGLIOuxm3YBrWNDMvFYZ0EKLZnwwiLGZ6RRRXcPF012K+z2cYGlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR1201MB2492.namprd12.prod.outlook.com (2603:10b6:300:e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 15:00:19 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 15:00:19 +0000
Date:   Fri, 27 May 2022 12:00:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] iommu/vt-d: Remove for_each_device_domain()
Message-ID: <20220527150018.GR1343366@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-3-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527063019.3112905-3-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:208:32b::24) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ddea8bd-9fdb-485f-c367-08da3ff19dec
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2492:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB249224F6844AA70729E66D33C2D89@MWHPR1201MB2492.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJdwFgvquNbGz0z7jBYaeEDAf1anOYiLK7EfIMZ3yWGUzOMPfopwEdqhUuDrgvio88Z9wA1si9A9hc6E1xIk4Jffau2DCnRq4ikouuVDA2uvuY7rhM+jE8wVgJti7fU2KZic+RgLfp4ytmBy7ZT9KVNor9ybrUy1MflJ7411Rgp102aKTogB0h0c5sm9k/23q+PoeyJUp9lhk2yo4KTeL+UK+xgy7OvoB749BO5woVzOo8dQdszrQqsZW2PqGkawselSyvGJyAZAWN5WfnCzX63xTB5IVBifnSuORD5HPzZLN+q6RGGAew3n82KZZRwZv6v+AtgKT/Z4WDfB7Vr++1sDgVIUing/hqNfnghZmlf+OCgTw3w5gecLKJp1s6UEqCvp1b8UHFXeLy2RRmbejwzkFcASZgV5lXjxsNRzg4pxKtNzMDmz3IehoohkapdRURLEPbDsrCzhVur2ghNbYy4tFAL1BcSaMOF08jsc40uA5G0cHb2Cfpq8Q9B8DTYxniQEUxniUUsD+H9W9pVCBn63HmWWp0NX/7M2f4G7JgQ411i1P+15rHrpDNUaKTnrW8+RN7Bo/fwOUFl2mA/0SSRcMeC4qVIvNurhheCVCeslDbhlx7Xxt7pC0uuCZ8ScT9p7MaZHEi4LS7ApKe1+Tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(6512007)(36756003)(6506007)(33656002)(2906002)(83380400001)(6486002)(8936002)(508600001)(1076003)(186003)(86362001)(2616005)(7416002)(4744005)(38100700002)(316002)(54906003)(6916009)(66946007)(66556008)(66476007)(8676002)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7BoPc4ZtVYyXCmE5HrhFe+jcsfx3FFUIHGENso+OIjygtwubz22NrK7ax/lV?=
 =?us-ascii?Q?ZfrkM+k0lAONL6T2qWhbmW90Z6hfFupkgsN2L60ms/a5G8QtwB99Y3+/Ix8g?=
 =?us-ascii?Q?kNrd33PzWHqIWstosksMjQCOBgWPuALMVCM4zJfgGa2bg9VAkmX/FpoveBBZ?=
 =?us-ascii?Q?S8Uj1Te5VFbf6GKYGHqwIuyqlY8AcBbGRCVBcpu7GhARekniFFxyby0VTIod?=
 =?us-ascii?Q?z1HwOiw3glr8Luoe//SLitN6loRNKHXT7K1dy4WJw2jxkIAco3vBzUsMbz4/?=
 =?us-ascii?Q?Lsk0qi9xsbHdkDvQe15dAx6tMQ9rQHn3LnwAW5VEZEdvZ2teDTiQzp2GTeH1?=
 =?us-ascii?Q?Wc7zKWN1eCAAGTRETL7TrWlne5NvXqaC+dSmO5hz09+kOc4XMAdYeuwQwhYN?=
 =?us-ascii?Q?KeBBNPJShMzr6Mu6vEn72706yNtJreuE0WeCm7KSvP62Z0kSrRd7GksNtWsw?=
 =?us-ascii?Q?sVRoMhtHuOhTEBW1ckqtkr1Ja04QFvPC+0eEeqQpIFWJyO9jtCggdWD3/v3Z?=
 =?us-ascii?Q?+bdkznHzndlnBTNVIG9LXI3+vCaxxCV97P6ymDsVBUd3ZEo6PIqQOsEvi+3W?=
 =?us-ascii?Q?y1GVsjak+xNLtWAPN6HuR6WtqfgrAi7kvA7/Tz3aEnr6747OMx5KBhB2fZdZ?=
 =?us-ascii?Q?f/TcS0YtjhsNGtmqBX/b1ka1R2HeaGxcK2Lut68/MVcq3+HMY4g7461sHPUW?=
 =?us-ascii?Q?0BsMeiD2k0qLasYsZJ7i8+EuTEBDV5EMyGAkzBCklVEuZG4QpI1zQTZ16rdM?=
 =?us-ascii?Q?6aeyVH8e2UpdOExoEXmPLTZc/wZqOVxR0W9rCVv1z4ugizeejYB/pRUVY9d3?=
 =?us-ascii?Q?+C0vqpvpvLfALfAPWI3W6fupMek8757aw5mHGwvZgxc921a6MfVM9womKGzR?=
 =?us-ascii?Q?NYUU6twly1eYLnfa15X5YtlRaKzy9wCWBNriGnH671V4HG+vyn6PJjP0D8e/?=
 =?us-ascii?Q?s31fmBxrCV2f417lAAajZQATAOXWyZpJB7IUWCeDbJA3+61//CJHmIUd4Q2x?=
 =?us-ascii?Q?kCyEB8KSJlqcjy2OvcuPa/Lzrmv1V2499UMePIgTJoYaBwvv1gc9n6qgY88F?=
 =?us-ascii?Q?JBXAwuuIiwHQpyUB/DO21tBcEkCu3MDGHj5/5V/nZaGXNdz8zGO4pLzuMhhy?=
 =?us-ascii?Q?yyP34oWfiWRGu9EhSlaM8LhSHMdg5POCiLSDzk0Qcjxboy4ID0b9IVyWeX2N?=
 =?us-ascii?Q?HdIAb3e+H0Xmlff/9993EwwQSQyc8s7AgiG7f4gdR16wHPM6ysOvqKmqqkyG?=
 =?us-ascii?Q?L9HZiLZ7Om6NtQQ/Olu7zTV2ts9c9a9PE0WwWO4fAZZ8HwRcBwaTNb50bdIb?=
 =?us-ascii?Q?dl3/amhh802IIpMyT1GVxotQBcyIh1vHVxeW3Wv2h6FJ71+dvMAFNuZkOe9P?=
 =?us-ascii?Q?j1OibGnepe9eT9Op4Jj/kDeA/Xk4AKdJ6ZqznRHH9bn99hmIV+p5TpOhVuy2?=
 =?us-ascii?Q?lyGZ4ISJ6afzS2650Ch2PuiT5Sg7opdwRAa6OMqTTYVJQT+Umc6gcl2A7X94?=
 =?us-ascii?Q?8r8fUNLnpaTezlcj9pAxlElD1Mn+ErEa4ChifV7dtoK1ClFfdYOL/pgb1FJ3?=
 =?us-ascii?Q?A7bxpVgff0ChYpV1t1oXYb2KP2FoQfpaP6hAzmmSv77BQdSrDyJh9/uEZNPx?=
 =?us-ascii?Q?Wl0ZupDX6HCW9zmeednLQULWe3iJSslukRZyg/yulO5CFdyNSoEJ7V1U0fAt?=
 =?us-ascii?Q?/kTZDnydnChK1YfOS9iK/azluDwxab5FnFxkaseWKFRe7+NvEfUsG3vohsxn?=
 =?us-ascii?Q?cKAzC94VXg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ddea8bd-9fdb-485f-c367-08da3ff19dec
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 15:00:19.6674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jO5RLuP9cfi51K7SUC4WQi/DWniDsDg63IZZd1NiHwiTVlTqP3BtKvzzbBwLw5TA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2492
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 02:30:09PM +0800, Lu Baolu wrote:
> The per-device device_domain_info data could be retrieved from the
> device itself. There's no need to search a global list.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.h |  2 --
>  drivers/iommu/intel/iommu.c | 25 -------------------------
>  drivers/iommu/intel/pasid.c | 37 +++++++++++--------------------------
>  3 files changed, 11 insertions(+), 53 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
