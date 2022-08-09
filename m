Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3915958DFBA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345001AbiHITEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344826AbiHITDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:03:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3277722BC5
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660070308; x=1691606308;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ATsjxCeXRfGofsZfXdbg/06e6rhR7MP7GX3xqMKi4jk=;
  b=Kf0tI8f3uqNrfiUg/CF6EeyNZEha16l8un41hTWyaFye+v//jJ217ciw
   bTr4B9LAPnCWuJq+KT2/Z1SkX0ns/MjII20mS/7jgVi7YKY+Ma4YOKoHO
   mAI2btAm3W/pyD+NEUARIb+S3yS2bynhn0gwJuEiBmHDNGJfxDXvrxNkr
   t23BUnlH63WPRPSFKsMm3MCAQlVC+bw+BPq8A2tCztxQm/HeKySd5rjk8
   5J9bS3DCnZLnJ0wl+LKtmXyyhAfi118LY8dpgdOoGDTHgolpt6UWPnBsc
   ZUhdFFqNL3t3l8XDCHC7Si0IMUnnBCJmWyZbq6q9QqtUa3nEZomEGDO8W
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="291694233"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="291694233"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 11:38:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="633441416"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 09 Aug 2022 11:38:12 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 11:38:11 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 11:38:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 11:38:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 9 Aug 2022 11:38:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NO2sAE45x5BOVG7skF53OAJyuCqAs2PA/KgPaNqxla6Uz3T/Psi4niIdSJNVQpmYCNAjU/5n2cSLxelGRWdp8+GbSAEIiPtWQ8E026CUU639/6wUaJK2HsYVyq8ebnd5hRR11+UzRdJIvAZmXM+30NKH/jSwY2lcwTH9UECF9qrP3eoW6gmSjcTu0iFGwU6VJ3TG2AahQqniogmr4KLL3D0ctTDhek2eD5Eq5jXc/vDmQ4vcPt8cN+0rlxaBZVERBHtFIAg2+EpJcBoIxc9FfEq230rZ/Vc+YKJnLJzdB6nPV0Sm10ZOT71S8oKLEUH3kBAzyid0URuFfdJZba3vqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0flL1qyJhPyJoZduvMhJKNGhS7kpP2MdAJAOnqG7JWo=;
 b=NkrYbO3J688qb+D5cI/TT1Gsm6csF8bS19WL3AQmqg5TpPzB/OeEhOPOwcH7LX29zgGD1UIhGMZE9qGBf3XI8NsNOinFeXQIV7aeqLcD/Q9w1wQg42AXjXnq+qQUtmoOBQsvJMTQGecnY5w5W8a2THLsX/GBbsp9ed5gaOHlZZuKGOl7OACrCyB6p5bw+TW/fgaU37rIcRgbWQsVFyzt7fwN65YdQgX4RVq2dTbgPQUfuXcP1fGD/uGUduR8GbzRKCuj19ZWHAraYNQTzjiw26b0ravKOriQYW1m5ynQXMu1ntf7ZYSQdG8M/hkJa49mY3eUUTfYJGTHvQKcv2j6EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BN8PR11MB3604.namprd11.prod.outlook.com (2603:10b6:408:83::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.17; Tue, 9 Aug 2022 18:38:08 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058%3]) with mapi id 15.20.5504.019; Tue, 9 Aug 2022
 18:38:08 +0000
Date:   Tue, 9 Aug 2022 11:38:03 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [RFC PATCH 2/5] entry: Add calls for save/restore auxiliary
 pt_regs
Message-ID: <YvKpi/CVHko50PNQ@iweiny-desk3>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-3-ira.weiny@intel.com>
 <YvJNe2rzXfcogFFX@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YvJNe2rzXfcogFFX@zn.tnic>
X-ClientProxiedBy: MW4PR04CA0353.namprd04.prod.outlook.com
 (2603:10b6:303:8a::28) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07c07127-d85b-4f8c-cfff-08da7a364e07
X-MS-TrafficTypeDiagnostic: BN8PR11MB3604:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HXvKCgj9W1Dz58uGC58r79bKB0kL1oCNXKfF0Ef6hyBiO2Ktw5kVVl3MUGim6bHPmYLenJc5X9NvSnZ/DV1kYyTt3Gts/GUUYplziNhXG5BqoBMd6SZsk0Pct8Md0dgqnpPQa+ho/VSJcuB4mcQWIHHfzk9APzrK9u3vTfj4wu1AbJkbZGJd1NXsmtzgZtVAJZEJ3a92JxmpjBgduW0J5GOosysqYvksDjwAmVeUCmtvXjT0xOah4812kzH/eDj0rrAviuE19tJpLHsbouiJdJIEECGnb8I3Nt454tEprcBHt2rVPERdiPrM8ohuhTMQZ0GaygXS46GmN8IrUHiVA3ZUfU/8uultza9DpG45Y26lAx81EkOBdDX63tW5D+Tl2K5PB6W9Fn2i5n5sp4GDr58X1tPzSkWwbgQNQaZbjZx9lvnskMDCCgvYiW21DB0W0PlquOWsfVVD+g2TtLe5MHggea0+bza3aLWvDOdu8ZaIv7+GKYkTro7D58vTokjgRXdEp25+95vRJ5h/FC5BIuOs3JDwGqse9Zj1yuf+/q3J6UyuBKrV3FTkjsd1kWnil17TYpddUVcginF/I+HBiZjDFWFE91mMh5/V3xKgLFUgZrjbF/LG1h2AMYf3Dx5eK6QG+O+jt17j3YU8ob7ZzW8FiE8YC0iQ0a26irj6lwx2ufJBagQuFI6zO2/EF9boTHEJvMGUeTHqF5CfRgn15TF9bl7n1szwSZI0HQzLAOs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(39860400002)(376002)(396003)(346002)(366004)(83380400001)(66946007)(66476007)(66556008)(8676002)(4326008)(26005)(41300700001)(6512007)(9686003)(6506007)(2906002)(86362001)(44832011)(6666004)(6486002)(186003)(478600001)(5660300002)(8936002)(82960400001)(38100700002)(33716001)(316002)(6916009)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8bCah3Kkjwikub2iyZ/eFhxL+XZSdf/X6o//iC25SJFVjHZpXqkCpwXHmDZP?=
 =?us-ascii?Q?9QRpR1rg0fbMd/vtetQVWS2VxrnUC/lor/8mnc83AD/Nmjx70q1xTOZ2PM8x?=
 =?us-ascii?Q?0aqXbkf1TPTx/PX8J+kNn/U8ardgYQ7i2mvoUCac6eS2C9Uo7Q/djWlOE2k4?=
 =?us-ascii?Q?7obHaQnPo9Ei1EBJPfLkcF2pRIxVZWONjAqK+1SOm6pjQKXGgB29eyuyet6o?=
 =?us-ascii?Q?A2x6IMvrw6aDcfXvNZT9am2Y12/OIHcssvzendlu3rm0l8TctZlWvm0+s6p0?=
 =?us-ascii?Q?i67JMqkp41BpZCJ2v26Y9d3LrU+2t/N/DTFQZm3teSVKjNDv7D8wGyspJtLu?=
 =?us-ascii?Q?uyt9wGvFX8qDok2d2jcTabvgg38Ojv7kDGpwIDd8p/uriFfNcm50hHjfHR/H?=
 =?us-ascii?Q?Hmf7nLxC7zaL3Yzb9APCJvEgCOuZQYvzBymifp5FkROIuxVcC+pUEvu3sHbq?=
 =?us-ascii?Q?bkh30Lvzfmtqzp5zVdWddF1gGSNQOV2GnSXUyAz9DlSdJbHOSPX5V4ioyqC3?=
 =?us-ascii?Q?ADgN6sNSrGEiY1V28maTosH5h4a8McDikexe7dXwb76fD54XDrXkSz8Mk1dc?=
 =?us-ascii?Q?w1INudtOyKevRs/UE43bH+GedfoCzqos8DWXKXqs/ENC/9NWuAFPniPf5nuF?=
 =?us-ascii?Q?9ROOwWAQOOF2wCGoebOiM6oZrXBOuWOe9ZdTObWall4wySoJZ4Kzr0IEpFFz?=
 =?us-ascii?Q?Um3H+4svVq4tApjox5LJtjuzD3xETHxbJCZ+6tK8aQebzGrKoJAs9DPRXcB6?=
 =?us-ascii?Q?RxqYNkUNbmVtLHtL8/wf+7KXJgfmeeH6m9SUVYv5Kudk2rTBUdpvQ4jUTc/W?=
 =?us-ascii?Q?wSpuzLEK/yWV4YnkvglX/rEepph6Z6WXMlIKi5+8Jf45gXCcJ+1C5tG/lWtU?=
 =?us-ascii?Q?X9KQtuweZ6Fd3+1rPXj3+S76+bw8eLfeEi9C8qoL6yb9zLgiYVnmi+4p3Z8c?=
 =?us-ascii?Q?cb50kLldQb5hIbHGNru/zOtGj095C+SXIf4sMzaY5UnmVarKbPteZcFUvLom?=
 =?us-ascii?Q?M/hPGeGn0VuAu4oujMsYDqFeo2uw1LNq7RDyQvIudc9lDcenAl8qIc9GSwFd?=
 =?us-ascii?Q?DJNMnl62zb8J8NS2VSZfxVZethV0ob+yPJU9EE37hL510rpzXxBxagQXJvBq?=
 =?us-ascii?Q?MvXo0YeSzbeIyImgBua1x43XOY2TahJMZ5j6aty+Xt625MYUsSrSDa9rxWgN?=
 =?us-ascii?Q?3h4t+u5w6YWWsx/EbwFN4t6mQ07W1X5536IfsNc2Y6MXSlp+2BOKkyuLsrWS?=
 =?us-ascii?Q?mUACbEKXXHq2Eg4ncF+edF7FOMw6SFgYFsRk7zZC0V9kPfHydc0NnJmD7Kk3?=
 =?us-ascii?Q?EkUhtOkiJyzOxF2l2MpDztSOrCWJVmd00unl5VFKGrT2ebQ2/OC1Fw3O0eOI?=
 =?us-ascii?Q?BcVPDJDkWwtPiUNCPsfBCsZBsOpRDl2C5d9FxY5Iwfmi4bsp13nU1omsTQK8?=
 =?us-ascii?Q?kPPGmLN89SZb/3fsOmEngiwx+qbltGfzqwERXi662qcH/Rlfn/gKakZM6/BP?=
 =?us-ascii?Q?lyMRuAHoIdJpaddXm3BkjA64LontYmqIAA5cNQsBXRMnM7Zj0EUHnOVpyTm2?=
 =?us-ascii?Q?TqejBzXn7/YNnXoNsYmKRje4AuMkGCmqEfcjS53p?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c07127-d85b-4f8c-cfff-08da7a364e07
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 18:38:08.3709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoYIzybU+lpgXt52CycZXFJzmi5LWdxotTd5oLqKC+Pq3jwBnevzKOTfV3Mlh9M/j17R2QrE/WQL/bpDOnf1qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3604
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 02:05:15PM +0200, Borislav Petkov wrote:
> On Fri, Aug 05, 2022 at 10:30:06AM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Some architectures have auxiliary pt_regs space available to store
> > information on the stack during exceptions.  This information is easier
> > to obtain and store within C code rather than in arch specific assembly.
> 
> There are others?

Other archs?  not now.

> 
> Because I would've done this whole thing in arch/x86/ only...

Thomas did a lot of work to make the entry code generic.  So I was keeping that
work consistent.  This also helps to ensure I did not miss any places.

> 
> > diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> > index 8c0f334c4b75..a70a0f314aee 100644
> > --- a/kernel/entry/common.c
> > +++ b/kernel/entry/common.c
> > @@ -317,7 +317,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
> >  
> >  	if (user_mode(regs)) {
> >  		irqentry_enter_from_user_mode(regs);
> > -		return ret;
> > +		goto aux_save;
> 
> Why do you have to goto and do the instrumentation sandwitch around it
> at the goto label?
> 
> Why not simply do
> 
> 	if (user_mode(regs)) {
> 		irqentry_enter_from_user_mode(regs);
> 		arch_save_aux_pt_regs(regs);
> 		return ret;

I don't believe this is correct because instrumentation is not enabled here.
See below.[1]

There are 3 exit paths from irqentry_enter().  All must call
arch_save_aux_pt_regs().  I felt the maintenance of the code would be easier if
I did not scatter those calls through the function and simply exited 1
place.[1]

FWICT calling instrumentation_{begin,end}() is a noop in production code.  So
there is no real cost to calling instrumentation_begin() -> end -> begin ->
end.  And the goto seemed low enough overhead.  Given the current discussion I
admit I may have made the wrong choice.  But I think I would add some comments
to the below to help future developers.

Ira

[1]

--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -317,6 +317,9 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)

        if (user_mode(regs)) {
                irqentry_enter_from_user_mode(regs);
+               instrumentation_begin();
+               arch_save_aux_pt_regs(regs);
+               instrumentation_end();
                return ret;
        }

@@ -353,6 +356,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
                ct_irq_enter();
                instrumentation_begin();
                trace_hardirqs_off_finish();
+               arch_save_aux_pt_regs(regs);
                instrumentation_end();

                ret.exit_rcu = true;
@@ -369,6 +373,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
        instrumentation_begin();
        rcu_irq_enter_check_tick();
        trace_hardirqs_off_finish();
+       arch_save_aux_pt_regs(regs);
        instrumentation_end();

        return ret;


