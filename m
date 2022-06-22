Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF9F554F34
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354544AbiFVP2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358374AbiFVP1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:27:55 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65585C69;
        Wed, 22 Jun 2022 08:27:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9GvbRXFU3r6aAFG+zMmurU5MFu99z42+yhTNVsCxd3d8mohwLd+h8zxWDMP3MJqm91hCxCcw+aFK3DDK5Y+Er7LS7hmdqB+fIJpzOtpN6m1bAlvJOt3ct3CR/lqXYJzQWrLq8m77G51tZ26lDNlFtk6Aa+bC3dtHkbQU5mH388ZyBAjQqMRW5fLnC1isCZFkDLomMWpXWI2I3gEXwHcAPW+dkJ1ss2kKPt73KuysWhKn3gz2SQ8ZCs/qkGvUd4kWBn2230/kwGm2ZUDVhvwMoeRLP3cor/EAkPDzL0GBMh6yifwDuCqKj0vBqmuemZPjG2fvNYpTWCkz+JRmt3ghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKztkPvE73c85bdIx1504vIFQKOlJZUHhm9xhLkVUic=;
 b=hjZXOAhbeEyLyQ8Epbhfnz8rrlLkdqTyekeZyXekfTkCgE62CSdKuFqPhnWv1loiKPr4WmyIQz2qTo+VV/sMjyJGgX+vgihlq7Rf+02TGdURNAzw2znmpdjpaSaSS6AcKPwtWVOjQEBUVT4GdW7ngW6A10E99zI97wQeVg0JmJTtV+x6jAWuTBcaNQWRnQ4cEPh0domnD5MA4jVnfQZZItVw0RCTx8fRx63LY5b/Osy6S7jeqPteu4bYyWCfNYjp4bDrlx/ombDuA6CwLhvBCVkdzPsERxmnn3nBSiRa2kzSBOFAVNWaVIRrqUQEIsKpxriwpfbvsM4sdiDsQvTvRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKztkPvE73c85bdIx1504vIFQKOlJZUHhm9xhLkVUic=;
 b=sZrS3B6m8jv1DXdS7UOdhvZg+UYCDDfIkSzEec2aTYEj2h8m1qxVLAsWSCtykEMex8wGd9HKIfZ/qoPEsL4Rw0oN1q/DfthPl0kU8Zm6kOPz1QjQ3D0sHtKH/vIrh+cXoB8Y3UBxnClwkB/tTK/hadRhM53tCN8dnvl/vrEEk+OENNyENNvfnDSUxUxXbq40eWs7jSfHZNC7sP+5CWipwAGd3LuJxuexz6HVYeXzzyoQ8HPaxARL5VTmhzSOppQ+b7d77eS45FDu+SfLOUPQsz7desNC1hcy064vWCpgJ5bCuN0jA57RTPHYuNO99BjXlZsU+8nsEhD78AmlcgDXgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.19; Wed, 22 Jun 2022 15:27:51 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8%4]) with mapi id 15.20.5373.015; Wed, 22 Jun 2022
 15:27:51 +0000
Message-ID: <40e616eb-22f9-19c2-8d77-20cd3c7c518b@nvidia.com>
Date:   Wed, 22 Jun 2022 16:27:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 5/8] OPP: Allow multiple clocks for a device
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1654849214.git.viresh.kumar@linaro.org>
 <8b29fa207024dc295639f9ba52c28e45782e3baa.1654849214.git.viresh.kumar@linaro.org>
 <55623c12-dda3-613f-5bc9-80b3b6fec5f9@nvidia.com>
 <20220622141511.yzg5itkdwirpavfj@vireshk-i7>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220622141511.yzg5itkdwirpavfj@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:540::14) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e466fbca-8c4a-4eed-e57e-08da5463c4fc
X-MS-TrafficTypeDiagnostic: SN6PR12MB2800:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2800D7E9770EA7C2CEFC5588D9B29@SN6PR12MB2800.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h9fSEFZn6pVYPyYMyARk02A+Jbkx75YO6xBHxghNqrdgvq9FV7+Iaprp4pEM3811gM3fpwQZDfXQZlcyYgII8fNVZxAdNxrL6GZT5Pu7ScIFvmTk2eN5NqRtAtOIjibyJ56gUH1misdCD2RqI/O0QLt9MKQdrzJeVFPWJYHqrA7s0g1ib50uw14cfkSDt1azz64Fci80vSfdlbEKCd5reaFfeK1FKE5fGiTzWKWbCF/Jom6Bm9VVcHTMZMaOGDnrQPx9+QTmu/nkdQVI0oi4k4VineSO1x97rGFwtb1MNmKXeDCLKk386oNi7I4yUWJ4gUFsXxNvdPOtPFPoOhypZSI6/DmlyKPwrLvOW7Xzl0XxOH00wuiWV5Caeo2f3C44sdSgmyD+m4YDnHNQWhO1/ZfdW8D8MUApMReuEGnpRGvPtIxNcZnnSHyey4mKTzByW/n5rhGWGGN/yqLjv0UX3ZAtbvtzhJg+dj7c8b6o4jJr2VWTDM8T4U3JA7tJ0GzfQZ64+a8gfwz/Y/ChHu9An2KQDqw6aipJfBBaxVUtGH1w9gQrSCQYKTwEkH+r+ER+WvKgdP+azecz4Lk++VxVywouVfFDZryTVaMt3ba3vQ2mjCtl3RzVYLWrdySBdmtBR49lTrz4WByyUOw8yA9rRoxCQrVQUXeFjbz6LFgY/iSjCCQXno2JYOdAb5Nc4x7tRUb2p8C59gmQ93+q3rBDqfiKFwf936DNBC+K13u5G/BqEn6Hnm6/GOIgrnHvjeiLpqJdC5o8oVf7134LG+ujX47DmAvA4HnCWhRqvZyAHSs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(38100700002)(31696002)(6512007)(2616005)(186003)(86362001)(5660300002)(26005)(83380400001)(110136005)(7416002)(45080400002)(8676002)(6486002)(4326008)(316002)(8936002)(54906003)(36756003)(53546011)(31686004)(6506007)(6666004)(2906002)(55236004)(41300700001)(66946007)(66476007)(66556008)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnJCeVpkZ3RLWU9aMiswaEduSHJ3RHhhMmVNUjZuK1Q2aTkvam9tSEx2eTJs?=
 =?utf-8?B?aW5aUjdld2pPWlFIeG03TkppekxXTjNpYU5MdFhFaHlaZ0M3Nkdid0I3MTJ6?=
 =?utf-8?B?Q2ZEeTEwN1lXZWl2WE5DQzlxdGJQMlpWWkhneXR5Z3Z2NHVST2ZPWE85Ty9U?=
 =?utf-8?B?WDBvTldMNGtBczZsK2d0ZDlZSXE5MlVnUEpYbitYWmd5dW9iTDRzcXJPVnFP?=
 =?utf-8?B?b2JVN3BGYkQ4YXI4MjVxVWN6Y1JVL3FPcWRSdk40NDVNVFMzK3pKdFJFdHF3?=
 =?utf-8?B?S3JZTVhLQ1psc3dWcTRQdi9pRmJNMmdQSE0zSFJhbGVtVm5DM0VOZHBhME9D?=
 =?utf-8?B?WTNndjRGT2V6Q3pVU0h6MUlsK2lENTJRcXBYdEptZFd2K0tIeVMyU3VxNDVq?=
 =?utf-8?B?YkFxeTMvS1REaXRmYXJWSzlkT1hYY3lRTjUzWFFkbmNqdUJkVHcrTWhvKzl6?=
 =?utf-8?B?ZFNCQ282UjJiV2J6ZFRIcW5uSTlwbWN4VnNyVytXTUhnMmlrQS9vdkNZVGVu?=
 =?utf-8?B?VFplM2txSEhUYlI2RXBYTmtqTm0vU0tHaVpZc1p4eXBETnc3WDlicTNmKyt6?=
 =?utf-8?B?VXdFUzdsL2hYV0dBeFEyQ2p4dnZkdSsxYkN4NUVzdXN1OFJjQ1l6LzlMdUN2?=
 =?utf-8?B?c0JRZ1JtSWxSdkhmRVcyNFJ0V3kxVU1YdWhmeEN5eTBmTW9nWE96WXNpZVlW?=
 =?utf-8?B?WFlzSTNUWFE3RWJXdFp0bERPRHRrUTMxNy9Oc0hteE9kcGlxNkdyNlFkK21V?=
 =?utf-8?B?NDQrSXBsVVFWRWNLVm5TNERVQ3EyMWd1K0pldzQ4U3JRS1hYbHFZWDZaOWVX?=
 =?utf-8?B?WVFkUWpJd1JtOXR1bm5zZHVYem1hdWozSFU3KzBhTlNyVFEzcDFncUpBaFlr?=
 =?utf-8?B?V1ltMDZmNmhDaW5jSUZZTFhYWjlCdE90RHVSQU5qZmJlSy9RTjNzK1ZpOVB5?=
 =?utf-8?B?cjRQSTY3WCsrTTZSdWlBcVZmVXk4U2tiZlFUa2ltbGV4ZHNtSjY0QlBQc2VF?=
 =?utf-8?B?Z2xFMzVFZTBTbmtRd01FUGExZ3BycnhXL2dwSXgyOS8yUXlaNXF0NElSSDAr?=
 =?utf-8?B?ZUZHRjVqVW9zUmZiWU1LRnZmeTVqd0k5a1J4M0FjZkYzZHlma1R6RTJRU2hZ?=
 =?utf-8?B?TTluTWZMaXhJNEhqM3pJS1c4SUxKdlQxdjRPQVJ5akZVZllPeG9IRlVnMlJC?=
 =?utf-8?B?bjZFZGM2OUVwZHI3NzRxandpa2grT2t4di8yQndtbnpXRjdXOHZwUGlzR00r?=
 =?utf-8?B?MUUwWjNHcXpzelUzeVZtTjhtQ1FVSTZ0N29qNSt2NGZFaFVYc1RpbUd3ZW9T?=
 =?utf-8?B?elY5dk52Qno0YW5RVEdhWjZNangyTU5Jcy9SZktkTmRFSWUvbGF3RHUzOGg2?=
 =?utf-8?B?cGhlMFp4MW9zR0wxOHYwdXhjZFNnS3gvN01sSWxXeCtIb1JCeE8xS2dvV3Fw?=
 =?utf-8?B?ZDBQM2lsK2lyMEFmTTRJK1R0S2I5RFBnVWFNelNoSUw4YTJGYkVVaS9jd01L?=
 =?utf-8?B?Qk1iZFREOFhtZXhVSmhnbjdwOG9NYlNOU0pFYlFWcWxGL0U2VzNaRHY4OHRt?=
 =?utf-8?B?Zkk0WmFGUWNzbXlyMWVra20vaDlGL01sKzN4VDU0UnNoMWc5WkVHNElwYmZK?=
 =?utf-8?B?WktqOGJFMllTTWl2U0FsTHhMNlIvTWJDUGhubU9CRWJ6cEJRaWhxNEZNQkV4?=
 =?utf-8?B?Zlh5S1dia0RueFFaUGE3LzNKYk5xVmtNR0N3dXQ0QjJHSkx4U05hbzZOam1k?=
 =?utf-8?B?eUI0c0h4RTZkbXJCNXl4ZDBibUozNWxjTTR3N0gxdTk5NWJoRW5YZXNwSTUv?=
 =?utf-8?B?MEVLUE5XSDZ4em9ZeXh5TExRMlBvcGxpZjVqTWxqUTZPQ2J1NGlNd1gwY2l6?=
 =?utf-8?B?SXBJVS9KN21mUU5hcDNCR2FWQXdzcmhoZkRNaTRGYTJyUEJEMDg2WkFqWG1K?=
 =?utf-8?B?dnZFQzlQNXRYYmphem02bkZIcklDdFl4MElDNktPaHpTUEJZYTYzNmd1bGFp?=
 =?utf-8?B?TS9sMU9WdmlnUHg5U3dRWmZUT2FhQ01FNHFUNlFRUUZFaWhzZjQ3d1VwVXZh?=
 =?utf-8?B?dVlUK1ROcW9qdGxic0lXRVpVamhuWmxFQ25Lem1ocU1ldnRlRUFEY1VPMklJ?=
 =?utf-8?B?Q3d6dU9TNGo5QlhJdG1ZdFVnYTRYRm9Gek1NL3FJQnpnLzhORWpaUWtKdHlX?=
 =?utf-8?B?YUl1aEdKN2RQZVJvTEs1ZHpuMkV1Q2FWcy9Pb01lc0w2dXNQMGIxZkFZWEVn?=
 =?utf-8?B?aUR0QmY4cVJ3S2FLMk85bUJMckhFSG85My9PeTA1YkhITU9LSEc0bFhOTjVj?=
 =?utf-8?B?QUxWTk1kQ1E3R0h0Rm5IdW5xSVczRnRtNUo0cTQ4WGlGM2pWNFRnbHA1bS9p?=
 =?utf-8?Q?XEPh7Hk6B4T3iTis=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e466fbca-8c4a-4eed-e57e-08da5463c4fc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 15:27:51.2250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyHuly+5CCV15n4yE1aNEf4R6rGf35isRcMeoylVB3Pa4W9jwIuKTDIPaeqUaGo3sDxEXHrRmEoYlD/jvZAOpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2800
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



On 22/06/2022 15:15, Viresh Kumar wrote:
> On 22-06-22, 14:47, Jon Hunter wrote:
>> I am seeing the following panic on -next and bisect is point to
>> this commit ...
>>
>> [    2.145604] 8<--- cut here ---
>> [    2.145615] Unable to handle kernel NULL pointer dereference at virtual address 00000000
>> [    2.145625] [00000000] *pgd=00000000
>> [    2.145647] Internal error: Oops: 80000005 [#1] PREEMPT SMP ARM
>> [    2.145660] Modules linked in:
>> [    2.145671] CPU: 1 PID: 35 Comm: kworker/u8:1 Not tainted 5.19.0-rc3-next-20220622-gf739bc2a47f6 #1
>> [    2.145688] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>> [    2.145697] Workqueue: events_unbound deferred_probe_work_func
>> [    2.145740] PC is at 0x0
>> [    2.145750] LR is at _set_opp+0x194/0x380
>> [    2.145779] pc : [<00000000>]    lr : [<c086b578>]    psr: 20000013
>> [    2.145789] sp : f08f1c80  ip : c152cb40  fp : c264c040
>> [    2.145798] r10: 00000000  r9 : c152cb40  r8 : c16f3010
>> [    2.145806] r7 : c264c034  r6 : 00000000  r5 : c265d800  r4 : c264c000
>> [    2.145815] r3 : 00000000  r2 : c265d800  r1 : c264c000  r0 : c16f3010
>> [    2.145825] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>> [    2.145840] Control: 10c5387d  Table: 8000404a  DAC: 00000051
>> [    2.145847] Register r0 information: slab kmalloc-1k start c16f3000 pointer offset 16 size 1024
>> [    2.145883] Register r1 information: slab kmalloc-256 start c264c000 pointer offset 0 size 256
>> [    2.145914] Register r2 information: slab kmalloc-128 start c265d800 pointer offset 0 size 128
>> [    2.145942] Register r3 information: NULL pointer
>> [    2.145955] Register r4 information: slab kmalloc-256 start c264c000 pointer offset 0 size 256
>> [    2.145983] Register r5 information: slab kmalloc-128 start c265d800 pointer offset 0 size 128
>> [    2.146012] Register r6 information: NULL pointer
>> [    2.146023] Register r7 information: slab kmalloc-256 start c264c000 pointer offset 52 size 256
>> [    2.146052] Register r8 information: slab kmalloc-1k start c16f3000 pointer offset 16 size 1024
>> [    2.146081] Register r9 information: slab task_struct start c152cb40 pointer offset 0
>> [    2.146105] Register r10 information: NULL pointer
>> [    2.146116] Register r11 information: slab kmalloc-256 start c264c000 pointer offset 64 size 256
>> [    2.146146] Register r12 information: slab task_struct start c152cb40 pointer offset 0
>> [    2.348527] Process kworker/u8:1 (pid: 35, stack limit = 0x(ptrval))
>> [    2.354896] Stack: (0xf08f1c80 to 0xf08f2000)
>> [    2.359273] 1c80: 00000001 c0868db0 00000000 7a13d783 c152cb40 c264c000 c16f3010 c265d800
>> [    2.367471] 1ca0: c2661c40 00000001 c2661c40 00000001 c2661c40 c086b8e8 00000000 7a13d783
>> [    2.375666] 1cc0: c12ea5a0 c265d800 000f4240 c058cfcc ef7dddec 000f4240 00000000 c2661e88
>> [    2.383861] 1ce0: 000f4240 000f4240 c2661e98 c068d238 00000000 c2665e00 000f4240 000f4240
>> [    2.392056] 1d00: c2666258 00000000 c2666000 00000001 c2661c40 c068d15c 00000000 c2666000
>> [    2.400253] 1d20: c16fd140 00000000 c16fd140 00000000 00000000 c16b78b8 c16b5e00 c068d2d8
>> [    2.408450] 1d40: c16b7810 c26661d8 c2666000 c068ed98 c2663d00 c2663d00 00000000 c086914c
>> [    2.416647] 1d60: c2663d00 c16b7810 c068ebec c16b7894 00000004 c0174868 00000000 c16b78b8
>> [    2.424843] 1d80: c16b5e00 c0684630 c16b7810 c068ebec 00000000 00000004 c0174868 c152cb40
>> [    2.433041] 1da0: c16b78b8 c0684794 c16b7810 c068ebec 00000000 c068506c 00000a00 c265e040
>> [    2.441237] 1dc0: c0f5bdd4 00000004 00000000 7a13d783 00000000 c16b7810 c16b7894 00000004
>> [    2.449434] 1de0: 60000013 00000000 c265e10c c265e154 00000000 c06854c4 c265e040 c16b7800
>> [    2.457629] 1e00: c16b7810 c152cb40 00000000 c05e42b0 00000001 00000000 ffffffff 00000000
>> [    2.465824] 1e20: c16b7810 ff8067a4 01000000 7a13d783 c16b7810 c16b7810 00000000 c12f7700
>> [    2.474020] 1e40: 00000000 00000001 c1367c20 c140f00d c1405800 c067a668 c16b7810 00000000
>> [    2.482214] 1e60: c12f7700 c0678280 c16b7810 c12f7700 c16b7810 00000017 00000001 c06784e4
>> [    2.490411] 1e80: c13b6754 f08f1ee4 c16b7810 c0678574 c12f7700 f08f1ee4 c16b7810 c152cb40
>> [    2.498609] 1ea0: 00000001 c06788bc 00000000 f08f1ee4 c0678834 c067675c c1367c20 c14b4e70
>> [    2.506804] 1ec0: c1ea60b8 7a13d783 c16b7810 c16b7810 c152cb40 c16b7854 c12fa050 c067810c
>> [    2.515001] 1ee0: c1400000 c16b7810 00000001 7a13d783 c16b7810 c16b7810 c12fa2f0 c12fa050
>> [    2.523197] 1f00: 00000000 c0677410 c16b7810 c12fa038 c12fa038 c06778d0 c12fa06c c176a180
>> [    2.531394] 1f20: c1405800 c140f000 00000000 c013dd2c c152cb40 c1405800 c1203d40 c176a180
>> [    2.539592] 1f40: c1405800 c140581c c1203d40 c176a198 00000088 c1367177 c1405800 c013e2a4
>> [    2.547790] 1f60: c0f07434 00000000 f08f1f7c c176f7c0 c152cb40 c013e064 c176a180 c176f640
>> [    2.555984] 1f80: f0831eb4 00000000 00000000 c01459b4 c176f7c0 c01458ac 00000000 00000000
>> [    2.564180] 1fa0: 00000000 00000000 00000000 c01001a8 00000000 00000000 00000000 00000000
>> [    2.572373] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> [    2.580569] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
>> [    2.588768]  _set_opp from dev_pm_opp_set_opp+0x38/0x78
>> [    2.594038]  dev_pm_opp_set_opp from tegra_pmc_core_pd_set_performance_state+0x44/0xb0
>> [    2.602010]  tegra_pmc_core_pd_set_performance_state from _genpd_set_performance_state+0x180/0x1d0
>> [    2.611018]  _genpd_set_performance_state from _genpd_set_performance_state+0xa4/0x1d0
>> [    2.618972]  _genpd_set_performance_state from genpd_set_performance_state+0x50/0x7c
>> [    2.626752]  genpd_set_performance_state from genpd_runtime_resume+0x1ac/0x25c
>> [    2.634016]  genpd_runtime_resume from __rpm_callback+0x38/0x14c
>> [    2.640073]  __rpm_callback from rpm_callback+0x50/0x54
>> [    2.645335]  rpm_callback from rpm_resume+0x394/0x7a0
>> [    2.650424]  rpm_resume from __pm_runtime_resume+0x4c/0x64
>> [    2.655947]  __pm_runtime_resume from host1x_probe+0x29c/0x654
>> [    2.661824]  host1x_probe from platform_probe+0x5c/0xb8
>> [    2.667080]  platform_probe from really_probe+0xc8/0x2a8
>> [    2.672433]  really_probe from __driver_probe_device+0x84/0xe4
>> [    2.678308]  __driver_probe_device from driver_probe_device+0x30/0xd0
>> [    2.684789]  driver_probe_device from __device_attach_driver+0x88/0xb4
>> [    2.691350]  __device_attach_driver from bus_for_each_drv+0x54/0xb4
>> [    2.697647]  bus_for_each_drv from __device_attach+0xf0/0x194
>> [    2.703430]  __device_attach from bus_probe_device+0x84/0x8c
>> [    2.709129]  bus_probe_device from deferred_probe_work_func+0x7c/0xa8
>> [    2.715608]  deferred_probe_work_func from process_one_work+0x214/0x54c
>> [    2.722269]  process_one_work from worker_thread+0x240/0x508
>> [    2.727960]  worker_thread from kthread+0x108/0x124
>> [    2.732872]  kthread from ret_from_fork+0x14/0x2c
>> [    2.737602] Exception stack(0xf08f1fb0 to 0xf08f1ff8)
>> [    2.742669] 1fa0:                                     00000000 00000000 00000000 00000000
>> [    2.750865] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> [    2.759061] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>> [    2.765690] Code: bad PC value
>> [    2.768990] ---[ end trace 0000000000000000 ]---
>>
>>
>> Let me know if you have any thoughts.
> 
> Maybe I understand what's going on here now, Dmitry too reported this yesterday,
> cc'd. Does below fix it for you ?
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 2c1ae1286376..a7c7f6f40a7e 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1120,9 +1120,11 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
>                  }
>          }
> 
> -       ret = opp_table->config_clks(dev, opp_table, opp, clk_data, scaling_down);
> -       if (ret)
> -               return ret;
> +       if (opp_table->config_clks) {
> +               ret = opp_table->config_clks(dev, opp_table, opp, clk_data, scaling_down);
> +               if (ret)
> +                       return ret;
> +       }
> 
>          /* Scaling down? Configure required OPPs after frequency */
>          if (scaling_down) {
> 


Yes that fixes it thanks!

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic
