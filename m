Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716A159C1BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbiHVOko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbiHVOkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:40:39 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916F4357C2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggHd0yhPzCTmx9HAhvBMaJtv09YRl23aTTvqSy7genLfKkOd66WMlGg/v6R2xyFBLgfcddn+hknxeuUqibc5xJPjZUkHWXwJVgocyriA0ZCC3J0ObLwS+tLC9lrIodPWIL7Vd39GyPGB6RYACKaGQ6bejPSMfFtk3TS6qoaXjY7wHSn84c0PWkJGclYz2ZK29AfBFntpiKxg/LXuw1YWbBdecfq4EgKxb+XOTqYChiiEZvEDc1XfqeL0xDN0HcMjjAiCIstmOv/zLiTr5UB+KZJOvBdwi5hnydpOOyOx/3w/H2WfoH24hTQCWI/bUw9rrjOMC5s1QAmn8Apywqjn4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IvblF0aInwJkiGz9Z2M2neUv4YTobxJ8nLcFNlnFtY=;
 b=I0P4PYCG0P2Ywup5Qg2ziPjQgrtzqB3Sp6nO+gtIZYnAcYh8NvPFu+npLY+6Jc6Rdv1m3CCaJ7hJtrGkejoT1zk6gba3CVXbzGFCLKiFwoY/BABi+nXjuOT0ySCK58ufLesakhGwcTpvhYxJpRWDy0AB0OebOM2LtuGR9saj9esYesKk5EeMfGAhPXCSmPmd5SlMjDeKXt1Is0GHTjSZiWVBEiEdTyJEZxi0y0r8dqvh1WJpCxJVWYR6BfqOJa5+HhkGaXWONkp2PlOlhHBOPR8o26L6+FbHuM6j2r2I+9Q489Ef3wfeWMd3zFpXcV5VOp9vVLbGhlva6nWDHaSIGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IvblF0aInwJkiGz9Z2M2neUv4YTobxJ8nLcFNlnFtY=;
 b=B0fT8z0pfbmBLz1/rGSPuAtwbhqvx1nrXfcpWnmnlf4KjHwXNhMbhjMV8XYMnzX9p4/9J6Hq8eTfZtKZK6BbB+OgQQ2VziUTWJGr6ziuvRgbjTxBBiYEwLR3rblVfC1ucdwvmmCLBZSpkmeBroBAm86hX0gVW03HJ8A/rjm1qtE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MW2PR12MB2491.namprd12.prod.outlook.com (2603:10b6:907:f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 14:40:35 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::7d11:1ba2:dab0:bae3]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::7d11:1ba2:dab0:bae3%4]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 14:40:35 +0000
Message-ID: <3da17219-afab-0a1d-88a8-f571f2cde5e4@amd.com>
Date:   Mon, 22 Aug 2022 20:10:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC v2] perf: Rewrite core context handling
To:     peterz@infradead.org
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, mark.rutland@arm.com, megha.dey@intel.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        kim.phillips@amd.com, linux-kernel@vger.kernel.org,
        santosh.shukla@amd.com, ravi.bangoria@amd.com
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
Content-Language: en-US
In-Reply-To: <20220113134743.1292-1-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::7) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eef88bc2-fbc4-4510-8b21-08da844c4584
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Biv5mFiyD02THyhj4vdNWM9+6kzfjLJkAu8BgLl/JvB33llpjnOC5F0+ciqm93dkknF0QDIFLxAlq10XTVM9RmBtGyQYkmrx+W90UVYm2uPWAfDQxvnYzo+QiwgXnlcAqgV/R/sYgWgC+lUCA8ANLPiBEe7EneIDBAIeHJsP+S/F7FnVE5eE7TYvghk8IR1IEozEguTe6NpKsIk/iuS9jxxNIm0oRC5HUJpVIOgsM3xy9cQzcXt5DcP03wBUuUXmfOHBfap/XzvIh26G5B9FER5KxFfL3YMzsieWG3J76G0gtivROPFP+32Tjvh2Zmoez/yDr3gQWoEg7vpBqgT9zsNiutBkeSKLehvmb0qo5ovvnp2gNGwi8lfbRYiPy6M1UqzX1vD03WXcPUk4hd7ZqAc7NMmyPBZQnt3dVjx2fBYpIdHQoAD8FkG/eN8WSax8b70Z40kaWnnZsMcL9MiHX4q0a2edyAQlcnkLqe6248E/bnsTnbgwUO8EidswMLo9eI6Wb4sHbBOiW7bRaJxpbz0dzDj1Brme/wA1gMkSvWJMfbeFN/VBuSuSPVugVvc50DbqZyIWUo7kzweigTkHBsSxZDV/l8ed4EBTUUnc3kTfhtEy5VaFOJ3B8IvFCL+IprJtDrhBGG0WNgTyLv3LeJhpQRkmXneHoMx3gUFPrpwmzXe9GzF+15G6YdoppLRCEbF2CcMupK/Ip49c9INvTYbWml2MRaucehBoOkD8Ej5tLhZDWMVVdAYcNvVCp67CY4EX5BfkiRsQzjK+orUr7RIIvE8oRz6qqgUZ+EqbN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(31696002)(38100700002)(2906002)(478600001)(6486002)(4326008)(8936002)(8676002)(66556008)(66476007)(66946007)(6916009)(316002)(2616005)(186003)(41300700001)(7416002)(6666004)(5660300002)(6512007)(44832011)(4744005)(86362001)(31686004)(26005)(6506007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTlUb1R3VXl4WmRBMFQ4eXc1NnhtcU4weFc3RHNpMlgrZ0g5YmhtV0cyQ1Vi?=
 =?utf-8?B?Wkl0eHk0dVQxR0hhckpMWjI5WmF5c0JuU3dFRGgxQ3oyZGh6L25wWnlpdExo?=
 =?utf-8?B?Z1BraUVqTVNiamNPRFVJenlicmVkbmN6ZTM4N1N0VXdLeU9VcjAwYjM1SXpt?=
 =?utf-8?B?TVhIc1MwR2tYUmlDeDhXbWhqYldYWlppTnZiMjVlRnZZQnlhaXkwS2NNeUFY?=
 =?utf-8?B?N2Nic2c1TWIrbVl6aUszKzNjK2E4TUg2amRUWXFCRkFoUG5pYTV3YXVmcHIx?=
 =?utf-8?B?V0M2ZmtKZTdqMnFwMzY3cHgrZEpseVpEQjhXNllxZHUvRDJqZXlPRFkzRnds?=
 =?utf-8?B?NnNxV1dWN1JFN1NWbGNQdHBjRE8xQkJtUE5BVkZzSzU3OXBVVUJDTnZObTB4?=
 =?utf-8?B?b0NzNE94U0lKd2JPN3NnSmp1RlljQnpEQ0c2Y0kxWEJnUFVFdlZMckFHdVBR?=
 =?utf-8?B?NGx0am5ud01MbjdQZnYvTG05YVFGWldxOTlkSDEzVElST3dVeEVUeUFET2Ja?=
 =?utf-8?B?UFB2cnJqZHhoNVRwV0gwUCs5UnhxKzBTMjZlV0JqbncrUi9kRXVEZFNZYkls?=
 =?utf-8?B?aFlQVTE4eW42bnpIbXhPd2dxVHZJaHJtUGRabFdoR2F2VFJVeU9wbVlaWnZp?=
 =?utf-8?B?b0FuaktGOWo2ZjZZSUwyeUNRbGpDTTBYK2xPRk9LUEE4cGJMVmJwdm9TT1Z2?=
 =?utf-8?B?RnF2T1VWUFBLbmpXNWRuQkwzRmpoZTNpZ0M4dHdKL3ZWN3BPdmVidXB3eXQ4?=
 =?utf-8?B?eVkvTTRoZ0k2bGhOYkJ3aFlwc05zQjJCUThrWDY1NXJweUJiaHRueGo0aTlh?=
 =?utf-8?B?TjhQMkRDWW1nVzRzd3V3cjdQa0N1RGd3ZHF1QVBGb2VvbHNIeHg1MGJPYnN1?=
 =?utf-8?B?TERjbVZRQ2l4ai9JZ3BJdlAvZ1VvQVJ3ZUtCZk1UbGlxUHN6YW5GeEFyT1VL?=
 =?utf-8?B?b2JoSEVhbmNtOEdlYVprVEd3UWdlaVRFSnpwUUdJaFBzK1MvTmVWTHk3SDFD?=
 =?utf-8?B?NE5yK1VXK1h1czJJczA4V2dmdDA2dnROV2NJZTRQZjkxZ2VMZVlpLzArV0wy?=
 =?utf-8?B?NkVudXh1d3BSV01ISGdMbTgvdDBJYTM0cVU2cWhlT2dKTFNhZGtCT0hiaHha?=
 =?utf-8?B?dUZJeDJHRVFxS2ZEZS96eVYrU2VsMGVXUW1yVTN1OWo3d0RPZ3NRU2tKNE5V?=
 =?utf-8?B?d1E0KzRXN2xxWDgzL3FyMmhHWmhhby9kYTdCZ2sweVNOam4wVm9VRnFIOWJM?=
 =?utf-8?B?MjlwMzEvT0xXR1UvcHo1d3BzQ2xiRnp5Ymo0Q3h5dWJEZlJsa0tjVmFZZHQv?=
 =?utf-8?B?SkV3WVlVUmxTa25zczk2aXhTQm9CMVpnODl3MlkvMHBIZU5sNysyVlh4SzdR?=
 =?utf-8?B?RzFGejd0L1h6bnl2bGpqSDNxYS9ZQXAwaW02eTdaL0tmSEZFNGYwK2lIUkZ2?=
 =?utf-8?B?UndvTFpoT054ZWxyZ0R3MVM2UXpQRjUvamJUK1FNQUVCK1YvbnVWaEdhQnlS?=
 =?utf-8?B?RW5hK2tmb0hLbGhIclJIVkRjcDdLT001V2VIdmZoM0NON05lMTVwaDVKYzJ2?=
 =?utf-8?B?UytLZlN2RVdEQ1ducVNEMlcvNXNRaDBtdmk1QVY3NHZaQzB3QmZ5aVNkQWlV?=
 =?utf-8?B?STJOdmR0amZ5K2h6QjNwTk51VGVWUUlFbWZEdm4wUkJzQ1F5YzI3T290OHE4?=
 =?utf-8?B?cFhTZ2x4ckg4azFyU1VweDk2ajlZRXBJRW1EdmxkRytDRm1VMDVSS3JHUEU1?=
 =?utf-8?B?b055UDdmcDQreklvcy9Ha3lJVnQ4NFJhWkVZZk1SOFI1VE1tL3pubFF3aThN?=
 =?utf-8?B?R2grbTU0dWJDczhiUElodDI2RlNoS1ptWnN5SFV6T1JEN25jOWVEOEtYTEJI?=
 =?utf-8?B?SXFCMXBLVG9TTFFWc3lFRWdYQjNhY09GREgxNjB1TXY1Q3F2b1hLOGpPRXNr?=
 =?utf-8?B?VmhtLzNENnlmOXo5cVBVVGV3M3piVVd0MWRyVW82cGFGQW1NckJKSWtwSi85?=
 =?utf-8?B?VVE0NUFlb0M3WlVwNkF4dmYyaXdUM3daWlM5b3gvWG1jNHZybWxEN2xoRlFm?=
 =?utf-8?B?TXlrdU1VSExZKzNNcnRBR25oZzZIcnBBcDd0RHRSbGYyQlQ4bUFkR2J4RG9s?=
 =?utf-8?Q?yfSXyhCl0YOE+7/iPe4t1RlE9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef88bc2-fbc4-4510-8b21-08da844c4584
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 14:40:34.9415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFDdaGEAQtUI08Qk9pHxrAK+6iJAUXfB4C/An05w7ieCxiuUwvhA5qfLUbn/FbKIA1mYXpbjE1ZE/AVg4tKOBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -915,7 +925,7 @@ static int perf_cgroup_ensure_storage(struct perf_event *event,
>  		heap_size++;
>  
>  	for_each_possible_cpu(cpu) {
> -		cpuctx = per_cpu_ptr(event->pmu->pmu_cpu_context, cpu);
> +		cpuctx = this_cpu_ptr(&cpu_context);

This should be fixed as well:

s/this_cpu_ptr(&cpu_context)/per_cpu_ptr(&cpu_context, cpu)/

Thanks,
Ravi
