Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489D2525E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378783AbiEMJGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378130AbiEMJGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:06:14 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2121.outbound.protection.outlook.com [40.107.244.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC98D606FD;
        Fri, 13 May 2022 02:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbISJBx2BURY8A9XxXLkAbQrWfNl+w/nQ4sgEXkZ7feiXYNsidYF0F0vsY2ju/W08K62jm7mvvJNsGMTmK4IwgmjdwUo8LPbfjdRmZs1fR/mLUaOWSZ5o5a19KptbRfleMliLtGS8KhX0OBMLYLn2+2KTCKxZVgIcIj1vGs8pNZl+10JW2hiubpI88H9n7+OYQzJpjNKEqgVWATQZiXQ0p0/jFyCyh6SfFlcXIiCwrYXaG21hanpNgFjCZfskG4RhksBwCoaBtPohPXQEfiDepqXC5DelxG96aNIsp3sEaSxfhH9lQy65ry6KHkzLuibBjNDs0VzAv6t0pypsvrXCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcpqrIdlF0fuWceQIdHx11FNZ4rmqYvtbj7P/i+2VUU=;
 b=g/x2HrlVe7trl2DDq5P5gM+Q7V16BTi+3nElfCCJIw1CHORZHCef4qxekd6ozxgPkGY/flXLt2d7NLg3VvXNqoEPuAy7ZJ0jJ3PHmO4PjpyCrAuQ5lcqUQ2niml1SwM3Q4IAQiXWNlCj8qYl7OJnyP6xxvVdAVJ+RFZNNc8llugs44f3l0qx3eVG1Bm0KgvlNyDgoTByqjd0xXr3ECQe4w/mPei1bywqz3DMemJlidOk/0t2pj/p7h6CbHpOUYIyb9U04TtXM3A0uu7QGMtfrIwYghiq9ZcPZ8z+g9KL7uB6mtcBUHOq4SrU7IqyiOuNAZSobC6cmU2348L4/2Nk8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcpqrIdlF0fuWceQIdHx11FNZ4rmqYvtbj7P/i+2VUU=;
 b=RjDo9WerTckhV7AB7gL/NZ/XZmljG5S0ZQ0ko4oEMLOoK/46yOwM0E8z+xe6dt6yYbVNXti901G02PeHhsCICZj9o6+wuUqxkark4xNuIL0ZBc3PFOUFodlgBbgdsmqOPQpDI2k5LqRRA6lpHdI8aRfqw+wLQa3iiWFiSjTAOHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from SA1PR01MB6605.prod.exchangelabs.com (2603:10b6:806:1a3::14) by
 BL3PR01MB7010.prod.exchangelabs.com (2603:10b6:208:359::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Fri, 13 May 2022 09:06:08 +0000
Received: from SA1PR01MB6605.prod.exchangelabs.com
 ([fe80::950a:450:5273:f1fb]) by SA1PR01MB6605.prod.exchangelabs.com
 ([fe80::950a:450:5273:f1fb%6]) with mapi id 15.20.5250.013; Fri, 13 May 2022
 09:06:08 +0000
Message-ID: <fefc1f23-ea1c-6339-77c4-b0974cbd6e93@amperemail.onmicrosoft.com>
Date:   Fri, 13 May 2022 17:05:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 9/11] perf c2c: Sort on peer snooping for load
 operations
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Like Xu <likexu@tencent.com>, Ian Rogers <irogers@google.com>,
        Alyssa Ross <hi@alyssa.is>, Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220508092346.255826-1-leo.yan@linaro.org>
 <20220508092346.255826-10-leo.yan@linaro.org>
From:   Adam Li <adamli@amperemail.onmicrosoft.com>
In-Reply-To: <20220508092346.255826-10-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR06CA0024.apcprd06.prod.outlook.com
 (2603:1096:202:2e::36) To SA1PR01MB6605.prod.exchangelabs.com
 (2603:10b6:806:1a3::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9311363-c847-470b-79a0-08da34bfd159
X-MS-TrafficTypeDiagnostic: BL3PR01MB7010:EE_
X-Microsoft-Antispam-PRVS: <BL3PR01MB70100DFA8A248AB49A629C7BF5CA9@BL3PR01MB7010.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omlKGMeiyBDRMVLmGLgItlsXBDr1NidnmmTkdertAFKLXD2GJUaQ08d1fbGh1qfpA7iNWBrI0PKDAkzbGn/d60mMEWKNxDcHNOUiIEK4qqzAbUD8h0apsramAWmZ7K+1948FXu2PHl/1PqdNasLjNW0kM1tfDR4xbyJTLn+4uBVULlMJvAPWCWJ1v4PbYILQRi62BV9st352Qmx3gp2nWpcKu3+3dkHpnhgPqzzPOr5JNZj1EoaIRYYZKrOb6UrSimSEu1gk42Qqb/ZpFnEpvXB2ur+by8my+aB+6SaouYFKnVqje/ipi98tO7FYHj42XiWVLW3gQKAcWeEKtr9T4vKQQcvoOZ09Bdz3Xb42LfPADR5/1JBWyvAvFTEI7UZx9EhBVvCb93+yfSOA37nIUAyIAUl1oWA5upNLMsCJH+6Zdjcn8P6cG0/j2Tlj6mAGAeRJvnsCMlhCD0+P51PH86FqJTGHcmfMm8BeNAYJtKZWSBzbQGyrk0v59Dsz9MhjIvoeXdahagfB7SrZemiBLMCWl9R/eUqtxcBh4gLEy6MNvQxknDVQRq2N3RZYvKcHy6bzAAYezBKzSZDla28l6GOmmx+PrQ2wL8CylE2kyEoT0DzZH0f4Whf/F/Z8vCPjN09Uwklhnb+8Cb8tsF7+ebCaW+2HezgNKlgYMVw4oIsEQdSfJchV5LCl6scrG5mCpS1VU3RROH1383xk0XwcquUKzIE5MkQx7hHzOnSrxaVxbP7xq3iKmfK7GVWacsYZHnAJrmEtzgfaap9M/YQhTcHrib/WqMrugi/c0LYH46BxsbUtu7sA31UEc0RnZuEEVqwPNY1BVAjuDstJQV6EJhUHgPh8F2LSJps4ZyDuXk0SRRvYVPg1JR2e7DamEBSJ1JULqXQwe7StWTU5vReM4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB6605.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(42882007)(5660300002)(186003)(83380400001)(2906002)(66476007)(66556008)(66946007)(38350700002)(7416002)(31686004)(8936002)(8676002)(6506007)(6486002)(52116002)(6666004)(31696002)(6512007)(26005)(2616005)(53546011)(38100700002)(921005)(83170400001)(508600001)(316002)(110136005)(43740500002)(460985005)(2480315003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0JHL211RVdIS080WmJpV21UU2JZdHd5UVVWOHdYbzJSYzVBd3hocDhwb3ph?=
 =?utf-8?B?NHZqeVZLNDhjZEMzSEFJTXR3WDBXcGQvM0ZrNnhrblJWd0tXWXc5Q2o3R2Zm?=
 =?utf-8?B?RVEvcERic1ZQVnJjSjB6RmdOcWNYUE5BeFNTcEpjZ3cyU0hHRnFkalBkTUJz?=
 =?utf-8?B?bVlNYWlEckY1T0RLSVNKdmpRZC9BSmx1d3hKU3FNV0dKanBRL0Z4cHlpb2xt?=
 =?utf-8?B?WUFSZGVNYkJKSDBPM3BWdmFELzFyblplbHY2Um9EbmRJMWZtamMrM1FyRXRU?=
 =?utf-8?B?S2N2RHpkTnB5VjhFb25wUmg2V1gxQ1o5a0JvbWxIK2x5TWJNYzRYUWY5Mkkr?=
 =?utf-8?B?bFV0K3RTV1NVdUh2UU9DVTA0cTI1NmN1amRLNFJwWmZ0c0s5M3krckpPY0wx?=
 =?utf-8?B?THp1UjVVL3RLSkdqbWdnTzJEQko2aE9LS2NmYW9wUnBiQUI2MlVId2t1QmJ1?=
 =?utf-8?B?d3dRZDV0eEQ0NEx3SWgrZmM0T1JkSkpqQ3N3M1oyaWptUlFCM3dOdzludzFU?=
 =?utf-8?B?QVc3dGxYblFzWi9iejhvdEZ0Snd5b2Z3aFBFTjcrOVJPTUlrQjhoTFAzWXBO?=
 =?utf-8?B?dzFzL01JMDdjaUpCYTBnKzVjOFZNVDZnTm56ZEZMNHNCYVBOTEF0RWxpUks0?=
 =?utf-8?B?d2t5N2hJSnNhaVdxSWpEWUpicmVrLzAzeVgzOGFYYXZlcWxMbEttWEVGUUFy?=
 =?utf-8?B?ZW45ODRvTlZoVHB4eCt2NytOTmw0My9pVDRxcGdTcjRnbE1SZ0lKcUdhSXdC?=
 =?utf-8?B?Rm1KbUxPajlhdmtERWlZKzVQVWhpRE5TU1BMQ1Z0VjI0eGQwb2VaTGM4NkxD?=
 =?utf-8?B?czNQYkJ6LzBlSC9hUXkxVXVRSDNBWjQ4elNGNitmb095aC9BS2JPVDB1Q0pX?=
 =?utf-8?B?cm9kcWJhZTNDb0V1VEt3ZmVyWmdDa0xoZ2R6dnoxUGhDaysxN0RpNWpiSW9S?=
 =?utf-8?B?NzRkYVJkeG9UZDhTaEd6QnFLQSsyV1lPU3UydDRnY1NlU1FNYW9kdzFkUDQy?=
 =?utf-8?B?Z2Qwb1cwL0NaMHVkdmJIa3J0ZWZZVmFlSmtiRHJMU1BaTE5LSDZ0ZTRIKzgv?=
 =?utf-8?B?Qzl0NDVqMTZETzVjWDhxc1hwT2l5N2NtbE96UE43MmQvRjVBdmV3aG50Rkkx?=
 =?utf-8?B?ejhPUVc3b0hnRy9JYkx5ZVBwcUUrQ0h0RmRTaXRwTDNwcDNFSFI3UlY4Y0Ns?=
 =?utf-8?B?WkJLeElzcENZNGwzcjBLNnRtMTl3OFNiL3VDNkk4RVBTaDdURWorWVk0OWNH?=
 =?utf-8?B?Q3k3VGRJQU1NZ0ZwMm5rVXRQdHV3Tlorbk16ellVRWd1eUV2aHYvbDMydFFE?=
 =?utf-8?B?N0tpU3pqaGVVYmNoUlFDbVhBQ09DNXo5VWpiTHVsa0dYTWI1NWJGU3RWQkhz?=
 =?utf-8?B?OXpjUUVnMmtncXlOK0xPYjRQN3RkWTZNR2RkYWVmKzA2eVpjemRmNVJNT2Fu?=
 =?utf-8?B?eDQ0aEJmN0Y0RGZNa0tPOVBzNDBIc2xVdGdPdk1tUHVZcWl2SHVjUGRXT0xO?=
 =?utf-8?B?MXVvMlR0aUg2WmpKcURDWVBXZVlweGZZNDkzMEdRM3dhd2FoZ0ZqODFQampT?=
 =?utf-8?B?RGZUcUFxamk5M0dVYnRsbmpQUUFmTnhaRkJabVR5K1o2M1l6cEFTUXcrcnoy?=
 =?utf-8?B?SXpRWWpkcmhVV0V2YWF3b1RnUlArMi9vYWZqMFc4UmlGMHBVYlh4WHZ1Z0Zu?=
 =?utf-8?B?Y29na2RKbFF0OEN2QzJ6M3hiYmhVVERGUVZyNjZaeFZDT0l1YTk5WjBqVitL?=
 =?utf-8?B?M2RuYk9YeDBzelRNZGFxQWlsd1JvU3ppejh4Y0ZhWnkyaFpLaG9hS3BqdDRt?=
 =?utf-8?B?VUxFSGlkb2RHVzZRZVJhR2s3azB5YTFRUlNkSXhiOWIyblhzbEhOeHNyYVVh?=
 =?utf-8?B?Q3JTVFcvQ1JVZ2MwWTVrZUM0UTZkSjA1ZWMvS0lzN1N3dnBsbmNpaTR6MHFo?=
 =?utf-8?B?bER4WG84NXBidFFVTi9OOTFZZERRbTVhYTM4V3pvaXA4dU5LTUtxUGZDYkY4?=
 =?utf-8?B?aytUQnZnb2JUa3l2K3hEY0xsWTJGTmVUbUtKMnE3TTIxMmVFQUkvWTI2U2NY?=
 =?utf-8?B?bi9yalhrVyt6ckphSlRHSDZyKzhwelZ2U3E2M1NJTTQ3ajN4RXQ1SVg4YXgz?=
 =?utf-8?B?R082a3FrNDhURi9MTzJFcG0wbXA1bGNkSHJYWHkyT1QzL2tQdUNMMmp5YUs2?=
 =?utf-8?B?NVVseFZjd2lidU9BU1RXaWE3cWVaeHdpelV2Ky9QaGVMaUFLS2I0L0k3YXFh?=
 =?utf-8?B?ZGFOSzFaNTk2Unc1VEU0T1FrZ3NDY1FsYzdVUUptWVY4UitvS0FkbjkraElZ?=
 =?utf-8?B?VDR0Qmp0MDBzc2NCVUNkVHU4N2QzZFZqRS9VTzVxaEMrNEFvbUIvdUo4QnBq?=
 =?utf-8?Q?wZ5gGNa3b97xx7Ez5RIudYOhrroSkL/VezgNR?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9311363-c847-470b-79a0-08da34bfd159
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB6605.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 09:06:08.6108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i68tTP7XN8K92Qvftw499KbC4a+7Mw92sDdhvBN7ue+EtwWH2jPgXTxMnIG38KXOdoLONrEAdkzBsuRUTmy3xtitLfFIyCAl7b0mt2ta+eQQNWxynf1UzvNQ0NpTOAMt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7010
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/2022 5:23 PM, Leo Yan wrote:
> Except the existed three display options 'tot', 'rmt', 'lcl', this patch
> adds a new option 'peer' so can sort on the cache hit for peer snooping.
> 
> For displaying with option 'peer', the "Shared Data Cache Line Table" and
> "Shared Cache Line Distribution Pareto" both sort with the metrics
> "ld_peer".  As result, we can get the 'peer' display as below:
> 
>   # perf c2c report -d peer --coalesce tid,pid,iaddr,dso -N --stdio
> 

Hi Leo,

I tested v2 patch on 2P Altra system.
In case the false-sharing data is mainly from remote node, 'Snoop Peers'
cannot indicate severity of false-sharing. As showed in bellow output,
there are only 10 'Load HIT Peer' records, while there are 2353
'Load Remote DRAM' records.

And the name 'Load Remote DRAM' is kind of misleading, since we cannot tell
the data source is 'DRAM'.

Run false_sharing test(https://github.com/joemario/perf-c2c-usage-files):
one lock_th on node 0, one reader_thd on node 1:

# perf c2c record -- numactl -m 0 ./false_sharing.exe 1
131 mticks, reader_thd (thread 1), on node 1 (cpu 80).
145 mticks, lock_th (thread 0), on node 0 (cpu 9).
[ perf record: Woken up 16 times to write data ]
[ perf record: Captured and wrote 33.726 MB perf.data ]


# perf c2c report -d peer --coalesce tid,pid,iaddr,dso -N --stdio
Warning:
Arm SPE CONTEXT packets not found in the traces.
Matching of TIDs to SPE events could be inaccurate.
Warning:
AUX data detected collision  6 times out of 47!

=================================================
            Trace Event Information
=================================================
  Total records                     :     551944
  Locked Load/Store Operations      :          0
  Load Operations                   :     493082
  Loads - uncacheable               :          0
  Loads - IO                        :          0
  Loads - Miss                      :          0
  Loads - no mapping                :          0
  Load Fill Buffer Hit              :          0
  Load L1D hit                      :     490589
  Load L2D hit                      :        117
  Load LLC hit                      :         11
  Load HIT Peer                     :         10
  Load Local HITM                   :          0
  Load Remote HITM                  :          0
  Load Remote HIT                   :          0
  Load Local DRAM                   :          2
  Load Remote DRAM                  :       2353
  Load MESI State Exclusive         :       2355
  Load MESI State Shared            :          0
  Load LLC Misses                   :       2355
  Load access blocked by data       :          0
  Load access blocked by address    :          0
  LLC Misses to Local DRAM          :        0.1%
  LLC Misses to Remote DRAM         :       99.9%
  LLC Misses to Remote cache (HIT)  :        0.0%
  LLC Misses to Remote cache (HITM) :        0.0%
  Store Operations                  :      58862
  Store - uncacheable               :          0
  Store - no mapping                :          0
  Store L1D Hit                     :          0
  Store L1D Miss                    :          0
  Store No available memory level   :      58862
  No Page Map Rejects               :        490
  Unable to parse data source       :          0

=================================================
    Global Shared Cache Line Event Information
=================================================
  Total Shared Cache Lines          :          9
  Load HITs on shared lines         :         21
  Fill Buffer Hits on shared lines  :          0
  L1D hits on shared lines          :          6
  L2D hits on shared lines          :          1
  Load HITs on peer cache lines     :         10
  LLC hits on shared lines          :          0
  Locked Access on shared lines     :          0
  Blocked Access on shared lines    :          0
  Store HITs on shared lines        :          0
  Store L1D hits on shared lines    :          0
  Store No available memory level   :          0
  Total Merged records              :          0

=================================================
                 c2c details
=================================================
  Events                            : arm_spe_0/ts_enable=1,load_filter=1,store_filter=1,min_latency=30/
                                    : dummy:u
                                    : memory
  Cachelines sort on                : Snoop Peers
  Cacheline data grouping           : offset,tid,pid,iaddr,dso

[...]

Thanks,
-adam
