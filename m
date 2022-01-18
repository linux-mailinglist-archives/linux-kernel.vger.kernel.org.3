Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30C44921BA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 09:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345097AbiARI6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 03:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240431AbiARI6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 03:58:18 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE31CC061574;
        Tue, 18 Jan 2022 00:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GPIVl475f8UFddNg+OludgqDGQTkzKzQzuYcVSAcSw4=; b=NWXtUzOr08XMubwhSysdp0GKYD
        /1LjawvPEUyvMgVvCkIXnCt5NDZghDo5DbURPwhKBGygjb5+SXXsfhuSwIhSJw2NEQUaNz3gyVZ83
        HkWIZsvV9Sio3eMt2RNnlajwJgxeR5K0cdgzsyT4p8k+E+H3RFQKlbNDBOOCdWusCPelXhHC7cRCH
        FHsnFHllKXuopliB1VQSJDtKtMnaGPD4FyXqTF6OFkSEv4/KwuTkxpW3rzA/T003rtok5LEnCZZ6x
        m10TwSHMNy9WDBA4IwFRd4vSdUb7wx41OSLZZW7dYMeEzwTeL3hQDSAHD8E3NaCFOkCKDYL9HJo62
        Bolm4ylA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9kJI-001odZ-8t; Tue, 18 Jan 2022 08:57:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E6E293001C0;
        Tue, 18 Jan 2022 09:57:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A068020168646; Tue, 18 Jan 2022 09:57:45 +0100 (CET)
Date:   Tue, 18 Jan 2022 09:57:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH -next, v2] sched: Use struct_size() helper in
 task_numa_group()
Message-ID: <YeaBCYiTM/mxtBDU@hirez.programming.kicks-ass.net>
References: <20220110012354.144394-1-xiujianfeng@huawei.com>
 <Ydy3N577YD0JJr2N@hirez.programming.kicks-ass.net>
 <20220110193158.31e1eaea@gandalf.local.home>
 <Yd1qYsFcgcp/uHSa@hirez.programming.kicks-ass.net>
 <20220111101425.7c59de5b@rorschach.local.home>
 <Yd/ugQ8kUmcceuex@hirez.programming.kicks-ass.net>
 <202201141935.A3F2ED1CF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201141935.A3F2ED1CF@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 07:50:47PM -0800, Kees Cook wrote:
> On Thu, Jan 13, 2022 at 10:18:57AM +0100, Peter Zijlstra wrote:

> > Then I would still much prefer something like:
> > 
> > 	unsigned int size = sizeof(*grp) +
> > 			    NR_NUMA_HINT_FAULT_STATS * numa_node_ids * sizeof(gfp->faults);
> > 
> > Which is still far more readable than some obscure macro. But again, the
> 
> I'm not sure it's _obscure_, but it is relatively new. It's even
> documented. ;)
> https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

I'm one of those people who doesn't read documentation, I read code.

I also flat out refuse to read any documentation that isn't plain text.

> > I can't, nor do I want to, remember all these stupid little macros. Esp.
> > not for trivial things like this.
> 
> Well, the good news is that other folks will (and are) fixing them for
> you. :) Even if you never make mistakes with flexible arrays, other
> people do, and so we need to take on some improvements to the robustness
> of the kernel source tree-wide.

But nobody helps me read the code when I trip over crap like this :/ Why
do we have to have endless silly helpers for things that can be
trivially expressed in regular C? I appreciate things like
container_of() because if you write that out it's a mess, but this, very
much not so.

	struct_size(grp, faults, NR_NUMA_HINT_FAULTS_STATS * numa_node_ids);

vs

	sizeof(*gfp) + sizeof(grp->faults) * NR_NUMA_HINT_FAULT_STATS * nr_node_ids;

The latter wins hands down, instantly obvious what it does while with
the former I'd have to look up the macro.
