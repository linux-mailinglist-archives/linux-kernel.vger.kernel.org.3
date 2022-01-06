Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B029486CF7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244974AbiAFV4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:56:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:36550 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244485AbiAFV4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641506173; x=1673042173;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9KodgYKG3fFjQi545R6D+Ahfgnlov8/fgX8Amfksz1Q=;
  b=DRsqlqIjEr+7Jx/Ha9aifdJu7ykyIPFoePyaMNlJ1N0pU4k1H18SS/Lj
   E9tK+//Ekxv74dDSRpgaipcxl5qiWn96QPJ7HcOyEOoXccrVLCRo7LJ+H
   sS9VVNppnojKZ770XJZrk1Gkj+NTwNmTsOXhtDN+u7s8bjmQi4FXEmD7l
   w/nw8ilGvXWqYB1/syag5FcF7En86B7Sd8OO3lXtDHWND6MbQ1+r9uf2L
   CcITjxLE+/q8dP9rKMTq3A8Q+X5H5h5xNT0iiUF4mpsDqQPwvCgtww7Io
   9bkEutD4DGCM8fjoHOWZhWYDyE0RhV7PSGWRDOYKxieop9sDTyAAiwHbJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="230086775"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="230086775"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 13:56:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="527097710"
Received: from dwmarks1-mobl1.amr.corp.intel.com (HELO samudha-mobl.amr.corp.intel.com) ([10.212.136.192])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 13:56:12 -0800
Message-ID: <a14c639df462ead1cca4da20203eb1283f4d6cb5.camel@linux.intel.com>
Subject: Re: cpufreq: intel_pstate: map utilization into the pstate range
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Francisco Jerez <currojerez@riseup.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 06 Jan 2022 13:55:50 -0800
In-Reply-To: <alpine.DEB.2.22.394.2201062141290.3098@hadrien>
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien>
          <alpine.DEB.2.22.394.2112291012030.24929@hadrien>
          <CAJZ5v0g5wDxYXA-V=Ex_Md82hgnj5K6Vr0tavFFVz=uBqo8wag@mail.gmail.com>
          <alpine.DEB.2.22.394.2112301840360.15550@hadrien>
          <CAJZ5v0h38jh3gyTp9W0ws0yXyfK=F+TQ7VYRVx4aGXhNeSObEg@mail.gmail.com>
          <alpine.DEB.2.22.394.2112301919240.15550@hadrien>
          <CAJZ5v0haa5QWvTUUg+wwSHvuWyk8pic1N0kox=E1ZKNrHSFuzw@mail.gmail.com>
          <alpine.DEB.2.22.394.2112301942360.15550@hadrien>
          <CAJZ5v0im+Cke7tcNRav2VCyf5Qvi7qC29aF+9A1kVZZmt7cu6g@mail.gmail.com>
          <alpine.DEB.2.22.394.2201031922110.3020@hadrien>
          <CAJZ5v0hsCjKA3EisK9s_S8Vb9Tgm4eps1FTKvUSfd9_JPh5wBQ@mail.gmail.com>
          <alpine.DEB.2.22.394.2201032110590.3020@hadrien>
          <CAJZ5v0hFcRWPO859YWUKLdqkTrVA1WLqRjFWg1=WS8qGG5CTkQ@mail.gmail.com>
          <alpine.DEB.2.22.394.2201041643520.3020@hadrien>
          <CAJZ5v0i9Rh0Cm3Mbu3N8w6UmgJEnmThk4znWVcp9qeroabjsNw@mail.gmail.com>
          <alpine.DEB.2.22.394.2201052107280.48852@hadrien>
          <87a6g9rbje.fsf@riseup.net>
         <alpine.DEB.2.22.394.2201062044340.3098@hadrien>
         <1b2be990d5c31f62d9ce33aa2eb2530708d5607a.camel@linux.intel.com>
         <alpine.DEB.2.22.394.2201062141290.3098@hadrien>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-01-06 at 21:43 +0100, Julia Lawall wrote:
> > > All the turbostat output and graphs I have sent recently were
> > > just
> > > for
> > > continuous spinning:
> > > 
> > > for(;;);
> > > 
> > > Now I am trying running for the percentage of the time
> > > corresponding
> > > to
> > > 10 / P for pstate P (ie 0.5 of the time for pstate 20), and then
> > > sleeping,
> > > to see whether one can just add the sleeping power consumption of
> > > the
> > > machine to compute the efficiency as Rafael suggested.
> > > 
> > Before doing comparison try freezing uncore.
> > 
> > wrmsr -a 0x620 0x0808
> > 
> > to Freeze uncore at 800MHz. Any other value is fine.
> 
> Thanks for the suggestion.  What is the impact of this?
Uncore scales based on its own heuristics based in P-state change and
works in package scope. So to actually see the effect of P-state change
on energy you can remove variability of uncore power.

Thanks,
Srinivas

> 
> julia


