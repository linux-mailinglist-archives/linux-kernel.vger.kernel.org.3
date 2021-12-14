Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378844741ED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhLNMCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhLNMCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:02:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13538C061574;
        Tue, 14 Dec 2021 04:02:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2EE3614A6;
        Tue, 14 Dec 2021 12:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAB6C34601;
        Tue, 14 Dec 2021 12:02:30 +0000 (UTC)
Date:   Tue, 14 Dec 2021 12:02:27 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Yee Lee <yee.lee@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, nicholas.Tang@mediatek.com,
        Kuan-Ying.lee@mediatek.com, chinwen.chang@mediatek.com,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fuad Tabba <tabba@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3 1/1] arm64/cpufeature: Optionally disable MTE via
 command-line
Message-ID: <YbiH04yqEqW8p8EM@arm.com>
References: <20210730144957.30938-1-yee.lee@mediatek.com>
 <20210730144957.30938-2-yee.lee@mediatek.com>
 <20210802153036.GH18685@arm.com>
 <e055e71f0ca7bcb351b9097ba8f8f4a9d324623c.camel@mediatek.com>
 <YapGyozjactAm8vp@arm.com>
 <dc2fd1f8c68e78905f4242c2b530bc720b979cd8.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc2fd1f8c68e78905f4242c2b530bc720b979cd8.camel@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 04:19:05PM +0800, Yee Lee wrote:
> On Fri, 2021-12-03 at 16:33 +0000, Catalin Marinas wrote:
> > On Thu, Nov 25, 2021 at 06:19:29PM +0800, Yee Lee wrote:
> > > As pointed out earlier, the hardware has been verified that still has
> > > transaction sending to DRAM due to mair_el1(Normal_tagged) is
> > > setup.  That means the override in this patch would be incompleted and
> > > cannot achieve to avoid undesired hardware confliction by disabling MTE.
> > > 
> > > Do we have other options to delay the configuration on MAIR_EL1 after
> > > the override? Or maybe another CONFIG to bypass the init in __cpu_setup?
> > 
> > This register is trickier as it may be cached in the TLB (IIRC). I think
> > deferring the setting of SCTLR_EL1.ATA(0) should be sufficient. Can you
> > try the diff I sent in the previous email and confirm that the accesses
> > to the allocation tag storage are blocked?
> 
> Yes, the previous diff is already online. 
> 
> In our experiment, with cmdline, "arm64.nomte", cpu_enable_mte() is
> bypassed and the ATA0 is not set, but the access to tag memory still
> dispatches. Only as MAIR_EL1 remains MAIR_ATTR_NORMAL, instead of
> MAIR_ATTR_NORMAL_TAGGED, the access will stop.
> 
> From the manual, I think ATA only affects TAG instructions like STG,
> IRG, but not the tag access within normal STR/LDR.

The ARM ARM states SCTLR_EL1.ATA0 == 0 means "access to allocation tags
is prevented". The AArch64.MemSingle[] pseudocode ends up with similar
checks:

https://developer.arm.com/documentation/ddi0596/2021-09/Shared-Pseudocode/AArch64-Functions?lang=en#AArch64.MemSingle.read.5

before reading the tags from memory in AArch64.CheckTag():

https://developer.arm.com/documentation/ddi0596/2021-09/Shared-Pseudocode/AArch64-Functions?lang=en#AArch64.CheckTag.4

My suggestion is to raise this with support@arm.com (feel free to cc me)
so that we clarify the hardware behaviour. I don't think it's entirely
correct (it's more like, is there a risk of external aborts caused by
access to allocation tag storage that's not present?)

-- 
Catalin
