Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3028482D8C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 03:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiACCWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 21:22:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:8749 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231346AbiACCWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 21:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641176556; x=1672712556;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t/8ppdYUq/8Kc8VOSsDoAYfcw9iNBQgZWUdDKxTFxLI=;
  b=N3ge8u7VE+gZYzZiw2XPLy8PZZbSo/bnXtMMsI4+6JVJHVXwmfkPHhLN
   2I9eFT6IKXY8IYr/215+KQfif1Su8hzn6o07MxYUAUvEUo+CkNcHxjUoE
   75Ml5wio8uXUMCznDLXeS39oXsthaZaIIu8/Sfntijy5ZrrIuD2skwMuO
   pbOaeVczJuumtyFV/NzeIRXNMK7Vmt0LMN7deW6LkwcpcF21BD7TrO34k
   gZ/ZpX6sJCMn1G6Fu+9nerpqumKFNOWtBs+pDNAEkuKfpMSo9H+eQJr9e
   VfLJfs9k8CBamu99WeQBJ1NLdS8H1L8cdO402TF3d/riggksXPBkVdfkY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="328344351"
X-IronPort-AV: E=Sophos;i="5.88,256,1635231600"; 
   d="scan'208";a="328344351"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2022 18:22:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,256,1635231600"; 
   d="scan'208";a="471501208"
Received: from tnakamaf-mobl.amr.corp.intel.com ([10.209.55.114])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2022 18:22:33 -0800
Message-ID: <2f284d197a5cc160d973a81c898ff42fb4a75db1.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/7] thermal: intel: hfi: Minimally initialize the
 Hardware Feedback Interface
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 02 Jan 2022 18:22:33 -0800
In-Reply-To: <20220102214647.GC14930@ranerica-svr.sc.intel.com>
References: <20211220151438.1196-1-ricardo.neri-calderon@linux.intel.com>
         <20211220151438.1196-4-ricardo.neri-calderon@linux.intel.com>
         <CAJZ5v0hQUMBw-0t0QzvCfOvzp0WEhE64xiU1JX2jkzdG5BJrMg@mail.gmail.com>
         <20220102214647.GC14930@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-01-02 at 13:46 -0800, Ricardo Neri wrote:
> On Thu, Dec 30, 2021 at 07:43:22PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Dec 20, 2021 at 4:23 PM Ricardo Neri
> > <ricardo.neri-calderon@linux.intel.com> wrote:
> > 
> > 
[...]

> > This looks like it may be too general, because HFI is not a
> > thermal-only thing.
> 
> > 
> > Maybe cal it INTEL_HFI_THERMAL?
> 
> True. The *Enhanced* HFI introduces the concept of thread classes
> [1]. I was
> planning to wrap this patchset, which parses the HFI table and deals
> with updates, as INTEL_HFI. The code that deals with classes would be
> wrapped as INTEL_EHFI.
> 
> After this comment, so you still think that INTEL_HFI_THERMAL makes
> more
> sense?
In general most of the configs for Intel thermal is has THERMAL suffix,
so to be consistent may be add THERMAL also at the end.

You can still add INTEL_EHFI as a silent config, which user will not
select. It will be selected by default with INTEL_HFI_THERMAL.

Thanks,
Srinivas


> 
> Thanks and BR,
> Ricardo
> 
> 
> [1].  
> https://www.intel.com/content/www/us/en/develop/download/intel-architecture-instruction-set-extensions-programming-reference.html
>  , Chapter 13
> 


