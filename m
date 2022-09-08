Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C9E5B2A19
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 01:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIHXWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 19:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiIHXWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:22:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA491EA60F;
        Thu,  8 Sep 2022 16:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662679352; x=1694215352;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=n2gov6i5G8opTeVhBPqbJyg5BRTGd36vOM/ghGHAkh0=;
  b=Tjgjiex4CLQ1uqQ4ODQ77UH5HM1G0mTaXD8B+CAGL8M0kXO0M3pRmd1C
   fXNAyLQVDp1Rdm4ka94ETGrd3ALw9yqjoPFkOsAbFgyFTPTXSL4ZWjW2S
   lCFXJSs5Oaq8//gmilWTgqvjKu54QHJ8TnbXam+ENkSVcr+io6nvwhP+y
   kwHhyvRXv2lgQpf6WTW9d/GWy4JYOEC67Mv7JZvkxti5yfXDiOvRvdfxj
   RYf15cTNRLaMCePd+Tid2sDu5JXqy9gxJg/u4PkmZb4hKX18mCO7epYBM
   gZL2p4FsSNWFlq5UUA7pLmokFLECWWLSO8/pAYpgSZ49r3LI2JLHX5PEF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="284367403"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="284367403"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 16:22:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="645299843"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 08 Sep 2022 16:22:32 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 16:22:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 16:22:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 16:22:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+CfDM4r51o/IWjKBYQDK73gqIVkUF8ISx9wvHYXE3ExeGhcOeDojAJqjxEwoxQ9oJyW9GiRgSUSnkFpx9fmBuo98wH7Dr893WRA1U/TtF/CXG6QEqjeoM3P3nmax3rdI1uG/MqqSI70LfJpsXhkwG3DIMVDPWOJAYXz6/xHmytzm1FNIhJmdlEfrEMXRcyAxU91fHdJPLLSk2Ef7Ooksjg4huKtlwtmObPdjoXo65PanLyssMMJLqhKBPXRjCYb1/62sSh31fCHhWQUJeyTYwEGDAoXlJx3wg1ioKNBGYcQrF6jvOxGFEl1bYHEzQq9pwQPxqzdEXouF3eWCIRDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpINktswjx/hf60YFoBqLIQP6Q4cnqwtRBCw5HjWhLk=;
 b=CpMkVyX/uA4T6+a5MWGBcqEKCtfU64LF+n9HAuuW0A5q1GT74ocRgdFMtpwccWhGhDJjh2ldQMxXXsQ+Ujji5gEkUUjQJiGdIi/BXtjUi+2Pz87H0jFM7Cs1lXYu6ly+YwcOS/uVmHlly+/2iuhHoOIPYCeuX3evAk155v0NMI0dNoGr/jgvrZXr2884QkST6HbQkR8SsrOg1gKsiOx1EWkOJ9WbMCuW5mxoOQ1oy7gmzTux1phpAOvt+FEdrNvfMAlcqa70kfNyIdmoMdZXfo/6JFOnmKkWN4Zrdqzpl5PCTzPnsYSGKtJV09pR40WuEKisuiZhDT8APap537sXMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DS7PR11MB6246.namprd11.prod.outlook.com
 (2603:10b6:8:99::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Thu, 8 Sep
 2022 23:22:29 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 23:22:29 +0000
Date:   Thu, 8 Sep 2022 16:22:26 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>, <x86@kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <bp@alien8.de>, <dave.jiang@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <a.manzanares@samsung.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] memregion: Add arch_flush_memregion() interface
Message-ID: <631a7932c6eb5_166f2945d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220829212918.4039240-1-dave@stgolabs.net>
 <20220907153016.f7cd4f42a337fedae8319f28@linux-foundation.org>
 <631940536d040_2736529437@dwillia2-xfh.jf.intel.com.notmuch>
 <20220908141319.00000f01@huawei.com>
 <631a7206afc2_166f29413@dwillia2-xfh.jf.intel.com.notmuch>
 <20220908160035.f030e3e533a996eadc04dbd5@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220908160035.f030e3e533a996eadc04dbd5@linux-foundation.org>
X-ClientProxiedBy: BY5PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::33) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 826e5fa7-82e2-4677-3a8a-08da91f0ff8a
X-MS-TrafficTypeDiagnostic: DS7PR11MB6246:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OYeQxtY73yXAe+nsJ84cKEPmQO/QyLsXHx9d6gHsT+7ERWAlnbYSWbUIINFwkXRVSgkbw7rwnHcAyYmWpJmTxes3R1otYa6fIs9740RwrCYeZxlgnhZebGbRrOI1b+h1YWkzF5J/YOKM1qV7r4wjsjWCtWu+TRpnqnTZ1v0UZJOiwmh4H5RSFA0rkFhpMCIztDbYTouT1iOIy8z6W64nzHXeY92Zq8FBscO4hgQT79THomfjdTkNRvt8Sb2PJ2iSyXOVV+tUukqiD1mCBJSNBMJizhB+p3f0H/s5ta7uEoOFujDP2/72gv7F9+i8QaAS84iaP49yCdGw9Ssbqqamafs/2XvZhrBDNVbr5sPWpfrUzk4h7YSkgp9Ebo6OclTM3hlciPdc1bCSin9IlHbCStRm2lgXvOM2OxIKzXlh/LbA+BFLASaisOcVKnKee51g743h0ZWG4a3wI0YKBQ0fE/mwGnT63OizAj6iS21pJZhTH1b37r5SiXREyPLNSVlBO2oRKxTiKN40NqbLV3luwVnkaTRW0/hNOEa+tZ+Vgfs4eepJXxeS5RM7I9FJvvgi+h3wQy9AzQUVSVnvImqFFdU7dO16nNCJppUC4mzFwp/UzTHEz0iYGNQHEXcneDwVMQyu01LfuLII4P51oHS09tiVgrgLGVh8kojG0njzwDz8SdEUFeDieRvBJIuk3oVvR65v3W8PZEz8XcxTRW0gvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(346002)(136003)(110136005)(6486002)(54906003)(82960400001)(478600001)(66946007)(8676002)(66476007)(4326008)(66556008)(38100700002)(7416002)(86362001)(6506007)(8936002)(41300700001)(6666004)(5660300002)(83380400001)(2906002)(316002)(186003)(26005)(9686003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GGO6ovaKxNMZuQQkti+DkX1JVvV3lRa7cfLYu9tDUzsrJg22EeYvVexm1ODV?=
 =?us-ascii?Q?7qlnpGdoaBIZEu6o+Ac1q2XEkecNX4gT1MJrq9HJJBzsnFpHuisTo/zcN+nm?=
 =?us-ascii?Q?7BZj4FRq3wvvDr7jOr3igZSHueBesxVkf2dgYodrr/XiJSwE6LNw5oXTME1a?=
 =?us-ascii?Q?8BiwTNfvPXHD/IvkVKxMDNgXa99ZniGjPYcarLW+g3ruTFmYSSpXybuC1MxS?=
 =?us-ascii?Q?4NLp5IwXf5q2YgkjFjj87V6a7qZj8rX15eyB5b6xvsRwkCWtTHwYlatDOxLP?=
 =?us-ascii?Q?LLI1wAp4dzG9CYCQ4MlTEC9T9/s0uPnx/L+iYWGt1ZYs6+/Q+q9ZeAmupJGQ?=
 =?us-ascii?Q?fcXIsrrpgyvq5CfnyMOtfVphUIRoAULB6bBazmQOFISt+B0Mjp2gVI3HcQO3?=
 =?us-ascii?Q?jpa2IJ4o9Jjvb1b2yDiBaYNWe9U7O93m/4bkVaDfWOLPD2/zAZItQp3gfmDI?=
 =?us-ascii?Q?o13VA81W8ZuqCefwOLbP4sbm4MMswbBWVgPXvseZlM6epGhV0Jkux5XHS8ok?=
 =?us-ascii?Q?Ub6PEWqmfCQklg/LdPmVxAlYB2F38f6Qii4VIfqfpAB+wR5WXXNPaBXN/8NM?=
 =?us-ascii?Q?J1qaolSnImKb+h+o4IrQh2PnAa0mdOW0Z8yijgYNR2MZYm4f49gIiJPNPodE?=
 =?us-ascii?Q?vlkXqL1XFkL+K9qbLSQCVkcHwvKj/+gV36ScgFedeFm54Nid0YuUzq3xpQX7?=
 =?us-ascii?Q?UPi2U0LXNJWdUAkD/3RXSrG6El6iNqIBDsh+H457xVg7BWnqIdnKMbV2OPh4?=
 =?us-ascii?Q?arKioGx7ejvxTOkbwWIxEKGZNVw587CRKLeopXFTHqE5CQhZOWu65BhTWC1C?=
 =?us-ascii?Q?dTosHP+rIgL2o4oQ8yMd0Kfss43Bh7SdRSGQ1F7Y5G/DYdPtjYPOgKWAeV3r?=
 =?us-ascii?Q?BL6bs1dr/nmZFqaJCUAJ5aY9XxxWM2ZRDx70pqtAu4atpoCjUDsaUQdppX0T?=
 =?us-ascii?Q?wJ1RPvQoQ68wY354CbWyiUmsWasaReiZkNiT59psID0AU5XauSL5NL6sIT65?=
 =?us-ascii?Q?B8FBtQkIOJqGU/UQTKNhUWj+AcQvezR6vcmSlJ5rflFbg/FvcBipAVXHOpED?=
 =?us-ascii?Q?YZpFFmQ1LudaDkzimNgYIbz0meWfRw2NyJQlFeB03LUTRE8zipzBvKY3+Ib9?=
 =?us-ascii?Q?tNooAWrbxK2KjljhMQsDkETjAT0O568Fm/+gOgYe35Lo095s1Nu4tXZ1dx6A?=
 =?us-ascii?Q?2cF0AgTdJ2Gy7chFttXa7xjgzWXU2VU1pGRoxnl3t3bNUrRZByxk4JLzlJxA?=
 =?us-ascii?Q?7ZdjiKu45S9NEcJSXWkVsFbQwWIpmX0GR/UnXEOv7ugt5/v6l8T+tDwiJBvN?=
 =?us-ascii?Q?CoGZLTnxwcFpbhFB+N0SDmn9fvnf5bTHmdCPu6l/IAqyvXrUBpg3ESPvy/jK?=
 =?us-ascii?Q?rEBrcbNESQdWOn2KaYODUwa2HJb0N1cLzmsLnVWzlju9NxInO/TKL64/SsDk?=
 =?us-ascii?Q?LFs5b7ChwvEdnFSyx6Rh8uZFUkVq/Qf2zPxmT/BeeOoEzEJjNbTUeG6iLBML?=
 =?us-ascii?Q?a2OcrF8ll6NDRYdvEinnOos+34Iyx1Oi4tIwtFQmcWFOPzH7f+JSE0iplcs0?=
 =?us-ascii?Q?QVF/EZHjA7MC7Sxo71GPbLrUmQkFoQFwZJq0jB45g4yWgsYNEmh+JQlx+HZl?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 826e5fa7-82e2-4677-3a8a-08da91f0ff8a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 23:22:29.3805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +s4aI2G0QA90/fGb44WrGNRd2r6gL0zxlXk4jbBeUyQ3zjKnE0h35SczFMQrh1Iv6nhj4S+CwlA/RdvjIWOGj51VwPUpuOaLeJFbJ3sqRMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6246
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 8 Sep 2022 15:51:50 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Jonathan Cameron wrote:
> > > On Wed, 7 Sep 2022 18:07:31 -0700
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > > 
> > > > Andrew Morton wrote:
> > > > > I really dislike the term "flush".  Sometimes it means writeback,
> > > > > sometimes it means invalidate.  Perhaps at other times it means
> > > > > both.
> > > > > 
> > > > > Can we please be very clear in comments and changelogs about exactly
> > > > > what this "flush" does.   With bonus points for being more specific in the 
> > > > > function naming?
> > > > >   
> > > > 
> > > > That's a good point, "flush" has been cargo-culted along in Linux's
> > > > cache management APIs to mean write-back-and-invalidate. In this case I
> > > > think this API is purely about invalidate. It just so happens that x86
> > > > has not historically had a global invalidate instruction readily
> > > > available which leads to the overuse of wbinvd.
> > > > 
> > > > It would be nice to make clear that this API is purely about
> > > > invalidating any data cached for a physical address impacted by address
> > > > space management event (secure erase / new region provision). Write-back
> > > > is an unnecessary side-effect.
> > > > 
> > > > So how about:
> > > > 
> > > > s/arch_flush_memregion/cpu_cache_invalidate_memregion/?
> > > 
> > > Want to indicate it 'might' write back perhaps?
> > > So could be invalidate or clean and invalidate (using arm ARM terms just to add
> > > to the confusion ;)
> > > 
> > > Feels like there will be potential race conditions where that matters as we might
> > > force stale data to be written back.
> > > 
> > > Perhaps a comment is enough for that. Anyone have the "famous last words" feeling?
> > 
> > Is "invalidate" not clear that write-back is optional? Maybe not.
> 
> Yes, I'd say that "invalidate" means "dirty stuff may of may not have
> been written back".  Ditto for invalidate_inode_pages2().
> 
> > Also, I realized that we tried to include the address range to allow for
> > the possibility of flushing by virtual address range, but that
> > overcomplicates the use. I.e. if someone issue secure erase and the
> > region association is not established does that mean that mean that the
> > cache invalidation is not needed? It could be the case that someone
> > disables a device, does the secure erase, and then reattaches to the
> > same region. The cache invalidation is needed, but at the time of the
> > secure erase the HPA was unknown.
> > 
> > All this to say that I feel the bikeshedding will need to continue until
> > morale improves.
> > 
> > I notice that the DMA API uses 'sync' to indicate, "make this memory
> > consistent/coherent for the CPU or the device", so how about an API like
> > 
> >     memregion_sync_for_cpu(int res_desc)
> > 
> > ...where the @res_desc would be IORES_DESC_CXL for all CXL and
> > IORES_DESC_PERSISTENT_MEMORY for the current nvdimm use case.
> 
> "sync" is another of my pet peeves ;) In filesystem land, at least. 
> Does it mean "start writeback and return" or does it mean "start
> writeback, wait for its completion then return".  

Ok, no "sync" :).

/**
 * cpu_cache_invalidate_memregion - drop any CPU cached data for
 *     memregions described by @res_des
 * @res_desc: one of the IORES_DESC_* types
 *
 * Perform cache maintenance after a memory event / operation that
 * changes the contents of physical memory in a cache-incoherent manner.
 * For example, memory-device secure erase, or provisioning new CXL
 * regions. This routine may or may not write back any dirty contents
 * while performing the invalidation.
 *
 * Returns 0 on success or negative error code on a failure to perform
 * the cache maintenance.
 */
int cpu_cache_invalidate_memregion(int res_desc)

??
