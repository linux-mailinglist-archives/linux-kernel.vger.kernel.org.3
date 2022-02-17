Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95504B9E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 12:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239711AbiBQLY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 06:24:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiBQLY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 06:24:27 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC6E120EB1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 03:24:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEGcg7eDAakeItBIi2pgUu2kNP5S89dyuVdBZ1ONTp6bNBPum7Oq1LZykLBsWlwLiCGmQScqca5XaiheKz7Ad15J1SWSW6j5sL9x/a3Ct6do8WrU6DK+PPDwH0ky5dQDgX3j+X1KfULfwOb3d+v8D3KWjkBXd5Y4k18NI0GWYQXIvF++6uAswKK683OvTCdR12EjlyiAC2bkG+l/pSQ5yVFoCNdEk60661NEhPDAHwgnOe0odGVcfxUlYPDbXHDxgjJkonE5h53bAKuAIED0J9vKGdK+W7b9igbPzAsOUMxJVmNF3qEoTweO53+DF+tuQzK9wonkL7CJAAry168NNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Y/Mmd2+yb0HL39QEcc4lRX964659kpUpnrrkIwskSU=;
 b=IRMRfbFaAwGWqJqPDAvtgGcPBf4GND+5cjL0zcnld9qLlPf6Ssa7OaGcS+Lz0IY8j61gkQHC2msTvY36aDLV+iK7+6hZN5+NZ0Q7vda7jiS4b4X/gjjAwPVSSWfEfz4Qzj4QxzOQ0P99BJGq1b4SRki/Had6JBk3AZNs2TLcbdWbSitMeCwxo/dgy1URW4feWt4hRHvjEHnauYfMcp8zHSqphfVCW0D/VUiPHQJSECiiOGZW7JAlhubLwIy3k9FIq4rgMd6cHQ75A+m8zJa/mjcZkVpa8/1G32PkVyvUmJz8087f8wo0tTxZ4+Jd5TlYEDRTcV2WF7WJowCQaPOVsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Y/Mmd2+yb0HL39QEcc4lRX964659kpUpnrrkIwskSU=;
 b=PnwE4H6gODkk4JFosee+iX5CLi0C29tOCa/jqmfWilCQm36jlXRZDAYkV4ZGWPNGhi19abIoQVuE2awTn3InflAIGxEUEgF2I0voYs/Rktyu3Tk2o94X/6MeXaHEdb7+BrXDJhy3EkLhwV/U9uq1KvSWwpr/qMu+lIYNz1+Zk+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (52.132.180.152) by
 DM5PR12MB1610.namprd12.prod.outlook.com (10.172.33.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Thu, 17 Feb 2022 11:24:06 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::c90d:9f80:a049:b432%2]) with mapi id 15.20.4975.017; Thu, 17 Feb 2022
 11:24:06 +0000
Message-ID: <a57dbac2-1b8e-ea5c-8b6c-3a97ac186ad9@amd.com>
Date:   Thu, 17 Feb 2022 16:53:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     peterz@infradead.org, aubrey.li@linux.intel.com, efault@gmx.de,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
References: <20220217055408.28151-1-kprateek.nayak@amd.com>
 <20220217100523.GV3366@techsingularity.net>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220217100523.GV3366@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::11) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc818cf2-9fe5-4082-1ed6-08d9f2080232
X-MS-TrafficTypeDiagnostic: DM5PR12MB1610:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB16106852787388D5C86AFDF798369@DM5PR12MB1610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mOMZqRzZeAOnsDu78z9YlDdTFJ8pj7n/zNk5cRy+bH1J91ANIxNRKM4PYZvhWl7wgqMRWQWmn99o6ZcbbT84rrTD9/4S3CHWdvONjbKM8LsIU/4VzoTObpEnqwgQiHC2mhNYUhW/OPNMIDkarhJOoRPjT8UcaJHOlceojP9MGr+66+KXKa5jwy1z5g0/0SRJd0U8UOc/+7xwjtvH4g3EeSXDqe4Iy+413wA/Ni0lHv0fZvBUg0DEZ1ThTOmz+fg1G1iDX6UDx9oZds2pmKyD+9N9TwmNuXsgW1PLvzfeOgokm2hUx/NGneGWJ/K2J7ukW8NfidhbJ1Pdb0LK3gI/sYDC4F4EhkB5oW3R/mTRrDc1JIlrLCOkWrW8Nf476+gRIvO01y2sw2Na4z2RvkTROjCypDE2SXL/RuYFH2H3++le8O2vMsSMrZ+jz4BE98U39EiAca0bT+jUCCkRzmVStEH01TYrHi0nJGq7dqflyzWryuEQfdbZ8okMagGwgihryslhWCn2Dci+UMl+4733LJqlb2Um0FQ6ssqAYX66fgA77TeY+EA3ij/f2iXkveYMZ3Ih3pfhfL0gmL2rHlcbIELfouJJ8ZYR46rZw65gZPm/9YBBs2rL4VcaichCjhkk8C2AtYyY/yj+aMF2GI9jE9F9MhbSrk872b/S/S41ZMy+nqp4gA8JwBBrQkRFjfFLlqogSllyjJsSogPriShsMOVVlERdf4aWsMXKRTNYmVB9C/8pzNYhCSd/ttJ7gbTd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(86362001)(31686004)(36756003)(6916009)(316002)(6666004)(83380400001)(31696002)(6506007)(53546011)(5660300002)(8936002)(38100700002)(26005)(186003)(7416002)(6512007)(2616005)(508600001)(6486002)(66946007)(8676002)(66556008)(4326008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkhzK29INkQ0d0tkTW5PYXA1Sjk1a1JZekdKUlQ0dDc1RFhqa2tFbTZxUE9o?=
 =?utf-8?B?L2xOVDlHcFBLbnVaNVdsMk0zVkpqa1NyWUVHdElNN3hoMDN5ZWpmL2VHS2lr?=
 =?utf-8?B?TGphT3ZrLy9leGx2dmFZTmh5TVFiMnFCNTV6WWNrb3dSa2FJb01xdE9SQ3Y3?=
 =?utf-8?B?c3JhQUdtdWd3NUt2WTNtUGJseWRzYUNZVGZHMlVlUXB1NS9nc2I2Qm9PN1hL?=
 =?utf-8?B?eC96aGVWZ0ZwNkN5VXhmU25IRHgrMjl2YkdnVmVTbTBhQ1lkTFVUNVdZTHQ3?=
 =?utf-8?B?RHdtYkU3U2I5eG5UNVRiRWxZS2hpa0ZHOUwyVlI4c2JHZXVQMDgyVDdKNnNL?=
 =?utf-8?B?dmozcWpxQXFwaHBkaWg3UFo2Nnk4OGt5NGQxL000OXRZUy91NHV2YVZsUGZM?=
 =?utf-8?B?aFZxdjBnMUhPbFRIdS90amtsZTZlOFZlZzRxSVVMcEU3UDU0QllPQXpHOStz?=
 =?utf-8?B?N3dzZEwzZ0lTK0FMK0hkWHlmSmhNeGN0YUR2NndyaGliMTR5dGYrU2pNM3FQ?=
 =?utf-8?B?SFJ0Rm9QRmxPUGZqcXFyZ29YaWI2M3pUdk12YjdQSnRUeDlnUTlxTTd2ampr?=
 =?utf-8?B?eE9zNEI5bTRQeW9zTWtlcDFZWTZNRkxuNGthTWVtbXkvNmlwbGdhTVdyM0VB?=
 =?utf-8?B?OUdzYUhnSHR1ZU9hSmlzN0x6RU5sQlJEaE5Gd1hwcE9pWmc4WkxnOHZTZ3Bq?=
 =?utf-8?B?RlFzWVlOVHhLN0U0QzBadU9ScjdlSTZGWUZmVmNYOEJhUnM4RGt4RXAwdTVX?=
 =?utf-8?B?Zk56Vkwxb0F1SUZaNzZmREgzWjh6KzNydFBCejRRMERJbkowMklIS2FCZ0JT?=
 =?utf-8?B?dW9jcTg1aStTaCsrTExLR3V0UTNCcGFlcjB6UkRtbzdJbmk5NTJJWUg1aTQ2?=
 =?utf-8?B?WURLNEY3dndrUVBxWWlHclFoU1RCTzJSY1Y1U2g5M20zdUR0dlVUUmQ2NDZR?=
 =?utf-8?B?RzRWL1dwK0Nzb3BwWW9zQ0tiU1IzZ2pudEMycHZiZlMyRXlQWWkycnUzME1W?=
 =?utf-8?B?QU42VVlHbkJIUVBHZkZOaHJVOXFUTWVvUjZ0MXEyVDlodXB1VGpBYjJJZGt3?=
 =?utf-8?B?V0MwWFhtUGJrU1dzOXJnTHpjcGJ2Zk1JQVgxU3dyMVhrTm1OQ2oyNDQ4SlVW?=
 =?utf-8?B?dEdGWE5ROE1SQXJ4bThLYS8yQkpvWHVpeUF3cytYQktqdnRxdnUwVnZza2N6?=
 =?utf-8?B?TzhEcGI1Yk5JMXM4a2dIaDBoU2dGRXB3MnJZd1FaUFYwdVdzcXJxdWdSdkM5?=
 =?utf-8?B?Y1dRKzJwcm9lZlkyZmU0TGFwelBTRmJmRStUTmdwUFVSajQ0Y2RFMXN5TlZX?=
 =?utf-8?B?dkRNUDJERFM4MVNLSjNZOTVud0UxbUh0K2VDOFFnTU1IUGFKamNhaVczWWF1?=
 =?utf-8?B?cmRlRlpMaHlpNFlSTlF6Ynk5TFlDZXlBTGFqb0UzYktZMVc2T05jZ3BVaExS?=
 =?utf-8?B?YzFBQ01KSkEySlJCMmUra1U4Mk1zTklzWlZUb0crMlhXWVlQVE54NE5RRmFw?=
 =?utf-8?B?VXgyaFcwbXJub2RLSGtiQjRQWjNKNUJxSFBMZVRmYlRkUEtUanlNTkk5YUFy?=
 =?utf-8?B?WGsxL25Xd2tXTDlZYllyVi9VTHhRRHFxQ0thY0JkQitrL3Y3a3dvY3g4b3cw?=
 =?utf-8?B?T0VDczZJYnAyMEljWXNUTnFGc205d0N6Vm5GMC9zRGxMWWpXVWpHTzUydDJF?=
 =?utf-8?B?dVc0WHdLRlgrK25WdWwwOUJQcWswSHVVakFjNldQUmpKS2t2YzRIR256R0RI?=
 =?utf-8?B?UThqYVFQUERGMnIvbVVndm9NZXJCYmU5alYrRys3ZS9VUG9tRElVczZQY3lU?=
 =?utf-8?B?NzlnTXV3c3JnWTFIY3V3Y3hBVVpxTjhtbndJREk1dEpBRlVTcWgvMjIvUHNa?=
 =?utf-8?B?ZGxZdks0dWNvNHRsakRadGJzS2FlK0dadDEyYzNtR243RzF5SFNJMXVieGpn?=
 =?utf-8?B?L2lRbmlZd3dJRnQ4eUlYc1NaV3AyeGtoNENBVFBFTXdKOHVjaUsrUENWVWZn?=
 =?utf-8?B?SzlteFF3TkgrT0g4SzBOcXhnUjVFU1QvNW5ZZ2oxNyt1VXVmT3VkOTl2SkNT?=
 =?utf-8?B?T0tmQXRsV3ZEVHlnMkNXTDdETlhVZENnS1NaMTdmUktFV3Y3MTlWRmMwY0ZR?=
 =?utf-8?B?SFVVVmNlcnFCVFpQak5SRUZMaytZNi9lUCs5SE5BSlpIdkZWd0RJN1dLOWI3?=
 =?utf-8?Q?qIPUd7Poqq1gtzOgxWo98lY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc818cf2-9fe5-4082-1ed6-08d9f2080232
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 11:24:06.4822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSt8rm4aZqa11qk7fsi+rHhjwrzTxB3eFsvCbnMg+NDmBQOgiIjlQTlTbPvNtyag88x+IQxwn9EiGpwDy8mWdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1610
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


Thank you for looking into the patch.

On 2/17/2022 3:35 PM, Mel Gorman wrote:
> Thanks Prateek,
>
> On Thu, Feb 17, 2022 at 11:24:08AM +0530, K Prateek Nayak wrote:
>> [..snip..]
>>
>> Eg: numactl -C 0,16,32,48,64,80,96,112 ./stream8
>>
> In this case the stream threads can use any CPU of the subset, presumably
> this is parallelised with OpenMP without specifying spread or bind
> directives.
Yes it is parallelized using OpenMP without specifying any directive.
> [..snip..]
> One concern I have is that we incur a cpumask setup and cpumask_weight
> cost on every clone whether a restricted CPU mask is used or not.  Peter,
> is it acceptable to avoid the cpumask check if there is no restrictions
> on allowed cpus like this?
>
> 	imb = sd->imb_numa_nr;
> 	if (p->nr_cpus_allowed != num_online_cpus())
> 		struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>
> 		cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
> 		imb = min(cpumask_weight(cpus), imb);
> 	}
Can we optimize this further as:

	imb = sd->imb_numa_nr;
	if (unlikely(p->nr_cpus_allowed != num_online_cpus()))
		struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);

		cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
		imb = min(cpumask_weight(cpus), imb);
	}

As for most part, p->nr_cpus_allowed will be equal to num_online_cpus()
unless user has specifically pinned the task.

--
Thanks and Regards,
Prateek

