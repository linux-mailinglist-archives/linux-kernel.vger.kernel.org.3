Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E103449BDE5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiAYVcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiAYVcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:32:53 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1EFC06173B;
        Tue, 25 Jan 2022 13:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=klGnJioOcgDKO/TJKK9IN06R18s20W+7JvkgdEv4Aw4=; b=qIoYpP71UhPHE0K6vzujD18XKY
        7SZzWx6zDIvvHkm9p/b7r9nm8aBtuGldnLOZQLopnx1bdHrmVGn91GDbOFj4oHwrClngRjCrW5A3T
        Cg/ea39ydmIASfDUj2/J22tIlEPgnRQN5a97KLRX4iXLuLVgoA9FAvxAnF+eNg78cys2yI1POMgiB
        2nEzh91MCuMOwMcjMNktKbkKUM/81yNMZit+OPVr1YCm/rx3TlcbqvMUdm/g+6NOs2MPl9cszqqrx
        NSXHC9aJE72mOsenqa1alw3Zx3F0XCuhDfHRA/DLp5NDcXI7Am1nsHFN+CEZB8lwHXR4fTxS91R4g
        hbYjyhwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCTQX-003Zaf-Pi; Tue, 25 Jan 2022 21:32:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AAB4F3002FC;
        Tue, 25 Jan 2022 22:32:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 928D620172667; Tue, 25 Jan 2022 22:32:31 +0100 (CET)
Date:   Tue, 25 Jan 2022 22:32:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] perf/x86/rapl: replace 0 with NULL to initialize
 pointers
Message-ID: <YfBsb/3fR7v7tnr4@hirez.programming.kicks-ass.net>
References: <20220125201403.670011-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125201403.670011-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 08:14:03PM +0000, Colin Ian King wrote:
> Pointers should be initialized with NULL rather than zero. Fix these.

Why ? This isn't C++, heck, this isn't even C, this is the kernel, we
hard rely on NULL being 0.
