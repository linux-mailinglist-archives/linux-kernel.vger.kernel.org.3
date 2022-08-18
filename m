Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB592598132
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243955AbiHRJ7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 05:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242603AbiHRJ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 05:59:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4D8275E5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 02:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660816755; x=1692352755;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=m2PWxo9VLIH/Rw60L8lfBDM3ZxF5jR+6jY0z5wdGMHQ=;
  b=nCN4ubD8ojZ2NO/AnUrZIM7OL5IYsXgdUw0V13m0UHCewk6ZUL++Y3PW
   HVlFAfrjHY8KdZTpbF0B9WRQPiawD1yeEhR5dEYkm3hyXqS5DuOFcfmJq
   WQlwQOVOhyflwOLPik5AasdZ5NitapiuLBMThMMYrmsBXayc/fsws+U0U
   FgVUItbMFGBJPY5eCk7cVgar81bmsemRLoCIrzwsWuSUxc8uBRwhSY2Dc
   VQHYhyNv6Tf8a5JbfFpXi2Xfd1J7eo3IfNlJhN6R8dpy5n/iTzPHxUypY
   SH8lknYDyJA7eFk7px5yo+eUAaj7yfATDG/7OwZZFzbWhCDJTUiz5U/H9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="356710987"
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="356710987"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 02:59:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="640801458"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 18 Aug 2022 02:59:14 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 02:59:13 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 18 Aug 2022 02:59:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 18 Aug 2022 02:59:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 18 Aug 2022 02:59:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOiILjwe/L0nURswJkGMa6r2Hiekj4vYdxEWP9yXEa+k6gLpcyMma0ENUHDLXn9W9xPWu9Jw5kjWtY9JVuPZtlcoP76zGDvzXebxRt1M7LO6YFjQtIYjtf2PbP5gpoP1BO1ayMAvAtArnGGRGbDNyXb1L29RSCSCJ2EbMDlH6yyhfLhmGR4UFOk1JXFeWidxdcjIlaa5IuFkACT6wGkXlDjDA70Vo8sH4cqSu5pF+bkgOJNy4rUXflSVC90QvseSLZZh5vU2YwRNK/suWGgRiEE9LrrmtoxJ2EyoQBW9Qbaj6oESDsygwlQVZYnvEI9KvCv7oJ/mq5rLR8r8B9/4Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QF+sekEInzIsgYcJgONQ7jx53hSjHuzRQtDP126kr2U=;
 b=VDTCD/iudhNRqIk3z+HStQNozw4CclBFfV46zynFoiwECTeg4or52LTYjQ6/Kpqjr6x2fvDKhVBs3vTA+b51HNQCADhhMVhVRziuYyfwfnAfZuXK+8STYwB1LzT9sE5vWKWlUpx/ClXJiVQe0kPfQiaP13RXqtw+AaPJYxziLik1F3lFar7EzHCuT7swEWbw6fi9MQ9JEFH6gtuUIaNbhm0K/1aBLeg23DzNJ0km9E4on7GF66Z5bcDht/KFBPmakZkYRilFlw0W6Tam4TyAVcZbXv1KaFYYHY5lkdsyfggN7yBD0m9xdw2NuAeZoh5i1B2wL8fgQVEncI2PWG4NQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by MWHPR11MB1246.namprd11.prod.outlook.com (2603:10b6:300:29::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.23; Thu, 18 Aug
 2022 09:59:11 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad%6]) with mapi id 15.20.5525.017; Thu, 18 Aug 2022
 09:59:11 +0000
Date:   Thu, 18 Aug 2022 09:58:52 +0000
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Ashok Raj <ashok_raj@linux.intel.com>, X86 ML <x86@kernel.org>,
        "Andrew Cooper" <amc96@srcf.net>,
        LKML <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?=C8=98tefan?= Talpalaru <stefantalpalaru@yahoo.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] x86/microcode/AMD: Attempt applying on every logical
 thread
Message-ID: <Yv4NXOlLHcx1Ghf3@araj-dh-work>
References: <20220814120026.16118-1-bp@alien8.de>
 <YvtcGEHX8eSFpALX@araj-dh-work>
 <YvuQgx698T5cgF+C@zn.tnic>
 <YvzbFXnBjNjK+UJK@araj-dh-work>
 <Yvz53AAh+p5Db7CK@zn.tnic>
 <Yv0JQGa/2BlbQChZ@araj-dh-work>
 <Yv0vu6OqCptK6gc+@zn.tnic>
 <Yv1WXxcIXSQ7nMji@araj-dh-work>
 <Yv1j8v7o3lOniUoH@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yv1j8v7o3lOniUoH@zn.tnic>
X-ClientProxiedBy: BYAPR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:a03:40::46) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65ffc5cb-f9d4-49f5-4358-08da81004cc3
X-MS-TrafficTypeDiagnostic: MWHPR11MB1246:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NnWt1Wf+PW0aN01dXgeA6cyyci193DtA7jrqHfjQ5sfE43Ymm9C2h+sA8BIX6Q84GozIatJ1N10Mq1m8l0f7Axk1LQIcwS6sqgutGWPs3is3rWOFZ14z5OhHwyGosRGgDqMeMwWJQiDhhmJ0NGxMgYsx4bbznbrFDMY31VhGKkM7rJywcv4bcA/x93iTyhdETRPgJ65sRHvM/5DvQFyIVfKVqPwTqEoWgMb27A92JSHcNtHpdstpLmvZEXKBkQyILLhno8ssmegcY1IL88Ew9h8tgj62MKWW9ljGU1Fed/jDBWxjuO7BAmI8dcoM6KpSNp9tHxHdy41w2nzk06uyrmRQmhbx8kLP0Sp2X/hJZTauvL+2KdzySbSlYe4JGVY/YabKEovXR8NFeQa9bhySh2KFmVSLGJCzQ5l5rLCEUl+YY5MZIBpoRn5/OvBOdJmUCH1qP4U/yObsjEeQTWD3dVtPTpvL+w839jkaS2VQ63ZoL6qH02+MOdNniwv4usRoBxlEaY6ynPpk/XVMwhg6iYW1nPSC+5FCzVq7oLm7qJbl2dJ+agUHlyOdOEbXusfqtaVFeNf53CfEar+qKqM52RH6j7vL4YxxefZdyiuC4WegGqBn/DpMxV+1cAarCd5fS2BXs7hThk2rp2Zlt25oytLmmOndBctCB8IW23I8nAaulix9b8asHDH6EFtzFNBpyYFFsPwGvGrXLX9vw+i2og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(376002)(136003)(346002)(366004)(396003)(38100700002)(6506007)(9686003)(6512007)(26005)(83380400001)(186003)(82960400001)(44832011)(8936002)(8676002)(5660300002)(4326008)(66946007)(66556008)(66476007)(33716001)(2906002)(6486002)(478600001)(6666004)(6916009)(41300700001)(54906003)(316002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BThLsTs+uliR3auWXFwL1n4+MituAsGctiJPY/lob4fnjlnaUHXLziES7AP9?=
 =?us-ascii?Q?fhjSXE2cfEvHnw8K3BMKozKuJPqV4wbY7ZaWIYoxmpvtVZnDzMi7+WeuTiv0?=
 =?us-ascii?Q?+Ok1GXe0zhOjBKA1myM72LF0vjCkxACvImhEiGTzzwBprFoVVUTErNnox6il?=
 =?us-ascii?Q?N2b4mKB7qg+dVh2yqPUJiB0PjKUM4C+EVAGPmlfLcnJCafFwiiznxbAJdssd?=
 =?us-ascii?Q?g8A0EHoRlQOQFxcxvI1LsQMMT9VWXDMgxLM67bVED45ug/talcdMcHBvkfsk?=
 =?us-ascii?Q?NJZtM0S03ff8RXbE+46zF6eqAoYj6qk13TEbXjCk/17RwdMhN1QC12T8pdcg?=
 =?us-ascii?Q?ypJI/9aVrfAWf+jb0uZk/ceCz7422hm3Hfe9corKFPDq/M44LB73R20fgfCG?=
 =?us-ascii?Q?KwIZBn7JOlp67B60rjB2ZGuk94niZGhoTBzr80MDoEWGWTK8I5uPBjSNwAoB?=
 =?us-ascii?Q?qzR7FtmDLlJRUgdrj8SjS/YJauh2Mq4jxUERDydDovQA1gClHk0bVuNIx+fU?=
 =?us-ascii?Q?hnJOHtfPd/4uTpEMSnSnRIyBx0LYViYVeJWzg9yAG98eWO38ToDo3F734uAM?=
 =?us-ascii?Q?N46Mczt1D63pFioR87FS1ODo/FOexqIWDr6hQWNOKy2dt71H2snYpTB2vTKC?=
 =?us-ascii?Q?y3p/JueoLCkn/14m6xzSuklmqJ8TDzsK1wajXhiGEffv8Ewjh03P7HO+9xcA?=
 =?us-ascii?Q?giqVu81ZSBbaaSRJWYzytWJa5FAgdGkMCZnWK3H5UYB/8Vy2QY084pyutTBQ?=
 =?us-ascii?Q?x+iuMx72sJUBRjsGx1lMDeZImOGvj3kA3gL17mMe1rJIQScN9iabMmEagymY?=
 =?us-ascii?Q?WA2WwVwV7xWHblRQRaYRIEm0x4CzSuwgJnfLQnoEAn9SBqeLvz2NoSuzdiNQ?=
 =?us-ascii?Q?DShyxRVTmVFF4Uo6x70IF5uiXhe9M2N5zpc31pVAq3+IbYN/i9GUCqaAFY28?=
 =?us-ascii?Q?zvz4R+IvG+W0OkcuqIBPsKuXTzma//SeTecoMWZPAoW8ZIUdDDdqA+fi+8d7?=
 =?us-ascii?Q?0j2p492M828mybsyvmf45hyw5crj28XeJRGhiKHyQHHL+QxKnbvvH17JA04x?=
 =?us-ascii?Q?B47DwiPg+lIIuEX7oJXOJuWHyOtYg7vdQzANa/qdrM1UK+oxIl6lVWnfjpdd?=
 =?us-ascii?Q?PIBmm8PBeMUmjXfWnfVOytL/WQeCBbgP0NrKXhtM6izMdBCrFvNDJsDP0/zi?=
 =?us-ascii?Q?R4qfODwyE195wNUPh4zSIfkGxLsga9C3AM1WlLOiS09XOSBEayhfu6aly/Yv?=
 =?us-ascii?Q?S7yc/SAjdxxlvecAdRMVSNYrXEfZRTdteg4obnyVBPSMccSdMmb3L+kiiTA9?=
 =?us-ascii?Q?pZTL90lIaaVkwJQ6jfJCaSt02VpW62OoPLxcJRwI2P1ofcSgq5U2OT+UlCzL?=
 =?us-ascii?Q?j148p4dpd2dc8XeqdTx4bqJkh6mD3J7sCZqE1DHaZwGUbQYP7zm4AeD1+PnP?=
 =?us-ascii?Q?SLQK9KCTS1YiCimhdGo18NBdjotl39GQBXh8M1CSsR1nz4YnMVGEjC/JXlGV?=
 =?us-ascii?Q?yr1oWjid6J1dLDD4hgJ0gJQFrpJ1r2lG3dUyN2WHba5OQbppJezARgEcO6ew?=
 =?us-ascii?Q?r776NnF66gBqoEj45GBDwsrh9WHUcgPuwQwggbceO/q+kDN2zSdf32/ev2D9?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ffc5cb-f9d4-49f5-4358-08da81004cc3
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 09:59:11.5600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsAfhkoEKYLv+Rw7XIqZd9Fkx9+y+FkRn8iqdfO0yhA6w+XNSRrv9gAUnloyaaAUKOSLLVLMW0bvd/t4NsZjIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1246
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

Hi Boris

On Wed, Aug 17, 2022 at 11:56:02PM +0200, Borislav Petkov wrote:
> On Wed, Aug 17, 2022 at 08:58:07PM +0000, Ashok Raj wrote:
> > For this specific patch in question, its not for testing though.. Its
> > required for functional purposes?
> 
> From its commit message:
> 
> "However, there are microcode patches which do per-thread modification,
> see Link tag below.
> 

I did read the commit log. I was just stating the fact that reload isn't
just for testing, for e.g. in this case its required for functional
reasons.

if cpu_rev > ucode_rev, there is no need to reload microcode correct?
There are a bunch of changes in the original post that seemed like it had
nothing to do with force load on a sibling.

Completely untested, no commit log to spare you from fixing them :-)

Seemed like we were simply passing over each other with emails, thought
I'll convey what I meant here via a patch. Hope this helps.

lemme know what you think.

Cheers,
Ashok

---
 arch/x86/kernel/cpu/microcode/amd.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 8b2fcdfa6d31..124e15b8559b 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -440,7 +440,7 @@ apply_microcode_early_amd(u32 cpuid_1_eax, void *ucode, size_t size, bool save_p
 		return ret;
 
 	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-	if (rev >= mc->hdr.patch_id)
+	if (rev > mc->hdr.patch_id)
 		return ret;
 
 	if (!__apply_microcode_amd(mc)) {
@@ -679,6 +679,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	struct ucode_patch *p;
 	enum ucode_state ret;
 	u32 rev, dummy __always_unused;
+	int first_cpu;
 
 	BUG_ON(raw_smp_processor_id() != cpu);
 
@@ -691,10 +692,17 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	mc_amd  = p->data;
 	uci->mc = p->data;
 
+	first_cpu = cpumask_first(topology_sibling_cpumask(cpu));
 	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
 
 	/* need to apply patch? */
-	if (rev >= mc_amd->hdr.patch_id) {
+	if (((cpu == first_cpu) && rev >= mc_amd->hdr.patch_id)) {
+		ret = UCODE_OK;
+		goto out;
+	}
+
+	/* Siblings need to reload microcode even if rev is same */
+	if (rev > mc_amd->hdr.patch_id) {
 		ret = UCODE_OK;
 		goto out;
 	}
