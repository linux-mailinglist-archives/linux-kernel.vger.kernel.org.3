Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D42E54C9D1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352380AbiFON36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353479AbiFON3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:29:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B3736161
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:29:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvFRvjQae4YN1Codc185ONd8Roa/w+tQ/I4uiESx5DcVjPmOuboQucmORDS357VpMoFiY6BaFrrzVEbqGsOkD1QeZBTQpRhTUyGQLJ3ioUL61pZIaY+BwAmGIZoXKni6m7641Aw9qs3FHEgo4fQPDTRWU2R186tTQqAAs8iTZGtZZD6UqiXVBd/P3jRvHJPc6TsWU7BJOHLY5z/If9pYU2eOnUo5hmntNv9pVv4SY0GLWJr+bhxlvQcly/utarRCSUweNt6Z0N4etg9T3No2cLWTJRn51wSJPSzLZvAYvb/nEkoaKaJMXgvzRuOt6Yh3lA2zApMbd6bveWQsSIreAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8P33eGOyPtddWpD3O0t2oubyJ/QcI159CK+If1myOXo=;
 b=l2uv16hyt6bE4eqFrcOL8La+SMVpYXKtQ76fMBocKjcuWWj60EzwimBGGoKq/AHq4D1ncdzwrbwA3ucxlpzCFHExxCPHlJI1geqABgQxH256Z9VPNlRwf+/9uO5Pq2rOA2Z5NHnBhBDNIisa5lpH/0L90Uh87AICeIyKR/nkMIlPZLEGgNnAGlyue7JN4W79rnFE3h+ado68pbiQ/nbSgLt3OiN8lsIWBBII1tPUXfGz0/Koxa2lYczqKeD6eec3zQpqg37GNrsZjAlvhnXjjQ+D0lNMXcjFOXfqqXG1vMnp/1vG8xt064u1YBACVs3NYzZwzwY1IaGIUc5gaoVPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8P33eGOyPtddWpD3O0t2oubyJ/QcI159CK+If1myOXo=;
 b=0T2g2y/jipShV5GFgUu86ajCdBFC88A9FbOtokLo13pQPBlPcMNGasntS3B+KR+OXwo2M+wz9Dqn/vWxcaIKqgGYEG5PdBwq3mvFqLQElREAAg9rVlRRqYdykBpgMeB5A7qw7VpGW/lNYMD60dNDResGcNTcRaQ5rJ6ZiwGpCCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2381.namprd12.prod.outlook.com (2603:10b6:802:2f::13)
 by DM6PR12MB4895.namprd12.prod.outlook.com (2603:10b6:5:1bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Wed, 15 Jun
 2022 13:29:19 +0000
Received: from SN1PR12MB2381.namprd12.prod.outlook.com
 ([fe80::e5ad:dd49:ae41:bc97]) by SN1PR12MB2381.namprd12.prod.outlook.com
 ([fe80::e5ad:dd49:ae41:bc97%6]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 13:29:19 +0000
Message-ID: <0b065646-5b05-cbdb-b20c-e1dfef3f4d79@amd.com>
Date:   Wed, 15 Jun 2022 18:59:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 1/2] sched: Add per_cpu cluster domain info and
 cpus_share_resources API
Content-Language: en-US
To:     Yicong Yang <yangyicong@hisilicon.com>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tim.c.chen@linux.intel.com,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, prime.zeng@huawei.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        guodong.xu@linaro.org, hesham.almatary@huawei.com,
        john.garry@huawei.com, shenyang39@huawei.com
References: <20220608095758.60504-1-yangyicong@hisilicon.com>
 <20220608095758.60504-2-yangyicong@hisilicon.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220608095758.60504-2-yangyicong@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::20) To SN1PR12MB2381.namprd12.prod.outlook.com
 (2603:10b6:802:2f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51f65103-45e9-4925-8502-08da4ed30d16
X-MS-TrafficTypeDiagnostic: DM6PR12MB4895:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB48956BD12EB0232672895AF498AD9@DM6PR12MB4895.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kjPuMQ9CmpXX6eDMyNsGkcRosy18G5eP6PoTRBjsGXEXsJsg34NiS1hq6aa16yB3WM1yHR4EhB6GI3N0NEsdMebi7zjEHjJ0kjVWVDVlG2CD1TcJ04Mhpn+u3VTqSvt6WtY1OhAzrVUw3dunYBugX1R7enVEVJEdgzyYX7reTx28Z2TbkrlnarFDoRZnXczGoPjubPEr8q/6CdWYogc5cl1DH5vAqtlJ+eI1mx4+DO4XWd8bmYJhXJxxgxOTWD7tCcER5ughGp3q0FIU12DOVPZ1noLz0+ygUpK7cgws0kMZ4FDJ5D/DU3oUd8rEmX6KXQQsRWqXcvjFv2EOQkORpISJjBhbi/U/kHR4Qgsv54gTLhfjKG6oApmDFOWXC6KtHLXccB9Eq5oE+XzMPHTAsUie7awoFo9VbdKaVl63gctkVOPcoV9dFdebrCO6rEvbc6G46tbmsMcGKcnAfRH1FUSpT5JISf1g+8K57ZHqFOV6lWqiNOVFgF8M1rbnPI10PDYL3SA+IplgCUgO8heJoTpZCbqK0Fh1JKTaM7hDijBL/vB5fhsvBEFCCbbEaMKKl3nMbwKPB4FeBQgUM+uDYvjlacwMKJ4e0V7elcXiqZk+hELSdp9FWu0RIZ9gMkVnoJkdwcs0D8sKULDrDSCAnrJ3dZMYCtVmTXYNVrjrmYAgzg2dFOB3Q1ULXfsrWrObeESiZWkokpv+a/AZxHnZ0eHYmowX0TpbdrQmWAKxUUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6666004)(2906002)(36756003)(31696002)(26005)(66476007)(508600001)(66946007)(66556008)(186003)(83380400001)(2616005)(86362001)(31686004)(8936002)(316002)(5660300002)(6486002)(6506007)(7416002)(6512007)(4326008)(38100700002)(53546011)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXROUWs0NGtXRjBFY290ZzM5bDM5UG5KdmJLNE1FdHBDQWdXTytYYWtKdFRv?=
 =?utf-8?B?T0R4UGFsUVk4aVhFUkZrQkRHRFhmS29CTWNvWlhGMzJzZUJ2L0ZUdzhTOCt2?=
 =?utf-8?B?MWJJN0lCMVhGL21ieURmN0EwN3hjZjFxMlZtSW1OSzkzSzZOLzJGYnd4NmYw?=
 =?utf-8?B?TGlyajdmczgrSWxsZDNFT0IvNnY3V21ldm9vZzFhWmVOWlJoNkpvTnRRS21V?=
 =?utf-8?B?N3U2OExYZGJSVFY4TEkvMDFIbGFyL3pzYnR2eHpIWko4cVlhTnhoZExhNG1M?=
 =?utf-8?B?eWJoeFN4UG10SnFJU2hYYzZCWGt3YUVUNndVa3l6cVBwaGpwZXcvVTE0S1U5?=
 =?utf-8?B?b2NmZjl1Y2RiMmRKUU4vcTgvTUtDQ0N3bjJaMGRHSG9TRDFLU0lVQmU1Zmlt?=
 =?utf-8?B?YllUY0lVNE1JQ1ZQMGZqcEQ5RkQ4cGJGSGkzajVzM1BmdHNybW42V2xIZXI4?=
 =?utf-8?B?NEFXY20vNlRGQkhtbXZFZnVUL0R2bUpodzJUdksweGlvNHI3UFhTaXQzeVJa?=
 =?utf-8?B?NVYrbzkrandta3RGMjBCdkhFcmduRnhtNWxIQjNlQkRQaTJBRGNOSFhhNW9T?=
 =?utf-8?B?MUdtaC93YUdpaWhUNFdqdmRUUVY1aWhma3JscmtCVklQT2xHVkFHeHY4QnNw?=
 =?utf-8?B?YU1CWWZZbFBSZXdFT1ZEdXFDVmR5UXh4eTBvZ3RZOUZDME9DUlA4R1Q4R2hi?=
 =?utf-8?B?Qm9tNENKbmFNTllvM016RmFvWU5EdmhYTXdEQlRKVFZldENIU2JvZDRwVW1C?=
 =?utf-8?B?U0tpRHVjVGZjV3BscnNJQ0ZmakZIVk0xblhmc3dNY05NOFk1UHlCM25yTmFN?=
 =?utf-8?B?ZGh3MzI5aGNlL0JkY05ySWUwN1ZlaDVoR0JKdTUyeENxaU5ldndnUExac3dI?=
 =?utf-8?B?SXpLTStrenhyazF4bzRaZGwwdWl1NE51YkhnN2dkUlB3bkRneGJmRmJHYmZU?=
 =?utf-8?B?bzByalRLMFBJVVNKT2tBWXRZcUZJTHlEcEFWZEN4YzNSZGcwVGcybEh4elR6?=
 =?utf-8?B?TnVVQldyWlBmd0NqVkRjWk5QTjloWkZKWTVBQWl4b2FvK3VwMjNLYWREV0hW?=
 =?utf-8?B?ZExjRCtiL3BuMmlBSjdrbkJiTUtzTlJJenJPeXVRS3YwRW9ibkZmMWVHeEVo?=
 =?utf-8?B?WFVPcDFkUW0zZEw2dDNDK3dXOTRXcWVYeGhEQy9XVU1XS2ZkdGtUaUV3MDAv?=
 =?utf-8?B?UUlMRjVjZVFxMTRnQVVhVHg2bTZaN0RCbDZHWVZ4dWYwa0kyYVpVZ1k4WGR5?=
 =?utf-8?B?T0tDSEsvY3ozZVpPb1loaTZGUzI5MmVzdkRabW5OUVkzV3NLTWFncDNHMEF5?=
 =?utf-8?B?VzNWMnhlWjd0SUg5TUdGbE1rQi9zbmJWWGI2SFNrZGFxTGRGd0tlWDJicHNQ?=
 =?utf-8?B?djBid21rR25zOG84NFVWWHRGbGFsNW5yRkRiU2wwZHdxNVRzVncvZWFpbkQz?=
 =?utf-8?B?K1VrTk8yeDN5TXU3dGZQKzgvWCsrTThxUjFVc2U3NWNCT0RxN2FFdE1laHRK?=
 =?utf-8?B?TEZUaERqMnkwUk1zdG0yeHFtbGdldGhzcGFCck5vOXZCR2x3M2hmZG95d24z?=
 =?utf-8?B?Z29KZGk4dW5ab29iR3RsaEdKN2U3aHFUWFJRN2M0QmdUVlEvSWJiWXp5dU5i?=
 =?utf-8?B?bGx0dHpFVm1jazU5SUZkQ2ZuZFZScVhobWlnbm1lS0F3UmdrT3J6S2cyTVYv?=
 =?utf-8?B?SllsYXdyVko1VTI1RmNNYUNwcjkwK0ZaZjYxUkZYTlZqb3E3L1RmNmxGcUVE?=
 =?utf-8?B?cTk5TStzUitpU002Vjh4VStIeXZ0VExrVFFieWt2ZVBZeGJkY1hmTXF5cFNU?=
 =?utf-8?B?RzMyVWcvTTk1Ulh5UWhrSnQzRGVqSHJzOWZiMFMzcUpzODFiUXRmck1jNW1M?=
 =?utf-8?B?Z1cwL2RrRzhON3VmVG9oZ3p6clRhcjMyNW5UcS9iSUY5M2ZWM2pSK0dZS2Y2?=
 =?utf-8?B?Vy9EUUJhQjFhYjlYcDlIWmgwMTlLRDBFcGk1T2JXOGNRZkIxbGF4OHNSTUIv?=
 =?utf-8?B?aTJqUnk5L0tuV0xJS1Rpa0EyT1M3U0IrcU9SSUVBVEo1OGRnREZPV0oya21M?=
 =?utf-8?B?TDNaakowTmdjbGF0blpwM2lzUlRvR3NmWGhoTUg5Ty9LQ1ozM1gwcmJWWnNE?=
 =?utf-8?B?Mnp0eFVOZ0ttTDI5WnE5ZlR0ZEJ0VjltT2ZUb2dUY0t0aGVWczBVUHBMNVBh?=
 =?utf-8?B?OWgrZGl6eW9mTWFBWkR6TC9kTVJ2NTEvR3Uxcm5veG4zam9OVlkwUGNLdEZi?=
 =?utf-8?B?RlJ5SlJJdW82eHJvNXJwOTh1dlROZzF6Ulpaemo4SXNkb3lCcm04UDB2QW9n?=
 =?utf-8?B?Mlk1LzRSMVdVaklBaFh3RklkWEJNRU5IMlVYb2F6UVgvZEErc0NyQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f65103-45e9-4925-8502-08da4ed30d16
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 13:29:19.6304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7Bzv/BO992UDADOAwtooYjqynYlQ3pHVZc/1l+SlIukwL0OybPOLfkIe3gYV6N7zrxi5c7KMCX15w6KZDsNdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4895
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yicong,

We are observing some serious regression with tbench with this patch
series applied. The issue doesn't seem to be related to the actual 
functionality of the patch but how the patch changes the per CPU
variable layout.

Discussed below are the results from running tbench on a dual
socket Zen3 (2 x 64C/128T) configured in different NPS modes.

NPS Modes are used to logically divide single socket into
multiple NUMA region.
Following is the NUMA configuration for each NPS mode on the system:

NPS1: Each socket is a NUMA node.
    Total 2 NUMA nodes in the dual socket machine.

    Node 0: 0-63,   128-191
    Node 1: 64-127, 192-255

NPS2: Each socket is further logically divided into 2 NUMA regions.
    Total 4 NUMA nodes exist over 2 socket.
   
    Node 0: 0-31,   128-159
    Node 1: 32-63,  160-191
    Node 2: 64-95,  192-223
    Node 3: 96-127, 223-255

NPS4: Each socket is logically divided into 4 NUMA regions.
    Total 8 NUMA nodes exist over 2 socket.
   
    Node 0: 0-15,    128-143
    Node 1: 16-31,   144-159
    Node 2: 32-47,   160-175
    Node 3: 48-63,   176-191
    Node 4: 64-79,   192-207
    Node 5: 80-95,   208-223
    Node 6: 96-111,  223-231
    Node 7: 112-127, 232-255

Benchmark Results:

Kernel versions:
- tip:      5.19.0-rc2 tip sched/core
- cluster:  5.19.0-rc2 tip sched/core + both the patches of the series

When we started testing, the tip was at:
commit: f3dd3f674555 "sched: Remove the limitation of WF_ON_CPU on wakelist if wakee cpu is idle"

* - Data points of concern

~~~~~~
tbench
~~~~~~

NPS1

Clients:       tip                     cluster
    1    444.41 (0.00 pct)       439.27 (-1.15 pct)
    2    879.23 (0.00 pct)       831.49 (-5.42 pct)     *
    4    1648.83 (0.00 pct)      1608.07 (-2.47 pct)
    8    3263.81 (0.00 pct)      3086.81 (-5.42 pct)    *
   16    6011.19 (0.00 pct)      5360.28 (-10.82 pct)   *
   32    12058.31 (0.00 pct)     8769.08 (-27.27 pct)   *
   64    21258.21 (0.00 pct)     19021.09 (-10.52 pct)  *
  128    30795.27 (0.00 pct)     30861.34 (0.21 pct)
  256    25138.43 (0.00 pct)     24711.90 (-1.69 pct)
  512    51287.93 (0.00 pct)     51855.55 (1.10 pct)
 1024    53176.97 (0.00 pct)     52554.55 (-1.17 pct)

NPS2

Clients:       tip                     cluster
    1    445.45 (0.00 pct)       441.75 (-0.83 pct)
    2    869.24 (0.00 pct)       845.61 (-2.71 pct)
    4    1644.28 (0.00 pct)      1586.49 (-3.51 pct)
    8    3120.83 (0.00 pct)      2967.01 (-4.92 pct) 	*
   16    5972.29 (0.00 pct)      5208.58 (-12.78 pct)   *
   32    11776.38 (0.00 pct)     10229.53 (-13.13 pct)  *
   64    20933.15 (0.00 pct)     17033.45 (-18.62 pct)  *
  128    32195.00 (0.00 pct)     29507.85 (-8.34 pct)   *
  256    24641.52 (0.00 pct)     27225.00 (10.48 pct)
  512    50806.96 (0.00 pct)     51377.50 (1.12 pct)
 1024    51993.96 (0.00 pct)     50773.35 (-2.34 pct)

NPS4

Clients:      tip                   cluster
    1    442.10 (0.00 pct)       435.06 (-1.59 pct)
    2    870.94 (0.00 pct)       858.64 (-1.41 pct)
    4    1615.30 (0.00 pct)      1607.27 (-0.49 pct)
    8    3195.95 (0.00 pct)      3020.63 (-5.48 pct)    *
   16    5937.41 (0.00 pct)      5719.87 (-3.66 pct)
   32    11800.41 (0.00 pct)     11229.65 (-4.83 pct)	*
   64    20844.71 (0.00 pct)     20432.79 (-1.97 pct)
  128    31003.62 (0.00 pct)     29441.20 (-5.03 pct)   *
  256    27476.37 (0.00 pct)     25857.30 (-5.89 pct)   * [Know to have run to run variance]
  512    52276.72 (0.00 pct)     51659.16 (-1.18 pct)
 1024    51372.10 (0.00 pct)     51026.87 (-0.67 pct)

Note: tbench results for 256 workers are known to have
run to run variation on the test machine. Any regression
seen for the data point can be safely ignored.

The behavior is consistent for both tip and patched kernel
across multiple runs of tbench.

~~~~~~~~~~~~~~~~~~~~
Analysis done so far
~~~~~~~~~~~~~~~~~~~~

To root cause this issue quicker, we have focused on 8 to 64 clients
data points with the machine running in NPS1 mode.

- Even on disabling HW prefetcher, the behavior remains consistent
  signifying HW prefetcher is not the cause of the problem.

- Bisecting:

When we ran the tests with only Patch 1 of the series, the
regression was visible and the numbers were worse.

Clients:       tip                     cluster              Patch 1 Only
    8    3263.81 (0.00 pct)      3086.81 (-5.42 pct)     3018.63 (-7.51 pct)
   16    6011.19 (0.00 pct)      5360.28 (-10.82 pct)    4869.26 (-18.99 pct)
   32    12058.31 (0.00 pct)     8769.08 (-27.27 pct)    8159.60 (-32.33 pct)
   64    21258.21 (0.00 pct)     19021.09 (-10.52 pct)   13161.92 (-38.08 pct)

We further bisected the hunks to narrow down the cause to the per CPU
variable declarations. 

On 6/8/2022 3:27 PM, Yicong Yang wrote:
>
> [..snip..]
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 01259611beb9..b9bcfcf8d14d 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1753,7 +1753,9 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>  DECLARE_PER_CPU(int, sd_llc_size);
>  DECLARE_PER_CPU(int, sd_llc_id);
> +DECLARE_PER_CPU(int, sd_share_id);
>  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> +DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);

The main reason for the regression seems to be the above declarations.
The regression seem to go away if we do one of the following:

- Declare sd_share_id and sd_cluster using DECLARE_PER_CPU_READ_MOSTLY()
  instead of DECLARE_PER_CPU() and change the corresponding definition
  below to DEFINE_PER_CPU_READ_MOSTLY().

  Clients:       tip                     Patch 1           Patch 1 (READ_MOSTLY)
    8      3255.69 (0.00 pct)      3018.63 (-7.28 pct)     3237.33 (-0.56 pct)
   16      6092.67 (0.00 pct)      4869.26 (-20.08 pct)    5914.53 (-2.92 pct)
   32      11156.56 (0.00 pct)     8159.60 (-26.86 pct)    11536.05 (3.40 pct)
   64      21019.97 (0.00 pct)     13161.92 (-37.38 pct)   21162.33 (0.67 pct)

- Convert sd_share_id and sd_cluster to static arrays.
  
  Clients:       tip                    Patch 1            Patch 1 (Static Array)
    8      3255.69 (0.00 pct)      3018.63 (-7.28 pct)     3203.27 (-1.61 pct)
   16      6092.67 (0.00 pct)      4869.26 (-20.08 pct)    6198.35 (1.73 pct)
   32      11156.56 (0.00 pct)     8159.60 (-26.86 pct)    11385.76 (2.05 pct)
   64      21019.97 (0.00 pct)     13161.92 (-37.38 pct)   21919.80 (4.28 pct)

- Move the declarations of sd_share_id and sd_cluster to the top

  Clients:       tip                    Patch 1            Patch 1 (Declarion on Top)
    8      3255.69 (0.00 pct)      3018.63 (-7.28 pct)     3072.30 (-5.63 pct)
   16      6092.67 (0.00 pct)      4869.26 (-20.08 pct)    5586.59 (-8.30 pct)
   32      11156.56 (0.00 pct)     8159.60 (-26.86 pct)    11184.17 (0.24 pct)
   64      21019.97 (0.00 pct)     13161.92 (-37.38 pct)   20289.70 (-3.47 pct)

Unfortunately, none of these are complete solutions. For example, using
DECLARE_PER_CPU_READ_MOSTLY() with both patches applied reduces the regression
but doesn't eliminate it entirely:

   Clients:     tip                     cluster           cluster (READ_MOSTLY)  
    1      444.41 (0.00 pct)       439.27 (-1.15 pct)      435.95 (-1.90 pct)
    2      879.23 (0.00 pct)       831.49 (-5.42 pct)      842.09 (-4.22 pct)
    4      1648.83 (0.00 pct)      1608.07 (-2.47 pct)     1598.77 (-3.03 pct)
    8      3263.81 (0.00 pct)      3086.81 (-5.42 pct)     3090.86 (-5.29 pct)	*
   16      6011.19 (0.00 pct)      5360.28 (-10.82 pct)    5360.28 (-10.82 pct)	*
   32      12058.31 (0.00 pct)     8769.08 (-27.27 pct)    11083.66 (-8.08 pct)	*
   64      21258.21 (0.00 pct)     19021.09 (-10.52 pct)   20984.30 (-1.28 pct)
  128      30795.27 (0.00 pct)     30861.34 (0.21 pct)     30735.20 (-0.19 pct)
  256      25138.43 (0.00 pct)     24711.90 (-1.69 pct)    24021.21 (-4.44 pct)
  512      51287.93 (0.00 pct)     51855.55 (1.10 pct)     51672.73 (0.75 pct)
 1024      53176.97 (0.00 pct)     52554.55 (-1.17 pct)    52620.02 (-1.04 pct)

We are still trying to root cause the underlying issue that
brought about such drastic regression in tbench performance. 

>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 05b6c2ad90b9..0595827d481d 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -664,6 +664,8 @@ static void destroy_sched_domains(struct sched_domain *sd)
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>  DEFINE_PER_CPU(int, sd_llc_size);
>  DEFINE_PER_CPU(int, sd_llc_id);
> +DEFINE_PER_CPU(int, sd_share_id);
> +DEFINE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> @@ -689,6 +691,18 @@ static void update_top_cache_domain(int cpu)
>
> [..snip..]
>

We would like some time to investigate this issue and root cause
the reason for this regression.
--
Thanks and Regards,
Prateek
