Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8A2596DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbiHQLlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239068AbiHQLlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:41:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782C882FAB
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660736459; x=1692272459;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hV7qxQF90QR48DkBsVRhuNVynKffQFgelZjbhe2vauc=;
  b=nYIWb7rN2XyNII1oAE8tkMFmIEfJ8OFmhbh+Xp866SvsLaN9ycGRmuoX
   b7WSaaMxbCXnukFMS9vMnrcEHxhMO8fqtRqyAfAiyI2oN5vKNMtMrEUVW
   do+CkbapANywa5dt1nhb9umcx74cQUX/WcQWufAeHPaXHpRJnD0BnAxy3
   03qczXiMxWnP6jodYN6BXc/IyAXAou2Ibob4zDXct86LEaN2bxxW7tfH3
   Pbr5/ADhmKeJkR0rUoWW5UlLyzQQxoZgaN02raaI9/oN7acY03adb4fw5
   NIS57TQ79jI0yha5FNodJnd1p2TrUzDDvjsOccxVRUXot6NPz9175HMk0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="318478998"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="318478998"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 04:40:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="667580302"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 17 Aug 2022 04:40:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 04:40:58 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 04:40:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 04:40:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 04:40:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glptG0/2yfJfiq+unlvtGj95Bi4yGOPRLuNnmA2WT6zdAE5nwn/JUpBDZKko+qv2Y8KhCsZJe6cXr0mHjtrEzsBTtBKsklUtuOruZMTgEpUpHH0YYbcYqeLW0LMTbsU4JLFHgi1ZlaArkD4NS9MRpf6/3RshepXR6mhLPGLkWJsGDpK92MaQGbpfsnNFjES7kcsrdYqmNYy9a5EXkjC3881PVmvg4VBYvN6uc2/UmS0yVebrLgLTU1be+xo6qen1ZVeuX6qWQhj2j0Upkxy4awYYPBE+fw2TFvWLih+B+3hDgL7bxCkuEL91h8wYe8XFi5LvH9KI24wUHvpolKAY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmjyFSoRbMPO4PzKkEQQCJehlHzEuOkWD4KE1DZo60E=;
 b=brP1RK2NAzoawmoUiIdGoYYsLWDng59GNftcCvNUsu2+8GHjwt7O8zPNQWZIxiNuGdIX3Ma89UYaCxiLsrMRViCfk1bFHusfvo90wGPVqV+xSBFGEw0m0oZNnsTc7CKrpbWWSAi4axPyUee47fhcqWUGOgs2wOZkMqApPNaEBcrCpguWy4A4HqpHvzONaYdPTMVGfnWgq0ZVTbErAdoiL8H26clTOUl2ayjUvG/qcMqkGk7W3GQuSGkPZVxyTK6IkyQGp3JXioxbAgT8rwp+gDMQBlQArK9d3vzLShDd72NQx6OMvnf/z1hge5DgicGYTKVDKbLwn0pmcjBuhJFLfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DM4PR11MB5389.namprd11.prod.outlook.com (2603:10b6:5:394::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Wed, 17 Aug
 2022 11:40:55 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad%6]) with mapi id 15.20.5525.017; Wed, 17 Aug 2022
 11:40:55 +0000
Date:   Wed, 17 Aug 2022 11:40:35 +0000
From:   Ashok Raj <ashok.raj@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v3 3/5] x86/microcode: Avoid any chance of MCE's during
 microcode update
Message-ID: <YvzTsxilM1kUGeFQ@araj-dh-work>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-4-ashok.raj@intel.com>
 <Yvybq+hYT4tG/yAg@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yvybq+hYT4tG/yAg@gmail.com>
X-ClientProxiedBy: BYAPR07CA0045.namprd07.prod.outlook.com
 (2603:10b6:a03:60::22) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c79fe2db-5598-41f4-eae9-08da80455838
X-MS-TrafficTypeDiagnostic: DM4PR11MB5389:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBDZUDc+rYH/LjiaoFam7MiUKRbBQVjFPa9+VkERsD53FAjWukkRE+uG5DzzjfBnLkR1Xw7jS3vwYxYwkR4XwS2Ibxm2suHHL9DjnfQd203TamEuZ91p1UfwvC44SFR6H8mThl34X0YVG0z+e+sN9ylzGcxsDSbybtx5QyIsCpoyTgm14KSh5RpcxT57XyfPbLrDESzlVOjEDi+4LNbRz3t2m1wDRXpS7bsc0U5FtNaEFaXz6xNP3/MFz/DIWxb1k5SuwArJiCZP9ru1ojSRTAtwWsMO2JnaZxb8NoA1jMc/zmW9+ZsT6YWRWNMdT9UHwXxCytkjbuZOcwzn5jQli+WERkmqi5gIC9cTIrPmY9xy7VSGgnRkBoKYnRmkdHkgcvGYd/+iFRhMQqZuUllOaT0GUb5y+CEi5Y74h/GVhHyM9pnCB7mxdDkQxkP5mHOVzSJk9kws73PKPzGdlC/z9OSlD7oo++szhnnZSOHTW35/a7Sz8Fl8heUfuu7IiAWDq91P9PYycxeuk7LXgQwzsPw+WqmJkIvdWxdWp3xQdVJQoAzU0qq48qHglvJIGXO5cgo9oZWneCj2lvi9oTZPMQ64xxMi0UBdaXOiv03G4Uhu+O7yh41BfG61HztuKx/hrqaG8IAyZ/yHi5Pw2YzoUNuUVFsMFIWOphPa/HAJWSniHjhY8wy9SCQo1I6o8YhTcCmE4Gs6CW3fG8IhjB0oSenBbDYSx6eRd7s1L0iIXVivlJR7jczes6Xc7KMngZFn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(366004)(39860400002)(376002)(396003)(346002)(6916009)(186003)(38100700002)(86362001)(83380400001)(54906003)(66556008)(66476007)(66946007)(8676002)(4326008)(316002)(6486002)(2906002)(5660300002)(8936002)(6506007)(6512007)(82960400001)(26005)(6666004)(33716001)(15650500001)(478600001)(41300700001)(9686003)(107886003)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rvEljZ1GeY/lixDiuCqy8jN6JkM6J0oBPgMVEgvuaRIbRUdq96utcYmebC4D?=
 =?us-ascii?Q?RHz1+EQnSswfiAbXP5hcnzicxgGP6qxsqVVVSLysEtzQ0go6/sP8zHdvamqW?=
 =?us-ascii?Q?Am3sRRcR0EsG/NtzeovFBE/UHiZ9tDzgFBBWEg3qKGdoKNIrIx2iFyFNwn+Q?=
 =?us-ascii?Q?lhAoxCpqqQXScijZW0xPw6ZljKRo29eABJ9lpYvL06//fzlW2izbxmrmrfcd?=
 =?us-ascii?Q?2DaYHiSOy6/+e/PIt/qDzWizHbALgTIINSPAUw+Fud/RvpofNr2VxN95i4ax?=
 =?us-ascii?Q?gm2x8uxQT4WRKEVbBZmbQlF79jtR+/qbeJQQpaf5X89xr4qbdqTcpUwMWr2J?=
 =?us-ascii?Q?ChEJdhjY1DlEJJfBa9vC8kzRKtJQVuQGzGipo04Fen2B1Y5NvFbTt7l3lqSg?=
 =?us-ascii?Q?H9I6NR6oJTYh2P7ydqwwxTW3XLgLIpyDvrGZlDFbbCVuJ4RR0VgXUmJ+x3aj?=
 =?us-ascii?Q?aWBNxNlJB8oveoY2Wj84o8Mzj+bjxPRnGDPo8xvPACJqqSpRy8cCiQJNbAGF?=
 =?us-ascii?Q?SfKLoBhqMpgewSvTYpZiY6KQdteflVGtquH7RzM1gZkD/F1S5EGx28l/w242?=
 =?us-ascii?Q?a6TZlCzvWCnMeh808bx+RPwiNjS1550VRjcFuExzr70EQzlTudBGybAiIwkI?=
 =?us-ascii?Q?aHPXt9HiYvBeOOtv0gYmUst9PKzllSx2zi/tZvcG/m5dCOHhGX30AymEcIu/?=
 =?us-ascii?Q?Dll5OwfyYzyfz9SOvNzWmummz2FsgzeIYyXdQQIrMOXlWk+kjLwL4lphF+xa?=
 =?us-ascii?Q?Dc5O+csMI3xng4SEaRYolDUss4zWRwH36URjQQpVzdONcRBcj/DMT9HemeWS?=
 =?us-ascii?Q?IbhNw399wiR2We9JN/Nb0S0bE1nLJRGr5zynmc6M8AIp5F2JD4vY3DC/nXRZ?=
 =?us-ascii?Q?EoAc0oIgXbReOArTfHMLRau3EoAm8hzZoNhbfbsXpWSdJiDhoB5GeelEAcX2?=
 =?us-ascii?Q?/ZXlx7WTnBnHKOSgldVHvQnuI3bCuenT/x5fXmqdgmGOQ8xH4Oc+/Hg0lMDd?=
 =?us-ascii?Q?gnDWyAtP0BbSPYosvCmLOnCjKVgAnf9yeI3UZmuD4g0LgOUFud8M5d0LuGw7?=
 =?us-ascii?Q?2cC1d99gcdcJQoNee0HKQj+udwJ9xtqlvcDxaT4EUiGDGsEqXGDjmKFH/SSV?=
 =?us-ascii?Q?rMq9zpz7GGECilC8j26Ymr14blYPhvvrhOs06SCgE/fLDyx2qN3Ggb5Vqie6?=
 =?us-ascii?Q?gshUfYCNpX0NUUQV4lgcODFWk/4qcV7L6hhoAynjq38JsDzlFmh1iY/P8JuF?=
 =?us-ascii?Q?OiJ76vDy26ZcgYbPQYf+KIDExGhsFEoFyDH8d3Iw4wRYA5u4WiQX9etFDQ7/?=
 =?us-ascii?Q?11kzCnj4I+G3E59yh8BFdz2illfTBEXoPM0GTUUkY64ITjJi6NLg6pthWjH4?=
 =?us-ascii?Q?lXoUf0+v9t1yLqFv1u7L5Irv/0bOxPUAeiYNhhy6vvGeYzIuCvoeO1vFXmgD?=
 =?us-ascii?Q?4cb3BQB5j1lUuHkHyQySFqlR+KfsnhnswJ7wO/nu2uYstYOQBhnp5x/JSXFe?=
 =?us-ascii?Q?prad13+rvKmSk9rGp13TAg+/YBDEPPUInAp32nL1qXpXN29rkuJaUdZPuyYs?=
 =?us-ascii?Q?Td/OsQRIzyER+pW6D+AS1+pykWs0GrFJeHyHy72ZF3fZk7ZSm5BQ/aaQNUAl?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c79fe2db-5598-41f4-eae9-08da80455838
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 11:40:54.8663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Z3oDIr2PcnoFtK8TBbKWIckRtIoEJ0TVQLK3jfAmX5xvT0hlwyS9GMDdwzcinvHaxtFCvIzXnK50Vjx2sycyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5389
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 09:41:31AM +0200, Ingo Molnar wrote:
> 
> > +void mce_set_mcip(void)
> > +{
> > +	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0x1);
> > +}
> > +
> > +void mce_clear_mcip(void)
> > +{
> > +	mce_wrmsrl(MSR_IA32_MCG_STATUS, 0x0);
> > +}
> 
> Instead of naming new APIs after how they are doing stuff, please name them 
> after *what* they are doing at the highest level: they disable/enable MCEs.
> 
> Ie. I'd suggest something like:
> 
>      mce_disable()
>      mce_enable()

We actually aren't disabling MCE's we set things up to promote it to a more
severe shutdown if an MCE were to be signaled while in the ucode update
flow.

I'm struggling to find a suitable name. But I agree with what you are
saying.

promote_mce_to_fatal()? I'll take any names that seem fit.

> 
> I'd also suggest to at minimum add a WARN_ON_ONCE() if MSR_IA32_MCG_STATUS 
> is already 1 when we disable it - because whoever wanted it disabled will 
> now be surprised by us enabling them again.

Ok, will add.

> 
> > +	/*
> > +	 * Its dangerous to let MCE while microcode update is in progress.
> 
> s/let MCE while
>  /let MCEs execute while
> 
> > +	 * Its extremely rare and even if happens they are fatal errors.
> > +	 * But reading patched areas before the update is complete can be
> > +	 * leading to unpredictable results. Setting MCIP will guarantee
> 
> s/can be leading to
>  /can lead to
> 
> > +	 * the platform is taken to reset predictively.
> 
> What does 'the platform is taken to reset predictively' mean?

Since we are setting MCG_STATUS.MCIP=1, since MCE's aren't nestable, 
if there is a hardware event trying to signal a MCE, it will turn into a
platform reset. The MCE registers that logged the event will be sticky
and preserve in a warm reset case. BIOS or OS can pickup values after the
reboot is complete.

> 
> Did you mean 'predictibly'/'reliably'?

I don't know the difference, except both are a trustworthy topic :-)

I like predictable, the system is going down.. not reliable :-)
> 
> > +	 */
> > +	mce_set_mcip();
> >  	/*
> >  	 * On an SMT system, it suffices to load the microcode on one sibling of
> >  	 * the core because the microcode engine is shared between the threads.
> > @@ -457,6 +466,7 @@ static int __reload_late(void *info)
> >  	 * loading attempts happen on multiple threads of an SMT core. See
> >  	 * below.
> >  	 */
> > +
> >  	if (cpumask_first(topology_sibling_cpumask(cpu)) == cpu)
> >  		apply_microcode_local(&err);
> >  	else
> 
> Spurious newline added?

It's a gonner !

Cheers,
Ashok
