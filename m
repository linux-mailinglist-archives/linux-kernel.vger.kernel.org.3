Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1950497F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239401AbiAXMWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbiAXMWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:22:10 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B2DC06173B;
        Mon, 24 Jan 2022 04:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=usUI3XRHp3JiGsl+VkmrMKazICb5yORxOcpWOnXHZrk=; b=MlClG8g2lp50xwDbbI11yIYH45
        xbj9Jkem1145+AfyoUqS+iiKazgKF40qCbIWrZLqrslyRKUT5jUn/0ndcwJRxjYcdmwa+BQh+8Sn4
        qbcqA806RlsKHAGWzs1ygY/puCt1TXLp/4UTjBC7sypJg0yCKwWrluoZc1FY6a5yCZylv2clqXqWX
        BA75wFe4lksdmOL/5wlZU/0pPDP8G4JV0oVeC5wZEF6nPh1m9x1FKVTvqxx5VavxsySJpUBDUcSsJ
        PuGS0+aDT8AMe1f5A/GOs7Rpsojgpd6t0ppV016Y93fgZGGaOfh/zZlLxZ1U/EPzGqi8OWHjTylG0
        /7CAG3lg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nByM5-0039Tl-Ns; Mon, 24 Jan 2022 12:21:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3DBC5300BA2;
        Mon, 24 Jan 2022 13:21:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3D66201A6CC2; Mon, 24 Jan 2022 13:21:51 +0100 (CET)
Date:   Mon, 24 Jan 2022 13:21:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kyle Huey <me@kylehuey.com>
Cc:     linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
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
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: [PATCH] x86/perf: Default freeze_on_smi on for Comet Lake and
 later.
Message-ID: <Ye6Z31keWVPrsNWU@hirez.programming.kicks-ass.net>
References: <20220122072644.92292-1-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122072644.92292-1-khuey@kylehuey.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 11:26:44PM -0800, Kyle Huey wrote:
> Beginning in Comet Lake, Intel extended the concept of privilege rings to
> SMM.[0] A side effect of this is that events caused by execution of code
> in SMM are now visible to performance counters with IA32_PERFEVTSELx.USR
> set.
> 
> rr[1] depends on exact counts of performance events for the user space
> tracee, so this change in behavior is fatal for us. It is, however, easily
> corrected by setting IA32_DEBUGCTL.FREEZE_WHILE_SMM to 1 (visible in sysfs
> as /sys/devices/cpu/freeze_on_smi). While we can and will tell our users to
> set freeze_on_smi manually when appropriate, because observing events in
> SMM is rarely useful to anyone, we propose to change the default value of
> this switch.
> 
> In this patch I have assumed that all non-Atom Intel microarchitectures
> starting with Comet Lake behave like this but it would be good for someone
> at Intel to verify that.
> 

Kan, can you look at that?

> [0] See the Intel white paper "Trustworthy SMM on the Intel vPro Platform"
> at https://bugzilla.kernel.org/attachment.cgi?id=300300, particularly the
> end of page 5.
> 
> [1] https://rr-project.org/
> 
> Signed-off-by: Kyle Huey <khuey@kylehuey.com>

Patch seems sensible enough; I'll go queue it up unless Kan comes back
with anything troublesome.
