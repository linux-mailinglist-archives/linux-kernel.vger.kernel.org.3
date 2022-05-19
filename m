Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CF352CEEB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbiESJGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiESJGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:06:31 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2132.outbound.protection.outlook.com [40.107.92.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BA126AF1;
        Thu, 19 May 2022 02:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jein5sMXY86p7DeJuuXP/13KfsOFiBDPZtevcYIbSnESVJXN7S5O2odaiS0pGjXoaJn7WThmPs+gJg5Uw3HA5Kx0rKDBnxBtKODQ4hbir3PtvOi4AqHbh8LjiIc+T99c6+f1ptoSBOUy5lzYLXWprnyHr68vqh/eUyybm6nRzKU2Ou8fWyFAPLaU1zb9VaXyiNEzuhHiaUP42ioDCm3pcKidb7jOszIrZDxDlEJZKSrV2PNmZLQd9bquNx3XCZGNvz7iOItv4SwUTec1/em8EyPwBUzd9/ii/nTdj2Sm/PRiAx9yhyEB37XUL3Lj1lp+Q636zjrzeEhA9QeGR7oeww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3m74O31g2Jnl7lwlJJmc5jdnDRmaJQ4DmZYEDVz1gc=;
 b=f+pAOfNHpFuXmRJ7eCwgeXIZWILSwOD/ApBTliiqd1knYEkx4Xl2/11Jq/2bQn3FGQ119yLM7aXTNu49hROBnXf3ZleZz2SwBJsrsWHcmMget/dfUKCXZv/8cKv2zDqP9n1F3+TePNUbjqJDuoEO0o4tyi280efPFWHlGqF9q0jAP2PV1Yy+Ly/fFNhq2nggQXH3xpyzbobnufoOPC5wRZATXGITwY6PpzOW1Sz5vzxmbJJufdNJrNomAZe3HAcaVaE4k6zFAa9QnyJc+biNUb3AkmhcOQuQxuz/MUMcIcaCTo50AWTG/FN2eQYgzc/R0eQMr4NUxbbpCAL3iF/VpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3m74O31g2Jnl7lwlJJmc5jdnDRmaJQ4DmZYEDVz1gc=;
 b=kf2R/cLjdG8I7KclfF9FVKLIt7jYfiN4hELzo0DsBIRV620GsS/6/QxN5wdJxVU+9AXChJhng6yp52YM+1dWLz1wqNpPic59YYf1/WJtQw32SWUNQXG7m7wtH64tSYnDzmepjUVLq5SY/BIqfWZMaZVw/qepsvVXK0w6cl5zfPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CO2PR01MB2182.prod.exchangelabs.com (2603:10b6:102:a::8) by
 MWHPR01MB3296.prod.exchangelabs.com (2603:10b6:300:fd::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Thu, 19 May 2022 09:06:25 +0000
Received: from CO2PR01MB2182.prod.exchangelabs.com
 ([fe80::2531:79e8:2eec:2620]) by CO2PR01MB2182.prod.exchangelabs.com
 ([fe80::2531:79e8:2eec:2620%11]) with mapi id 15.20.5250.018; Thu, 19 May
 2022 09:06:25 +0000
Message-ID: <e87bc3d7-6664-a1b7-faee-6117aa1d121c@os.amperecomputing.com>
Date:   Thu, 19 May 2022 17:06:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 9/11] perf c2c: Sort on peer snooping for load
 operations
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
 <fefc1f23-ea1c-6339-77c4-b0974cbd6e93@amperemail.onmicrosoft.com>
 <20220518061221.GA430350@leoy-ThinkPad-X240s>
From:   Adam Li <adamli@os.amperecomputing.com>
In-Reply-To: <20220518061221.GA430350@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:202:2e::13) To CO2PR01MB2182.prod.exchangelabs.com
 (2603:10b6:102:a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cde02f9-94b7-44cd-450f-08da3976d9e2
X-MS-TrafficTypeDiagnostic: MWHPR01MB3296:EE_
X-Microsoft-Antispam-PRVS: <MWHPR01MB32966D9E3EDF8F7193975D3BF5D09@MWHPR01MB3296.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eVxLflfKzYT4LOac/h7wEpRnTzI0Eo5Jh7LVYWtzUYx8WDjyvSJ6Hq/iY35X3Iozga9y85GlNXPpVxd+J7SjfK6myLJcfgaiXKw/5tIOf6Gqwz2Y4ESE8rMiNH7Cu4mZ5yZSQd3tf+aAyJrpE7Mv6cq6+cdjxR371VyU4PXDrwSQ9Xk8dOxSkeFHNxdWcc5JwJQabJeuH9GfaCav33mq60to5vZZSREWD0IVgswiuMNd3/TQpv9ZNlaqOKdH7waoSIsW7/zXTroWBgHi7ap6uGmU8K3NDVjC+E49Hq7j23+WEbgDJ0HiK7pkHUakFYdhm9XYbcxu8gGgtdTXZLe5eWyIrPgIBg06AzS4opUQLm1VBpbG52WomN/W8mFf9sYi6KqpOKQPf6Z2DmgFc+d1nu5usOtd7qyQHnSsK/E9r6GtxGC5bPezTAXWPoU8iy1YAZ3vvEPihSWjnkJp1vWFBEr9oR38m/Tg726TKBRYplZfCllTgEyBm2FoB9WayAR71vyfWb6/q3eFfvnk9Jhai3Ot5aT564nthABDwILazzi5IPI0zo03m6JnFqt++fkK8FbR6VZpAoCk2JZVzMv3dadGc8B1XSteHOZifwa9kgbvbrBtDKPRzOftVVMWzJOyukbXXxiV/qgeLzcQZ+ZgTabkKOJPItnxeck5nx4SyeH0nuI22aCh1LLo4yE7yccOdRiY1K6qhLES4sflhtCD0oa4wrpGdquUoM4std0IpniUapDeChtX/SKq6utxzAex+9CWHid7YwVNsSDJJ/IPy1BpoYeNuCLqZsEpwbva8+E42mFazbOUgydckNMKtPBo7VQdOhCg+huHP7CZrRk57HRxl5DGzR62o1Dc/PHKcE4vP+pu4QaqLivQm3IUVBwC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO2PR01MB2182.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(6666004)(186003)(6512007)(38350700002)(2616005)(38100700002)(26005)(52116002)(6506007)(53546011)(8936002)(5660300002)(66556008)(66946007)(66476007)(31696002)(6916009)(54906003)(4326008)(86362001)(316002)(83380400001)(7416002)(508600001)(8676002)(31686004)(6486002)(966005)(43740500002)(460985005)(2480315003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck5CRkE0SXdseTV2eHhWZmdENDVSZnFEMU1kWHRUQy9Md1VqY0h3QlViSWI5?=
 =?utf-8?B?OXY3Mm11bWdIdDJXVXZFaTQvRUVwRTNWWTBlV2VUdEpMMVBEc0JOMkVLVHRa?=
 =?utf-8?B?aFIrbW0yRTV4azVlREcvRWJYRTZFWDlGeTFLRUVOQ1ZOVzNEZzMzNW9xN3RX?=
 =?utf-8?B?VWE4ZFZabDFHcXU1SHBPWkJlZGl2MXNXcWNPWjIzTWtTR2NVeElRamtXRTFm?=
 =?utf-8?B?cWpGOFFWeVZHNUlzd3lVQUxpYlFXU1BWLytyTkpLc3JqN0xNbWhVYjZoeGc1?=
 =?utf-8?B?dUJsQzc4S1l3Q3RkYmRlbTlGWWdLbHV3L2NsaVpKN2JzbktwSlI1SGlKQWJF?=
 =?utf-8?B?YmJiN284Z1FRK1dSV0k0WjNZanJ2ZmlJS1lWcEpCeDA5TTRuazUyVDZ0N2lW?=
 =?utf-8?B?djkrTmkzamFoejlyVkpremQ0RXUvYTdWalE4ZVJ6UEFYNUdMQmh5RGRPbjNt?=
 =?utf-8?B?UkduUHBNYlh3MlNNSTU0YTBuTlg3dkJ6ekFWR0lXQ3NCdStLYVdaNWJUanZM?=
 =?utf-8?B?WWU5WVBCaDJNU0tldzU3MWlPUjdYbnNIWUlzWk9JNUVWaGs1c2ZKOFRrTURy?=
 =?utf-8?B?K2FxMitLNjdKZzkraHJKUXNiUFROZ2FZV082cHpmejNxYTR0V2hJVW04Z1RT?=
 =?utf-8?B?RERtMXpOQWVpdWNQT0x4cnlLcGM1NXNadU5mdHUwV1VyUTk1azU5Rk5OVmtO?=
 =?utf-8?B?NjJ0ZVJhTkpHY1N5Snk1RnVVS1BkVnlPeXVzSlV6bzNycHNEUVNpS3pTQ0NM?=
 =?utf-8?B?TWtSNGxKckd1d3lQbEptWFRlUjNnSEFMekhHUHF3bDU5Mzc5RGVGNzRaRE1G?=
 =?utf-8?B?ZS81WjFOM21jdXM0cHphWWphN1B0RThXYlpEVzc0bUVYZHFmRlp3Q1dzS1Jk?=
 =?utf-8?B?TUwzN2E4SVV1SmloOEZqTVZWdnhocVQyeVE4dmd6SkF5SUt0THhoK21HMzBX?=
 =?utf-8?B?eFBQTmVET2I5Z1dHVm9FSi96dWhkcWc3ZDBkVmZJNWRmSEh2dFphdG1uNUx2?=
 =?utf-8?B?eXNDNnh5d2g3eFFocS9vUm9Uc28yU3g3dHRHdEJEcWNlcGpqcmNYNGFMZ2RH?=
 =?utf-8?B?K0I2Vi9MV1k1Zk9qZ3E4eTNVS3JFRk9KNjQ5K1l4Z1ZGbWY2Wk5OYnhQZjA0?=
 =?utf-8?B?Rk9VQnArOWNQU3hMTHM3cnphQ3Rmc2NabWcvOXRrNi9reDdUQW1lcCs0NDEr?=
 =?utf-8?B?RWQwbm9XVTUvaGFsamZwWjU1UUVRYVlwTXlNYm5nRTJ6TE5JM1ZweWFZejVJ?=
 =?utf-8?B?NTM0TStaajRXWU9jQllabDBQeFNNekxZODhOcHB6VEJmMkFrMXlhK095U0xY?=
 =?utf-8?B?RFpLeEVqc3JtMWJnalEwZWlrNVNud0ZqUndLZkV6bUdva2dVSWxvQnIwU3Ru?=
 =?utf-8?B?WnlSVSt1K243d0xIMUtOc0t2UmpLWXZQbE5yQ3UxRVkzTDlsNzlhMHlLMGhi?=
 =?utf-8?B?TmhzZEJWQnduWElLZ2poelZlTTI5OXZKd0prNkNtdTFvN0Fmc01XMnA3MGtG?=
 =?utf-8?B?dEtuV21xcWZUMHlzL0xuNVZHaCtCRU9SdmUvY1lYQm5Fc0tEaTdjZXZ5V21n?=
 =?utf-8?B?Ty9RRWxudC9DQ3hXc0VmaStYdnZycFNlc2YrYi9zNVNPTnBUd2ZVWnBjZTFk?=
 =?utf-8?B?WDdUUGlrRnI3L1ZISnZVbE9ncFNzdHQ2Ly9xVmI2TXNvSTZYaTBlV1ZEUkhS?=
 =?utf-8?B?S00rU0lrWTZENkEyZ3lDdnh1WlhHNTVOcVBzK210TWorYnZHQ0t5VzkvVnFt?=
 =?utf-8?B?MHpkZkVySmg4RzJRMlRsWXJySE5FUCtzSEtlR3FGQ3RzYXBkZnJzU0NlbmVw?=
 =?utf-8?B?M2dUcmZiR0EvcVI3RjJUNVBTVzU1bnBQZTUvR2Zrb3BrWXdTV3FpSEZWUnVI?=
 =?utf-8?B?NWhMMUdaTXRvNEFVRVVZMlFEbVArbE80MGVUS3dkaHRzOG8rN2wvTW85dWZ4?=
 =?utf-8?B?VktxSU1COE1oczUweit5QStJcFd2UG9vSGF1Q3VrQ0s1RXVnTm9mdnlySU1J?=
 =?utf-8?B?eE1hWC9yZTVtOVIzQjNyL0lFL3hMN2R4T3g0R1d0djg2TGpkMmEzMkZsem9N?=
 =?utf-8?B?cjd6UjI1Q052NUdLK2VJMVFEWEtaRHZ3Wjl6ekxiTTBUOUhuQ2EzZ3FmYzZF?=
 =?utf-8?B?TUtQSVFFYlYyc3YwSDVqcGp2QmRJUTBzYUhoMzJnM2xTSWppVzQ4enkwd0d3?=
 =?utf-8?B?cStqVzZhZVNSZjcybU5xcVJxN3QwcUJnR1J1L2dOU2xGWVpxeTlzclZ0dmUv?=
 =?utf-8?B?eHhLOTV6dGh4VVZOajFKYTVlZE1iTlFxeGJVTitCbW42OVNxOXpFa0tEVFpF?=
 =?utf-8?B?QVYxM1pSZmlCT2REKzZ1YjBESDVLMGRVSUJtV2FkbVlqcXdmWW9FalNXOWlG?=
 =?utf-8?Q?Nztha6j0MN4naOG1KvRxpQExHohOI9Rul9C4S?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cde02f9-94b7-44cd-450f-08da3976d9e2
X-MS-Exchange-CrossTenant-AuthSource: CO2PR01MB2182.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 09:06:25.4036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smtUyFw/9/tb3qW8N7qSHNNW2SUJks1x2ppGEpnkszAT16fvhW4Hrid4eF3Z6paeZ8+eEkpMqt3rZ2I8XA5DXTKNXVlNXjmr3PKZGICniNhRNRuPKf69z2FbC0/Pf8b9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB3296
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

Thanks for the update.
On 5/18/2022 2:12 PM, Leo Yan wrote:
 
> Please note, in the total statistics, all remote accesses will be
> accounted into metric "rmt_hit", so "rmt_hit" includes the access for
> remote DRAM or any upwards cache levels due we cannot distinguish
> them.
>

Agree that "Load Remote HIT" makes more sense than "Load Remote DRAM".
 
> From my experiment, with this updating the output result is promised
> for the peer accesses and it's easier for inspecting false sharing.
> 
> As you might see I have prepared a git repo:
> https://git.linaro.org/people/leo.yan/linux-spe.git/ branch:
> perf_c2c_arm_spe_peer_v3, which contains the updated patches for both
> memory flag setting and perf c2c related patches.
> 
> Could you confirm if the updated code works for you or not?
> 

I tested v3 patch (perf_c2c_arm_spe_peer_v3 branch) on 2P Altra system.

Compared with v2, "Snoop Peer" can better indicate cache false-sharing,
for the 'false_sharing.exe' test case.

Bellow are details:

# perf c2c record -- numactl -m 0 ./false_sharing.exe 2
183 mticks, reader_thd (thread 2), on node 0 (cpu 78).
195 mticks, reader_thd (thread 3), on node 1 (cpu 124).
546 mticks, lock_th (thread 0), on node 0 (cpu 0).
562 mticks, lock_th (thread 1), on node 1 (cpu 123).
[ perf record: Woken up 36 times to write data ]
[ perf record: Captured and wrote 72.440 MB perf.data ]

# perf c2c report -d peer --coalesce tid,pid,iaddr,dso -N --stdio
Warning:
Arm SPE CONTEXT packets not found in the traces.
Matching of TIDs to SPE events could be inaccurate.
Warning:
AUX data detected collision  20 times out of 168!

=================================================
  Total records                     :    1198728
  Locked Load/Store Operations      :          0
  Load Operations                   :    1031196
  Loads - uncacheable               :          0
  Loads - IO                        :          0
  Loads - Miss                      :          0
  Loads - no mapping                :          0
  Load Fill Buffer Hit              :          0
  Load L1D hit                      :     970636
  Load L2D hit                      :        292
  Load LLC hit                      :       2477
  Load Local HITM                   :          0
  Load Remote HITM                  :          0
  Load Remote HIT                   :      56459
  Load Local DRAM                   :       1332
  Load Remote DRAM                  :          0
  Load MESI State Exclusive         :       1332
  Load MESI State Shared            :          0
  Load LLC Misses                   :      57791
  Load access blocked by data       :          0
  Load access blocked by address    :          0
  Load HIT Peer                     :      58814
  LLC Misses to Local DRAM          :        2.3%
  LLC Misses to Remote DRAM         :        0.0%
  LLC Misses to Remote cache (HIT)  :       97.7%
  LLC Misses to Remote cache (HITM) :        0.0%
  Store Operations                  :     167532
  Store - uncacheable               :          0
  Store - no mapping                :          0
  Store L1D Hit                     :          0
  Store L1D Miss                    :          0
  Store No available memory level   :     167532
  No Page Map Rejects               :       1234
  Unable to parse data source       :          0

=================================================
    Global Shared Cache Line Event Information
=================================================
  Total Shared Cache Lines          :         45
  Load HITs on shared lines         :     226254
  Fill Buffer Hits on shared lines  :          0
  L1D hits on shared lines          :     166010
  L2D hits on shared lines          :          4
  Load HITs on peer cache lines     :      58814
  LLC hits on shared lines          :       2455
  Locked Access on shared lines     :          0
  Blocked Access on shared lines    :          0
  Store HITs on shared lines        :      96403
  Store L1D hits on shared lines    :          0
  Store No available memory level   :      96403
  Total Merged records              :      96403

=================================================
                 c2c details
=================================================
  Events                            : arm_spe_0/ts_enable=1,load_filter=1,store_filter=1,min_latency=30/
                                    : dummy:u
                                    : memory
  Cachelines sort on                : Snoop Peers
  Cacheline data grouping           : offset,tid,pid,iaddr,dso

=================================================
           Shared Data Cache Line Table
=================================================
#
#        ----------- Cacheline ----------    Snoop  ------- Load Hitm -------    Snoop    Total    Total    Total  --------- Stores --------  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
# Index             Address  Node  PA cnt     Peer    Total  LclHitm  RmtHitm     Peer  records    Loads   Stores    L1Hit   L1Miss      N/A       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
# .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
#
      0            0x420180   N/A       0   95.53%        0        0        0    56183   246056   219522    26534        0        0    26534        0   161914        0       106        0     56176        0      1326         0
      1            0x420100   N/A       0    4.37%        0        0        0     2571    76437     6576    69861        0        0    69861        0     4005        0      2335        0       236        0         0         0
[...]

Thanks,
-adam
