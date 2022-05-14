Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1A6526EDC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiENCwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 22:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiENCw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 22:52:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52DA308848
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 17:56:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMprto5NmYnedloCzTWSvlX/wyYUX7cdfJvBiWbe1aDvdtUF4/JqRLGuW4OEBmpovBN2Pjw2hGsL6VVw9IrkLnckgyFoOqr0VpyhKBlj37cRECMSj87xjWu4dBFNk1r/A5UZTlOKRNhQiyh9wYwge8joxt/UfZe5pCzKSGCyGj6lDmhlW3Bi42SOfuHapBAQUDr9NnTN/56Stl2alUHoP9ZlFwyKktTp10u6NfiVQtBHSWMvXEZbT2nnVryq5i4u+oD6PMZM13aVdzabwtvmu5fUZ/l6hln6inUlfh2bGR3p+tDBtcaXew+rqFQLvjdY8Lq6CyqSTsckgrTR0eVZVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cHWJfEK8IBKczUOvQrmy0By4XYGXoFqcXhSN8RBdX4=;
 b=itfiJsp+9WLRnBfI0QzSOixdtu/dyKpnBmrVCoB8SGtjrNDIDTJPPyBiziTU5ujY2VFq4ECwkKwTUqcdK78ZUNjPrxD9XPQRvNdgsmdERUxdp5yfvURz92rP0K0SX5BwvT8s+OgGJd1Blzr9lnkvkSmsi0NGljONDg2aHgwHEmM0Of+RpxF4DIWHyYnxeFmjpr/uqU8RP2x89C+eRnb+xJUdZ+YOK/MGeGTw6YbtlykMIrS+kjm0ue45ikO8xVZOtUnQ0fRsV85YbCgs9gIi5b8w+kb7GRhK4LLXdgTFnsglIuSdQlTvCCbEUEGEw/1qeEemUuz9pindL3t2oGmuwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cHWJfEK8IBKczUOvQrmy0By4XYGXoFqcXhSN8RBdX4=;
 b=k8Nf7HQjyTISiAOF/bwS86qzUpHHD7ttvPNpCJ6J7jofqNzs4m+j2z+Qa3p4gImee8LHIAxzc3EKvkKh7U9wkDJA9tVPRYooBreRkKnzJguC+v2PnWOSKVGi+crqmmtHyP1IpX9oC1tRhptHLnaHZ2osWxFTzlcaQ6MFVuCtmE0zY2Dsg4lWAttfd5uHDiwOZvNzz8M/b8GlUUJt8uoxLsIaqnv7BUIXq4mCJIu/ZJkY53tbGEZiPQ1yR1iYlksbo6TbrpBFG+RD6K/fkVNzztO7WTM/LwUgAPF7VmCkLXRZl76vstdFs5Se2wG3CZsofvoqc4nhOnpV4DRh8SP/oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MWHPR12MB1549.namprd12.prod.outlook.com (2603:10b6:301:10::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Sat, 14 May
 2022 00:09:14 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0%7]) with mapi id 15.20.5250.017; Sat, 14 May 2022
 00:09:14 +0000
Message-ID: <4809b134-a37a-50b8-4c25-44548bc1048f@nvidia.com>
Date:   Fri, 13 May 2022 17:09:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [syzbot] WARNING in follow_hugetlb_page
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Hildenbrand <david@redhat.com>
References: <000000000000ef451a05dee0f2b1@google.com>
 <00000000000077377c05dee75f63@google.com>
 <20220513102617.c464c4f566052838e911a3ec@linux-foundation.org>
 <75f09063-d184-7d44-17a1-ed04be5eb953@oracle.com>
 <a7fd0c3f-921e-19b3-2f67-a231dede28f9@oracle.com>
 <20220513161910.d1b73583cdb2e33562aa86e5@linux-foundation.org>
 <Yn7vnpXwX50J3K+7@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Yn7vnpXwX50J3K+7@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:a03:60::29) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13fd6ab8-d7b7-4ac1-e72b-08da353dfaa6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1549:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1549185700EAB793CE2C15FEA8CD9@MWHPR12MB1549.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L2b0cUVv3vLH8E+ZqaNLp0nChgQJvOdfid6wSQNQmTiFR0G/0hG4uZAN/146bc9avK0dSrefwB/S29kNLpJRYOjU/8Ry+bf7eM1whQnXCOFx61yTUeaWfH9NI8sI0wQ4zLEWUGHitPb61AIGDcAEH+eavPCU+NTGWYl2+TChYmNakOYiatk8Kou+gSpBCPM85Vkc/w5gm4ntfJM0Gm81RS36hPOmYzJfJoBMNZelpkJpQtF7l5v6H1MQVb9aRHeBDNKfpNqi/Ig96i2HCfl5HchKDntfKFhtSgm8wt4e/DanfTN3fQMHfK5ZyT+WaGt/Ib+qPhhVRntXgmgOGlyqj3b1j4ZpQ0RmgqkhHcoGbfi8SKV9gfqv3Q/n62xjEYbpQ72Wm6MnR6wmHpuyryPyJ1Rvsrtx1ua8XgbRksnoQ1V4rPsKBxY1BB3TvQ8z+2puZfzAVjdjbhLv9k878nZIE+UZ7EtiSluacITMoBTIgru8/WcBBgKwbMuvzEX7NUQHue+ttkMQUVKXMspkGOr+zt/EYU15uB76c1oq35IdUwqBIQg2TSvm4EPLujBT0Gf232Glj1R7vqh/8+XKp04/+ZYZDvqk7Po6bnG/wfo3Rb6WM6pA37gZ7ucNHQpYkejOjc4HPhX757Y2Xg98mz6fXDo13hwuFKHYv1MX4sp3Om/6biHmd2bmkIgG06kbd3QI3MC2K51gdn4YQ1H6WmmqgNBWFi2HVpHf/aF6gEONSBw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(2616005)(6512007)(26005)(186003)(66556008)(8676002)(66476007)(4326008)(66946007)(4744005)(316002)(36756003)(7416002)(2906002)(5660300002)(110136005)(54906003)(6486002)(508600001)(38100700002)(6506007)(31696002)(6666004)(86362001)(31686004)(53546011)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0w1U3BMQ2E4N0dsaHl0RjBYWmJGL1k4MVhrRHh0UGhtRlA2Y2VnMlZSODJ6?=
 =?utf-8?B?S2x0NmEyYmhjcDhsdnIxWDJyQmpHbjYvTVZkTFpZVXpSdS9LcFJZbHVocUJi?=
 =?utf-8?B?aFkwKy9Yd2V1azlwbXlaRFpEZE5tWC9MVHhLUW1tZDgyM29wVEcxTlNUeTFp?=
 =?utf-8?B?bk5ISU5oZ1d5T2NpTlRVdHFGTEhkRnFjUWxLOEhab0U0TDFrT2tFSkE3M0g5?=
 =?utf-8?B?K3hZMS8zUDZjeE05TzN1b3prZTczaEJNSXk3SEJVN0dLR05jb2ZlU3BmM3JH?=
 =?utf-8?B?THIxWGZVclpCUlhOdW9VdXA1Z05pTFJ3MVhGVGR5M2Q1b3JqYmEyRk5OTVph?=
 =?utf-8?B?OUVkTzd6WmJhWFpCV1NnT0FHTWkwSXVZTEJvaG5ENjRzOFRZT1ZpZk5kdGFB?=
 =?utf-8?B?a21rWDJLSXdkanArdG1xazEyV0VXV2Uvb3Y4dkNqMS9oMVhwWjRMcnZMYjNO?=
 =?utf-8?B?OE93OSsrMmhFeExJZHVwTDNUZVhjR1dRd2gzMGdtQnZOZ2FwVkxrc0phd1VM?=
 =?utf-8?B?dlFsR3BkcE52UDJ5TGR0K3A2Uyt5eXZkN2R1Z0pROEVkNjhnVTdiaXFTbmR0?=
 =?utf-8?B?S1lqdTFicFJkbGYrN2lSNzJTWkZaNEQwWERVbi9RN0JETCs0RHRIbXd6ZnJq?=
 =?utf-8?B?cEw4bnltcDJnYklmYXBGdnpVSW1CaXZ6U2pya0x6Z1FzdDdjS2puWjM2a2lT?=
 =?utf-8?B?dm5UV25QeXo1V3ozaXg0YW85T0dMSEI4R2ZFaUtGM1dkL3JhOTJzM0ZZaGYv?=
 =?utf-8?B?WE4zTWJ6RWdGRDlJclFKaE04bUJqR2ZiNDZ2bENHcUR6RUxmVmxOMzNUdlh3?=
 =?utf-8?B?cUwwQTZiZkFJdkV3V09aZUFPS2JGLzAwN0hObjZPMnVOTzZiR1VPK1RSUFFu?=
 =?utf-8?B?Yy91SEpnT3pQeUx4SHA4N0ZxQ0YwVlMxNWY2SG8xZ3o5L0ZpcGd2L2JnQ2ww?=
 =?utf-8?B?ZnhBc2tvZkRSYzRmcjlSeFdoYXhhRnhyUURUTlV2WEN5Qit5YjI4c2Flb2FC?=
 =?utf-8?B?ZUh1MXJSV1hYL3BNdUo1NklQZ0hMeUlPeGg2NkZnME5WTVBzdFhMRjBGN0xQ?=
 =?utf-8?B?ZGFJZTBRWjNaUUdWdU40WXM0TDlqSkRld0gzelZ3VkJQZFE1R1RiTEJNWlpO?=
 =?utf-8?B?aXgyVUhudHN0bWxXeXdTVk5wd2lEejg3cG1NSi8yUmRWQTJNeDl5R2k0U3Ew?=
 =?utf-8?B?am9pN2ZFcVRyWmtwenBYeUI1N3dMS2xxdUloeUVlSzdPWW14ZU0wNlpzV3Fy?=
 =?utf-8?B?Nmp2dHh3U3RTS2FkR2RMT1l0SUw5WWtydk5jYWZWdXhMd25hcUo1UVppQlRt?=
 =?utf-8?B?MmtlQzFxYWdVTlFVZXBRRTM0SUh1N29LWjJ4dGQ0Q1E2eG9TeVU1NHY3ZTV4?=
 =?utf-8?B?SWc4azRXQlBWSFJJWkVhTHc3ZkVjUzgxVUtRQ2NiSFFxWG9RU213K1VsN3BN?=
 =?utf-8?B?Q2xNSThoeHRzTWZFNGg2aXVjT0w5NXovMlpzNk5hbitBU3plcFFBWXFlWWJM?=
 =?utf-8?B?UnVFc1VGV0IyNVZSTWovemc5NXZOMjZJTGg2NG9ZZVpsV3ZZNkZjUGN3WVFo?=
 =?utf-8?B?dUxaVDVBSEFRNTFleENSM1hJVy94RnhiNUhza1J5cFhuTkVlZC84NGVmY2s2?=
 =?utf-8?B?ZW1hSjBKN3l3TUpseE5pSGhvc0pMK0NFUjRybzl3TXdCMVlJaU42MkFYMXVi?=
 =?utf-8?B?K211cllURUVGU0crZHI1cHdaaGlsYllrSlpEc0Q1YXFvZkRyVG8rYy9XQ2Ey?=
 =?utf-8?B?TEdHOXFGYlhxS2gwVmFLSWdHRnlkRE9KUFB5U3lCc09vMk1SK0tRSWxmaVdj?=
 =?utf-8?B?R0hkZ05pVUJRYjlJT0lIQjhneXlJNDVmR0tENGdVblYrWUVLNkFhd1p0T3JS?=
 =?utf-8?B?bzZEVHFUdXlxQjZyeTJ2K0NIbVEvSHRLa1c0OXpNVmxoemdrRDdqdUE3U01j?=
 =?utf-8?B?QnJiTGFEUHlpTWVpVDhzVVNNUC95a2ZNR2k3Vkc0b09mLzVOaHNUUW05Z09m?=
 =?utf-8?B?U25Fc2w5azY2eFVRQjlmQUJ2ZzhJWDFFMmRKYWRrVExRZ3NyV3hKTHVkcGVT?=
 =?utf-8?B?ZUtXZ3JtQWtJZmJXUStiQllyaTh5OEo0bDNtaWRYTjVPVDFWWFBDeERXZHlu?=
 =?utf-8?B?ZnpqV3hBL0owekhDeTh0U0xNako2OTU4YWxQUUQ3UVZVSUQ2b3VtdVhnbjc2?=
 =?utf-8?B?OWhnczU4TitnMWJvbS8vN00relNYRjJJRXJsVkgyWHVtSG05UEY2Sk5ZYXA2?=
 =?utf-8?B?aTBjSXhtQUgxeVBRbXlCcU5hYmtPallmRVlYRkVkdmZaWWFUTmN4N092a3o4?=
 =?utf-8?B?NVdvU05zNjUvVVBQWWFQaWE0dHFOb3hHY1BlVGdPRHUvWG9RODdqREF6Nmox?=
 =?utf-8?Q?3z0tf6U8/haIsZng=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13fd6ab8-d7b7-4ac1-e72b-08da353dfaa6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2022 00:09:14.2583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35NB1oK1AwiG0fvv5Y2+gc92jA2XMk5OhV3h79jtznM3gNIn486dzHFAqbMVxKcbO6m7w8TAONwgpQ6qqR4g3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1549
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/22 16:54, Minchan Kim wrote:
>>> I isolated this to Minchan Kim's "mm: fix is_pinnable_page against on cma
>>> page".  Yes, the fat finger fix is in next-20220513.
>>>
>>> I don't have time to analyze right now, but can confirm that in the
>>> reproducer is_pinnable_page is returning false after this change when it
>>> previously returned true.
>>
>> OK, thanks, I dropped mm-fix-is_pinnable_page-against-on-cma-page.patch
> 
> Seems like bug of the patch v5 due to change of this
> 
>      if (mt & (MIGRATE_CMA | MIGRATE_ISOLATE))
> 
> The migration type is not bit type so it shold be
> 
> if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
> 

Sorry for leading you astray by recommending the bitwise OR, Minchan.
I overlooked that point even though it was right in front of me.


thanks,
-- 
John Hubbard
NVIDIA

