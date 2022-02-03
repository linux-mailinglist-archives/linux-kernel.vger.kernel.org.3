Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2AA4A8FA2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354398AbiBCVN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:13:56 -0500
Received: from mail-mw2nam08on2089.outbound.protection.outlook.com ([40.107.101.89]:8160
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235192AbiBCVNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:13:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6i0VsPSmgEc+VIa2tY6ZTK5S6yGhkhVWqE5IvYNcilY0ANJZGnq/2sdR0AIh9evTzpYNClvkN6sMrSibvND+BmbWGgPwE0awZP1f24FoMA7SpCRcTuHy7d0vKZJUO0MQGTNt8AfLxSSyUBXGYETOivHboloRnze0Pnpqn1VFxfmqzo6uoygXibDbgb4KfAq+Zv4m5432qCgydi9W9Viah7fFpNMl1wF6Sb6FlbkWugc4JWbAERnxNKGfbbcl6J1UVrBD1ywdPrKyjcHBA3WSCsNvA6yfG68fxnk0gI4GVABgnIcXF54ZchJJ/F8/dmrQh7+JYle9VzW2Rth/0V5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8n40IcKyRLtd2A0JuqiX9bu0AURHtSTHrs65XIpM4g=;
 b=JqHmO7jNEv6gqYt+3e9WbaQkES9HWvdX0nPQGUtptcPJYd6TVl8Uhv83+mrPFbjuhYkbSJsQeeaTBGcV6Al0oDOoyG2lcxUbl87hmEwNVa6tEu7/issPwmNrFxlMyibkotDBy3RsN3ugHMAFwa16SHs7R4Aq/cErSrAPxf8GUYZt0JGK8IQRxeLTQwJkg2RPGBdbqtESCWmkOLtziYRxrDnv90W3NWUdVs1doUKU7GU6PwhPcC3XiUQ3kFh9N0esguFKb4sBqYoLZDnk1S86mvQu3j7WUOLSpCTYf11RbjWgh6u88FBaz4hwNrnmfEFTLYd4o3A6TpHa6sFFTB08Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8n40IcKyRLtd2A0JuqiX9bu0AURHtSTHrs65XIpM4g=;
 b=ut/5II1xWyzDaOwRR86xqDTX8EP1FScgymCv1AcCDWJzCUUgDNQgY0l5YBNuhqMVSUkOXTyrSohYQmlJ31H9F1fKSRPgNngTSG6ZscBUf/GXvwR77TINKmQD2owr0QGp7VLXLU+p5KKEEjxqj+f3R3iuxfVQvVfr1oRb8ma1ruX0H9c7uO01QrnMZxbgpvSe3WQyvczbtf2WQtvFwuNiEI2gNKZQMSpi9PenTNf7dJ/QzVIOa071ZcmcIFM9FMIA69oPAgYce2JeGVvnr/7uTlnFxvgliOhXfPcC1ZlU15lqSWZ6g9lriA7mmQ7SgBArmVzpj8Aq4SSeo9HYOpILLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 21:13:53 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%6]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 21:13:53 +0000
Message-ID: <012e78aa-fd4a-35c7-5405-752bcd675449@nvidia.com>
Date:   Thu, 3 Feb 2022 13:13:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 1/4] mm: Fix invalid page pointer returned with
 FOLL_PIN gups
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jan Kara <jack@suse.cz>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <20220203093232.572380-1-jhubbard@nvidia.com>
 <20220203093232.572380-2-jhubbard@nvidia.com>
 <YfvgC5Y9mTb3vKlV@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YfvgC5Y9mTb3vKlV@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::28) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43e81652-f0d1-4205-9f1d-08d9e75a14d6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4110:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4110982B18720C696D297D06A8289@MN2PR12MB4110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4/8TAuQhEoCIL2QvtSK2kw3gz9Nlwm/GidNUBkq2C1mxy7kNITtBj4k9iOz25MJfNXxRqP9MuWLJMQfcJUYGkg/62tbKzQcT7L50BVW7vkRrzwJGQOnAMxo9E9LQcX/HwjrlNJaxKiWUi/MCmbUZpszKAgtfro5VrzFmBVayndrpkYJL/yIdk8YqzyVfmno/sxnKPjJaH56rW/6YpnxFVDizdjBAtAf5IWFX7Q/aqQ03QnAffYQf7qTpbWgvl/y+T4NCBnKHdV7EXWNFAuJjaCZ9RYG4jnO7yYwPvvz55HQZaB/dMOBURzoROFCCU1WlNcCg+GDhTg8CQ0IETiYkEav1dLPGjBJv9GNzUHgzYig/NOUZXY/dywxqAog45FVzCZte6MSiucVusiCOB8eD4tvU18gmLKlptFO2ECO5ilaAZBPwcyNCuUVxnGaZ0Ld2oJ8lUmGxorTfScfA7XbviXlV3JnLeDf2nkOBV6mHtToxOWf2AV8cJjwqY2x9wzEOoPyE5dQeLCqsE3VJ0lSpM5Dn/t8gmYS7ivmerK6Mpv4J6LTjCSpR8V+u7V3MO0dh8vI8AMx9vUIV4jZnSoAADWuz7jtnkah8JdF6vfF8LdargOzR3E7XGlQuwHApNt2J2+aomlKryED22UXbkw/l/oLibjTPw3UAHIUB73zwlDd3Up9bpO81DyBd9Gea3CdIw2sWNghmpJxDgaw4EEDEuXrwndHRupuvVET5pgKwqZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(26005)(186003)(86362001)(2616005)(31686004)(31696002)(4744005)(6486002)(508600001)(7416002)(5660300002)(83380400001)(66556008)(8936002)(6512007)(36756003)(54906003)(53546011)(2906002)(6916009)(66946007)(8676002)(38100700002)(316002)(66476007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aS9aMjJNQ3duUDJvWUdMRExBUHRkSDhKNWZ2b2lYRzQ5TmhjVXNNS3dqd0lF?=
 =?utf-8?B?NzF4Mlg1cVZ6RzJBR2Q5dklEOTJLTWZxbGhRdlFETjR1YU12cmZ5eEtWWFov?=
 =?utf-8?B?anlzQkNDRXQzTEk0V1diV3hDckJTOG9RakE3VHBEanJYbzUyY3Q2WG5udkNT?=
 =?utf-8?B?VGhOUnpJaVd0ejk5UGVWR0VIdGVwWUdTR0pZOHUzSzBmYTQyUlg2My9jVldy?=
 =?utf-8?B?Vis1UzdESXNxeldneTd3MWJEN0dpSC9MallMc1gvd0FBaUZKL0pEWExyL2FE?=
 =?utf-8?B?Q1hOWGVTMEVZR1lReGx1Q0szbFAybS9HUXpzb0lIeGVtMDdhVDIxQ3VHU0dq?=
 =?utf-8?B?YmJFdFF2UExTSDF3Qk11UHFCNnREaGg1aWlNQUk1RW5wTTJKRWtSUVlVc1JQ?=
 =?utf-8?B?VUt3U2VqVTdmZ2xOaW5HMWg5cHVtaEJxTy9EVWJaVFdQRmVweW1jdHUreUgw?=
 =?utf-8?B?YXJRTzNTTkpqUlZUcGIxVjlsSlJrUEwyRldJMDJzMjVZNThQMWttZHZmeExw?=
 =?utf-8?B?QUxzdURrbGg4UVRCK01KMkRNbUl2MkQ2ZXdodHRSbkZySHRzSFJVTjhLU3M2?=
 =?utf-8?B?dG84U3hlTnVRRnQxSmxOdzNpbS9MSWtXRjV6aWZWWnhPWWNNcUJwQ3RoRVZ1?=
 =?utf-8?B?TUgwYlFvcFMrTmdxazA5TVZWNXEra1VqcWtYQTdXbUNCVmVBTXEwVEVEOXFa?=
 =?utf-8?B?emNBbmtpaHRQbXNUY2xNL2w2SU9sMVp6S1ByZ2N0WnducEwrS3dqS1dHWmxW?=
 =?utf-8?B?bHg5TkZsSG4rd2dsMnlnelFOSGtsV3VJZ3RRSGN2UVVQUGxORmZXTWMyRnV0?=
 =?utf-8?B?cTJ0Y0pObjVwNWMxSzhBcVFlbEFhcW5EY3lLeElST1pkK1BsdFBXYWI3MmxC?=
 =?utf-8?B?b3NYSmhwOFpIVkExSGhNMklQbkxKc2IxcDdZa2pDa1FZb282WlVRRlUxdUox?=
 =?utf-8?B?SkVmUnNkMEZjbG0yakVvMlQ1YXF4c0pQMEQ4am9kUk4xc044Z1V4bkdGR0ly?=
 =?utf-8?B?UHY3UzBIditHVUhVMWFDOFMzeHVUTGpMN3JUL2JpbTJ2MFR2czB3ak9NUFR0?=
 =?utf-8?B?SnZBSktzQ3YrOGsrYW9IQ1JCQngrT2M5UjNFZ1VzcGUvaTBMT1BvT2pubm5t?=
 =?utf-8?B?VVZRUmlWbDVhMkFQYW5tVytDTGNCY3JDOURMMWozcE9WdkhRR1BmQndWZ0o0?=
 =?utf-8?B?K09IcG4wak9EZ1hxdmtkY2s0YjdIWHJCd3JQZWtLci93dUUvUWozWjd2eG80?=
 =?utf-8?B?Nk1ISWF2N1BITkRvb3hRNmRKWDhxNUI5a3pNS25rM1ZLaVNFaWNOMUhsSm0z?=
 =?utf-8?B?R1JQMUtFdUtmU05YZmxXUTdEd0pQcGR5OGpzcVJHNVZHQjBMRTVLdmc3bXdY?=
 =?utf-8?B?TS9MSFFadXFKa3lUR0lvZ0UxcEJaM1htRXRLMSs2M0N5RG02Rnc0TDNaWWcz?=
 =?utf-8?B?OHNoOTEwL0xtb2xsN3doMnVlWldpU0k2Z0lzWC9mUVBLSURkckRzUS9yUjNs?=
 =?utf-8?B?aFRKMDlEQVR3L2dsME9mdmJYaW9KOW5zRmNzOExNektrTGpDWFVYM3FKaTRR?=
 =?utf-8?B?eDJaaFdla2Q5Zmp3dy83WHZ5M0h2WnpIaTNJb3VRY1lVRlQ2NlhMK3BLUS82?=
 =?utf-8?B?RGNTMXYxalQ0N3JhUWNES0l0RWIxd0ZQcTZFNi96RFNySVJ3K1BxMWNxeDFU?=
 =?utf-8?B?VzJ1RVlHV2hjenVmdHdCTDFkN3dRNDBWV1BidGtzQlNjT2l1KzBidUVoN3pP?=
 =?utf-8?B?eTJBdXA0WGF6bks5SUloK3RUOEg4MGRiWHFqUWRwUEYvQ2NRbzNtTjhteHZk?=
 =?utf-8?B?eUgyd1IvRG4rdmhUMEs4eExSN2MwelM2K3ZnUmdKdlFSbTNSQWI5eFdRcWNv?=
 =?utf-8?B?VGVnYllrNE5kYTFYMkZZZmhEa2JNdk1xeC9YOENMaGp4SkR6aXRmOEloblBq?=
 =?utf-8?B?VnczVEJLYUZjZWFNM1p4T0d4ZTk5WktTd2szWk9OQkRnSE1WRmlFS3VWN3Na?=
 =?utf-8?B?MUZKQWZYbW5uRGdUcGptQVpXVENJa1J1MFU1aDYxYlZNaGN4Tk9ZVVBZN1pI?=
 =?utf-8?B?UG1aS2NSeGhDSVJnQjdYQXkyZ1RBTVQ3VHFaVE9LcmdBdXVaMllkR1dINnlu?=
 =?utf-8?B?NUlHbTZXOVdpQnowS0JZNGg5TjlxdHdIeEZOUmZYMGc1THhZUmdFSDZjb1Vv?=
 =?utf-8?Q?a0dJNLle/B5LHCf8cAizuIQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e81652-f0d1-4205-9f1d-08d9e75a14d6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 21:13:53.3568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/QH/Nm5ITO43Rx6LfyB/HaXTx+qmpSlm5Cd/Wx2BiL/y5Pi5udRONhXekNqPcNB+qB7MQU1HqCHukK/4R7kFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 06:00, Christoph Hellwig wrote:
> On Thu, Feb 03, 2022 at 01:32:29AM -0800, John Hubbard wrote:
>> From: Peter Xu <peterx@redhat.com>
>>
>> Alex reported invalid page pointer returned with pin_user_pages_remote() from
>> vfio after upstream commit 4b6c33b32296 ("vfio/type1: Prepare for batched
>> pinning with struct vfio_batch").  This problem breaks NVIDIA vfio mdev.
> 
> There still isn't any nvidia vfio mdev driver in the tree, so this
> changelog stilldoesn't make sense.

I'll remove that last sentence (and put in a tiny note that I'm scribbling
on Peter's commit description a little bit more), in order to avoid any
references to out of tree things.

thanks,
-- 
John Hubbard
NVIDIA
