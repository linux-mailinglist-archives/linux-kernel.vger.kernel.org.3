Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E3C591DA9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 05:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiHNDF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 23:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiHNDFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 23:05:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141CE13F38
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 20:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660446348; x=1691982348;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2p7a52cR9/o4Gf0UxdTQRMFMD2K2ApSR8dn3yUAPBrI=;
  b=j456ZBapwMB3Y5/sA13CwOyoa61w8e4DVUNOHys5UlS+lEegWD5Sk5Jz
   N+srVCrcPtPWDoBKvYdOF63AXcrGlOcvodBFkYCiUz8AZRhoGCOlGua8+
   YOWZIlRYLitBNIVXSW7g3dt0Iuxb0TH+x7cVmYfvmhVxSI3Bk+I6hQ3kt
   uQejFZ6mKumbHMZD6uj5DnR7ybXqUlb/ZXLJfCUKrlNWn0lLXqucVj+Y7
   Cx5k4f9K+5AmvWRp9wAba0AvCqMibm6nrW7X6D+t5jxlF88NTd42RY0x6
   pFptJXR8AIUWO5+yIiClrQbM+MIXeBgudy96iJi9bK5cy3Ia4cFIW7E7K
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="291791746"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="291791746"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 20:05:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="606302207"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 13 Aug 2022 20:05:47 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sat, 13 Aug 2022 20:05:47 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sat, 13 Aug 2022 20:05:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sat, 13 Aug 2022 20:05:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sat, 13 Aug 2022 20:05:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsoWmunN8hxeT1ZF5y3X4kMz/SQdiWOeIJG/kGiaPuRXh7rK751wwF9Gp8BfSMmG1bn5jWpyWC3ppF1GeLRW8OfheSzJ5QcZ0oXOKWnnAeUyuMBeoudw2NqkufAbQ7XNtnxK8ob309xZ+wNcyJr5+XkvPTEAgvEJLp+IeQtONOjH8Gvu9B4RSLNnY74Ma89vTxSVjaFM+noYqfahG2BDt+mkAk+fDLhI/tNMZ1lxImxvI3ZlyYQr1ga2x7x/GicWNesfsDoNhxbAO2j9HRgN3Seh9pHkHmCXJgBa2q7AYzcjH7mYFJCpKJMPzBx0L/Hd+NJzyIYpNakTZDVpBF/TFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x80qMcYwiW/NvGBmDlRwcItHsFcJuM9OfvoYUmFop2s=;
 b=iiXNYWKqyS+vfaZDjWFpjXC3Y0fUBNUXD6gbXBs2IDxcaRpfYQ5dO+rSFgP+cu9XFWi+6h1K84Ilelxnzr/ILs1RCyCX0DslOljV5Iebw8W2WJ3u0xFmAK9UxPYMvviYCuCcK2yj1yhrGf+P/TVdRPXmPMEsEb0ZAMAKK6ftEHZTSBfI+ScjSo69pMCz3doMud9Y3Y8XvSYWZx6eAQX6zmulDod/ICozx4lW8igbETj/ONEuPgviaxqmtbkTFrRWH4I4QQBqr/aJ0UfgEwFcv9mxvVzZsnN+/k6hcsP8sJgvy4h/sV47BM13we8ZNnZ6HB3FzmyGF/a8FEXoN1RqRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by CO6PR11MB5571.namprd11.prod.outlook.com (2603:10b6:5:35f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Sun, 14 Aug
 2022 03:05:43 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad%5]) with mapi id 15.20.5525.010; Sun, 14 Aug 2022
 03:05:43 +0000
Date:   Sun, 14 Aug 2022 03:05:26 +0000
From:   Ashok Raj <ashok.raj@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 5/5] x86/microcode: Handle NMI's during microcode update.
Message-ID: <YvhmdsEhPe9nHn2T@araj-dh-work>
References: <20220813223825.3164861-1-ashok.raj@intel.com>
 <20220813223825.3164861-6-ashok.raj@intel.com>
 <0d6afdb6-e546-4ef0-80c2-84827c11f2ce@www.fastmail.com>
 <1471edba-ccb9-4568-85da-bf69f55d02c8@www.fastmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1471edba-ccb9-4568-85da-bf69f55d02c8@www.fastmail.com>
X-ClientProxiedBy: BYAPR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::22) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 021bc9b0-c39b-45ea-fe54-08da7da1e040
X-MS-TrafficTypeDiagnostic: CO6PR11MB5571:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cCoQi2M9QMWHwaSRjIpdgWaYF3CDdLJnNne51L+EakrFLqEMjWMmDmx4VUDNK9f2H0BmyDFwmWJT/3lJfITgOheuPAxjhnSqTsm9AL+WS0BHTuRSCSPvkVGapSXO0f8ekD4wQ/qFXVCMdKkUnfE55h4S4REN2G4RDLzijXBJ6ccIwFjsYCSP1eWixnEGNGyMU5p/yqO3R7kPuLM0m1NiFoLSr6PmYjc0DqoKohqQBN6e9v4YKkoEvek+9sNYygn+LGg4qMjGG7eAu8f3Myl9lqG3QAgVwyZQw2N5QSvKH3b9L0uOESge3x47wC0SFoX1g7MhQhovYGG987NuvC2Pi3LpGEfpW5w7pf6ANYEVI5uH2Aze3CyzhN5iaPwrPP1/O3FMJilNVlGkn6VU7QM6cAezf8WOVwMkkLQPETXl0IkaIHWAV2hby1jf2Fqe19yb60cwkUa2lDdTbF/+Wkc1LrA+QZgOeYHAWRVDhhYv9/EWQZoQihhsze7TWkKPjZXPhrEDntDzBx/3ETUQw/F3qValJKOu/+P4Dz+Csbh5nVImmpthVNf0m06Aj4r0AklNsFya9a5xNw5oVIFl5onC5t/IlxFlnMaygtnm4AI6WhIb4HMpr/tUSvqa5dcxO1unKfLhYtF+ETJ98fsN125WSdPdPTnj81K6kXiiKHVBIjuyOxOho73LhyJAJrBydrjwOHzoRyeJO9PdFWyEVAtVN4wCbG4hWtzy279/m4AkxqZ2+vQWO4xm4a+6OHykbL3e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(396003)(376002)(366004)(39860400002)(346002)(6486002)(6506007)(6666004)(86362001)(186003)(478600001)(41300700001)(9686003)(26005)(83380400001)(6512007)(33716001)(66946007)(8676002)(316002)(66476007)(107886003)(4326008)(54906003)(66556008)(15650500001)(5660300002)(6916009)(82960400001)(44832011)(8936002)(38100700002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4J0xNzvcJ2b93Xy6Yypr7825ps+F89cDSdsznIyoDZJwVUKSkWWM20IpLHnC?=
 =?us-ascii?Q?hcJJBteooqe7hdH/nZILCcaW+2LhgDt1wFwjfLHIsiSBOaU1nhLiPn7N/l5X?=
 =?us-ascii?Q?8ZgHLciBvgD4OhlSYtnymGtfiwdSm2IXpPi2pg8IlIIhjSnW0wXUFI+dRnXY?=
 =?us-ascii?Q?6VPiD43IKCC7VawCsAAUKfz1Y9NJsWL4/OLNqZqcgTg39ybVMg27ZiNkC6no?=
 =?us-ascii?Q?vsb3vgBz2UAgZ6bvU0tKtEdqhx0EFXbRL2i15O4edMCZseVn+EGUUOZhH8dP?=
 =?us-ascii?Q?S6gwFfBBePSqIkUc3qTLIDb63hds1R5ed2nwzbD3ul7slR5uvqTHzFgF9Ivr?=
 =?us-ascii?Q?R2EldRgg8q6oLhCAMgNrzTAvUt4USkWOqvy3cepY7uZZqsiBAL7P/mn7cJOL?=
 =?us-ascii?Q?MWW9IIX0M9AXg1iqQx3eLsMy94trRAaZCe+ftIerzmaZtdAhma8VxXRwr/2a?=
 =?us-ascii?Q?SJOlhvWJunn8aZ6JEjd8sEsNNt3Qy3zgA22KZ66nUCRhcCqYSV3rmYZK+pYq?=
 =?us-ascii?Q?R+qJncNVHHYhMP82nTMmC6c36ziwRdR7x1jkBGwjpcOFVcMM/feLj3Fwnmfd?=
 =?us-ascii?Q?9NsvRwIyAX0Y6jWUIqkYg5mhztUP8Izg2GAc5IdbxXJMkfvS/GPb/UARjQVi?=
 =?us-ascii?Q?Q5gHvEJFnhYjZC9QNY6INE0nteDJAvpIdUz+ipb/ukCKgLqTipoEiUSz481n?=
 =?us-ascii?Q?VRqh9wGhJnSOeJS+sy1g+sYgUk8u4vtaMcNHeRtOE6YeCPgrSebzTYZtY0t6?=
 =?us-ascii?Q?0V4JCt+WRAn62oFAdHWmpbti/ZIIdkkGAUyKFhk5kxwe1wkJFvK6pri3f2ia?=
 =?us-ascii?Q?D3u2w+XYGskWGOitC2bQL36QTW1jkGH124rOt1Os5OV9bK1v9KDP3+wf1zSk?=
 =?us-ascii?Q?5oX2qxEO/yUw03cD+R8Jl6xRstENXB+/qT8UeK3ZFU8AdpFGRvtIpPFVyPAI?=
 =?us-ascii?Q?RyAAzU3V703TbCB/fbI5q5SQfZmhnzE/4kX1yEDGzzlkBxXIcNHwoLaGeDCA?=
 =?us-ascii?Q?N7h9GBk+8Lkw8BImJ72u7SZ4hKaMsP1elp8SQ41uh1EiYtSFHdWLSsA+qDY4?=
 =?us-ascii?Q?f2DbopgFvgVWKE/9Y5mr1ZGO9d7F7vECTfFPPMaTzHf0Db/aKkH/QREHbtSz?=
 =?us-ascii?Q?6N1xDjfiXHzWRBO6O48mJ3CQ54Ck4bkk+tzBJg/oom4kHt5io1z4YwWrvtct?=
 =?us-ascii?Q?qhGxGNns5D/o2xucOQftSjfl9C7SN2wELEVnsk7srdXo6is/1LVkEi7vHvb+?=
 =?us-ascii?Q?z/B+7IPfXnNjEUVM3/x+kuibgJpxGkqHMl5l6/Mea1mFKnTdNPireGy8WUDZ?=
 =?us-ascii?Q?DY+C9gtcD70qThZVsEqANUXtXars3qFkKsTaLjK6yKk7U3fJpvsxJIEG46WJ?=
 =?us-ascii?Q?7vFiV0LYQAr3gHKjZHfCG34iU+2I1B2QvqdS9g0QCv0XLqYJ20k9Jw+Xs3lw?=
 =?us-ascii?Q?ofhFXLhJbdWu8Zs/X4LLg5Q7TAwuw8ow1kfPVXAmTSPC2Ja6dCsvTda1Ihx5?=
 =?us-ascii?Q?S2qiOe6JVfwntgSH8f1ygFFeBw3HHiDQNxZNLva6Qqx0grLMm4IHP3nqo2b/?=
 =?us-ascii?Q?JjZlEanbkj3HOVftv6H6tqcrT1jaxkcIrp0mz1Vzx2suQSnsxXs2boSBLktA?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 021bc9b0-c39b-45ea-fe54-08da7da1e040
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2022 03:05:43.3002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aq9uvVq5hBezRKmKfTcRs8FeDpM2V1cgL0B3FW43TASmSNlJ81OtNDpdH8+jr16Sm16e7M/6+2ITF2NX4qjsFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5571
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

On Sat, Aug 13, 2022 at 06:19:04PM -0700, Andy Lutomirski wrote:
> On Sat, Aug 13, 2022, at 5:13 PM, Andy Lutomirski wrote:
> > On Sat, Aug 13, 2022, at 3:38 PM, Ashok Raj wrote:
> >> Microcode updates need a guarantee that the thread sibling that is waiting
> >> for the update to finish on the primary core will not execute any
> >> instructions until the update is complete. This is required to guarantee
> >> any MSR or instruction that's being patched will be executed before the
> >> update is complete.
> >>
> >> After the stop_machine() rendezvous, an NMI handler is registered. If an
> >> NMI were to happen while the microcode update is not complete, the
> >> secondary thread will spin until the ucode update state is cleared.
> >>
> >> Couple of choices discussed are:
> >>
> >> 1. Rendezvous inside the NMI handler, and also perform the update from
> >>    within the handler. This seemed too risky and might cause instability
> >>    with the races that we would need to solve. This would be a difficult
> >>    choice.
> >
> > I prefer choice 1.  As I understand it, Xen has done this for a while 
> > to good effect.
> >
> > If I were implementing this, I would rendezvous via stop_machine as 
> > usual.  Then I would set a flag or install a handler indicating that we 
> > are doing a microcode update, send NMI-to-self, and rendezvous in the 
> > NMI handler and do the update.
> >
> 
> So I thought about this a bit more.
> 
> What's the actual goal?  Are we trying to execute no instructions at all on the sibling or are we trying to avoid executing nasty instructions like RDMSR and WRMSR?

Basically when the thread running wrmsr 0x79 asks for exclusive access to
the core, the second CPU is pulled into some ucode context, then the
primary thread updates the ucode. Secondary is released. But if the
secondary was in the middle of an instruction that is being patched, when
it resumes execution, it may go to some non-existent context and cause
weird things to happen. 

I'm not sure if the interrupt entry code does any fancy stuff, which case
dropping in the NMI handler early might be a better option.

I tried to do apic->sendIPIall(), then just wait for the 2 threads of a
core to rendezvous. Maybe instead I should have done the
selfIPI might be better. I'll do some more experiments with what I sent in
this patchset. 
> 
> If it's the former, we don't have a whole lot of choices.  We need the sibling to be in HLT or MWAIT, and we need NMIs masked or we need all likely NMI sources shut down.  If it's the latter, then we would ideally like to avoid a trip through the entry or exit code -- that code has nasty instructions (RDMSR in the paranoid path if !FSGSBASE, WRMSRs for mitigations, etc).  And we need to be extra careful: there are cases where NMIs are not actually masked but we just simulate NMIs being masked through the delightful logic in the entry code.  Off the top of my head, the NMI-entry-pretend-masked path probably doesn't execute nasty instructions other than IRET, but still, this might be fragile.

Remember, mwait() was patched that caused pain.. I remember Thomas
mentioned this a while back.

> 
> Or we stop messing around and do this for real.  Soft-offline the sibling, send it INIT, do the ucode patch, then SIPI, SIPI and resume the world.  What could possibly go wrong?


All these are looking more complicated, and might add some significant
latency. We might as well invoke SMI and let BIOS SMM handler to the update
:-)

> 
> I have to say: Intel, can you please get your act together?  There is an entity in the system that is *actually* capable of doing this right: the microcode.

So we have it.. this dirtyness is for all the current gen products.. Much
improved microcode loading is on the way. 
