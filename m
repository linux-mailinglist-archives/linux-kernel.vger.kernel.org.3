Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EF552E427
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 06:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345488AbiETE6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 00:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbiETE6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 00:58:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F4F3A5EB
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 21:58:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqzOeVrQcoSkSurzQE7AQVMuxlukn5vtrh6wqStFMBT3h+ZIeADtwwEnuYivWdtez9pDJ7F1CabvmYa9jSczsu0R8GtJt2k9ocytYZjmaNr8XYeGFk55hZHDAo8x2WALTlhzwL5hyGHUDEq1ld8eftCItsGob9hds+UGhxk05mX+y/YI33tUXwcVA0uGP1l7Yfyt/W8bWX4F9rIQ8kz2Yvnf0SWRawXf8i/aGjbRIb0+rN0TBlsHAkGJm42A1Z3JNhDa/sZv3iFDb7B+24BFB8Dsvo2aU3yqu72ZDMG34DFboeJlWKsp4NO1KB2WT8+Gx3e3w817U3v5WSA4EEoxmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJ1qUsyM+yB1QYyLBoEPtbz84He7NAu7ZupdJW4unQM=;
 b=l2Lj3NqLXQQz4aU833f1AkKLvML95wk7kj8l+WhJFWWH4Y1cBDEzYjVI+SQIvkZwcJSkGvgZh2p/i+cCd/yW74d0UrFhrNyo+tcd+eOdtt6E6kyxNqQnXOc4pgmmaHXbNuhrptLQ5N5ESECp2Y3pjHFnsdE21M6zZZfjzflq8eUFo7+uPTcrzs5LvsEWfuWagn/1RYeg9oVijFaztNmUC/H83vhioxvZe+DlWgMc9eXKTsk/MicOaRxvu4qh8JDfRQub9Q2GKfyo+q0Zhy0lwHnO6jAAqwXsDieD7Nogi2KR8sBWemiU35sxtl/sDQwW/vhD/Iv2ZxUVlR2MPzbbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJ1qUsyM+yB1QYyLBoEPtbz84He7NAu7ZupdJW4unQM=;
 b=se9wEC9uiZLvfOXwNvbtsoPYou4WF6NELZGb6x1WaPrQAvRY4pTFAAIDuKb38ZYRXzYt7ZyfFMuVMakhiqcBTaPZ3eP8Q01HfCNjlHJ/bBmWqbrMzcPdpUFmPdi8ZKb+yUgffEzqX9zGyS9Ua/cajBNPs4o3QxasOs8cPLNHc8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CY4PR12MB1525.namprd12.prod.outlook.com (2603:10b6:910:11::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Fri, 20 May
 2022 04:58:16 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d22:1b6d:6231:e435]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d22:1b6d:6231:e435%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 04:58:16 +0000
Message-ID: <f6b2eba0-2c28-b41b-3900-8834abbd6575@amd.com>
Date:   Fri, 20 May 2022 10:28:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/4] Mitigate inconsistent NUMA imbalance behaviour
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220511143038.4620-1-mgorman@techsingularity.net>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20220511143038.4620-1-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0106.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::22)
 To MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33d3e060-db03-449c-6502-08da3a1d5968
X-MS-TrafficTypeDiagnostic: CY4PR12MB1525:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1525EAC640EAB2031220C06098D39@CY4PR12MB1525.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sn1Hk5NwOZENWVkqgohjxTQ7W5Xe5NvTWpZZfJB3HBvh0Hy3eLw94n1BEvnbdZNcvol6TtFq/c0gG4Pkofp3j27NMdV0toyAKNGs1mR7Z8/MaD6L5uFJC8BBclOlGkQ8du4D2J3MvECqKQ4VcytncjX8nILg3fTGhHwdsSHKdVOKc70Ay/u8wmYczNqt9C81h9B05ZOoWtPXIOHwMoSAcjXJd6a/YDruzr3sQAff5BRXnP/igcuTieiO2dK+1xNpu8S3pWJSt37qd9+UB3Bx05CaxrG0cFSWuL/2nuAkxk89oFvPJJ+QIp0PFPP0ckKctdgP3Nd+Gl+UsJYoywHUsje2xpJWFFvcOH4QF1+dW3PLlAtl3CqFxOT8ji+Th8yYL7g5PDpOcom94j+J/68PysHnOx6HRTy9pD6HeToBMR/Ajag9bz6k1VLIMkGIb002QEFdSYte5rELTJDwmXTqAF3auRkRA6pSDMe2D/0p0hJZ0qGcbZiC9scdgE/Olc6bMA/Xiln1uSoPNrv30LqhlO08vdeFGxxzwtVICY1AhQKH3vudHZRFi5qAlVMEU5QlBEsYe52KMwdIrzqnGnRhicO56OwoISow2yE+1pL42wS/8V1wD8IBT74YFNn/BHwS7B9uMijmahJdlcljybP+KYMUplRhetYRk1v36t3vEy4eYx5uklimGYV1Gom1sNRQeYvCqki6HTvF3wSmAXBU8V3rjyjlg2rkj4b6QbsO2zoLrKXJPEYK7qCRR39OEp4M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(5660300002)(31696002)(86362001)(54906003)(30864003)(186003)(316002)(83380400001)(36756003)(2906002)(508600001)(6512007)(110136005)(4326008)(8676002)(38100700002)(31686004)(26005)(6666004)(66476007)(6486002)(53546011)(66556008)(8936002)(66946007)(6506007)(219204002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTVBR0VqQ1ZJZXZkRmV1Y3NCaFlNRDJabnlNVkJ0b1VKcmhsM0FudytXeENy?=
 =?utf-8?B?VU0yNFZvYWhiNUVLcGxJcW9IbExSZWJmOVdSdTA0b3ljeHJUbll1ekpMWjZG?=
 =?utf-8?B?VWIzbllodmlkRXNNRktOWGE5SEhxTTNRWFErRWNNVk83YmhQSEliS3l1dmZS?=
 =?utf-8?B?eVVsaG1OMWFGOFc4SUU1YzcwM2FIdEJrRDZMTHNmN0hNL1hGZ2h0cDdMUFpZ?=
 =?utf-8?B?OWhYd1VVZFFJUUdaZStPZGpzM29rSzBlZVo3T01HbjJHMkdpZzdwNndqMCtD?=
 =?utf-8?B?c3VTUE5kOHg4MlFlZXlxS004M0Uvanh5REw3ZnJVazBoYXVaT2JrZWxPZlMz?=
 =?utf-8?B?Ri8zL0NDQzdOMVlLUTNXLzF1T1hFU0QvNjFpMjRFNlpWRS9YZndnWjhEMWMy?=
 =?utf-8?B?ZW0yMnlPYkJkZ3NQbXlDQVlnTG04Z2lRbkFVbFBSODFLYXVDcldlMFBkQ212?=
 =?utf-8?B?S3NQLzU5UVRyd2g5ekMzQVY4ZmNpL21MOHVWejkwWFh0a09QUHpidGJYMkk4?=
 =?utf-8?B?c1lOSFAyVk1aYi91MTUwY2pSUDJEQlZ4YlE4clJnMk0yMzBkRzIyd09Kd3I2?=
 =?utf-8?B?QTlsUys4dmhQVm9YSUl2dUtTaElVTTV4OGIvWmlJVWlHOFhXakVHVER4ZWUv?=
 =?utf-8?B?Y2hFYmtIUEdkZU42N1NwczhUcDBUaXVuTFpNOE1LNERNanAxTFVaYVF6Y04x?=
 =?utf-8?B?bjVNdXBtT2JwUzEvNVdVWThFdGRacnNWdnhuVHFaUE51MlJpWS9Hd0lxeFQy?=
 =?utf-8?B?TkNQcU1aQ1BqYUx4Z3doUldyQVJoKzRmbFN6ZzIzWklUeEF3cmJCV2I5N01B?=
 =?utf-8?B?UUxrQ2pwNXBCY0FobjlYazVRRVNCZDRUZXAwOVoyT0YxZUdjcEJoejdUMzBO?=
 =?utf-8?B?QVRUT05td045VTZhU0ZiVzZtVmtMaWFFc3M1dXlLWlY1cEpXTzc3b1VTTkpH?=
 =?utf-8?B?bjlqQWk0U0szTEM1b2xncVVocC9pR0Z3QVBBcVZHaWZFWUxCVkozN2I1ZC9E?=
 =?utf-8?B?alZicVJmMjR4aWdjRHpvdDVZVmY4cUNBbzY0d1J0T0NQQlJXalJzK0QrbE1C?=
 =?utf-8?B?b2IwaDd6MTZLU3BqV2ZwQklQNUJNWE1KamJoRjNZYmsrTGhuOE5UQmtDNnJv?=
 =?utf-8?B?bHh0d2tMOWRycE1qZ1F3K3VseVh2djRrVW01THo2UUc2ekhVT0JiMldycUZo?=
 =?utf-8?B?eGhUNkV0Z05ZTHlPYVQ1cTRyT3hkQUdRd2FSSTR0dnlpWnRNL3pTclptem4r?=
 =?utf-8?B?TEFrSUcveXNmcndOOW1YQ3RuT0thUm9wTG9sRDN6aHR2bkRVTlBZRTRJbmdn?=
 =?utf-8?B?YjU3NUttY0hqbFpZalpQb1JwdUQ4VHRwQ2VIRjNUOWhqU2F0c29QSVQrWUwv?=
 =?utf-8?B?bXBDZkJDQnk1Und5akhnSXVxZ2JmSy96VEF0SUd5aU5EYUFZL3VqODNQZkxG?=
 =?utf-8?B?dU9oK2lZNmVhaGFoV3hoSnEwbXpTblNiWEJhTmZuVVF3RWdsRG1zN0pvZ3Rn?=
 =?utf-8?B?NWpXblZvMmNvWmhMOE11SkRjSnQxMGlJNHd6Nld4UVBTYWVUUjVldkkwNGRr?=
 =?utf-8?B?My9IRWllblZWR1ZYb2E0MFRwbm84b2xDai9DUmEvSTdORVhNQjBidXBHMGFm?=
 =?utf-8?B?ZWRSNFhRL214SW84elh1OGltWHZ6WGZieDk0N08zd2tRVy9LNENma2gvRTg0?=
 =?utf-8?B?Y0xMSExScHN6RTVUMk85bnduNXNMbTMyOXczUzFSV1hWWjY4dkU1YlJBZ2pE?=
 =?utf-8?B?NEIxellFc1ZlR0VJRFhXazdvSjV5YnNKbElVZ2NaelVodDR2Z3ArbDdsUmdx?=
 =?utf-8?B?RTZqaXV6enFHeFhyWXkvd3VTR0k0WlV0L3E0cTBoUkd6TWFVcFlnMCt4OWcy?=
 =?utf-8?B?R01XV2RUN0puR0c0RU95NGxLTE1FVkt4NzE1ZXk3YzBTaHpXdFAwdCtibk0y?=
 =?utf-8?B?dDhQNVBqOFEvd201QXZjeEFhWFdCTitTbDBkVlJGSHJjZVlnN3h4eElxY1Bz?=
 =?utf-8?B?bkJXVmo0dllkK0lLOWIzRWVwMUJQWUNkOTFMbHRzNDlWS0tTNXdqZUJuYlNB?=
 =?utf-8?B?d3A3N2pyd0dYMzlsRlRiN3pzR1ZSY2xWcWpPSTMxM0tuYjd2bWdSbkxPODJL?=
 =?utf-8?B?YzhFcUFrU0xaWlNEOHNMb1pvb1drS2s2RzZkZzZDU2VyOFVkaEZsMXRib1dk?=
 =?utf-8?B?MjA2REMyOEJoNHh0R0QrSWFZeEJVdGtabm4yYndYT2dBdXd5blJyRkc2NFl4?=
 =?utf-8?B?L1E4Y0Z3T1dHYm44aWNnVHFFdXlMTDQzTlE0YmtwRjU0U2g5VTVpTFdQV09h?=
 =?utf-8?B?bDBnMklwbXVLUTUwZEtjRXJOak1YenQvRENJWkNmNTB6SnRRQ2VBdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d3e060-db03-449c-6502-08da3a1d5968
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 04:58:15.9353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kCbAlPW70qGshkV4qGxQ1T3qyByvm5dnmCm3oERIGJJ0c388wcKj617UT/ooX9W9PktFpn/tg7O8GG37AbJpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1525
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mel,

We tested the patch series on a our systems.

tl;dr

Results of testing:
- Benefits short running Stream tasks in NPS2 and NPS4 mode.
- Benefits seen for tbench in NPS1 mode for 8-128 worker count.
- Regression in Hackbench with 16 groups in NPS1 mode. A rerun for
  same data point suggested run to run variation on patched kernel.
- Regression in case of tbench with 32 and 64 workers in NPS2 mode.
  Patched kernel however seems to report more stable value for 64
  worker count compared to tip.
- Slight regression in schbench in NPS2 and NPS4 mode for large
  worker count but we did spot some run to run variation with
  both tip and patched kernel.

Below are all the detailed numbers for the benchmarks.

On 5/11/2022 8:00 PM, Mel Gorman wrote:
> A problem was reported privately related to inconsistent performance of
> NAS when parallelised with MPICH. The root of the problem is that the
> initial placement is unpredictable and there can be a larger imbalance
> than expected between NUMA nodes. As there is spare capacity and the faults
> are local, the imbalance persists for a long time and performance suffers.
> 
> This is not 100% an "allowed imbalance" problem as setting the allowed
> imbalance to 0 does not fix the issue but the allowed imbalance contributes
> the the performance problem. The unpredictable behaviour was most recently
> introduced by commit c6f886546cb8 ("sched/fair: Trigger the update of
> blocked load on newly idle cpu").
> 
> mpirun forks hydra_pmi_proxy helpers with MPICH that go to sleep before the
> execing the target workload. As the new tasks are sleeping, the potential
> imbalance is not observed as idle_cpus does not reflect the tasks that
> will be running in the near future. How bad the problem depends on the
> timing of when fork happens and whether the new tasks are still running.
> Consequently, a large initial imbalance may not be detected until the
> workload is fully running. Once running, NUMA Balancing picks the preferred
> node based on locality and runtime load balancing often ignores the tasks
> as can_migrate_task() fails for either locality or task_hot reasons and
> instead picks unrelated tasks.
> 
> This is the min, max and range of run time for mg.D parallelised with ~25%
> of the CPUs parallelised by MPICH running on a 2-socket machine (80 CPUs,
> 16 active for mg.D due to limitations of mg.D).
> 
> v5.3                         Min  95.84 Max  96.55 Range   0.71 Mean  96.16
> v5.7                         Min  95.44 Max  96.51 Range   1.07 Mean  96.14
> v5.8                         Min  96.02 Max 197.08 Range 101.06 Mean 154.70
> v5.12                        Min 104.45 Max 111.03 Range   6.58 Mean 105.94
> v5.13                        Min 104.38 Max 170.37 Range  65.99 Mean 117.35
> v5.13-revert-c6f886546cb8    Min 104.40 Max 110.70 Range   6.30 Mean 105.68 
> v5.18rc4-baseline            Min 104.46 Max 169.04 Range  64.58 Mean 130.49
> v5.18rc4-revert-c6f886546cb8 Min 113.98 Max 117.29 Range   3.31 Mean 114.71
> v5.18rc4-this_series         Min  95.24 Max 175.33 Range  80.09 Mean 108.91
> v5.18rc4-this_series+revert  Min  95.24 Max  99.87 Range   4.63 Mean  96.54

Following are the results from testing on a dual socket Zen3 system
(2 x 64C/128T) in different NPS modes.

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
- tip:      	5.18-rc1 tip sched/core
- Numa Bal:    	5.18-rc1 tip sched/core + this patch

When we began testing, we recorded the tip at:

commit: a658353167bf "sched/fair: Revise comment about lb decision matrix"

Following are the results from the benchmark:

Note: Results marked with * are data points of concern. A rerun
for the data point has been provided on both the tip and the
patched kernel to check for any run to run variation.

~~~~~~~~~
hackbench
~~~~~~~~~

NPS1

Test:                   tip                     NUMA Bal
 1-groups:         4.64 (0.00 pct)         4.67 (-0.64 pct)
 2-groups:         5.38 (0.00 pct)         5.47 (-1.67 pct)
 4-groups:         6.15 (0.00 pct)         6.24 (-1.46 pct)
 8-groups:         7.42 (0.00 pct)         7.45 (-0.40 pct)
16-groups:        10.70 (0.00 pct)        12.04 (-12.52 pct)    *
16-groups:        10.81 (0.00 pct)        11.00 (-1.72 pct)     [Verification Run]

NPS2

Test:                   tip                     NUMA Bal
 1-groups:         4.70 (0.00 pct)         4.68 (0.42 pct)
 2-groups:         5.45 (0.00 pct)         5.50 (-0.91 pct)
 4-groups:         6.13 (0.00 pct)         6.13 (0.00 pct)
 8-groups:         7.30 (0.00 pct)         7.21 (1.23 pct)
16-groups:        10.30 (0.00 pct)        10.29 (0.09 pct)

NPS4

Test:                   tip                     NUMA Bal
 1-groups:         4.60 (0.00 pct)         4.55 (1.08 pct)
 2-groups:         5.41 (0.00 pct)         5.37 (0.73 pct)
 4-groups:         6.12 (0.00 pct)         6.20 (-1.30 pct)
 8-groups:         7.22 (0.00 pct)         7.29 (-0.96 pct)
16-groups:        10.24 (0.00 pct)        10.27 (-0.29 pct)

~~~~~~~~
schbench
~~~~~~~~

NPS1

#workers:      tip                   NUMA Bal
  1:      29.00 (0.00 pct)        22.50 (22.41 pct)
  2:      28.00 (0.00 pct)        27.00 (3.57 pct)
  4:      31.50 (0.00 pct)        32.00 (-1.58 pct)
  8:      42.00 (0.00 pct)        39.50 (5.95 pct)
 16:      56.50 (0.00 pct)        56.50 (0.00 pct)
 32:      94.50 (0.00 pct)        95.00 (-0.52 pct)
 64:     176.00 (0.00 pct)       176.00 (0.00 pct)
128:     404.00 (0.00 pct)       395.50 (2.10 pct)
256:     869.00 (0.00 pct)       856.00 (1.49 pct)
512:     58432.00 (0.00 pct)     58688.00 (-0.43 pct)

NPS2

#workers:      tip                   NUMA Bal
  1:      26.50 (0.00 pct)        26.00 (1.88 pct)
  2:      26.50 (0.00 pct)        24.50 (7.54 pct)
  4:      34.50 (0.00 pct)        30.50 (11.59 pct)
  8:      45.00 (0.00 pct)        42.00 (6.66 pct)
 16:      56.50 (0.00 pct)        55.50 (1.76 pct)
 32:      95.50 (0.00 pct)        95.00 (0.52 pct)
 64:     179.00 (0.00 pct)       176.00 (1.67 pct)
128:     369.00 (0.00 pct)       400.50 (-8.53 pct)   *
128:     380.00 (0.00 pct)       388.00 (-2.10 pct)   [Verification Run]
256:     898.00 (0.00 pct)       883.00 (1.67 pct)
512:     56256.00 (0.00 pct)     58752.00 (-4.43 pct)

NPS4

#workers:      tip                   NUMA Bal
  1:      25.00 (0.00 pct)        24.00 (4.00 pct)
  2:      28.00 (0.00 pct)        27.50 (1.78 pct)
  4:      29.50 (0.00 pct)        29.50 (0.00 pct)
  8:      41.00 (0.00 pct)        39.00 (4.87 pct)
 16:      65.50 (0.00 pct)        66.00 (-0.76 pct)
 32:      93.00 (0.00 pct)        94.50 (-1.61 pct)
 64:     170.50 (0.00 pct)       176.50 (-3.51 pct)
128:     377.00 (0.00 pct)       390.50 (-3.58 pct)
256:     867.00 (0.00 pct)       919.00 (-5.99 pct)     *
256:     890.00 (0.00 pct)       930.00 (-4.49 pct)     [Verification Run]
512:     58048.00 (0.00 pct)     59520.00 (-2.53 pct)

~~~~~~
tbench
~~~~~~

NPS1

Clients:      tip                    NUMA Bal
    1    443.31 (0.00 pct)       458.77 (3.48 pct)
    2    877.32 (0.00 pct)       898.76 (2.44 pct)
    4    1665.11 (0.00 pct)      1658.76 (-0.38 pct)
    8    3016.68 (0.00 pct)      3133.91 (3.88 pct)
   16    5374.30 (0.00 pct)      5816.28 (8.22 pct)
   32    8763.86 (0.00 pct)      9843.94 (12.32 pct)
   64    15786.93 (0.00 pct)     17562.26 (11.24 pct)
  128    26826.08 (0.00 pct)     28241.35 (5.27 pct)
  256    24207.35 (0.00 pct)     22242.20 (-8.11 pct)
  512    51740.58 (0.00 pct)     51678.30 (-0.12 pct)
 1024    51177.82 (0.00 pct)     50699.27 (-0.93 pct)

NPS2

Clients:       tip                    NUMA Bal
    1    449.49 (0.00 pct)       467.77 (4.06 pct)
    2    867.28 (0.00 pct)       876.20 (1.02 pct)
    4    1643.60 (0.00 pct)      1661.94 (1.11 pct)
    8    3047.35 (0.00 pct)      3040.70 (-0.21 pct)
   16    5340.77 (0.00 pct)      5168.57 (-3.22 pct)
   32    10536.85 (0.00 pct)     9603.93 (-8.85 pct)            *
   32    10424.00 (0.00 pct)     9868.67 (-5.32 pct)            [Verification Run]
   64    16543.23 (0.00 pct)     15749.69 (-4.79 pct)           *
   64    17753.50 (0.00 pct)     15599.03 (-12.13 pct)          [Verification Run]
  128    26400.40 (0.00 pct)     27745.52 (5.09 pct)
  256    23436.75 (0.00 pct)     27978.91 (19.38 pct)
  512    50902.60 (0.00 pct)     50770.42 (-0.25 pct)
 1024    50216.10 (0.00 pct)     49702.00 (-1.02 pct)

NPS4

Clients:       tip                    NUMA Bal
    1    443.82 (0.00 pct)       452.63 (1.98 pct)
    2    849.14 (0.00 pct)       857.86 (1.02 pct)
    4    1603.26 (0.00 pct)      1635.02 (1.98 pct)
    8    2972.37 (0.00 pct)      3090.09 (3.96 pct)
   16    5277.13 (0.00 pct)      5524.38 (4.68 pct)
   32    9744.73 (0.00 pct)      10152.62 (4.18 pct)
   64    15854.80 (0.00 pct)     17442.86 (10.01 pct)
  128    26116.97 (0.00 pct)     26757.21 (2.45 pct)
  256    22403.25 (0.00 pct)     21178.82 (-5.46 pct)
  512    48317.20 (0.00 pct)     47433.34 (-1.82 pct)
 1024    50445.41 (0.00 pct)     50311.83 (-0.26 pct)

Note: tbench resuts for 256 workers are known to have
a great amount of run to run variation on the test
machine. Any regression seen for the data point can
be safely ignored.

~~~~~~
Stream
~~~~~~

- 10 runs

NPS1

Test:          tip                     NUMA Bal
 Copy:   189113.11 (0.00 pct)    183548.36 (-2.94 pct)
Scale:   201190.61 (0.00 pct)    199548.74 (-0.81 pct)
  Add:   232654.21 (0.00 pct)    230058.79 (-1.11 pct)
Triad:   226583.57 (0.00 pct)    224761.89 (-0.80 pct)

NPS2

Test:          tip                     NUMA Bal
 Copy:   155347.14 (0.00 pct)    226212.24 (45.61 pct)
Scale:   191701.53 (0.00 pct)    212667.40 (10.93 pct)
  Add:   210013.97 (0.00 pct)    257112.85 (22.42 pct)
Triad:   207602.00 (0.00 pct)    250309.89 (20.57 pct)

NPS4

Test:          tip                     NUMA Bal
 Copy:   136421.15 (0.00 pct)    159681.42 (17.05 pct)
Scale:   191217.59 (0.00 pct)    193113.39 (0.99 pct)
  Add:   189229.52 (0.00 pct)    209058.15 (10.47 pct)
Triad:   188052.99 (0.00 pct)    205945.57 (9.51 pct)

- 100 runs

NPS1

Test:          tip                     NUMA Bal
 Copy:   244693.32 (0.00 pct)    233080.12 (-4.74 pct)
Scale:   221874.99 (0.00 pct)    215975.10 (-2.65 pct)
  Add:   268363.89 (0.00 pct)    263649.67 (-1.75 pct)
Triad:   260945.24 (0.00 pct)    250936.80 (-3.83 pct)

NPS2

Test:          tip                     NUMA Bal
 Copy:   211262.00 (0.00 pct)    251292.59 (18.94 pct)
Scale:   222493.34 (0.00 pct)    222258.48 (-0.10 pct)
  Add:   280277.17 (0.00 pct)    279649.40 (-0.22 pct)
Triad:   265860.49 (0.00 pct)    265383.54 (-0.17 pct)

NPS4

Test:           tip                     NUMA Bal
 Copy:   250171.40 (0.00 pct)    252465.44 (0.91 pct)
Scale:   222293.56 (0.00 pct)    228169.89 (2.64 pct)
  Add:   279222.16 (0.00 pct)    290568.29 (4.06 pct)
Triad:   262013.92 (0.00 pct)    273825.25 (4.50 pct)

~~~~~~~~~~~~
ycsb-mongodb
~~~~~~~~~~~~

NPS1

sched-tip:      303718.33 (var: 1.31)
NUMA Bal:       299859.00 (var: 1.05)    (-1.27%)

NPS2

sched-tip:      304536.33 (var: 2.46)
NUMA Bal:       302469.67 (var: 1.38)    (-0.67%)

NPS4

sched-tip:      301192.33 (var: 1.81)
NUMA Bal:       300948.00 (var: 0.85)   (-0.08%)

~~~~~
Notes
~~~~~

- Hackbench on NPS1 mode seems to show run to run variation with
  patched kernel. I'll gather some more data to check if this happens
  consistently or not.
  The number reported for hackbench is the Amean of 10 runs.
- schbench seems to show some variation on both tip and the patched
  kernel for the data points with regression. These are evident from
  the [Verification run] done for these data points.
  schbench runs are done with 1 messenger and n workers.
- tbench seems to show some regression for 32 worker and 64 workers
  in NPS2 mode. The case with 32 workers shows consistent result
  however the tip seems to see slight run to run variation for 64
  workers.

- Stream sees great benefit in NPS2 mode and NPS4 mode for short runs.
- Great improvements seen for tbench with 8-128 workers in NPS1 mode.

> 
> This shows that we've had unpredictable performance for a long time for
> this load. Instability was introduced somewhere between v5.7 and v5.8,
> fixed in v5.12 and broken again since v5.13.  The revert against 5.13
> and 5.18-rc4 shows that c6f886546cb8 is the primary source of instability
> although the best case is still worse than 5.7.
> 
> This series addresses the allowed imbalance problems to get the peak
> performance back to 5.7 although only some of the time due to the
> instability problem. The series plus the revert is both stable and has
> slightly better peak performance and similar average performance. I'm
> not convinced commit c6f886546cb8 is wrong but haven't isolated exactly
> why it's unstable so for now, I'm just noting it has an issue.
> 
> Patch 1 initialises numa_migrate_retry. While this resolves itself
> 	eventually, it is unpredictable early in the lifetime of
> 	a task.
> 
> Patch 2 will not swap NUMA tasks in the same NUMA group or without
> 	a NUMA group if there is spare capacity. Swapping is just
> 	punishing one task to help another.
> 
> Patch 3 fixes an issue where a larger imbalance can be created at
> 	fork time than would be allowed at run time. This behaviour
> 	can help some workloads that are short lived and prefer
> 	to remain local but it punishes long-lived tasks that are
> 	memory intensive.
> 
> Patch 4 adjusts the threshold where a NUMA imbalance is allowed to
> 	better approximate the number of memory channels, at least
> 	for x86-64.

The entire patch series was applied as is for testing.

> 
>  kernel/sched/fair.c     | 59 ++++++++++++++++++++++++++---------------
>  kernel/sched/topology.c | 23 ++++++++++------
>  2 files changed, 53 insertions(+), 29 deletions(-)
> 

Please let me know if you would like me to get some additional
data on the test system.
--
Thanks and Regards,
Prateek
