Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E8B4CCC59
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 04:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbiCDDq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 22:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiCDDqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 22:46:24 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2075.outbound.protection.outlook.com [40.107.95.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6A517128A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 19:45:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbIlonBI61he1EJKkXNyIb3CluPe1ZexnQLOMxSDtYtU1ykPqDPqdAyIMLmDnTooHT/Y4NZafUiZcTB8dLetB0l7/iIIhLHMUDQB0AbPgcBHxemhtw10lYxER9f35ziS2zr4nR5f0eunro1RP71VjOTKv8Gk/nOoecNf1INPZqvDJQKgbmymhZ1fi2I6vhyAI23MwTDiTWP+KKImToXx3wpV4w9QyJeXEw4lDh586TYhLdHNNppVrneUcKh2fIduHhoIeuC8/btb0NKNe2xGSMrdxLaEMfRGil65msqYfXZwLed0OFAYLlzaJh4a9kAOF65TL311aGyAiRX2en4nVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUUonELMPbEWoCFdCvMq5yEmGO05p98t7wXpUricpK4=;
 b=BzcnPGlU0aHbxh/wZb2LjQgRZJ7smTJJj3/5YCAET7tt5UHYTW5/ThLaC+gGAoA0FvReoF+4Kk7Fam27gw3x0OxKcY4hY/l0tjsE52z3l2SQtSrGmUDolYCETD/azBTe6kUF66mQn/9faJDz/3UvRNwA57IYkqPBX4HNvyma/TMiuzSWPuq/4+t6q+XpugCUviszlqanW+Neoac47W4k3ox4+7xmyMepb4/nRGbG6zTSu4XGbdX/TwK1eGYaPwqBSv7EdwNlpYXm0v1PuIplXQvZYsf6TBYO+UNLUG9X+LVP7+BuKzZjHi7ZiJ7HPD01UD11nh+18beeHUDjmrTJNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUUonELMPbEWoCFdCvMq5yEmGO05p98t7wXpUricpK4=;
 b=u2EYTUQUBWEa9zKKN23aOQt5+Ngih0KfoMS6b180Wi7YnUwtflMtYc5KJVQ5v1GipyuZHZF1Cq2MA+qTUmzhbBCXeJlVVuZ9LQLD92x6Amark1hRtE8bQ+bVgs3Qw6PuVdKQ+r6OBcBM4FE6qf5Z/FnViQHml2CXxBJsC1RSeqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by BL0PR12MB2337.namprd12.prod.outlook.com (2603:10b6:207:45::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Fri, 4 Mar
 2022 03:45:30 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::a094:81bc:148a:fc38]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::a094:81bc:148a:fc38%5]) with mapi id 15.20.5017.026; Fri, 4 Mar 2022
 03:45:30 +0000
Message-ID: <579e0023-09b8-8fae-355f-7182e7c8214f@amd.com>
Date:   Fri, 4 Mar 2022 09:15:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     peterz@infradead.org, aubrey.li@linux.intel.com, efault@gmx.de,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
References: <20220222102133.2956-1-kprateek.nayak@amd.com>
 <20220222132722.GC4423@techsingularity.net>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220222132722.GC4423@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR0101CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::27) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d936d39c-7b58-4017-2a82-08d9fd916d39
X-MS-TrafficTypeDiagnostic: BL0PR12MB2337:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB23377CD7CB26C65EDB53643698059@BL0PR12MB2337.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpQpK1zrrLkGgX3HYVSe8oE8C1LO9QKwEVpUzgbkXnCLqrqa6dumQTjGwUEVHgjz6PJHIaacOuk24X9C7yfOGHPw06/uTLu9XXi5w/1aL1O3EhV7xHJ8E3NrYiqg4Yix0t4TKIBM1jD8tA+hGqvVhZ/yx/VZNoHlixiV/RU3XeDvGQNJel2nMVZeFDq8nX9U+UPITbHQLfbLId7emXE0gsJQA61LRiOHLjd2q3rEBzWxdXjR4EbluPTSYVpKJ0xBcqxo29oc+TO9EUnGcBv0fzgaT7XhdkpfkGu3X8COmQha5gtknPWdHsFWB0CSjQM9k4GwWWP4nCoE6v9aSy427atpIJEvk2549Dgnd0VfPPvFPt5we3/A4GqbJSZ2cVyuAVPzax/yfJW23jAZNxh86WlGHai5hKbIqjb6ZfAjb9zmkk4gNlBgVtigLIzLkikFjWw8lz2YuEzSkDWzoiRCqlQnIqYJP3acsZHlZ9o3hDuKQIzEVY+X2Y71DR9txHauWSpMHT0kcsBAXn9bq1jSPcn8U7RJlJ7OQJf36TZbWJmLsTTbor4Zv4nWU/9eIcUHSZtMvVmUkdwTochoisymWRSGx43a/82Fqhq+lVCjeaNGHQDCidj9afyZsiTpXSyiH0asFgaGjsZ8daSoK8YgOhuEZ5Ii4QWyponXLvIQE7OrmSwp/lm4PZqsnqSo0efDJU7GAlpqUSo1VJq+8GcmQTd8mVsRJfLeSdsqEBsHdXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(4326008)(5660300002)(66476007)(8676002)(26005)(66556008)(7416002)(8936002)(38100700002)(2906002)(66946007)(36756003)(4744005)(2616005)(6512007)(6666004)(53546011)(316002)(6916009)(6506007)(83380400001)(31696002)(86362001)(6486002)(508600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFlLN3Y4K3NVZnk3K1FEUCsvOG0wbEhUOW1KN1pjN2ZNQkYycWZ4UHFTMDNU?=
 =?utf-8?B?SnBuSXRieXk3eDBseGZSMUFpZnhLcUNlMVRaZitneVFPS0VPdmQ3ZG1YYmpu?=
 =?utf-8?B?L2lIT0dLbkFWQnVpRWFXbXdDVzBqYWhBMktKYzV0ZkVRU0xvM2t4bEdORWt0?=
 =?utf-8?B?S3lDWWh4cG4wNEVDTEVIbitZOEx6a08rV3phdW5GNVg3QzU3bWFacXBNdlgx?=
 =?utf-8?B?dTgwYURvaDl6djFPNnduTENjZUdpS042MFdSNjdsdlJlOVlUR0JIbUgyVE1K?=
 =?utf-8?B?eWJCYkNWK2RDTUIyVmNLUzJZZitWOHpKN1RVa0grUlluQVp5U1MzVS9Jc2tp?=
 =?utf-8?B?ZGRPd0dPL2ZsRm9idkgxcEhLaFd6RCs0R2owS3NBUk5DYkppT200bEtiblpW?=
 =?utf-8?B?eDQyYnd2eTY1aXJ3TGJsRU5wNE9qOGNnSlZyKzNzdUdqbXNLcXZDZ2Q1ands?=
 =?utf-8?B?dWxQRXorUis5cHJuOWFVNE9HZVkxMlhVZDVZNmkrOEZyUUFDckkvWUR0WGdU?=
 =?utf-8?B?YWt1WnBFcjQwRUt1WFYrU3luMXl6NDJ1TmlUR1dPRFRjMXdLY3JmYy9KN1NY?=
 =?utf-8?B?cVlDZzhzQjJ4YncyUkJuY2crUFpUQUtPSEloUDhEZG9RUk51VmY2WmhPclB0?=
 =?utf-8?B?VmtIdXEwVlI5UzFXd2d6MkVOZEtZTlFYekJMVTZZVGYxQllPaWxmZjZNYjFH?=
 =?utf-8?B?c1FHQ1NwUURCMmpCZDlJNURxSm52V1lXWm5JbnA1b0Y2RGprRkx3YnRxVDNt?=
 =?utf-8?B?ZFl5Wm45SUlrdmoxeCtwdm4xQzBEWjRiTmw5VFBSMklFVm5Vc2Q1MUd4WUdk?=
 =?utf-8?B?SU8xS3E3KzZEOEwzRkE3cFd4ZWFCb29QTzNpak0zT3pRU2U1TTNCTlN5N1o3?=
 =?utf-8?B?eS91dGkvMEVjamd0QlV0Sjd5dEZ3SG9OMWlLNlp5S1RlMmFONko4WHBnTlJH?=
 =?utf-8?B?L242K0YrZDVUZk5GN1NpSW03dXpEeFh2WE1PZnhNcDltQjQxQnU0cVJqRUlY?=
 =?utf-8?B?YVcvMEExYnFRRHI1dWk3OXpHdE1WWlFMeEdDcjlxZ2V2NFNWazBjdEJBMjh6?=
 =?utf-8?B?TXFHR0ZjemdaZFlGeHdVUytmTDREL3A3aThMSjRyVnRkeWFmV2FNTi9mOCtU?=
 =?utf-8?B?Q3pBN0h6QzFvM2pvQ1B3cGhqRC9uOXBvREdOeFNZdnJ2VmNiSkQrNkhTd0ds?=
 =?utf-8?B?cENQdEJSbUJVNTNvQlRQU2RiN2RudlRNRFBXZ1hFUlhQc0pPM0UrUld3QTNh?=
 =?utf-8?B?MnVqSHVtb0FhTEZPM2ovcy9COTBWVWtwQnQxOGI0cjI1WVRYeEEvNXI4QW8r?=
 =?utf-8?B?NVJBd1lMMFlNQ09vZWZxSnVyS1JkTkl2Z3RsTUxrUDIwZzlZQ1lWTi9OSWF3?=
 =?utf-8?B?U3ZXbGpRMUkzTlkyQXA4cnVlSnZzQ3I1RUJkYi9zaGIzVStjRlExZmtKTjhu?=
 =?utf-8?B?dTdYT1lQT2R0M3NoZ2k1SmhSSW55MEJTc050aDBmcVRNaitBVWN3V29pMDFp?=
 =?utf-8?B?ZWkxVzFIQVVRSzJ0Q2ZmOFkybUFuTE9USEZ6cmJQOXJFMlBhK1NkL1d0SDFJ?=
 =?utf-8?B?Yjc2Vy9xOXQvWElrL1NlZ1hyRDdPbWU4MVVBMzR3azh1NGRLSFVmWXVOZTNY?=
 =?utf-8?B?M2R0UGZjNzZwQkZWK1p0aUViZFZwbTFZSUJVVkZQV0VGRUw0bWdGdzluMGJw?=
 =?utf-8?B?K3k4TnFYaWxvY3FveFRaR0gvTTUzcWN4TlpBK0s2cUJmY1dhVSs4MGRvWGQr?=
 =?utf-8?B?N1NtRlUySERaeTFIYWNvQUIxMFhzOFQ1SlI1M3czQ3BoVERaVTM1Q2t5MnRL?=
 =?utf-8?B?RmxIRFNTVkhhN2x3Z3BNajdCVWtIOEhHNTdra2FHTWcrWk5qckhTZEI0bnFp?=
 =?utf-8?B?N0tpUzNvcjQ4b0NRQkM5VU84VXlmemFiVWRRam1icmxUQllGemxtczduQUha?=
 =?utf-8?B?TmtsQVhzOHpvM1g0QnVxOWZ2TzZYR0hQSTZ5NlVLc0w3bjhTTDZSNXhPYnJ1?=
 =?utf-8?B?S1p0c0FaeVBFVmw2ZE5VQlFxeU52RmN2OFpOZXNpMStMeFRjQVpqaHRNVWFE?=
 =?utf-8?B?T2dZK0xBSFBDVTA3RVRZRTkweWpkWTMzRW9GbSsrZ2VGdUZVZU9GU1lTbGpR?=
 =?utf-8?B?VjFrUWpBOGEwdTdCN0diR3hGZXdKK2J0VHdlS20xejlBZm1jL0lnRDloazk2?=
 =?utf-8?Q?1QQ6tROjhHrOho8pyHB8jCg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d936d39c-7b58-4017-2a82-08d9fd916d39
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 03:45:29.9652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5wJdlFnMbDguGYQ/sc+XALfXUDUxDFfcbVHZYkJljnouJtOvJdKhGFNZ8N17tiorYRLQnE/NnbSvFueSIgM4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2337
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mel,

On 2/22/2022 6:57 PM, Mel Gorman wrote:
> [..snip..]
> Only minor nit would that the cpumask can be declared within the if
> block to limit scope but that is just being picky so
Small oversight on my part. I'll wait for Peter's response on the
same and create a v6 if necessary.
Peter, any thoughts?
> Acked-by: Mel Gorman <mgorman@techsingularity.net>

Thanks for the ack :)

--
Thanks and Regards,
Prateek

