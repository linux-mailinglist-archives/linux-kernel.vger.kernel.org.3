Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDC259B6EB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 02:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiHVAKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 20:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiHVAKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 20:10:12 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14E91F62C
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 17:10:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BetmXyLwoORUFhEcsfYi3c2mlNOotZ0TuX9tQUPmJJy5rbOQ7eFkF/tHcfdsCqgJBR5+UG710W4+NjaVBk1cwl9o60LIcs+pSAEcyGOAoNERqVIHLk8sMFp9uBauHK95beIXQFsyrj35VsyscNT0ZEsw1IONOxkzGgKz5U1Fh3T5DUVqAYPpkFwQDA6kNUSIUilEOVNlNy8cP+Q+4Rwn2v+bv2Xxp65OysMKzj6JfxvdM7e80YK9bnBbFPp+X+7M1z0hgh2iZhvl3zNo3Ts4KFPXnKvQ64I683sv1XtaBg0P+5+BO/N6+QWMbbLVDk7nK2I4dIPFzSLyUnn3sKr1SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpQijV+uAlouCoMY2jUu5Zqpy+wvqwjrH/6FTutU39o=;
 b=F4QaMN2R8qjfGckeKcLnyKTVHxl1jao9qicBpMhyaq9u3y9hpOXGQRb+5hWkwv1XMccyjxevRk6MCk9zxyKCCUIjm7HBW7gwP7sIdcDECU83kI4yt20O1tt05lkxCDJmgeW1WHO7tfZ3d+WocqIDfS6brOg7zaN61z2Yz9NMNIpA3jp7YKYs4nAh7kiM8soaDjndNW0N37KuHXOIDklBHgKgtwpprMdW375TnSptNBE1lE9DwoCd1SFH5TVxBFb5WRAqdMrU1xY8bEEQAb1WTzNXaByJAAdsDM/bSiSprejkdw0ktdF0QQQtjqn1Sva6KBY4vdhOscWvY8z2sRYG7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpQijV+uAlouCoMY2jUu5Zqpy+wvqwjrH/6FTutU39o=;
 b=TITw+yagCgOwZGyMuFUt+3eDq04lPr/9jQA1/qsxabfsI2ryp/a2VRmJW7qsCCZysZJ9nzNSgJq5jVBLCpPCO/Bgr0cgF+0oeEqAjRT7PbKMBIJvlhphv3Gc28vcfcEBovH/Vxme9fzoGemBLMlGBBrjB8z2vWvJ1aIVRT6maxPrtm8Up45T6AMdop/QxT9B9NFC9wlaSOCIHYjiUK3jl8W1DQ8y1lltBsRBdIyQ+B3KSgStdsWXGqMUVMLQ+XIngzHinxn5kiv/I4LNhZ9WE5KUcS8coVFr6JpVEQjFdPM10JwQNWhb89G62FdyVe0yGRyE/dwXVuhqLS4usHjlag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 00:10:09 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%8]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 00:10:09 +0000
Message-ID: <761793f4-cd16-fcc1-8777-f7e032604e1e@nvidia.com>
Date:   Sun, 21 Aug 2022 17:10:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [syzbot] general protection fault in vma_is_shmem
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+681bbbb80445ead3c040@syzkaller.appspotmail.com>,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <0000000000002c73fd05e6ba3e0b@google.com>
 <20220821013246.a706fa7c2d8cb494efdba02e@linux-foundation.org>
 <0004c00e-e50f-5dcf-20f9-1b8da0822bfd@nvidia.com>
 <20220821163120.df7d936c9f47b6dc875ab763@linux-foundation.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220821163120.df7d936c9f47b6dc875ab763@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::11) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3e6f654-f7f2-450c-8119-08da83d2acb5
X-MS-TrafficTypeDiagnostic: SA1PR12MB7125:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIbK/zr8y0sdbrA1XRBY15eCWnNQoXxS0hbM72aAOYzz4iCK1IZ+pWg0sgN2mU35KOoXSnS2yUw/14twxzTVFDYNLE8QSX171CjBo7pB661R2l8bY7ROuEmY0eBfbdGFAOtLKzBD1dmOwY6SrqiohMlUgLVVlGDFUuXH2nE/ndmrfnL/fyD9NEZw8xbDivoIUokoHfnUYktijPzp8ZT/+Dyi/cItppFw7Dz4H4Vk6CqUn4sHlngzDv8PGpm4B0dTES7qkxDXVaiA8Ti8eLm0IwFj5RB8LouYqmbMM3E/35se2pBO1DacuRb9oQFc39rqBYyG7r46OYbFjFprm46lW94FPjN5HhvxZBFTgVkRVJF2GLm3tY4dKQitrnE9DdVLImBK9DZbWmg+suyjt/WhiRTp54IA+HsdlBJG7rhSVKshBSRdO1RmHb+ZrGFX1BSff6ESMZWSUI0o6g84cPxdlXPV23fzTnIX1UvUhB/9z9oHS+D7NzqL3zie8XzzhZrqwnk0NiiqRnWwfIG6a0Jns/127IPbXNVp4XVlLk7/p+oIq3CUVu/w8+WVLAu1MkzqKqIlIIObh3eUgzkOM9JDDvXNjP8xmGkjeFGPLdhRzdnkg/XY+MJOBwiX4uYCpV2UMKP5bus9ZQIsTGa/VD33viFAGH5zAbFx6mBJQ0idXha4vF/dasA1wxow0IA1GR6n9hUm0p0KJJj15xZoxrQu8Qx6qxmniMGpHxkqMmm0yAXc976yRq2XDVsTjxt0HMCjO1/c9kZanEHrDAjkesYGrYQ9nuVJ4qGYwQ6cIiWyY3kJEXledm+m28JlM/yyggbdrMbv/RG8gHW5YtfUEIUIMcuSpvwn/2ZWeCrRN1ZcgnEK38czjWkWWxoVcA8pk7p1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(54906003)(66556008)(6916009)(66946007)(8676002)(66476007)(4326008)(86362001)(31696002)(6512007)(316002)(26005)(6666004)(6506007)(53546011)(2616005)(107886003)(186003)(478600001)(83380400001)(966005)(6486002)(5660300002)(41300700001)(8936002)(31686004)(38100700002)(4744005)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGVrR2JHeXRtMHQ5WW81VVhXczh1bTRGSDQ2VkZYWW5mQnljYTFOamxCa1pT?=
 =?utf-8?B?WGdzOS9Bc3pCTCtST3FKTTFaUWh5Nk04RjVVN21TQmI4bDFKUFpjQ0tWUEsz?=
 =?utf-8?B?NThBSHN6VXJnZTduK0dxZnc3UkxrVnlRN1pOcm80TDFTeG5mT3I3bU9WenhF?=
 =?utf-8?B?OTFZZTh4eUYrbG5MRWtaUiswU3NldWZoaGRjcUpPMkhLQ2NqTCs2NkxUMG5r?=
 =?utf-8?B?TkluNHlzVHdOd0doNlNESStwNU1SZXpCVTBLamZ6TGpRK2t4UnFSK1hSczhB?=
 =?utf-8?B?MVRwbU16MTh2a2xKY3ovanY0c0FrNDlpY3lFYUFZMmMyV1FLeWZIaENHUXhQ?=
 =?utf-8?B?OTFPczgyNHcxZ2JzaERvQmp0cTNkVlJHL05tejRMcXdDYTNBYXVWVDJQZW1Z?=
 =?utf-8?B?WXpGbTRvWmNyNFgvNWVvcFo1M1NTRW5GVDg2VXpJS05Sb2k3cS8rS1ZQc3l5?=
 =?utf-8?B?bzdNK2czS3dZUlAzMVZZVFFmZUpxWldmZXZTSkh0YjhmRlJIaHFGU0o3cldL?=
 =?utf-8?B?dndZU0RZWTRnUDVqcUxYdHVQSHltYmQ3eEp3Skg3U3VLbGtTd25JTVE3UDBD?=
 =?utf-8?B?WnVUR090TFlFSDEzQnJmRFBrdWlOM3ZkS28xcWd0eFJyMzV0OWFOVjd1SXls?=
 =?utf-8?B?bm5UYXV4ZGVjUkdBeTQxREE1d2FLZ2xKM0NwcEM5NUNaaXpoNHVoOXpma3Mz?=
 =?utf-8?B?N09wbnQ5cEVFUnlnTXZETGlhckZjSmNWMXJLREh1T1FjK2p3MDZXU1JMNCtj?=
 =?utf-8?B?ckY5c09WWXZFL1d1WS9RTGhYbWpKeTlzZndrQ3NlYkpYbU1hMmJUTjFhR2Q0?=
 =?utf-8?B?RXlMRWdub2F1MkEyZk1wNTJiNllwMFczVEwxdGs0MjFCdW1sUFc3U2syL2J2?=
 =?utf-8?B?aEo3Z0lNbDVOM3BiazE5anBRa3ZRcmFwMm1sTnl6ZDQyMnp3RWxaL1ZQeEls?=
 =?utf-8?B?eVBSSk9JZFJSLzduVTNOcnJHUUh3WFBQMVZsWDNzemdjOU5YZkpKVWllY2cz?=
 =?utf-8?B?bUpVUElYQ05FUmFxaHZGNEEzaEcva0VoYlVLZk1WSUhxbXNRQmVTZ0NRbzZr?=
 =?utf-8?B?TkdrL0QzVUNwS1ZZYk5PUWxTdmE5dmtiU2JjY0JMNFJNSm16MmFoaW4ydnZK?=
 =?utf-8?B?dk9IVHFPWk5lckNRbE1WWnVjSVFxVG9kMGlDRUxtQkVrd01KMUliR2ZXaU1v?=
 =?utf-8?B?ZmM3TUdnNWFqUFRhQUlnOUdpdTd2eDZUUEtkbHBHY04xWDN1bVpycGo5dEtx?=
 =?utf-8?B?OHl4clZpOFY1REZVWkZOakxvNnJSNzFTSXBla3dpY09xTUlWMWFrMXdXVnFD?=
 =?utf-8?B?bDdUeEMyd3ZLR2doWFRyNkNZMW5DWnE5NWs0eVZKeVFiUHhZVjJRNWRKUktQ?=
 =?utf-8?B?dmtqSnVrVFNzTXh4djJEUVBPWng0d0FNUm1tbmFOY1VGaVlKc1NyRkpQRm5P?=
 =?utf-8?B?YmgyKy9vT2JuRGVwK1ovai9sUkRDMVV4THRTQ05xSENTa1VnYll0Yy9QZEFm?=
 =?utf-8?B?Q3M3OW15SWIxeU9kVlFNdHd1Vm14UFlmZFRWS0dRWFliNXNzUml0WUVoRHY5?=
 =?utf-8?B?NDB2UHRyMXpMWjVsUllhWTVGcGpJWTRIS3NzTnRhV1lqRUUyT0lIVVpYK04y?=
 =?utf-8?B?WkN2MFFtRXU4L25Jb3RYK2JQeS9MaDdSdzZabU5uR3piYjlEMFRpekdYckZ5?=
 =?utf-8?B?L0FIRVVkV1V0QlV3T21ycXNUU1lsR3FQeUdzS0Nud1R4NFRZOVFhMVQ3NFJP?=
 =?utf-8?B?Rk1haFp4bTcyTFRZNjM0VXRTUGpTK1pzaVZuUlprdGswQ0tYQ3FTcEhDS3Yr?=
 =?utf-8?B?bDZvNVFzRzBmZ0pSdHowZnk4NzZJTlFnL2lUeGlXUVRXV0dMTkluaE1PUllT?=
 =?utf-8?B?ckk1cFc5bTgzOHYwZmoyK2QwZHZtUlk0ZlljZlFXSTFuZGE3VjRMYlRpUEdT?=
 =?utf-8?B?aFhzV2xtN0VxcEJNc09SbmYwNjRFbVA2TFYxSXlQU1QrZ0ZRNlBiWndNd2J6?=
 =?utf-8?B?dk9VVlBEZHlIei9TMG55TkpvLy9XUmYzQmdYcU85SHlmdjluZkRVWjhNVFN0?=
 =?utf-8?B?ZWhjUUxOM01WbXF1TS9zN1JyeGxxR2owajEwMjNUanFUNm5zVkpCZThYWGZG?=
 =?utf-8?Q?HPJ1Igb5o5EVQ9QwLfOq4DcRJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e6f654-f7f2-450c-8119-08da83d2acb5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 00:10:09.1075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2E9lfCQiBtDcFzhNhn7lh4KYKwwl2ikntyWcJmuXJjAIT5lDJzigNlLHcY32xOLPhw3TnoCGmOWEg9iG4hhUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/22 16:31, Andrew Morton wrote:
> On Sun, 21 Aug 2022 16:18:48 -0700 John Hubbard <jhubbard@nvidia.com> wrote:
> 
>>> vmas[] array.  We haven't messed with gup.c much this time around -
>>> just one patch from Alistair ("mm/gup.c: simplify and fix
>>> check_and_migrate_movable_pages() return codes").  It does touch this
>>> area, but I can't immediately see how it could newly cause this.
>>>
>>
>> Neither can I, even after looking at both of these recent commits to
>> gup.c in this branch:
>>
>> commit 4d1225cd5560 ("mm/gup.c: simplify and fix
>> check_and_migrate_movable_pages() return codes")
>>
>> commit 0e5d6dac6b65 ("mm/gup: fix FOLL_FORCE COW security issue and
>> remove FOLL_COW")
>>
>> As you say, a bisection would really help here.
> 
> Might
> https://lkml.kernel.org/r/20220821183547.950370-1-syoshida@redhat.com
> save us?
> 
> 

aha yes, that looks right.


thanks,
-- 
John Hubbard
NVIDIA
