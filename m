Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8CC4D5C64
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347195AbiCKHep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347193AbiCKHed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:34:33 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933CF1B6E15;
        Thu, 10 Mar 2022 23:33:25 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="318743586"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="318743586"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 23:33:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="548381735"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 10 Mar 2022 23:33:23 -0800
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.68.32])
        by linux.intel.com (Postfix) with ESMTP id 58249580DCB;
        Thu, 10 Mar 2022 23:33:21 -0800 (PST)
Message-ID: <ad071c01174bfb76ec790a2b43db2892e5b652e9.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] intel_idle: Add a new flag to initialize the AMX
 state
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Date:   Fri, 11 Mar 2022 09:33:20 +0200
In-Reply-To: <8fc192be-348d-0102-22ab-57b974e9d840@intel.com>
References: <20220309223431.26560-1-chang.seok.bae@intel.com>
         <20220309223431.26560-3-chang.seok.bae@intel.com>
         <CAJZ5v0g2ZU8PY8QkGD1Nb6VH37pm=ho8ZYa3h3UBRWDoH+xqnQ@mail.gmail.com>
         <8fc192be-348d-0102-22ab-57b974e9d840@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-03-10 at 10:50 -0800, Chang S. Bae wrote:
> On 3/10/2022 10:34 AM, Rafael J. Wysocki wrote:
> > On Wed, Mar 9, 2022 at 11:42 PM Chang S. Bae <chang.seok.bae@intel.com>
> > wrote:
> > > 
> [...]
> > > @@ -792,7 +805,8 @@ static struct cpuidle_state spr_cstates[] __initdata =
> > > {
> > >          {
> > >                  .name = "C6",
> > >                  .desc = "MWAIT 0x20",
> > > -               .flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
> > > +               .flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED | \
> > 
> > Why is the backslash at the end of the line needed?
> 
> No, it is not needed.
> 
> Sorry, I think I was mindlessly following the style in this new c-state 
> table:
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-
> pm.git/tree/drivers/idle/intel_idle.c?h=linux-next#n787
> 
> Thanks,
> Chang
> 

Sorry, too much python programming lately, so I automatically added the back-
slash. Let me know if you would remove that backslash at the same time, or I can
submit a patch.

Artem.

