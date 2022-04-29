Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFC4514827
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356741AbiD2LdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348567AbiD2Lcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:32:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7702B48E62
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 04:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651231774; x=1682767774;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UBywjs8fko+DwZS+xu4EaG1GIp82zr4CB8b2puwJSf4=;
  b=lnDW6UsZXYO1ZCD4+OxTflw8x3ppWAf9Yt7cr4/9yjNYdtTkJpSxl+0F
   3YWK4HeuUmNj1852TQBXUBT8P4AL3ogoD5Ve8Xc8rjG9g0o83iYqk/Dhi
   /iiYiV4Qe2H6BW3Rvnc0ddCBQRYxd1EwFfXIjSGAlM4A5YJfnag/8cZOw
   tDR6elY5qgrP/O3+9gX3qpzTNJ6rUkkX9cS6oKaaoj9K0NbO1DEeTkMbL
   VLll8CIFV1nMqA0mLpiFK8x1PCk6UdWM3z6KYXMVCbicr+p3xnSlJ9gWH
   1aYkwj74ex3fulxL9ahzqIPpb/7bB7nkwuiIOoMrGoiEiHJYv3Kuqyy4O
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="248547998"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="248547998"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 04:29:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="880821716"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga005.fm.intel.com with ESMTP; 29 Apr 2022 04:29:33 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 29 Apr 2022 04:29:33 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 29 Apr 2022 04:29:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 29 Apr 2022 04:29:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 29 Apr 2022 04:29:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5Evc+D7c0n8fJHwiSgJSsVOB2MDtEFSs5+xhMPfBXVO19+NJltlcQzL5q5yqEPrCy6FWAWPOZp+VxIRpbz3POoEGATRToJvCvpjxaRGLD/rWne3WXQ+pxwzrjLobD5zobw/psGRuX3BrRwLOyQKIujfsHBlB1DDrq6+84gZGyGyoX/kGj6iEoDFHPDjZ7JpzloguVvdixXplD+wTdENCT7y6Wh90wrGqpi+ywnkaHKB09QXqSgvM0E9SQhpTWCvBCmxmfxzo2THbxPF8qPhp2whncT3UghsmGSmzRpIN5DNe0xBgza29nscWUxgEbo8CqWaTQjSxp0c0rXXWuXdVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwKi5InAX5vYM3hoMLEEuAR2il9vMUwEobpeSUV8zxg=;
 b=Pu8zUMYuO2lJUGHop/LhlVQFh0gDpvw9sDfYzsAutUIirBIG9cMXhPviljQhnMhXPTduiHJ0ufn1xkNysJPeN1AZjkHilUdmEpJ98wLMPOAh/pVDLH7zaoQjScguQPUKuCxObSK1ixB6loGSsSqCRnwfvPSoKAsthvpCkRsXz9i/CAKMJ9xWLYwXCik4ugCFuXHvWJq9cKLhjfpx59+j6pWvyPuTaJX2z0TVRsvoMfaIiyCGeK6h1W+lJs1Ge6FK86an9VrNazVw1IR+QzUIQ2RiF1SQYo+BlEhR9hqfgNxHHxRtcciTzY/QNEXhQrP9j2TZ0Y4PuebF8WvT0I1UrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by BN6PR11MB1892.namprd11.prod.outlook.com (2603:10b6:404:105::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 11:29:30 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff%5]) with mapi id 15.20.5186.023; Fri, 29 Apr 2022
 11:29:30 +0000
Date:   Fri, 29 Apr 2022 19:29:19 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     kernel test robot <oliver.sang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>, <ying.huang@intel.com>, <feng.tang@intel.com>,
        <zhengjun.xing@linux.intel.com>, <fengwei.yin@intel.com>
Subject: Re: [mm/page_alloc]  f26b3fa046:  netperf.Throughput_Mbps -18.0%
 regression
Message-ID: <YmvMDyx05UoPFtQy@ziqianlu-desk1>
References: <20220420013526.GB14333@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220420013526.GB14333@xsang-OptiPlex-9020>
X-ClientProxiedBy: HK2PR04CA0073.apcprd04.prod.outlook.com
 (2603:1096:202:15::17) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea908cde-bc29-4660-83bd-08da29d38659
X-MS-TrafficTypeDiagnostic: BN6PR11MB1892:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB18922A5D1F49B379EB06C3778BFC9@BN6PR11MB1892.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+yzO7cuCvkIkmQKRJUjrIf4jQ+3Qu5KA7AMczKpQkN20OI8aTabve3fJg0CzhJ9hhBS+6S08w5g6E/pCqtmYrmmDJm3ehJLHrOmvPoaVJ2bahAyIG6Lc/tmUvLeL8gAIMQVm25Gri49/+j/QDXCw+Dv1DifqiSig/zORutZv9kQ+YJDCG3hI7gbWQgIER2cLPotiJlJHuJGzwEEe69qBJTGuqPe+hGcYguWrXIJtjV1nOFfk87ThhgiifH5+X14qROZufjVBUye2mnMc9Ub69M4Bh5BtoW1dGsCQRf9znVrAZAfOb+3GCtnna8EejWtJjSdQd8WUKaXtLelZ35V7fhvc/raRtFzVi53BWSg2750wTTaOl9sxLiGxVcUtU8RglfxouFT/iAxdVu3NTTUS2Xq7z53UdXew9/eAY9RpSgfayvPDijYFphfXUNc1HC4ePcEKJa+D/TaaAdXxUt7oFMjTRC+25Aac+jyDluTNQLx0U8y/uHW4YkK73lmVfKKuSm7JHSVH3PC9RXugDtErpUKxJkiUsojsQK3suoVDuC/MotySSte/hmsEnewzd8x5BugzLSeV6eetWQOHna+apGQQW2VoS/2lQ5jpeMpU0Dc6PQFju+QkjmqeHAssm1wZj6ENKLXW3F9Fh9XrC4btLjZ3e3ni7BpHf8ZqXCDwBrw11jn8mQp8Q4irkKDD4RD4yAO9x/MOO1p4FHaFaAdzDSbNknNfhrzZELOZEgWv/k3EZXuOYmegJIKi9Ey76l7oylihsq4P530VealIoOyig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(44832011)(6666004)(6506007)(83380400001)(8936002)(186003)(966005)(6486002)(86362001)(9686003)(5660300002)(508600001)(6512007)(26005)(2906002)(82960400001)(54906003)(33716001)(7416002)(316002)(6916009)(66556008)(8676002)(4326008)(66476007)(66946007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+8xPraKc21BJckui78RpmioZ3gKIGblRtR61k3bKW5Ys8Qkj/UOcJ2P550VF?=
 =?us-ascii?Q?Ro3h2PodeB+eSL4B7TSDdTRN+iqRBvUXf/oTRz4MMjs0S2UKYBcLJmUw3n7z?=
 =?us-ascii?Q?kg95ijHc0rzfREK1uYhwD6crISshUQabyqo8E47G+Akz9wBmJBS+lhFSELrA?=
 =?us-ascii?Q?1+ai/748gRFMI6j9Crh0hTU5DLhH0cPQLBADlaRgpUxjDF7yaNJfTW8ls+ZQ?=
 =?us-ascii?Q?GDCs4TDWCWrfK2iaJDiLP0qVS/H6mzyOUHgH+Heqk1jx1iblP0hTIIdnLB10?=
 =?us-ascii?Q?AOgpD2t36VDk98GTmmiqOBjxS6+4+u2KaZ0wTm0tnyS07pM8wlb40cDG9YnW?=
 =?us-ascii?Q?8qIt7OXxn6JaJCiLWP+CbwedU8Ww1Q/Nsqwap6ZzGJnw6SQQWi1mlWVOLne2?=
 =?us-ascii?Q?UZYvnnjnZJL53lHZHlzO22hpIA/7/xAdfYyVb4uvnJ03squHcNtckikuX/44?=
 =?us-ascii?Q?F9Sf9kUUnLvDHlDUU04QVP6uweqRLSQNWu0x22uPrgVSAPbjI80rdqCq0mgR?=
 =?us-ascii?Q?77zmTc1vLoyq25BnG9ehqLml/IXXuFi7AZr0CTsf+4DVGxJe8u+A8VUO8hSI?=
 =?us-ascii?Q?ezITMtWxwdqafuSG7x7k+bAX+UjXuoL8yQ9tcHPC1ouULWYIDCLAapKNA2DW?=
 =?us-ascii?Q?Cdp6TfhyY68/I2K1GPeJrLMV+YkHFtI3KxTd54UcrG4XTUJZCapxgUgm6lBd?=
 =?us-ascii?Q?3AJ39AnXA9rV50BCTzgIoOuo/x5DpBUutPA8s01fOarsihb5rW1+XVPP8Wl4?=
 =?us-ascii?Q?BqVnal1eVTqMPdvSdMJQWNdSZlZzqf6MlNhI6DigyrFxh4pLiQ7x6P9PTrnm?=
 =?us-ascii?Q?T2BKMyjJwc5xiNh6aFF1kPC/WC9eydK1Cs57q/Tf24F2ojB4E1fMifUl+a3L?=
 =?us-ascii?Q?2ujvJdDgJwT28OziKpYXX7id+gFTbELb03JyTGVIUzHU+oo7lsqVNWFEgZRC?=
 =?us-ascii?Q?o81XF+YgM3DOUCGVBC7VGvk+MEsqCA3Opw0vtzONkjLul7E1GJxZzegPi5Sy?=
 =?us-ascii?Q?cCme8KFczUy2d/O4CO9y8LpA23GKakVGz/bP+RCK5TAl7UzwqHQ9/3pjCjAG?=
 =?us-ascii?Q?uY4aTtOu1Fm32SL5Yk0ZxqkEpZB9VfFgQX7iAvrjCBg/AYE2yPKZXO+IlFR7?=
 =?us-ascii?Q?QJSljR8GFabz0LkKvWu6OsptVkxb8MqB6lTcKwGFLL30I/0hJzdqcSYTyct2?=
 =?us-ascii?Q?TNPe579uSwdf1JYXRF9AVrbzvFWOW24nfihcyaml+QwfCa6DFBs3W4Lu/A7u?=
 =?us-ascii?Q?4tRNFOiBb8TFpNemRH0DcuLn+KuDbDXUuuPhG1fY9Rfn4AFVkpzLGPutZ8SP?=
 =?us-ascii?Q?JAsWxX7ADgYBQhFx3/GC4Rp/9FyEATdAxSyS/D66R62a1M+b6wMbI/HvTJ0k?=
 =?us-ascii?Q?qup4lYO1CgMy6+Gd5ytPwyS/a99O2GdxfFA5uFEOqStIakpOrKcdhE/sYs39?=
 =?us-ascii?Q?RjIIU46ha5iaGcBel/vBZlZVHqkf+ng4H8oXaJplvNhYXBGtFeKpkdrDYgAx?=
 =?us-ascii?Q?ypE8uXUd/wY6h4RW6vsg9T2GXBMAxRUV3NYq0F908GXX5VOCJruh1A1g+12a?=
 =?us-ascii?Q?i+Y4iihBqkPujWahb7BMRMCGS4FFsaygmYzUSGnvAabCdsk3YiezbQ2X76ra?=
 =?us-ascii?Q?T4IKEu1l6JoE1aZg52C9zTWx+q5ZlNi+KQIONnG+0a5aobL/BaKEFs3kX3iX?=
 =?us-ascii?Q?HCfvSTIO+xTQPSgsB3YcDp5BlXIxuitXkZXGXDhFaB8Q7G00uNq0Fd/oO/DK?=
 =?us-ascii?Q?fay0wXGTnA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea908cde-bc29-4660-83bd-08da29d38659
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 11:29:29.7229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymvrlvK5qjbYUlRB9Cqa5ClrhE2+zasbCpJpu78Cvx0tlG+T1dMDu0+Hzi8dTAbn/29WNdeZyDbVr9ji2wfTAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1892
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

On Wed, Apr 20, 2022 at 09:35:26AM +0800, kernel test robot wrote:
> 
> (please be noted we reported
> "[mm/page_alloc]  39907a939a:  netperf.Throughput_Mbps -18.1% regression"
> on
> https://lore.kernel.org/all/20220228155733.GF1643@xsang-OptiPlex-9020/
> while the commit is on branch.
> now we still observe similar regression when it's on mainline, and we also
> observe a 13.2% improvement on another netperf subtest.
> so report again for information)
> 
> Greeting,
> 
> FYI, we noticed a -18.0% regression of netperf.Throughput_Mbps due to commit:
> 
> 
> commit: f26b3fa046116a7dedcaafe30083402113941451 ("mm/page_alloc: limit number of high-order pages on PCP during bulk free")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 

So what this commit did is: if a CPU is always doing free(pcp->free_factor > 0)
and if the being freed high-order page's order is <= PAGE_ALLOC_COSTLY_ORDER,
then do not use PCP but directly free the page directly to buddy.

The rationale as explained in the commit's changelog is:
"
Netperf running on localhost exhibits this pattern and while it does not
matter for some machines, it does matter for others with smaller caches
where cache misses cause problems due to reduced page reuse. Pages
freed directly to the buddy list may be reused quickly while still cache
hot where as storing on the PCP lists may be cold by the time
free_pcppages_bulk() is called.
"

This regression occurred on a machine that has large caches so this
optimization brings no value to it but only overhead(skipped PCP), I
guess this is the reason why there is a regression.

I have also tested this case on a small machine: a skylake desktop and
this commit shows improvement:
8b10b465d0e1: "netperf.Throughput_Mbps": 72288.76,
f26b3fa04611: "netperf.Throughput_Mbps": 90784.4,  +25.6%

So this means those directly freed pages get reused by allocator side
and that brings performance improvement for machines with smaller cache.

I wonder if we should still use PCP a little bit under the above said
condition, for the purpose of:
1 reduced overhead in the free path for machines with large cache;
2 still keeps the benefit of reused pages for machines with smaller cache.

For this reason, I tested increasing nr_pcp_high() from returning 0 to
either returning pcp->batch or (pcp->batch << 2):
machine\nr_pcp_high() ret: pcp->high   0   pcp->batch (pcp->batch << 2)
skylake desktop:             72288   90784   92219       91528
icelake 2sockets:           120956   99177   98251      116108

note nr_pcp_high() returns pcp->high is the behaviour of this commit's
parent, returns 0 is the behaviour of this commit.

The result shows, if we effectively use a PCP high as (pcp->batch << 2)
for the described condition, then this workload's performance on
small machine can remain while the regression on large machines can be
greately reduced(from -18% to -4%).

> in testcase: netperf
> on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory
> with following parameters:
> 
> 	ip: ipv4
> 	runtime: 300s
> 	nr_threads: 1
> 	cluster: cs-localhost
> 	test: UDP_STREAM
> 	cpufreq_governor: performance
> 	ucode: 0xd000331
> 
> test-description: Netperf is a benchmark that can be use to measure various aspect of networking performance.
> test-url: http://www.netperf.org/netperf/
> 
> In addition to that, the commit also has significant impact on the following tests:
>

> +------------------+-------------------------------------------------------------------------------------+
> | testcase: change | netperf: netperf.Throughput_Mbps 13.2% improvement                                  |
> | test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory |
> | test parameters  | cluster=cs-localhost                                                                |
> |                  | cpufreq_governor=performance                                                        |
> |                  | ip=ipv4                                                                             |
> |                  | nr_threads=25%                                                                      |
> |                  | runtime=300s                                                                        |
> |                  | send_size=10K                                                                       |
> |                  | test=SCTP_STREAM_MANY                                                               |
> |                  | ucode=0xd000331                                                                     |
> +------------------+-------------------------------------------------------------------------------------+
>

And when nr_pcp_high() returns (pcp->batch << 2), the improvement will
drop from 13.2% to 5.7%, not great but still an improvement...

The said change looks like this:
(relevant comment will have to be adjusted)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 505d59f7d4fa..130a02af8321 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3332,18 +3332,19 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 		       bool free_high)
 {
 	int high = READ_ONCE(pcp->high);
+	int batch = READ_ONCE(pcp->batch);
 
-	if (unlikely(!high || free_high))
+	if (unlikely(!high))
 		return 0;
 
-	if (!test_bit(ZONE_RECLAIM_ACTIVE, &zone->flags))
-		return high;
-
 	/*
 	 * If reclaim is active, limit the number of pages that can be
 	 * stored on pcp lists
 	 */
-	return min(READ_ONCE(pcp->batch) << 2, high);
+	if (test_bit(ZONE_RECLAIM_ACTIVE, &zone->flags) || free_high)
+		return min(batch << 2, high);
+
+	return high;
 }
 
 static void free_unref_page_commit(struct page *page, int migratetype,

Does this look sane? If so, I can prepare a formal patch with proper
comment and changelog, thanks.
