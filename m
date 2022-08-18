Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0078597DDD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 07:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242691AbiHRFEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 01:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbiHRFEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 01:04:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1484F9F18E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 22:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660799077; x=1692335077;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MBQsIqotgaTfW/90fLMlsLIFBZ2tbx9QGn/DOW8t8d4=;
  b=M0ssVGStxc+J47jz6v9I89yB/ck7hrsH4srdIdfX/VKsWoVIA0lcQzBv
   ZMtRpsDZfT+7AS139ENxng+GJ+Y804LRQzAPFTaqHWPSLHolbfOEXTYEA
   WD8GpR0rfcXpzVfpl7NQ0T3JfCFa8gUIVal/XMmpJwJeWm4opWod9HOeX
   tG8OUwSvekkRZW0i2J0F0pNYmK/JvF9b7uJrQun8xhhgDX3Ur9q12nS/f
   JAQzeG0lxXZ/5txYZaAYUUP6ljh0uXxhyTPz8EXe1QdCbQzdV+kMPI8o+
   11MpxoeNQCwXJNuvaM/+s5jYpCv6/7Sy6snzJBP3ZJSso0r/VXYhMs7Lg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="272432670"
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="272432670"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 22:04:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,245,1654585200"; 
   d="scan'208";a="697031271"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2022 22:04:28 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 22:04:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 22:04:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 22:04:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfyTCaOpPM1ZJiZ3rwIz5Jtiijlcu4TJh4YZBrfRoo56AMYOnmij54HZQS7CWu4UXBdhDVMbLnqocnExOrg6HOtjLGx3yTEcyeJ+feT4JSG0fyy8Qc20AR+ndDnonVNJ1aaQarv/mybn4B7E+6I1vuy92KsFY6tCJqzNUvHWeogT5mXNdX3SJFjhpM0y2pCiendO3OUxY7AK0Gb9duECDAsd7Vbao9t0za+8WBYpdOjRmhGLbBoNO3NOs489T7xHBsPLcP7oW0Lv63BrQkBL127AKbi45NdXvc2uLj+G+6Lqt/jQpjAC37WMUlj6HdpdYlkw+NkY0r+UWRL5H2gMVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XK39pCFOtkHfSNlGeeU+Grwu3epHTqhu8tjGm0Za/k=;
 b=SwnKsP03Rwzki2p7XBrN16BEc1szS+HbEcej8/IimOv4Hc9gZwzIqQOfHAReWJWElRzZxkfMSpPMsUb/0AUcJEBX/Q15+/02KoJMzKGhk7ez1gkkbFKFsohaD/nn8MRKcXG77Schs3aZRSDV+twBJtwoW4ue8ZCSQ+C6h8hSyRNTP8gnyB5dMo21QOZ7qSJRhZA7M0OUTCG+frmKlVvq/tbwLel+PAqyoRVItVNJZwUr6oT3nRbDEpPgMvg5a5F/q0+dhH8yd2QXeJ7dkmP9D2eDOKJ7I9fWR6ZCPSRGS1eZ4YaZusbvC4VwsowVCtXGUpB12LFtT/oMKRcJWLjuKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH7PR11MB6770.namprd11.prod.outlook.com (2603:10b6:510:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 18 Aug
 2022 05:04:12 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::503e:4a34:50bc:9f4]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::503e:4a34:50bc:9f4%6]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 05:04:12 +0000
Date:   Thu, 18 Aug 2022 13:04:04 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Su, Heng" <heng.su@intel.com>, <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, <pbonzini@redhat.com>,
        <x86@kernel.org>
Subject: Re: [PATCH] x86/kvm, objtool: Avoid fastop ENDBR from being sealed
Message-ID: <Yv3IRNKsTfF5IwvX@xpf.sh.intel.com>
References: <PH0PR11MB4839B4D2FB8B8D8D52A62C7F9A629@PH0PR11MB4839.namprd11.prod.outlook.com>
 <YvzJTxOwmikAlZ6j@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YvzJTxOwmikAlZ6j@worktop.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR01CA0144.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::24) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5364523e-fb9e-49a4-3540-08da80d716fb
X-MS-TrafficTypeDiagnostic: PH7PR11MB6770:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jQt2C6YT6DVZ7GD9u0yvfW5SeU4kQ0LcHKi6Wo0ZC0tSBi0RNfCpHh139h3nnt5dH4Gx0apJWuHFjSjZLLTMVDgQz0kFCEa1awBM4l50wCs2c5zjYkcIqhVnxn7H2CHU6XwOjKJglw63YCXpAE/bhuY1dKEwzOJn9Ru5sH8ZFxTriTMRC5z5nUP9YoSmhpDpotDcUmo7IJKAfzxFgx0OSegs0905N7pg688vP7wh4LUQn0raRfXGB5bW1CjhwTEAndlZfl8c71upHG2rHLipMFzqv8ScS3EAq6ZwxFoswBOEmB2Vmcg5T93+smuT4dfgRlNvqjZVEdB4Ru0PBpt+6xsf9HAkRgRlb5xshN+50wYa6B+i2/TA3NGUvBMsu8HjK0KEX46x6Mhhpdy4HOgGA+22xjEbcxdiUZ0598khxDH7RtYZcC6L0iTflmtHOxmRU5uJC8BDC6hC/5RO7J33HAutXkYh1PN7enuurr3NqobTprSPpl0csc8GZF8AZKQYmLVQB+toT5LlX3hx46xhPf/8hSTrtqzyRvUjLeR1Lx0m2zXqu3nmjUtqDrEBijMb0LZMmxBc28gHVeKyz/ej+0HFSNhNrKic4uOacSmdqXzl9Q9mmLKWmdMHSVktOy4MypoDdkrJG4DzZBNFQ5nTSs9sPjR+/xvnc4GmIptMk8ae7uCNvoZMxmCCcIcLZXA91InTxtOwPbv18QuKJ6t2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(366004)(346002)(376002)(39860400002)(44832011)(316002)(66556008)(53546011)(41300700001)(83380400001)(6666004)(6916009)(66946007)(4326008)(8676002)(2906002)(54906003)(186003)(38100700002)(26005)(82960400001)(6512007)(66476007)(478600001)(86362001)(6486002)(8936002)(5660300002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fsnHxl2ECRsswxB89FoDPcd2wJizSQ3zpg+Y3Mk5wKMh7Whf57Detqf9rVCr?=
 =?us-ascii?Q?2LZhhnWsuH5iU/3YaoztyAeCT/RRvtinHhWkJcWYN3818TISwFcf839UdUir?=
 =?us-ascii?Q?tbka5/5Zx5tYxo/xsKc22ihuR4bzsamb+hXM0qz78aCIZvwMczL4ym1ILfGc?=
 =?us-ascii?Q?S71Qmf9zEzUHOzfQqJm0U8m9ELGIJTPfTeFIrcmA0qNztRxeq6010YtNglCq?=
 =?us-ascii?Q?SCcDJ0Y3F7u/tXK7/kmwxZhn3jJk2KWhzJLXikyBe+EjipjA+hcGp8i1M0f2?=
 =?us-ascii?Q?zEVXIEXXBm+nfY4pRGlI5nc9+baHuAMRiHjEgO79U0joLF06buDI/+LSCRjY?=
 =?us-ascii?Q?DriOZsQqZuLOWKPKH4BXGTGDJxSt+tposvsVYFRv9T7nach7br3eV+rW/unC?=
 =?us-ascii?Q?EmZX1rHWh/e1qL1Rub6kakbJk5KBa4obg9qO8ociqKlJBITXg/txJMTvut79?=
 =?us-ascii?Q?WIdG4FUMGK0Wflav5PU8/GzmZeIel4X2pyyTe/YSOCsfSoJ5tX492470Ia0G?=
 =?us-ascii?Q?xELOTdJz3uAlN3VwFJ8jhVOVQCrkdGAFRaIeHwGQvlZhy7A7oExTIMRae7gK?=
 =?us-ascii?Q?tA/gyAew2gxHmk+n0D1w++IKq9c2VwF0zkGKson3nG+Bq++e0SOeFO7k17ZH?=
 =?us-ascii?Q?220pD9savZFm6RSBjL3gPVJHu+8/E5hcZBF4hDEQIBZAg/EyRAeEiqcU8eEe?=
 =?us-ascii?Q?yWvlqej1jJGUkeOJpud2U7Po56XgdSxXUMOUP/YzG1+J6ojrLbGLr2gA3Sd3?=
 =?us-ascii?Q?CIQlfgQsb9Td/Uzi4tlA/HNv/v2i/ybxES/l7Vkhlem5TlKcBpQpIXN0S35r?=
 =?us-ascii?Q?kWDvbSwmmYzkVCRbdL7vUU3cwD9yiuy+tdehG2C8LVYROe81K20l/GTXrOus?=
 =?us-ascii?Q?wmxFgns8LG3AAV+al3wunxwQi3AtzBPArL2X62IPvMpdNOzNMRaY5/Y3LiLb?=
 =?us-ascii?Q?yMw5hzChoKaQR07AnvLX/CFMMmP1PwhKPRoyDdmw2D9Gi2Bpg2aAU/ot8OTy?=
 =?us-ascii?Q?+nx9O/mdLBIL3t3RLf6cFH1w21qapagqpMriMM1tJ+UMPJ9qG4JMhtm3E6T2?=
 =?us-ascii?Q?V15RpmJojfspkR21zlslFkgSQEnIkOo8HXZavfdFtChLEt8MFtCHb9xArMxc?=
 =?us-ascii?Q?uK9xu0OQ3ceZ8PYcRaWxyxcM2CWJ3U+yYrLD2TL0Ta7jiqFK5SvJt7x2J4NT?=
 =?us-ascii?Q?z35+bLbs06pVH0YxEmwiDdfGL0lYxIOYFK4GpI9GeTO6Zskefq+EVB4oVEFy?=
 =?us-ascii?Q?ECVSi/ekQDyWdqZzZjjjJyxo4MnlAwNRIXcxLoCLJ2s9+3tEEYgqtdAR3Im0?=
 =?us-ascii?Q?ged6QhvLgDUfoSg1qYzHw/hC3HevzyFLLvYLeaauK3cnw5uyxsDzH8T4gd64?=
 =?us-ascii?Q?oa9JtbQMBBJ3sirT2dRRYtsO1L3CGmKLWMf6Zo9EN7nOuZCjERpwT26Pc+n6?=
 =?us-ascii?Q?IbQ0cciXvvokNjFwwkcV/2k+pDeKcL2gW7Quy+iegYsFR/IURayZmixifRnt?=
 =?us-ascii?Q?0h9reoJgj9zYHpj5XiFHABcf7xNohoFrlVaHOufwblKGDxiQ7vf7eI5Ctyt6?=
 =?us-ascii?Q?gebeFfOiCbP5f8scRaJppuzp64EX6IFefmOimhej?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5364523e-fb9e-49a4-3540-08da80d716fb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 05:04:11.9949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bu1+pzZ71usmhcFCCiLojgpZ93rlIYhaRxJWrOe4AFtKlomtHGTVsTviqFDvgxszk54qR4fT7t7rLwmZcd+X3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6770
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2022-08-17 at 12:56:15 +0200, Peter Zijlstra wrote:
> On Tue, Aug 09, 2022 at 02:44:28AM +0000, Xu, Pengfei wrote:
> > Hi Peter,
> > 
> > Greeting!
> 
> You again forgot to Cc LKML and relevant people...
  Ah, I will Cc LKML and relevant people if I report new issue next time.

  I have tested your patch, and I could not rerproduce this issue
  when starting the syzkaller test for more than 6 hours.

  And I will test Josh Poimboeuf's patch, will update email if I find
  some problem.

  Thanks!
  BR.

> 
> > Platform: ADL-P (I tried that TGL-H could reproduce this issue also)
> > Kernel: 5.19 mainline kernel with kernel IBT enabled.
> > 
> > Boot up ADL-P,  and then run syzkaller fuzzing tests, syzkaller will start up guests(Guest kernel is 5.19 mainline also but doesn't enable kernel IBT) to do fuzzing tests.
> > After about 1 hour later,  there was "traps: Missing ENDBR: andw_ax_dx+0x0/0x10 [kvm]" info generated.
> > 
> > [ 5048.057266] traps: Missing ENDBR: andw_ax_dx+0x0/0x10 [kvm]
> > [ 5048.057440] ------------[ cut here ]------------
> > [ 5048.057457] kernel BUG at arch/x86/kernel/traps.c:253!
> > [ 5048.057482] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > [ 5048.057908]  <TASK>
> > [ 5048.057919]  asm_exc_control_protection+0x2b/0x30
> > [ 5048.057940] RIP: 0010:andw_ax_dx+0x0/0x10 [kvm]
> > [ 5048.057999] Code: c3 cc cc cc cc 0f 1f 44 00 00 66 0f 1f 00 48 19 d0 c3 cc cc cc cc 0f 1f 40 00 f3 0f 1e fa 20 d0 c3 cc cc cc cc 0f 1f 44 00 00 <66> 0f 1f 00 66 21 d0 c3 cc cc cc cc 0f 1f 40 00 66 0f 1f 00 21 d0
> > ...
> > [ 5048.058209]  ? andb_al_dl+0x10/0x10 [kvm]
> > [ 5048.058265]  ? fastop+0x5d/0xa0 [kvm]
> > [ 5048.058320]  x86_emulate_insn+0x822/0x1060 [kvm]
> > [ 5048.058376]  x86_emulate_instruction+0x46f/0x750 [kvm]
> > [ 5048.058433]  complete_emulated_mmio+0x216/0x2c0 [kvm]
> > [ 5048.058488]  kvm_arch_vcpu_ioctl_run+0x604/0x650 [kvm]
> > [ 5048.058543]  kvm_vcpu_ioctl+0x2f4/0x6b0 [kvm]
> > [ 5048.058590]  ? wake_up_q+0xa0/0xa0
> > ...
> > [ 6324.778942] traps: Missing ENDBR: andw_ax_dx+0x0/0x10 [kvm]
> > ...
> > [ 8760.430810] traps: Missing ENDBR: andw_ax_dx+0x0/0x10 [kvm]
> 
> Urgh, fastops again :/
> 
> > Dmesg and all the ko files  in "/lib/modules/5.19.0-m2/kernel/arch/x86" are in attached.
> 
> From your kvm.ko:
> 
> 00000000000376f0 <andw_ax_dx>:
>    376f0:       f3 0f 1e fa             endbr64
>    376f4:       66 21 d0                and    %dx,%ax
>    376f7:       e9 00 00 00 00          jmp    376fc <andw_ax_dx+0xc>   376f8: R_X86_64_PLT32   __x86_return_thunk-0x4
>    376fc:       0f 1f 40 00             nopl   0x0(%rax)
> 
> However, the Code: thing above gives:
> 
>   2a:*  66 0f 1f 00             nopw   (%rax)           <-- trapping instruction
>   2e:   66 21 d0                and    %dx,%ax
>   31:   c3                      ret
>   32:   cc                      int3
>   33:   cc                      int3
>   34:   cc                      int3
>   35:   cc                      int3
>   36:   0f 1f 40 00             nopl   0x0(%rax)
> 
> From that we can tell gen_endbr_poison() has been used to scribble the
> endbr -- so clearly objtool didn't manage to find code references here.
> 
> And indeed, kvm.ko's .rela.ibt_endbr_seal section includes:
> 
> 00000000000002c0  0000000100000002 R_X86_64_PC32          0000000000000000 .text + 376f0
> 
> ---
> Subject: x86/kvm, objtool: Avoid fastop ENDBR from being sealed
> 
> Xu reported a number of "Missing ENDBR" triggers for the KVM fastop
> emulation code. It turns out that because of how the fastops are set up,
> only the first of a series -- the 8 byte variants that overlap with the
> em_ symbols -- is found referenced.
> 
> Specifically:
> 
>         .pushsection .text, "ax"
>         .global em_and
>         .align 16
>         em_and:
>         .align 16
>         .type andb_al_dl, @function
>         andb_al_dl:
>         endbr64
>         andb %dl, %al
>         11: jmp __x86_return_thunk
>         .size andb_al_dl, .-andb_al_dl
>         .align 16
>         .type andw_ax_dx, @function
>         andw_ax_dx:
>         endbr64
>         andw %dx, %ax
>         11: jmp __x86_return_thunk
>         .size andw_ax_dx, .-andw_ax_dx
>         .align 16
>         .type andl_eax_edx, @function
>         andl_eax_edx:
>         endbr64
>         andl %edx, %eax
>         11: jmp __x86_return_thunk
>         .size andl_eax_edx, .-andl_eax_edx
>         .align 16
>         .type andq_rax_rdx, @function
>         andq_rax_rdx:
>         endbr64
>         andq %rdx, %rax
>         11: jmp __x86_return_thunk
>         .size andq_rax_rdx, .-andq_rax_rdx
>         .popsection
> 
> Only has the em_and symbol referenced, resulting in and{w,l,q}_* getting
> sealed.
> 
> Add (yet another) annotation to inhibit objtool from sealing a specific
> ENDBR instance.
> 
> Fixes: 6649fa876da4 ("x86/ibt,kvm: Add ENDBR to fastops")
> Reported-by: "Xu, Pengfei" <pengfei.xu@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/ibt.h |  5 +++++
>  arch/x86/kvm/emulate.c     |  4 ++--
>  include/linux/objtool.h    |  6 ++++++
>  tools/objtool/check.c      | 44 ++++++++++++++++++++++++++++++++++++++------
>  4 files changed, 51 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
> index 689880eca9ba..f32ba1c4e619 100644
> --- a/arch/x86/include/asm/ibt.h
> +++ b/arch/x86/include/asm/ibt.h
> @@ -29,6 +29,10 @@
>  #define ASM_ENDBR	"endbr32\n\t"
>  #endif
>  
> +#define ASM_ENDBR_NOSEAL	\
> +	ANNOTATE_NOSEAL		\
> +	ASM_ENDBR
> +
>  #define __noendbr	__attribute__((nocf_check))
>  
>  static inline __attribute_const__ u32 gen_endbr(void)
> @@ -84,6 +88,7 @@ extern __noendbr void ibt_restore(u64 save);
>  #ifndef __ASSEMBLY__
>  
>  #define ASM_ENDBR
> +#define ASM_ENDBR_NOSEAL
>  
>  #define __noendbr
>  
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index b4eeb7c75dfa..d51ee8a3bcae 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -326,7 +326,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
>  	".align " __stringify(FASTOP_SIZE) " \n\t" \
>  	".type " name ", @function \n\t" \
>  	name ":\n\t" \
> -	ASM_ENDBR
> +	ASM_ENDBR_NOSEAL
>  
>  #define FOP_FUNC(name) \
>  	__FOP_FUNC(#name)
> @@ -461,7 +461,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
>  	".align " __stringify(SETCC_ALIGN) " \n\t" \
>  	".type " #op ", @function \n\t" \
>  	#op ": \n\t" \
> -	ASM_ENDBR \
> +	ASM_ENDBR_NOSEAL \
>  	#op " %al \n\t" \
>  	__FOP_RET(#op) \
>  	".skip " __stringify(SETCC_ALIGN) " - (.-" #op "), 0xcc \n\t"
> diff --git a/include/linux/objtool.h b/include/linux/objtool.h
> index 62c54ffbeeaa..ad752f8b3b36 100644
> --- a/include/linux/objtool.h
> +++ b/include/linux/objtool.h
> @@ -90,6 +90,12 @@ struct unwind_hint {
>  	_ASM_PTR " 986b\n\t"					\
>  	".popsection\n\t"
>  
> +#define ANNOTATE_NOSEAL						\
> +	"986: \n\t"						\
> +	".pushsection .discard.noseal\n\t"			\
> +	_ASM_PTR " 986b\n\t"					\
> +	".popsection\n\t"
> +
>  #define ASM_REACHABLE							\
>  	"998:\n\t"							\
>  	".pushsection .discard.reachable\n\t"				\
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 0cec74da7ffe..0d04d0a707f4 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2111,6 +2111,40 @@ static int read_noendbr_hints(struct objtool_file *file)
>  	return 0;
>  }
>  
> +static void mark_endbr_used(struct instruction *insn)
> +{
> +	if (!list_empty(&insn->call_node))
> +		list_del_init(&insn->call_node);
> +}
> +
> +static int read_noseal_hints(struct objtool_file *file)
> +{
> +	struct section *sec;
> +	struct instruction *insn;
> +	struct reloc *reloc;
> +
> +	sec = find_section_by_name(file->elf, ".rela.discard.noseal");
> +	if (!sec)
> +		return 0;
> +
> +	list_for_each_entry(reloc, &sec->reloc_list, list) {
> +		insn = find_insn(file, reloc->sym->sec, reloc->sym->offset + reloc->addend);
> +		if (!insn) {
> +			WARN("bad .discard.noseal entry");
> +			return -1;
> +		}
> +
> +		if (insn->type != INSN_ENDBR) {
> +			WARN_FUNC("ANNOTATE_NOSEAL not on ENDBR", insn->sec, insn->offset);
> +			continue;
> +		}
> +
> +		mark_endbr_used(insn);
> +	}
> +
> +	return 0;
> +}
> +
>  static int read_retpoline_hints(struct objtool_file *file)
>  {
>  	struct section *sec;
> @@ -2356,6 +2390,10 @@ static int decode_sections(struct objtool_file *file)
>  	if (ret)
>  		return ret;
>  
> +	ret = read_noseal_hints(file);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * Must be before add_{jump_call}_destination.
>  	 */
> @@ -3952,12 +3990,6 @@ static int validate_functions(struct objtool_file *file)
>  	return warnings;
>  }
>  
> -static void mark_endbr_used(struct instruction *insn)
> -{
> -	if (!list_empty(&insn->call_node))
> -		list_del_init(&insn->call_node);
> -}
> -
>  static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
>  {
>  	struct instruction *dest;
