Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE5D5AA873
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiIBHCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiIBHCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:02:24 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BD6BC813;
        Fri,  2 Sep 2022 00:02:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huXlvKOVHjnDsFw4G+9i9swO3Kuf0VNg2L/JhFMAj5QSs+Ujeoyhs17asRplrgb1u3uuCv7kBwN25T2G8E/fd/6Xn6/ECfv8voigR8DCQWDbqEObcrre7SW6ilVYChowD5PSBXlI4/wgLGLTzksWZbZI8/lTeoupNRyldA/5jLujerCE/P/yd83ooCZAZ270ByyEuczjfgzl+YAJJlq0yClFTXpKn0Cm7lKkb9E0o39sbo6vQUzz3CNbJMBymRWP7KUvbQgF11UIXQF+LJKIi2q1RJMBX9O/a38RjBODciq937uzuSVWrvPyz6gaHznHqKSL5GbQBs1GM7Bcdwn4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fc5fgLCN6K9Ip8lP40Pr+TNvRtNQs9b2cswLvkgQmcU=;
 b=b1dKLbqhBb89hz5l8aexS/fyksAYkn/4FZ8v/aarAZXU1uelb28PSba/rTAgf2k0ZEJs/bm92NkkCu0oummKghUai8frJjCwpWN6CP6cfvYGs8ABw2AsczAfFnmVj/6ERGQUaK/Np+9OPlVcxD70w1NG3Ap0AwR41fydrgsXB0cplsBly/eezBYzZGDafU6wMPn0mklHmkILnazlq25x3+fRa9rqJO8c4Ia3B3TpJExn6EEfH7DCH9Sg41QRe4EhLvQwaqzFr1Iynn7X+GdsijPXhOYYRCq7bfrrBiPShSEVLrYmdWm2FkAEbDH2joOD/hfszU4Hv+MYzwABSZv+Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fc5fgLCN6K9Ip8lP40Pr+TNvRtNQs9b2cswLvkgQmcU=;
 b=VCEB1XvXSgOe/BFbfezcEaOoeCwAL2jQ1WiasainSgIffNm0VMV4Wja9zy8vGw3t8c2EVuOKXIg8lXHkCBoS/K/zEgmU/9E2xQ7OHWF9FXFYSJt2Pf4j332w4fLIb7+vsFZaug6jinXqowqiXmf+16bZ5Glk6BdE0fwyrkRs95iIo5WciDm3SXt4oX16TJucc7o3XeVflSM1j0rVp0MDyiZ0pq4+zTqucvBBwA2uhkgSMZsCB6ugOb8TTynq3qREA+R7xR0QcwsN8FL+QY4fhIYflpN2Qjvl1RIw7KZgL1CnkugzxQg08QUu8fA8w3byecqZOJ146PG3HnugIWy0eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SJ0PR12MB6709.namprd12.prod.outlook.com (2603:10b6:a03:44a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 07:02:21 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5588.014; Fri, 2 Sep 2022
 07:02:21 +0000
Message-ID: <87d96d36-fd13-2268-122b-fea806090942@nvidia.com>
Date:   Fri, 2 Sep 2022 00:02:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: linux-next: manual merge of the mm tree with the block tree
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220901161722.739d2013@canb.auug.org.au>
 <1a6632f1-5e23-5fb3-1af2-6d653e4338d4@nvidia.com>
 <f80623f2-7c19-c121-6eff-f5bb4f1cfc48@kernel.dk>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <f80623f2-7c19-c121-6eff-f5bb4f1cfc48@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0024.prod.exchangelabs.com (2603:10b6:a02:80::37)
 To BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4b91e53-bd1e-47ff-fe76-08da8cb114f9
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6709:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NApKAUCCVUAmVUw0OUBZCqpr20PY1LuJcFOUCJu2qyfOTYH5J90ryLWYz40IEnGkWJUxlhMYpyQVxy3WaAAoFsVC3DZf9BZaP6vY5BzjCKFQP+ml5jk3maStqp2AXNlKRZnHk9T7NPjJbjy0BDB0dJoZsr8qdILQBydp7HBR0YkU23l2hbfq0ExwTC7lZGPuGcHDhS3U/VD3l74QIh8bEXGOi65e3G5jhg3XDr9z3a9PkylnIDAXGVUrfkcPgPl1sJCZROGOIUqCEqTCTKn6dI4HpiYM4RpFccw+piWF4Ezqsmm/gsaPMjY6IRH35gHN6oWqpE/KShyXhoqKAdc8UIAkU2nMYoVXKHKu2BAdVXrwxcyGgbKhvDCHADKhemBW5RSw3ydIM5ri48CshvXHnjwKS4rVZ+6EiPn8/DZnjcvTW1IVeSKnd023PLEDkmfcEO4VEJoZOb209chGFO7R3yRvS4lir3zNfAauELWd/6VI1laajgL0zcK/hhze+edIoVTN36rRD54vXubCcJ9HFwuy/hw0s8L6Ea6djEww6pBRJZ+3cT3njgJqdEKDqKCPbP6aGyMmaT8PIpNpWNpCtFGLevtQ+ynRjpPRBWuLGZdM0aMCKHbGgZHRKJdIUjjMnEF317DF0cZGL2aP767YZFa/rGaAV+97muZ0u0BJeemKEH2OBl7GEC06QFIFRopDufcnL4BnBaHT0SxIzZ0hb5o0rRxZgGZY6gVta5La5E/mHwHYNOxm80ECuRgsbJDjZQESLTFW992bIhaI9bNRO6+epmnd1BvnnfWKUWh4lxE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(66556008)(66946007)(36756003)(5660300002)(8676002)(66476007)(8936002)(4326008)(110136005)(478600001)(316002)(54906003)(41300700001)(2906002)(6486002)(2616005)(6512007)(6506007)(53546011)(83380400001)(26005)(186003)(38100700002)(31696002)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUJZZXdXWlZNZi8xQ2s4UDltdEcySklEd1RxL2w1d2lnUzlLdmJhN2J1SkJm?=
 =?utf-8?B?Qm9LUnBXeStjczVKNE0vUlMydkZHYzB3YkJIbmNUOG83eUM5Z3N5TjNyeHds?=
 =?utf-8?B?dURWZnZQMExkWGwwcmJZMzA5WG5Wa1JNbHhYNDFFNEZ5MCtlTVZTVUJvSUdm?=
 =?utf-8?B?dmxxbHIyWnFoeG9haTQ1M0Z6TTl5V0pPWnhkcmdUVjhnUVROZGd1U2JNb3VF?=
 =?utf-8?B?S2MxMHNKczU5a3JXQTU2S2FaajBoby8zTnYyTi9FMGMwNUZGenQrazNHdjVl?=
 =?utf-8?B?bkkrKzZhR24yVjFWSnNXenBUZjhKUmEwK2RqV3lkSXRNN2VKZTd4NWdTWTlN?=
 =?utf-8?B?QnFtTWxMbkowUCszRUxlTjRWa1hQWEZJbzIyc3VTb1d3QXVJVFFucUdENS9L?=
 =?utf-8?B?TGRWLzJRcGppNFZmdUt5V2dZK1d5SlBTQUhMeHBQZ0FzaDZkSjd5VW9qWG1J?=
 =?utf-8?B?RlVLdE9rYWdjNURMcU9lSlZsN0NSaEt3Yjdra29qZ1J4UTJoSGQrRmhLZURT?=
 =?utf-8?B?QnY1emxRNytsMmxha2ovYUpxUG1HNEhHSXZyYzZobFFibkJBd003QVMxU0l6?=
 =?utf-8?B?UUJwZXJFWW5sdE1ySkdKcHYxQWVzeVdDcW5UdFFZS0hxWWk5eUJyRmJuVDVP?=
 =?utf-8?B?VGRyS2YvdVVXUXlqSGNaYVd4MFYxeUx0OWhBejZEM2ZtMTVKQndjZWtReTZJ?=
 =?utf-8?B?MmUzdTZzSlBCZUxwT2NXVjVicEpWZmswdG5QNXlsdi9FZEVvQ012YnlUTUdF?=
 =?utf-8?B?R1MvbytlZlRTR2E0bTRVV1FHbHBiSFBTVmhrNzUyZkdsZ05hOWNhTS9LSjRl?=
 =?utf-8?B?VWRMNWdkd0FrRStlUlZ6aW9YV01IS1pLZHEweFN5clFlQWlzQ0QvTy9mUkxo?=
 =?utf-8?B?SXZFQTZ6TUtESndxay9FV0pZbUtTYXdGN3RkR2VVRTRJUmh6OGlGL1V0eURk?=
 =?utf-8?B?Rkk1WUt1U1orQk1hMmpod2RpUHBaVnVpT01Nc1ptUFhsbFQzQlpscVAvb0gw?=
 =?utf-8?B?OEdYdU5LQmh6MCsxWDN4SnlMMlQ3T2h0N3hBYkhjdko4WTZmUjZHR3hxSjhz?=
 =?utf-8?B?S29NM3ZYT21zS1htTnRWME5mM0FjdW9KM0t0eHJ2ZVc0TW1JWnRKZWhJYUZL?=
 =?utf-8?B?eWRaZWliK1ZueEJsdHljWC84QmFXS3lnTWdwd3RUQ3RjSFpWeEFRaFZnNW5I?=
 =?utf-8?B?cEYxRXZvSVBuUVR5VkxaTFZoOXdlZTFuM1hqdzFpQmphdXk5bEcwMm1jekIy?=
 =?utf-8?B?V0ZkY0l2TnQxaDdyUG9hdm9CVXkwcGJRcS80ZjhUaGkzYmUxY0ZmalloYjhv?=
 =?utf-8?B?SGdUalA1UVBLWGk2Y05Pc0VhcHY1Z20zb2d6MHFLZlIweThCTW11aXF1OTJU?=
 =?utf-8?B?S2VMREpYVURYL1hXTlJaNUVtSmRFMzRxUjZUM29YRUI2eTBUbFo0NGRQMmsy?=
 =?utf-8?B?N3lsWUJiZCs0ZHJESGhueTNwSmlwdVRKTWFlV0dDa3gwTElxVlRSYzg5RGc5?=
 =?utf-8?B?cUg4MDNxT2pTdVVUOEloR0RPaHI5bk1EQkRMNng1VzcwR2lkUWVLK2dGK1ky?=
 =?utf-8?B?RzRwUW5vTFJFM2tkdlRweFlRV3JKTG8wK0R1OFYyWCtGMEJGZFNvWFRzRzVk?=
 =?utf-8?B?UTZIaGxzZHVYY2F0ek5FS0RtOEd4QW5qYWhIanNYYW5xd2ZOWDg4aDVtd2ZX?=
 =?utf-8?B?SlU1dldRT21OckpKT3lMaHBHejYwdC9ja2NPcG9KYXhqN1k2d1U2dVRySXBs?=
 =?utf-8?B?NWZyeUNNSXFKb2VicmgybDN5MzJBYnQxRzJvYjROdnRMR2MvRUhnMDdvelMz?=
 =?utf-8?B?ZE9ncUlsUEg5UEZIM09rTzZYQ2xqKzhxeXd3a2R3cmhHdGU0UGZtV2psVU01?=
 =?utf-8?B?L01NZW54M0tTaXBrWHdhdDhWdXRkUmtJWG5HNmwxR1FBMkh6ZE1JSVl6bmF4?=
 =?utf-8?B?RWw3cFl2Z2tzZUlOclBFVFNSZnoycXhoSmdpaTVEOVlRSDhveTJKYW15aXkz?=
 =?utf-8?B?VkpLcGhkTDI2YnI2V1ZXRnRCbDJCQjFVWGFSWUtCUzhBa2hpWTNTVmxrRy9M?=
 =?utf-8?B?eFhVWiszenlUTTMyZVY0U0JmdUNMUVBOVjNlT0oxa1AzdE1TV21DR2pOS3NC?=
 =?utf-8?Q?MPck6JmgTG2WMy4zEJCBWB0TO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b91e53-bd1e-47ff-fe76-08da8cb114f9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 07:02:21.6311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2Fmi1eXFTeYCC7alt3zfA/rB9orlp6OqnYtCHlAeVdeOg4kjuQPV34+f9ZkkSNmFj4Vm0/BO4s5C0tOOV4SgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/22 07:10, Jens Axboe wrote:
>> So I see two obvious solutions. Either:
>>
>> a) Only do the first two patches for now, and leave them in Andrew's
>> tree. After the next release, do the remaining 5 patches via the block
>> tree, or
>>
>> b) Move the whole series to the block tree now, or
>>
>> c) something else?
>>
>> Andrew, Jens, any preference here? 
> 
> Would've been cleaner to take through the block tree given what
> it touches, imho. Or at least base on that, so we'd avoid frivolous
> conflicts like this.
> 

OK, so I'm new to block, and my first guess at the right git tree
and branch:

    git://git.kernel.dk/linux-block block-6.0

 doesn't seem to contain this one:

    e88811bc43b9 ("block: use on-stack page vec for <= UIO_FASTIOV")

Can you point me to the right tree please?

Once I know the right block tree to use, I could post the next version
rebased on top of that. And plan to send it up through Jens' block tree,
assuming that it continues to survive the reviews, that is.

Andrew, is that OK with you? The first two patches will still get
reviewed by mm, and they shouldn't conflict with mm, even if they
go up through the block tree.


thanks,

-- 
John Hubbard
NVIDIA
