Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799DF522A7E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 05:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241936AbiEKDlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 23:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241909AbiEKDlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 23:41:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD67A45792
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 20:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652240471; x=1683776471;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=6XMgFyUuqPrHSZL+y2Hlat6X1Dsqb/hifTE/KqF8LVI=;
  b=AR6oLNzw1D8O2HTz9j2svp7xA+6iW0TosJdJAipk+oIkTDUsnop5AGBc
   IGtZxmd7LX2zU76lSQnFxLrpXKmWwKNcUvlXU4ywpIng13IFeH0NnmGLe
   Pwwd5VCUhs0fukKQB6/Ur34xSRHXhm2xZ3oo6jT2jbR6fVn4prp5lv75n
   0ai+PrD7cTUDtvdSe+skFSRl9vcjFoOFNVONJ0dzBq5ARyAcQgrEr8sPz
   0dgA98cNxnPycQQ2dKqT/iGQtZVjLWomUztZ2rYb5Pa4jDcPzrM2Xtkc9
   nKK8e23SJ88Cs5n9sVQWtYTK8tmHyxTQpti9+mkAZ9ATnDVgXqtsBC6HH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="267162455"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="267162455"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 20:41:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="711310477"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga001.fm.intel.com with ESMTP; 10 May 2022 20:41:11 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 10 May 2022 20:41:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 10 May 2022 20:41:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 10 May 2022 20:41:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 10 May 2022 20:41:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqmCcSMKqYaFDf6wlTImni/pIaWGb1kTgCgnh860sKoHCpTb0QoRRyPTRuDFBaMNCqk1vDoHrfYYwRuqlfKy7nv5wNmsCHWI0H/MTiBoIUn3ODJwPMqOPByMpdusppAPUUdvwMvAM5kPwad8N8Z6hxVOhk9nXsRViK4y1AsiMdg9FE/p1u8JDsfHdpLH8vYya4aOr8gNztXGGj1m86KXbpbks4rR2/b+vRaozh+7tiRy04Zh/On1vUPcSPpvNBpvf+G3JZrNUGgIy3C+bowzWVw+Zic5AVPM8SjibyUCY2x8AgKU1wfMZ9bTCdQSuNvwQ6qbLVCFtBvYmZUZIDxImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B19pNZhAt1VWQrfEcP0EIL7b5sJaq2eLtNiFjn4qVVg=;
 b=PLZSRAqoNrw0W/y9Ox4Dh5d3j+2hI3fH61wmlaKOIs5owk9pqRnCBw7tcNVZt1YrHFWezNdnQd0Xwa8ZZZlc0Hx1J8QnaIHfS8qAwHq16hsMf+8QpnMTzE1c/jqXuroFNby//FRAtHGC8C/ehmYTs1edMag7xuq3mZn6tEz6pjObnLXQaV3dzDHOM0McaAVn48/BdcnSpX6hE2S49Jl5zQzEYxHNuZEqcBFgJQvgqe8UJrfsJWtQXG4b+7/G0RY+75t1Wf3g+jtXjyYS8slkKWrmYk5I5XPFG/SR/sofQrZ2VVHpSoKbZY82mPk9xrlDFPUtJS8Ls016FrTsPmTEuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by BN0PR11MB5693.namprd11.prod.outlook.com (2603:10b6:408:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 03:41:07 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff%5]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 03:41:07 +0000
Date:   Wed, 11 May 2022 11:40:57 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     "ying.huang@intel.com" <ying.huang@intel.com>
CC:     Mel Gorman <mgorman@techsingularity.net>,
        kernel test robot <oliver.sang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>, <feng.tang@intel.com>,
        <zhengjun.xing@linux.intel.com>, <fengwei.yin@intel.com>
Subject: Re: [mm/page_alloc] f26b3fa046: netperf.Throughput_Mbps -18.0%
 regression
Message-ID: <YnswSZQAfRAWr+z0@ziqianlu-desk1>
References: <YmvMDyx05UoPFtQy@ziqianlu-desk1>
 <bd3db4de223a010d1e06013e93b09879fc9b36a8.camel@intel.com>
 <YnURx04+hE0sQ3v3@ziqianlu-desk1>
 <7d20a9543f69523cfda280e3f5ab17d68db037ab.camel@intel.com>
 <YnXnLuYjmEWdVyBP@ziqianlu-desk1>
 <ae763d63e50d14650c5762103d113934412bef57.camel@intel.com>
 <ba83270a-4f37-7d5a-b37a-0b7a6df5f5b4@intel.com>
 <d13688d1483e9d87ec477292893f2916832b3bdc.camel@intel.com>
 <c11ae803-cea7-8b7f-9992-2f640c90f104@intel.com>
 <37dac785a08e3a341bf05d9ee35f19718ce83d26.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37dac785a08e3a341bf05d9ee35f19718ce83d26.camel@intel.com>
X-ClientProxiedBy: HK2P15301CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::26) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d95de31f-8c39-4b58-227c-08da33001519
X-MS-TrafficTypeDiagnostic: BN0PR11MB5693:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN0PR11MB569304F81A5F516EB0A2E22F8BC89@BN0PR11MB5693.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIgyX2O+S2y4jVtQR8JQBsd7yA3j7Iq6kWvi/MSONPcMdfeUlAOI5lgxANMV7cHYZABQVvv+f+85iPrfVYRRleImnUM1vfb6p1WvapeB98NOZl8wXOvQC15015lVMxDhawOrYIRTsod+eHCa05SIt3AJLtWX+Flq9KGxV4nyXyYfN6wSd9rCODwSw/XRs7XYlQMoKKfsxkXfgTJhi9Pd/8ub0ieyvXJRAQF1qR+w7vTO2GvvZwQqL3tcQvHg6paKcFBoGn49XKoPKnv/WHeaxF5ovcaqPoMVT4xg/V6ouKQVxq3kQ0e87G6VLQHhpexM5pq8FPUtKTnjoxug2M0gMqU1/PiIsy1wHlPxbH7nSzgJ6z8z7LkMvlICb/DlLIyLOOSIaif4Fxf8D3vlnVI7yWBygYpBYqN+jflH3eCz9fYeiMp+vkB6l8wr21Dh4GkJ1vsJaEcjWMinnOjgWBRWp3kuelF2ECYNhnqdW4m/Ai0L2Df41uqqRGEOY3M+2GWXKzHB935v2DwyjxT5EANRMFuXFYsENv/MDkjcb7JCAa5ej57RQhdjwv2e0JT+ufL7Mec9xfkz3XLJL7JAXJiESUCnPowe8vx6NEMhF9YJuOLWAsXQgqlYULuPrUPyKj7OXkx9oR5MmaQIyAVewiU1etsmJWNR3m8QAMuGn0zxo4m0UDK5X6f2THlQ2CEPxpbSbKU9Em4CuANc1zoiYTsKHwNbIIkjIyfjymUfOiupzPgMV2utYaRB8fGeEJiLO4aAwqyX+9THht9hA33vpE3fbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(38100700002)(316002)(82960400001)(508600001)(54906003)(6636002)(6666004)(2906002)(5660300002)(44832011)(8936002)(7416002)(83380400001)(9686003)(6506007)(186003)(6512007)(26005)(6486002)(966005)(66476007)(6862004)(86362001)(8676002)(66556008)(4326008)(53546011)(66946007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?IuwdhusnOWARG3PS7mr82Bl4tziuZbBn6cpo9GWxUmXbeCy00ytc1rhpbq?=
 =?iso-8859-1?Q?qL6H4dZLadhtyqADLDDvPJmAmU4sKBJqJwpwUYoP67fMzR05LfjYnwt5Wo?=
 =?iso-8859-1?Q?HH3ztZYhrfzkudKpgOaQPco7mCcu/6By1Uz586GuV5N/VpN5WKDqUXvNG4?=
 =?iso-8859-1?Q?q1JdmAJ2Hv7C7Erq73hpkqcyECi4DmfrFnbylUyTtn/bl1dzVHiQfiJRIo?=
 =?iso-8859-1?Q?ZPOCv48qnjFmvl5PpdZEU0+QTUXHzRIrsdYnstK0XZHzgL5afsy/cOoNUF?=
 =?iso-8859-1?Q?gOuw4t0nNQJM4FP0eiSM0FWLtr2qmyroSjcwTtLKutxRCC9hIh0k4r6TwX?=
 =?iso-8859-1?Q?UjUmJ9G/jMMc3ou9DUAXMshEawlYp+cphwFSkkBzzhoafY/Qy1E1X2Jzjh?=
 =?iso-8859-1?Q?wafTuqa8561U3/OmQFN1JagNZ9B1WhElEAWmV7ywguiY1OvSJ6XHNa4tbZ?=
 =?iso-8859-1?Q?cfxX9X2IAc5ZDoo+SVsdFpDY9CKCICXMWyy6Eag6PA6cDSOhskn+8WGgC3?=
 =?iso-8859-1?Q?FrvuUvHL9kPLhdPM9Cvp/vd3g4BbFeJDS5gUyHh+vI9CEe7xgv3/S86MDh?=
 =?iso-8859-1?Q?UqlPG0qciXf+z1gSBD8oWPfllLhIiH2bdDg09SNozzyXchnQBe0wBPH81m?=
 =?iso-8859-1?Q?uyiZCNUuP42XJd1w1hkPfri6cipQS3dRdjhQl/PErJzRy+4wbop90kUm2a?=
 =?iso-8859-1?Q?mRz55G1jQ6fE15Ob5+RsYuX/S3zTEHZJwh+KjA/QgxYHzgXMBIwacmjfHW?=
 =?iso-8859-1?Q?/QGrev6koiyqpsTyWByocmisweHyKxkn+YF3H/1DeJ8L0ydHdcmZUvZ7wz?=
 =?iso-8859-1?Q?DbioohFX9tUciP3w6ns3cZEIz/Gqxmfb5k6kL8QtWrYxhyJn+pv9FD4eja?=
 =?iso-8859-1?Q?MZnhUaoaaRAz6wLDcPNrTVenQrgVOl8ik9RnIW8b1XtR+p8/OUtgrZHZjT?=
 =?iso-8859-1?Q?T3cfRWsLNH2WCQxwlUEDZG7u3iptnnLacTyjjqG2n3A1/kygWWvYMBFa53?=
 =?iso-8859-1?Q?xq9QLPl1yzMHscnFNGPJ93PjjDh/4VHKAVdOtEu9WSqGbbHxZWAeyz7Dna?=
 =?iso-8859-1?Q?m8hofTdsL0GUBTcgKgKthkXTofVcPTwAr/NTY+pUWb47uaOeE7WYJlUxZd?=
 =?iso-8859-1?Q?Uchmopk/JqOQqyd4xh8MCj/UEs1gCASL4u3kXnoAmii6R/3sP17d4vhIPJ?=
 =?iso-8859-1?Q?degM8xOSuhawqXqOk05FwEvtQnL/zCn+jZet54YPXFMsbktr2xHznLXyCq?=
 =?iso-8859-1?Q?X/0zHJvOAY7sFi96FCcTh3T8z2tB3eIheaGM6146tTt7NuYRWEI1c868BT?=
 =?iso-8859-1?Q?guGrJjnDQsaauzQFTdmYGpZDtmX4U6DsC/N/SRs3sX5/evwVGBYmkC1Og9?=
 =?iso-8859-1?Q?BAH4jmkrfUc4thCymD8GKINrzH+vJljj/JYq1xd6hOG2Sk79s5uqO9wchw?=
 =?iso-8859-1?Q?xCYlvHRzoqkU7uk2ITL4UvWz9FPjweal7wnO3Yz4vKv6d5QjnxfYTY/ng5?=
 =?iso-8859-1?Q?zYHwURUNJVydJPyKbfZU0FHMZrT493jzRkCzMlOpPdC5GFLxsLz0eIF2HG?=
 =?iso-8859-1?Q?Ue0zHiKHlvKZlboy6aUIcAjUl2lkBh/Xf/euur6sJ1BJ45EsuOeiJLnaSA?=
 =?iso-8859-1?Q?HF25Mar1xSLogcjobKLMRgPkaOIGExWwqtyXZfJlZ44uAJcu9ZbzA/6r6S?=
 =?iso-8859-1?Q?o3S/caCEUiJlzjxMWNRMIFQKUWwpbG1Gp2STwsrLJI+SDoDGN/9cqjuxic?=
 =?iso-8859-1?Q?K+eDp5zVmCkw5dnXLaFQNXGj1aw/M7Y7UQDvCuk5eLFyktFI82Y3iWWEj+?=
 =?iso-8859-1?Q?ov3od+7Obg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d95de31f-8c39-4b58-227c-08da33001519
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 03:41:07.5519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZawtTkWE9zupQ8I/H4VeQAmBfn9T/uML9JQwzk6xFDcMXQmNcJi/Z/Zh/Ldpe7UuwVQ0JuO3AWPA4tjAc99xnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5693
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 02:23:28PM +0800, ying.huang@intel.com wrote:
> On Tue, 2022-05-10 at 11:43 +0800, Aaron Lu wrote:
> > On 5/7/2022 3:44 PM, ying.huang@intel.com wrote:
> > > On Sat, 2022-05-07 at 15:31 +0800, Aaron Lu wrote:
> > 
> > ... ...
> > 
> > > > 
> > > > I thought the overhead of changing the cache line from "shared" to
> > > > "own"/"modify" is pretty cheap.
> > > 
> > > This is the read/write pattern of cache ping-pong.  Although it should
> > > be cheaper than the write/write pattern of cache ping-pong in theory, we
> > > have gotten sevious regression for that before.
> > > 
> > 
> > Can you point me to the regression report? I would like to take a look,
> > thanks.
> 
> Sure.
> 
> https://lore.kernel.org/all/1425108604.10337.84.camel@linux.intel.com/
> 
> > > > Also, this is the same case as the Skylake desktop machine, why it is a
> > > > gain there but a loss here? 
> > > 
> > > I guess the reason is the private cache size.  The size of the private
> > > L2 cache of SKL server is much larger than that of SKL client (1MB vs.
> > > 256KB).  So there's much more core-2-core traffic on SKL server.
> > > 
> > 
> > It could be. The 256KiB L2 in Skylake desktop can only store 8 order-3
> > pages and that means the allocator side may have a higher chance of
> > reusing a page that is evicted from the free cpu's L2 cache than the
> > server machine, whose L2 can store 40 order-3 pages.
> > 
> > I can do more tests using different high for the two machines:
> > 1) high=0, this is the case when page reuse is the extreme. core-2-core
> > transfer should be the most. This is the behavior of this bisected commit.
> > 2) high=L2_size, this is the case when page reuse is fewer compared to
> > the above case, core-2-core should still be the majority.
> > 3) high=2 times of L2_size and smaller than llc size, this is the case
> > when cache reuse is further reduced, and when the page is indeed reused,
> > it shouldn't cause core-2-core transfer but can benefit from llc.
> > 4) high>llc_size, this is the case when page reuse is the least and when
> > page is indeed reused, it is likely not in the entire cache hierarchy.
> > This is the behavior of this bisected commit's parent commit for the
> > Skylake desktop machine.
> > 
> > I expect case 3) should give us the best performance and 1) or 4) is the
> > worst for this testcase.
> > 
> > case 4) is difficult to test on the server machine due to the cap of
> > pcp->high which is affected by the low watermark of the zone. The server
> > machine has 128 cpus but only 128G memory, which makes the pcp->high
> > capped at 421, while llc size is 40MiB and that translates to a page
> > number of 12288.
> > > 
> 
> Sounds good to me.

I've run the tests on a 2 sockets Icelake server and a Skylake desktop.

On this 2 sockets Icelake server(1.25MiB L2 = 320 pages, 48MiB LLC =
12288 pages):

pcp->high      score
    0          100662 (bypass PCP, most page resue, most core-2-core transfer)
  320(L2)      117252
  640          133149
 6144(1/2 llc) 134674
12416(>llc)    103193 (least page reuse)

Setting pcp->high to 640(2 times L2 size) gives very good result, only
slightly lower than 6144(1/2 llc size). Bypassing PCP to get the most
cache reuse didn't deliver good performance, so I think Ying is right:
core-2-core really hurts.

On this 4core/8cpu Skylake desktop(256KiB L2 = 64 pages, 8MiB LLC = 2048
pages):

   0           86780 (bypass PCP, most page reuse, most core-2-core transfer)
  64(L2)       85813
 128           85521
1024(1/2 llc)  85557
2176(> llc)    74458 (least page reuse)

Things are different on this small machine. Bypassing PCP gives the best
performance. I find it hard to explain this. Maybe the 256KiB is too
small that even bypassing PCP, the page still ends up being evicted from
L2 when allocator side reuses it? Or maybe core-2-core transfer is
fast on this small machine?

P.S. I've blindly setting pcp->high to the above value, ignoring zone's
low watermark cap for testing purpose.
