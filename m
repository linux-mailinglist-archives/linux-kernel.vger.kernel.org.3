Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3810B5876F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 08:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbiHBGHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 02:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbiHBGHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 02:07:45 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027FED100
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 23:07:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KahNW4EtunVbK+WqRlO3+ZzOja1S56mjeeoYP9N7yrVIk7uamJGxPdnx791ehz8jyVEeCdP5PIWUFQfl/kMgTHPY5XBPe1H9GwbQFrktskj7Xkizc5yL/awk8WGPyMBMTCSyhnvxmZuyc8i8+YXCvTxzAb2m4GGT+JcIyX/Hw3OMwD97+aPK3dUTqNck6NoAlbtETXj/m0d8TUCg9rMVHDZm2FbzlW5VB3tJ75/QYYN26HnJxQBwvjVl2qchHe3TeBeGVwuXeubRliyfiQBNAdxYZGew5tLFn0qb3aTPfDBv0afgKcU9IEvgn7HYwftUGA3ohvtX3N3lSSmxsQjUog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMiiLEAjEJisFBYRi8V9GbOCfd1T55CWOGC/f2PAKqQ=;
 b=OVllSOrLSuG6trwIs27llGBf78e+kLC6h+3DwTZHQONtAo4ZDC+Dm6HNCDx9gutSYdPEovMDyUcUcqrBPVrnhAXBwomWL83Nkm2hlHxv+bFeWnlW7mqf+m4jhZB1R+dsZCmnUP3zZHBpl0y6IjZEXrlCmICMARwBvvGeNsJsB0QMxYsa69S5s8ReXaRubkpszfrrFfNsxuMXJ+aenfNPV2lU96HMvuI85pwpVbjUZuCpdYEvctbb1l8qGoFEJKrufXONWwzYjYNqnTRBdo6gS2ywyGS0EnW5kfMBzhfJiFeaOM5/tZ5FQuSdg2Po9nB9XqfvNwj8tqD5CTeUYpy8tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMiiLEAjEJisFBYRi8V9GbOCfd1T55CWOGC/f2PAKqQ=;
 b=VccGMTKuRxiXbkJ/67fqMeyJ5BhMDyWZgKfmyifCbeQ3i3Ed1+TkD+K+/BYyR0Ttb2+l1iaTSXMqh8evh4bAfLH+S6ztmAk/G/bsoP/FpRQW6lYy3P0/iIdYM7rJGssMX6IDDYdPDYDjJajlv3sOMd8mvKpXxPGyOJRjvLQlcmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA1PR12MB6353.namprd12.prod.outlook.com (2603:10b6:208:3e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 06:07:38 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::1c48:55fc:da99:87c9]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::1c48:55fc:da99:87c9%3]) with mapi id 15.20.5482.011; Tue, 2 Aug 2022
 06:07:37 +0000
Message-ID: <d8b6c09d-78f0-eb0d-460d-28e8b5be826f@amd.com>
Date:   Tue, 2 Aug 2022 11:36:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC v2] perf: Rewrite core context handling
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, mark.rutland@arm.com, megha.dey@intel.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        kim.phillips@amd.com, linux-kernel@vger.kernel.org,
        santosh.shukla@amd.com, ravi.bangoria@amd.com
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
 <3492774b-a462-d8e6-34bf-9f5ea10729d4@amd.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <3492774b-a462-d8e6-34bf-9f5ea10729d4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::6) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3c838e8-7aef-4b52-2d28-08da744d4cab
X-MS-TrafficTypeDiagnostic: IA1PR12MB6353:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X0bYSjlfRNw7pD2IwKEobMG2XiB39YGCCfZwQGG4qEQyaEWEWmzJMxxXB1RXrKPyzE+tsu6sLFdLeKl7pN83GuTflnBH67ZcoDzDdDb0DszuCyDgmd+jdohtqBhH7qyWbhDYx/asB9/IZ34VP7/OcxYYwGoxv7MRqA7nWifWmWxgFkF3qQfzKzjh5oC59AQJbOrIvpUQW6KdGSqBP+AYlr0aAb2+uvIgBq6DrDQTWvReq9BlRsN6lNG/KCcsqM+1xLpyDbCJTONCasqb4DAkvlMxYVetFCFfJsfQ4zDEQJDAcyNKKIU0n8iR4zTNKd5Ca8lqasLz5tPIDpFH8HZUbsyV4OWdQmy6SbzTZUVK8UyOHxnFNAYWNY2aneZFSsZp8sP7CeM82a9z/JAriys/+8Grm/uVNWf8+RE2JIN281Z1aVkpxklR6kFsTYpu1/m9C4dyVCEl8tz4JxRapjIIEMNaywozVhyCsvJhvxE8jfxdV7QJrDBhtEJHgZBWr5cTGS/miVzHwYXNkbH9HUKHbUhuRlzmYLw6JPlk7ANFoOCDefve+SGUR6KNGWl/6pLIgoDbdKw94lzM2pr9t+VC/Ee5YiCkN9nvAvOG4GiI0DT6ZkByRx9MqAwKyppno9ufK6O5WoydwcLunabkd4J9ZFWbkoTNWzn2aitOous9RhLiPFDgu6wQOpuGUObxN6w9zF4Jnm7GumJlPW8WpYA7R4iyc34nMgj3VxjfpHHKve/MtakgmjXlSXqOe+MaHUY0Nv0SQAvPE98u9Y5mFXBwdiFqjFetI3Qu8amknhvwnBtx5daKoQsRTBZAkKWbmHlRc+yR1h6LtjaJwRQge+mm5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(31696002)(86362001)(26005)(6512007)(6486002)(5660300002)(66476007)(66556008)(66946007)(44832011)(2616005)(4326008)(7416002)(41300700001)(6666004)(8676002)(38100700002)(8936002)(53546011)(478600001)(6506007)(36756003)(6916009)(2906002)(31686004)(83380400001)(316002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NCs0bGlrNFdqSFNOaWhhWVZRVUpYYmNXUzBrbUdMbkFkNDk4bElvME9TZTNS?=
 =?utf-8?B?dXI0RVV3RWVTVkxvc2VSaW1WM1M3VzJwSWpZbHRyOWIwUUtja2hVRHdPNmlw?=
 =?utf-8?B?TUN3ME1Yb09JbkVGNjkzVFVpcFYraThQUlNUT1FNVkM5NTdpeHEzSlVkMmJ1?=
 =?utf-8?B?L085MkpOU1QzQzBtMEplNFlBMHhrL3NEbG92bGd5SUJnaFY3Wk5oV1p2eEFR?=
 =?utf-8?B?WnJzSjZCZHF2RXo1NkdZbDY0WG4yRHB0YktSbmxad3k0bEhSY0owZmhYVHgx?=
 =?utf-8?B?RFp6T291TEtmYmFZQUFIa3gxYjJFSDBWMCt4SUlxNnN2dHMyWXE2TzJBR1U1?=
 =?utf-8?B?Z2EwZWd1SkJzeTBZOXREZkVKdW1ubXhybGlCNXMxTWsrdW92TDBIcWJycy90?=
 =?utf-8?B?RzlYZG1EOC94U29EU0dwd20zNXI0UURXUGNDOVZjVFRNYk5EWGROWHdMRzhj?=
 =?utf-8?B?aTlWTXBGYkNuQWdqb21KdFhCdTBzdFdmMnQxR1JXek9wb0JOckt1ZmZIbGNK?=
 =?utf-8?B?NFJNU1RNemFSMzhkQUFYeHVCelJxcWR4aEEvWmZWdklhSDQyV2Erbk9aMDdo?=
 =?utf-8?B?ditHMisrcG9Fa25IRHVLRUV6amJzWVdzQ25uSXBOei9WS0oxa0I0K3V0ekFp?=
 =?utf-8?B?WW5IY25xV3ZBYnFQVTBaNXloWWYyWnlEekpZQTFUL2RrUzY0d0hHU3BkdklO?=
 =?utf-8?B?K1ZpbTcwdFQwMXNxYWZyR2xEVTBJeGlOZ3ZOWC9pWVNNTHJwL3JoMU5xbytM?=
 =?utf-8?B?eWlaU21FbWtKNDdGeStDZVBvK0hIVmZtMzdsQzZVUlVIK0JXcE9kTFJSdzlE?=
 =?utf-8?B?eDIzK2xySENQTnAxTHp6MmUwa0FTQ0I3Rmlod2VrWjR1N3NScFVvWElXTkN5?=
 =?utf-8?B?ZFpueFlkQ0ZqNWpPcE5JQlFGNkUyT3ZQWVA5TWppd2krNksveUVIVnlsbHlN?=
 =?utf-8?B?ejJGdExlNDNpbnYzZG52cWdNanBiM2dKcC9DTDZ2YlNBMkJVK1hYR3l3bnhG?=
 =?utf-8?B?QVJYUWJTVGlZSkVxVEordjBYTFRBaS9lWkdmMmhOamxxSTBWNDJIUVFpOHgy?=
 =?utf-8?B?bVIwd0RjVnRJYkZmY2U3ZWZ4TXZBZCtGbUswczhoRnptdW1KUUxEOTdKUWQx?=
 =?utf-8?B?K3lhQWJDTmZJTmhjZjEweFBrMThuMXRWVlI5MXlBU2dZamVUQ25mVC9TOFNk?=
 =?utf-8?B?VkUwK0pQRm1MUU9kL0RJK25rei82cWVRbkdsSnNNb0JaSVoySWNmUUk0M2FT?=
 =?utf-8?B?enhwcWRrM1BwUzRabFFySEFGZ282Nkh2U3czbkxJVFRtdy9RdnhZdjFOMXls?=
 =?utf-8?B?Q29IeXV3cUR4UDU0SUZERERtR1JrSWdScHg0UXZITWVaMFY4dDF0blA4RDJR?=
 =?utf-8?B?bWhVY2NhSmlXQ0laaW9Nd3MrTkp3bUVUTysza1hvL1AyNjljbWdtakhHdmQ4?=
 =?utf-8?B?WUdndCsxdWd4VmR5WE51WmJBc2dZckphdCt0bHlFVXhzV2JJdjVrSkhjc0Rk?=
 =?utf-8?B?SFFDbGlxRldPZk5xS3dJMTRpM2s3S3I3OVZOamxXYkx3K0R5ZnpJcHQwSi9l?=
 =?utf-8?B?NUJPeWh4dmRUQzVmQWd6M1BqKzJlUFdIbVlmUHl4LzdaMGVoNndneGZ2RlM3?=
 =?utf-8?B?ZENXMHlFSHp0NklkTXlVa0NUb0wydEFMKzRiRWVZNGsxOTVyTGFUM2hReXli?=
 =?utf-8?B?bnZ1UDZxUC92azg5Y0ZmOG81MWZRckdqSmtUQXhsaEtNWHpPa2N3WnYyMjdJ?=
 =?utf-8?B?ekRXdk9SK0p6THhYaTBzNU80RXpHeW5kVTNzaHRnc0htN2x6WGFSVXVPZFZs?=
 =?utf-8?B?UUpPTk5TL2ZNeG11NCtiUGtuRW10ZjZmVGJZbG05S2xxbitSUEVOTGRIMkow?=
 =?utf-8?B?SDhiaUc2UGtDSlhiMVB3dGZjY1RpdHROcUNGcnY3aTgxYmJiM3NwcWF1enAw?=
 =?utf-8?B?KzIzcDBlbFVnd0FiUmhvNDUzclVKY1NQeFdtdnRvbVM5alo2RlMyd21sQjBF?=
 =?utf-8?B?ODFuRDlyUUcwRVVGbDRvc0JGWi9RS2VpamVpZU1VY1VjcUpZOENQYmQ0WVN5?=
 =?utf-8?B?bFBiWWtFUjM1TWMzTDQ3U2dkZW5zcVRLZE14TDdFK3N4VExBUmE0WTBPeXpW?=
 =?utf-8?Q?3+drXTH5neFqkpzL7dfGNzVGq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c838e8-7aef-4b52-2d28-08da744d4cab
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 06:07:37.7842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qr2ZPrWlHsrFph7XTmVVpdpX+Ieq9RNscsm+GvMuuuswmTu2jkT648VOv2HVrYDNSMGFFh7CD4p4ULxl5PQ7iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6353
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-Jun-22 9:48 AM, Ravi Bangoria wrote:
> 
> On 13-Jun-22 8:05 PM, Peter Zijlstra wrote:
>>
>>
>> Right, so sorry for being incredibly tardy on this. Find below the
>> patch fwd ported to something recent.
>>
>> I'll reply to this with fixes and comments.
> 
> Thanks! I've resumed on this but my mind has lost all the context so
> it might take a while for me to reply to your comments. Please bear
> with me if I'm bit slow.

Sorry, it took a while for me to get started on it. Anyways, thanks for
providing fixes. I applied those and ran some tests on AMD Milan machine:

- Built in perf tests ran fine without any issues
- perf_event_tests reported one BUG_ON() and one WARN_ON(). I'll work on
  fixing those.
- Ran perf fuzzer for almost a day. It reported one softlockup but system
  recovered from it and later it reported one hardlockup but unfortunately
  my config had HARDLOCKUP_PANIC set and thus couldn't confirm whether that
  hardlockup was recoverable or not. Anyway, system was running pretty much
  fine until then.
- No lockdep warnings were observed in any of the tests.

I'll work on verifying functionality changes.

Thanks,
Ravi
