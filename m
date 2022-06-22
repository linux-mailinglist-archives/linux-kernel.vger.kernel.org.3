Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015D2554350
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiFVGhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiFVGhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:37:18 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2051.outbound.protection.outlook.com [40.107.96.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85775344D1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:37:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTehYuyTBKgaFMAQdzb068c4K7lOxCft6VKrjZDVhVYOaWlmkKkdylmVNFfuhw73ZoE4yE9JNuYCB+ZsMkH/02yWLpq/h3prmGonYsPNumktc+H4LfE9XoKmRAmRGWCRB37mSeXn8k5fsf8HuVe2KGi1omPM+V55S8HKIdwf7kINp4xFo19D1W389m0xhafHrpxSdfgImQ1l18NtEDCI+R80Dc9YYnCqlZPvUaPNdbNCc6WBQsiveG06Katdg0C+DLtIiTRBJDqM/siGd3z/cWqYAjGmu1VYTaTnRjfRr9rhddpK5ICuD+K5iEKB8ZNSs3WZ3d9LCjlRGqvEJSBO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93w8KZHooOm+OU10Mz7lAj6mb4GQJ4/jLvwayc8Y3uY=;
 b=h1zDNovLtVuMHXRXCLWC3JwItQl/rt+hbpZj1YBH09LZbNeK3jQDKxn57vrT6MkXWLT7nGpwhzsjELUDU1z70yuJJdWIPBs/yirl13K8L/aAdhhYg4kYF7yz+a33SJoS2W07H7Jye3nN6wXpnh9qOvSBtTtHqpW1ejtTdhgqAoXx35YiKoamzKQZ8odGPPYSPsAz2jRSk6ZgU67BCsC1CoLkQiCzsjZ1dBtm2wGEMCXLzWAZXDeNg8sTWZvh5FcjgFEUgV0VZgzgzoaDMwnqKGLg7uQdkbYx0ZIxPAoCR24mSW9iC4pAYynjYD2bzixjALwYDMW3zz+Yy0jhZfF/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93w8KZHooOm+OU10Mz7lAj6mb4GQJ4/jLvwayc8Y3uY=;
 b=ya0nmmEI53wZofl4REUNSOz+IYhfIE4b4F/ySVnCXgvrqgsd8Mu8QThZPBhSf2IeotobDuuQcaEQi+WAQQkX90BXB9NlkQNWQyidaaTFn4M4eTUsI8YtAYMU6L/NfvT1n7vy5SN5knp1AmZrtAHnDurYcTOAWUmF8MBPRfMA6uI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DM5PR1201MB2553.namprd12.prod.outlook.com (2603:10b6:3:eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Wed, 22 Jun
 2022 06:37:13 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::bc2c:1f18:f03d:895b]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::bc2c:1f18:f03d:895b%7]) with mapi id 15.20.5373.015; Wed, 22 Jun 2022
 06:37:12 +0000
Message-ID: <76c94a3b-6ca2-e0e2-c618-42b147d2737d@amd.com>
Date:   Wed, 22 Jun 2022 12:06:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4] sched/fair: Introduce SIS_UTIL to search idle CPU
 based on sum of util_avg
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Barry Song <21cnbao@gmail.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Len Brown <len.brown@intel.com>,
        Ben Segall <bsegall@google.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        Yicong Yang <yangyicong@hisilicon.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>
References: <20220612163428.849378-1-yu.c.chen@intel.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220612163428.849378-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::18) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd311b43-cca8-43c0-08b5-08da5419a392
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2553:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2553965BC232D0C7C969C5B298B29@DM5PR1201MB2553.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NXspDbjX1a3hHQXXRcnXoMVb6JOLhjSvadoM/KzGpRtwOUjpOG0/0pAUnnHiAiBDXbg+evOHVvfMh0jIvKukvkPAulSG9PM3TnAW2VO1dJCAa/BALaxR5dTFEDgechXtveswkeHJ+eUI3LYdRJ3PaQw/loZ7Sgzrp9my6zWdjNL3UuxmNZ/YkUJAcswL9mH12afyOmaq681ABRW2bKsEyGHkBqvdHG6rxy80GyqJIqJopi11MPB9kQ+rZemIUpGcYCVM+pMmkIHY2GERy3OmGzh/F9g//I4ZX7kz9O3QF2Kzi6PM72b5wVHTKImZlK+/j4eLpVVq7Y01wtJRI4WtHicr9fWFsGZRnUHhQLEav6n0eeTNstqllf5tzYcoxVS5HU81BYuzyj7czYc5MFB69bij6I4hMymPVCG2doZWOeZ3f6a+vVw5T0Oi3v00VbL0mNN+X0X1i54MMaFqdd7/qCRwPSX9JbOdlto9PD2nVYnDmryOQ6gW/XwfXl8GVN7VNzd44m6xh6E2LWoCqxBSQqItbhxVFJLmWoIEpqejF3HCDM9T56jXG98E1rIh+4zvlY2DhjiXebVCKaVhFTVoD/CQDmLOxrAWsF2NGK4da5JTCTybikLLu5nY4y7C4ZeZWBzBhiO99G8Mm5bW9+WnrkqoAnrG1sgcryIBZA0458kTqUIeD7fnEIHffgd8NT4v2Fwhd7gDasyXdW0do/SiynFC6ND6FWJ6OSYqP5NJWGVRgBYxUSbVYKW9WqMcP63u/TWafTzrw4sgUvMyTQn6CtgNNv3Gh+N6Kmn6eGzuK06Lh4aOLtfhEGKCdLFYhj/s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(186003)(83380400001)(38100700002)(41300700001)(7416002)(316002)(31686004)(26005)(36756003)(53546011)(6512007)(2616005)(2906002)(6506007)(31696002)(5660300002)(66556008)(478600001)(86362001)(54906003)(110136005)(8936002)(30864003)(6486002)(8676002)(66476007)(4326008)(6666004)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXZ4dEN5NWpDRDBGY2FRVmdJcDRaREtIWmYyNkZOblRDc3ZsZXZvWkpvbFpQ?=
 =?utf-8?B?SHBBVCtWYWllQU9mUHF2cUNCd21nV0xUMlhVZ1c1c2U0Y012d0cwcU5pd2dl?=
 =?utf-8?B?WnMxQmU1RHBSR0lBc2tjdGN4bXBiYXBkWitNTVBvbk5zQXQ1eVFFK0phVUx0?=
 =?utf-8?B?aHF6SEI5QVFwVEszVUZBclFRMkpNbkZZcHgvWnU4ekloUFNITUtjSGROUjlX?=
 =?utf-8?B?cjhjby80a1hJWVNvelNtOHdXSlFsUXFid1p0Y2g4L2FWdFJnYU4zL2VBSmxM?=
 =?utf-8?B?N0RBRW52Yk5KWGZUMGFGR1o1VWFEZ1dBNjhpcTZSbTNOTXJRUGJKemEvNmIx?=
 =?utf-8?B?ZGswTWpIU293WVc5QVIyOXgwQUFtL08vZXI3WTAwaDdpWlMxaURIZkgxa2Ux?=
 =?utf-8?B?RUUyTDhzRmliTlZnVXRaUjBpSDY5ZlVDQ3dTQTFybHNETTV2WXBTeGVoTjNM?=
 =?utf-8?B?UzRkcEhkRGVxZEtOak02Q3VDaE11a0hMUnJzQXBjWHUzTk5LaTBIUFd1cENH?=
 =?utf-8?B?dFpVMTNCL3JuTXZQelhxYnpmMndPTGZXNENjT3dod0JJWTVSS2tlKzR0dGNa?=
 =?utf-8?B?RlRmSCtCa0ZiWEJ1d3UzLzZ2bmhnRVViL1pYdHRIMTROQUZrS1lQYStKejh6?=
 =?utf-8?B?U3pjZnJMclhCWVpPVG9ITTNrMEc5MlR2c2N1L0FxR0VjeUloOXR3UHpEVjFR?=
 =?utf-8?B?cmt3WUFJWkduajN1NGlSdkRPSFR0VUFSaUxFY2pNL2c2K0Z6N21rSE11NDBN?=
 =?utf-8?B?dzBJYlRvZkVnMmFHRXYzdC9XMGRXc3U0MnFSL3FxUGtMU2FCSHVyeFFLWW0z?=
 =?utf-8?B?b01xNzB2UmZkTFJmb3Z5WE5MZCtvMllCTi9sb0NoNEs3OXg0Y0dZYXhETHlj?=
 =?utf-8?B?VzU0a2o2NTl2eUMvQXJNb3M5a2hXeTZ5T1lwMCs2Tlk0YW5UUlVhYVhsNWFs?=
 =?utf-8?B?eklrTXJ2bUpYMHo4Q2pqdVVQTEFHNjRNMStiK2dFOHB6c1p2cVNvVnZxVUhu?=
 =?utf-8?B?V1AwVlFQeUltWHdzVmhXR0hiZ2QzQld0Um9JQmpkTEtPNFpObXFqN3pRL2hR?=
 =?utf-8?B?WDcvblVRdkx1eGxET0c1VDV5ckd4NUQwOWFWZDhRelAvYjRRT3hmZ2JFelZE?=
 =?utf-8?B?QzhxZXJyd3hTemRsOXhpVXBwb1ZUdmxtdmhTUUVGZmppSmdDWVRkaTk1c1V0?=
 =?utf-8?B?bGVpTEo4Z1FUclJMeFlyRFFrNEdlY0ZpajRXUzRseHFSd1kycG1LUFNuZmd2?=
 =?utf-8?B?UHhtZHNWUEVPRFBBUGowVmpHRlY4ZEU0MVREQk5oMG1VT0pLamtmTHNiTHBV?=
 =?utf-8?B?Mys2ZXdsTG1zY21zdGJRenFqYnFNaDJnL2pNU3k1WG93YWhvck1JUU9WbFYr?=
 =?utf-8?B?RjhkSk5QbUh5NmhwQ2ZZOTV1b0JlbFdPSy9kU1dsYzg2Q2xtSjd3KzVoeEQw?=
 =?utf-8?B?ZThaNWs1T1ErV1N2eWFzaE9iaENPQ09EVTVBR3hwa2NFZzdhMDJnb0QxKzBF?=
 =?utf-8?B?MEoyWkNPVzJ3d3hnMjFnWXQwZ0ZqeFRlUU9NKzdZeGJjQytOQlluSm9OU3Uy?=
 =?utf-8?B?Qk80RWJjb214UFN3MnJncHduZEV0S2xubUJFeE5YcFlqR2NlZ1lqWndnazVD?=
 =?utf-8?B?Mm9qd2lGZUhtdHJNYVEreUJGSUQxN0FFYiswM3BBS1ZabGU2YzJRTTJSWXlS?=
 =?utf-8?B?MTJWWFdCVHdtbDR0dGE3SHAvQTlxdzlJd3YxQU9JN0JodktxSXc4ZDNtUThJ?=
 =?utf-8?B?Qk9tV1ZNRk4rMnlUTFhDRkpJVnYxaEdqQTdiTVZEeU1IZGhUVFU1ODc2MVNU?=
 =?utf-8?B?RUpmM3NrUFlTVDg0cTk3T0FydERLK2JHcjJqanVsK0JXZktsRnVtalZJa0dz?=
 =?utf-8?B?R21FNDF3UnFMVzY2NFFQQi9RcXlFc05mTGp0Q2NablVCWjA1WG9TZEphNHBu?=
 =?utf-8?B?VEdVcHNVWFM0MFJyK3ZBSHZaMnlSVjVPRXFyL05Gb1VualZqV1lUSCtiamJx?=
 =?utf-8?B?NFZjR3pJOTI3MUFxK1RYbzJpOW5XM3A5NXArUlFMaW1SNHV2S3lJL1dZSnZD?=
 =?utf-8?B?OWxjbnpyS1diM1hoemZXSEZMdnZFL0lvMFZ0RFV4QlRpVHVZRlNBU3BVQy83?=
 =?utf-8?B?d2s2QTVmd3ZuUWxCWDUzTDdpdCs2cjRZajNpbWZWSXhjcFpWTGlSR0hnUStT?=
 =?utf-8?B?Wkl6SElTNmRON2Z6WHhuK25sOXp0UmFIa1NtM0x2QUxzWlIvZ21aTS8xR2FK?=
 =?utf-8?B?aFgwMGZGUWJMbWQ4UXJ1S0xEbVNEUXR6Lzd1STQ4WUQwRXNWT0FKTWRYVS9S?=
 =?utf-8?B?aDZxeHRLZlRCZk1OeCtxR1BKUUk0SnNEcStHelVoYlNjekxiSWVMQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd311b43-cca8-43c0-08b5-08da5419a392
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 06:37:12.7143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nrc4yEsZZ0VfL+jcPT0An1CZ7nB74r+6MDkBYkDadRkbnnhUt+QWNOBNTPF3agkIU6MQZKvt+3+e7e2EzK/aSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2553
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

I'm sorry for the delay. The testing took a while but below are
the results from testing on our system.

tl;dr

o We ran all the tests with with SIS_PROP disabled.
o tbench reaches close to saturation early with 256 clients.
o schbench shows improvements for low worker counts.
o All other benchmark results seem comparable to tip.
  We don't see any serious regressions with v4.

I've added detailed benchmark results and some analysis below.

On 6/12/2022 10:04 PM, Chen Yu wrote:
> [Problem Statement]
> select_idle_cpu() might spend too much time searching for an idle CPU,
> when the system is overloaded.
> 
> The following histogram is the time spent in select_idle_cpu(),
> when running 224 instances of netperf on a system with 112 CPUs
> per LLC domain:
> 
> @usecs:
> [0]                  533 |                                                    |
> [1]                 5495 |                                                    |
> [2, 4)             12008 |                                                    |
> [4, 8)            239252 |                                                    |
> [8, 16)          4041924 |@@@@@@@@@@@@@@                                      |
> [16, 32)        12357398 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         |
> [32, 64)        14820255 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [64, 128)       13047682 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@       |
> [128, 256)       8235013 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@                        |
> [256, 512)       4507667 |@@@@@@@@@@@@@@@                                     |
> [512, 1K)        2600472 |@@@@@@@@@                                           |
> [1K, 2K)          927912 |@@@                                                 |
> [2K, 4K)          218720 |                                                    |
> [4K, 8K)           98161 |                                                    |
> [8K, 16K)          37722 |                                                    |
> [16K, 32K)          6715 |                                                    |
> [32K, 64K)           477 |                                                    |
> [64K, 128K)            7 |                                                    |
> 
> netperf latency usecs:
> =======
> case            	load    	    Lat_99th	    std%
> TCP_RR          	thread-224	      257.39	(  0.21)
> 
> The time spent in select_idle_cpu() is visible to netperf and might have a negative
> impact.
> 
> [Symptom analysis]
> The patch [1] from Mel Gorman has been applied to track the efficiency
> of select_idle_sibling. Copy the indicators here:
> 
> SIS Search Efficiency(se_eff%):
>         A ratio expressed as a percentage of runqueues scanned versus
>         idle CPUs found. A 100% efficiency indicates that the target,
>         prev or recent CPU of a task was idle at wakeup. The lower the
>         efficiency, the more runqueues were scanned before an idle CPU
>         was found.
> 
> SIS Domain Search Efficiency(dom_eff%):
>         Similar, except only for the slower SIS
> 	patch.
> 
> SIS Fast Success Rate(fast_rate%):
>         Percentage of SIS that used target, prev or
> 	recent CPUs.
> 
> SIS Success rate(success_rate%):
>         Percentage of scans that found an idle CPU.
> 
> The test is based on Aubrey's schedtests tool, including netperf, hackbench,
> schbench and tbench.
> 
> Test on vanilla kernel:
> schedstat_parse.py -f netperf_vanilla.log
> case	        load	    se_eff%	    dom_eff%	  fast_rate%	success_rate%
> TCP_RR	   28 threads	     99.978	      18.535	      99.995	     100.000
> TCP_RR	   56 threads	     99.397	       5.671	      99.964	     100.000
> TCP_RR	   84 threads	     21.721	       6.818	      73.632	     100.000
> TCP_RR	  112 threads	     12.500	       5.533	      59.000	     100.000
> TCP_RR	  140 threads	      8.524	       4.535	      49.020	     100.000
> TCP_RR	  168 threads	      6.438	       3.945	      40.309	      99.999
> TCP_RR	  196 threads	      5.397	       3.718	      32.320	      99.982
> TCP_RR	  224 threads	      4.874	       3.661	      25.775	      99.767
> UDP_RR	   28 threads	     99.988	      17.704	      99.997	     100.000
> UDP_RR	   56 threads	     99.528	       5.977	      99.970	     100.000
> UDP_RR	   84 threads	     24.219	       6.992	      76.479	     100.000
> UDP_RR	  112 threads	     13.907	       5.706	      62.538	     100.000
> UDP_RR	  140 threads	      9.408	       4.699	      52.519	     100.000
> UDP_RR	  168 threads	      7.095	       4.077	      44.352	     100.000
> UDP_RR	  196 threads	      5.757	       3.775	      35.764	      99.991
> UDP_RR	  224 threads	      5.124	       3.704	      28.748	      99.860
> 
> schedstat_parse.py -f schbench_vanilla.log
> (each group has 28 tasks)
> case	        load	    se_eff%	    dom_eff%	  fast_rate%	success_rate%
> normal	   1   mthread	     99.152	       6.400	      99.941	     100.000
> normal	   2   mthreads	     97.844	       4.003	      99.908	     100.000
> normal	   3   mthreads	     96.395	       2.118	      99.917	      99.998
> normal	   4   mthreads	     55.288	       1.451	      98.615	      99.804
> normal	   5   mthreads	      7.004	       1.870	      45.597	      61.036
> normal	   6   mthreads	      3.354	       1.346	      20.777	      34.230
> normal	   7   mthreads	      2.183	       1.028	      11.257	      21.055
> normal	   8   mthreads	      1.653	       0.825	       7.849	      15.549
> 
> schedstat_parse.py -f hackbench_vanilla.log
> (each group has 28 tasks)
> case			load	        se_eff%	    dom_eff%	  fast_rate%	success_rate%
> process-pipe	     1 group	         99.991	       7.692	      99.999	     100.000
> process-pipe	    2 groups	         99.934	       4.615	      99.997	     100.000
> process-pipe	    3 groups	         99.597	       3.198	      99.987	     100.000
> process-pipe	    4 groups	         98.378	       2.464	      99.958	     100.000
> process-pipe	    5 groups	         27.474	       3.653	      89.811	      99.800
> process-pipe	    6 groups	         20.201	       4.098	      82.763	      99.570
> process-pipe	    7 groups	         16.423	       4.156	      77.398	      99.316
> process-pipe	    8 groups	         13.165	       3.920	      72.232	      98.828
> process-sockets	     1 group	         99.977	       5.882	      99.999	     100.000
> process-sockets	    2 groups	         99.927	       5.505	      99.996	     100.000
> process-sockets	    3 groups	         99.397	       3.250	      99.980	     100.000
> process-sockets	    4 groups	         79.680	       4.258	      98.864	      99.998
> process-sockets	    5 groups	          7.673	       2.503	      63.659	      92.115
> process-sockets	    6 groups	          4.642	       1.584	      58.946	      88.048
> process-sockets	    7 groups	          3.493	       1.379	      49.816	      81.164
> process-sockets	    8 groups	          3.015	       1.407	      40.845	      75.500
> threads-pipe	     1 group	         99.997	       0.000	     100.000	     100.000
> threads-pipe	    2 groups	         99.894	       2.932	      99.997	     100.000
> threads-pipe	    3 groups	         99.611	       4.117	      99.983	     100.000
> threads-pipe	    4 groups	         97.703	       2.624	      99.937	     100.000
> threads-pipe	    5 groups	         22.919	       3.623	      87.150	      99.764
> threads-pipe	    6 groups	         18.016	       4.038	      80.491	      99.557
> threads-pipe	    7 groups	         14.663	       3.991	      75.239	      99.247
> threads-pipe	    8 groups	         12.242	       3.808	      70.651	      98.644
> threads-sockets	     1 group	         99.990	       6.667	      99.999	     100.000
> threads-sockets	    2 groups	         99.940	       5.114	      99.997	     100.000
> threads-sockets	    3 groups	         99.469	       4.115	      99.977	     100.000
> threads-sockets	    4 groups	         87.528	       4.038	      99.400	     100.000
> threads-sockets	    5 groups	          6.942	       2.398	      59.244	      88.337
> threads-sockets	    6 groups	          4.359	       1.954	      49.448	      87.860
> threads-sockets	    7 groups	          2.845	       1.345	      41.198	      77.102
> threads-sockets	    8 groups	          2.871	       1.404	      38.512	      74.312
> 
> schedstat_parse.py -f tbench_vanilla.log
> case			load	      se_eff%	    dom_eff%	  fast_rate%	success_rate%
> loopback	  28 threads	       99.976	      18.369	      99.995	     100.000
> loopback	  56 threads	       99.222	       7.799	      99.934	     100.000
> loopback	  84 threads	       19.723	       6.819	      70.215	     100.000
> loopback	 112 threads	       11.283	       5.371	      55.371	      99.999
> loopback	 140 threads	        0.000	       0.000	       0.000	       0.000
> loopback	 168 threads	        0.000	       0.000	       0.000	       0.000
> loopback	 196 threads	        0.000	       0.000	       0.000	       0.000
> loopback	 224 threads	        0.000	       0.000	       0.000	       0.000
> 
> According to the test above, if the system becomes busy, the
> SIS Search Efficiency(se_eff%) drops significantly. Although some
> benchmarks would finally find an idle CPU(success_rate% = 100%), it is
> doubtful whether it is worth it to search the whole LLC domain.
> 
> [Proposal]
> It would be ideal to have a crystal ball to answer this question:
> How many CPUs must a wakeup path walk down, before it can find an idle
> CPU? Many potential metrics could be used to predict the number.
> One candidate is the sum of util_avg in this LLC domain. The benefit
> of choosing util_avg is that it is a metric of accumulated historic
> activity, which seems to be smoother than instantaneous metrics
> (such as rq->nr_running). Besides, choosing the sum of util_avg
> would help predict the load of the LLC domain more precisely, because
> SIS_PROP uses one CPU's idle time to estimate the total LLC domain idle
> time.
> 
> In summary, the lower the util_avg is, the more select_idle_cpu()
> should scan for idle CPU, and vice versa. When the sum of util_avg
> in this LLC domain hits 85% or above, the scan stops. The reason to
> choose 85% as the threshold is that this is the imbalance_pct(117)
> when a LLC sched group is overloaded.
> 
> Introduce the quadratic function:
> 
> y = SCHED_CAPACITY_SCALE - p * x^2
> and y'= y / SCHED_CAPACITY_SCALE
> 
> x is the ratio of sum_util compared to the CPU capacity:
> x = sum_util / (llc_weight * SCHED_CAPACITY_SCALE)
> y' is the ratio of CPUs to be scanned in the LLC domain,
> and the number of CPUs to scan is calculated by:
> 
> nr_scan = llc_weight * y'
> 
> Choosing quadratic function is because:
> [1] Compared to the linear function, it scans more aggressively when the
>     sum_util is low.
> [2] Compared to the exponential function, it is easier to calculate.
> [3] It seems that there is no accurate mapping between the sum of util_avg
>     and the number of CPUs to be scanned. Use heuristic scan for now.
> 
> For a platform with 112 CPUs per LLC, the number of CPUs to scan is:
> sum_util%   0    5   15   25  35  45  55   65   75   85   86 ...
> scan_nr   112  111  108  102  93  81  65   47   25    1    0 ...
> 
> For a platform with 16 CPUs per LLC, the number of CPUs to scan is:
> sum_util%   0    5   15   25  35  45  55   65   75   85   86 ...
> scan_nr    16   15   15   14  13  11   9    6    3    0    0 ...
> 
> Furthermore, to minimize the overhead of calculating the metrics in
> select_idle_cpu(), borrow the statistics from periodic load balance.
> As mentioned by Abel, on a platform with 112 CPUs per LLC, the
> sum_util calculated by periodic load balance after 112 ms would
> decay to about 0.5 * 0.5 * 0.5 * 0.7 = 8.75%, thus bringing a delay
> in reflecting the latest utilization. But it is a trade-off.
> Checking the util_avg in newidle load balance would be more frequent,
> but it brings overhead - multiple CPUs write/read the per-LLC shared
> variable and introduces cache contention. Tim also mentioned that,
> it is allowed to be non-optimal in terms of scheduling for the
> short-term variations, but if there is a long-term trend in the load
> behavior, the scheduler can adjust for that.
> 
> When SIS_UTIL is enabled, the select_idle_cpu() uses the nr_scan
> calculated by SIS_UTIL instead of the one from SIS_PROP. As Peter and
> Mel suggested, SIS_UTIL should be enabled by default.
> 
> This patch is based on the util_avg, which is very sensitive to the
> CPU frequency invariance. There is an issue that, when the max frequency
> has been clamp, the util_avg would decay insanely fast when
> the CPU is idle. Commit addca285120b ("cpufreq: intel_pstate: Handle no_turbo
> in frequency invariance") could be used to mitigate this symptom, by adjusting
> the arch_max_freq_ratio when turbo is disabled. But this issue is still
> not thoroughly fixed, because the current code is unaware of the user-specified
> max CPU frequency.
> 
> [Test result]
> 
> netperf and tbench were launched with 25% 50% 75% 100% 125% 150%
> 175% 200% of CPU number respectively. Hackbench and schbench were launched
> by 1, 2 ,4, 8 groups. Each test lasts for 100 seconds and repeats 3 times.
> 
> The following is the benchmark result comparison between
> baseline:vanilla v5.19-rc1 and compare:patched kernel. Positive compare%
> indicates better performance.
> 
> Each netperf test is a:
> netperf -4 -H 127.0.1 -t TCP/UDP_RR -c -C -l 100
> netperf.throughput
> =======
> case            	load    	baseline(std%)	compare%( std%)
> TCP_RR          	28 threads	 1.00 (  0.34)	 -0.16 (  0.40)
> TCP_RR          	56 threads	 1.00 (  0.19)	 -0.02 (  0.20)
> TCP_RR          	84 threads	 1.00 (  0.39)	 -0.47 (  0.40)
> TCP_RR          	112 threads	 1.00 (  0.21)	 -0.66 (  0.22)
> TCP_RR          	140 threads	 1.00 (  0.19)	 -0.69 (  0.19)
> TCP_RR          	168 threads	 1.00 (  0.18)	 -0.48 (  0.18)
> TCP_RR          	196 threads	 1.00 (  0.16)	+194.70 ( 16.43)
> TCP_RR          	224 threads	 1.00 (  0.16)	+197.30 (  7.85)
> UDP_RR          	28 threads	 1.00 (  0.37)	 +0.35 (  0.33)
> UDP_RR          	56 threads	 1.00 ( 11.18)	 -0.32 (  0.21)
> UDP_RR          	84 threads	 1.00 (  1.46)	 -0.98 (  0.32)
> UDP_RR          	112 threads	 1.00 ( 28.85)	 -2.48 ( 19.61)
> UDP_RR          	140 threads	 1.00 (  0.70)	 -0.71 ( 14.04)
> UDP_RR          	168 threads	 1.00 ( 14.33)	 -0.26 ( 11.16)
> UDP_RR          	196 threads	 1.00 ( 12.92)	+186.92 ( 20.93)
> UDP_RR          	224 threads	 1.00 ( 11.74)	+196.79 ( 18.62)
> 
> Take the 224 threads as an example, the SIS search metrics changes are
> illustrated below:
> 
>     vanilla                    patched
>    4544492          +237.5%   15338634        sched_debug.cpu.sis_domain_search.avg
>      38539        +39686.8%   15333634        sched_debug.cpu.sis_failed.avg
>   128300000          -87.9%   15551326        sched_debug.cpu.sis_scanned.avg
>    5842896          +162.7%   15347978        sched_debug.cpu.sis_search.avg
> 
> There is -87.9% less CPU scans after patched, which indicates lower overhead.
> Besides, with this patch applied, there is -13% less rq lock contention
> in perf-profile.calltrace.cycles-pp._raw_spin_lock.raw_spin_rq_lock_nested
> .try_to_wake_up.default_wake_function.woken_wake_function.
> This might help explain the performance improvement - Because this patch allows
> the waking task to remain on the previous CPU, rather than grabbing other CPUs'
> lock.
> 
> Each hackbench test is a:
> hackbench -g $job --process/threads --pipe/sockets -l 1000000 -s 100
> hackbench.throughput
> =========
> case            	load    	baseline(std%)	compare%( std%)
> process-pipe    	1 group 	 1.00 (  1.29)	 +0.57 (  0.47)
> process-pipe    	2 groups 	 1.00 (  0.27)	 +0.77 (  0.81)
> process-pipe    	4 groups 	 1.00 (  0.26)	 +1.17 (  0.02)
> process-pipe    	8 groups 	 1.00 (  0.15)	 -4.79 (  0.02)
> process-sockets 	1 group 	 1.00 (  0.63)	 -0.92 (  0.13)
> process-sockets 	2 groups 	 1.00 (  0.03)	 -0.83 (  0.14)
> process-sockets 	4 groups 	 1.00 (  0.40)	 +5.20 (  0.26)
> process-sockets 	8 groups 	 1.00 (  0.04)	 +3.52 (  0.03)
> threads-pipe    	1 group 	 1.00 (  1.28)	 +0.07 (  0.14)
> threads-pipe    	2 groups 	 1.00 (  0.22)	 -0.49 (  0.74)
> threads-pipe    	4 groups 	 1.00 (  0.05)	 +1.88 (  0.13)
> threads-pipe    	8 groups 	 1.00 (  0.09)	 -4.90 (  0.06)
> threads-sockets 	1 group 	 1.00 (  0.25)	 -0.70 (  0.53)
> threads-sockets 	2 groups 	 1.00 (  0.10)	 -0.63 (  0.26)
> threads-sockets 	4 groups 	 1.00 (  0.19)	+11.92 (  0.24)
> threads-sockets 	8 groups 	 1.00 (  0.08)	 +4.31 (  0.11)
> 
> Each tbench test is a:
> tbench -t 100 $job 127.0.0.1
> tbench.throughput
> ======
> case            	load    	baseline(std%)	compare%( std%)
> loopback        	28 threads	 1.00 (  0.06)	 -0.14 (  0.09)
> loopback        	56 threads	 1.00 (  0.03)	 -0.04 (  0.17)
> loopback        	84 threads	 1.00 (  0.05)	 +0.36 (  0.13)
> loopback        	112 threads	 1.00 (  0.03)	 +0.51 (  0.03)
> loopback        	140 threads	 1.00 (  0.02)	 -1.67 (  0.19)
> loopback        	168 threads	 1.00 (  0.38)	 +1.27 (  0.27)
> loopback        	196 threads	 1.00 (  0.11)	 +1.34 (  0.17)
> loopback        	224 threads	 1.00 (  0.11)	 +1.67 (  0.22)
> 
> Each schbench test is a:
> schbench -m $job -t 28 -r 100 -s 30000 -c 30000
> schbench.latency_90%_us
> ========
> case            	load    	baseline(std%)	compare%( std%)
> normal          	1 mthread	 1.00 ( 31.22)	 -7.36 ( 20.25)*
> normal          	2 mthreads	 1.00 (  2.45)	 -0.48 (  1.79)
> normal          	4 mthreads	 1.00 (  1.69)	 +0.45 (  0.64)
> normal          	8 mthreads	 1.00 (  5.47)	 +9.81 ( 14.28)


Following are the results from dual socket Zen3 platform (2 x 64C/128T) running with
various NPS configuration:

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

Kernel versions:
- tip:         5.19-rc2 tip sched/core
- SIS_UTIL:    5.19-rc2 tip sched/core + this patch

When we started testing, the tip was at:
commit: f3dd3f674555 "sched: Remove the limitation of WF_ON_CPU on wakelist if wakee cpu is idle"

~~~~~~~~~
hackbench
~~~~~~~~~

NPS1

Test:                   tip                     SIS_UTIL
 1-groups:         4.64 (0.00 pct)         4.77 (-2.80 pct)
 2-groups:         5.22 (0.00 pct)         5.17 (0.95 pct)
 4-groups:         5.43 (0.00 pct)         5.29 (2.57 pct)
 8-groups:         5.85 (0.00 pct)         5.75 (1.70 pct)
16-groups:         7.54 (0.00 pct)         7.62 (-1.06 pct)

NPS2

Test:                   tip                     SIS_UTIL
 1-groups:         4.61 (0.00 pct)         4.79 (-3.90 pct)
 2-groups:         5.00 (0.00 pct)         4.94 (1.20 pct)
 4-groups:         5.14 (0.00 pct)         5.00 (2.72 pct)
 8-groups:         5.66 (0.00 pct)         5.49 (3.00 pct)
16-groups:         7.54 (0.00 pct)         7.33 (2.78 pct)

NPS4

Test:                   tip                     SIS_UTIL
 1-groups:         4.64 (0.00 pct)         4.69 (-1.07 pct)
 2-groups:         5.03 (0.00 pct)         4.98 (0.99 pct)
 4-groups:         5.66 (0.00 pct)         5.88 (-3.88 pct)
 8-groups:         6.16 (0.00 pct)         6.14 (0.32 pct)
16-groups:         7.37 (0.00 pct)         9.60 (-30.25 pct)    * (System overloaded)
16-groups:         7.38 (0.00 pct)         7.99 (-8.26 pct)     [Verification Run]

~~~~~~~~
schbench
~~~~~~~~

NPS1

#workers:     tip                     SIS_UTIL
  1:      23.50 (0.00 pct)        20.00 (14.89 pct)
  2:      33.00 (0.00 pct)        29.50 (10.60 pct)
  4:      43.50 (0.00 pct)        40.00 (8.04 pct)
  8:      52.50 (0.00 pct)        50.00 (4.76 pct)
 16:      70.00 (0.00 pct)        72.50 (-3.57 pct)
 32:     103.50 (0.00 pct)       100.50 (2.89 pct)
 64:     175.50 (0.00 pct)       183.00 (-4.27 pct)
128:     362.00 (0.00 pct)       368.50 (-1.79 pct)
256:     867.00 (0.00 pct)       867.00 (0.00 pct)
512:     60224.00 (0.00 pct)     58368.00 (3.08 pct)

NPS2

#workers:     tip                     SIS_UTIL
  1:      19.50 (0.00 pct)        17.00 (12.82 pct)
  2:      31.50 (0.00 pct)        21.50 (31.74 pct)
  4:      39.00 (0.00 pct)        31.50 (19.23 pct)
  8:      54.50 (0.00 pct)        46.00 (15.59 pct)
 16:      73.50 (0.00 pct)        78.00 (-6.12 pct)     *
 16:      74.00 (0.00 pct)        76.00 (-2.70 pct)     [Verification Run]
 32:     105.00 (0.00 pct)       100.00 (4.76 pct)
 64:     181.50 (0.00 pct)       176.00 (3.03 pct)
128:     368.50 (0.00 pct)       368.00 (0.13 pct)
256:     885.00 (0.00 pct)       875.00 (1.12 pct)
512:     58752.00 (0.00 pct)     59520.00 (-1.30 pct)

NPS4

#workers:     tip                     SIS_UTIL
  1:      19.00 (0.00 pct)        15.50 (18.42 pct)
  2:      32.00 (0.00 pct)        21.50 (32.81 pct)
  4:      36.50 (0.00 pct)        29.00 (20.54 pct)
  8:      47.50 (0.00 pct)        51.00 (-7.36 pct)     *
  8:      49.50 (0.00 pct)        44.50 (10.10 pct)     [Verification Run]
 16:      74.50 (0.00 pct)        78.00 (-4.69 pct)     *
 16:      81.50 (0.00 pct)        73.00 (10.42 pct)     [Verification Run]
 32:      98.50 (0.00 pct)       101.50 (-3.04 pct)
 64:     182.00 (0.00 pct)       185.50 (-1.92 pct)
128:     369.50 (0.00 pct)       384.00 (-3.92 pct)
256:     920.00 (0.00 pct)       901.00 (2.06 pct)
512:     60224.00 (0.00 pct)     59136.00 (1.80 pct)

~~~~~~
tbench
~~~~~~

NPS1

Clients:      tip                     SIS_UTIL
    1    444.41 (0.00 pct)       445.90 (0.33 pct)
    2    879.23 (0.00 pct)       871.32 (-0.89 pct)
    4    1648.83 (0.00 pct)      1648.23 (-0.03 pct)
    8    3263.81 (0.00 pct)      3251.66 (-0.37 pct)
   16    6011.19 (0.00 pct)      5997.98 (-0.21 pct)
   32    12058.31 (0.00 pct)     11625.00 (-3.59 pct)
   64    21258.21 (0.00 pct)     20847.13 (-1.93 pct)
  128    30795.27 (0.00 pct)     29286.06 (-4.90 pct)   *
  128    29848.21 (0.00 pct)     31613.76 (5.91 pct)    [Verification run]
  256    25138.43 (0.00 pct)     51160.59 (103.51 pct)
  512    51287.93 (0.00 pct)     51829.94 (1.05 pct)
 1024    53176.97 (0.00 pct)     53211.32 (0.06 pct)

NPS2

Clients:       tip                     SIS_UTIL
    1    445.45 (0.00 pct)       447.64 (0.49 pct)
    2    869.24 (0.00 pct)       868.63 (-0.07 pct)
    4    1644.28 (0.00 pct)      1632.35 (-0.72 pct)
    8    3120.83 (0.00 pct)      3157.00 (1.15 pct)
   16    5972.29 (0.00 pct)      5679.18 (-4.90 pct)    *
   16    5668.91 (0.00 pct)      5701.57 (0.57 pct)     [Verification run]
   32    11776.38 (0.00 pct)     11253.96 (-4.43 pct)   *
   32    11668.66 (0.00 pct)     11272.02 (-3.39 pct)   [Verification run]
   64    20933.15 (0.00 pct)     20717.28 (-1.03 pct)
  128    32195.00 (0.00 pct)     30400.11 (-5.57 pct)   *
  128    30248.19 (0.00 pct)     30781.22 (1.76 pct)    [Verification run]
  256    24641.52 (0.00 pct)     44940.70 (82.37 pct)
  512    50806.96 (0.00 pct)     51937.08 (2.22 pct)
 1024    51993.96 (0.00 pct)     52154.38 (0.30 pct)

NPS4

Clients:      tip                     SIS_UTIL
    1    442.10 (0.00 pct)       449.20 (1.60 pct)
    2    870.94 (0.00 pct)       875.15 (0.48 pct)
    4    1615.30 (0.00 pct)      1636.92 (1.33 pct)
    8    3195.95 (0.00 pct)      3222.69 (0.83 pct)
   16    5937.41 (0.00 pct)      5705.23 (-3.91 pct)
   32    11800.41 (0.00 pct)     11337.91 (-3.91 pct)
   64    20844.71 (0.00 pct)     20123.99 (-3.45 pct)
  128    31003.62 (0.00 pct)     30219.39 (-2.52 pct)
  256    27476.37 (0.00 pct)     49333.89 (79.55 pct)
  512    52276.72 (0.00 pct)     50807.17 (-2.81 pct)
 1024    51372.10 (0.00 pct)     51566.42 (0.37 pct)

Note: tbench resuts for 256 workers are known to have
run to run variation on the test machine. Any regression
seen for the data point can be safely ignored.

~~~~~~
Stream
~~~~~~

- 10 runs

NPS1

Test:            tip                    SIS_UTIL
 Copy:   152431.37 (0.00 pct)    165782.13 (8.75 pct)
Scale:   187983.72 (0.00 pct)    180133.46 (-4.17 pct)
  Add:   211713.09 (0.00 pct)    205588.71 (-2.89 pct)
Triad:   207302.09 (0.00 pct)    201103.81 (-2.98 pct)

NPS2

Test:           tip                     SIS_UTIL
 Copy:   134099.98 (0.00 pct)    146487.66 (9.23 pct)
Scale:   168404.01 (0.00 pct)    180551.46 (7.21 pct)
  Add:   184326.77 (0.00 pct)    197117.20 (6.93 pct)
Triad:   182707.29 (0.00 pct)    195282.60 (6.88 pct)

NPS4

Test:            tip                    SIS_UTIL
 Copy:   123058.63 (0.00 pct)    129624.17 (5.33 pct)
Scale:   178696.74 (0.00 pct)    182611.49 (2.19 pct)
  Add:   169836.95 (0.00 pct)    179869.80 (5.90 pct)
Triad:   170036.21 (0.00 pct)    177249.46 (4.24 pct)

- 100 runs

NPS1

Test:            tip                     SIS_UTIL
 Copy:   215860.05 (0.00 pct)    205953.63 (-4.58 pct)
Scale:   207886.55 (0.00 pct)    203384.29 (-2.16 pct)
  Add:   253513.05 (0.00 pct)    243351.95 (-4.00 pct)
Triad:   239471.82 (0.00 pct)    232221.90 (-3.02 pct)

NPS2

Test:            tip                     SIS_UTIL
 Copy:   223991.94 (0.00 pct)    217920.18 (-2.71 pct)
Scale:   205631.20 (0.00 pct)    213060.40 (3.61 pct)
  Add:   252292.90 (0.00 pct)    266848.26 (5.76 pct)
Triad:   239838.71 (0.00 pct)    252369.51 (5.22 pct)

NPS4

Test:            tip                     SIS_UTIL
 Copy:   225480.09 (0.00 pct)    218902.02 (-2.91 pct)
Scale:   218218.59 (0.00 pct)    210839.93 (-3.38 pct)
  Add:   273879.95 (0.00 pct)    261761.62 (-4.42 pct)
Triad:   255765.98 (0.00 pct)    246971.11 (-3.43 pct)

~~~~~~~~~~~~
ycsb-mongodb
~~~~~~~~~~~~

NPS1

sched-tip:      301330.33 (var: 3.28)
SIS_UTIL:       295360.33 (var: 0.76)    (-1.98%)

NPS2

sched-tip:      287786.00 (var: 4.24)
SIS_UTIL:       288888.33 (var: 1.58)    (+0.38%)

NPS4

sched-tip:      293671.00 (var: 0.89)
SIS_UTIL:       295682.33 (var: 0.92)    (+0.68%)


~~~~~
Notes
~~~~~

o tbench reaches close to saturation at 256 clients which was
  previously an unreliable data point and usually showed regression
  compared to the result with 128 clients.
o schbench improves for low worker count. It is not strictly because
  of SIS_UTIL.
o Most serious regression seen seem to reverse with a rerun suggesting
  some run to run variance with few data points on tip as well as with
  this patch.
o Any small regression or improvements seen are within the margin of
  run to run variance seen on the tip as well. The results seem to be
  more stable with SIS_UTIL compared to SIS_PROP

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SIS Efficiency Stats for Hackbench
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Following are the system wide SIS Efficiency stats for SIS_PROP and SIS_UTIL
when running hackbench with Mel's patch applied as is on both kernels:
(https://lore.kernel.org/lkml/20210726102247.21437-2-mgorman@techsingularity.net/)

Metrics and the labels assigned for better readability

SIS Search		: Number of calls to select_idle_sibling
SIS Domain Search	: Number of times the domain was searched (fast path failed)
SIS Scanned		: Number of runqueues scanned
SIS Failures		: Number of SIS calls that failed to find an idle CPU

SIS Logic:								   SIS_PROP	 SIS_UTIL	Diff (SIS_UTIL wrt SIS_PROP)

o 1-group

Benchmark Results (sec)                                    :                4.823         4.841		(-0.37 pct)
Number of calls to select_idle_sibling                     :              3154397       3166395		(0.38 pct)
Number of times the domain was searched (fast path failed) :               931530       1349865		(44.91 pct)
Number of runqueues scanned                                :              7846894      11026784		(40.52 pct)
Number of SIS calls that failed to find an idle CPU        :                76463        118968		(55.59 pct)
Avg. No. of runqueues scanned per domain search            :                 8.42          8.16		(-3.09 pct)

o 2-groups

Benchmark Results (sec)                                    :                4.705         4.912		(-4.40 pct)
Number of calls to select_idle_sibling                     :              3521182       4879821		(38.58 pct)
Number of times the domain was searched (fast path failed) :              2049034       2979202		(45.40 pct)
Number of runqueues scanned                                :             16717385      24743444		(48.01 pct)
Number of SIS calls that failed to find an idle CPU        :               366643        241789		(-34.05 pct)
Avg. No. of runqueues scanned per domain search            :                 8.15          8.30		(1.84 pct)

o 4-groups

Benchmark Results (sec)                                    :                5.503         5.268		(4.27 pct)
Number of calls to select_idle_sibling                     :             13293368      11006088		(-17.21 pct)
Number of times the domain was searched (fast path failed) :              5487436       4604635		(-16.09 pct)
Number of runqueues scanned                                :             53028113      43238439		(-18.46 pct)
Number of SIS calls that failed to find an idle CPU        :              1171727       1040776		(-11.18 pct)
Avg. No. of runqueues scanned per domain search            :                 9.66          9.39		(-2.80 pct)

o 8-groups

Benchmark Results (sec)                                    :                5.794         5.752		(0.72 pct)
Number of calls to select_idle_sibling                     :             26367244      24734896		(-6.19 pct)
Number of times the domain was searched (fast path failed) :             11137288       9528659		(-14.44 pct)
Number of runqueues scanned                                :            106216549      91895107		(-13.48 pct)
Number of SIS calls that failed to find an idle CPU        :              3154674       3012751		(-4.50 pct)
Avg. No. of runqueues scanned per domain search            :                 9.53          9.64		(1.15 pct)

o 16-groups

Benchmark Results (sec)                                    :                7.405         7.363		(0.57 pct)
Number of calls to select_idle_sibling                     :             57323447      49331195		(-13.94 pct)
Number of times the domain was searched (fast path failed) :             27853188      23892530		(-14.22 pct)
Number of runqueues scanned                                :            248062785     180150761		(-27.38 pct)
Number of SIS calls that failed to find an idle CPU        :             12182277      14125960		(15.96 pct)
Avg. No. of runqueues scanned per domain search            :                 8.90          7.54		(-15.28 pct)

For 16 groups, when comparing SIS_UTIL to SIS_PROP, the
"Avg. No. of runqueues scanned per domain search" goes down and we
know there is high chance we won't find an idle CPU but it is
still relatively high for lower number of groups where the
opportunity to find idle cpus is more.

> 
> [..snip..]
>  
>  #define NUMA_IMBALANCE_MIN 2
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 1cf435bbcd9c..3334a1b93fc6 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -61,6 +61,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
>   * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
>   */
>  SCHED_FEAT(SIS_PROP, true)

SIS_PROP was disabled in our testing as follows:

--
-SCHED_FEAT(SIS_PROP, true)
+SCHED_FEAT(SIS_PROP, false)
--

> +SCHED_FEAT(SIS_UTIL, true)
>  
>  /*
>   * Issue a WARN when we do multiple update_rq_clock() calls
>
> [..snip..]
>

With v4 on the current tip, I don't see any need for
a special case for systems with smaller LLCs with
SIS_PROP disabled and SIS_UITL enable. Even SIS Efficiency
seems to be better with SIS_UTIL for hackbench.

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com> 
--
Thanks and Regards,
Prateek
