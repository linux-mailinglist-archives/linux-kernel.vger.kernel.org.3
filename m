Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01E6473E24
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhLNITK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:19:10 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:34338 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229565AbhLNITJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:19:09 -0500
X-UUID: 426187845b5740578dcebda14c740936-20211214
X-UUID: 426187845b5740578dcebda14c740936-20211214
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 530296576; Tue, 14 Dec 2021 16:19:06 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Dec 2021 16:19:05 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Dec 2021 16:19:04 +0800
Message-ID: <dc2fd1f8c68e78905f4242c2b530bc720b979cd8.camel@mediatek.com>
Subject: Re: [PATCH v3 1/1] arm64/cpufeature: Optionally disable MTE via
 command-line
From:   Yee Lee <yee.lee@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <nicholas.Tang@mediatek.com>,
        <Kuan-Ying.lee@mediatek.com>, <chinwen.chang@mediatek.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
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
Date:   Tue, 14 Dec 2021 16:19:05 +0800
In-Reply-To: <YapGyozjactAm8vp@arm.com>
References: <20210730144957.30938-1-yee.lee@mediatek.com>
         <20210730144957.30938-2-yee.lee@mediatek.com>
         <20210802153036.GH18685@arm.com>
         <e055e71f0ca7bcb351b9097ba8f8f4a9d324623c.camel@mediatek.com>
         <YapGyozjactAm8vp@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-12-03 at 16:33 +0000, Catalin Marinas wrote:
> On Thu, Nov 25, 2021 at 06:19:29PM +0800, Yee Lee wrote:
> > On Mon, 2021-08-02 at 16:30 +0100, Catalin Marinas wrote:
> > > On Fri, Jul 30, 2021 at 10:49:53PM +0800, yee.lee@mediatek.com
> > > wrote:
> > > > From: Yee Lee <yee.lee@mediatek.com>
> > > > 
> > > > For some low-end devices with limited resources,
> > > > MTE needs to be optionally disabled to save system
> > > > costs such as tag memory and firmware controls.
> > > 
> > > I understand the cost of using MTE but I don't fully get what you
> > > mean
> > > by firmware controls. If the ID_AA64PFR1_EL1.MTE reports that MTE
> > > is
> > > present, the firmware should have initialised MTE correctly (e.g.
> > > tag
> > > allocation storage, SCR_EL3.ATA) and not rely on a kernel command
> > > line
> > > argument that may or may not be present.
> > > 
> > > > This allows ID_AA64PFR1_EL1.MTE to be overridden on 
> > > > its shadow value by giving "arm64.nomte" on cmdline,
> > > > and to suppress MTE feature.
> > > > 
> > > > Suggested-by: Marc Zyngier <maz@kernel.org>
> > > > Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > > Signed-off-by: Yee Lee <yee.lee@mediatek.com>
> > > 
> > > While this patch appears to disable MTE, I don't think it can
> > > fully
> > > prevent the access to the allocation tag storage, so the firmware
> > > must
> > > still initialise it correctly.
> > > 
> > > The issue is that __cpu_setup already configures the MAIR_EL1
> > > register
> > > to use Normal Tagged memory for the kernel mapping and
> > > SCTLR_EL1.ATA is
> > > set. The TCF field is zero, so no tag checking, but I couldn't
> > > figure
> > > out from the ARM ARM whether this also prevents LDR/STR from
> > > attempting
> > > to fetch the allocation tags. I think it's only the ATA bit and
> > > the MAIR
> > > configuration.
> > > 
> > > With this patch, KASAN_HW_TAGS (if configured) won't be used and
> > > MTE
> > > will not be presented to user applications, if that's what you
> > > want, but
> > > does not fully disable MTE.
> > 
> > As pointed out earlier, the hardware has been verified that still
> > has
> > transaction sending to DRAM due to mair_el1(Normal_tagged) is
> > setup.  That means the override in this patch would be incompleted
> > and
> > cannot achieve to avoid undesired hardware confliction by disabling
> > MTE.
> > 
> > Do we have other options to delay the configuration on MAIR_EL1
> > after
> > the override? Or maybe another CONFIG to bypass the init in
> > __cpu_setup?
> 
> This register is trickier as it may be cached in the TLB (IIRC). I
> think
> deferring the setting of SCTLR_EL1.ATA(0) should be sufficient. Can
> you
> try the diff I sent in the previous email and confirm that the
> accesses
> to the allocation tag storage are blocked?
> 

Yes, the previous diff is already online. 

In our experiment, with cmdline, "arm64.nomte", cpu_enable_mte() is
bypassed and the ATA0 is not set, but the access to tag memory still
dispatches. Only as MAIR_EL1 remains MAIR_ATTR_NORMAL, instead of
MAIR_ATTR_NORMAL_TAGGED, the access will stop.

From the manual, I think ATA only affects TAG instructions like STG,
IRG, but not the tag access within normal STR/LDR.


