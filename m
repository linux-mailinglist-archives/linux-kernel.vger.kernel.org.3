Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581214DC417
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 11:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbiCQKlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 06:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiCQKlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:41:08 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A817C1D4C16
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 03:39:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjbcmbO9sIaBeVP8KpF+Wo3mS1wYQ2shFkbcInqLlX8Pd1jv2XD6DaSExSHYYTO7JtsOMvxsVcdY4QqiZR1e2DQAjsKnbFarCJBolXXBlwC0sej8/e1NIEHkA8ePSz6XkOLvLj5q2LqBnXwYMtrHZjnO8FIVJ/W8zmSrnjlAuJc+ohqMOsz9uXC8j6cJJyoB39yOXQZlWCBNxoMJsQFUh67R2lBptHWQXSn1zC5MRv4wvkpg1pNMOD4ftOK4xyMd8In2UZdeK0jbUPsCJvCFra4f8EfRj3YtBwQPK/6IijheOI+0Jnxqb1mdfDsWqeFA+XzlI7eC9bsFX/Kp7PcaqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gA45woDXVqTabC/liSfLHbJNIKik0f76AzYMnwGjRA=;
 b=XVkwqpvhmdD57vpap2I2rTzXptoiXsKfzqS6REKg/op0/FgA0p+KYq7+swTo734x/xUSVHK4CzhI87P2Q0LYN/i8eghebVvDW+UjqCL7Z8NYL+lkpk7ipttezTbagno0UCFN+FlTo0h7XTsbr+L4iGOfaJq6z5nu7oT8LkuHajCAHaArLr7JVFq8i/IiRksKCrRASNJVr4xZLsRQl1Chemo2xvtrcS7LEL3J8clL04IBuH1UrjxGC0rKLvaHT/se3zwx8st1bhBwYN2U11invlUxmMgZ5mCattxnhyoPxMsuYVLyPg3CSGoeDIA0JNFDlGoc8kXBX6qNMH3xy2sUuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gA45woDXVqTabC/liSfLHbJNIKik0f76AzYMnwGjRA=;
 b=dmUdEWKf/wfjeoKtHDcmdbGopHyHZuarH44r+NzHk6KtDQts1o0O8WQh54+s4HtKArtyrrj24Myvh8XWIDaIh5XTp1yyEbFCFNrHzHtSt8RUqS3E8NaT1dw78QCAjwUPLl9vDeOUXtDC2+bUO5pJ6vWEVu8RB3cGCjfdQAdUr80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MN2PR12MB2942.namprd12.prod.outlook.com (2603:10b6:208:108::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Thu, 17 Mar
 2022 10:39:48 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::7446:3a0f:f807:f5b2]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::7446:3a0f:f807:f5b2%6]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 10:39:46 +0000
Message-ID: <9191110a-daf9-0520-a47a-801fa3f744d8@amd.com>
Date:   Thu, 17 Mar 2022 16:09:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2][RFC] sched/fair: Change SIS_PROP to search idle CPU
 based on sum of util_avg
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Barry Song <21cnbao@gmail.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Len Brown <len.brown@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Aubrey Li <aubrey.li@intel.com>
References: <20220310005228.11737-1-yu.c.chen@intel.com>
 <50315795-c2cf-fc1a-6698-752b0c26cb96@amd.com>
 <20220316115418.GA20589@chenyu5-mobl1>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220316115418.GA20589@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::16) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8981ff3-5467-4fee-c628-08da08027423
X-MS-TrafficTypeDiagnostic: MN2PR12MB2942:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB29426F71FDE2C831774CF1ED98129@MN2PR12MB2942.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: daZeeQL92ZDBLI0YMAiEnIoRY+NYmCCaqE8ZOJm+GpuGfv8eIexCuByXqkFoRB5KEOugWVX2o0AS43X4nVWnTR4bXnl8hPhZKmebBoIGJdm/p85hkuzyzgPLBc2gh3lrd+GpXCI3iX8MIH/a1Mr8Mj2EBFDlTbNn4n2zYTt24gA2u7DJa6yB+im5HxgB42jG3qYqSBAN7NguxeK+NJnMaPy7kg8tVaf7maOwDv/PigNCz7sZBtX9H2+IAKoDcqNLOSwD1y+rnAwTjwbPmnEp2buGqrpyAS1seCrD0M6kgqo94o1YSyJ1FydVMtctbEjMe5t030TekC/3DGLSSe4ReUpUi0u/0r1JgTw76hWiZIIFxZFRk2UpMxU+HtD6hIj5rYo4cLq1V/h61WHk+9UC6SQq0SmWUpFCT/EVWyuRrJOBtDn7ib1Ud0vYplPeS+/x5RqZUAxAPxfRWiqYFx7ZbTT3YbZVPN268WOM7alDiDodyeD8QhTwrrsPsytXkC0Pk1mhhxZD6LqJlU5Koly/2U1LIbUp0sUA55lSbDOnMrx/sfUrpzlpOEOC/etlDCJDXMP3K5T/XnBnnub/hq8eg/aTLVj1GAeksQHgocep5xFRJzsWqtJjMpTDgz1ujQ/LVlvYUapVlA8hT207MznPA/3jI8kwOsNDvlb9SnFHUdcPNjo6hpr89+a13xzxF/mThDRwB6WfhuG2ryCCZmR6Wwr8z0WP2QevGtHeUvgCEOnMHyhsE9BaiToGkmO0GZp4cySzJpki2bAfgKP0ojb2Hs3AA7GIDoHPOSPYXAwd8NVmL1MeDFP46gF5Rhg47Tvj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(83380400001)(6916009)(31686004)(54906003)(316002)(36756003)(966005)(8936002)(2906002)(6486002)(86362001)(66946007)(31696002)(8676002)(53546011)(6666004)(66556008)(26005)(186003)(66476007)(6506007)(4326008)(2616005)(38100700002)(508600001)(7416002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3VHallmajJpRlpNV2NhNC9mRVFmOUNlalFsVkZvZVlON2tpOTJWVUY0WFV2?=
 =?utf-8?B?VkE2aDBGSzcyK1lUc01Tb2tyVVo3WERYczRCZjVnQlB5OHVZWWRhVzFxbnlp?=
 =?utf-8?B?dXRCR2xyRDZzOXpnQytlTWxIR2ZxRjZWRGVIU2MwNGVSSVBQMVA3d3pHUDVw?=
 =?utf-8?B?NWpVTitsR0lmaUFEMnFmV0JyeUtXQ0JWQ3NaZ0pVUjBFb0xjVC9Ja1NHUDRX?=
 =?utf-8?B?Sk1uY0ppdjhJMC9YKzhYU1FGODNaNVBqRTdlNGJnaDRocHBXcThZMFNPYlRO?=
 =?utf-8?B?b1lNczhFOXExSmUwY2dTN3BHeHpGMDJBemJWMHpkdHh4M0RyY0FKOThCMGxQ?=
 =?utf-8?B?VUdSWVp0Si94Zks4d0Q5aHY0VzYyRWtYT2srUWlNOExJaEdLeE1tQmFNK3Rs?=
 =?utf-8?B?ZElGVW12ODFDbERETWhWdndLT3JiSFQwUVZrUDFYcDVWanFLZ3FSM0FxZGli?=
 =?utf-8?B?VXNMNlFob0dxa3Zxc1IyNyt5TDhlRjdOblZNVlhkQlB1dXdoemJRUklMQlVR?=
 =?utf-8?B?cjVmRU5YNTBqWXF1M28raVBYMG0ya0xMOURCWWVDZlpnWXFUWG9nQ3oxdDB6?=
 =?utf-8?B?ZnZYUEFlTC9UMzYzOWNvakU1Zy9lZDRZY0lNMExGSnNjTVhGUDNtWGo4cjVl?=
 =?utf-8?B?N3ZsQWhrQUk1UWJoK3FaN1EzQ2JtdGk2V1ZBMTZ0cnJxUGdMYTdWcVRXaVoz?=
 =?utf-8?B?Mm1zbmZ6a0djV2plTFpDM0ZrWHUrcGtRc203V1dOcTJDZ2hGYlZyQWhiTG5K?=
 =?utf-8?B?Q3cxOUw4RTN1WGIxUzU3cGVmZ0V5cDVVdFhjMm1aM1NnRDI2Y0hCRFQ4ZVgr?=
 =?utf-8?B?alNHd2J2TDdERXNmaTJWeEduM1RHSjMvdHJ0bTduZGV1T1NocU9UVS82c3Q5?=
 =?utf-8?B?Q0VWbGljZHJySWcxQnltZjNwM0lkY1BTWXJjUEV5eFl6aUtzWGh1L3lFdWZL?=
 =?utf-8?B?NmlJcU54R2xNNkg2NlN3Z2dkUXlCdm40VlkrZks4clRObzY0N2UzMWkwQ1VC?=
 =?utf-8?B?K2QvcHJrYkY2cmdkRE5oeHRwZ2QvSG1hUmtOdHFkWXpvaSs1OWhpTDVWRlZV?=
 =?utf-8?B?NEpBajJhcXNkWUFndEp0YkV4RDVGNWtYdUhPNFVvTTVGWDRFUFBkQkl1T21R?=
 =?utf-8?B?bjVEUVlsMmVwUUsyMXoxa3dYRnZUeU9YdWp6dlNGeDJJL09XZnR3VjNpdUg4?=
 =?utf-8?B?cmxYWExzUmFVVVpFZWZtR3RrL012R2F4TStxQ0RKUzlaa0t2ZTU5Q1R4VVZX?=
 =?utf-8?B?SXRGMFhCazMxeUhtSHlEVmg5VTU4clExVXhVclRKOVRVRzdFMkc0Vko2U0VD?=
 =?utf-8?B?TG43OStWcTNOZEdZaVdwdFh3enFpZlh6c2Z5eXVPOHgxQU1RRG1kazlJK0E1?=
 =?utf-8?B?aWo0MkJTS1UyQ1BzVkNOa0hsTkcvaG16MEFhMXF1aWM1aUloQWdpRko0R0RX?=
 =?utf-8?B?RkN4NVRYaHhJS1liY0twT2s5OHpRVENla0Uyc0hYMmw3ZENSSnBoRWZWRStp?=
 =?utf-8?B?NEFFVit4MklxYXF5MFBZVTcwS3Zrc1RjZ0VBUi9oVndrKzBRcUFZQzZRSXdV?=
 =?utf-8?B?Zm15bG9EeWdhWFVYNTlHbjk3ZEozL1FVVm9XRmFWaGRKRytDeGd5bTVxRXZG?=
 =?utf-8?B?RmZMTXdHdVduUmZPVmR0MDFSbmV0SjJqWXFpWGN4VVN4bytwTDFqWlJGSXov?=
 =?utf-8?B?bFRzVktDN2VkMXc3ZFkwRlN0R28vaGs1SENIZkFOTHpXVGJBaVQ4Y3p2RUpT?=
 =?utf-8?B?WUQ1WVJmcWQvWklVaTdrMmFFQlZwVGo2WGE1WVloSmIwKzNUN29lbzkrZ1Bp?=
 =?utf-8?B?TGJ1ZEhmT3dzTXViRHNOcGhRamIrTGRKMS9kdEY2MzAybFl6RVlSSlRFajFr?=
 =?utf-8?B?U3M5Vm01RkVWSVpTbC9DOHF4eTU1emhZQ3ZEdjN1bGtqZ0IvbUlZbFNtdi9J?=
 =?utf-8?Q?sYp8k0FMVEFdt1mDQGHYRxNZVi9wCVRn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8981ff3-5467-4fee-c628-08da08027423
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 10:39:46.2804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vU7nFU+MWVhZeCrdle6jcz7VXHkGDrxpONYfJLb9RdiwJJBhUe8ShBKY22eklNBptmeaTO3nS6v0Fye5KeYBnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2942
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

Thank you for looking into the results.

On 3/16/2022 5:24 PM, Chen Yu wrote:
> [..snip..]
> Just wonder what the kernel version was when you tested v1?
> https://lore.kernel.org/lkml/4ca9ba48-20f0-84d5-6a38-11f9d4c7a028@amd.com/
> It seems that there is slight performance difference between the old baseline
> and current 5.17-rc5 tip sched/core.
I'll make a point to include the HEAD commit from next time onward to
remove this ambiguity.

- While testing v1, the sched-tip was at:
  commit: 3624ba7b5e2a ("sched/numa-balancing: Move some document to make it consistent with the code")

- While testing v2, the sched-tip was at:
  commit: a0a7e453b502 ("sched/preempt: Tell about PREEMPT_DYNAMIC on kernel headers")
>> [..snip..]
>>
>> ~~~~~~~~
>> schbench
>> ~~~~~~~~
>>
>> NPS 1
>>
>> #workers:        sched-tip               v2_sis_prop
>>   1:      13.00 (0.00 pct)        14.50 (-11.53 pct)
>>   2:      31.50 (0.00 pct)        35.00 (-11.11 pct)
> It seems that in the old result:
> NPS Mode - NPS1
> #workers:       sched-tip                util-avg
>   1:      13.00 (0.00 pct)        14.50 (-11.53 pct)
>   2:      31.50 (0.00 pct)        34.00 (-7.93 pct)
> we still saw some downgradings. Although in the v1 patch,
> there is no logic change when the utilization is below 85%.
> I'm thinking of this might be deviation when the load is low.
> For example in v2 test of schbench, 3 cycles of testings were
> launched:
> case                load            baseline(std%)  compare%( std%)
> normal              1 mthread group  1.00 ( 17.92)  +19.23 ( 23.67)
> The standard deviation ratio is 23%, which seams to be relatively
> large. But consider that v2 patch has changed the logic of how aggressive
> we searching for a idle CPU, even in low utilization, this result
> needs to be evaluated.
We too see a lot of variation for schbench. For two worker case,
following is the data from 10 runs in NPS1 mode:

- sched-tip data

    Min           : 23.00
    Max           : 40.00
    Median        : 31.50
    AMean         : 30.50
    GMean         : 29.87
    HMean         : 29.25
    AMean Stddev  : 6.55
    GMean Stddev  : 6.59
    HMean Stddev  : 6.68
    AMean CoefVar : 21.49 pct
    GMean CoefVar : 22.05 pct
    HMean CoefVar : 22.85 pct

- v2_sis_prop data

    Min           : 22.00
    Max           : 41.00
    Median        : 35.00
    AMean         : 33.50
    GMean         : 32.84
    HMean         : 32.13
    AMean Stddev  : 6.64
    GMean Stddev  : 6.67
    HMean Stddev  : 6.79
    AMean CoefVar : 19.81 pct
    GMean CoefVar : 20.32 pct
    HMean CoefVar : 21.14 pct

The median of the data was reported previously.
> [..snip..]
>> ~~~~~~
>> tbench
>> ~~~~~~
>>
>> NPS 1
>>
>> Clients:          sched-tip              v2_sis_prop
>>     1    477.85 (0.00 pct)       470.68 (-1.50 pct)
>>     2    924.07 (0.00 pct)       910.82 (-1.43 pct)
>>     4    1778.95 (0.00 pct)      1743.64 (-1.98 pct)
>>     8    3244.81 (0.00 pct)      3200.35 (-1.37 pct)
>>    16    5837.06 (0.00 pct)      5808.36 (-0.49 pct)
>>    32    9339.33 (0.00 pct)      8648.03 (-7.40 pct)
>>    64    14761.19 (0.00 pct)     15803.13 (7.05 pct)
>>   128    27806.11 (0.00 pct)     27510.69 (-1.06 pct)
>>   256    35262.03 (0.00 pct)     34135.78 (-3.19 pct)
> The result from v1 patch:
> NPS Mode - NPS1
> Clients:        sched-tip               util-avg
> 256    26726.29 (0.00 pct)     52502.83 (96.44 pct)
>>   512    52459.78 (0.00 pct)     51630.53 (-1.58 pct)
>>  1024    52480.67 (0.00 pct)     52439.37 (-0.07 pct)
>>
>> NPS 2
>>
>> Clients:          sched-tip              v2_sis_prop
>>     1    478.98 (0.00 pct)       472.98 (-1.25 pct)
>>     2    930.52 (0.00 pct)       914.48 (-1.72 pct)
>>     4    1743.26 (0.00 pct)      1711.16 (-1.84 pct)
>>     8    3297.07 (0.00 pct)      3161.12 (-4.12 pct)
>>    16    5779.10 (0.00 pct)      5738.38 (-0.70 pct)
>>    32    10708.42 (0.00 pct)     10748.26 (0.37 pct)
>>    64    16965.21 (0.00 pct)     16894.42 (-0.41 pct)
>>   128    29152.49 (0.00 pct)     28287.31 (-2.96 pct)
>>   256    27408.75 (0.00 pct)     33680.59 (22.88 pct)
> The result from v1 patch:
> 256    27654.49 (0.00 pct)     47126.18 (70.41 pct)
>>   512    51453.64 (0.00 pct)     47546.87 (-7.59 pct)
>>  1024    52156.85 (0.00 pct)     51233.28 (-1.77 pct)
>>
>> NPS 4
>>
>> Clients:          sched-tip              v2_sis_prop
>>     1    480.29 (0.00 pct)       473.75 (-1.36 pct)
>>     2    940.23 (0.00 pct)       915.60 (-2.61 pct)
>>     4    1760.21 (0.00 pct)      1687.99 (-4.10 pct)
>>     8    3269.75 (0.00 pct)      3154.02 (-3.53 pct)
>>    16    5503.71 (0.00 pct)      5485.01 (-0.33 pct)
>>    32    10633.93 (0.00 pct)     10276.21 (-3.36 pct)
>>    64    16304.44 (0.00 pct)     15351.17 (-5.84 pct)
>>   128    26893.95 (0.00 pct)     25337.08 (-5.78 pct)
>>   256    24469.94 (0.00 pct)     32178.33 (31.50 pct)
> The result from v1 patch:
> 256    25997.38 (0.00 pct)     47735.83 (83.61 pct)
>
> In above three cases, v2 has smaller improvement compared to
> v1. In both v1 and v2, the improvement mainly comes from choosing
> previous running CPU as the target, when the system is busy. But
> v2 is more likely to choose a previous CPU than v1, because its
> threshold 50% is lower than 85% from v2. Then why v2 has less improvement
> than v1? It seems that v2 patch only changes the logic of SIS_PRO for
> single idle CPU searching, but not touches the idle Core searching.
> Meanwhile v1 limits both idle CPU and idle Core searching, and this
> might explain the extra benefit from v1 patch IMO.
Yes, this might be the case.
>> [..snip..]
>> ~~~~~~~~~~~~
>> ycsb-mongodb
>> ~~~~~~~~~~~~
>>
>> NPS1
>>
>> sched-tip:      304934.67 (var: 0.88)
>> v2_sis_prop:    301560.0  (var: 2.0)    (-1.1%)
>>
>> NPS2
>>
>> sched-tip:      303757.0 (var: 1.0)
>> v2_sis_prop:    302283.0 (var: 0.58)    (-0.48%)
>>
>> NPS4
>>
>> sched-tip:      308106.67 (var: 2.88)
>> v2_sis_prop:    302302.67 (var: 1.12)   (-1.88%)
>>
> May I know the average CPU utilization of this benchmark?
I don't have this data at hand. I'll get back to you soon with the data.
> [..snip..]
> I see. But we might have to make this per-LLC search generic, both for smaller
> size and bigger size. Current using exponential descent function could increase the
> number of CPUs to be searched when the system is not busy. I'll think about it
> and do some investigation.
It would indeed be great to have this work well for all LLC sizes.
Thank you for looking into it :)
--
Thanks and Regards,
Prateek
