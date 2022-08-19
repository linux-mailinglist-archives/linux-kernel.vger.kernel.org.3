Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097C359955A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346094AbiHSG1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiHSG1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:27:37 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF465CD78B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/tmfIH0sCM9ctOn5X+y5pQskvOcpQXstBXp3Wl9VEXHL9OKy6/em3JwLjc47G5Zv/pLRTNULIxwFXrHS2CJ0kGOOt6AG2J6EgJq7n2a3ZcDBIlDMFs+cQuhWh9gqj4VfQMj1u4wYX+WEVS4YJtH59r4Ek5jZRRyk75GkqMFy5G2XLT37e+lU9mH2ei9+Wc6BHakmce/tjzZFddBcCrYm/p/MGt3ka1oc9yE6iqAZ/Rdca+XIt2ySXiD+xeCJ10lkKzRos+YUJpOsQv929cN1+ZwKcVCp/Z4VJ85H1ksJj9eyCwrZ2Jyz4sqrP0lmS2Rkb33oe3fKeyINnfoI21sfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHk05LO+LBJjh/R9SP60yok7XY9X59w51ld+0p3j6yE=;
 b=jS08HGLs5mi1fD+7bJflCrPPoYNoJjAiVHUnFezgt/wvLAZy5S50ZhrgSVJDS15JtDO3lfkrkAQaosQlacpQoHBCK7AM+4i180h+9vroWBH9JhXbU8CjK55busRP1llL0yMjvPwjNWfOZmYRyHHonqiV2QA1rO0HLLLzVSEcCCnk8h8DrxcAXTDwV9f8TX+XSukwxlrWFKqEDaio7vTXcmZJkDTHUIBNaXr4nue8Jpd/6B4p5wJWl1oxYcQwCWPOWo3F63wX2bLofvCbtnCDLP1GcqFJNJLotj8roHcAAooj+Lsvuk/v6vTXc+BZh5lW/TJMNes+dgcax9jOh2Xmkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHk05LO+LBJjh/R9SP60yok7XY9X59w51ld+0p3j6yE=;
 b=fvSeX1V5rmP4LmLxK8EIv8csy7xSDxw0MmPFJFs5xAUVG1GQe+K/wafnkFodXb5lIrCNRQHjkwe3g3EX9bVmTrRWxBPsN6QBNHrID0U/jDM4EJdZORnVAX4QdqfhduPevlx+BnrlxgogvccTSuw6bH6CnweoUzjnVoiqvUmWxvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) by
 BN7PR12MB2738.namprd12.prod.outlook.com (2603:10b6:408:2d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.16; Fri, 19 Aug 2022 06:27:32 +0000
Received: from DS0PR12MB6439.namprd12.prod.outlook.com
 ([fe80::141b:7635:b118:7db4]) by DS0PR12MB6439.namprd12.prod.outlook.com
 ([fe80::141b:7635:b118:7db4%5]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 06:27:32 +0000
Message-ID: <137cf90f-abf9-4a6d-08fb-ef3922685ba5@amd.com>
Date:   Fri, 19 Aug 2022 11:57:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v15 00/10] mm/demotion: Memory tiers and demotion
Content-Language: en-US
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
References: <20220818131042.113280-1-aneesh.kumar@linux.ibm.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <20220818131042.113280-1-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::27) To DS0PR12MB6439.namprd12.prod.outlook.com
 (2603:10b6:8:c9::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bba7b28-501c-41d8-bc48-08da81abe5a4
X-MS-TrafficTypeDiagnostic: BN7PR12MB2738:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mqwyQaQSt+fOazhSOIK1LtAlehKWYPXX9YksgnOAXWg+hlH0k6too4AAvcN05fywlYgJ7iDu61b7iq0CzpMpWp5ZmZnga/BjuRRJBobYMcCnQihds7TB5rr1X1Vl7Fy/YvLw7iLD/VMg8QKUc55NpJ9Ono5OSipNU9H0UL4S65wzuQisHPhe05IhwB/zu5BGmy4gbcaBnNUkOQ1tIBv8CGDROay1AvtS00EDtjY07g99/wsSqtkOmiwdhIbHb1K2jRFU3cHJR4gArF00HRvyUOZnc3tQEYJl45PD+Qif7ka5ZvR7yVreVWTzVxYaGQeUsKvIlsPGnn1Epphj/fD4arga+G49Gre4E7kqRgeHU56C/lta7uUCk60m6YTJLkbTTE678dtWUv+x6kFobov/bpdhLbrrz+Y1arntxVBLknlxf36SfPfejXDc+QYwMr5shrorSC2KgjAnblfQVUSczGMjEdV9sRKlo/s+YUQsGE7xTgG789gEOkpUsB7mVA0ecVL9BWQvtlbCbJ+WkptqMh6j+OcuXR2iSCpkSJ/zQgJeHJO7oEn8q+iGPLNarRyrGKCG3ZSzxCkKSpn5qDqrjdRrhz6IQa92qHDg1OwgTRlTjhZZxvBNRNR+Sz1xowh/Peg5rJ/WjdkMFg4hRdFhbh6bWwFk6S06hiI679nmZDduBOjkKjtjxfTaz5SW14OV1uD+vMZuXwcwddbfcisG6hqZq49p6c5s63VVS8fES7S4hwiSzxt+ZKtS3OqnIouaF9DxJ/U+HFYMsYPkkloVg9wIWN9EzhDX5oQMPfzAgcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6439.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(31696002)(36756003)(86362001)(31686004)(38100700002)(53546011)(6666004)(6512007)(6506007)(186003)(83380400001)(2616005)(26005)(478600001)(41300700001)(54906003)(6486002)(316002)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(7416002)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGlaZ1lYNm8vMmpYOEdLbyt6L2tNOXdNejJEckRNa3BYbXRmOVZEcnJadmk1?=
 =?utf-8?B?VEZoczdLekhDUitFS1VPUzdRSWtIcWdPaitYVUpIaENRd0owRCtyQzkzNVNR?=
 =?utf-8?B?dzVxNVlXQUtnNzRVZng3MjBiVTR2Y3U2Q1k0RmZHVjY0MjZyd2ZQNWd3d0dF?=
 =?utf-8?B?YTlOVjQwZGZwS1NYbXdRVnM4NkE4MHp1TEFSZXd6ZHNad1NUTi9ZVDNYYlhH?=
 =?utf-8?B?d0RLOUtzdFpURnBDMFVRTUJNWFJteEhCdno0eEFIblZETHUyU3FIaHpBekl6?=
 =?utf-8?B?ZEZSdlkvSk5CeURtcjY3TTVKMEI2R0xKRW5mdHZ6cnhMcjMvSDVuUURndVVz?=
 =?utf-8?B?RW5DU3lNZTBSY2pvVzdsblZrZkRKK1VqVVBncG00UWJxOGxYWG5SakcxTllo?=
 =?utf-8?B?bGh3aHpSUTh2ZFpZcUhEakNLVElwSkFEcWhZKzQwblNqNzQ5NVBZR1JEZ2R0?=
 =?utf-8?B?Y1c4VHBlREpwU1FaQzY4dE91S3plSlpzYU9NcCtUV1A4WGlTNlNpTnF1a254?=
 =?utf-8?B?YzhscDlMSjMybjNGdmZWbDVuTXZPNmIyTWtkWTNhb0JPT3RQczhRbFE2WWlM?=
 =?utf-8?B?bFBmTTRMZkdGMkw4SUVqNkJmbVJUYmhyb09SRFZGdHJNbjF5dmg0MzRzUFRy?=
 =?utf-8?B?S3NRb05qcC9KM21hR0grS1RXSFNrd3ZPYkpQMXBsL003bWl4eGtoNHNDcUtX?=
 =?utf-8?B?WWdLTVEvaUFHU0w5b3pLOGx4bW0yRHlsV0U0aTArVlNaVFRUVjl0YmxVU24x?=
 =?utf-8?B?ajNGUFpuTytFaUZsYlVJQXBSK3RvSDZRU0hoRkdlbXNGRFBHM2tJR2FRQ0M3?=
 =?utf-8?B?WCttRzJGc252N3VwYVI2MTBBeTRPS0RqVWpjRTBYNHZMOEtkN01yM0lQYXd5?=
 =?utf-8?B?R3VhS3lOSDJJczRCRTErTlJqU3JrdjFHY3FadXpkSUJqNHFzTDljcHlXN0Jk?=
 =?utf-8?B?TjJHS2lwY3VzaDZuYkJjbktVc3hXcHN5RE1vbC9oVEdMTC91dWtFMWI4bW9z?=
 =?utf-8?B?Sk9nOTU5RG1Odm1VVjY2dkFpemdxTHlhNmlKSHgwR3N5MEh5K0Y5RTQyVGhj?=
 =?utf-8?B?STBUeUtydDg0NCtvc2xxMTE4ZGVVc1R1VVdITGEzUEUxcVF3SlBJdlVqUGtM?=
 =?utf-8?B?clc2RjJpakVuNDZIWS93RVBjcVdjZndocXJFRXV0M1pxV29tczVLNTVuRmI2?=
 =?utf-8?B?cHVCTnZsWTdlTFEwemgxVWNIQVJKMUZiWGxQTXN5REthdm5yTjlVZW1nUk1u?=
 =?utf-8?B?eG5vc004VEZLRHJlL09GTVlwNk5kMC92bXJ3dy8vM0hTT3p3Smg2VWowRDE3?=
 =?utf-8?B?dE15MVNoeW1xMkE4cThKbVhLS2hHZHJieDJKK1BmdGJjNnFOa0wzYVh2cTFq?=
 =?utf-8?B?SXdMR0VNU2hKdXhDR0pWUHgra2RNVzlnSDc3aHNEeTZDaGx2eEhSZlo1Z00w?=
 =?utf-8?B?dDlMdTZQQkVnYTM0SDJKM0lwSXlSTnNUQ2p1YTdsRDZkakFFN1VpQk82QkRH?=
 =?utf-8?B?MjYrZHQva3R3S2plbWhXeE5mTnR4eXRma2xiME5zbHFYMDBOemZzdHhqQ2tP?=
 =?utf-8?B?K1RCVkFvVDl1UGVlajd6bmFRRUVFY0VncEpkcUtVM21wMlZRZHlHMWtOM3E2?=
 =?utf-8?B?aU9JbzNzSEZtVTJKNzV2YlJXaTFWWEFYWHo5Ym4relBoQjRmTHdXTHVoMUpn?=
 =?utf-8?B?QjhWUmp5RW5GOVc2TEkvdGc4cUsvemp4L0gwQWVwbUprUStDTDVOcGJGWXkx?=
 =?utf-8?B?dTA2SnFEd1RoemZEWWNLRmJUc0UrU1FSTzd2bkJ0LzVDMjVCWUNXMW9jTWRv?=
 =?utf-8?B?Qm9UeVArRHFnTy9uVWN2cXZHZXBQS2VrZGRiWkJWR0o2VjhtME1TdFZwQmlJ?=
 =?utf-8?B?cmxuZWJ3YlMxV1V6ZkFhMXZwRUIyanZDS3JybkdWYk5RWThKZ0VBdVpoTWZ5?=
 =?utf-8?B?M29GZFl2eWNqY2ZmWUFvQUY1ZElKWWxqNnBLSEMybXFMZHdQMDJvT0w4dDM3?=
 =?utf-8?B?VExvMkR4dFBZQlFGamJOb0t2OHQveDEwQ1pkVko5VjBGc3JRZTZsV0hqbjFV?=
 =?utf-8?B?NW5JOEEwcVJMMFRqQ083UWpmTnZmZk1GQk1CNzV5NzZHRWtzd2E3L2VreDJC?=
 =?utf-8?Q?u0JozBGNsRUYGBlE/ATW+h210?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bba7b28-501c-41d8-bc48-08da81abe5a4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6439.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 06:27:32.2589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8vOlY/zb/YM29bkaI5egyzHRUjVs6IyrT7oS/M8uh+U3ucoyjqJVoe+DVy/Ga+big/neTUm8f3pDzveuIVPLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2738
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/2022 6:40 PM, Aneesh Kumar K.V wrote:
> The current kernel has the basic memory tiering support: Inactive pages on a
> higher tier NUMA node can be migrated (demoted) to a lower tier NUMA node to
> make room for new allocations on the higher tier NUMA node. Frequently accessed
> pages on a lower tier NUMA node can be migrated (promoted) to a higher tier NUMA
> node to improve the performance.
> 
> In the current kernel, memory tiers are defined implicitly via a demotion path
> relationship between NUMA nodes, which is created during the kernel
> initialization and updated when a NUMA node is hot-added or hot-removed. The
> current implementation puts all nodes with CPU into the highest tier, and builds the
> tier hierarchy tier-by-tier by establishing the per-node demotion targets based
> on the distances between nodes.
> 
> This current memory tier kernel implementation needs to be improved for several
> important use cases:
> 
> * The current tier initialization code always initializes each memory-only NUMA
>   node into a lower tier. But a memory-only NUMA node may have a high
>   performance memory device (e.g. a DRAM-backed memory-only node on a virtual
>   machine) and that should be put into a higher tier.
> 
> * The current tier hierarchy always puts CPU nodes into the top tier. But on a
>   system with HBM (e.g. GPU memory) devices, these memory-only HBM NUMA nodes
>   should be in the top tier, and DRAM nodes with CPUs are better to be placed
>   into the next lower tier.
> 
> * Also because the current tier hierarchy always puts CPU nodes into the top
>   tier, when a CPU is hot-added (or hot-removed) and triggers a memory node from
>   CPU-less into a CPU node (or vice versa), the memory tier hierarchy gets
>   changed, even though no memory node is added or removed. This can make the
>   tier hierarchy unstable and make it difficult to support tier-based memory
>   accounting.
> 
> * A higher tier node can only be demoted to nodes with shortest distance on the
>   next lower tier as defined by the demotion path, not any other node from any
>   lower tier. This strict, demotion order does not work in all use
>   cases (e.g. some use cases may want to allow cross-socket demotion to another
>   node in the same demotion tier as a fallback when the preferred demotion node
>   is out of space), and has resulted in the feature request for an interface to
>   override the system-wide, per-node demotion order from the userspace. This
>   demotion order is also inconsistent with the page allocation fallback order
>   when all the nodes in a higher tier are out of space: The page allocation can
>   fall back to any node from any lower tier, whereas the demotion order doesn't
>   allow that.
> 
> This patch series make the creation of memory tiers explicit under
> the control of device driver.
> 
> Memory Tier Initialization
> ==========================
> 
> Linux kernel presents memory devices as NUMA nodes and each memory device is of
> a specific type. The memory type of a device is represented by its abstract 
> distance. A memory tier corresponds to a range of abstract distance. This allows
> for classifying memory devices with a specific performance range into a memory
> tier.
> 
> By default, all memory nodes are assigned to the default tier with
> abstract distance 512.
> 
> A device driver can move its memory nodes from the default tier. For example,
> PMEM can move its memory nodes below the default tier, whereas GPU can move its
> memory nodes above the default tier.
> 
> The kernel initialization code makes the decision on which exact tier a memory
> node should be assigned to based on the requests from the device drivers as well
> as the memory device hardware information provided by the firmware.

I gave this patchset a quick try on two setups:

1. With QEMU, when an nvdimm device is bound to dax kmem driver, I can see
the memory node with pmem getting into a lower tier than DRAM.

2. In an experimental CXL setup that has DRAM as part of CXL memory, I see that
CXL memory node falls into the same tier as the regular DRAM tier. This is
expected for now since there is no code (in low level ACPI driver?) yet to
map the latency or bandwidth info (when available from firmware) into an
abstract distance value, and register a memory type for the same. Guess these
bits can be covered as part of future enhancements.

Regards,
Bharata.
