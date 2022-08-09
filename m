Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F10B58E33B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiHIWdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHIWdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:33:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2D465645
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660084395; x=1691620395;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Yrkb4EzezQjbUg4VIAQOqKNBYy6TLB5hiojvvufvI7A=;
  b=MMzR9IY250N1VNbRlLyYWJeOTtADHmwd1c0HiMGmBj2Hwx9dP8xsEUzv
   yBRH8Z60l4DBO0Upm+kAdm1YUUgWZLAkGakJ2kEtw2VozS+BHmfR4Hacz
   3sYg+3eh6AS9bigSQA6IDTWEnXThH2NYVFYIlcYtvDjGrhvaHNqsf8xGa
   uZMp1qTRARj9XNsZujy2t3xGd/MZee5UYBnyHoJuWWUtqLtmAIqeWMP+m
   GBNYYr72V8yTpuFQlZptGDBGb1tYjiqnJmoXiRukhSuYTiEZylM7jCL6F
   Lpj3wyjYjAqpA35S9LeSt5K7E776HbeAoSXyVjxgv9PmiQqBTdxuN7cyH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="292195849"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="292195849"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 15:33:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="555508425"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 09 Aug 2022 15:33:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 15:33:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 15:33:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 15:33:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 9 Aug 2022 15:33:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwiK1alsjo3RLy0wdGuUTTAF3TbDP5VHynxfDPnNuImh6Lis9hz0We4bYatDJ07bL+mH25WEN5ppDr4cSfp1SzVDc/tK7nlDtuDjdBa9rHQWonBQu2KwhbCIgg55ktvbUMb7qLttDzpDpKfw8T+miwJ8BS6bc0dfGgjBUzBZ/lMXP34kO//IdHIyyRUD4HKs6lEywcmcMDgMbgCg6A9Ea7fQw7b5kTCyd3b4LL067CsUWZOWekOVZonPabh28nLwy/9URqvOTwa2KS9ADr9mpwmSmxSdrY1CLYz1GAQB09FMHKnlv8zExItOVgK+giKC97Y6+Oc4c7ZckxyIb0aa0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1K3oitAwlHfN7dPIiN4rOY7Vms9nCu+YBsGyw+2Sv4w=;
 b=JJ8e2/q3V/d7dW6fC8p6GKhr7B63NIQ5NL7E/EmTabZsmv9jmSe/e+MZPVGJyiUJD3b3aJg1SP+vum0aw+EJfGrXXyCuvtwdtkMIwguwUmsojuc4algdnNqueQLT7sPsY/52Ap4dZLnw315qPBsQNe3hG/E2vR577mhBAwZl241zY7YcPfxtRZfB3uXLS2rsXHI+1cqn258TGQ4u6YWBxyQjLkLYl3JNuKLLvLrQQ+osi8iQUjR9TkMGqwvASV3R8pQSC+x51fUv8UOFqnLWtOsF2xHPlqx5X2zMtSXGxgwrvrpkaU+soeJ3Ie5Q3YHQKv9/ekm1AuPjWQeGf/fQuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 MN2PR11MB3853.namprd11.prod.outlook.com (2603:10b6:208:ea::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Tue, 9 Aug 2022 22:33:10 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058%3]) with mapi id 15.20.5504.019; Tue, 9 Aug 2022
 22:33:10 +0000
Date:   Tue, 9 Aug 2022 15:33:05 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [RFC PATCH 2/5] entry: Add calls for save/restore auxiliary
 pt_regs
Message-ID: <YvLgoZyyZp5pkGkk@iweiny-desk3>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-3-ira.weiny@intel.com>
 <YvJNe2rzXfcogFFX@zn.tnic>
 <YvKpi/CVHko50PNQ@iweiny-desk3>
 <YvKsS3QuOu4JVzZU@zn.tnic>
 <87lerxqfv8.ffs@tglx>
 <YvLT6FipPdSkCW/6@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YvLT6FipPdSkCW/6@zn.tnic>
X-ClientProxiedBy: SJ0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::8) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a58415f-4579-43ba-af58-08da7a572379
X-MS-TrafficTypeDiagnostic: MN2PR11MB3853:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ezLVWlCzkZ196HjztgLYGcGqO+GfUyYlNo1syYRni8n5tnkGKo/8WKKGSG/7ibX8lKffl64jn0tDjvL9sJXv95rbvQegH50gPbPdC7zOQ6r+UyCTgQGh5NOOQaJFNCOeQ5k9p3jpSo9SCPAa8UaxoficxokgaLrneeNsVDNGpVbDU3MAVKnhW/+x57RQhMeaIaG801pvCTCYuS+CyxUbCEC8dFopLItObcspJNMekmIyClk7jCiJezq0GcKxv+ZDsLCpQlwW8XjLTvDkqoBc0hNJs1YJ60G57aWBVc6lm9CQcT8NoRCp++2AIpZ91EPAN4B0bBsZcJM6nIXDBOtILKMttB2YnAWAimC0LAw1dnQfXQ36Hc2M9ehq27NiLeRTN1MMdbVAgOxXE1Avsk5ttKC8e3LtzHE/BYL92jw06cNj3CKGcnku1Ol7OUe6Dg75KOcg0kTC/QsRbUhvykn1NEdNLAktWS5OF6yGG/p9hypdxcl+uOxS6NP4/oi+X0Q23+anxPZhZO/+epPNsPwuLQMc2SaA/M1mxr7UAIi91Dluv+Mn8PtLcNejbvHaUMYl5R0oizNY9YDW7WbUv646xGPlb3DSB/K9Sl/zv5z8742d9bCKQGjwnUQTPzDzl2/AiGrPbBSVCqN+B5c7zQe8+7Wf9OSrgzJxY8EL79z7v+/3aFf8hZJl3e1fH4KEMQN/9ORAI+aEMcXqA5BKLVSc8h3MwIiuweu6A/W+Vw8yWCc3ZPEiDjN/uN4tkXEEJ8gz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(376002)(136003)(39860400002)(366004)(396003)(6506007)(6512007)(26005)(9686003)(2906002)(41300700001)(6666004)(316002)(38100700002)(33716001)(86362001)(44832011)(8936002)(5660300002)(4326008)(8676002)(66476007)(66556008)(66946007)(6486002)(82960400001)(478600001)(83380400001)(186003)(6916009)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UgYjkS2VVfXNevG7jWhTlnT3lhy56WBmzKFCWg9w+cruGVAvlWrnd3gP/bgt?=
 =?us-ascii?Q?CSIMWRLZq79eLxmKoixJb6hy3CS3rxEW3YSafXIYb/glIwEMeCEL5EIJatDv?=
 =?us-ascii?Q?ozCquNX/LBI2+jhfkeUJEPvk+so9aOTwJxHO/YBJi277ZFfGtnJFtYZpwhnt?=
 =?us-ascii?Q?gCSh1GGyGohJVbOKjzgFaDSoLquYHYOmAsQ+wD7KgAIM7qTo2TWvRQXWdNcM?=
 =?us-ascii?Q?Lm0HNX8buoUbYSdby8cGsY+XioyoiNz1FP3uIy2iBTYVPh+yULd5EO9P9mAt?=
 =?us-ascii?Q?S0JJBAhUxd0ZaI3/5tPC42FXwdB8haLg5ox6B59iB5pl6a2difEBzNiyRwQb?=
 =?us-ascii?Q?08Bv4fkGB8Hd1qqZIU5G1O2Xm7RHaUnNIsO5kp4+Um5S3rSzc1xbRvaWOV+W?=
 =?us-ascii?Q?FH6hb2h/fSMbo3Jg+KpE6kZxwvI33JMu+itkKK0a2k08f/SWm7FnDmpsjcEv?=
 =?us-ascii?Q?Ohu1WjkwEGtpnfoPRDWk2e95x/BHH7P/pV0pAdy+4HuO0e6TYstaZ2QNl44V?=
 =?us-ascii?Q?HHDxAlUSOOR9SNqtWZ8TzEoGX1hY9MislMd/A+a3TCk55/9FWxo6u7NF4bA5?=
 =?us-ascii?Q?VB0awR6Qz1cM0oy3FFcc2zGVSvdyPLZpSrSBaRTKOjDo4WDa9W7NLiur6Q2O?=
 =?us-ascii?Q?KjT92la9KTXAT9I6zcg3aQ8TD59Tw/lGF8iLkC12GTw+GCJLBrcePu2djBn/?=
 =?us-ascii?Q?8S0Qcb0Hy8rZ/PwbbIffZRMoHw4hwdIbH2R8lyz3ZrzVWjrjBbOvjbmQbiI8?=
 =?us-ascii?Q?bJoewKQLu41KBy0ZSehn56QPPhuiETXs3v2weunaPV9QVIMVyz7pZSb5vUwl?=
 =?us-ascii?Q?JIVnzv3PoqmFVjh8KPj3Fb4wqu84HwEOT083whLb5H/D5y2Y1kC/3j+oISSC?=
 =?us-ascii?Q?Go9RucSG6bpbdbA9mtxvb1QHJG+RQTGS9hdkIvxiwjmNt3BypOPKlFeItbtg?=
 =?us-ascii?Q?ya6RFMM9udtShN7KQdM+KVjgdVw8LciP6cpFjNdiDbQmQmJW1o8FEy1g16jG?=
 =?us-ascii?Q?48bSolhxIY4kwXTliJv8hwJ6ez8zMzKxE81Ku1W3z55DhZQ306iJLBZGS0mY?=
 =?us-ascii?Q?Y10Dkwh3T6P2okeaGDAdj8bVRy5SE5SOw8pWTaw69qjpkSz16TRr1cd+EXIZ?=
 =?us-ascii?Q?vQ/03R7k5y6HbNcGxxEYrJySuT4rr5d2r+GmSKj0qV63TtA1kHbXJSkJHA34?=
 =?us-ascii?Q?DA2v2erUfNa6PpJ38gC2iZgF9G3M2yv/zaSgK2JdUIUbDKH4cEIHlt96FSGf?=
 =?us-ascii?Q?6itXfq2G98uCrmQ6WwPJ8B33muW70pYiCWdZtYcQ/bS6cYRFCDKGgLbowiHP?=
 =?us-ascii?Q?+bquAt5IDCWITNAarCEJOkcVZX2ENKaKBPvgip5av7/yuDHbMnZPMcD3JRvg?=
 =?us-ascii?Q?+wur4rBIunhgVEXVzsL6dYDVI5xgHtrO7Hw10IeJcEmrmmsmhvtEqNrt8vAr?=
 =?us-ascii?Q?e2LwLWhALj3V0EHmmVwwsCKSv1bz4qk2anJnv0AFHC/ugVsXW8pfIXhF33yE?=
 =?us-ascii?Q?0Ek/ew8NyHva47i2bY59uOFmMbeGo3KolKzvRWSBRCIxOEmpko2luITwzHgU?=
 =?us-ascii?Q?e09YK7Ly/GG01u2ZhH6XaNDxQ0hUX/qMkuOCsB+iuI0RtUeSUrvAKAkXfPvH?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a58415f-4579-43ba-af58-08da7a572379
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 22:33:10.4298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmk8YIXi0HLIPAuM1OEwDdmMfFUeuac+xQPt6GQ8x8gk3+rwGjSqK/kMJs+WKgFuNaA9ljTSoY8SzYBeODU0rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3853
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

On Tue, Aug 09, 2022 at 11:38:48PM +0200, Borislav Petkov wrote:
> On Tue, Aug 09, 2022 at 11:14:19PM +0200, Thomas Gleixner wrote:
> > Ira is right. If we want it for everything, then the generic code is the
> > right place.
> 
> But what is "everything"? Currently, and AFAIU, it is for the PKS use
> case on x86 only.
> 
> I'm not saying it should not be done this way eventually - all I'm
> saying is we should not design "preemptively" before it is really needed
> for other arches.
> 
> Unless putting it in generic code makes it all simpler and cleaner to
> do, that is.

For the cpu use case we could limit the number of call sites.  However, for PKS
the patch would have required changing x86 code in approximately 9 places for
the enter code.

$ git grep 'irqentry_enter(regs)' arch/x86 | wc -l
9

How about we drop patch 1 (I'll rework it to be less churn and submit it for
clean up separately because it will no longer be needed).  Keep patch 3 as is.
Then combine 2 and 5 as below.  The saving of the CPU can be lifted later if
needed.

Ira


commit 4c1d646888dd7471ae71a24109d587901a00f87d                                 
Author: Ira Weiny <ira.weiny@intel.com>                                         
Date:   Mon Jan 10 15:06:07 2022 -0800                                          
                                                                                
    x86/entry: Store CPU info on exception entry                                
                                                                                
    x86 has auxiliary pt_regs space available to store information on the       
    stack during exceptions.  This information is easier to obtain and store    
    within C code.                                                              
                                                                                
    The CPU information of a page fault is useful in determining where bad      
    CPUs are in a large data center.                                            
                                                                                
    Define aux_pt_regs_save_cpu() and set ARCH_HAS_PTREGS_AUXILIARY default     
    to yes.                                                                     
                                                                                
    Store the CPU on page fault entry and use it later.                         
                                                                                
    Cc: Rik van Riel <riel@surriel.com>                                         
    Suggested-by: Borislav Petkov <bp@alien8.de>                                
    Suggested-by: Dave Hansen <dave.hansen@intel.com>                           
    Suggested-by: Thomas Gleixner <tglx@linutronix.de>                          
    Signed-off-by: Ira Weiny <ira.weiny@intel.com>                              
                                                                                
    ---                                                                         
    Changes from RFC:                                                           
            New patch combining 2 and 5 from original series and modified.      
            Boris/Thomas - eliminate generic calls to save the cpu and call     
            only from exc_page_fault                                            
                                                                                
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig                                
index b35f6a472e09..707650a6ecb2 100644                                         
--- a/arch/x86/Kconfig                                                          
+++ b/arch/x86/Kconfig                                                          
@@ -1876,7 +1876,7 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS                   
                                                                                
 config ARCH_HAS_PTREGS_AUXILIARY                                               
        depends on X86_64                                                       
-       bool                                                                    
+       def_bool y                                                              
                                                                                
 choice                                                                         
        prompt "TSX enable mode"                                                
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h      
index 5a9c85893459..b403b469996f 100644                                         
--- a/arch/x86/include/asm/ptrace.h                                             
+++ b/arch/x86/include/asm/ptrace.h                                             
@@ -97,6 +97,7 @@ struct pt_regs {                                              
  * ARCH_HAS_PTREGS_AUXILIARY.  Failure to do so will result in a build failure.
  */                                                                            
 struct pt_regs_auxiliary {                                                     
+       int cpu;                                                                
 };                                                                             
                                                                                
 struct pt_regs_extended {                                                      
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c                          
index 82cf23975aa1..b9b8344b69ad 100644                                         
--- a/arch/x86/mm/fault.c                                                       
+++ b/arch/x86/mm/fault.c                                                       
@@ -768,9 +768,9 @@ static inline void                                          
 show_signal_msg(struct pt_regs *regs, unsigned long error_code,                
                unsigned long address, struct task_struct *tsk)                 
 {                                                                              
+       struct pt_regs_auxiliary *aux_pt_regs = &to_extended_pt_regs(regs)->aux;
        const char *loglvl = task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG;     
-       /* This is a racy snapshot, but it's better than nothing. */            
-       int cpu = raw_smp_processor_id();                                       
+       int cpu = aux_pt_regs->cpu;                                             
                                                                                
        if (!unhandled_signal(tsk, SIGSEGV))                                    
                return;                                                         
@@ -1503,6 +1503,13 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
        }                                                                       
 }                                                                              
                                                                                
+static void aux_pt_regs_save_cpu(struct pt_regs *regs)                         
+{                                                                              
+       struct pt_regs_auxiliary *aux_pt_regs = &to_extended_pt_regs(regs)->aux;
+                                                                               
+       aux_pt_regs->cpu = raw_smp_processor_id();                              
+}                                                                              
+                                                                               
 DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)                                  
 {                                                                              
        unsigned long address = read_cr2();                                     
@@ -1546,6 +1553,7 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)             
         */                                                                     
        state = irqentry_enter(regs);                                           
                                                                                
+       aux_pt_regs_save_cpu(regs);                                             
        instrumentation_begin();                                                
        handle_page_fault(regs, error_code, address);                           
        instrumentation_end();                                                  
