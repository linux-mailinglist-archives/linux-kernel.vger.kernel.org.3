Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A805572AC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 07:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiFWFst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 01:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiFWFsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 01:48:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5BE3BA7E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 22:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655963326; x=1687499326;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ikvXNC/SPWj2/NkXkDPmxNQ5DWORD/FMrlkurH/YAxI=;
  b=km4zUHJoiLSidGHvJCsGA6y50e6EGz5XQMqXsktOtK+WvB6MzpR11wAK
   +uXkBpbZKUhRCI58eV5V/AFoeoibJ0N51KIsTkBsItBl8OVQmOQpqIQ5c
   MWM5Pt4+A281HBqD9MsGKKcBE1wxNWBe9yMvVE89vgxP20Gdd0HxXRQgx
   cWbPFgXLS5F8tcYTIsH1D03HJyp4FLOufOrcILDEeo6Q2t39QC+UgHjQK
   mGgtK1hMjKf/o3oM94F64dB2NhI/mEcAddeSgaEv5Fw/qsmrVLQnhc9Oa
   nkKq8UQeT1IfnXbF81Rk/5a1TxP3lQUKcvHv7MdNN5JvRMYsr3fYXkgT5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281709283"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="281709283"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 22:48:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="690861623"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jun 2022 22:48:46 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Jun 2022 22:48:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 22 Jun 2022 22:48:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 22 Jun 2022 22:48:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkaa/Im44yQhw3wh6hiWOXsN6Nk+6MBf4kkEsMW/qH2jRfn1412EokEG+RlzGR1U21VslT9jWNagzJbDj/bdnJUBW+1fRdAYnHCuqna9Xx8TNY/DNEdPQ76Te1sxwwnI6ZKDM1s3KNuGyMNv9AZxcZSSJQ63em2/BIhU9RJ8I1N6liWJCnlUiVlbjwfLAx+2sYAxSlzGCnflwrnJoEA5FilLV55Q+QmAb83Ed28WDrvZLLkDADdklkY9FK7W1oxTlXaWdFKRCioCIzJvq2fkvJOuhSewYIZHzpaSIN+aG5/G7X6t4qyeFUWojrYes/ukxi8TEckG80LpqW41/u30lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9/qtW0NjvX7SYNOgQA1n6bEILJ80jISO3n7pGzGF8E=;
 b=oVEn/w60eLV0EIsZef2FOCxbjtBG5PaNOUXo6heNyp8rE8H5Mtz5x8VHGWV0Yq0UIN7HdA2RdbgOHKqqltBcV0Vi/jIAbQth3M66DPN4ab1KnHz8lzpF6X46ffuve9TvD9+olRg5xHRfQ3IkGGy+wxAxKOZWLdJzqG6H5GbJ00K8sO9KyF8neseI5dvrFwFbZxKpEKQmBMAkL63vHkXAHUV/tpqVfOGtOjUknu4jvHr6fctBqaTf8F6xDHWvTCiuUWnnUZ5YxOzrUwDadt//yJIDHM++3byvcRSGbamDI7kygVWvG28Yh7xfYHvKEIsArkZ6xKQ35ysFIeK6dycXCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BL0PR11MB3297.namprd11.prod.outlook.com (2603:10b6:208:69::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.16; Thu, 23 Jun 2022 05:48:42 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262%5]) with mapi id 15.20.5353.018; Thu, 23 Jun 2022
 05:48:42 +0000
Date:   Wed, 22 Jun 2022 22:48:39 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     Rebecca Mckeever <remckee0@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 0/4] memblock tests: add VERBOSE and MEMBLOCK_DEBUG
 Makefile options
Message-ID: <YrP+t6EGnfIxU9NX@iweiny-desk3>
References: <cover.1655889641.git.remckee0@gmail.com>
 <YrPeXOgEQq7G4Ctq@iweiny-desk3>
 <YrPp+xMGZ/n1TpTk@bertie>
 <YrPuSxlRrIn9kowB@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YrPuSxlRrIn9kowB@kernel.org>
X-ClientProxiedBy: MW2PR16CA0004.namprd16.prod.outlook.com (2603:10b6:907::17)
 To DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7250900-515e-4d0e-965b-08da54dc07b7
X-MS-TrafficTypeDiagnostic: BL0PR11MB3297:EE_
X-Microsoft-Antispam-PRVS: <BL0PR11MB32979402374CA115EBE80DF8F7B59@BL0PR11MB3297.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yrp/sAtFlKjIFMz1EhWxaNHDIBNMFKkgvkM9A56NOtS7vfvVv6hylmwfx3YpVQSU5QGRk107JivQR9ujpk+KujJBsC7Zk1w90MekgyGEeEOgYjM5w/4bAebbs9HGRSQ2FzWdKdAaS4A1XKBNhkduHwhSdBzF16DgzKa50d4p6ML+uGFvL+BnA4jgR8r03F93GdBQ++Lsztx5dyRwfg87FEFiOAF4Ff6z4WHGEiduj2RPr5Kj1TTUl/YEnOfsOK7DnDbO6BSnoRwouOQ7ukWgoOJ72mzPV7pFqt1TkVLPsusP8ctPsm2e9FjWRWX5+Ej9Lzj0asM2JMt/iqdMXbL3YTVkM1xhDrxr0+LjDgNTBMaOVOnWx7fZ9vhRIGk1DJd0ysGptRbvtc4kmgk35gLhL5BWhOXq6/fJNcJOibLBDtxhwB0VyZ96BHz+5HtjeHhXa1Re8Bijy7TpoZv5hxD2W4IlCFoc3qro03iiybsWCuiaAFxETS4gnOngJL94na2F9vOJfLefeihRM/dbdWmkc0/7rFXAT7M7dJ6+7QoZhRP4x9aftMDvM2V4VeyOhdDzihR6n6RpKxoI9mAcY7pzLBmsWr6RXwOmwdF1cFinjb48S+rtp8vSmtxTm89lY4TVP6INE2/V4YFfKSouOphUDcIqnfHkAUXGMk98zFG4oSqqSHsgHlBfAfU73rN1mT/p4SolqqS5GAFIrkJG611vWN2lla5h/+uWfHO2h09N/o0WmsbL+7G/C7QM958GlfzqIfQobxxNQm+XG4tyKNYHWf3XCbz94kuJIjFovCIFGDqAD/Av2sDlueiJvnia4OJb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(376002)(366004)(136003)(396003)(39860400002)(478600001)(26005)(6512007)(966005)(41300700001)(6486002)(316002)(9686003)(186003)(38100700002)(6666004)(6506007)(8936002)(83380400001)(8676002)(86362001)(66476007)(66946007)(4326008)(33716001)(2906002)(66556008)(6916009)(54906003)(82960400001)(44832011)(5660300002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZDCLTcjWu3PR3RPWS/vocxZWnDkvMKb/HCAbe0iMytaer+FeUz3rs71D5czj?=
 =?us-ascii?Q?dfY2tzMw1XmiDcssXXveOlerx+KbknJNrUaMwkDdS8X6oNDlwZCFzI+bV86A?=
 =?us-ascii?Q?NHowWdUqceqndkeyudmjJdS6SbJLKmoyrVINfiINDM52r+Al5P1vDra28eK6?=
 =?us-ascii?Q?eYf2jS+2P1hA28kWNpx+q9KVAG1w8QWO3UsDKMivzr/9LrD7BqJoG0dfzFZ5?=
 =?us-ascii?Q?Jy9/kvrL4GGydJyfQvXPHu3VE7KwKP4c+fiVECydtTrh5sMdZodoAafxZNWL?=
 =?us-ascii?Q?vbanUyLOK5GuxEjV8xbMBWpSnnzjwPCAo8260tRpTeRfmPCdTVadmXdGe4hO?=
 =?us-ascii?Q?FkPMPs5KzsEnVaTCje5gaQSLBzhmftVfALKiiyH8lQAalGqmAUj4Gy0EsUhZ?=
 =?us-ascii?Q?+Y8oTNS0/HahQpP4q0rURWDQv+2g4ZymimfJttHFxZyYXG1qpTWCzi9mne/L?=
 =?us-ascii?Q?/qbeU43P0MvkBbAty7Eg6LHC90PQwVIv0q/nhOV2scsC5sRobFyPvLLDnMZ+?=
 =?us-ascii?Q?QZeGOh4YhbzI+lstXKwFdHrBGyIQ9uAx6IyjpIHPWwsUuKTxDSdTSVH71xdP?=
 =?us-ascii?Q?QbfeOeGZNSoJYd1HBont8E0n2u4WQq/sVUyKLHyah6taQnYoRPftehTbFWDW?=
 =?us-ascii?Q?WO9iEAuuXBfrX1r8JnfYQ6DzY5dYRsEJL2rakI0OBUtIY5gLTFgRmJyRjKk6?=
 =?us-ascii?Q?TBvqUKNLHdMHswo0Lc8m0Mv6BiLh+LYiet3BqXMyOfr6X5NNxiec2sfN/o/R?=
 =?us-ascii?Q?SF7S/mov8hy/ooPD10DcFrCbc4MLAtrr9NxeK1Pio9R86zIAha+yUmbq/mjj?=
 =?us-ascii?Q?IAfTt4dFnIYF+NUIZBWNaJRQEBuNpDF1nd3ecKVTjpaS5vDcGjeDu2T36B+7?=
 =?us-ascii?Q?+//rSr+zSNy6mO0FPM+zCrixsmRrB/uiGS/FxykI8OkF2R5QBal0APRF2Wjk?=
 =?us-ascii?Q?LFZSy3XH4aegi1nt1WejZDUdQrQXuW1rmRKfBwia4BbND7LiqUOExGu8DRdy?=
 =?us-ascii?Q?EF5CEaDflYiC34H+vxuImva2K9RzbDckSdDujYQYHQI5R7ncJyXcKcKh4k1C?=
 =?us-ascii?Q?+hcGwYVN4q48znLflitBFOxXPGUhV+L2Xzun0o3JL7MZL8RR8yxJrBgbosmR?=
 =?us-ascii?Q?kx1Bks6gevYpujr5jCsapn31vWVu2n7bjbMHqQKjpsdXcUPvDbMrxaHEdUOM?=
 =?us-ascii?Q?d4Mm56BbnXtqEyUQp6sbjhjrRHY2qNMIdgpnHa8U0NwoOhZ/WkYCtHgQQSyq?=
 =?us-ascii?Q?tErRJsUYsNCFS6u81D8Ck03XM4y+m+fCzeB0KtO5kYTDJHRdYpymL8xvoDK2?=
 =?us-ascii?Q?MYVw7/jk2mVcdVAORia9XwR3zWHEG8HlwqAmWpmcUcKVVQMhghMljRNVr5zc?=
 =?us-ascii?Q?jeZB88u92djqwHGa7LasrZ/KOanKEhmKXIoCnHNxyQTUs+zzmYKRwdPWTODp?=
 =?us-ascii?Q?gCeT+QPu2/F9v7tMCDGT2djmDVOYbOOEWcXQQeof41xOqZrWfcDktokRvfR9?=
 =?us-ascii?Q?EfM9X6tOE6Dj8w9kjklxBX1EWMw+GO0rrNXd3YV+r44UrKV+vszCLImaiXWc?=
 =?us-ascii?Q?7UmTPTSVO24YAb9LVSAlTa7V1Onx0djrHF43kXfaUibqyiEootIDCimOuLe9?=
 =?us-ascii?Q?ftAgkmtJaIdHNnSJZhkURXpbABqMXrl/N7RcNp23ChfWtwHg3NRK3lh2TzB0?=
 =?us-ascii?Q?KhNUfgms3oVHny7LlQMn6ZKGsvy0Vu4Y75ncJtbu/HFEvYX4hIXTPvPgW1Ae?=
 =?us-ascii?Q?KdG3M6FyRAhy1IOUlmK3Gvjq+jaIK84=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7250900-515e-4d0e-965b-08da54dc07b7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 05:48:42.6450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZOEofFYNPhztLEnPytzgpJugBbT3Wh5AhA1pAc82Sx6tp7ZhwmqCq74RHti5GhhbPWXF543CsB1zFpoAH1R8DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3297
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

On Wed, Jun 22, 2022 at 11:38:35PM -0500, Mike Rapoport wrote:
> On Wed, Jun 22, 2022 at 11:20:11PM -0500, Rebecca Mckeever wrote:
> > On Wed, Jun 22, 2022 at 08:30:36PM -0700, Ira Weiny wrote:
> > > On Wed, Jun 22, 2022 at 04:29:05AM -0500, Rebecca Mckeever wrote:
> > > > These patches add options VERBOSE and MEMBLOCK_DEBUG to Memblock
> > > > simulator, which can be specified when running make. These patches also
> > > > implement the functionality for these options.
> > > 
> > > I seem to be missing patch 3/4 and I don't see it on lore?
> > > 
> > > https://lore.kernel.org/linux-mm/004e021cc3cb7be8749361b3b1cb324459b9cb9f.1655889641.git.remckee0@gmail.com/
> > > 
> > > Did it get sent?  Did it define the ASSERT_*() macros?
> 
> I see it on lore in both linux-mm and linux-kernel, and here as well:
>  
> https://lore.kernel.org/all/39c5c97d2b5c1ab88b7bbbf02633f840fd5dfcdf.1655889641.git.remckee0@gmail.com/

Odd.  Thanks!

Ira

> 
> > That's strange, my email shows that it was sent to linux-mm@kvack.org and
> > linux-kernel@vger.kernel.org but I'm not seeing it on lore either.
> > Should I resend just patch 3/4?
> 
> No need to resend.
> 
> > For now, you can take a look at v1.  Patch 3 is unchanged from v1, which
> > is showing up on lore:
> > 
> > https://lore.kernel.org/linux-mm/fe34452209f54287023ccacd666eade81ecd9a24.1655878337.git.remckee0@gmail.com/T/#u
> > 
> > It does not define the ASSERT_*() macros, that happens in patch 2.
> > Patch 3 implements MEMBLOCK_DEBUG.
> > 
> > Thanks,
> > Rebecca
> > 
> 
> -- 
> Sincerely yours,
> Mike.
