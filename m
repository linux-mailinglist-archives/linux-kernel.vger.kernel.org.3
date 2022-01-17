Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B4E49070D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239062AbiAQLTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:19:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:15761 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236343AbiAQLTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:19:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642418357; x=1673954357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=89EnvaRj99ht3rvS5EmgkqNz22XEdsGuHgAmVBLHn64=;
  b=lcnwJziv/iwgLrfriRkAR62DtdRSwIw846xQIeTDAit175NWwCDAPQ0j
   Z9QnMkMGLwImLY7SSplE8dvPBZI9pjx7JWYKaI9kQ/SqWXGi2GyhESeUN
   JfQcWLgU+zKnmSETFRx3/FZZmfxiZhgTR3ffBUlEtlA7+cKtbLqJdQ2Fu
   S8kiaYphc43WErnLyoY+WI4KwM3GSO7PmifAR+pMWieTJFR9RziPs7R7/
   MXAiQqgsKpzPjL6NfQ3Wg3rvWx8qTXMqxpZI5BchmsdOuJdE6DwVtrFaj
   FAP8oU7JICLKx70AkD9GmMOgJcTFtxUDfpSfu7BWOZBgO6Hqciw7H4XCj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="307946314"
X-IronPort-AV: E=Sophos;i="5.88,295,1635231600"; 
   d="scan'208";a="307946314"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 03:19:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,295,1635231600"; 
   d="scan'208";a="671531193"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 17 Jan 2022 03:19:14 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 17 Jan 2022 13:19:13 +0200
Date:   Mon, 17 Jan 2022 13:19:13 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        rafael.j.wysocki@intel.com, linux-usb@vger.kernel.org
Subject: Re: [Bug][5.17-rc0] Between commits daadb3bd0e8d and 455e73a07f6e,
 the kernel stops loading on my devices.
Message-ID: <YeVQsRp7aDMcQKs7@kuha.fi.intel.com>
References: <CABXGCsNb22JCJ4AyR1sYqFtF4QUnvM3B2zQcc1svcm2mquWxoA@mail.gmail.com>
 <YeUvvIaVJnJrrpYe@kuha.fi.intel.com>
 <CABXGCsO5PYBuZ11YR16NLLa0H07Jom1JQhWHFuETfotfBfzkMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsO5PYBuZ11YR16NLLa0H07Jom1JQhWHFuETfotfBfzkMw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 03:46:44PM +0500, Mikhail Gavrilov wrote:
> On Mon, 17 Jan 2022 at 13:58, Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Hi Mikhail,
> >
> > Thank you for bisecting the problem.
> >
> > The code assumes currently that every USB Type-C port has an ACPI
> > device node defined for it in the ACPI tables, but it looks like we
> > can't make that assumption. Could you send me the acpidump?
> >
> > I'm attaching a test patch where I check the Type-C port ACPI nodes.
> > Let me know it that fixes the problem.
> >
> 
> Hi Heikki,
> Unfonitaly I can't test patch because it applicable to actual code base.
> 
> $ cat 0001-usb-typec-Test-fix.patch | git apply -v
> Checking patch drivers/usb/typec/port-mapper.c...
> error: while searching for:
> {?
>     struct each_port_arg arg = { .port = con, .match = NULL };?
> ?
>     bus_for_each_dev(&acpi_bus_type, NULL, &arg, typec_port_match);?
> ?
>     /*?
> 
> error: patch failed: drivers/usb/typec/port-mapper.c:56
> error: drivers/usb/typec/port-mapper.c: patch does not apply

I don't know which tree you are working on top of, but the patch
applies just fine on top of Linus' latest master branch:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

> I attached acpidump files from my workstation and laptop.

Thanks. I can see UCSI in your laptop dump, but not in the workstation
dump. The laptop has the device nodes also for the ports as expected.

Which machine is failing?

Br,

-- 
heikki
