Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08E347BECB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbhLULV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbhLULV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:21:59 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74ECC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 03:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h/1jCTTprJQtIMsCfPUfXow4tl5XPnfP0BfgxIdMdjI=; b=glWm5qBcjxcCMwcY0p88TsHtKw
        G2cHr9fsXevCxqp+ggwVeMfNzIKFQ2Moh2kfh8J4Qiy05iQgo4gAKj+DxnJ7+Cy9uCTaBgy+i6Ym7
        gET5qtZFexhBovuEgL0d9mfz60UCp5ABlxGT/4l7pjPAnKFNlcRm+q9t3scOevZZjIJpRgq49Yt9D
        Ps9SJDuGPFtVY7F6OW70Y3Jb2+mOFcBG9MGtevwg4WcWH3pT8GJcCI5fsylr33evhhW3z1Du/2OoU
        DVx5o4E1BL2utbTZOC7RZGke+3TF3aT7crrdVjjMm0nzRtLuXHMIs32xo3fdna+fKZE3r4gpt4rYA
        LcVv5KGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzdD9-002its-JP; Tue, 21 Dec 2021 11:21:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A08EE30003C;
        Tue, 21 Dec 2021 12:21:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B6503005A8F7; Tue, 21 Dec 2021 12:21:38 +0100 (CET)
Date:   Tue, 21 Dec 2021 12:21:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v3] perf/core: Set event shadow time for inactive events
 too
Message-ID: <YcG4wilm6xcTKn74@hirez.programming.kicks-ass.net>
References: <20211205224843.1503081-1-namhyung@kernel.org>
 <YbHn6JaaOo3b5GLO@hirez.programming.kicks-ass.net>
 <CAM9d7ciJTJB1rumzmxGeJrAdeE9R4eXhtJRUQGj9y6DBN-ovig@mail.gmail.com>
 <20211210103341.GS16608@worktop.programming.kicks-ass.net>
 <Yby8Su+fVA1lqVjT@hirez.programming.kicks-ass.net>
 <YcB06DasOBtU0b00@hirez.programming.kicks-ass.net>
 <DC7F1B1E-99DB-4121-91C5-EEB51FBFA7A9@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC7F1B1E-99DB-4121-91C5-EEB51FBFA7A9@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 07:23:16AM +0000, Song Liu wrote:

> I think we need to forward the declaration of calc_timer_values?

Curse these last minute cleanups :-) I've moved the whole function up.

> With that fixed, this passes the test for enabled time. 
> 
> Tested-by: Song Liu <song@kernel.org>

Thanks both!
