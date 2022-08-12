Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742E4591530
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 20:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbiHLSCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 14:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238086AbiHLSCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:02:48 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A5CB2865
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqS/ZR+Ad5nJMjOehOfUpKm4IIeuje9DAgY98hMxeBmMwGPy7dJ4qB7Nw/bX5XuJb4+R5RgVClfTYRu7Yj4nxtV6yjI68XJSwSLl7ss+968XKVuu+L8aOicV+/qWuQ8fF8Cyhh2UIq8DKhTYCiDjJtoLazrwSzFpSRHO65GAo5oRNsKFfvNxZN08qSIUFMa0X2dIZTCVCGsa9LK17wrAMLVtWgqF9y1ChD5cM8t6cTJNtzBa0KzqsXK6EroRx3gds93p4wGZ8TV2SL9EPLKyYOXH9SszTGPxayQi6jJ9p3jnlsHWU+RVJPG9GQEf+TxRQLgMqRg2n6xPEFSNfEkO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5gt6Zg7d6bdRXaJRss2RDX1cvh4CFPpPnePPND0e/M=;
 b=fhmy31fUb1PrqXwg2WAY674dNCCqerVJ2EquCwNlPtqoMZE3vKlvwRsWhod1tF0JY/UBB4whuoLlot9sGofJn26feWJ9xfp9UkXIUiDhRf6nn8DFqvSPdppOKifGFqEWp9XFkAelT/84KAvOmTUSZW46bbB/b/fjxehhS8YmGKla8Evdq5Tq1pBUjvMAYbh4WLwNO4ePU/k9t/ghB4NZDYWzhIvd3YMDct1VN0gbMaqyjxzQjkJ/Qay9shcoXFJFj4VA08da5IZ/JACH9N7ulWDxixNjgiosbUlHNrusnYfqgjfaHmpmWHBi1we3QodhM19qKkGZEy1/QmKvhsNEOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5gt6Zg7d6bdRXaJRss2RDX1cvh4CFPpPnePPND0e/M=;
 b=noWYHMFCfzeD8JkYZRBKHw6zZKn59nlvMEtc3pqsDbWvWG/Qfexgd2fiomxW999nfrYLpo7ZRE2M8hx3SkqDj1e6Ys6T2za84p71BqYOsLmXgUFEwwS2uZqfrYoiun6LUHRKJG/7r0pEegrm87sRTfcmtpAmiO104ZdH6QFxAXShI43zINGJvB4S0BmZTicFyQM0NcIX0yvYUaF4JNKEgyT/czVjwN/F1D4TNUsiMdG/FnlhqiaR8olIXE6IIjHl1nvIiKa7OAhlWj1OLC6nJNu5xamQdUIyuk8VBTahB1jynnaZftKbr9vphn2L+e/ksynn+iT18JYywbwJykk15Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN2PR12MB3694.namprd12.prod.outlook.com (2603:10b6:208:165::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 12 Aug
 2022 18:02:46 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 18:02:45 +0000
Message-ID: <51d4408b-14f5-f6a8-80cf-d23cdb0a7c69@nvidia.com>
Date:   Fri, 12 Aug 2022 11:02:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 1/2] mm/gup.c: Don't pass gup_flags to
 check_and_migrate_movable_pages()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Hildenbrand <david@redhat.com>
References: <487960bf67c7273ff5606c76f73bb51271bc7b90.1660269441.git-series.apopple@nvidia.com>
 <YvZOSUrXoeYnuCyg@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YvZOSUrXoeYnuCyg@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0006.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::19) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f884319-71c1-4f4f-0529-08da7c8cdbd8
X-MS-TrafficTypeDiagnostic: MN2PR12MB3694:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQPG80qTl4c6eL/pp/zpMGbcREXRR+9/9YlsbhBroy9bSqa/UrrGKXKUxRQXfqCGd+9pAVe+qZbHp5N/YVg5KmhceV64DlAu64M5IsWOrdG6aJHwAM4TtIDTUtOa8nSvnDcyDiKRcZQXo0wUTefg2onOUrNF7Oh/Gvb37+sC0a3tiQBcfiV8TcyT94dTxaYSXdPRxSqURX93/eTimIPZ+5IqHg1MxzbZkKTKbEcQoL9ur3o53rayKwNQpqFKgdBwiu+APmy7E5T9Ssydb0ztltVCxBMOtfQInba+ucrsRT90b2mHNrWKsxpzeC+elD+rfSDwN4agoGApJ0PH8ZQ7GweC0eQ/8kkIJEHooCpIjBYvpea7jR5wcxNWfcF49Gvj8A9b0UHfXRK0RR0X0DlEaFTJkEZ70SQ0CDGfeLlRd5qff3gTDfgEq0tYtJJxMLDEWB0sJLjL/2T3xO8GXa1u/ZoXd7V8E+QMF50A5+P+6gWu4W7E6YI33lEBDuDSxFKJ/6YOOAuoQj0pyFmcAAb8ISaVmlFZGIFVOaZecl2pS7T15OvmUgKZWoKJ6tIU39RyQQKXE7n/1WtxnJOh0lunMDaa00ahaZHF0b7QVx3QzYrh3EMruMMhuMsPq/AJLTgO838SmFZ9b+WuAWFTg6dXGUvdZ4Kbz3jGuXxvqmSu3sCpLiSp/G6IjkuUA/W9rK5wgKbBnFEJW7aUxj6WaKvYD90A5uZmxfpPbGdHDcSXf6q3xoHtWMj6qo1uTJUOGfZdtuAmdQH15HLuR+pBhBVK70DTnOVODVqEvywbjxgouznHPTAVRImuRlRyyHcEkv2uDGifavrZMWK5d2eWO39CMTAG+muM97ZkDt/PV4/NSp4J+XgsSPsDOVqD7Pgz9XyxotPTJr1IzqiTIFxAZgBkmqxWA3rdxRlAJcpW21//hjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(86362001)(31696002)(38100700002)(54906003)(6636002)(110136005)(316002)(4326008)(66556008)(66476007)(66946007)(966005)(53546011)(6506007)(8676002)(478600001)(41300700001)(6666004)(6486002)(6512007)(2906002)(8936002)(186003)(2616005)(4744005)(83380400001)(7416002)(5660300002)(36756003)(31686004)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0tsRzNSY3M5SjZoSWFGY1ZkcS9aNWlSVFJ3Z040ZU5MYlVOQUNDNm1QL25r?=
 =?utf-8?B?WThvOU94QXIrMHBVOEFJMERnVUw5K3dqMDZDSU4yVlFXMDBybjlaYUR2U0Jq?=
 =?utf-8?B?akNkYk5aVHVBTWl2TStnU2FMcGNOT2FzKzNNSk5Gd2xWb1BHSmpmcFNEZkxG?=
 =?utf-8?B?ODliaXVwNWxpS3pOTk9UaXJVckQ1c0d5cDRFd2h1aVF2aU1oKzYvMXV0aUFu?=
 =?utf-8?B?RE01RVRoRnlOYjQ1V0JEcm5WNE5FVXFDUEljWUFSOTFwUU9qejUzcEFicTVH?=
 =?utf-8?B?N3VlT3ZwbkIrc3R0K1dNRk1kaXdENUlXTHJnY3EwUldTdlRIc3pQalF6aDVI?=
 =?utf-8?B?alBuelJTVUZxWHJMb20rd1hHZ1hZb3ZNRmIrTFlYR3R1N1pPV09qa2hGNXpr?=
 =?utf-8?B?R1hXaDd4YVRQQUFXU1BhQnJrYmxTWXBUbzNVaU9lS3JvV1lrak1ZT1Y4V1dY?=
 =?utf-8?B?LytaL2JRN1ZyT0tMYlVxOFcyUDY4WTJPaFRRT0lXRVgvNnE4U251N2JuRmhB?=
 =?utf-8?B?THVIRDVXbVJGUmxnditJc1RXUVlUcTlHN0xVMlo5WVZiMFkyZ0NQbUpmQ0VH?=
 =?utf-8?B?bitwQU13OVdGUmpQNVNBVWIraHR6SWhpL2VaVzYwM0hES0E3Sjg5UmlyTGNU?=
 =?utf-8?B?dkUyL2hxR2Q3QkdNSXdlMC9FeXdIS2pNVXJ3cFJQbytWbnRTQTl4bFpQdmRi?=
 =?utf-8?B?ZUZVencvT05TcVByVDllV3FxanpabW82WlMzdjdWR0sxZzRXSGZ6TjVhOHp3?=
 =?utf-8?B?QUdqWXg4RWJRWnZUZU5TVmg0amZ2c2pKWHV1WDRVeDNva3lvbDFSUk9TM1F5?=
 =?utf-8?B?aXhKYmNkRTVxUnRxbHpsR2N3bkFnb1JidmhoOU1XTHhLcWEwd0o5a0laaDBn?=
 =?utf-8?B?UkFNeWZEdTFzcyszWm8vQlpzOVFwWWNXTnd3UGhueWhjUXM0YmtuZ1RPYUFJ?=
 =?utf-8?B?VDRhK0FRcEhua2hxcm9YaXBCR3hlZ0wwWlZEUGtTY1BQRWtiZUJHbXdBZ04w?=
 =?utf-8?B?Tkd3NitDR2NabUl2R2tXWHhzUHllZ3NHNVlNaHF1b3pva2VsY1JtZWgzVGlV?=
 =?utf-8?B?TlJ5ME0xMUVER3ZnUWlvOHJxVGd1b3ZScFdnRXNuS0ZNODk4dllZc1BSVzQz?=
 =?utf-8?B?OFpIWm96L1VJcmFPN2EvK2lEaGxMZDdSd0V6TGFNOVZ1SWMvVUo2Qy9TdkFP?=
 =?utf-8?B?ZDVsWDJlNFpkT3Y1ekI1OFhERU81UllFSXpQTzdQdk9ybmFpTFVLd3hJR3Yx?=
 =?utf-8?B?RlV3Q3EwN2tRZVlINEhuYkp3NjM4VG1CN08ySGlhU1FNeHBHeWh0NktNSlRV?=
 =?utf-8?B?cTMvZnBqMm96VVJrTThJcWpxeWFla1lkWTlYY1pKdjlVYzdyVHpCSGh1dzBC?=
 =?utf-8?B?ZmpMODNKc2NSQmlnbHhqVDJMWE1XQnBlQ3cvMzVpd2hSOCs5ZFZoTWxMZkQz?=
 =?utf-8?B?SFUwVHIzbmJPTVU0QmFQdlIydXgxaW1kaS9hazlrd201MmluNnBwSk1hNENt?=
 =?utf-8?B?QkNNbG8vcU5Uc1Iwekx5V3I0OVNTengvenZpT0txTHBOb2hWRGpWblM4V2g0?=
 =?utf-8?B?NHV1M0ovL3lWRTRuc2JGSCtEYnhFelhyYldvUTR6UCtzZmcycmg4cjdGUXhy?=
 =?utf-8?B?MTYzYkVjZVEya2JhOXpBZ2JEMlBOUS9OUEM2bnhwVW1mc2M4eU05cmRSSllq?=
 =?utf-8?B?b3pmR0ZMcnI1ZmxFNEVUQ0NpS0Q4MTlwYXBNNWlzT2RiNzRyWXdBK2tPMzU1?=
 =?utf-8?B?THNZbjI5eHRwUGttZ0RSdnU1WVFsVUZVWjcrd2JFZGpXMlBrYkFzb3ZnSEhI?=
 =?utf-8?B?NWZyczVPSmx0c3ZMUE04WWpIaS9PUXNzd3lUbzVGNm5TbmU2bEZQT200K3oz?=
 =?utf-8?B?Q29Db1NsN0RCVzhlS051UFRwOERoL0hlVE5CYUxLR2h2bkZzQ3ZlT3JVUHY5?=
 =?utf-8?B?NXRPMkpldzFxRVNCY1pENjJ5bGRxTlM0a3JUVjFIL1Rtb3ZESVh6R1NLd3dE?=
 =?utf-8?B?SStGdm5vc0hCeUhGYnFGWFZSeC91bGIzdm8yRUdFb29YZitWbTk2end6THFa?=
 =?utf-8?B?cDhTUlMxeHgzZ1RVMVpYemlhZmlPWklPN2hyelJNWGg4MDYwbTVmaWtPQ1Iw?=
 =?utf-8?Q?WC5ozgK2WLV4gNcuKnySvv6JA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f884319-71c1-4f4f-0529-08da7c8cdbd8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 18:02:45.4322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKWSwu/HuXKJzY58BOJOfKs0IovOM4peGl9KlcRMETbk1zCY68yvxqEFZnfyu7+Y1mUSXaRjzxT3pWt4WEyjLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3694
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/22 05:57, Matthew Wilcox wrote:
> On Fri, Aug 12, 2022 at 12:13:08PM +1000, Alistair Popple wrote:
>> +			get_page(&folio->page);
>> +			unpin_user_page(&folio->page);
> 
> https://lore.kernel.org/linux-mm/YvJddHPZsh7Lwzps@casper.infradead.org/

The above fix shows up in patch 2/2. I noticed during review that
it was applied to a different patch than the one you replied to,
but figured it didn't matter which patch picked up this fix, since
the problem precedes either patch.


thanks,
-- 
John Hubbard
NVIDIA
