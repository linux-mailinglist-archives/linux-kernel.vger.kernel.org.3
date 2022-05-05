Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2FE51C293
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380613AbiEEOdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiEEOdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:33:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9AB19C27
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 07:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651760968; x=1683296968;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=I3uC7ZNoLkMV2PN+MYFwGVHik6Az91nOYBK1xrNI5L4=;
  b=epHx5awCkV+66y88syUgK9pwxMRiKLz8I9lsXh4C/IZoh3Dlq2DoGH3O
   v7I4ModiV38P6edHJZZpGtWKZgYg4rlFppG4xbf7aYqWrCgZ+QNxU1lM/
   I+ZviYXz4zls4ouEPBryOiNFPF4+/85t80LShB/GBlXLuipvfRH3wCGR/
   kyA5GR6Ad6mpIMjU2BbTCfzCRXAQbaJdTlI4CdIex15Ky7olVeDNEe47T
   KfKDZuHmquomkSNWTaplCPgw0G676PMLDX16XQCLAoYhCMLcYEnDuTwNj
   ppTUObtgJZXHyXM0I+IKR2y3i6ZTeIm8FeR3WDD/lm9zV2Fxcm9gyObxh
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248032384"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="248032384"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 07:29:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="568613289"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga007.fm.intel.com with ESMTP; 05 May 2022 07:29:27 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 07:29:27 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 07:29:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 5 May 2022 07:29:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 5 May 2022 07:29:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNoUL7qu1Zc7cB7gSn8LgMcfRC9//n+PlrdbLDw/YQyJ/DnrVxXZDWWGDqngpX2bbcVw5VD9zlvMAcOPDOTJz0iA5jw0IyBF0hY5ceFiJb99Mc77QmKMqmqbvG2VMqGaogNuRQsg5sBWJRyKIHUZVMZlBEat1zZzAQzdmAv/u2NpFYHelefXCKE2cD0jrVgVbgriUE1gZKtMUqYj28rxAH4TITADxqQl4gR3eAB2WzJUXNDvXvvNtxdDz6jTsE50FC0HX8dUokR9bQsRT5jdBWVhdh5b0R3iNVa1WyOcIZHVYdVVrKlrMIAGc3EYqwoNXmwPl0zqbnTu/GZd53ZxJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHu5GZtpJLDXVNUa4XSke2+tRRLvUnHVjz2tQUeGi9M=;
 b=EI2XhGRuJishOeStXjYVOJCNpPR6yGnjVpqi4e2jNd6dT8i0WCGzC4o1XpXO38A9o4xzc/JZKtnahFOAQj82SSgI4oRdentNmZe1fDIPrKQqOVNjY1GwLOOOR3/um5cRmFEEVr4YXUHJk3m030expPIBvaGgejvcLdg5zQlhDJyO1EcnQ0Zz1Km5TGA8cmiAUD9KHNNUE6G++YkStIxnj0IPbAMDACYXlFy+kvYpS1GafoV/cN97pw31GP59uEfzD1JEk7G7Hv0iWA/0NLWveeCQWG1K78xk1oEt1YvqU7j3a8K+xbfE8scmQpqcnLqGSooZ0ewZLS2mfFy+Xg9y7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DM4PR11MB6095.namprd11.prod.outlook.com (2603:10b6:8:aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 14:29:24 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff%5]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 14:29:24 +0000
Date:   Thu, 5 May 2022 22:29:16 +0800
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
Message-ID: <YnPfPH4bbLIkCeNp@ziqianlu-desk1>
References: <20220420013526.GB14333@xsang-OptiPlex-9020>
 <YmvMDyx05UoPFtQy@ziqianlu-desk1>
 <20220429133918.GC3441@techsingularity.net>
 <YnOKWNE3PZzzohNH@ziqianlu-desk1>
 <20220505110947.GD3441@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220505110947.GD3441@techsingularity.net>
X-ClientProxiedBy: HK2PR0302CA0022.apcprd03.prod.outlook.com
 (2603:1096:202::32) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d68791a-fc66-4661-7dd2-08da2ea3a718
X-MS-TrafficTypeDiagnostic: DM4PR11MB6095:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM4PR11MB6095A3B1B7F34F7440CF69778BC29@DM4PR11MB6095.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MemPJW59MpoDnJNUyFkU6j4xToJ3+OZSc2ZTeGiiSoL28opVQCT5hcLyvUc24BMz8Tk56U9RPlwjWaKqME4Ch/3yxDzRuUze19i4AeMp1WX1eD1HByr3TKodKQjVunYTQJiHsAgC2W4t2+DlB5tmh5tWDHrWbaldVTfrV183e0qROx1uQ7JjW3USBFUgzjC5c5JJSYsLeBAgR+dZy1mAO7S9ZMn0NSI0zZA4r35W2xJ0/eXutC8cLKDwL9ZmdLHPjz6xNLoudWrztEFa7wgajTtPDk98ncaS+iWrSXdez+P08mAEcooRULUnWAgf6T7Qo7mtW2XbL2iF1C6pWw/WhYrnx7Dz6T3a/tjHUm1EPtQVA81+SZO/AsswUbrBySF8Sd+vru0t7uNMNgBfXUGGP/7hgJYmT+58s02h9dkAtVGin2pnr+qdVxB38tT9ktD5P4IcgWCtgWcKPboowDz5Pp06TLgXeWS8+/HY7q1B7JdvO1bh/Mmm4cq2cKBlTigZ8B3L8vzNQV6VuhUvHOFVB/H47aaCE3F0op7zvzHyhi4f3a7FlA1L9cCOZj73jjs5FhZuMV/DNxr0zC863hlbtM7OA7OEwqgcXYWxBn5DInMlwCzSrgTUciP4BnckZ7uIjPN4BPXOOY6lM2O+ZFq7AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(186003)(316002)(44832011)(6512007)(9686003)(38100700002)(508600001)(6666004)(33716001)(8936002)(86362001)(6486002)(54906003)(6916009)(82960400001)(7416002)(83380400001)(66556008)(5660300002)(66476007)(4326008)(8676002)(2906002)(6506007)(66946007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G46ZtIEd8RWENAosU8Cz5H7kNdhoX3K6ynG0Fco0AgXNgeutkZKtN35bNwLI?=
 =?us-ascii?Q?R5cSko/T9N1szSSubd9QLxPrDVfJNC7ZApUn2zVv+9Dt9cS6ZqByUCVDbq6L?=
 =?us-ascii?Q?gXwev9uQSPscv3xef35WgM2EFeMM4j0yGGmmr0rR4DyB2eHUR7tJBwLlibsz?=
 =?us-ascii?Q?rOPG5QM6CPnrp8MZKJu0SmeMKYYugSNj/wD9fDdeWYgegDnt0w8USDhQBIbQ?=
 =?us-ascii?Q?I43wiEKd5XWUV+oLzLwl+Y8+t7abGv97tHaR8FP0utJ90E+0mD2GeseZUVZI?=
 =?us-ascii?Q?qF0rBomac2GoASKrKhxGdn5fPCvsRJwuPOts5VWgZ0PcCkrvLTdX1c1EEg9L?=
 =?us-ascii?Q?0+CGW5qMscbEgSkdPCjzTtuXeYv4gt7PtHdbcugQ3nh4adnn0LZDgiaAlosO?=
 =?us-ascii?Q?4TfcnnB8NnCIWN0ZDlPPzmQGyjUlY+EZukAi8zHXgscc/BzNCySNXSAf323o?=
 =?us-ascii?Q?s6RWBXFWjN+AMjCesKY0XtvBIYz1h9shFM8QtCv4lHZQgAXBVAtrSRpYVLY5?=
 =?us-ascii?Q?+3YY3oqFXD4/gvdUAIZjGFwJMyICIR1FFilBcvHcO3BonQ1LawSTOgwn1vou?=
 =?us-ascii?Q?56hfXlzGW7Qv+FrO2BMxdXCYTEOembub+pgL5K7wtX0pdEBo12nC3P7B+P8g?=
 =?us-ascii?Q?0F7yuQBoAIqEiMQA0sskO4GRgAikDU283emnimkzhhPWLDO6OPxDDRz0DYxv?=
 =?us-ascii?Q?sMcp5oiKdeHGM9J4wwQfYnKyNK1jc8nqLsO87JhZlReS6MiRN382kjXJD4Gm?=
 =?us-ascii?Q?wCV1iRQMlW/qA0xg6kyPomy35sFDXCQTEaRJ51CDfax7eJrPFUDP3yla2cWO?=
 =?us-ascii?Q?z6quj+5hPz4B1oYSfaX+E9qEEpBSS8aZeiOhbdiqs/qIw1oePCg2T/LL/Yuj?=
 =?us-ascii?Q?pJaTJKA5A2LKeRARvxfvikdjwOF79ZjakPDx3ExXOIRiBni9SQotnPdzgpNc?=
 =?us-ascii?Q?bSwXSXwNPVVc5jscixm0gplLCqgJW4vZUDeI52ULtCysvov5PxFzsfmqwEsj?=
 =?us-ascii?Q?DOyCjVHZkKholqXxmU5MwB9LZmrKU57olTckQlbTW5Xm7Iq6ICKStQwEAn+c?=
 =?us-ascii?Q?lK/8Ew50X+jvwEgMxlk/l4GkEVLr9qObeVLzuwmFwDEgglRdv+vOI9V4wLav?=
 =?us-ascii?Q?VKknQqecAGIh84mCGJaVhVuGmMy8WtETkjX/HnTUaM5/IokSqv+CYYQJ1wBG?=
 =?us-ascii?Q?uFfuDht6ZgJDUeiYY9ck2F6NzXctnOAXFuaqT8EkgtSMDA8K0guOnwTM2ySM?=
 =?us-ascii?Q?G4I2WMZDYgzEDabnG4hALwkOlzMKtSYyA/wIYtmOnGZAARk+uqJ4iFlsE9k3?=
 =?us-ascii?Q?OUIFiGeM9uqJovThQKVwdMexuUKMxOEvn/4csmAVld6hTX3xTz0rIN41mqtF?=
 =?us-ascii?Q?bUkns0nhmP5c0rTIqznhTbUVG0LW3NUWSwh9WX/fdncxuRCT0x+wTF1PVVoT?=
 =?us-ascii?Q?KSI3O8IH13K6aUkWO8dOkxiKKXPmo9sAd2yt65O1Q/uceY9f/aUB2+uSLoIZ?=
 =?us-ascii?Q?0rnSXVZz4m4atAXEAcQ3Mm+GQyAKaReTKY/hmyeaew4nKisBQ8zeUMcrnF78?=
 =?us-ascii?Q?yULv0BlNW+zsipJ3eomBNMmGP45fr0B+BR/2slylfVIa1p8qHHi1hXwwgBI+?=
 =?us-ascii?Q?5b03dB+i89TxwwVphtjJvB1KR3yJGma9o2lWGXqmdkfIVX4lTk7Vbi/7iAll?=
 =?us-ascii?Q?a4VFLjPYIPf4ZRVCuK4eBUf35qo0je3ipOHtZxogHtEIo8tRET47C52m5MmO?=
 =?us-ascii?Q?+5t2k+wNVA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d68791a-fc66-4661-7dd2-08da2ea3a718
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 14:29:24.7105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvrskQjynLlTM+wKypJsI0sfplEQr9M7tueMJnykq1nsKP1JfGGHNkWgIFJXgm1zxe6EclYV6un4ZBzCNiJZkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6095
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 12:09:47PM +0100, Mel Gorman wrote:
> On Thu, May 05, 2022 at 04:27:04PM +0800, Aaron Lu wrote:
> > On Fri, Apr 29, 2022 at 02:39:18PM +0100, Mel Gorman wrote:
> > > On Fri, Apr 29, 2022 at 07:29:19PM +0800, Aaron Lu wrote:
> > 
> > ... ...
> > 
> > > > The said change looks like this:
> > > > (relevant comment will have to be adjusted)
> > > > 
> > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > index 505d59f7d4fa..130a02af8321 100644
> > > > --- a/mm/page_alloc.c
> > > > +++ b/mm/page_alloc.c
> > > > @@ -3332,18 +3332,19 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
> > > >  		       bool free_high)
> > > >  {
> > > >  	int high = READ_ONCE(pcp->high);
> > > > +	int batch = READ_ONCE(pcp->batch);
> > > >  
> > > > -	if (unlikely(!high || free_high))
> > > > +	if (unlikely(!high))
> > > >  		return 0;
> > > >  
> > > > -	if (!test_bit(ZONE_RECLAIM_ACTIVE, &zone->flags))
> > > > -		return high;
> > > > -
> > > >  	/*
> > > >  	 * If reclaim is active, limit the number of pages that can be
> > > >  	 * stored on pcp lists
> > > >  	 */
> > > > -	return min(READ_ONCE(pcp->batch) << 2, high);
> > > > +	if (test_bit(ZONE_RECLAIM_ACTIVE, &zone->flags) || free_high)
> > > > +		return min(batch << 2, high);
> > > > +
> > > > +	return high;
> > > >  }
> > > >  
> > > >  static void free_unref_page_commit(struct page *page, int migratetype,
> > > > 
> > > > Does this look sane? If so, I can prepare a formal patch with proper
> > > > comment and changelog, thanks.
> > > 
> > > I think it looks reasonable sane. The corner case is that if
> > > ((high - (batch >> 2)) > cachesize) that the pages will not get recycled
> > 
> > When free_high is true, the above diff changed the return value of
> > nr_pcp_high() from 0 to min(batch << 2, pcp->high) so the corner case is
> > when (min(batch << 2, pcp->high) > cachesize)?
> > 
> 
> Yes. It's not perfect due to cache aliasing so the actual point where it
> matters will be variable. Whatever the value is, there a value where the
> corner case applies that pages do not get recycled quickly enough and
> are no longer cache-hot.

Understood. And as you said, it's a tradeoff.
