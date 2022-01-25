Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011A549BBDF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiAYTNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiAYTNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:13:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCC2C06173B;
        Tue, 25 Jan 2022 11:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zn9OdX6SCDnc0a4wA7ukdq4TtllhJ5C7oxCbnabS+XQ=; b=J/KCFhpGNX4sNyM277ABmhi8Hy
        Fi3zuqPhUBkZJ/KU+5Gw+g3bRVewGjJ38vNw6llArBt5rsz9wKFmcWafnpxC8/vmErxXwnqp0xYwH
        54S1Js5dgFwRmsQrtowdpFVzTSTEtgbihFq9Kw/WZeCIrfyN/xhcJTk6RX5h7eINcd1runRLXFY7D
        oJD9wcsZ8vIRzBO6JElLBPGr4sXEL7oULummUlc6kgFAXm/Rzkf+AA+ORFs1o8wGrHfn9UK9/WJPZ
        OttFM/ZB4OUrAmkclZ/uaj4BNahfakC13qeynjYggqZO+JxaDBZDDJ9fTyPF1qYjr06e+DVDxOF7o
        esxPxyjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCRFU-003HEF-4M; Tue, 25 Jan 2022 19:13:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BE278300099;
        Tue, 25 Jan 2022 20:12:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7AC342B370DB8; Tue, 25 Jan 2022 20:12:58 +0100 (CET)
Date:   Tue, 25 Jan 2022 20:12:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     James Clark <james.clark@arm.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.com, Suzuki.Poulose@arm.com,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] perf/core: Wake up parent event if inherited
 event has no ring buffer
Message-ID: <YfBLusfOk9fpIqqI@hirez.programming.kicks-ass.net>
References: <20211206113840.130802-1-james.clark@arm.com>
 <20211206113840.130802-2-james.clark@arm.com>
 <Ye6SR0yxTrkNUQF6@hirez.programming.kicks-ass.net>
 <a4b64cff-f3f1-e6ad-38e9-b65a113ce561@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4b64cff-f3f1-e6ad-38e9-b65a113ce561@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 02:58:18PM +0000, James Clark wrote:

> > Would this be the better patch?
> 
> Yes I tested this and it also works.

Excellent!

> There is one other suspicious access
> of ->rb followed by if(rb) here in perf_poll(), but maybe it works out ok?
> 
> 	mutex_lock(&event->mmap_mutex);
> 	rb = event->rb;
> 	if (rb)
> 		events = atomic_xchg(&rb->poll, 0);
> 

That case must be good since it is the event from a file. Those cannot
be clones.

> We also have a Perf self test that covers this failure for Arm SPE now, I'm not
> sure if I should post that separately or with your new version of this fix?

They'd be routed through separate trees anyway, Arnaldo takes the
userspace stuff.
