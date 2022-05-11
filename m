Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA1F5234D0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243136AbiEKN5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244327AbiEKN5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:57:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5978D4755F;
        Wed, 11 May 2022 06:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8bafPVpeXgttnp0NnvgkWAZnnHNGWJEw+q1LuEA1XVE=; b=PgtUhcQVkIAqRO3ULeZVr6yhOc
        wbqqsexomZ6YO/UDSDcR6QdG4PWCjGeBfHnk7Z5/OuUccmJGygI+1sPteJruESD5+f6ql6e1jMmO9
        rcO1nQjJdVkiOYpjKvlbrWWw04gD5r2eiwmgOJ5sBgc6Ees+sS78Pvo2hHqR2oFyoMI8cNOTYbizB
        EJjBmeWHyDpAwTgSQFsORs6149JstbAP8DCjV3ef1O4mcir+lDt4wZNrkBN2k5TSa8VJtZUigAEuf
        MR7fHiL4nwGs2Qc4r157vdGRY6rGA2nsegya5rPg6uCY7KQwXhKvX4CmyhmH6qcWdKVrxfTeP7wsz
        O4Tx9Tpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nomox-005UpG-Qv; Wed, 11 May 2022 13:56:07 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69200980E5D; Wed, 11 May 2022 15:56:05 +0200 (CEST)
Date:   Wed, 11 May 2022 15:56:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 0/7] Rewrite jevents program in python
Message-ID: <20220511135605.GA76023@worktop.programming.kicks-ass.net>
References: <20220511070133.710721-1-irogers@google.com>
 <20220511073501.GW76023@worktop.programming.kicks-ass.net>
 <CAP-5=fVoZSusNWfpYDpHvbxF=J0-a2jF+TpxEYLxmtWx6QFZ7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVoZSusNWfpYDpHvbxF=J0-a2jF+TpxEYLxmtWx6QFZ7A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 06:50:59AM -0700, Ian Rogers wrote:
> On Wed, May 11, 2022 at 12:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, May 11, 2022 at 12:01:26AM -0700, Ian Rogers wrote:
> >
> > > The changes here switch from jevents.c to a rewrite in python called
> > > jevents.py. This means there is a build time dependency on python, but
> > > such a dependency already exists for asciidoc (used to generate perf's
> > > man pages).
> >
> > You mean just building perf (not the docs) will now require snake stuff?
> >
> > That's very tedious :/ I don't typically have snakes on my machines.
> 
> Hi Peter,
> 
> You're right that after these changes python is a build requirement
> for jevents. We could keep the C code around for the case that python
> isn't there, but I want to do things like remove the string
> relocations, sort the events by name so we don't linearly search, etc.
> which would be a massive chore to keep alive on the C side. An
> alternative would be to have an empty pmu-events.c file that is used
> for this case. If you wanted to keep things in C and have jevents like
> event names, you could use the empty version and link in libpfm4.

I'm not normally linking to libpfm4. All I really care about is that I
can still build a bare cli perf (not even tui). If all the snake stuff
is purely optional and it just disables some features, but I do get a
perf out at the end, then I'm all good.


