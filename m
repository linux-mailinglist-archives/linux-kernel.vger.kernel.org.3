Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F72451BA53
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347829AbiEEIbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347434AbiEEIbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:31:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493B62D1EB
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651739241; x=1683275241;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=M952Nmejm69YsvjtZ+4uKwszT2KJJdyDJgIJNHRhNQ0=;
  b=N/f3Q+fT15RcnwJo+q8ZnlpBwmXAnlG4xJki38o2t2VmlJh9niqmTdTu
   r3o7SvmRBkCrFKExQ50dhLQeyfrL9MTb8ilQQRMX27nw8tnfxKqNmkyS3
   iKC29t+Hz37fbtOE3T2ZakZ0J+Jy0eHN1J9i1e6wiWdhJlCj5GDIzxt5m
   2NwrQ+RJB7dJ7zXK8yN7L3naO+nNY/WxVEgCfgEvidCPcdmQGXdGc/H8e
   R/Ipu6tq8mYyc9svxbXoPduGUcdOv7Dqqpb1mvHkWh04Ox5gaOvuA+yxH
   f0u1ChNzPlbM2LELPEvedz80JGbZEsIsnIrK9sEsIlPxl7Fue2V3DtN70
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="331029651"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="331029651"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 01:27:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="599954439"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 05 May 2022 01:27:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 01:27:20 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 01:27:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 5 May 2022 01:27:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 5 May 2022 01:27:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGdXJIwFLqrsGOa06PZ9EGVqEUOB3y7XMk3kmqqEUteTVmGgCbBz8Eel6HWOka29EHob6ZDi+fSsIWB5O0XQic621P7CRbB0/zFbr5KgntMFnBG6wv9j1zXpPgYdEWnE34CVVN63hxCL8vFXF9obna+/MeU9m4BIzDpiG9I4BAMfljJImXALoOvMiz+mZ9oD3ttgmWC2GzMQMvOGEEQW5uLxT0l6SPA5277vxYhvIZLmN/32torUQy/PIOi9M8ynjhVbSy+++fdBCwP4BHTl5t4WxbD4AxayAtcb37xwmu8g8dBpYFZ8foJouAdlz1lrsDLuNLn/4WmBJ/h8AJn2uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CcLh0qw+5eYhaSMj1ZsRQntME2ofHcXEhtoC7X9n6U=;
 b=XaSQNfZg9GvZxV8eWTaT/7M6pYYV1iJa4nH43D6tmwotLUe2NsqGYJ0lQhs7NAPx1zVI1jOUhTqC3FGlI6ho0V557m8X+pcAfvkCKWekNKyi9QSBFBQTMA6bt7KoJPW7irmIGC135jXXLJdj4hnxXDO9dycz4SSeV/fLeUC3f3ePRhBgauu0wxNqx6LbY1qnpm0ecOi8MLtjF2DCvg8+6IL7tkt2Y7jF+S5zcetfMcUJ0LwhZYRnnlq4WDBJBUaeQMJuwf16qzMtQ/XTX7X/sPo1vS01m2yjMzDLWzMFRbAqMakIu14ld02dPaMGFaTv5LOkb6rYUU2izordOl+I3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DM6PR11MB4345.namprd11.prod.outlook.com (2603:10b6:5:202::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Thu, 5 May
 2022 08:27:17 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff%5]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 08:27:17 +0000
Date:   Thu, 5 May 2022 16:27:04 +0800
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
Message-ID: <YnOKWNE3PZzzohNH@ziqianlu-desk1>
References: <20220420013526.GB14333@xsang-OptiPlex-9020>
 <YmvMDyx05UoPFtQy@ziqianlu-desk1>
 <20220429133918.GC3441@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220429133918.GC3441@techsingularity.net>
X-ClientProxiedBy: HK2PR0302CA0019.apcprd03.prod.outlook.com
 (2603:1096:202::29) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75b2f102-f241-4f4c-ece6-08da2e711094
X-MS-TrafficTypeDiagnostic: DM6PR11MB4345:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB43453E3BD312D61799D5B2FF8BC29@DM6PR11MB4345.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DoSkEllMwOhvx0y98m41AJzIAIKo7UOFW8rhdpj7tR8hJEUSetjPI0DEuF9DbcQhlTC0RyP4Ct6ohfvSZfay1RH45r6Xw6/8o5ZC7ToGGEh7cP8uC38qkniC1yaCvAF9h2CTgcEwSk6dn63cGUDWZko5llWAybBABO6RiGuKbNRsApJO8TjkAko73wTvNQ4hp/AzTlCTg3RaWZDYCmHJCUBQ847nkAoJBLhNY1hdMl0LIvH/L25duptnn/9WqhTJ6TZ6NyW0j8OYAe0WeueNJ21/mFa9vTIDS255/AsiYPXmwNpID/XWT2YgjOh6ae/xSpIvpY8OeQhet/otnTJOtatPJ1+Ft57WXNL6vHE5IQpUkrPhDV65Mi8aPmAKDpgbHWRV8DAjFbVenLWtY+babm3TyzEh3RXMt0GlgTTM2Wug3NhAh2osJUcaUveuxLJEu5tF5VZvIg6Zwl3fRJNE/7bTtvnwrzMTX3L1v8Jf1k5oS4byxKnC2GmS/Q5rDKXX4LMfLWCxNoshS5OWodXu6q2KYffUdeEcv2b1Uo7FIt1B7KGL+Li2dBoyPMLp0Sj2CLjUpMz7joXsRKYTgKMLksUy92XjeFDcg5zdvjfHP+vz4x7xjxvRbH+hcvt5VzECa4AJSszUm9p/1xit6YiHxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(316002)(26005)(86362001)(66476007)(6916009)(66946007)(66556008)(8676002)(38100700002)(83380400001)(508600001)(82960400001)(7416002)(8936002)(44832011)(6486002)(5660300002)(186003)(2906002)(6666004)(9686003)(54906003)(4326008)(6512007)(6506007)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uLA+rz0Vypy7Dv2gYh1s9BvBY3/yd5DtGEx3w9nWpeoEsK467peMUxplyPaY?=
 =?us-ascii?Q?g9VrcEv069zI6wafjPHcOamaT8mEf9fHQ+DzLvxKFABMQD7k/WQTfCK20Inq?=
 =?us-ascii?Q?styhdHrE54/GwwIB5HLlshEDm6kQDFn2hIC3M0qIZnNAsmF80fzdH3OpqyEf?=
 =?us-ascii?Q?IdMOMKx3jYk8a1L6D+DBDM47Dgsx5AMXAt2NGh+GWdXW/uyITAZcuNpAxlIV?=
 =?us-ascii?Q?q2lLWB6TJHzSLYKF9rtkFU8XPNZitsFza7IAtL0tZnOMKa27rAIvVwbJIsHF?=
 =?us-ascii?Q?dq2povKZX0veaTjXDHotliLYvffKwzppinln/shRGB5i7bFK2YO5aDHUvLzf?=
 =?us-ascii?Q?Z668jsQuroSkqv7Et8z2n4B3PUGqhEVnksu9bIE2uwhKbQSFrADAw1JDKQzp?=
 =?us-ascii?Q?6zCIPapzY7W59QEZVozE4lBe7uhqQ7hAbJGXdEqY8Jnm+qQrO2vfxgi6MC6E?=
 =?us-ascii?Q?Hs7Te3xPly4+ZlwKp37jUG7lO7utOU0s9nkAKoLD1oLn0jcAW3pRpIGBkeqY?=
 =?us-ascii?Q?cJvnVPgx3v/eNKMZQKHLcquwfkLf9GTx1PDMO7QpIzhpoIcjEu25UV5DXZwW?=
 =?us-ascii?Q?ftUXlh1avWdzmKLOyT4eRdNy6VY0Ybp1sTUFVmhZh2VpGCj5Tcg5lQm6jpAw?=
 =?us-ascii?Q?kIPKTtpbg/MCmcM/v9kj9cQYF9vV1FFwhyPGDXu1EZjZHTyc6IRVlzNi+XKe?=
 =?us-ascii?Q?A1X4kt7nZoCqpdeFNssTm600ZcN0//1H9eVksXZAbiM4vYCpwRhY73D8fMxt?=
 =?us-ascii?Q?NFXKKOnLeMEvubTwgXANcZreoFg8sAaH69WWhQt7bzqkmWlqkWk7Se9/mJW7?=
 =?us-ascii?Q?kwFw7+hhe5kZ18tECjyVnobtdB0tLDIlZ14yjtEDtlOqiugwxNvaS1O7kbzu?=
 =?us-ascii?Q?AJWU1MRBIzAqn08/COqw0aAeIeV5PAieSuC4QfxGvXsgM9XXPkiCzIHWFy31?=
 =?us-ascii?Q?hjjE/ZNXMLb0XwfYmgf8mr93CcwrHUC1Rxa0i1F+rRhimCFBhcKwgXXLmEab?=
 =?us-ascii?Q?PSyTdHflVm6Qjek1ySDOfI/pEUr1ft36KAmR6+luO0Wj/j/BMYBd8ic0bvlr?=
 =?us-ascii?Q?fzHBzLt16LyBAYlWZ4JTyDJTmioaiZLR4/kNpX3SY46jKU0v5uEHekXAdsG/?=
 =?us-ascii?Q?HgkIUyTGKCPzVRMEFuORC4d1dsr7F8B6kCIAQ4VMkWDeOFTZcwe4dl9FT7WA?=
 =?us-ascii?Q?xOCB4T7IQ0rJ9h8e6YGRx4ThdysmspetaYexOMybV8z0UN5+FEvV39e9z0UE?=
 =?us-ascii?Q?suxqQSVQTChs+ryuh3xyLGaSMSOGPM//Llpau8G1ur7IJkMLbDdf996q/fuN?=
 =?us-ascii?Q?UP6aMp21JtrQbIDcsTZNcBfH0yGpsS+/FCekAn/zWwKKHTRqy2JINiXGZYEv?=
 =?us-ascii?Q?l/EFsYUv2k3vZLpX5OSyitX5uaqgVbpnZRLB5o9SXeDzuIo+vRtZRK5MffZd?=
 =?us-ascii?Q?jBcGVq0nxy2aok5XMKGDSNU1T0/+9/r+Gr1aqPuwNfsIDM6zVkcE9m09J3lx?=
 =?us-ascii?Q?FIaZZmOgZcksPkOggpNymZeZ50NoS3ZtF4ro5ujeC7WoMiZ/Dg2EJkQEZBJw?=
 =?us-ascii?Q?23DhukbbY92mS/FV160GOMZhpUYebESk/M28GZRqoN6BndScXmnHh6RbL+AU?=
 =?us-ascii?Q?XlCYEGjsMiJ0tbRzdNVlxfy4P+EQ6K0GJWqsVfs4EuhR1UrWBY4bMq4idvAX?=
 =?us-ascii?Q?hAmp2aZ4DlrVvMRXS3UEaYuwk2DaFMUQdmPquDavmZGvWbwJnfECXrgnM5SP?=
 =?us-ascii?Q?wnWfdWtouw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b2f102-f241-4f4c-ece6-08da2e711094
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 08:27:17.2130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUOfJs/LozO7qbJovusPwqm06WTG7V30aw1LPoonMxseOkFd7MmKO1cckJOU0K1rHAj2JFPOs8IWY5ZDlYFjZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4345
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 02:39:18PM +0100, Mel Gorman wrote:
> On Fri, Apr 29, 2022 at 07:29:19PM +0800, Aaron Lu wrote:

... ...

> > The said change looks like this:
> > (relevant comment will have to be adjusted)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 505d59f7d4fa..130a02af8321 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3332,18 +3332,19 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
> >  		       bool free_high)
> >  {
> >  	int high = READ_ONCE(pcp->high);
> > +	int batch = READ_ONCE(pcp->batch);
> >  
> > -	if (unlikely(!high || free_high))
> > +	if (unlikely(!high))
> >  		return 0;
> >  
> > -	if (!test_bit(ZONE_RECLAIM_ACTIVE, &zone->flags))
> > -		return high;
> > -
> >  	/*
> >  	 * If reclaim is active, limit the number of pages that can be
> >  	 * stored on pcp lists
> >  	 */
> > -	return min(READ_ONCE(pcp->batch) << 2, high);
> > +	if (test_bit(ZONE_RECLAIM_ACTIVE, &zone->flags) || free_high)
> > +		return min(batch << 2, high);
> > +
> > +	return high;
> >  }
> >  
> >  static void free_unref_page_commit(struct page *page, int migratetype,
> > 
> > Does this look sane? If so, I can prepare a formal patch with proper
> > comment and changelog, thanks.
> 
> I think it looks reasonable sane. The corner case is that if
> ((high - (batch >> 2)) > cachesize) that the pages will not get recycled

When free_high is true, the above diff changed the return value of
nr_pcp_high() from 0 to min(batch << 2, pcp->high) so the corner case is
when (min(batch << 2, pcp->high) > cachesize)?

> quickly enough. On the plus side always freeing to buddy may contend on the
> zone lock again and freeing in batches reduces that risk.
> 
> Given that zone lock contention is reduced regardless of cache size, it
> seems like a reasonable tradeoff.

Glad to hear this.
