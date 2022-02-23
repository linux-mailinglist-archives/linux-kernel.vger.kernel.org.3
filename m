Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C42C4C0FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbiBWKG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiBWKG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:06:28 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B448A32C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 02:05:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gB4il3qMcSXxPSoljNv1CgIx2YOsrc3tMjIEDp/Z7qgTy2iwEWaEQHogVgK9grDvRiySNQ1ZTvVzXVd6UdBD3qwIhKcuTmK6Uk7i3Xz3YfO67DrpcW2zCxGwg0GfPDWWalQ3qvn5xsCdX96hRh6R2fDmhMlTsMtE8mBboULtc0hzQegi7QoWRt/OU9CrMQh9wvNfqyZulAronOCUcS7Im2hf1hSyLWSvemr2WPgvRhLkGtEu7osbYP1/9xvrcxvgAAz9qNgOID4XTp5Hje1QnXozmUUuDFuCwzhTWzM/6ZBQ4nh+JEce0cZcagvPyVjL6Wup0vPzoOGRJ43zOxRiJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/9N3AoE7LzyRrGLnjj9Jk/QPe11sqCpBuTyGjcqZPk=;
 b=KtnBd/7P1X+Yy0tLg71D6irSaYJ/AVEWM0KVyN2v8lTRToXdU0XNyxfS6OLAvUKycr2z2SX+WtNlV+3sEMFPhiO+u4hnhJ9eZQ3VDpz4p5UJjCP/Vj6T77SRpqELLwcUIZGHbjbbIvXcTEKKtOO3JMtz5I51+4Dzn2/DUgP/qpx9Lrt6fbPrK/3VunIJvZ4HxpNs0LtTmgZrWOYt6AG28BAWKl1M/PRUTwsQ4xzx4uLb53z41/1STUQ+nEEPHi/L0vtmrra2mZ24lWVcVi+IOSU9Ptf51tNzdAuePNb//MoqIH4N7uONROSKEi1OFr7PEeE0E6ZOdna+04tDZHVS2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/9N3AoE7LzyRrGLnjj9Jk/QPe11sqCpBuTyGjcqZPk=;
 b=jh/PFKbzE5D6Hh5PwSOGUlwAA+gfVFeQbZ0UO8XQk75J9HmkJXmAOVXGkCoUCzz1CQPvjZgkmd9Kd7E3ESmKU2LSSkLuI7a3BzeCp1IhDKFz9hLg2PZoVwcKq/4sepQMwDUKtoYzI+2Cqzsl25W1nOMlaq5JhlB1u4OgPJ0cUYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM5PR12MB2536.namprd12.prod.outlook.com (2603:10b6:4:b3::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 23 Feb
 2022 10:05:56 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432%2]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 10:05:56 +0000
Message-ID: <4ca9ba48-20f0-84d5-6a38-11f9d4c7a028@amd.com>
Date:   Wed, 23 Feb 2022 15:35:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH][RFC] sched: Stop searching for idle cpu if the LLC domain
 is overloaded
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Barry Song <21cnbao@gmail.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
References: <20220207034013.599214-1-yu.c.chen@intel.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220207034013.599214-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::10) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c106176-f580-4a18-40eb-08d9f6b41529
X-MS-TrafficTypeDiagnostic: DM5PR12MB2536:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB25362D69B16E1C2AD9093B5A983C9@DM5PR12MB2536.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spG+mBQHh2iUQukFfhHmTIgCvkiGie0yO+q4rCybAtKPxpUW5gVnDjH2zy2S/FoT0+/4DQSGZCtFWfhcMIwBrtC5gkv6KR+y6+P2pCVzPJ+w3w8oURUvLrDzKanBBRhxIIQP4Mdso3B30eBS31UgEX0xwdp7aFR855uF1BATyoSwNxKHY/sV/Nr5zxYitQEac9R+BsSEn9aLfPezXa4IOn1WY3g6LpU7wZBRZxHVWbAUFAD3IhIvXaDaw7VldqGKpXVnFvufey7Ph/yK0IT7GbblgXynusEtwR5vj3m906zzBDAXI+ClQvzplTvv08CqJHmwv6FQdKmM1HV1MlVA8kxZlhi0P0qMiauF74QGVwZmfXFMXgKzhsW9IqvrWb6hxEimjoYLVo9+HdJgjTyIXXOjeEEsX87ttPNZwGRXJ3UYAjOkx5LfzvvVVf0jGj31WgN1QyigR5xoqLUKVwM0RAFF2MNOsb1wmSAI+7h/zZ06v3C/nrMJaRxXJ5FrBzT2Z3YkJhgSZ0mY5bfKysqseo8pJqH6eWJxQdnCooHeVQP3x7MtFzsROzBzvz0e6iBzsncjcOyzfDiHu70fmjMzvZALBh36lIAm6ySKO0SHGvORIvZ4uA5B7bhhofwQVBcmUkJ/gTE2VOPUKNh50ESS2xkVD0O0YHcQ5PBxYzacRXzYgEEqTJc8aquwiPqSfleWlbgtOYFYAOyl5OHBP1p1mXcQcObUowhzNzm2kvm3OQ5txIL6pI2ZH/gTLouQvi6o2JZzYdX1sv2nL+6Z+zPuFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(2906002)(86362001)(31696002)(53546011)(54906003)(2616005)(6506007)(316002)(6486002)(36756003)(4326008)(5660300002)(31686004)(8676002)(7416002)(8936002)(66556008)(66946007)(6916009)(6666004)(6512007)(186003)(66476007)(508600001)(26005)(51383001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGNXWEd3b3ZYcTlnSHl3MWtybVI3c2R5WXZlN0J4dDdzZHAzRWxRYmw0WXJx?=
 =?utf-8?B?aDlaOEVVYzVIVUtjTkFCZXlNclU3bVNMWllOMTI4NzFsejJ3UndrVzZtZmZV?=
 =?utf-8?B?ZWV1ZEwrdHRKSm5VTDVPZVVFeUE1YVdaM0dJQ3dEWEptWXh1Sjc5dGhvRFJX?=
 =?utf-8?B?S3grcnUrRWM4SkV1bXVFZzUwZzNXQ0lSSEJuaDVNOTNFdkdHMjdVTUJHREFw?=
 =?utf-8?B?bzdpK2ZiTWlIRmltVUQvdnJGbmdwOWF4Q0IvWjVmWGsyZlZ2RUNHRUhxU1BP?=
 =?utf-8?B?SkZycHNuQnd4TzFKdHpGQTI3YjUzalM4dHZrL3RBWnFKbTZUYlhBeEVYdTQ3?=
 =?utf-8?B?STJWMTJwTVAxQ0Noc0Qzc1hmUVZYZWxuUzJPRnk3bjhObGZsM01vRWxJZ3VM?=
 =?utf-8?B?aGp2czlqa1VlS1Z2TWprdk5Ma2JGcE4vTlF4L25pbDk0Tk5XNWRhTjIvWGRa?=
 =?utf-8?B?ZlJQbjJiSUltSzhTMmRBOUtjaUU3TlNQS1FicXVzNGpPaStYZFRvbElSV3N1?=
 =?utf-8?B?dFR2NGhaRGhKejJoTU9nN1FiWCtFV21VKzUvRm5VN2N0MWlyZWlZeGJqbXo3?=
 =?utf-8?B?NWdIeUlGUnVyVC94VEhoWTBYb0hHWDdSREJCUHJuNmZEaStIOGNGZDJ2aDFt?=
 =?utf-8?B?WllacjZSY1NMSmgvN1l6VnRGVU1EQStURmtPalQremVtL0NxZmxyb3lMcmZI?=
 =?utf-8?B?T2pEQmpJakJ6aStwYWlMOFd4ZDd6UmlnbXpRWkdRcmludWtVQ0tWNUUyN1pE?=
 =?utf-8?B?NXlXVmRmNXVWU2N2MDBEWVNnNEt3eWhOSWM1NnpRRTdOOCtjS2VFR2lmQXNN?=
 =?utf-8?B?T2VMaG5aMWQxOVVzSko2OFJXZ2tSNzRtSUtVc3lBZWV6WE5YZTVhSisrWlli?=
 =?utf-8?B?eXRpL3JpUjhnWngwcnFKck82dVRpUjhFU05meVFQN0QwTDgwU0xaUHFGN3dR?=
 =?utf-8?B?R0NkWjRZa0lmb1g3ZGVhcDdaOThWZlJvSDVpNzdJWW9zeVhuS3gycllWSnFH?=
 =?utf-8?B?YzhWN3UyOEZUT2VFdlUxc1B2bTdGbVFmTHdJVmVja1AvTEpkNVMyL1BhTjFT?=
 =?utf-8?B?Q2ZGdTZJeWEyd1lzaEVHUGxGYTJHYVM2cWRwL3BPK1RkMFZGNmxLMzFGZ2dK?=
 =?utf-8?B?SGN3WkQvQThtNDVoeDhmRzl3ZlVYWEdSZnY5RE5jcGhuY3RBR3lDOUt4V2pm?=
 =?utf-8?B?T3N4T1ZYU3YxcWN2andWUFpvNzdWZkY3anNXR2pobnFPcjNDWEF0ZFhUbVJY?=
 =?utf-8?B?cGlsVkFLS3dtOWR2N0J6MnlCOWQ1NHAvT1MvS0hnYmNmRDBPN0o4WWlvY0VC?=
 =?utf-8?B?TzV0MndrZkVBTHlVb3NaS3dqUXlPNzFQRE5SUE9TVDVsZnY4WndYR0t2YmQ1?=
 =?utf-8?B?aDQ2NGk0M1l1bzd1dHFCckpvblhFK2RmdEJFdTVLbENKUDJYYWxhV1d5WmdQ?=
 =?utf-8?B?U2xpdlJ0Q215a1JCakdPTjg3cW0rM2IvVHgyODRWSjVSc2Q0RFlzV1VFd1lC?=
 =?utf-8?B?K1A1NFJRbnhSYlNHZnlHR0wrVlEwNXlFOTE4bUEvaEFzS21HamZLYjdjMFVC?=
 =?utf-8?B?dmFOdG1VS2QvRkpLN2NLVWduSUlrYmZ4bDdORTdwSk9HVlN5eGJLcTlKcldB?=
 =?utf-8?B?S2Z4WTdFODVKMzJKZmVBd1lIUlFPckttc2hYMzBzTHg3b2hURVNwQVVFTlEw?=
 =?utf-8?B?T0MyakJVTlIwZEx2UkduZUxXeHhhVTJBNjhtWWxSSHNlRnBPdm1ib2hJaDIx?=
 =?utf-8?B?Z29KTmRzNlJuRE5wTzM3UmJ5ZkM0QnAvWTJCOFRBVDVITHdiR2FnWnJqaGZ5?=
 =?utf-8?B?VkoyQXpiTEZ2VzVUVWJibEp6V2pscUxFNnIydnNEUG5LRXhRK2pNb2czcWlJ?=
 =?utf-8?B?RTQrd2N4b0JuRmpmTmU3bHVDZXJRSklSY1ZzbFhuQmRvaVo4a0FCMk14dXpV?=
 =?utf-8?B?KytYQWVYaXFyQ21WM29KU244TnNRTFp3bXA0VWIvd3BmckxlVzBTZ0piNDdo?=
 =?utf-8?B?OHk5Z3BnMUcrQjE4MU8rM24rZW9nQ01BMHZjOW5kUnBSaEFXTFhmenBLRHFh?=
 =?utf-8?B?WnRvbWpuSjFTUk9sdzlncys2c1RIbENvcVBGOExlL0VuaG9RUER0ZnZtdVNx?=
 =?utf-8?B?ME94TlU0MDJ3RmNabnJJWXZla3dURk54bE82YlRkYm1JcjNHeE1KUVlIZStm?=
 =?utf-8?Q?mk9DLzixjBB0pW6BqDauTI0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c106176-f580-4a18-40eb-08d9f6b41529
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 10:05:56.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXm4rGvoRJ2VysrhiC7vYxwgyufItCq1DDvHAORoipgkV0s1oqDlUZR/mLp/Jj4k2X3qVe1mD7zAhlZATP4S+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2536
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

On 2/7/2022 9:10 AM, Chen Yu wrote:
> [Problem Statement]
> Searching for an idle cpu/core in a LLC domain is time consuming
> when the LLC domain is relatively busy. Even worse, it is possible
> that after iterating the whole LLC domain, it might still
> fail to find an idle cpu/core.

We tested the patch running some standard benchmark on a dual
socket AMD Zen3 system (2 x 64C/128T). Following are the results
comparing the results seen on tip/sched/core (sched-tip) and
tip/sched/core + this patch (util-avg)

~~~~~~~~~
hackbench
~~~~~~~~~

NPS Mode - NPS1
Test:                   sched-tip                util-avg
 1-groups:         4.97 (0.00 pct)         5.06 (-1.81 pct)
 2-groups:         5.71 (0.00 pct)         5.65 (1.05 pct)
 4-groups:         6.33 (0.00 pct)         6.22 (1.73 pct)
 8-groups:         7.93 (0.00 pct)         7.77 (2.01 pct)
16-groups:        12.35 (0.00 pct)        11.75 (4.85 pct)

NPS Mode - NPS2
Test:                   sched-tip                util-avg
 1-groups:         4.87 (0.00 pct)         4.97 (-2.05 pct)
 2-groups:         5.43 (0.00 pct)         5.39 (0.73 pct)
 4-groups:         6.07 (0.00 pct)         5.94 (2.14 pct)
 8-groups:         7.46 (0.00 pct)         7.39 (0.93 pct)
16-groups:        10.27 (0.00 pct)        10.07 (1.94 pct)

NPS Mode - NPS4
Test:                   sched-tip                util-avg
 1-groups:         4.87 (0.00 pct)         4.89 (-0.41 pct)
 2-groups:         5.40 (0.00 pct)         5.48 (-1.48 pct)
 4-groups:         6.15 (0.00 pct)         6.17 (-0.32 pct)
 8-groups:         7.63 (0.00 pct)         7.53 (1.31 pct)
16-groups:        10.24 (0.00 pct)         9.89 (3.41 pct)

~~~~~~~~
schbench
~~~~~~~~

NPS Mode - NPS1
#workers:       sched-tip                util-avg
  1:      13.00 (0.00 pct)        14.50 (-11.53 pct)
  2:      31.50 (0.00 pct)        34.00 (-7.93 pct)
  4:      43.50 (0.00 pct)        37.50 (13.79 pct)
  8:      56.00 (0.00 pct)        50.50 (9.82 pct)
 16:      69.50 (0.00 pct)        68.50 (1.43 pct)
 32:     107.00 (0.00 pct)       106.50 (0.46 pct)
 64:     191.00 (0.00 pct)       191.50 (-0.26 pct)
128:     413.50 (0.00 pct)       408.50 (1.20 pct)
256:     950.00 (0.00 pct)       947.00 (0.31 pct)
512:     60352.00 (0.00 pct)     60288.00 (0.10 pct)

NPS Mode - NPS2
#workers:       sched-tip              util-avg
  1:      11.50 (0.00 pct)        11.00 (4.34 pct)
  2:      26.00 (0.00 pct)        30.00 (-15.38 pct)
  4:      36.00 (0.00 pct)        39.00 (-8.33 pct)
  8:      57.50 (0.00 pct)        49.50 (13.91 pct)
 16:      68.50 (0.00 pct)        69.00 (-0.72 pct)
 32:     105.50 (0.00 pct)       104.50 (0.94 pct)
 64:     192.50 (0.00 pct)       189.50 (1.55 pct)
128:     403.50 (0.00 pct)       430.00 (-6.56 pct)
256:     945.00 (0.00 pct)       957.00 (-1.26 pct)
512:     60288.00 (0.00 pct)     60224.00 (0.10 pct)

NPS Mode - NPS4
#workers:      sched-tip               util-avg
  1:      12.50 (0.00 pct)        11.50 (8.00 pct)
  2:      29.00 (0.00 pct)        23.00 (20.68 pct)
  4:      28.50 (0.00 pct)        29.50 (-3.50 pct)
  8:      45.00 (0.00 pct)        46.50 (-3.33 pct)
 16:      74.00 (0.00 pct)        84.00 (-13.51 pct)
 32:     110.50 (0.00 pct)       108.50 (1.80 pct)
 64:     198.00 (0.00 pct)       191.50 (3.28 pct)
128:     434.00 (0.00 pct)       418.00 (3.68 pct)
256:     964.00 (0.00 pct)       952.00 (1.24 pct)
512:     60352.00 (0.00 pct)     60352.00 (0.00 pct)

~~~~~~
tbench
~~~~~~

NPS Mode - NPS1
Clients:        sched-tip               util-avg
    1    475.40 (0.00 pct)       480.46 (1.06 pct)
    2    939.62 (0.00 pct)       929.13 (-1.11 pct)
    4    1767.75 (0.00 pct)      1798.94 (1.76 pct)
    8    3315.70 (0.00 pct)      3231.78 (-2.53 pct)
   16    5887.79 (0.00 pct)      6037.36 (2.54 pct)
   32    10202.20 (0.00 pct)     10223.65 (0.21 pct)
   64    16816.42 (0.00 pct)     17122.40 (1.81 pct)
  128    28423.90 (0.00 pct)     28680.46 (0.90 pct)
  256    26726.29 (0.00 pct)     52502.83 (96.44 pct)
  512    53082.43 (0.00 pct)     53635.54 (1.04 pct)
 1024    52940.64 (0.00 pct)     53051.05 (0.20 pct)

NPS Mode - NPS2
Clients:        sched-tip               util-avg
    1    481.84 (0.00 pct)       479.67 (-0.45 pct)
    2    941.13 (0.00 pct)       927.93 (-1.40 pct)
    4    1797.61 (0.00 pct)      1770.86 (-1.48 pct)
    8    3353.37 (0.00 pct)      3360.29 (0.20 pct)
   16    5779.49 (0.00 pct)      5925.27 (2.52 pct)
   32    10810.27 (0.00 pct)     10855.17 (0.41 pct)
   64    17046.83 (0.00 pct)     17457.64 (2.40 pct)
  128    28799.32 (0.00 pct)     28855.49 (0.19 pct)
  256    27654.49 (0.00 pct)     47126.18 (70.41 pct)
  512    51831.52 (0.00 pct)     51219.55 (-1.18 pct)
 1024    52579.87 (0.00 pct)     50213.68 (-4.50 pct)

NPS Mode - NPS4
Clients:        sched-tip               util-avg
    1    474.08 (0.00 pct)       478.40 (0.91 pct)
    2    928.23 (0.00 pct)       937.76 (1.02 pct)
    4    1754.78 (0.00 pct)      1741.17 (-0.77 pct)
    8    3219.31 (0.00 pct)      3318.00 (3.06 pct)
   16    5791.53 (0.00 pct)      5687.78 (-1.79 pct)
   32    9810.76 (0.00 pct)      10866.32 (10.75 pct)
   64    17098.46 (0.00 pct)     17203.60 (0.61 pct)
  128    28575.94 (0.00 pct)     28020.97 (-1.94 pct)
  256    25997.38 (0.00 pct)     47735.83 (83.61 pct)
  512    47698.94 (0.00 pct)     48220.54 (1.09 pct)
 1024    51451.30 (0.00 pct)     50455.47 (-1.93 pct)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Stream with 16 threads.
built with -DSTREAM_ARRAY_SIZE=128000000, -DNTIMES=10
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NPS Mode - NPS1
Test:           sched-tip                   util-avg
 Copy:   175278.66 (0.00 pct)    147847.67 (-15.64 pct)
Scale:   193235.46 (0.00 pct)    186582.76 (-3.44 pct)
  Add:   220232.14 (0.00 pct)    208519.22 (-5.31 pct)
Triad:   215526.78 (0.00 pct)    204975.14 (-4.89 pct)

NPS Mode - NPS2
Test:           sched-tip                    util-avg
 Copy:   166600.09 (0.00 pct)    146456.45 (-12.09 pct)
Scale:   190820.84 (0.00 pct)    179603.16 (-5.87 pct)
  Add:   214660.01 (0.00 pct)    198636.00 (-7.46 pct)
Triad:   210879.10 (0.00 pct)    196132.74 (-6.99 pct)

NPS Mode - NPS4
Test:           sched-tip                    util-avg
 Copy:   173888.83 (0.00 pct)    180948.16 (4.05 pct)
Scale:   193027.03 (0.00 pct)    199330.65 (3.26 pct)
  Add:   218731.48 (0.00 pct)    221743.63 (1.37 pct)
Triad:   214651.06 (0.00 pct)    218036.35 (1.57 pct)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Stream with 16 threads.
built with -DSTREAM_ARRAY_SIZE=128000000, -DNTIMES=100
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NPS Mode - NPS1
Test:           sched-tip                    util-avg
 Copy:   222954.79 (0.00 pct)    219066.70 (-1.74 pct)
Scale:   208255.97 (0.00 pct)    215060.20 (3.26 pct)
  Add:   247694.16 (0.00 pct)    262893.33 (6.13 pct)
Triad:   236060.27 (0.00 pct)    250188.38 (5.98 pct)

NPS Mode - NPS2
Test:           sched-tip                   util-avg
 Copy:   226147.92 (0.00 pct)    228438.70 (1.01 pct)
Scale:   214059.09 (0.00 pct)    215959.36 (0.88 pct)
  Add:   264978.05 (0.00 pct)    270058.63 (1.91 pct)
Triad:   253095.73 (0.00 pct)    257466.31 (1.72 pct)

NPS Mode - NPS4
Test:           sched-tip                   util-avg
 Copy:   223484.37 (0.00 pct)    266929.80 (19.44 pct)
Scale:   224198.90 (0.00 pct)    235316.80 (4.95 pct)
  Add:   272008.98 (0.00 pct)    294452.15 (8.25 pct)
Triad:   258219.64 (0.00 pct)    285935.30 (10.73 pct)
--

We see great results in case of tbench with 256 workers when the
system is fully loaded which is exactly the kind of scenario this
patch optimizes for. Hackbench too shows improvements, especially
in the case of 16-groups.
--
Thanks and Regards,
Prateek
