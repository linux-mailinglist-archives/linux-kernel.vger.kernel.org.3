Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A84453949C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345963AbiEaP7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345975AbiEaP7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:59:15 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AA59AE62
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:59:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hB6bMUtfEHGYrdQvfmONJ5u01h5OKKkU3XgQ/L2HUEdN4c9PsShRmrbX8CNK+Qjg0tcUrI5qjBiZvvYevciNKi15kuAaksGSmNo4aZtxOymVdEq6phhhKXaWyrQloa5vp0e656gdJyeqZ4kvVN7OVdU+HrDTQh2h7BzJ6SRa8/HrVa1De6Q37tv6UCDZ1hhJpAbxFcdgK4FeK6XmB3FEB8LBGIHW8NDP1dnuEwqSDUnjoUnLebBxmyH1eXk+t+miLNuSkiIIvbqFS/eO0imr9+Au8z7+NqEXrCXoCL4dhE8RYBnmhuL7Wpe4Oe1ltFiP6h3zuXKZcO58FqGDqIo1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7CeqyMG66SAGO16LSNszkZXO4j3V6e7XBzodLqnIwE=;
 b=hxAzlSXX0I+NNntloefk7EN+RM0xmmKfKyry+JXSXJLY74BbKqO5u9Azi1GjXT//qOFh15ye+yYidXBENebaRvQiB4r+WX3JO4w12DaaU/jXdLgAHKLjHIUwb3/DGqXfeKLhSd5Z9LsnmRzNDTyqQokWJJoeyz88V7kVQ/XhtziUchRaNTy94SAdhd53DF3yGILSP73ocbStjFgB2nEeLZLDW+W1z1Yz88PrOrHXAk5xJHy59V1rRNKs8zFHg0thBHBMbWWxgbqv9W4k4ijCPBtrjXFqXWCqGrSTUrouAc/olGZF4WILOlM+mrJW5RhJt4wuOyhtLKfrEcvbgA6wLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7CeqyMG66SAGO16LSNszkZXO4j3V6e7XBzodLqnIwE=;
 b=NfTTZyqroxWgT5YgOJRd2bHQ+bLM2g7POj9ULhhlLagouE8DG9BwSGy3UswYUyyboOJz/ZbuRiuMPtioNSqJuMSJ1VIjSvtF+hCfhZPCdVrgaiN1alTMPvQV+/QzHRD/9QhhhtiLmV8SO/WRvERU1gc3wBTScHlrz0tDJ+r1qGHm2fC7A1skab5KWnoJWT2B/ubgvWUB73XVCbf8b5Gj/blqvjW6496/QxufnVdZuEjbw5ZYVP0qmfAG/vP4h+iO+7UTsxspdDm3poD/Lsc8jcVQpWz7RCZph9rn9SB+cuHODrXnd3QByd8IAvwguSgmnMlIO//o9gmgGLgU5m1+mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1534.namprd12.prod.outlook.com (2603:10b6:301:10::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Tue, 31 May
 2022 15:59:06 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%9]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 15:59:06 +0000
Date:   Tue, 31 May 2022 12:59:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Message-ID: <20220531155904.GA3726345@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-2-baolu.lu@linux.intel.com>
 <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
 <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
 <0b7bd793-a3c7-e7e7-8ef0-214dd5b98f05@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b7bd793-a3c7-e7e7-8ef0-214dd5b98f05@arm.com>
X-ClientProxiedBy: BL0PR0102CA0007.prod.exchangelabs.com
 (2603:10b6:207:18::20) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a307f1e8-2323-4d98-833e-08da431e7d7a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1534:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB153464E4E9CAED81922825DBC2DC9@MWHPR12MB1534.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V2DHnXs7kRfOpmgu8rui1Ndu7f9poWXty2Ejo3s5EBYf5zazHL0izzHTYbc1NNixHMfH71fy9dAgNYukUJVsAJ+Le/fnStJziInagESJsQH0VG1ymEhHQxt0rGRjkvw1MHE9bUR/hP5kridWAu9GV5gBKj4tPvgQwEtrLapoDXF+4B7aNAUvQY0zLi1v+9ajIOWKUM2yLsPCNhWlVxb03qVNzyy6qt6EVKJv+a/e80VcMVxusOkUmfEe5Aw8AcGq+E6NLL3G+LCVzzUZC0OJSPtPuv+Sk72JfSImg4QI/ItPxZ7DhW8yxv6oHBDV0fk+IQj8eKr/fK3M/zc6+R+p0mQr4jkzOEfd0w8v3AZ8stUGfY5O8ipT7akq4b8+eHt9Ix8zTUY2NjTwksiIE2BUpPkcUejnPc3GbgLPjADTI7hkdoCjijqHDOs8IlWsLM9VzOk9dA6MRfzT6LgcMIWsW2eUFPyYgn2ebHEkxH7imREG0nRnquF66TIMC+zaTiGefCSW05TZB9meuArWnBVD5Ty+mNKPX6ChT5fZhS8LFMBVVyfuHs54lOgC40yTrWyBY7l01S7kpBPa4fEaOtVqWM0zn5OBil3nsfWp8dnTOmc5Jt3xhEXYsyLfxx+RPNS4nm3pkKPJzFARyhr/5CLaAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6506007)(66946007)(66476007)(4326008)(66556008)(8676002)(186003)(5660300002)(6486002)(33656002)(508600001)(4744005)(83380400001)(8936002)(2906002)(54906003)(36756003)(316002)(6916009)(38100700002)(1076003)(2616005)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y24wS3Myc2E1QTRuNERCYjlobTB3U2srTWFwb3Y1dGh4RkpiZ1hXSUpCNWZo?=
 =?utf-8?B?WTZ2dHdMa3J6N21rNkZLbGZ6dHhXczJkNCtDVmE2WVF4b1dqZG02TGNFcWM3?=
 =?utf-8?B?UzQvalZMU1pkMTVibS9Pd0NsTE9KWWp0VEV5N0VJbk9uek9GY1NMNTRjSFVy?=
 =?utf-8?B?aURtQnFWcnE0a0lXdnhXdUROYzlURFhzbDdKZHBGTy81MS91c204SUFVTVVu?=
 =?utf-8?B?dkhicFBXRTlqTVZTeUlycDd4V1d5WnhYdU1PV2R3dU0yVnE3bE1lWVluYTFy?=
 =?utf-8?B?RzRPK0FaTjlFN1o2Rzk4aEJNdTVIcGtwSTNrZzcrNFVMWHdGVlRjT1pXanNl?=
 =?utf-8?B?blkyWTl0dmRaK21jY0hUTmNKYWYwVWFLclVqNVlTUGt5ZUYvMWF6RHBwaW42?=
 =?utf-8?B?aHNuWjB4UjFOOHNhVUtYNGVobGgydzQ5STRJeFhuWHFvTW9UdVY0RHdQa0Ur?=
 =?utf-8?B?aFdXQW1uZ3d6blcwNy8zRHlpRzRIa0FvT1JtYm40QWJIakxoaENiK1d4ZjN0?=
 =?utf-8?B?b24rT0NxZHZ5TEw3Yms4cUhQNnNHTjdiNmhVTDhkN25zVFlhMFNralBZYzZB?=
 =?utf-8?B?MStpaFNMY2hPSzNOb2sySXE4RXYxL1dkOVk0STdmVnlOcnNpNHYwWjk2UW1Y?=
 =?utf-8?B?bmMyc3JzQzUwS0RDYnl2M1pvdzRZRExPeStkbGJlc2p3dGZWbHJxVEw3WlRq?=
 =?utf-8?B?M2FnTHlVbVo2ZnAwblRWWmtVbFNRR0FtNTBTN3owMU9Ud1grZEJlRzY2UFNZ?=
 =?utf-8?B?NWpKdDhvZFdQRE9CcGhTRTJVbm5FcEIxUDY0cFFKYWZ1QUpIVFozc0xkWnZX?=
 =?utf-8?B?Nm5XdXVBVE1jL0NqTkxCbzlmZTA3cHo2dm9pYTFCMzdiSE9aWjFCOUZITHZ1?=
 =?utf-8?B?NTlqSHZGalBjektESFZ6WXJYYzhaYlF6dHp0UEF4T2FoYkkxSmRETkhSeXc4?=
 =?utf-8?B?VGc0bTFqTzRKa083WEZ5eHRpQ3VtVlgrMUdMTHlBU3l2ekJBSFg0VVVvTWJM?=
 =?utf-8?B?aENLamZEdjFiNFNyeDhXdXEwL29XUEtTb01PMWVCZHdjMm80K0NwRGlldXp4?=
 =?utf-8?B?QjV6allVaHRXYkdUOW05VVNnYkIyVlp6bEIrelVxRW4yRlJoVklPeTNqZ0p6?=
 =?utf-8?B?cExmTjhsVitUbldwekdpLzhVME9DZkNuRDZZL1pjLzJHVjFBRTZDcE1hdklx?=
 =?utf-8?B?Q2dPRDhVMC91b2JXM0J4U2lZc2haeXB3UHV6bkZVYTVYb0F0NFJ5bkYyVmJy?=
 =?utf-8?B?dmQ1ZDd2bXRaRll6RE1BUU81M0xTMXFBSlVtZXg0Tm9kN3Jhd0psUzNndC9N?=
 =?utf-8?B?ZlRNT1l6Uk5hQXlpc21ObG4rRXdxdmE5RVhXek1sdm50VGhvTG93VTg5NmlU?=
 =?utf-8?B?bGMyVWdIcWl4U01iNVRqN1AxdVp0dWh1VGZlZ05qR3VTcE16bWdxekx6Sm1I?=
 =?utf-8?B?bkltdlVpaVpLeDlCQVQ0MXZWNkY1N0JoeFA0OU9FdFVCYUdIdzhvOVlIRlJD?=
 =?utf-8?B?bHZYcjZnTDdYUFhpMFFSQS92ODhrQXl4M1phTDJLdWpIQlFBNU41WWdMU2I0?=
 =?utf-8?B?WlNaTGI1Uk1pd2x6bC9RZnlBdTRoM0FoYTB6UC9lZHFxbjU4M0hVSHZaTERV?=
 =?utf-8?B?R0FCTXlxb0VYdnRKWGZLbWJvdTIwWklDOFVPZko4Z25QaU5nejZlcFhoZWtn?=
 =?utf-8?B?QStvMStiU0hVb1d3ZDZpN3pESmZrdEF5Y2ppdVE5bFRYR2pEeUxjbVB1N3pk?=
 =?utf-8?B?TE8zQXdzZ256WjBQL2JiRThjcWJKeHFqVzhvM2xOS0RhNUloVkNSTTVOYkJw?=
 =?utf-8?B?ajJETHNGQUcxd2Qza0JTcWphS0tJMVRKYXVkcUNzbEJ5SCs0ZitkVWNhb3VL?=
 =?utf-8?B?NFQ1TmxCN3pjdEFUV2tiVDFubytYUWJBSkxJNmZmU09MVkZ3TUdwZGYwdHkr?=
 =?utf-8?B?L2ZYS29jVXprSlJFL2FuaGV5dmN6U0hPMEV1bytBcUVCOWh5ZEx0NHlNeE95?=
 =?utf-8?B?N3RjUW5JS3h1dTFRVFE4dUdCcGpwRkNWK0pJa1IzM3VQMHpyYTN4Qm5ESHNl?=
 =?utf-8?B?VDkwYlI2RERSZ05XSjZleTRxS2xFb25jNjFxc1FwenQ3S2VlTmgrOE4vTFpY?=
 =?utf-8?B?K3psN1lVMlgzUmJ4N2c5ZmpYVEhxT3d3dnRld2x3Y2dqV3VXMUhhR0VlZWg5?=
 =?utf-8?B?RzBQOW9WN3NHOWtzTFNDNm1lRWIzckp4UUxwUFNhRnA2aU1HdE9DczFnVFZD?=
 =?utf-8?B?azBRQXhwTVFJQkduTHJ3eWEwZFl0bnRVdjYrV3ljVHY1dXNIRjVINURNTEQ5?=
 =?utf-8?B?YW1FajNDY0RyUmRXeGQzOEZYcDltU0Y5V1FOMjB0ZUJmK3YrcDBSUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a307f1e8-2323-4d98-833e-08da431e7d7a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 15:59:06.0700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jq75xuf991s5r2XM1eajtpQsgXPFNZLvSh1iDRmkEtgdUZ70/HUKFaoCwH7T8w+S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1534
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 02:52:28PM +0100, Robin Murphy wrote:

> > +                break;
> > +            pgtable_walk_level(m, phys_to_virt(phys_addr),
> 
> Also, obligatory reminder that pfn_valid() only means that pfn_to_page()
> gets you a valid struct page. Whether that page is direct-mapped kernel
> memory or not is a different matter.

Even though this is debugfs, if the operation is sketchy like that and
can theortically crash the kernel the driver should test capabilities,
CAP_SYS_RAWIO or something may be appropriate. I don't think we have a
better cap for 'userspace may crash the kernel'

Jason
