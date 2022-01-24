Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503B849863D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244317AbiAXRQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244253AbiAXRQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:16:36 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7E7C06173B;
        Mon, 24 Jan 2022 09:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DSa7jeW9P4lNLLrfrfHT/zJUZL/sXm6OhiC7qNBM8w4=; b=NUBgWZujFXvoL7DzLqV7A+5FRa
        xuK3c6RIvRpVEfkXWUflBmensb2bfz+/Gvmov/NjfsFEl0/GHaBuKKW4+iByQ4f0xGqLZsSrazXyZ
        rHNhf5OncD+4efuucKMbf/9mMTGHcle4HAyDbU6oYPM4Y14TVwedjIAAB6VHVicUPprucaTw7e62r
        0TCU2IfZp5FSL3+7tdgjeh2xWMJTS0OPsrwcHkgKuNwibsF9u6gvWoER4mxPp5iiFrReEOdHn5B2N
        38h5Nx3mjaXlZ0cjkoPtUG0lWucqKNSEnUItr7exQCqNOlcgf+tsQKXFpZxAJA4Y9tkCrRxpiRjI0
        49gQaoew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nC2x2-003D8g-QG; Mon, 24 Jan 2022 17:16:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3FDF6300222;
        Mon, 24 Jan 2022 18:16:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 28E652B54C677; Mon, 24 Jan 2022 18:16:19 +0100 (CET)
Date:   Mon, 24 Jan 2022 18:16:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Kyle Huey <me@kylehuey.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86/perf: Default freeze_on_smi on for Comet Lake and
 later.
Message-ID: <Ye7e49ln8mfCELqy@hirez.programming.kicks-ass.net>
References: <20220122072644.92292-1-khuey@kylehuey.com>
 <Ye6Z31keWVPrsNWU@hirez.programming.kicks-ass.net>
 <3c35dc76-c187-8d3f-7fc9-75de32e7cbf6@linux.intel.com>
 <Ye7UDFAV5/OPaE5N@hirez.programming.kicks-ass.net>
 <3bfa617e-007c-ebc3-8c71-0bcb83b24794@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bfa617e-007c-ebc3-8c71-0bcb83b24794@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 12:03:10PM -0500, Liang, Kan wrote:
> 
> 
> On 1/24/2022 11:30 AM, Peter Zijlstra wrote:
> > On Mon, Jan 24, 2022 at 11:00:56AM -0500, Liang, Kan wrote:
> > > 
> > > 
> > > On 1/24/2022 7:21 AM, Peter Zijlstra wrote:
> > > > On Fri, Jan 21, 2022 at 11:26:44PM -0800, Kyle Huey wrote:
> > > > > Beginning in Comet Lake, Intel extended the concept of privilege rings to
> > > > > SMM.[0] A side effect of this is that events caused by execution of code
> > > > > in SMM are now visible to performance counters with IA32_PERFEVTSELx.USR
> > > > > set.
> > > > > 
> > > > > rr[1] depends on exact counts of performance events for the user space
> > > > > tracee, so this change in behavior is fatal for us. It is, however, easily
> > > > > corrected by setting IA32_DEBUGCTL.FREEZE_WHILE_SMM to 1 (visible in sysfs
> > > > > as /sys/devices/cpu/freeze_on_smi). While we can and will tell our users to
> > > > > set freeze_on_smi manually when appropriate, because observing events in
> > > > > SMM is rarely useful to anyone, we propose to change the default value of
> > > > > this switch.
> > > 
> > > + Andi
> > > 
> > >  From we heard many times from sophisticated customers, they really hate
> > > blind spots. They want to see everything. That's why we set freeze_on_smi to
> > > 0 as default. I think the patch breaks the principle.
> > 
> > Well, USR really, as in *REALLY* should not be counting SMM. That's just
> > plain broken.
> > 
> 
> For the USR only case, the bit could be set.
> 
> > There's maybe an argument to include it in OS, but USR is ring-3.
> 
> But we don't have an option for the USR only case. The changing will impact
> the SYS case as well. Personally, maybe it's better to let the user apace
> app control the bit as needed rather than changing the default kernel value
> for all cases.

The bit is system wide, you can't sanely control it per counter. The
change that made USR include SMM is insane and broken.
