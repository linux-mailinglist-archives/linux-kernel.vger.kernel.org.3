Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC95596E6B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbiHQMbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239449AbiHQMbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:31:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B7E80E9C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660739475; x=1692275475;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OYgl32X7ea5e4myd6/S2ynhZUoGTr5hCt8E5wutO43w=;
  b=dDspwAcHw0+Q43N3GYGyBU1fVmiZmjbOD19RmH03o6HxhtXn6WuJDWgK
   yUURmVxN45UrRsKlT/QoFIiiLGseMrSIR5qFkLv/6KSfLSd0YsKFz1Tcq
   Cniu9lDUmf8EILGQXYvI1EFmOu6XQCzN4d68p+QBdif8GHTx3HKJGJVap
   Dsk89wjQ2RZtV4Oyz+fkID2diBiZaaJQVp4aq3VCvM2ZZavSiRb0t0l0D
   Y/dfIqNv6ZMXzmU33fGUw4V4aiXhmzILrjWP44MBwxBtvHSDzUSgtD2yo
   3KHEE9nG5lkKECwjx9AeFLbglDzLnnWz5kwCeW9zcUJxVGFRVlCSW+Spm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="356475775"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="356475775"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 05:31:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="935340801"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2022 05:31:12 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 05:31:12 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 05:31:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 05:31:11 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 05:31:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzR6b+0a1Lj76idqVSc+st3HdrHkTdpJMmgCGCL4wW+FSctpVLwyX0pRH72nzYE3pqNt2g4t+LW+p/vw4rv2FNyEdbf0rANPLZGXjdxMyNblfqvM5H2EPusrleaUnzLzfHr4fqtHC1rAuWwsZ3OkEWqqzW95VekI07hcBfraOiY/WWHHfgLNkKtrQ3OSOXZ3XSjq2JdMQckAQXWzQHjVINAjk2W3dsoaIxfq9MRb5fJ96xWqp0fU64YgKDKAHe/Ix91uSdiAMuNwpmgDvqGJyaQ6q2TsgBUzk7xv3y9UE6uM+2qwJBTqolgY0gM94oTDdm+72W/7xAXVvwFgyLpL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vW6cutmlrPAlz6OzifFR9hdaHoHSFilGl1nhMofiksE=;
 b=H+mCeuhAv41oOjXksjIuzz9/bwSTfwMQYN2+yf/sOUWvN4YrlB5cepkRjWJUr5F6P4sLnCrO9kYQI8vu8SWo0oDw4rscGBkjK23QSi23SklTgAWow5mev84kuzN5fr6uQtskm92Jp5VI2FrGqI9w19+Aiz5OtZBN8nd6NJ1AVkA3idNmUW/MZWm4tB4xBoGHQAarKStwj033WFnF1Q+TqMsNlZJibHrk7ssPONugFfBLK9FZg3DKXaZVpwqzErsRE1YY564IfUgV6E/yVA2DprTTirOQZFFBU/4XP4kzY7yB9bwvrlWowxRsZBMBtEGFV4FZh/eYjaxGvuAGX4kImQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by CO1PR11MB4883.namprd11.prod.outlook.com (2603:10b6:303:9b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 17 Aug
 2022 12:31:08 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad%6]) with mapi id 15.20.5525.017; Wed, 17 Aug 2022
 12:31:08 +0000
Date:   Wed, 17 Aug 2022 12:30:49 +0000
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <YvzfebgOWVKYLClJ@araj-dh-work>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-4-ashok.raj@intel.com>
 <Yvybq+hYT4tG/yAg@gmail.com>
 <Yvyfi9XC8bu0cOG+@gmail.com>
 <YvyiHGMbp2MtV0Vr@zn.tnic>
 <YvzXsf0mGEcOlZC5@araj-dh-work>
 <Yvzay5jOu5XBJpWa@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yvzay5jOu5XBJpWa@zn.tnic>
X-ClientProxiedBy: BYAPR02CA0071.namprd02.prod.outlook.com
 (2603:10b6:a03:54::48) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed0d9489-dae3-43df-fd5d-08da804c5c4b
X-MS-TrafficTypeDiagnostic: CO1PR11MB4883:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bP+hxg+GxCJGCB8tgLb1cL+xTgSnZL7sFqct3UAiwL9gNcfeoRYS3dObsrLFN4oZgoPv9M918c5P1+hi9SKPx9ctYnSOMF6iMh17vW+wi1ET6NlnzvQX5wOiiPUXij4ugQVRgFzPMyxwC89lmRDiKHDdIjHrQMY3qHGTOt/e7La4C9bvwSLpRgPX0c0bgmHgqs+OhCIZrqrfauL8wdeSSDLIFlwm/D+Ej6du0B9E0sxEpZG8xdMWnR3uNbm6XRp0qcY2IPgitPBnFqXKWzGuo74ERefGh/NDPWYwMne5UN9hdUwjBPkAYodtb3VMrlObQ/tjIDjUHTJeEFpaOLwVVveJQY0dgRCNIsQ48uDyARgKl4sZU1QU5ZhYnqW33S2EjBtFl271dh2BOCJj/+NOVH55f4AOpaSuD3dRJjAeDIlaRX5sELGMgn/ce6ZalnE5jjX6yP8B2vsr31T0P+6KPD5/9Y68orwkcMhZldp2x0NOkmIfyinbq5UgSjslsCbzHdAKqcfjKkPee8b5If6D0Vnr8YB2tV6VSv9zL0qsy5oTrCuSOeGWHgvx2p4E4MDVablsd/BCtY2ybq3m2bcY6YnHNM40pf8DFjJQj5PPs82YPzMPGhHc78X8pigu3DNLrb2y7RUru7/32uuoG168KNczhL+Gm21M46QiuwN4+kmX+0CVPAkkIsTirjQFsd7jaLDvqvrKmgwVXbVeg4ghItIF+TqMR0ZOCALKNxpgcDoHM4K5DBCe9WbQlbe1lFDv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(366004)(396003)(376002)(136003)(39860400002)(2906002)(41300700001)(6666004)(6512007)(26005)(6486002)(6506007)(9686003)(4326008)(15650500001)(82960400001)(66476007)(8676002)(33716001)(316002)(86362001)(6916009)(478600001)(66556008)(54906003)(38100700002)(83380400001)(186003)(107886003)(8936002)(44832011)(66946007)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qVuZTeiFX05GNSc9gBF1QW6nGYZDsI2ENPi7HCusZC7lMzwbz6WDJ19LSIeK?=
 =?us-ascii?Q?TJ4vV/IRlsLzsxjLdpiBjBBj/UgED7wuR4M3jWBqqCQVRvFBq5w+ijYDv8Qj?=
 =?us-ascii?Q?f5z6KNtHORJjxvFJU6Rmd060yP0hfLucrAz/cHbml7iwt7+CszGbjrG4ALyA?=
 =?us-ascii?Q?nxfDYtPVUFG8qd8pRg5++oHhl0OfnDQp/bRBuRhp3VFuzmg6/LQ4onBeXn54?=
 =?us-ascii?Q?8L0Q4yoNvzOUJxQRKz2vEH97E2LkucDfYSOsj75JaXB5BtnFpEqrXukJg84q?=
 =?us-ascii?Q?zd5pp8tn0Ty0dtFYXq+w4NvluvAgEYcWUS0X40BfVjn/W7OTF3hQBDwmaJ4v?=
 =?us-ascii?Q?OeIxO9poAl+X7y7DUONMEoQTv1GlmB7y7gBCIP5jGPL2QNSDYohXXHD/zJ0e?=
 =?us-ascii?Q?FL99Zm7YQ7M1OoOPg0ZAe63IY/9TdcOmGe2EAspPNxt2F7jQwrJU4zhzgGTS?=
 =?us-ascii?Q?C/V3Gc90E2ORfhoRfan3nepcS/TWv8STGcllbUbGeKA6KCnDVik0qYVv3ck4?=
 =?us-ascii?Q?4DutP3W0ktVG24DonMBIXaSbN72YA8LnDcyk5aVH6KL6hUT8zYhZGx1P3/T0?=
 =?us-ascii?Q?6sDJoaDV+Iy12Hm6tKf7RtSKUoL1fvYgV4TGLCoq5JJUWw4Vvx6Itsj0PHjB?=
 =?us-ascii?Q?RF1+EuGRyNIFlBxlfuUi7SEjC0TWY9n24zGSp+wfMOUyX6odcfnvnubje5/1?=
 =?us-ascii?Q?PqryyLLZlvn1Th2O8CDOCifAVUUMWUHlJN+uR+lcDxR2QcgqYTVFcgjZbaTS?=
 =?us-ascii?Q?/KYFudCKztuww5WrkHsi8qn7nY1Z5wrW85ABFvCuawhlfxp/qI04mrhBjEg5?=
 =?us-ascii?Q?JouiE/g0nIdRgDOQp1tHA6uiQiXfsrHLsCiaPf8sfcZINQcNC5+qAmHJsiSr?=
 =?us-ascii?Q?R6J2vItPJEn7Zc13XtwcxpDJnHEtLY8VxxTA2w1gdN0BGXQ3iaIlhbXPWQQF?=
 =?us-ascii?Q?E7ElDq4wV8MirnM7K7LeWkHq25BNyuHGbf6ASxNmaR9fugShXK6LPi+LNfAE?=
 =?us-ascii?Q?TQOPrbi2sBVbvEE/mMQCzK+8HJPCGKrRVwlyhxeiDm/UMT7PYyaOGPAZAY4i?=
 =?us-ascii?Q?nNkxPrYKnexxyXMidWDxZbjPHsWo5iQJVZaAvYaok9HItO9u9AjX5bIU31F3?=
 =?us-ascii?Q?FnLz8Bj41Vq/uGLIgDSMYoG15fwX99DmBV9h6q6gSWO1lmlN3U4ZcGXz0tCx?=
 =?us-ascii?Q?I86Cix2teg6Q2yPbHRWxG43Yzsc1Krs8LmLJIK5b3MtwQA9Rp5ZuUcmzzijI?=
 =?us-ascii?Q?qyt31ljB8bbcAqnYtz5C4Lf37WXeJm2fxWYj/Hmngi5NK+sr8j/hnQ9+UFGT?=
 =?us-ascii?Q?hrjCfH2YvLri6s5C5gOE15NydRcypc3FK4QE7X7LBrGPS1229G4NoPTWY3ix?=
 =?us-ascii?Q?75qQ04MyfzQkfMaDqqdpLFlt2QbxUCdIR59WQA0nXOP9QFaOCMFng0EiZTnu?=
 =?us-ascii?Q?PRbQN5HocrpgSb0s4wMau+zwv51kRUOJbAGEc88fHtnzJPgnrW6aREZesdMV?=
 =?us-ascii?Q?RrbsQymw16Y4zrtZss6l9vQOV/XF/m0MN+Qf+0fZs4/1knaQO2myNA1XJqZq?=
 =?us-ascii?Q?YhW8Tl3NVycLq0ivQpLjMUDJ/jcGNHpHVeOFvM3sOAQQ2/BAqvam+CeT9L+3?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0d9489-dae3-43df-fd5d-08da804c5c4b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 12:31:08.2106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p68qcxehWXPCEy3YBWuLuJjt3X6MFGyFu+yaqYBdIFTqiP5sWKEN/fmJiLxAUZ0e48iMNa3IHf/XZ+jaJQtMqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4883
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

On Wed, Aug 17, 2022 at 02:10:51PM +0200, Borislav Petkov wrote:
> On Wed, Aug 17, 2022 at 11:57:37AM +0000, Ashok Raj wrote:
> > You have this reversed. if you get an MCE and MCIP=1 -> shutdown
> 
> Yeah yeah.
> 
> > When MCE's happen during the update they are always fatal errors.
> 
> How did you decide that?
> 
> Because all CPUs are executing the loop and thus no user process?

Correct. There can be a fatal IOMCA which is asynchronous and can fire
anytime. We removed any CPU initiated async errors like patrol-scrub and
cache errors observed during eviction (EWB) into CMCI's when we developed
LMCE.

> 
> > What we do here by setting MCIP=1, we promote to a more severe shutdown.
> 
> It probably should say somewhere that a shutdown is possible. Because if
> the shutdown really happens, you get a black screen and no info as to
> why...

You will find out when system returns after reboot and hopefully wasn't
promoted to a cold-boot which will loose MCE banks.

I can check with the HW team and get back.. 

> 
> > Ideally I would rather let the fallout happen since its observable vs a
> > blind shutdown is what we are promoting to.
> 
> What fallout do you mean exactly?

Meaning deal with the effect of a really rare MCE. Rather than trying to
avoid it. Taking the MCE is more important than finishing the update,
and loosing what the error signaled was trying to convey.

> 
> > Shutdown, shutdown.. There is only 1 MCE no matter how many CPUs you have.
> 
> Because all CPUs are executing the loop? Or how do you decide this?

Fatal errors signaled with PCC=1 in the MCAx.STATUS is *ALWAYS*
broadcast[1] to all CPUs in the system. So MCIP is set at the source of
the CPU and if any other CPU is also attempting they go down. You can't
even collect data.

[1] Broadcast is true for Intel CPUs, its legacy behavior
LMCE is the only one that isn't broadcast and truly local to the logical
thread.


> 
> > Exception is the Local MCE which is recoverable, but only to user space.
> > 
> > If you get an error in the atomic we are polling, its a fatal error since
> > SW can't recover and we shutdown.
> 
> Aha, I think you mean that: the MCE is fatal because if it happens on
> any CPU, it will be in kernel mode.

Yep!

> 
> > Overthinking :-).. If there is concensus, if Boris feels comfortable
> > enough, i would drop this patch.
> 
> This is what we're doing right now - thinking about the consensus. And
> Boris will feel comfortable once we've arrived at a sensible decision.
> 
> :-)
> 
I'm waiting for the results. :-).  And if you feel we can merge the
- Patch1 - bug fix 
- Patch2 - min-rev id

I do have the comments from Ingo captured, but I'll wait for other comments
before i resend just those 2 and we can leave the NMI handling to get more
testing and review before we consider.

Cheers,
Ashok
