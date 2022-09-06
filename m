Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A812E5ADC58
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 02:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiIFAYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 20:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiIFAYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 20:24:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1999586
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 17:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662423871; x=1693959871;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UaxP2m2G8Sm9OWWGffOpG8K1Oa9mwBrC2OvoPCZ933U=;
  b=XdxdHziUfmJBARZbNd+FAcdK5RZwU0DOnt6vP6sk7imT9FpNEnpX33nu
   Ai20ztDo7v70YV+5VZsPDlZWQnTczXFTBM+UhhG3VlpIElP1RDlPbK2II
   qn81iY84ieQtmzgqmvb0x0kiJ88KhgV3uvPGFdsx5WMyiL3QzRynImkbE
   RXxoDT9LgEuhmpQlq7dOEVHrsTvyFzhgNjHUJOW3RI3zqzFYGFK5Zpwsu
   v6sG2LvSi7HGUsLveohb7z5ZHCkiNmUfyGCw16V7ShzhFFSWup8BA72GS
   kgJmJq3e7HL5utXf9xa6HwA91I6ZrTH+7PHAeG8FQPEY1J645rM6Dtr93
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="283462278"
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="283462278"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 17:24:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="613913424"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 05 Sep 2022 17:24:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 17:24:28 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Sep 2022 17:24:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 5 Sep 2022 17:24:28 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 5 Sep 2022 17:24:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyM2Dngdg9PukMZx4sJ9B8VC9mqwdmd5Cpec8w1ov5UTEi5V5pxuVoy2EvN6Z2zZWlOH3+CVkkXszrnAhPzPgE3FZxOZXUa67wRy8QZNKPhtYQurU9w2LEDu3aN5ZOXJEOe7Ul0lD98ebBW162TZIJTvOyPoq0h31zskmxRwAIw4Rl6Ha0pAij9AgmNLgc4/gVTrjhXgcLXyaaL2WBrlsjtqWUr8yy7sA7X43tPya8PIhA4SPSsimSqZJHx1hzBDwy5Ry/hjEL7MAXQHrLP3DJianP7RtWgeiG1GbIW01ttYQQ2Sgi9L2HwkwcAUOeODDFNv5SsYfBbn7j4/+soT1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aa5HdpSOMwvBE7BMf+XvrXPD4qXbTjZMnG5Xm35eNe4=;
 b=bns4QTyMj+zAOmVMRJ9ctQE1jpxt9xMUNKuTub5Ly3UXOhfkyOIPTTtxwQKSYvlWU/zo2cpJahprbOR4YhsXWCJXEmhGUIgthGbXxSn4zm2UY4TyV14j0SgzcSJ5ian3xIIPbTH3Ul3YSCVFK0RoduYlZaQrSuXFnfHzIqIsIOa3hGowHyIzc2dH6tMraP8rKyJS5Z5Q5LsbWPMu9BfPFHAKD/HODEY/xIYxUUv/gzAf2DhaQ3pC4r4AWT9D+6sAZLVu3Hl5OrlxAfXRqlvPMRxhulD5UWUP4MkmCNBWUg5wYchTmzDfww+EiFs8jSBoVNIs0YBpG20KXvZ6Mt1sCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by BL1PR11MB5463.namprd11.prod.outlook.com (2603:10b6:208:315::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Tue, 6 Sep
 2022 00:24:26 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::101b:16b9:9211:831b]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::101b:16b9:9211:831b%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 00:24:26 +0000
Message-ID: <4f265843-bac1-944c-8119-aa4c1689c8e5@intel.com>
Date:   Tue, 6 Sep 2022 08:24:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.13.0
Subject: Re: [PATCH] mm: Check writable zero page in page table check
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220902232732.12358-1-rick.p.edgecombe@intel.com>
 <3d82deb6-357d-0b54-ffd1-dce157674aad@intel.com>
 <467b0cdb4f876b87b50d1cd7229a8e6e02a19a41.camel@intel.com>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <467b0cdb4f876b87b50d1cd7229a8e6e02a19a41.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0128.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::32) To MN2PR11MB3870.namprd11.prod.outlook.com
 (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef83d06e-5c19-4f9e-17e5-08da8f9e27d4
X-MS-TrafficTypeDiagnostic: BL1PR11MB5463:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E4rBO/xCBnGikgBki4zPspFdI894tuuXxR3KFgzi8y8iyq6UBGhedJBcMCsX/r0gjYzf81SjBOfhbmd8oTIfw2wP3IlN1CQOfo8UEaQjjI8a+Y+cHW+D+DHZBkz3+bdgdnrG77SyfYKtS3RTo4lbwszAU8Gz9HCrp9kmpyufyzVCxyB1+X1P8RhurKBzbXBI1KW8Wf2rg+1a6gGbPMfIST5joVTIc4HwG4vVz1rDUED1jncy0+RelQh4AXF+vAESwkalYMn0rdTj5M7uLhtSKvvhvU3ntJr0f6JlTEfghUJDp0FY2wwMJomI8Gy2K24D5JDp9DEH9GH9B6HydDutFmuerMIUaxc1h1X32k63WQemnZB2/eaMWwUYrtjiMq5nNCzRJI0UUk2ztw+gzHdCRZSP3HoHasDUTHechKr2AHUXS77wrmluqhnlfneVyEt2JPodBS8R8/msf5jJrhNhK1DI5XYb/S1Hb6VO9zisRcNPkS050FjRDTSMtDEUEIqiL3uQSnIg9nFGx+ZlF0Z4p6TNZuEDyJbfyOfkcpsXHL7PcC0rwsnIUhNA4SGoV5cqwOGJiMAaAFOORrRED5eQL5xyeF74bjGEacfq+/O4JZR8NjG4rrupvfNamCalGy1eRJKLQQwdJjlADGEU+Ff6uJUyYRE40s6283MYI6tQHhzPryDIgZq0ReBAC8EPwfic2EQZbwkAghiy7e/bHs75IJrbCkqi8sdHO7J3RNBp/LQlXQqVR9RLw59dSiwPVpFfjN0RTH/ohFQOagX1BKOhZ4YFjPdjgIXiNju4Vc9cFQ121PLn8Bw+biBdu3kU7wL1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(346002)(136003)(39860400002)(4744005)(41300700001)(6666004)(5660300002)(316002)(53546011)(6506007)(86362001)(26005)(2906002)(110136005)(6512007)(31696002)(66476007)(186003)(66946007)(66556008)(2616005)(38100700002)(4326008)(966005)(6486002)(82960400001)(8676002)(478600001)(31686004)(36756003)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGJCQkRCTlVXU0JiMnIwclBFY1l5RHpYcmFVSys1cVBhSFlQdUQ0N001OTRY?=
 =?utf-8?B?dzVhdlNJQlhsWnpCV1g5bkhjN2FOQUtvUDQ4V2laNjdaV25DSjNmdEs3SlRJ?=
 =?utf-8?B?TEpwcnpCc3ZOWC9HS1E5L1pleFBvaDlGaFk0WUdqQjAvSkV0MCtWQXNFcHBk?=
 =?utf-8?B?RXI4QXVvYm1DSXJzKzEzZkNrVzQza1BFSHY4MzFWRjY2U1RWT2JDeWxkazNi?=
 =?utf-8?B?MHljNFBHRlBnVkhUQzUzcnFQUkM3d3lxUkhmbGM4YjNpWjFmQkdMWE8vS2hZ?=
 =?utf-8?B?L2wwcStGMk05NUdBTnUzVmphWGpQV3kxbHZNVUNFcE5nNkd4a2dnL0hvc3Vz?=
 =?utf-8?B?aHNmMzRQNm5MdE1ORmVRdHc5NDVhQVdqOGhrL1dJWXR3VFdwS1dqd0o3bjhP?=
 =?utf-8?B?bjRVc09WelFRelVGU2pYNnUyUWZWZ3FIeXpTcUJOczNiMmU2bENpT3pmakFa?=
 =?utf-8?B?WmJxSEFieVNSOTVSVnk1M0VocklTenJXQ1p1R1QvNEZFMGZZdFdJY1Q0L1hw?=
 =?utf-8?B?RVBBMkloV3p4bkkzWVZ2V0I5ajVoT1BKekthaEJFbGg0ZG9Ga1ByMk9DVnA5?=
 =?utf-8?B?OU1yNjIyNjl1SytvcWJpSlZxZnFleHRLME9INkZiNkZVNzU4NDRFcGkxSmsw?=
 =?utf-8?B?QTFxeWZXcFdCZjViS0hiNnhXTW1IUFBWQ0lqOXJPZXBCWkNqUTZsK0Zxa0hQ?=
 =?utf-8?B?dVh4RnJpcm4reW1ZUWJSM0pSMXlKL3A0TGdkNVlteUtCdmQzQWxvRk03UVo1?=
 =?utf-8?B?MkVNbHFyekoxTnlBcWU4WURYMnVFUzJnajJzZnY0T2tIMXpmVGxrYmt5a1dW?=
 =?utf-8?B?c3J6YTNaTm5NUnpBbU1hdDVsWXpmQ2dPampUVTlxU1V3OXBIejlDNmNIQlFF?=
 =?utf-8?B?QWs5RUd5bDBTcW5GQURGVUxRQUdqcUE5MmY0VlZhLzRYSHV1RlVpeitLOWN6?=
 =?utf-8?B?SzZRMXp2cHBrWlpZMk1laFBkbktINnB6ZVhGU2N4UnpZVmdDdjBMd0JVa0lu?=
 =?utf-8?B?TjJGMW81aGlLRm02UXBaQjBIOEVzV1V1RlArd09PMWdTVUpCbVZSa0ZXS0di?=
 =?utf-8?B?Ny9QSEl0dWk0THdMdEQ2ZnhRaWlHYmJTMFM4ZzlZZExRL3JGTmRrWTc3T3Bt?=
 =?utf-8?B?cXNsTkdlczU1bWJYUW1HVytVbEU2SEIzY0F5QzF0WVg0eTJLWEMxUWhtTHlv?=
 =?utf-8?B?MndTbnY3TmNGNU9SSE9zN2l4OW0yR1V6MzIvK0tQV3FSb2huWHhKckFXYkdF?=
 =?utf-8?B?UnA1bXllNkZoeGpjKzZFZnRCbEtwZ3QxaGJDWUkreWp0MFhCQnhNM3lNdmh4?=
 =?utf-8?B?RVpOR0NDVG03RmlKbHlKWitQekFJVWtxQ2Y4MDQvOVM2bkVGbVZPajlZQ1N0?=
 =?utf-8?B?STJFT1l1Qy8yQ0NwNUJVb0p4MjBBc3dFTTBveEFRMmIrVW5GYUJpYXhNdTRs?=
 =?utf-8?B?ajBSSWg1L3JBTE1QSmFmQmJPNnpoRXdLeGFFRjZyVEhxOUdUWU90T28weEpU?=
 =?utf-8?B?NjFzWGhpTGVhTVp1L1ZLRk9FTGVGMlJRZnJPL1JoclRzS2RYdXNRSFdqcldr?=
 =?utf-8?B?aC91Z1Rkc2hYalhYY0V3MThWU1o3MTgyc3R4MUZqZ1VqUkYwWUZublBnMkZT?=
 =?utf-8?B?Ykt0bHR6anJUd0Q4cnh5cUpYRmEyZDdGeDhxd0RzemVxOFNtcjk3WmQvNVA1?=
 =?utf-8?B?SzV1UDY0c3p3aGQ2cGhva29nQXdEUWIxMG1DMmpnWllnS2t6OC9wNWNyeDZo?=
 =?utf-8?B?TXd2bE81T0lyMFhIYVQ1RndOY2pNWDV6cEtudERaM2cwUVE5U0gvb0xCVnMv?=
 =?utf-8?B?TGswRFI3Z2lJQjZYZ1Mrai8yK2JOV0lUbEQwb0NmQ2hpQWxNV3BGb0Z4WjNs?=
 =?utf-8?B?ZXhIZ3Y4cWFQWmw5UllyejhCSE9ZMVRHQXVwK2ZNZTZQQ01CV2tSRFZYeGxZ?=
 =?utf-8?B?ZGlXWmQvMjdzelpCMllrWUpVQUFLNlNad0lSQjN4LzVKcXorUzA4UXVrYTgz?=
 =?utf-8?B?YnRLcGo5ZzhmRG5oUkVkbnBsQmFjNHZIQmwya1htUlhWa2l4L0p5UjZJQ0NB?=
 =?utf-8?B?YlpiR013SE1HZFl3Q1FCc2VTeGxIZGxuOVdRcW1oVHMzalJjMTFqQnNDeVd1?=
 =?utf-8?B?QU9UYXdhVytzZ1Rmand1Z2Q3dWtNUmtKeXRsSTNla1UyRytsb1k1eXFXWFk0?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef83d06e-5c19-4f9e-17e5-08da8f9e27d4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 00:24:26.3724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0DjaPBhF7K1ADjRWhEZObLEiMojij93VuJLdWJj4Zlpi9lWBt83zI2PZX7grng6pZxuv1G3rnvG4s0SUv54rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5463
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/2022 2:50 AM, Edgecombe, Rick P wrote:
> On Sat, 2022-09-03 at 10:13 +0800, Huang, Shaoqin wrote:
>>> +     BUG_ON(is_zero_pfn(pfn) && rw);
>>> +
>>
>> Why we need use BUG_ON() here? Based on [1], we should avoid to use
>> the
>> BUG_ON() due to it will panic the machine.
>>
>> [1]:
>> https://lore.kernel.org/lkml/20220824163100.224449-1-david@redhat.com/
> 
> Yea, you are probably right. All the rest of this checker uses BUG_ON()
> though. Maybe they should all be something else? Just felt weird to
> have this be the only check that is different.
> 
> I don't have any objections to changing it to WARN_ON(). Should I
> switch the rest of the checks here while I'm at it?

Yes. I think in most situation, WARN_ON() or WARN_ON_ONCE() is ok.
