Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CE24696C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244333AbhLFNWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:22:52 -0500
Received: from mail-eopbgr80115.outbound.protection.outlook.com ([40.107.8.115]:26094
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244327AbhLFNWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:22:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFOT9TlwRzjRemfFxTjrGvE1lKjfV2VFPseHEEEd3xL6jpmhaQAFafPpP3pn31I6/ohQMba86Fn4xYlsyItjZYhhBWiTij7rHlVQTJv6H3XDbuO5frWBSBGJXa+bvVYSdp/6AY67X7/K4msklDNab8bndPsubkqISzXdgb+qcffEB175lBtun2ISY1/JOmrJnOVODUlqUp4LN+vmIidY5HMyBSiZdU15UhzUvHw1+53ufi9zOB+owaW8Kx03HpQUCh6aWcz6hX0BtaMqA4PkdypfZ8UIJ9pXHxyYr/CgvnjEGCmGpCnqNYyrWaxVJ7cyG0z4zujXgkV3cKlwGKQHEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Etx638MOyty1XQrMAi3UiiLxbYwwqofsIceNLVEv1LI=;
 b=HuclG8bkUIwEizX9NxHOg/hdtJIqcFJqKUfR4TnDP1AZT2RUjRKtzTbUpUGdEpDlIGkUBpu1RVOzek443HBQT3a8DoLbIrZCXyGMRd51j6RftLessvD5fx27l/yQLq2YfV2UEZZyRTKsd+ERWr7Pf9+4NmqRReWbYjukDsFyvjOkjqIysBNnvTcI7CuHqCo7mQI/DSf1scUaEbYZXaSu1FJl7fEw1XFqg8zej8G1hMXakRM1ua9rNzSqwLd2QqfiWR/kEtuLZIF2VUTS3kF70FlN5NaFqnZlW6lawVBRqu4qN0KKzT6iyJu2I3MIURPLI7sfPOID6J2VSTzxH1g52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Etx638MOyty1XQrMAi3UiiLxbYwwqofsIceNLVEv1LI=;
 b=c5wnB8ozjkyT3MPC2yANnJa1raQBBpWeiITgB3qjen2DOtRgxcPXGPp8+G+CVXNbrOtnwM4Le+qcVmulQDaE/r4vYgBC8mj4f7zbfxwaQGciORIDhoQrwf04ijLVUJwX73DRI7EpENjt+xACHxomlrJfw+sEgi1xy7iMkXPWEqI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DB6PR0802MB2374.eurprd08.prod.outlook.com (2603:10a6:4:8a::21)
 by DB9PR08MB6700.eurprd08.prod.outlook.com (2603:10a6:10:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Mon, 6 Dec
 2021 13:19:15 +0000
Received: from DB6PR0802MB2374.eurprd08.prod.outlook.com
 ([fe80::14cb:77c8:e84:114e]) by DB6PR0802MB2374.eurprd08.prod.outlook.com
 ([fe80::14cb:77c8:e84:114e%6]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 13:19:15 +0000
Message-ID: <24b4455c-aff9-ca9f-e29f-350833e7a0d1@virtuozzo.com>
Date:   Mon, 6 Dec 2021 16:19:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Nico Pache <npache@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        shy828301@gmail.com, guro@fb.com, vbabka@suse.cz,
        vdavydov.dev@gmail.com, raquini@redhat.com
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-3-npache@redhat.com> <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
 <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
In-Reply-To: <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To DB6PR0802MB2374.eurprd08.prod.outlook.com
 (2603:10a6:4:8a::21)
MIME-Version: 1.0
Received: from [192.168.1.86] (176.14.222.90) by FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::12) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 6 Dec 2021 13:19:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19c89aa1-ca1b-4803-6bac-08d9b8bb003b
X-MS-TrafficTypeDiagnostic: DB9PR08MB6700:EE_
X-Microsoft-Antispam-PRVS: <DB9PR08MB6700A7697BF7E6B807EA45E9CD6D9@DB9PR08MB6700.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RTk4zp4XtmAzmk/ixMlbfAs4YeqtP2h2jQs/3ccvuWyHFcXOuM+MHdnhctZcGii5NqwupHk73eBu6t3MhLJQ1eyeTevr8FOpY3SYVK+qlQY7SAjoC5IXvmQD/oukdefiCmrIJo35ar1lS/bMR52K8piduxKewmSLr5YQjXQ3UEiTOsnltnhQXRTUFwdHrZ6Q5nvnxFUScdswA48wxqJ71AX4Gu9fTKZRHbLAwyfcZRHFk/KYWY9HcNWaP4GLyrEaAz0WvzwKhGff/dyTlO3oIWo4rx2+qKM4rmZ3p5ZmFHyHyfxCQ3KsKww9HwiGFg+3pPf72gHNPc3gXvTXDAsT+jUHHcfdyKhnQNGfsaGHe5UK46/s+lcy233lsOdoCjeXsiQt51cx5838APV4k8B3FKRs13ORqLrXSarPyEgFt0rpwNBUzoH4OL73fIK52iT++AmMijZKs28IBakwwfzmF1UfelOYKSBGpgassW31Y3PqTCUCUpz+9jt7qnU7s8EM5UJ148WsohT42HM8RgYx/BdkrgLEFt1il2Dk/sj/Rw8Q4N54ot/ooArdLvFrJaYkN5v/ZwXhXLJ7gzpp31ss3UI3CU29jr7oJWU6exdCaTLps588cgHtzUGGyfAIqVTwFKttpUhgGfBzW8Fi9GvvdCnsjFJOZxSCccOHzuex0F57XHgLna1YIKwmQT3c8Dhm9gqi3huAscAbHn2zsyk58tXNhrGB6RBb0TL0JrP/8Or+1cID4KR6NLFkmn3C3iEv9iYbks/pCk+WX0E8fynWvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0802MB2374.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(38350700002)(956004)(7416002)(8676002)(26005)(66556008)(66476007)(186003)(66946007)(4326008)(52116002)(86362001)(4744005)(38100700002)(8936002)(508600001)(31696002)(5660300002)(2906002)(110136005)(316002)(16576012)(36756003)(6486002)(83380400001)(31686004)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXc3NGdXTlFYenV5L2huZnArUUJpdUtGODYzRXlWT2taejRZMERWSXM3YlBy?=
 =?utf-8?B?V0grS056aFY2bENJTWNsWGpJdUlsRzBhUlN6RGVORGtqY1FEUTQyOG5CcVZH?=
 =?utf-8?B?WHFzY1hnRHk4Rzc5SW5NOXBzWUU3bGh1Tmx0YktldCtPUVRFOVpja0JsUnNT?=
 =?utf-8?B?aU8ySG9ER3YvWVFSYVVTTHRYeW05cXQ3WHpBWnEyT3o1MkNGczFZaUZ5WTNy?=
 =?utf-8?B?aXlIYXFxMDZjL3lndVZCSmF4UVRVTHUzYUFSc0UzT0lzTDQxeDJvcG9DQmlu?=
 =?utf-8?B?TTZyZzZKbURONjh5c1p6bHMvZUQ4MHBnaGZub2pjV1pmaHhyWWlKZWF2UjZu?=
 =?utf-8?B?VHcyRDFXV0E1ZHNZd2VWTmRIN2NFQ3k5UmdRZGgvc3VaY2Q3OWdCZlRFbFJG?=
 =?utf-8?B?dXY3azNJd0dzVGN5d1AxZ1dvUjVTQkVtOTlidDA4TnJ0ejZqYkNGSHd4N2xz?=
 =?utf-8?B?Ym00VnFVNjZ2bldSYmxCN1FMdlBySi9heXlRcWNDb0t2OHFrZjRJdFl4OUtj?=
 =?utf-8?B?Mi9ESDF5bTZEWEpDc2hPOXNEcTFjMklIc29HWXdHdDVwcUUyS0VMRGszbVk1?=
 =?utf-8?B?azhDbUJraVhMeXpQaEJIOWQ0dEpOYXFsNHlralFoZnNWd1lTYVVzNG9PREFS?=
 =?utf-8?B?VWRkd0pObHNDaGYvOXlXRUJaTnI5aVVudkJSOFc3QVFueGxNcGFjS2dydUVY?=
 =?utf-8?B?ZjlUcmhOM0c5Smhmc3grLzFIYnF6ODBnaFNtODBHKzluVDBjdTBWT2Q0TjF2?=
 =?utf-8?B?bXNyU1RGQk1yTkt0bGtkdDQ5YUkxVHRab1RXUjIwdTMybHovNUhDbi9EMXda?=
 =?utf-8?B?WWh3VW81R3EzZ2FRcUpUbDlTVnBJdFgwd2U0Y2UvbGtPZ2RhQlI4TzZjR2hW?=
 =?utf-8?B?VTdHMXRpVTNSNzV5U29Jeis5bWxsYnQ4NVA0bDNJaThQS2p2RlIxdGpXcVhn?=
 =?utf-8?B?c2Jma2dQMTdMUTRuMHdzMy8vOTJ5RFlvK09hdlJGMG9PRnhXak50UkhOalBB?=
 =?utf-8?B?eWVuYm9HRGx3d042NHVBRzZ4N1IyUmduSllZYys4a3lLY2xEWVhPT09kNlR0?=
 =?utf-8?B?ZThNWkdTN2VUbHAzbGRwTGlnV0JHckNPZ0wraU95VWluYnRUTk1BbnFKMm5T?=
 =?utf-8?B?RXVmVUIyWGlIeXhpZ2tYWi9NdStJRURnZnRkWjJqbm9QWW9ydGZaZGNTUlly?=
 =?utf-8?B?bjlHd1lvYmtGZHloWktDajF2OFk0N0RGcHRKRVBzdG45V1RuNXJGVUhBVXZr?=
 =?utf-8?B?cjdPQW40a2lyLzBBV2NJTkZ1d3czSjErZExsUW9IMVVnamQ3a0pzVkNVbUpI?=
 =?utf-8?B?V2MxZVVjRE1QVnFSNUVURGY2M0FmVmdtSHQzbnczZCtFTU1mWm9PVFRBc0xB?=
 =?utf-8?B?NUVZUC9MSjJsVjE2ZjlqS2l2VGhDcWVpbngvWGJyejA1Unc4TkxjcWVRL3dG?=
 =?utf-8?B?QXhxVEtpdHoxS1REWEJhUHMyWmJhQ2pRRWlmYkkwb2JzcnduZkhJVXVkQjBh?=
 =?utf-8?B?SlUyNmpnNjN5TWl3TXQwRCtKMUJXTzJKU21oMk1tMnlXbGFaRWNxQk1EeDBr?=
 =?utf-8?B?TTFkZDVaaVhlTGlUcVVmMDJOQUdnR1VzZU16Qyt3OHB0SUNmVFJIL2o1cU5w?=
 =?utf-8?B?MUduNWZCeE1YbTVLU3JxVllMM2VmNnFyUy9JaE9YUDh2aVcwVjE4MUphSnhB?=
 =?utf-8?B?ZHRKSjZnZGkxY3ltQ1A3SVBZNk05UXFHUkZhS2lSRGNiSXV6OXNGaHArQVhO?=
 =?utf-8?B?dnBRRWVuNXRsQmM2U0lBSnFSSmhHWWdReXdRQ3RhK1o5WTVFTFMySG9PZkVU?=
 =?utf-8?B?RUc2K1pSWUU5OCtPYlFqTjk1amdjYVRFRjRUS3lYYkV2NzRuQ3Mxb0ladXlo?=
 =?utf-8?B?dEh5cldPaytrM2ZBcTVVZU9oSWNDTVBjWk9weDZEdHc3UW9FUzJNNW9kZHlB?=
 =?utf-8?B?Qms5ZTE3Q2hGa0x6cEtMNCtBekZJbERYbjJhSHBxcU9lc283amM2eFJnSHMr?=
 =?utf-8?B?V0hnSGphQ2M1Ymcva3ZQVHZ1RlFnRzYwSWNLUklnZjJkbEt4elBabS9CcXBG?=
 =?utf-8?B?TnFxOFlKSGtoanpqOXBVTGp2YXdvOVN5UnFta09jd3c3Y3d0eFdPRmtZMnZU?=
 =?utf-8?B?akhsYnVuR1dReE1TdUpuVkdUVzlCVEFwdHBQaDFuOFZ4YUQxOHl2SnFveUtl?=
 =?utf-8?Q?gjLLp0PiccHmDOmt3wKvE2U=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c89aa1-ca1b-4803-6bac-08d9b8bb003b
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0802MB2374.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 13:19:15.3814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSCx2n6lVGX53eJ2XfKmIFbdWHVFbrfm+/zbiCMN4aDCcWYKMZ7xpHz2OgNUqwcyYxbzXILhBar1jl4mN1+QAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6700
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.12.2021 13:45, David Hildenbrand wrote:
>> This doesn't seen complete. Slab shrinkers are used in the reclaim
>> context. Previously offline nodes could be onlined later and this would
>> lead to NULL ptr because there is no hook to allocate new shrinker
>> infos. This would be also really impractical because this would have to
>> update all existing memcgs...
> 
> Instead of going through the trouble of updating...
> 
> ...  maybe just keep for_each_node() and check if the target node is
> offline. If it's offline, just allocate from the first online node.
> After all, we're not using __GFP_THISNODE, so there are no guarantees
> either way ...

Hm, can't we add shrinker maps allocation to __try_online_node() in addition
to this patch? 
