Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FAF4A4EE1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357953AbiAaStv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:49:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:36380 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240198AbiAaStu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643654990; x=1675190990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8D2BH2C555PohOIaLdNhmx7HXgDMK6RxsyeCx7PYZgE=;
  b=EEyUqdtjAb/qJ1Tyn84A5HHEP68PwaNx2yJZtpByQhdhUtZkGm+CBEuc
   qqdtz25eE+rChqtlWeGcJkZkr6gpfLoiGQVtEWjQKqFevFCmartElTU0f
   k02CoaW1WblctlgdadMF7rSYkX3gr2BVo7FQru97iBTMvNcSAthz0R9Ef
   urRN0ai04Riv8QkLYGr5vLkwlclw6RNh0UKXlPbN6u1JUIkifja+E5YuZ
   9Utp7xIgEZSBn/ND3yP0qTOopkL2tZ772WR135tt9X3yxvapJ/fzAbe8/
   EmqQ7MQuo7V22cT/PlFEV2TSKyVl2Sz1aVWrW7sDJkTuwyURDWVMc4QqG
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="228188713"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="228188713"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 10:49:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="522759048"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 10:49:33 -0800
Date:   Mon, 31 Jan 2022 10:49:32 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 0/6] PPIN (Protected Processor Inventory Number)
 updates
Message-ID: <YfgvPD6AUPIwQgyf@agluck-desk2.amr.corp.intel.com>
References: <20220107225442.1690165-1-tony.luck@intel.com>
 <20220121174743.1875294-1-tony.luck@intel.com>
 <YffWtTq2y6K8+gHF@zn.tnic>
 <YfgbCFNeNEkypCmC@agluck-desk2.amr.corp.intel.com>
 <YfgoBgwgfoiKkPa9@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfgoBgwgfoiKkPa9@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 07:18:46PM +0100, Borislav Petkov wrote:
> On Mon, Jan 31, 2022 at 09:23:20AM -0800, Luck, Tony wrote:
> > I'm worried that some future thing might reverse that and have
> > a "package" id for each die in a multi-die package which still
> > appears as a single node. That would distort the meaning of "package",
> > so it isn't supposed to happen. But if it did, Linux would be stuck
> > just reporting one of the "package" ids.
> 
> Hmm, so we write that we don't really care about the physical socket in
> software:
> 
> Documentation/x86/topology.rst:
> "The kernel does not care about the concept of physical sockets because
> a socket has no relevance to software. It's an electromechanical
> component. In the past a socket always contained a single package
> (see below), but with the advent of Multi Chip Modules (MCM) a socket
> can hold more than one package. So there might be still references to
> sockets in the code, but they are of historical nature and should be
> cleaned up."
> 
> and the PPIN is a physical socket property. So there's no proper way for
> us to tie to anything that represents the physical socket.
> 
> So, the use case you're imagining would be, what?
> 
> The FRU code glue would go:
> 
> "I got an MCE on CPU X...
> 
> Lemme see which PPIN is it:
> 
> # cat /sys/devices/system/cpu/cpuX/topology/ppin
> BLA
> 
> ah ok, lemme report it:
> 
> You just had an MCE on CPU X, socket BLA"
> 
> Something like that?

Yes. We also have a new thing (patches coming soon) other than MCE
that would follow that same flow. So in general it is: "problem with CPU X,
go read the ppin file for that CPU to file the report".  For the new
thing, only root can trigger it, so not a problem for root to create
the report.

> But that FRU glue software would have to run as root so that it reads
> the ppin sysfs file.
> 
> But we don't want to expose that processor serial number to !root users
> so we're forcing the people to run the FRU thing as root.
> 
> This feels like this guy here:
> 
> https://c.tenor.com/fDZOE4okO3EAAAAC/homer-simpsons.gif

I think any paranoia about having a user readable "serial number"
should be gone by now. Those wacky web folks found a dozen different ways
to track your every move on the internet so that adverts for whatever
you just searched for will follow you for days. It seems highly
unlikely that browser writers will bother reading ppin and adding it
to cookies.

But I didn't want to get distracted by that, so made the file mode 0400.

-Tony
