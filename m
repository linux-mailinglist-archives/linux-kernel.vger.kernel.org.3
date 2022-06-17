Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D1254F7E0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381509AbiFQMyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbiFQMyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:54:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7233046B3A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GglKpfPd9lN3GBcVv/Sz0/4lZXc0GpxLpYwYdL+1knA=; b=e4f+uem8TAsjYNxxGrQe6P55xb
        FTuOCiIX6QvO1o86hDPXwFn3sv47oFAYeBH2UrPHkG8FGLThkWOhKvq66evkqkQe6Vj1FnYXBGx3z
        thuCoLtpZR6Jsmd/OqBnCiwAQNo96p2KbOX3mhzXa2oYT4BwY2f11n+iLR5So2TPTvKhKzBuDP6Ou
        xNtuijkFOSpQGXWn/LfzA3pD3B4bM0gYjMy4uuZNOLAUR/cs+CPMM5TzUT57n3/ewKO0u25krazvY
        c956JUC58PeeptO1qNN9O4/JyFUad7s+NkJEQOZa89FkXjlzTxsCmVJ+6SzoookqXnck9x4zQZyrG
        BW2YbN2Q==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2BTy-002qFZ-MA; Fri, 17 Jun 2022 12:53:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 757749816B5; Fri, 17 Jun 2022 14:53:48 +0200 (CEST)
Date:   Fri, 17 Jun 2022 14:53:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v4] perf/core: Add a new read format to get a number of
 lost samples
Message-ID: <Yqx5XPluXje13Ez/@worktop.programming.kicks-ass.net>
References: <20220616180623.1358843-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616180623.1358843-1-namhyung@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 11:06:23AM -0700, Namhyung Kim wrote:
> Sometimes we want to know an accurate number of samples even if it's
> lost.  Currenlty PERF_RECORD_LOST is generated for a ring-buffer which
> might be shared with other events.  So it's hard to know per-event
> lost count.
> 
> Add event->lost_samples field and PERF_FORMAT_LOST to retrieve it from
> userspace.
> 
> Original-patch-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---

Looks OK I suppose. Bit sad to get an unconditional atomic on the lost
path, but then again, we shouldn't be hitting that in the first place.

Thanks!
