Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51C153B3AD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiFBGgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiFBGgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:36:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A8D21DA1F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:36:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T64xZhjGtq/0iXrfD2yVJZ6VlwUI1ljmQ1Vc3jfAVwAQ95O3Db6KOn9S8CATjpJzoqnzlgBGqcs8A/03Uty1kCSNMF7ldKWfggvJtl2sP+PTZ73PmvxJvKG8CcRJz++whnQOokkN/r0BJPUvO2Pul6PBs1jBSgFGXooVIHFNbRyYX7NJLAFxI6nyhFyfMxZCLe1MJpEeH7/PGfI1xJfaMBC74xcKaBXKX9mnsOH5qVfHiP2jrcA1Ft7VxVcO6iYYwSeiR5PNJe1RBxXw41/EcwofMIf8AQ/leasTBRZghmDA7xVzioYcrDr+EybTYmtd7V579mvjBvxw+ffRO4ZXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xapo2MgDRMlrt8kPkr8wHqiJ9bNam503z464QV3jyaM=;
 b=kVZ7GChvNp7rRBwOsiXsYBunkajyGP2R07KPv+TIjLoAPO7Jirw9770mJkNfIT6JcuFp+bD6ZzygrcakGLWd5OAvEioEAkpvObpDPas7sVzsEj29NtKw0ZLwIJMaV4bBS1ThdBeIxzuTy9zqw3ubICbOivw+vNuJK/cELlTKJos8QPo0L1ztCezWLr+kwZsf8LbDHTxUCVMD1TkZa2aM7tfz8sOHciE4/ZGmr/7zzABG+U/bhx3r7sgt6mGXn0xbe3rkG1sv3k1xGBdPSzmdSjXYYebfkfO6tWqzPtcybWXENpTJYyXiak6hhPADRzBowkUroAQi79daw8XOLDRT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xapo2MgDRMlrt8kPkr8wHqiJ9bNam503z464QV3jyaM=;
 b=jXMgbK5MWw6vJaGXWiYEqmbfIP0ru1OFNJxZMF2Fm5QxrQcJ1/zIMjiTKeZCREfCc3h4W5Vn+CSQChvAgy4AkkvgoHmGKLMtblMmOrnfj5cdMaG5M2kak8tnE5uJUIEaaeGJFhfZ8G1JRjtWid7KaY2qWT/mTKIJUqWspr/6pMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 06:36:38 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::d978:617e:55a3:cfd]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::d978:617e:55a3:cfd%5]) with mapi id 15.20.5293.019; Thu, 2 Jun 2022
 06:36:38 +0000
Message-ID: <d45374fa-6e51-36cb-9a2c-96f85d9de528@amd.com>
Date:   Thu, 2 Jun 2022 12:06:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH v4 4/7] mm/demotion/dax/kmem: Set node's memory tier
 to MEMORY_TIER_PMEM
Content-Language: en-US
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
 <20220527122528.129445-5-aneesh.kumar@linux.ibm.com>
 <5706f5e9-0609-98c9-a0cd-7d96336d73dd@amd.com>
 <8e651a1e-d189-3e8a-438f-298f21402bd2@linux.ibm.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <8e651a1e-d189-3e8a-438f-298f21402bd2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::10) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91c72394-bfde-4a8a-cab9-08da44623eeb
X-MS-TrafficTypeDiagnostic: MW3PR12MB4345:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB43459131C1803D154A9F50E6B0DE9@MW3PR12MB4345.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RWb/yzLFB/BDX80nlYr2gcGwoAMkNOcoM7fHl5agOVQD35unQCrtvY+yx8smScyo8lp1m5EZ0AgWDzsMYXQfgo2TiAy5zzmzLhH6U0j6KGPZ0TwrvIIPPQiAgFYKwa4H/UA9b4Nhpuiu2LRjGh8gSwAjVYR/NJHpbC+N3CeOKRdN6Ln1r1OwgSI/q+H7t5a4unidfjm8JyfKPNe62bbEBoiorNnWaeIsD1LPGNE4HGe9ccHsgvM24pxXcswYsTytDxVfxUG4IA5N1dN3Dh2jgTWT9c74/nL1FmLVhz3LWhiSrzQ76tb4h1khaB5XqeMJH9V0ypeACmPYBdGNArLkP5SRnitULbAVgKbJp2P/wfyLknrZjd2uIJ3ysipmCkBO5hN0PAJtnc75NgXBh7In+hwXBrJG51OKcZ8dVyp/JO5H/6ujjzEljejXvAZmF1iAD6uCVvPz720IZcUqo3EcQ9VYIckkqQHdK1QGr4x/os+zDiDdIu10vZteMAQbOt+GzfgxTUgl9+gmiIfMgf63dfJRb2OmHAghrDrC3APgZ4RH/cPsjwOm4zk1rY4ZyLauuyIe39D0oa18PuoMDexqGOHHI7i32FKR5M3I5hE9kpGsoqTbFs4cMSoWy7Q6Gh4q2VDNqSrJPjSSn883nnFwXhbfn6wgUZjI/KMQv/M4zDW3fItBsEa6zmS6yYnubDdtZuoyr4cI97T9Xp3L9A5rgumYe1GGI41WGqbEE9Di1Bc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(8936002)(6512007)(53546011)(186003)(66476007)(66556008)(316002)(36756003)(31686004)(8676002)(4326008)(66946007)(6506007)(508600001)(6486002)(7416002)(38100700002)(2906002)(5660300002)(54906003)(86362001)(6666004)(2616005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEREK2cxaWI4aEMrRytPc0lIY1J0V1NpMkZvcE4yUnhFNkE4UXpWeDhHQm82?=
 =?utf-8?B?cFNFMGRQeERIUi9ORi8vSTBLdHVhUVFuSWtKMGNTYnYvaEtURDZCb0xtVEMv?=
 =?utf-8?B?OGdZVmVEaHNFTjRuMTdydXlSQlhWQTNUcFNWR2hWMktGSmZDeHRBRVBQbE1H?=
 =?utf-8?B?ZzRVWEIybU1KUFJ6RjVKekdVSXFtaktYanQvb0E2QWRuT1RTZWxyY2p3YS9k?=
 =?utf-8?B?aFliQ1FDWlUydnBuSmdXYWVpSWlUd202T2w5cW1xMGdIQkhEQjB6MllicEhX?=
 =?utf-8?B?bVNFRUpMdW1TZy8yRTdoM285ZlBPKzB5SjAyWTRyQlVaWUdsZVZLajhkWUZH?=
 =?utf-8?B?bFE1VjhKeWVOc3lDK0Z3d01yOHVqM3RtNXREVEUyNWhuaGV6Rm1iUEI3akpr?=
 =?utf-8?B?WEVCUkhJMG9EdVpmSnFjNFEwN20vT0JRRERzUFUvTDBzQjhzTEdxUi9wZkRn?=
 =?utf-8?B?UVZjZ0FsWm5sUzl5QWZ1WmZ1SnpRano5c3A4QzM4OTU3bVUwd1hTclVReDJ2?=
 =?utf-8?B?bjVidTZwRXQyK29sZldxVTNtQ1lCdWc0VmxUQlVlZVZyRWVxZ1ZHUTFxeDZP?=
 =?utf-8?B?dGgvaDU5NjNDd0JpU3hQTkREWWs0WElkM3FJU2JZUk9LMUNOM013MzNoWnp0?=
 =?utf-8?B?Tk44WG0vaCtrWUxMMUNoNmZlZ1dIY3h3cVlMb01sTngwM0U0b1Z5QVh1dmYx?=
 =?utf-8?B?MkZXQi8yNnM3Zys2eEI4QW42RkFpZUNnSWpuWmhvUkFnUTU2clNMWnZlSnA1?=
 =?utf-8?B?RFc5VGNldDdORHZiaEt3a1Q0eWZDQndTZU9FYm9QSHZDVVl1ZWNoVU9jTUhH?=
 =?utf-8?B?Y1phTkMxVi83MnhnL09kc0EwVi93Y3V4bXVZdTJ4MFBZZUZ1SEhYRU56UkNO?=
 =?utf-8?B?OGl3S3lxQWkwMm82QWwzUTYraTJXRjh2RjJMWHZUa29pSXpVMzVMRXh1NW91?=
 =?utf-8?B?aGhHN1FEd3BlbTU1MFhMOHZOaGJMMDVmbTNQWW1hWUN1QlZVQ25kRUFWVlJ6?=
 =?utf-8?B?R2ZTY05aenNidHBVYU5hcVhNTjFXZk4rN0E4MDRLc2JsOEFwaHVOU2ppU2hp?=
 =?utf-8?B?QUpsQmlnNFgwMHpsNHRWaTNOekNJS1BxR2M3YTM3SkRMVHpSNHlEaE90TGdK?=
 =?utf-8?B?dkxTQ3RURTllQVlETk8rd0lueG5jWUhGSHZiaEtsTk1JWmljUlJNK0xBSXZV?=
 =?utf-8?B?NE5BbkdrMUE3Yy9JOWEwNlp4SWhKUlNJVng3cmNxZHUxM01qUTQzeE0rYnFy?=
 =?utf-8?B?cWZlOWNhS2Y3NENyb1Y3eHpodkJOT3FGTVNHZWtyT1hSVTZBczVKYlM0K2wy?=
 =?utf-8?B?UCtnTkxwNHEza1NGWlZCeXkwelNMZ0JhRTM5MUdsYk9OcFFBK3JTYngwYi9z?=
 =?utf-8?B?T2xsN21LZ3hDR2FQSFpiWXpKc0lYb2FYcEQxMGx3eDU5VWtGa2JUU29CYXEw?=
 =?utf-8?B?dnVlZzd0TUMyMWs5N3N6TUhLU3hqb28xUTZZaWR4Mnd2T1p6c1k1WWI4NlNE?=
 =?utf-8?B?akp2djNiK1BGS0JPYzdIbkhvc3N4bVZXTDVpRFp6N0JOVGxwRlh5dG5jU0lG?=
 =?utf-8?B?WHlQSVJoTFkyc2ozWFFaelNSa3MwYytaOTRlN1FGcGw3RjRuM0FnOVhVbWNw?=
 =?utf-8?B?MlVFRHF6SlJub2FQQTkvdU1LTW8xT1pMRzRqTWRRQkxPNUZwQW41bURzVGpM?=
 =?utf-8?B?SUtodk9UR2dPQ3U4bWQ3WVMzR0FhUTFXbThDczI4aUJCekpYcit0b1VUR29t?=
 =?utf-8?B?a1AvRGdGOEJpZWdTaVNXeGJtcmo5TEJ4Z2Jnd3JxQ0pldTJZTTlyb1c5Qndl?=
 =?utf-8?B?SmlzVkZkTGhHNXBnWXlIUWRMbUNiSFJ6emRrMXNiOHljd2hFWCt1MGo3c0ZH?=
 =?utf-8?B?dmRHcEpYSUtaZWZWb20zQXR2UE9ZYW1tWXkrMVF3Z2x0eTdrT1ZXYVluOGww?=
 =?utf-8?B?UC9rR2xiVzlxYTU2QVBncUlZWXNmT0VUaUlqYnNCVDdoWFd2bnU4TU1tWjUx?=
 =?utf-8?B?d044ZXNGbG1VVzIwNUZiREdDelJYSi90SFhUc21nQmk1R0ViVDZSdlh4V3VB?=
 =?utf-8?B?dm1BY0NMVUdiUDJmbm5UMGo3Y3QxaFdCdmhmVVZHeEozRzdCRVY0NjJaY0tQ?=
 =?utf-8?B?NFFZNXV4YWNmd3g3WlF3WWdLRGU5YXNidVZZWDFzV2M5dTE1L2RJWmpYdUtV?=
 =?utf-8?B?UUtqVk9sRjA4TzRlU3lvZWV1TnlqRktyNXllMnlxOHk0SUg4cmhYcCsrazNG?=
 =?utf-8?B?SGJkMlZNSmR1eDAxMXFhRjh1cGs2Mi90UFlpTkE0c3g0bGU1OExtV1pMU2d2?=
 =?utf-8?B?M2wxUEQwajlsTkhkS2VSaDF3TG0xcVdMRHhGaDB5NEdVWnhETjIzUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c72394-bfde-4a8a-cab9-08da44623eeb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 06:36:38.2438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zxnS492TuVJNLRzFvSX9PjgvBLTpfpL4nsVG/9yvcZnczqi2+zTtJnRq/f/bIwFHsYXsu9k9p/VWmqikAuQlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/2022 7:19 PM, Aneesh Kumar K V wrote:
> On 6/1/22 11:59 AM, Bharata B Rao wrote:
>> I was experimenting with this patchset and found this behaviour.
>> Here's what I did:
>>
>> Boot a KVM guest with vNVDIMM device which ends up with device_dax
>> driver by default.
>>
>> Use it as RAM by binding it to dax kmem driver. It now appears as
>> RAM with a new NUMA node that is put to memtier1 (the existing tier
>> where DRAM already exists)
>>
> 
> That should have placed it in memtier2.
> 
>> I can move it to memtier2 (MEMORY_RANK_PMEM) manually, but isn't
>> that expected to happen automatically when a node with dax kmem
>> device comes up?
>>
> 
> This can happen if we have added the same NUMA node to memtier1 before dax kmem driver initialized the pmem memory. Can you check before the above node_set_memory_tier_rank() whether the specific NUMA node is already part of any memory tier?

When we reach node_set_memory_tier_rank(), node1 (that has the pmem device)
is already part of memtier1 whose nodelist shows 0-1.

Regards,
Bharata.
