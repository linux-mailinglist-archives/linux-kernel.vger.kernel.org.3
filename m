Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E00B5A5735
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiH2WmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiH2WmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:42:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F397E026
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661812921; x=1693348921;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xMYUrkXi6TQy9yxXydRT4tzTVX5LS52be61euCkFeYw=;
  b=kBN3btdy9W6UVIB8i9cSn/6HD9CsYbpJRjVNu5EmCdyvJ+C2ck1fxEqu
   8vYr1AuglV9EYic6Kr+xA3a/I7nDybYpmdwiv8ksjvq5ONW1OZBHrhScr
   D1Tas7nAnaqw3BsHrtVQZkvSs85iJWL1vr/vhFwZl25AIr8znGFkk+Jmd
   lyinc3G9rmJ9Gayo/3HSzBZOXmASAz+4hDg2S+0G3YN1wuH0rAhqT1F9k
   HNPdHq3ORfNvZbJfurXRSZrYakiwANXIrH50Gr8di8uu2OZpbdxjfIqHG
   itI0CtXW0mIhSO+HsLee6jRjlKIOBHJ7l4HGtBWENxQiGpKtwgXtJZ+zg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="295796760"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="295796760"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 15:42:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="611468621"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 29 Aug 2022 15:42:01 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 29 Aug 2022 15:42:00 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 29 Aug 2022 15:42:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 29 Aug 2022 15:42:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 29 Aug 2022 15:42:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcXaeETmHipDlKdfctRgeaaRSQ/1ofJ7mgvv3+Q2W9YNmUOQAwExhBuwJ7XzFOjiuyIZ8Z3RPu1d5ZoH1Vtsxz0C7wwR5oQUI7BzlCP5L+UAmYwV6NbCpJBEt5Gtt2euDBGMHsbhPn/lRpS4jpEr+zHhj3++03QD69C93c5eFdMm/QgKEoPrDSzeAqU51iqAhzWa6pq0+CxJVzgqWn8qKug7YV+8Mf3BKieSDNfZoRqEuFi0+leoZ+jQtwj5WZNPI/6V7qEGszJjPpJFCe9NyEe87xDXFEyJnAjNhkV1FHQE7RQuHfn4pceQqycoKEIUOvMx7piHIWdcMhLZqYVngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggdcxlviJre7bOq6cv9FhrtffPkEti1jmbuV6Ff60iQ=;
 b=DoLYDWHdefDB954K+FhEamhVMqwM7mPdZwWtH+c9w4Yp3x6hxPA5IjygBSVfsPY1xpe2w8dLAIMdjYHvEJ5+PhqWLzYaaU703I5opiL8QYkcar5viXE/dBurDpFtmTby+TkAq0DpjydOre0XWPaw84edJjURm6gj4O0RaZu9AplIEnGJoWNt+08NZcTSpyTqm7+E3e70nmEmFiBOO8XR1oJGEWGpcaW1aelggQjlgXLPyJ4/XxRpOxNU1MtdFzp+8znmhzRBfoyUnq1DUPX3g4MBLom06+p1/Z1bndGInFtTgPKHDa2jw7FN5WUq2PQQDm0HtqZD2wp7Pqnafr94yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by BL0PR11MB2915.namprd11.prod.outlook.com (2603:10b6:208:31::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 22:41:56 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::f80a:da3d:ca42:b0a]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::f80a:da3d:ca42:b0a%3]) with mapi id 15.20.5566.016; Mon, 29 Aug 2022
 22:41:56 +0000
Date:   Mon, 29 Aug 2022 22:41:56 +0000
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] x86/microcode/intel: Allow late loading only if a min
 rev is specified
Message-ID: <Yw1AtFrRPWhkJ4r8@araj-dh-work>
References: <20220829180436.716672-1-ashok.raj@intel.com>
 <Yw0iDnZ+dB4ULSs/@nazgul.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yw0iDnZ+dB4ULSs/@nazgul.tnic>
X-ClientProxiedBy: BYAPR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:a03:54::24) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb6a8721-cb4d-4784-196c-08da8a0fad81
X-MS-TrafficTypeDiagnostic: BL0PR11MB2915:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bL7WQ7Gb1bJI6oOYIYRxsmPAdxoi8SUqpQNjYIxr/BWpVkROscqzMl6/I/EK84610Rv5H3A6WmyvPKIxxPHsCnJAfx978j5v/o/4BXXEwAUcsGk+q21pCORAxdjyHzMCGW1RSqHrlf084pIe5icpk9bv30KwTho6mYMNhmgJ9xeU+uzNkb1MKFgEVp1d2YlogtFk557FBAZNEHqjQBpKH8ucHNqmY2i9qacmUloSHc7PEDYn0sgeeUCQ2IrDVVDe36RPABBdZbTXjB7mOjHAv+nEWDWFzwZElWrsi+9mpi3kA0Zr2pTiNunx4zH5u/HEg/t1e2PMdflnUuyUChx5izOnONbjAkJTDgcbe9LGzwUjpz4pX2FhyiJ2SZEaME99nL/Iq2bfwuzpSGty2U7bD6Gu4zRb4rXuXE0XL9EYp4DSGAtSa4nEpsdPAiDuoEsRX/I8m5cuTpAkDRKrnLILIyvo639pFMP5EfvX5P7TyaP0AViLm6aDGdzlAOgqZda4uC/v7IM7ziBwF8CknHTBcV81j11rQqFQgQPeqm8Gjg0gPTk1qJPeEdBZqh8ZI1HL/8hh1WewCK4wkHBhYvvppAn/f3JzAubabVIwfTxL/2+pQz0+AyzlXCaXy1COfOsuhCIPqcvqxGvP9mdUwbCRomT7S1YtBNkeEwktYSGUg+VArD7q0MqFDXijOoEsyeuOKbHl5jH8eub0TuMFR9mE/g9zkGzy4PL49QPmqgF0wDYp10TJS0793u93//jcw8wW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(366004)(396003)(376002)(136003)(39860400002)(86362001)(82960400001)(6486002)(33716001)(5660300002)(4326008)(66476007)(66556008)(8676002)(38100700002)(478600001)(41300700001)(966005)(8936002)(66946007)(54906003)(6916009)(316002)(186003)(26005)(83380400001)(107886003)(6512007)(2906002)(44832011)(9686003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XO27kdyQOTnt1d2GiWDWT98ueS8c3dpX0AAxxrbaAQiEi8cDXAcq744LVLGY?=
 =?us-ascii?Q?BC5jWaHZHqSY/AOz5L0wLocgKdi/pECZ8UejkKExboKwpb4L5XUCHxQFEcw5?=
 =?us-ascii?Q?8YYGLR9gnnR2RxA8klzqeAj9hE2bKyCScbuW40o8fjs9ifhq43faKkW9EGQE?=
 =?us-ascii?Q?LlxSaf0apjBgdsV+xIaSTpL01YapTf6s70UZi9L/UCfPyAE1hD54M4C+Qv3o?=
 =?us-ascii?Q?PHrEkjplt3l463fRxBZiLXS8Mhe424UzW+OeQ2HA5qozmbO7ijLrHau5fa7e?=
 =?us-ascii?Q?IG7K9bqLAD3N/p1CekTI+NoPa/uwSvOlu6IZ8OT5U2QhxSzrEkHNTY+uuGSc?=
 =?us-ascii?Q?Lx2OLx7NhiSw3Af3oEGIw2flPQfDOD8W7UVmhfCumtu5PynaFj76o64AZFEw?=
 =?us-ascii?Q?pufN61XOEHM/0sOr7rybp6unjtjymPA94AK+YNLeCHjrGcKlEdUiEQbYA0GM?=
 =?us-ascii?Q?BVBMKkZkDXpmzYTlNDaRj3TnEQIvVlZyFMhX3eXmb2BQfjd+v6XPgvqikPZX?=
 =?us-ascii?Q?hnxXBMIISOoElN/SUc1jplrAm8HoLVK37M6JErazM/sgojVGGVMQtfriYT/I?=
 =?us-ascii?Q?59Lhq/NWqI31FL5IvdETy7kwdDK5rMrKBcWNm2YnASpGt3ClKqA/+4eqVCYi?=
 =?us-ascii?Q?DAJw3tIcv4eaFuIcAGrhbV1xLa0doBhVZgiNDjZmci2qNDvs2fnS4CzTAPRh?=
 =?us-ascii?Q?rnHEzWDvWmRXqqrx7iDdA1KFJIZAy0fyMkLCfPT96lrq/WCzKy+P0KMFfkbP?=
 =?us-ascii?Q?laN9Ma7rh6vyhl3/OqHOEW/LnLgo+ELb9wi2z7ViXP8EVIvJd+6F2tOchU+d?=
 =?us-ascii?Q?CJwsyXe3Su4avvI41pFOJD+gKTewJsGpeL7qOCRHK/IdPoIcq4AwXZmKNFLn?=
 =?us-ascii?Q?QB+v2xf+cLQyS6+rxRp+zoonXDhn7bMDtSoZX/9ZReQeCscQM5Bl5w38j4fj?=
 =?us-ascii?Q?zsobWe4e6gLRfnMgx+emiz0beauSwPQJ7RJqqMEBefRHLsAfr2Xp+UO0FtRO?=
 =?us-ascii?Q?pbFiVJW+Xjsna7ctNzantiioUiAStt2QDdlBHDO8Mov8KwVO/Z1/YZ7Fjjw6?=
 =?us-ascii?Q?BN3XYNNJANA4QYwVN52wJ9jYSBALKYkpy1mrVIOBPEUnZ7fJMuoBZrc8/Lex?=
 =?us-ascii?Q?Q0pj9RoZd5+7s2LlXRmHFVQ2rycGMKzv+SfNbgDopJtEJITGeRNZlgsvccCQ?=
 =?us-ascii?Q?kJ1JaZIen7JIWTs98b+NhcUdWyZsVYVVjIxtbnwsbrIxbnYzYX1IXMa/Fe8O?=
 =?us-ascii?Q?ZwhWOFIdkR07XlEqxanZNRv5AgEGexojY07wWByYnAR//maNci6RWkiqK2oc?=
 =?us-ascii?Q?0ZSyWgITCVNBDfUjiQunuKoo9vWggoerw2ACTdu4JOw4LtLHe5/kqTuozWEy?=
 =?us-ascii?Q?bfg/b8tOusPV7wNJcE6tgm3XZ+4/MFfHNYpwqzjvP1CL615wJ6Iji2ZGeKEC?=
 =?us-ascii?Q?9cWI65kcINBk2rYd4oHPgxGXRKUHU21AczuwwYrXAGqKMY7dJbKLP5ymygLn?=
 =?us-ascii?Q?sVQ73IXSWLg3xoy8WiRqJyE5Fhzrfge2mIJ238XZcZEmzKhct+5rHkAluJGS?=
 =?us-ascii?Q?NNsgKI05GsRdX0IR9060uYfo//k9/4Ji3KbROy5MzlHAtDcLnWIznNY9l5fe?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6a8721-cb4d-4784-196c-08da8a0fad81
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 22:41:56.7970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqMsgQ4/7plWuJzUQlByIcoofKu+IfQAT3ZDbKAtLVzEJ/9qwOUZtdDf8PUAbS4fEsRRqp5mGAbRDpDHqaSVug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2915
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

On Mon, Aug 29, 2022 at 10:31:22PM +0200, Borislav Petkov wrote:
> On Mon, Aug 29, 2022 at 06:04:36PM +0000, Ashok Raj wrote:
> > @@ -886,7 +905,7 @@ static bool is_blacklisted(unsigned int cpu)
> >  }
> >  
> >  static enum ucode_state request_microcode_fw(int cpu, struct device *device,
> > -					     bool refresh_fw)
> > +					     bool late_loading)
> >  {
> 
> Until the refresh_fw's function hasn't been clarified:
> 
> https://lore.kernel.org/all/YwaBim3Xt3Il3KXm@zn.tnic/
> 

I don't know exactly what you mean. 

But I suppose, you mean what refresh_hw is supposed to mean from the existing code?

refresh_hw seems to imply when to update  the copy of the microcode from
the filesystem. Also seems to imply late loading.

its used in the following places.

1. During reload_store() where this is exclicitly due to echo 1 > reload

	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev, true);

	Here passing true makes sense since you are going to do a full
	refresh on all CPUs via late loading.


2. microcode_update_cpu() -> microcode_init_cpu()->request_microcode_fw(false)

   Early loading from resume. So we would use the microcode cache to load
   from.

3. mc_device_add() -> microcode_init_cpu(true)->request_microcode_fw(true)

   This seems like normal CPU hot-add, I'm not sure if refresh_fw=true is
   valid. A new CPU should also use from the cache, but not a full reload
   from filesystem. This could end up with new cpu with an updated ucode
   and older with something that was loaded earlier. Sort of what was fixed
   in:

   commit 7189b3c11903667808029ec9766a6e96de5012a5 (tag: x86_microcode_for_v5.13)


   intel.c doesn't seem to use this parameter at all today. But judging from

   amd.c: request_microcode_amd() 

        /* reload ucode container only on the boot cpu */
        if (!refresh_fw || !bsp)
                return UCODE_OK;

  Seems like it does the right job, since you would refresh only if
  refresh_fw=true and its the bsp. Hence it seems immute to the
  mc_device_add() bug.

  1. Fix mc_device_add() to set refresh_fw() to false.
  2. We can change the parameter to late_loading as you had alluded in
     previous post.
  3. Use that to distinguish if we need to enforce the
     microcode_sanity_check() to validate min_rev. 

Let me know if this is what you meant.

Cheers,
Ashok
