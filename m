Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F6C46D7AE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbhLHQI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:08:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:33704 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236226AbhLHQI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:08:28 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="237799890"
X-IronPort-AV: E=Sophos;i="5.88,189,1635231600"; 
   d="scan'208";a="237799890"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 08:04:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,189,1635231600"; 
   d="scan'208";a="479944744"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 08 Dec 2021 08:04:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id C74731A0; Wed,  8 Dec 2021 18:04:50 +0200 (EET)
Date:   Wed, 8 Dec 2021 19:04:50 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
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
Subject: Re: [PATCH 4/4] ACPI: PM: Avoid cache flush on entering S4
Message-ID: <20211208160450.3hplhtikjjvfrhts@black.fi.intel.com>
References: <CAJZ5v0gLwSvPfWzYwiZXee8SiPiQQoxjfKfVn4jx6wK_9VVEeg@mail.gmail.com>
 <20211206122952.74139-1-kirill.shutemov@linux.intel.com>
 <20211206122952.74139-5-kirill.shutemov@linux.intel.com>
 <CAJZ5v0iH_CQC-ak_NQC5yONT-tFVC1iikSsfVWFh+z+QL5FKdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iH_CQC-ak_NQC5yONT-tFVC1iikSsfVWFh+z+QL5FKdg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:10:52PM +0100, Rafael J. Wysocki wrote:
> On Mon, Dec 6, 2021 at 1:30 PM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > According to the ACPI spec v6.4, section 16.2 the cache flushing
> > required on entering to S1, S2, and S3.
> >
> > No need to flush caches on hibernation (S4).
> >
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  drivers/acpi/sleep.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> > index 14e8df0ac762..8166d863ed6b 100644
> > --- a/drivers/acpi/sleep.c
> > +++ b/drivers/acpi/sleep.c
> > @@ -902,8 +902,6 @@ static int acpi_hibernation_enter(void)
> >  {
> >         acpi_status status = AE_OK;
> >
> > -       ACPI_FLUSH_CPU_CACHE();
> > -
> >         /* This shouldn't return.  If it returns, we have a problem */
> >         status = acpi_enter_sleep_state(ACPI_STATE_S4);
> >         /* Reprogram control registers */
> > --
> 
> Applied (with some edits in the subject and changelog) as 5.17 material, thanks!

Is it for the series or only 4/4? Do I need to do something for 2/4 and
3/4?

-- 
 Kirill A. Shutemov
