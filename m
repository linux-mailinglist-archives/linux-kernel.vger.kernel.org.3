Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F0B5AFD7B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiIGH2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIGH21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:28:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF89A2877
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662535706; x=1694071706;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+PbJd98wl92mCTMJceiRr9dRZAeuDpJM0tRRqvPaoDU=;
  b=G3M0YgJRaiVy/iq7l1REwDe7OgkR9LKx7ezwO+lUVjDHMMOCJljjehCV
   f+fTvfzoxpCeImW9btthhWU4jtwQNjpPw6IMsluGu3QpvjWkI0Dndotaz
   G5HjjpCef4JQoodPsgQVwNXJLRUr07fKltIYMnSfUK1fToZ7qB4fvsO7X
   FK1dSm6Wm0xS5F+vAtpyIsbY1/3K2HCO3LQEXEhBGoL0zHJGergx1wTN/
   u2UjJKZ/ZecJJBaT82ro+w8eWty19EHFRkAsZMf+A+7Rskv6WM1CLANUD
   8LmT+1SCiJ/kc6jaribKCyXf94lJ/icGOpEzkjbZSwtlT/6OzZMY0jvlg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="358519147"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="358519147"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 00:28:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="610229473"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 07 Sep 2022 00:28:10 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 00:28:03 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 00:28:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 00:28:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 00:28:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocurCcVwzCYNDnM2EqJho5I6Up9oqVAsMkouqtKppa+gt/zR96AU9eh0xT+YAZ0jY7gqFoAWc68fAjl1i2R0H3byYEwGXOpk9ljO3e9NvYISFgTmV0T8JPlUDLp9R6rbugVj340D8JbWFO7EFJyJNHfm1k4T4IOffhe+Dotsr9Qe8ruyty5n7M9JgWZjzxzXIWpmzyQGLcNLbEBNykB9dYGETWl7DMnGwq+OqSZs10+KO5X/kvcOs19v+ejPH0gjvTuPpGVd/qmoEUlrcdbTOlUeEaT9jtfS1M3ZDn6SBhRsdhU/90jgoq47vXteCLV1Vz3dlhhdKO6SeV7FYZHL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhbi5doAmqcOX5A1JdFqzGPxkKHR8+KicbbuU0JPxYk=;
 b=M4RbXkg22NrykgInI6IBNO+cbW5g0mLkDRcyUrPAMBpHmBFL//hlU70yEFT2V8QjFuBT7vKaGfDF7/MNZETGFkerRjVU3LSDBew7HIzg1kpQFadB90cIS40blaEbMAe7vQHPPQFVgYvNMddkRkQfTz/vxvSoeS0ql3AmdbWwc77l/PHTsjpO7qv6sLwGKu715QVggkyjKUz0g+moII7pPCxBGaMfbG5hhcuPdd8PRn62ETW4pNrswmQZVXvq6Y+Xjbv3phltUiE+mR3yMoJFxi4Soge/OtWeqG5WqE5m/RHp0ri6PLM1/FulUaLq+dvCyQTpjEJni22180qZI87jiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BYAPR11MB3415.namprd11.prod.outlook.com (2603:10b6:a03:81::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 07:28:00 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::7c1d:1bee:fe96:695c]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::7c1d:1bee:fe96:695c%6]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 07:28:00 +0000
Date:   Wed, 7 Sep 2022 15:27:41 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] sched/fair: ignore SIS_UTIL when has idle core
Message-ID: <YxhH7cB+OIMAB0dM@chenyu5-mobl1>
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
 <20220712082036.5130-2-wuyun.abel@bytedance.com>
 <20220829130831.odhemmcmuecqxkbz@techsingularity.net>
 <51009414-5ffb-b6ec-a501-7b2514a0f3cc@bytedance.com>
 <20220829145621.7cxrywgxow5ov7ki@techsingularity.net>
 <0ffb0903-431f-88fe-3a56-150b283f5304@bytedance.com>
 <20220902102528.keooutttg3hq3sy5@techsingularity.net>
 <1fc40679-b7c3-24f2-aa27-f1edab71228e@bytedance.com>
 <20220906095717.maao4qtel4fhbmfq@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220906095717.maao4qtel4fhbmfq@techsingularity.net>
X-ClientProxiedBy: SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f4ed383-a8c7-4a64-4b0b-08da90a27e13
X-MS-TrafficTypeDiagnostic: BYAPR11MB3415:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCTxtXY91+Rqf1RGPlbbI1KEfvYWjw07Tfp0a0uksZKDSrpCSiGGRhfUvAPeGSdoP8CO210nrgW/9zOhtmakVEJhroMgVNwPxenYgwGOeF0nskPtq8NjIk7ostVU47LCnb6/vzXeBerHEoETiesOMBGmrFuVyP1XZlKmr2w8YdzAVjcjnzAfpm8v8/xU9pUczcdC37RVt3TINpaC25QugfAgXEg1d2n+mlrT+bam9ZVnn/5C2E+YnDDMWe41mbN3zhUJkQ+UJsrmULPGLKNYzZXIwIK8UsjzAQRAZdYA+IqFPc4dAdvsSoHbWssqSBLtFAZWBmtSp7J+zWq4R6DWPy9PI0tn9Wub/3eC8JJ7/DkPNfSEm1HLt9uhURTvj8psAqwG7+ruQjK6vI9vmNOFXsjuExPI1gbOLOgVtFTX0s0NA1LBJf2dfBKQcR9xMoX/e53I8qI4Dbd6mPCp8VRzkq6R/U28To5jNTt2hLUWGtp+VwwSdj4NPFc40s38TlKbwYuTihmdt5MN3JevVjgE8ZA2IN5mrCpexm1XLUedevtPfWs1CZmCCQCMo25HTbk7LbHeSbpkUmUMahVTa/0B14phxevnhevanWpLJ7iyb3L5R7H5M0xTDZflKagiBDlaF3BFkp6jyDbvN84ZL1v/SQjq+mFI2EePWd4z0jJs+j9yrPI9WQmfh84WAHW8FRk8fpDfrHif48NoHtpzb9DoVfwqL6AKTQiHhUoae8GYy8NnprO7WQrwaCbsvy5+G19AFKJOqU1sPJ4tOMHVYcqxGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(366004)(396003)(376002)(39860400002)(346002)(5660300002)(8936002)(2906002)(83380400001)(33716001)(66476007)(66946007)(38100700002)(8676002)(4326008)(66556008)(82960400001)(53546011)(6506007)(6916009)(54906003)(86362001)(478600001)(186003)(6512007)(316002)(9686003)(966005)(6486002)(41300700001)(6666004)(26005)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4gWnr/A8kIPPaJGFbw8sllYtJHgwNzjwuw/lykRs6ydymDw7ijyJZQ9vpBsL?=
 =?us-ascii?Q?GJTbipWJuw7oGvY2AhAn6qJPdsAGssSlZBbRl3iyvI7REz7XsBGyTNKhf1i/?=
 =?us-ascii?Q?X32z4ubftYc8bbUgc/Cil/L6AbOpvbusMfQt2lW7TmJ0WOwaLIsxBhIC++Zw?=
 =?us-ascii?Q?xNavGWiZicGqX2k4m8UJl18QyHMwPmYl2RohIIOUGkOi0IoNgRCMq6DobJB8?=
 =?us-ascii?Q?uMGrzJ5MhDnDHDs9Oe0OaXvuGCIzBV4GagufYKoJGEaJAFIWwH9INhFuJIn1?=
 =?us-ascii?Q?+4YPkX3MBbmnx6eUBsPBTMSY2SJaHN2FVQRqj0NGPxiuiv/nAyAG/hepSLZj?=
 =?us-ascii?Q?hL7N3DkxY+2nclThier3VrNHTQ338WvFz7ruhbSmA0M9J7Adk27Q3kP/T7S+?=
 =?us-ascii?Q?duonU4e2rcoHheMzst44Nkla7W3p6mOEJRGOG7RNPta/cKUkY/G3vWq/CLRU?=
 =?us-ascii?Q?VKpgNa7FLsercn8Xl4lol2QMDnkDBO/7t/HmzbiFTDLmnH37e3PUWPZE2rdC?=
 =?us-ascii?Q?BpGFTtFcuo0WoGhLHpsaZ6wyEpKBLz1CqNTsv7yIqDewfU06325ydw3V7WXT?=
 =?us-ascii?Q?k2tpfcEwpWjkZPCYM1wGgKmeqYPclt54m1U6hlonz4CwCOUaJOZ9KhHAzGm9?=
 =?us-ascii?Q?JjIEHlNSlnYJAIQ/KvBWmw13+SdLKr272vmeMA+wDR+IElC+ALnhKjFx6u3Z?=
 =?us-ascii?Q?QnZhu8D5EAoOgPkXEg3hJ9M6IiJYkMkUWMe77UgRnfuRf1XD3617i9RUmVNx?=
 =?us-ascii?Q?vmBPF9XZoT4V9hY7l6KSBDmGJmWdwUC0UdANLCBIC0/Dh7f/l6rv+DbRdwWh?=
 =?us-ascii?Q?byRKFSSIsfApJSNYe2gW+Vi3xFIL+w+qxiGBDn+hkGfxBq9Nyhm1AwoEXuSl?=
 =?us-ascii?Q?tNS6Iv6NhAkd9eWp3u831KJ7QtwZGNjbpSizRXEftHq1ZEgsAtDria2DZrJT?=
 =?us-ascii?Q?KcBJa3R4xt/Mdo8wdjQGTWMWHDmQGI0Va09/XRi2ibqoqkb0H6BR8iNeWFaC?=
 =?us-ascii?Q?SHwxRHxqgLX0wkir7pYeCwGfpDQe5qiuiPsf/Rak5dp78gTySeRSlcoqgdDc?=
 =?us-ascii?Q?BVHjgBmi51CYj+FwgNNMUMw6xB6QkeJjjFz2RN/hq0usRRdu/i92JESessqW?=
 =?us-ascii?Q?q98Gn8vj5+ONmLhNcVWCpWR2M5vhiFK+UdaaMe69iUIvG9yHkOfTSoDeIKbp?=
 =?us-ascii?Q?rXCHu1/PZBpZJkR7u8PtjFwAzoXggUKYNT76TCIT6InOAwKMzzQSy0kLHkQn?=
 =?us-ascii?Q?G3khAiaXKaZ5EkWhdWPFxEljLFt0n+05Sy+Jg6ZHdA3xAO1aIXEMC4Y+Nwvo?=
 =?us-ascii?Q?tReGwJNHSWNZGH6EhkT9rlRb9tyznKBoFs9ZtzTjCvQxjXZCew1yBIwXQ5N9?=
 =?us-ascii?Q?acwRSHaP1HrA0h+1vkTGdzGQ26OZ9sbzl1+gB0IsXfIJWS/iRiR48l5oicLl?=
 =?us-ascii?Q?eWBMQXufvYBTrw4BYVi200dc/wxhGGKnWMdSCcZYTeF1dTyL65q/h9/XKB4l?=
 =?us-ascii?Q?+kjEABvNp+9HHXACzeOaTqPf33MmW3zjZvLmyDM4XU+NtyHYIE3+SSiCeKFQ?=
 =?us-ascii?Q?7mukkpGbRHoJSJShHq5yFtJnfO/hOCC1d2u3luJl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4ed383-a8c7-4a64-4b0b-08da90a27e13
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 07:28:00.2530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6oBA4SZRGH00/Wxw62BzdWDdXuCHERXpWTvwzTHhzj1ZbN09eMq49wxNM4AqlXMXBJQU+AuFAlT354fAFuQ5pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3415
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,
On 2022-09-06 at 10:57:17 +0100, Mel Gorman wrote:
> On Mon, Sep 05, 2022 at 10:40:00PM +0800, Abel Wu wrote:
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 6089251a4720..59b27a2ef465 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -6427,21 +6427,36 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> > >   		if (sd_share) {
> > >   			/* because !--nr is the condition to stop scan */
> > >   			nr = READ_ONCE(sd_share->nr_idle_scan) + 1;
> > > -			/* overloaded LLC is unlikely to have idle cpu/core */
> > > -			if (nr == 1)
> > > -				return -1;
> > > +
> > > +			/*
> > > +			 * Non-overloaded case: Scan full domain if there is
> > > +			 * 	an idle core. Otherwise, scan for an idle
> > > +			 * 	CPU based on nr_idle_scan
> > > +			 * Overloaded case: Unlikely to have an idle CPU but
> > > +			 * 	conduct a limited scan if there is potentially
> > > +			 * 	an idle core.
> > > +			 */
> > > +			if (nr > 1) {
> > > +				if (has_idle_core)
> > > +					nr = sd->span_weight;
> > > +			} else {
> > > +				if (!has_idle_core)
> > > +					return -1;
> > > +				nr = 2;
> > > +			}
> > >   		}
> > >   	}
> > >   	for_each_cpu_wrap(cpu, cpus, target + 1) {
> > > +		if (!--nr)
> > > +			break;
> > > +
> > >   		if (has_idle_core) {
> > >   			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> > >   			if ((unsigned int)i < nr_cpumask_bits)
> > >   				return i;
> > >   		} else {
> > > -			if (!--nr)
> > > -				return -1;
> > >   			idle_cpu = __select_idle_cpu(cpu, p);
> > >   			if ((unsigned int)idle_cpu < nr_cpumask_bits)
> > >   				break;
> > 
> > I spent last few days testing this, with 3 variations (assume
> > has_idle_core):
> > 
> >  a) full or limited (2cores) scan when !nr_idle_scan
> >  b) whether clear sds->has_idle_core when partial scan failed
> >  c) scale scan depth with load or not
> > 
> > some observations:
> > 
> >  1) It seems always bad if not clear sds->has_idle_core when
> >     partial scan fails. It is due to over partially scanned
> >     but still can not find an idle core. (Following ones are
> >     based on clearing has_idle_core even in partial scans.)
> > 
> 
> Ok, that's rational. There will be corner cases where there was no idle
> CPU near the target when there is an idle core far away but it would be
> counter to the purpose of SIS_UTIL to care about that corner case.
> 
> >  2) Unconditionally full scan when has_idle_core is not good
> >     for netperf_{udp,tcp} and tbench4. It is probably because
> >     the SIS success rate of these workloads is already high
> >     enough (netperf ~= 100%, tbench4 ~= 50%, compared to that
> >     hackbench ~= 3.5%) which negate a lot of the benefit full
> >     scan brings.
> > 
> 
> That's also rational. For a single client/server on netperf, it's expected
> that the SIS success rate is high and scanning is minimal. As the client
> and server are sharing data on localhost and somewhat synchronous, it may
> even partially benefit from SMT sharing.
>
Maybe off-topic, since we monitor the success rate and also other metrics
for each optimization in SIS path, is it possible to merge your statistics
patch [1] into upstream so we don't need to rebase in the future(although
it is targeting kernel development)?

Link: https://lore.kernel.org/lkml/20210726102247.21437-2-mgorman@techsingularity.net/
[cut]


thanks,
Chenyu 
