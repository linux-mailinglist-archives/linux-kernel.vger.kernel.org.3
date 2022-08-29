Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D331D5A419D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiH2DzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH2DzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:55:13 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFF3175B5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gG4g3DBEBqje5Seiq3AzPYMgUqZ7eENuwgX7cWQdAg2LeY8EcFKkalMPLB+adHZy7z0V/EfDc7C6ADrao0IgF32GjzAHlwQ6rPZmUTqpn/AvNPTPq/mNuOgBbw51rlH3g+fg7Nqe94vfXpPSq0JAz7Hkpp95wJl4S7LidPyUgr8DGhqf3c46UD5/Vi/2Y+i9qamdPFB8kmkox5CiHCbuypgt7M64LDTnRr1vh5cowUGn3Qq10sXw/s8NYDrf78CvruvKYu6s2RL2dT5Z5/3uBSB8u4TasQBx3Oy33oX0HFsgC96Yv76pmdZwKSlcJjUPbDEG9tPYFBDZlfQXmMrnkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gruvyYFGgVvDKidtPvGbRRM7teNwhS+9elJnuW/o5uM=;
 b=IdxZmoslqpsj7XynlFyiVd0z8I0Wt5tE+OtoILhG0lLzox7N3bWThB4tkHhMqfhPkI74NneBsRYlQm7G6it4sRgMrmgkzsS9f9Q6B4yEx/WWkSG+7XorqzAokc+hn6Sq6OLu5lpyPKE/izJ9fIUiOHlTQrZcXxvM11hgcQqnNeNP9yTWyDufhd7Em0oGvDL3FLXDl5rkVdooT/G49/FsleCIv3Nbr3ps2tD7xnfJ84jwU0NyCWsqe0oYRpvg3Lbvmffv/zwgw2aFVtPIq5ZPelcdF9SfAIAy/lnXbhlnsj7NsifExUHTrJnP8F55IIaRMhZX1JR3UgpCL3yZ+GPJjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gruvyYFGgVvDKidtPvGbRRM7teNwhS+9elJnuW/o5uM=;
 b=L8POqeokwVEF4HXp4H6ng9m993K4VqzcD7ICMIw17gV9n3CIZXwM1jTWSfa0z11rL/p854ILmwg0PfhHTWdjILhCCITlPzTxRYUJXuLAY0MGxbgqIfYakLWcnzPKQTO/4/E15wgb2j8sXssj11WFMTTb9WaXCS4j/Y0X7dOvM8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM4PR12MB5215.namprd12.prod.outlook.com (2603:10b6:5:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 03:55:09 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d058:d925:c09b:de2]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d058:d925:c09b:de2%5]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 03:55:08 +0000
Message-ID: <5e69c472-b9d4-3813-70a4-f0d8bbaa14d3@amd.com>
Date:   Mon, 29 Aug 2022 09:24:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC v2] perf: Rewrite core context handling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, mark.rutland@arm.com, megha.dey@intel.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        kim.phillips@amd.com, linux-kernel@vger.kernel.org,
        santosh.shukla@amd.com, Sandipan Das <sandipan.das@amd.com>,
        ravi.bangoria@amd.com
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
 <YqdL8LsOvxNqhz/v@hirez.programming.kicks-ass.net>
 <f994d403-df7b-d88e-8324-c29d0ef2034e@amd.com>
 <YwOgxhfS99Rquwct@worktop.programming.kicks-ass.net>
 <YwOkFqqxONtoGImZ@worktop.programming.kicks-ass.net>
 <fb28c31f-c531-4be3-e9c9-d324451d79d5@amd.com>
 <c43751d6-8e85-28af-2cc5-4b90afea855a@amd.com>
Content-Language: en-US
In-Reply-To: <c43751d6-8e85-28af-2cc5-4b90afea855a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0130.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::19) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd159fd9-3550-4904-a55e-08da897243eb
X-MS-TrafficTypeDiagnostic: DM4PR12MB5215:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5HepLZH9Uh3+KQXIqbeDwNraTIGzfgoeNBuIvOIdU5HzmObJsVI5R3lkEzcw6X48TIzTQHTXmhUYrfVWaVcKYqf4XAbPIWwGN9CoI/l4643Q6vy4JDMpgU6svjgkzoJ+el4wB5tWP/eoMEf5J/s6x3XGdFa/QyZWxnuS7BvXiVD85ADulqESCbW/mWMCU7bUbe0yWkDRJ9KqCjonID4pEPy24rzHMjd8WAE0M/OePdC/8MKSPAc8jIow9u0YZYEcvvNEYT8Xnw9wJDBmo4vUemR3eLAn5WV56/LWCL4lo9UAkL2kJpt4LloOGp/mDEnPuUSC2ebUeypNHO4Vy1SmmwisqtJ6Slvzwz1zEkv2JtuouUuuitqAvHjDMN3qztmrKVrOSw4PbkgboCrN26PlqZQOwbnmh3XzKQYW5UdsHjuBcd1YVS/Hcx7Odi/jMbjoPBcmwlg0EvlMKhOL23G8lHIbDcA6/PJ58PM5aZjPVYIoP4ZDmYcC/yCZmrYoag7x+va1wdgTDo5CEix7GQ7s7PQv3z+gfCJwbNtxXBO2vbEt7YlcfCcFAuGcMXzSzb2CqPTzwuSSIMq09B/mQezr+WfTbV7aC5d1SArSxUAotUbpApiY2hfKtL+fPS4/qqIN1u6fC7YVY2f83fYqOBiuOMcpfInKZwth+BveaCkqodfzxo7P+BqQmVAGVJSvG6qBXCE/MJQKVLDKn1E/izrSiIUc4AFbgVa8KVROijiMzIuKVlf1whqMchD18ZzoGboh96RC38uFDahDfjEfsq07CA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(86362001)(31696002)(4326008)(8676002)(66946007)(66476007)(66556008)(41300700001)(7416002)(478600001)(5660300002)(6486002)(8936002)(38100700002)(316002)(6916009)(186003)(2616005)(4744005)(6512007)(6506007)(83380400001)(53546011)(44832011)(6666004)(2906002)(26005)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enBVdXhWSDZKUXA0c0pYVExKaFkzcWYvYXBIZGlUUTVMOXgvZmI0SWVuOXRJ?=
 =?utf-8?B?UGhaTFlGMnFaR3JqZ1Z4UFFrM0VUSng4ZW1BbVB6S2tVcTJIdGJoc2tvbitp?=
 =?utf-8?B?aXI4clZDVnIwYTBjaG03ZU9kSGFLR1NCVFVOdWtETHFOSXRDbGtMT282YUE3?=
 =?utf-8?B?Q3I5d3RSUDJqTzRLZW9xMnY2cklCQVBFSEREOWtKMlU0bzZlOWtyQmgrNlRC?=
 =?utf-8?B?TCtPdmtQODFxaTZCVFVFNHk5bUd2Zm8yODhVdDM2RkNSd1VKSjlOV1dVaW5T?=
 =?utf-8?B?dnJ3WDlISVQ4R2lKQi9KOGxlVVdhWUt1VDNqTDVUQ01hMmJkd2ZWN2RkeERX?=
 =?utf-8?B?M1IwbllnSDZCbGdoT1dueFhSWmcxV3JXb0ZHVlhFS3dobFhOcVBWZXhvVGE1?=
 =?utf-8?B?VExmYVM5dU5zaWZQYmlEMDd1KzBCR29FL3VCOXlndDk5UVdBTUJKb2hYU0ha?=
 =?utf-8?B?bDNRNW44SnRDcDBGUWpSSm1yZHhLUkFPVWQ2aU9YZjRnODdZcElEbGZMV1hL?=
 =?utf-8?B?L3pMdjFlUldKazA5c1FrNHhXTjBud2pBbkw2Q2p5WG96eWx2Z0dnRTlxeHRq?=
 =?utf-8?B?UFlUL0p2Y1N3WWhvSExQOHNQaERtVFRrNHpxR1pxUFZxeFRqVmI0V21Tc0Vv?=
 =?utf-8?B?UmpyVEhvSjRTL2RkMzU1YVBWMk9RRGhzTWYzTmNZbFN1eFhBbFZVMm5EbHdi?=
 =?utf-8?B?TVpJcXBlNFJVY3VSeHZiQXZhdGZFaFJRUGJNV0JxODZxS24ycHVVTDdHMUtn?=
 =?utf-8?B?UDlxVDNMUjl6N3htOGNGZzdUWXdjZ1B3MmllZnhsNjNRZjNabmh2V240QVl1?=
 =?utf-8?B?dkM4SDFwYzFVK2dhSXFDODl3UlN6WjMxSmRlNUtTMlRZR1JwQ3pIeFozZ096?=
 =?utf-8?B?aEdKN2RVQUJLekZjYkcrai9Yc0dQZURvMm9ZTDlNcjd2NmVTMllqeldPNkZV?=
 =?utf-8?B?WjVxaVpLRlZBUHVXZkdLQ2piQ0xQTXdDQ3BmVWx5RTM4V1paU0QwQXZ5dVds?=
 =?utf-8?B?WWg3NEYvaHZ6QWJDRDRQcFFwT1dwRkNJSnNWRHhaeUdsWEgyYzV1dzhsNFF6?=
 =?utf-8?B?NlBVY2MzNEQ2aXNWZkNuQlpTc2dzMHhodXB0SVpLc3ZBNWVEaFFIVjQvZlpC?=
 =?utf-8?B?U3JjS2pBUjlOZWhUUGg3eWJIVVp1NkhyVUs0TU9XTXhnSzYrZ2YwR2lXK2Fx?=
 =?utf-8?B?UERuWGZVTFMvMGUwdHdNNGJ6eG9XSzEzWjREdGhmYndJM01IdjY0ajNQa3Ez?=
 =?utf-8?B?ZzNOc005VGwrZUZCSzhicXhWNnN1ZVFZWFZPNTIrOVFHN0hlcXFYM0x5aDFP?=
 =?utf-8?B?b0p3aVpCYVN3dTgwQ1NSLzk3NGFsUzdFRTQ1b0p2NGRSM05zVXVUNU5Qb0Iw?=
 =?utf-8?B?aXJJZURIM05YbzhBcjJyWXFwdERwMHcweUNveEhjWUVpcEZ6Y3lIeWRSRlFM?=
 =?utf-8?B?M09ZY2oyOWFoUFhxZXdUeUU2K2dOR0xDS3BkMURXb0xDWkRCWnd1Rjc2dWRP?=
 =?utf-8?B?S25RbXJ6U0t2aHlVR2ZRc3MyRVF3L1ZXM0JVUjlRTFI3eGU5d29ZRThYVnB6?=
 =?utf-8?B?L1FBOFVSNk92Ri9ETVd1bk53MmRjQmhLbkdOQ08yUkRiREZ3RXZwMFNqUWVa?=
 =?utf-8?B?ZTQrck9Vc2dGaitOUFZlUm85d1FhTGdhSTU1Tmo3Uk5YcG1GZDVGQUcxR1Zp?=
 =?utf-8?B?cXdHb0F6cUVVWnlkTEFMaWRYRStvRzBCYitKL3pkR1pPUTk4cnhMYjl4ZFgx?=
 =?utf-8?B?ZldzRGluZ1prV3I4UVNrZTQ5ampybXhIenNGZkZ1a3BHK2FzTG1SeWJTREVS?=
 =?utf-8?B?ZlkrQVB1bkdFUFR0QXhWKzVmbFJFM2l4WFB3VkFlRDZDNkFBQVh1bE9HanJF?=
 =?utf-8?B?Ym5lRmdTQVdYTkdzWHRIYS95UHJSU0hXNWlvVnJvZmdJaVNTWWkrcUdvbExB?=
 =?utf-8?B?ZDNpemVIYlYvQzJqS0I4ZC9lb2ErUUtlK2tCMFBpbGZxZ0psVEdERElzVVdv?=
 =?utf-8?B?dmIrcHFhMEFydnh5ZytTcXpud093Mm9ESWllanlDQUNRZk9SazQ3MHcyTHk5?=
 =?utf-8?B?UEhkOGNlOWRXNUdyWHRtQTFwL2VTNENTNFdmd3JWdkxSRmVyRmNnMldXa1pS?=
 =?utf-8?Q?Jssq0Czyn7QPcM1MwS6eKEBcY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd159fd9-3550-4904-a55e-08da897243eb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 03:55:08.8889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ogx+vi9HK0cCPtlQJ5ZhRl9RGSBzE/NEgla/EHp7qVyS/yqNKqCiIbRy4PVRJ9DaoVLYy3zOxmUqTI6UodH+Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-Aug-22 9:50 AM, Ravi Bangoria wrote:
> 
>> With this, I can run 'perf test' and perf_event_tests without any error in
>> dmesg. I'll run perf fuzzer over night and see if it reports any issue.
> 
> I hit kernel crash with fuzzer. I'm yet to debug it. Here is the trace:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000198
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 48 PID: 0 Comm: swapper/48 Not tainted 6.0.0-rc1-perf-event-context-peter-queue+ #153
>   Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS 2.7.3 03/31/2022
>   RIP: 0010:x86_pmu_enable_event+0x3c/0x120

I was able to reproduce this with vanilla v6.0-rc2 kernel.

Thanks,
Ravi
