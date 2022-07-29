Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782005853BC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 18:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbiG2QoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 12:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbiG2QoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 12:44:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA4A21251;
        Fri, 29 Jul 2022 09:44:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF0BC61E42;
        Fri, 29 Jul 2022 16:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B514C433C1;
        Fri, 29 Jul 2022 16:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659113061;
        bh=mJkE7iNiddS10SeRQUk9T+q+s6pC//HflqXIEWLh3p8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TnnYviSFsIuiDKSaa8PsBlobhxXtp6QbUnj5EKYi2FKQw9feY0Lgg/0vAj9SSD0+H
         aND2+TWsdeeNI1nt6eClOMybsiKqho42uGCb8E9T9r+ZQIQzHERCyz57RD/wwpj4u/
         y5hoglZx1HqADvvoHfhTVAX78MOjF9wk+0RENp9fnkwd8mUxKFHu2GfTOhQlhzytck
         5UyE/KzjjiRYNR9/csqAiiI+Etj/WQBiscsLlSyVg5kWqTqzukdsk7FIaVNYYeYMsE
         z6yz+ms4pkt1AnUsDciBdUNygcizNmHE9dPy2qgpRxevY4koPL8AEpEdqWH4IZ5FvB
         +xm7hAFIn2SPw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5B78240736; Fri, 29 Jul 2022 13:44:17 -0300 (-03)
Date:   Fri, 29 Jul 2022 13:44:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     zhengjun.xing@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com
Subject: Re: [PATCH v4 0/5] Add perf stat default events for hybrid machines
Message-ID: <YuQOYdljpS5Og3Yz@kernel.org>
References: <20220721065706.2886112-1-zhengjun.xing@linux.intel.com>
 <CAP-5=fUJ2KaxLXwUhyTtAZhwQ=M=QEv4_tP6y5CU08tf_uKAnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUJ2KaxLXwUhyTtAZhwQ=M=QEv4_tP6y5CU08tf_uKAnA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 29, 2022 at 08:03:20AM -0700, Ian Rogers escreveu:
> On Wed, Jul 20, 2022 at 11:56 PM <zhengjun.xing@linux.intel.com> wrote:
> >
> > From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> >
> > The patch series is to clean up the existing perf stat default and support
> > the perf metrics Topdown for the p-core PMU in the perf stat default. The
> > first 4 patches are the clean-up patch and fixing the "--detailed" issue.
> > The last patch adds support for the perf metrics Topdown, the perf metrics
> > Topdown support for e-core PMU will be implemented later separately.
> >
> > Kan Liang (4):
> >   perf stat: Revert "perf stat: Add default hybrid events"
> >   perf evsel: Add arch_evsel__hw_name()
> >   perf evlist: Always use arch_evlist__add_default_attrs()
> >   perf x86 evlist: Add default hybrid events for perf stat
> >
> > Zhengjun Xing (1):
> >   perf stat: Add topdown metrics in the default perf stat on the hybrid
> >     machine
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

