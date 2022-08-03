Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2E0588E4C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbiHCOLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236517AbiHCOLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:11:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2892E1145D;
        Wed,  3 Aug 2022 07:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659535874; x=1691071874;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cW3MjXVX2BntOHHLPXhbYtN56L01c+6vPIBLotyGlpk=;
  b=jY8j0LIIv7QMFr4hobIfdKqSEYluKOG/wa8EBE8RZBNDd2Hmax7XVQLK
   31J03om5FQqxW8l1BycpeCl4/+Pmxsc565oVBrVMWxV9SsUPuDReZOc+2
   JAZN6kLG79Edk/4rWmVFhmS6IEVRGJlktgrYlumv4Hb0ItxmZN8MAXSM1
   J+y6M8LvlLLc1twLkfbSaLFXNqtjw9oL/FAlQhYW+AgCCWSydAo/E1OSC
   UM0Mik/lD7pM9QL9h3xHfbrR9N8ObbEZN3tH5oXPVUXkeSg0JCXSb/d/2
   AenZt7Fmn4qzbGhcjmc4wM7uiy5xZcYaVFjAwlc+mBe8g41UaaDQ6s6cg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="351393722"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="351393722"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 07:11:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="553336052"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 03 Aug 2022 07:11:13 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 07:11:13 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 07:11:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 07:11:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 3 Aug 2022 07:11:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsEVz5R/4xC0Njfk4Sqbqx3267yPbdn7aJeXz5lmb8LhsZVA1HGGK8s9rV1VsZpXWfguuljShQzM/osnoIE+0gtnyuHdhzD4Xj2GBMpXL9R9Z3Izq3VoIZdW7qkS+iiT3s6c3zFH5xePkfsTi9oDc1bBBNueVq19oG1ezJrm9n/s//+L/GPacD0sdGGGzo+dSXcu/LL8bX22wt6Pl02t+OZW0adtDa9TyGGkJwOjZj9LAO7GrJ5xaDl35Yuwjy6gIUIzzjzAuSuvfyMYfLssJmtJPLyqVODEoDo4YL8gIrA3b6MumlOapIU6wgFR17YjxdYB3kfFM/gXhvQ1OUG3AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cW3MjXVX2BntOHHLPXhbYtN56L01c+6vPIBLotyGlpk=;
 b=fxfD+JthowRP/kLy7J7OrLBmbnSz20uBimNTY3FZ6/ephyRJk0fVYm4XW8Rsfai3x+Jf0M2YFehl45QysTkwrXZQKIht8wXEaOtpCs1Mf5CeJm5Q+ll0q+N2YbSezL5fYq4wQJQpEkex4oy/ltzHUo2bUhkXIWZBGTstSzx/dl9booWelQdxTydpBhuMzCCLRFs6aWWgD+c+6LOkc9wlVv1qssnhtSl9yPzdmMG8QYV0KKIiqVfLrvIBVZV1hoCHJbRl7jGWaGyfY+X6eTKH1cX7BzmoYRzBb4aWbjnbLQ4BcKKQWYv2LKPe7guIwtPKx0mmU97k55vxdhFfnmxxfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Wed, 3 Aug
 2022 14:11:11 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::552f:2392:56f8:ca32]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::552f:2392:56f8:ca32%3]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 14:11:11 +0000
Message-ID: <8b9a5712-fbb1-afdf-6c5b-fa261832665f@intel.com>
Date:   Wed, 3 Aug 2022 22:11:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [LKP] Re: [xfs] 016a23388c: stress-ng.xattr.ops_per_sec 58.4%
 improvement
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
CC:     kernel test robot <oliver.sang@intel.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>, <lkp@lists.01.org>, <lkp@intel.com>
References: <Yti6PccitrglBtIj@xsang-OptiPlex-9020>
 <20220721220142.GW3861211@dread.disaster.area>
 <9d4e37e2-417e-7a2f-a187-5c7b680c6777@intel.com>
 <20220803010246.GB3600936@dread.disaster.area>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20220803010246.GB3600936@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0179.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::35) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be84c172-a83c-425d-3750-08da755a0469
X-MS-TrafficTypeDiagnostic: DM4PR11MB6335:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47WToUwyx+ThbSL4SjzX7sX5SxldMlFDksWm4CjWbzHUrsc+p+v/fbmkRd6DyJC7QNjPHaTUhTJIoESs71UZzK1XSvOdQD+Y7LGXNTaIqEXoLXP2EcVr8ikM62eHOhcBa3o/3eUslWwm9Bey9MUHm+0KqKkP/dzdjE04Fne/s5e43tzqbO/AxUotqMC0nCCrdNYGrgeeyEXSJnqGxQpCPcwDy9/tAgg11mhbe8XRoPVnePJaYEaE6QHkclr9AQDbeCdHo9LyGgcZ7y4F5F7gIGAs6xcDeu2BvZHdYGco1ILatS9TbhfY1d989D5vmTI1yYmtTGFa1HKSBF8artZRGwoqtxAdDbCFFP7hFsd/0H5DAXPol2WoU8tQCwwBXST+2OgfrwnRExLBSWIgcH/bEL6dusp7dsOCIErip6Gp4ly5uJFLTJhORvU5cpY5DcuBzLFB3/kM8SsjfBCyrlOxE+MvgHnVVxuPVUMOPguR6h2ds817B/PvGieQ/53CxZ4QSl2CG8UPfQMyZ2pZj53pQLtxwSRsVpoj07MN7OkbhnoACUR21aS9u9AchFPp68el48IrjqshlxUiLlUznDxnEge6A+OxRm2UnGOFtVx0x3/CXVh4UjmgRgr5BWMfvokQKEqtDOby2PaEEt0d2afjQVYFzbg484NV7mEMAPsygF90TjjVrzafGP+eU79dyc3poh/KObSgVP/mHCwUAtPIPUa7W3NeesOMCy/MwWT1NCCNyBBXptSrQqnKZBa9HRznxfPfOUcDlUZH5aAworpLNtY5G4hpP1kVQmPRJnouXWk5dSqwuejgSJLBcYUS/8e6FTI4dlWyAJRkCAg746mSxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(346002)(136003)(39860400002)(8676002)(53546011)(36756003)(107886003)(2616005)(26005)(186003)(6512007)(41300700001)(6506007)(38100700002)(83380400001)(2906002)(478600001)(86362001)(5660300002)(6486002)(31686004)(4744005)(6666004)(54906003)(82960400001)(8936002)(6916009)(4326008)(66946007)(316002)(66556008)(31696002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlVGTTB4Y1BSUTI4WENmZjNWWXpyVGZ5dlYwSmtWVytlQXRwQkxqY0V3ZVVB?=
 =?utf-8?B?bzd1MUlaNjQwTm9nRGNlOUJXZUw0UUFnVkQxQkdHSS9yZUZtRVpEMEFNUTZL?=
 =?utf-8?B?a3lGOHMxY3FkMU5mL3JHUlZyMU1UWXFVL1RLdVY0SzVqRldaYzlEUXVQRlV6?=
 =?utf-8?B?MElkbmMvUFZKMEN3Q0J1SG5BaVFIK2RsWFIrOXI0dGtnUHhEWW1SS2ZuaEYr?=
 =?utf-8?B?Umk2L0dMeW9RUzVtMHJQOGZTdFhhOUhKbGdodjVwbTNOSlRWc0R2eEhETHI1?=
 =?utf-8?B?TElPMnhGYytXS3ZtNWlqaVExUjFDMS9sSjB2T0NqM3dtR3oyUHd6aEVYZG1m?=
 =?utf-8?B?dXQzcVhHNE5td2g0b1JDNUtKZ1JSdnFZK1pudEUvcGFMM1dWQ3RPeEJhTlJL?=
 =?utf-8?B?dWhkWFQvWHlXTEp0SW5PT29BRHg2N2g5a0NqdGx1dXNRQXlOdEtXVndzMC9D?=
 =?utf-8?B?cGRWR1FzUVNITGxZN0RCWGtNMzlZQXFNaHZpMG1PeGRMQlhHTE1jUzZkR256?=
 =?utf-8?B?d29NWTgrSGRYVHlFNnBKcFNPNEtVa3o0YTlJdGgxanpqS2dpN2I5ZDJ1dlU0?=
 =?utf-8?B?dldPTk1OKzNMNW5neGd5ZGozOWRxblZzRWlhdTNkQWtRUWVVbVprME9wUGUx?=
 =?utf-8?B?ZFVlbE4rdUNtenpCOXlGdkpWbUFiRm1CTXFIQmNFVTBXQm9FN1ZtQnM2VDhN?=
 =?utf-8?B?Tmd3OUdEM3BCYUZ3NkdLUXFnN2RwSE9Oem9MR1BESXpsdWF5OVRIUnNaOU9T?=
 =?utf-8?B?R2hXVXQvM3o3NWlPbHRONEF2cHJqcStEcVAwMis5SkVhY1Yzem5hOXpIb2xO?=
 =?utf-8?B?L1hwQWphZjJOQUlMMndDeldUMFRsTkJzYTY0M0VMOHZKM1hXcmEwL2VPT2FO?=
 =?utf-8?B?UEJrZVpMakRla3NPWXJLUThEdGoxamlUWG1jN0R2bURpTHBoOFJaaWpMb1l5?=
 =?utf-8?B?QnFhN3NBcC9FdXRMUUFtLzRLeVNjWFVvenBpTHYvMWllKzZMcHFsTkpFVkZl?=
 =?utf-8?B?bXcwUHFUTThyUUFrN05CZXhlNDEvNVlkOVNKdWFqS3IyR000d2pGa2tQeUhq?=
 =?utf-8?B?cW0zcHpBeWlVeklLZVhNdU5KUnViaUc2SEFreUNtdW81TE5nTU9qZFJudExy?=
 =?utf-8?B?QmsvMERhNTJWWHF2RFkzVmRQSW9pREg5ZHdhMHBiYTYxWm1vV3Vodjg1QWRX?=
 =?utf-8?B?S2xqWE8vYWpQZUNGcjNZNmhla0RBb2g0S1dnaXpXZldLSlhISFVKQk9rSW1E?=
 =?utf-8?B?VHZlQ3A1RFJZN1F0MEE5RlRnSUpEMzNyRzVxUVNUTW9oUE9Hczc1N3RuU3NU?=
 =?utf-8?B?TlJOemZQck9FelZyR25VdmhBY3BBbFlJdFpzMlMxZWk1RHFpeDAzSEpCalNn?=
 =?utf-8?B?VUZQVFlzRmxFMjlXZHV3ZGxRVWpsbXRmQXNsZmo2QXFIc05NK0o1VnFYMXZ0?=
 =?utf-8?B?VEJCYm1sTFJyQ1piK0NycTh6S1ZpVFhDNEQra21PempSWTNhTmFmVy80dlVJ?=
 =?utf-8?B?VENEMmlnWGdyeUREa09OdkdqMlFyajN6MDErZ05VdVB2ZC8xbFhIaXhZUFZY?=
 =?utf-8?B?RFFreDBudVRTMmhGYWNWNUdpbXk5bjNDVE9oZXdhVWZQa2ZaTjdEdlZlNUN2?=
 =?utf-8?B?bS9ISkZielU4RGg5ZmUrd3k0TG80ck1xRTZsQmoyaytPUWhyemxmNXV2U3Z6?=
 =?utf-8?B?SmRoSHVZWGRXTnZFYXRPRDZFayswNytYNDVEaXVSb1JkbjJvRkVaR3NETjZp?=
 =?utf-8?B?ZjczNTRJa0FQczA5UkNQTW5WUzA5cldkYkdHdHB6YnNlZW9qdjU1U1M1RGFK?=
 =?utf-8?B?NDZTZ1hONVdzWEJEZ1RabGJVOUMvdGhyajJLK2s5ak1mZ3doNllVU24xajRr?=
 =?utf-8?B?SzF1eWFTRVVUNGM4M0IvR0ZIUlhiR1p6ZmdHQkpmdHBLRkJXeTVWWWFHMGht?=
 =?utf-8?B?WmQrYSttb3ZHOVJtam40TEYxeGlKRmJMYkg3TEErTWNMVUJFMjJnVmFmaGtm?=
 =?utf-8?B?ZUR2OUtrcnVYdUFtZk8zR29yTk5VTURmdU5GdG4yQ2ZHRGZvRGw3UE1jYU54?=
 =?utf-8?B?aGtZS0xUZGdINno4VUJKTWJiTEM4UzNCazNpRTRQSjlUUEJFcTBDVFN2NWY4?=
 =?utf-8?B?Uk9kNkJFTDlMQTVGSmZmZ29xczIrTlgvVzE3eEN1Z0ZFQldoNDcwOGlUMFlB?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be84c172-a83c-425d-3750-08da755a0469
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 14:11:10.9575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UegXPt6e1JYo/M9GaCeXERw+lB0TGg7UjgrimewrRZQ/W7D83pQRd2DBpuB0yrFZLfrpxK+624NAhUapf/4PZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6335
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 8/3/2022 9:02 AM, Dave Chinner wrote:
> That a single cacheline miss avoids all the spinlock contention is
> just pure luck - it'll come back if other work is being done on the
> machine that consumes enough memory bandwidth to push this back over
> the edge.

Agree. We did see some strange performance boost which can't be connected
to the code change. And worried later unrelated change reduce the
mysterious performance gain (and report it as regression).

Regards
Yin, Fengwei
