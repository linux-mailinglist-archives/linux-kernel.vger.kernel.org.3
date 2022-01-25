Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4BA49B743
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581490AbiAYPHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:07:50 -0500
Received: from mga06.intel.com ([134.134.136.31]:32739 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1390517AbiAYPFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643123102; x=1674659102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g/8CusRbDDiHWxjFMt+CwUueZApoQJ9sBvESGuUIsCU=;
  b=P1swMMMDHHQmcAHH/mUAtZzHtf+UowWTD3rIRfeLzZ+k3dkDXa3ZPzyR
   +t+yEHGRbgAS0naMB6Xcfi9t81ORev1Yha7uEQ4+G87pITzqKzZ5TC1jj
   Y8liYKVFvZfg7Ewr0AzfAfhIshf7oT/1MPoD3r6fjdBWsAdgQkNP/iLgE
   e1Viyg2FI5JcBfkO5C49v4yTggsaATSXvZqnNuXdl6wAXM3Kx8KESlMIB
   cPCCz/zoavr2hpHgf48sfbLm6FEAtZ/HFBSy4oidjsx7jwSsHr9SY8dol
   SzHrUXFTWtsvKhY8cXkayVs9Fel/4n3Pu7lXh1whJlhoOgtOV+hs1Mq/n
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="307031778"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="307031778"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 06:54:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="534754755"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 06:54:18 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 25 Jan 2022 16:53:06 +0200
Date:   Tue, 25 Jan 2022 16:53:05 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Zha Qipeng <qipeng.zha@intel.com>, linux-kernel@vger.kernel.org,
        Andy Pont <andy.pont@sdcsystems.com>
Subject: Re: mfd/intel_pmc_bxt: `intel_pmc_get_resources()` results in page
 fault
Message-ID: <YfAO0SPAK7r4zvUE@lahna>
References: <92c233bc-d1e0-b180-efaa-27e05fbd732b@molgen.mpg.de>
 <YfAIrkJaahKpCta6@lahna>
 <2ebf7968-a324-6f98-e178-45d4d19cfb48@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ebf7968-a324-6f98-e178-45d4d19cfb48@molgen.mpg.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 03:40:54PM +0100, Paul Menzel wrote:
> [Cc: +Andy]
> 
> Dear Mika,
> 
> 
> Am 25.01.22 um 15:26 schrieb Mika Westerberg:
> 
> > On Tue, Jan 25, 2022 at 02:08:53PM +0100, Paul Menzel wrote:
> 
> > > `intel_pmc_get_resources()` does not set the name member in the `resource`
> > > struct `gcr_res` resulting in a page fault.
> > 
> > On which system you reproduce this,
> 
> The dump contains the name:
> 
>     Hardware name: Star Labs Lite/Lite, BIOS 8 01/24/2022
> 
> > and how? Can you also share ACPI dump from that system.
> 
> Note, I only forwarded this from a report in #coreboot. The reporter Andy is
> now in Cc.
> 
> Unrelated from that information, the Linux kernel should never run into a
> page fault and not trust system data.

Right but this looks like an issue with the system ACPI tables so at
least we should report this to the vendor too so they can fix it in
future revisions.
