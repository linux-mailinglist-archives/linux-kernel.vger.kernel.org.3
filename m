Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6879746E931
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238016AbhLINhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:37:08 -0500
Received: from mga18.intel.com ([134.134.136.126]:22050 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhLINhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:37:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="224963065"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="224963065"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 05:33:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="606848385"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 09 Dec 2021 05:33:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 29FC9329; Thu,  9 Dec 2021 15:33:35 +0200 (EET)
Date:   Thu, 9 Dec 2021 16:33:35 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH 3/4] ACPI: processor idle: Only flush cache on entering C3
Message-ID: <20211209133335.u4suzd2u5sjly67l@black.fi.intel.com>
References: <CAJZ5v0gLwSvPfWzYwiZXee8SiPiQQoxjfKfVn4jx6wK_9VVEeg@mail.gmail.com>
 <20211206122952.74139-1-kirill.shutemov@linux.intel.com>
 <20211206122952.74139-4-kirill.shutemov@linux.intel.com>
 <Ya4mTij+eQPq8dnu@hirez.programming.kicks-ass.net>
 <CAJZ5v0hjcKn0g=Tc90aK_EchOG+sWi8na1HVb0GdtQsYn7sAKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hjcKn0g=Tc90aK_EchOG+sWi8na1HVb0GdtQsYn7sAKQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 05:26:12PM +0100, Rafael J. Wysocki wrote:
> On Mon, Dec 6, 2021 at 4:03 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Dec 06, 2021 at 03:29:51PM +0300, Kirill A. Shutemov wrote:
> > > According to the ACPI spec v6.4, section 8.2, cache flushing required
> > > on entering C3 power state.
> > >
> > > Avoid flushing cache on entering other power states.
> > >
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > ---
> > >  drivers/acpi/processor_idle.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> > > index 76ef1bcc8848..01495aca850e 100644
> > > --- a/drivers/acpi/processor_idle.c
> > > +++ b/drivers/acpi/processor_idle.c
> > > @@ -567,7 +567,8 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
> > >  {
> > >       struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
> > >
> > > -     ACPI_FLUSH_CPU_CACHE();
> > > +     if (cx->type == ACPI_STATE_C3)
> > > +             ACPI_FLUSH_CPU_CACHE();
> > >
> >
> > acpi_idle_enter() already does this, acpi_idle_enter_s2idle() has it
> > confused again,
> 
> No, they do the same thing: acpi_idle_enter_bm() if flags.bm_check is set.
> 
> > Also, I think acpi_idle_enter() does it too late; consider
> > acpi_idle_enter_mb(). Either that or the BM crud needs more comments.
> 
> I think the latter.
> 
> Evidently, acpi_idle_play_dead(() doesn't support FFH and the BM
> thing, so it is only necessary to flush the cache when using
> ACPI_CSTATE_SYSTEMIO and when cx->type is C3.

I'm new to this and not completely follow what I need to change.

Does it look correct?

From 3c544bc95a16d6a23dcb0aa50ee905d5e97c9ce5 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Thu, 9 Dec 2021 16:24:44 +0300
Subject: [PATCH] ACPI: processor idle: Only flush cache on entering C3

According to the ACPI spec v6.4, section 8.2, cache flushing required
on entering C3 power state.

Avoid flushing cache on entering other power states.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 drivers/acpi/processor_idle.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 76ef1bcc8848..d2a4d4446eff 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -567,7 +567,9 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 {
 	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
 
-	ACPI_FLUSH_CPU_CACHE();
+	if (cx->entry_method == ACPI_CSTATE_SYSTEMIO &&
+	    cx->type == ACPI_STATE_C3)
+		ACPI_FLUSH_CPU_CACHE();
 
 	while (1) {
 
-- 
 Kirill A. Shutemov
