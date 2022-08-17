Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C42597319
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbiHQPe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiHQPex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:34:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9747FC62
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660750492; x=1692286492;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=k7unP8JqfUATY8myPeuAfmP2uPdMOrj6Q32GSgvuRY0=;
  b=gdOMTtOeMrjHeWmLyvxiJez2W55gCxfZznKQ8Ttk0tTKpO9yRw7b7w5O
   PfiKQ1bitqZY4WfMHqYS8H0Qa7bomciNI47CN9yXOXFp18IrcpwkRPsUn
   jW0dEBc/hHgyZBnmpnL8b/2LrUKV3VM/wtVwQa1tE7aGyIBRhEmkDACcX
   HjgN6kwz6v+d0+D6At3Oll5bMerpczql9Xa01+Um9F8bTUSCjVTuDUOlU
   NuHpJT2VXXIMWwYLLcFm5SqTmRnBx1uI5CouSZ3rNWOy22k5IRqrytOvU
   ccMHayIU/+8HogbLGjYMqCYPJHqnvYTlG4begEEmnz3/WjJaDfpkzzcHH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="378814814"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="378814814"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 08:29:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="607471433"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 17 Aug 2022 08:29:25 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 08:29:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 08:29:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 08:29:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjMzd54BbXkK1p19qeiCVMy/cdNvmq3NzZPvEUWlxSpgB5TksF6p1A8HoDdohU5BaMvC5upTAExemFBjLJYhINLXhOqxQkHyI9YyOYQNU4jltj/pvMbV7M5ufdLIlbl9YTqlT7R73Jju9+eAPjHha7xb+QhbXkSP5fag+slf4XKj2q7jAHdnxLo55kZ6rBz7gikZ3DY+rzhs6eNMElOZ7JiUVDvErSrKDTRZXtlvR5xAVS10Vc5lHBLscwFCSZp0ZVGz0nl8NOaz6+YtffE+Gw9LZbE4P0UQbyXlk9CQQwfZZG7CpTRkQS4633YMPHEOCdlNqc3Me/L/othChgOZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Esle9MfhLaAdorcuH+c5mjdx7WIiCt3NDLFKqE5DhwA=;
 b=agzfxpEMW0ChnSG8AxWd7NysuXLghojlZc1YlTaKMTjVQqua7XB2a177u5kN7Ko3RoJpWsa1ZGRYro/i9MV1BHooWnKmNfK1dIou+zYNENQa8vQkw71gwo1sL0Bt35QLOpEhRZot0ooCTPG2Kb72ppV6ZUt2/XiS6a03mLs6Rr6+hqU1H4/QcE8XjdP2J4EOGJ3Un422S07QnmnXMQ0k9TJ02Twb3b4PsfvLLJ+JVd5PHjl7CW5wFZUEkVwkIlKWw5qN7lDHW77rivbHyr5nkGfMcf7XvrNR+hcZR0qr5dNnSrUhFKqDNIMCrAqZCs5czTLaaIDfzWlX3vKoQuZNLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DM6PR11MB4740.namprd11.prod.outlook.com (2603:10b6:5:2ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 17 Aug
 2022 15:29:23 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad%6]) with mapi id 15.20.5525.017; Wed, 17 Aug 2022
 15:29:22 +0000
Date:   Wed, 17 Aug 2022 15:29:04 +0000
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Ashok Raj <ashok_raj@linux.intel.com>, X86 ML <x86@kernel.org>,
        "Andrew Cooper" <amc96@srcf.net>,
        LKML <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?=C8=98tefan?= Talpalaru <stefantalpalaru@yahoo.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] x86/microcode/AMD: Attempt applying on every logical
 thread
Message-ID: <Yv0JQGa/2BlbQChZ@araj-dh-work>
References: <20220814120026.16118-1-bp@alien8.de>
 <YvtcGEHX8eSFpALX@araj-dh-work>
 <YvuQgx698T5cgF+C@zn.tnic>
 <YvzbFXnBjNjK+UJK@araj-dh-work>
 <Yvz53AAh+p5Db7CK@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yvz53AAh+p5Db7CK@zn.tnic>
X-ClientProxiedBy: SJ0PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::9) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1f35d69-0560-4864-7bd8-08da806542ce
X-MS-TrafficTypeDiagnostic: DM6PR11MB4740:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lu7GupVOeQX/Iv5JOBWzuX01zoypGZ+1ZJQccjgCUloWtFCKlkKakiGwaPphW92qZJJckk+uClGDNZMv84TFy8Z+/QsdaKGMOfW3kStJgt4v4JRGdNk2XYJfa2RVkydViZhUaYzVPUVRpceush2CgJ3QiN3blvBmBGjYZ/58JxW7v/HsfJZjP3T/ZhIo88AGXs/d9yEoWVZCp7ObJ35yoBYPUvL8Nt1ZDJ8s1mSE2EJtawDu7I9XlX5mbMXmEcapNckKdJ4+0fCWIwzsBUcW7UHRIHpYMZal/VfDAjv6SVvrY/hUq7VaCK8XNpqZvqRhNVvQVPJwY/T4AJh5k4GliwByMA84F8Gvw4ZLm6VPxtE3KgKNF0JoGCjqfpewd0HRAA/okK/gpNI9iZSnhp8VU7K+DWgJ0BOp/aumUlHcH2cJADhqJzEyajup3O78uEHcHkeE+234dKWRgJUkHcPn5iDJX8NPNZdPOzOnjHf6Gg7xruXjO+CoWQ4gZOyL1DR2jsJpXk541tvS6Gw9vjzNXyInGxy2E6l2IIB3MhUYv0Vyz0lQcVAsRXpseOPDHxW8L+s4qIDU8AAR6x8Sl4KW3yUBrehoyquDK8LiQDMDEriwijkhrXAHdGoh1xpQLFY+TNIziBpaURC+W+ZsHWQ0wMRVrlwgNAH0FeOFmdIpJMkEI6Dpf1lCdJDKEeKp+l8rg/CmMRQJX0WS+xStb9hPsfrBLIVT0Ndn7fJpQMpQs04vvdHAiryaJXiagj9yDUtgATNQSrS/Df9IdXBTeNt5vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(376002)(366004)(396003)(136003)(8676002)(316002)(4326008)(66476007)(54906003)(33716001)(66556008)(66946007)(2906002)(44832011)(8936002)(38100700002)(82960400001)(6916009)(5660300002)(86362001)(186003)(41300700001)(6486002)(6506007)(6666004)(966005)(26005)(6512007)(83380400001)(478600001)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sKjFuuMsWlHUPRKSlm/JR3109PkjixHnklYwj9Yw2rpXufQot//IOOZRjBGt?=
 =?us-ascii?Q?5xwBksTI/GLshGGKy9ha63F5qzWvFd7TLy2EpVZyF70bafUpscjOt6uw5E2t?=
 =?us-ascii?Q?eR3Ji6AUSbKagpeniAJlan78thKiITAZ07Uujxb4i45r4G41uaY4Pn0RQ6CA?=
 =?us-ascii?Q?VRAkkq7CEMzepnAN3GNJOg3CXTpXLOYHPElBOc2wISD/CeS7nEEbxup/KZ8X?=
 =?us-ascii?Q?G02myvtX0Yd3Mo6RbSdyvdewUT3ouLM9LCzql2y9Ad5HJsU5ZaPNpq2XWGdv?=
 =?us-ascii?Q?9rwq4wS4D6cT23VvbjpDYen3lm9SVFJEZcDpaW18PL3jEht1YwXjOtsRWz//?=
 =?us-ascii?Q?d7k1qlXNLZPtUJ4cYzlV5AaMPGL2N6W1C95I633o2GGMjHjpNfHH0pDwdes3?=
 =?us-ascii?Q?nvrlszOWXdiDtICQXOBXsDxNALH4bKoZVHI/50LZ/tMLEmxWZpq3l19x2Tmm?=
 =?us-ascii?Q?+OvY8CkS59A24eD6Ji12BjalUEz2esjr4uHBB9ia9JHC7kuTOxfrBXdjFRwU?=
 =?us-ascii?Q?bQylYGjoF4wOuQQZej36xjXlvl7NrH8wykQCoOlbS5Tv8YFf9Dt4wGPXA29s?=
 =?us-ascii?Q?gj9GlG0E71mS+K7hjcYfv4gViRSY+zlQIbF5Qlg6VcIgNJ9CdbJvPJWEadUN?=
 =?us-ascii?Q?TBb7pdAsS0Z8ilzJdd5PISy+DZKSk1ocHAI4uFjGNUsHgmCL0zL3htkWL0+V?=
 =?us-ascii?Q?LLVMpGdFYnzYfOxuWC2TMO1DkjQeoaEXwNpI+9ncvOW4HybXaNSzUkYmoQab?=
 =?us-ascii?Q?tOEwZsq0Aii0oCtzCkBJbPddrFwNTdJju6pzQ2uPAapCpR5+Vrf1lJBe/HgG?=
 =?us-ascii?Q?pkuNlpSe5mUx6CnCznZHmR+6IEMp0KpfRCB+VTkPdhQJ/h6zdxyLhJZV/zPt?=
 =?us-ascii?Q?Rfu4BkXSIH/DchqYk/6MsTSNCzbmQcq1F8wc32b2zJJLSGy/QSVZ/dg6fljB?=
 =?us-ascii?Q?2/PHltoxSPjWwInhco2DzZy16IFlWFlP9oWaT/oN9mCFJRoJoEBaOalZo7F9?=
 =?us-ascii?Q?4GymWSyZgC0XQVP8zZ7lRllhGZlAn4wQLhp0ElqrKYzJtOLauE4LaUKaKfSu?=
 =?us-ascii?Q?du8QdAhrwxujKFBxv8OrjMToM3UF9QhegFsfyfRjOOROXrlmy/srB3AvAT9H?=
 =?us-ascii?Q?hB2VTeDB3QuJjxLtUVGxq5lmuj2685ma+WVfTALWW7GDj0TssAzGC9bJZb++?=
 =?us-ascii?Q?j4FkWStoLjFcuv/zCSp8maojpI8J4HvCKgAnhSGW/X9orgwsSL2PXM0gRkOf?=
 =?us-ascii?Q?24mxAFOjJ4esK5gjnV/Qys0fEKHb7hkcdgQ8IxkpNZqD0DGnDk6INzaLp5JZ?=
 =?us-ascii?Q?Qg0Zv4G97Ykx+3nB4BBh5hySjweUMOsaE5r/ogb653w+LQhvbzxDTgtADITf?=
 =?us-ascii?Q?T5yNYnxvM13GR1d9PDGUzqYdDwcMpSCbuY52RKoj4oBnbqS7ARnNWOH4nUVe?=
 =?us-ascii?Q?WS06Yy36VCMMTzR51MD2KJvbvL2kQ4TuaGzN7zMOTMXgoGHLoklSGUsi9fPW?=
 =?us-ascii?Q?B8ZUY+iSy9PkMsI32+HdawYcbZvEuy180YrsdqYs4aHwjMHFGoDKfzqkkko+?=
 =?us-ascii?Q?trDLcK/uFjs/VEOOYff5e82DrD78LcxAGdwGImeHvMQLtlcgg3NPsDtYgL4Y?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f35d69-0560-4864-7bd8-08da806542ce
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 15:29:22.8789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NuPKqEj/YOEvUTtU4cyt0f1Aemqk8GMIYiMh31hP+KDRaG+Gr7n+BivQvwRyKixzbnSEmlYhp8CWD64Pw/cDzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4740
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 04:23:24PM +0200, Borislav Petkov wrote:
> On Wed, Aug 17, 2022 at 12:12:05PM +0000, Ashok Raj wrote:
> > Instead of doing a complete hack,
> 
> What complete hack?!

What I meant was the patch removed any and all revid checks *completely*
Instead of even limiting to == checks.

Once you do that "in spirit" its the same end goal. Isn't it? Although it
might be required for a completely different reason.

> 
> > could we maybe revive what we attempted
> > in 2019? At a minimum it will work for both architectures.
> > 
> > https://lore.kernel.org/lkml/1567056803-6640-1-git-send-email-ashok.raj@intel.com/
> 
> echo 2 >... - now that's a hack.

Its all in the eye of the beholder :-)

I didn't mean in any way to bring back the echo 2. What ever you think is
suitable to enable this is fine.

> 
> If you wanna use the kernel for testing your hw, use a local patch. Not
> expose it to people and then have me debug all kind of strange lockups.

So forget the hardware testing part. This is a complex flow for late-load
and how can we get more people to test it today in the community?

Do we have a more scalable way to support it today? 

This is similar to XEN supporting, ucode=allow_same, there is precedence. 

Doing that is just like having a built-in self-test for microcode loading. 

I think there is value in enabling it for x86.

Cheers,
Ashok
