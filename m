Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4856F464673
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 06:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhLAFXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 00:23:06 -0500
Received: from mga02.intel.com ([134.134.136.20]:61075 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230492AbhLAFXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 00:23:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="223615533"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="223615533"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 21:19:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="512536566"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.189])
  by orsmga008.jf.intel.com with ESMTP; 30 Nov 2021 21:19:36 -0800
Date:   Wed, 1 Dec 2021 13:19:35 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Luming Yu <luming.yu@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, paulmck@kernel.org,
        rui.zhang@intel.com, andi.kleen@intel.com,
        Len Brown <len.brown@intel.com>, tim.c.chen@intel.com
Subject: Re: [PATCH v3 2/2] x86/tsc: skip tsc watchdog checking for qualified
 platforms
Message-ID: <20211201051935.GA14778@shbuild999.sh.intel.com>
References: <20211117023751.24190-1-feng.tang@intel.com>
 <20211117023751.24190-2-feng.tang@intel.com>
 <CAJRGBZxdtRgENVonpfJn-zFoQx_LB0ms=aS3wAJhRJO+_OqYFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJRGBZxdtRgENVonpfJn-zFoQx_LB0ms=aS3wAJhRJO+_OqYFw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 11:45:32PM -0500, Luming Yu wrote:
> On Tue, Nov 16, 2021 at 11:18 PM Feng Tang <feng.tang@intel.com> wrote:
> >
> > There are cases that tsc clocksources are wrongly judged as unstable by
> > clocksource watchdogs like hpet, acpi_pm or 'refined-jiffies'. While
> > there is hardly a general reliable way to check the validity of a
> > watchdog, and to protect the innocent tsc, Thomas Gleixner proposed [1]:
> >
> > "I'm inclined to lift that requirement when the CPU has:
> >
> >     1) X86_FEATURE_CONSTANT_TSC
> >     2) X86_FEATURE_NONSTOP_TSC
> >     3) X86_FEATURE_NONSTOP_TSC_S3
> >     4) X86_FEATURE_TSC_ADJUST
> >     5) At max. 4 sockets
> >
> 
> Hi Feng,
> 
> We do  need to decouple  tsc from HPET as the current HPET as a
> clocksource watchdog for tsc
> is only useful to find HPET read skews in some circumstances and the
> variations of HPET read come from many different sources. But
> none of which really came from the tsc quality, AFAICT.
> 
> so this patch is in line with my understanding of the problem.
> So , please use  reviewed-by :  luming.yu@intel.com , if it can help
> the merge of the patch. : -)

Thanks for the review and sharing the real world cases you've met!

- Feng
