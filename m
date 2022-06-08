Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF48543FDD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 01:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiFHX3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 19:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiFHX3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 19:29:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63F741327;
        Wed,  8 Jun 2022 16:29:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C37361978;
        Wed,  8 Jun 2022 23:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E29C341C6;
        Wed,  8 Jun 2022 23:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654730956;
        bh=BwfF1KNfBMDFRw1G8F0dE9LDnE5awSaF2PVXP/gt4Ws=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XEQ8Z6QrYKsV530PxXkWMeVQkX77oh5Y5g03sjDAVpbSTLp6x5zXyxhTrr56HR4MP
         kKnGnmhgZYp4IDiRdQUyvA6WD0qtA8IH5tJ4AuUmojIjC0AsJ2w5LFouL3TFi38Oa+
         12a7cDeTxlCNM2ZmBaJOdr2u00NVYfhX0lo6hCzHbXm8m9iHobBAo5eJmth8tWI23V
         bNwlvq8zZU40LJI4jk5BVjzcypFjEtLlGCawHUvzDUfN/b4z2gm15jc0FFQU23/XNd
         DBEP5Ws/kETXFO7ivVT7zi6m8fpBtYnGfHgLDqWk8lVwFUyLkSBOykVFWpojhIrNky
         Se9COhkLHGMkA==
Received: by mail-vs1-f47.google.com with SMTP id j39so147984vsv.11;
        Wed, 08 Jun 2022 16:29:16 -0700 (PDT)
X-Gm-Message-State: AOAM5334DgrOz0zYnIzDkaLPUEDStSCU/WgzyE2I76Ez6nflD7p0F8k9
        wJB7XwkCf6D6FU/SgodHMPilKfylPGBDRYX2wg==
X-Google-Smtp-Source: ABdhPJyP/rvIGNUNWWY5/PywiiFUinhz+dD05q76j2QTz3s7E9nR0oViuk8WHmmTvD9VE0fWC9uWM7qt1dUSePMveSM=
X-Received: by 2002:a67:f28d:0:b0:34b:a293:a6fe with SMTP id
 m13-20020a67f28d000000b0034ba293a6femr10559305vsk.26.1654730955350; Wed, 08
 Jun 2022 16:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220608224353.1176079-1-irogers@google.com> <20220608224353.1176079-4-irogers@google.com>
In-Reply-To: <20220608224353.1176079-4-irogers@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 8 Jun 2022 17:29:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLUCkF_HwCyuWNZ2dw2Aw57RRfuKS8rqgnKQwQrvBwKiw@mail.gmail.com>
Message-ID: <CAL_JsqLUCkF_HwCyuWNZ2dw2Aw57RRfuKS8rqgnKQwQrvBwKiw@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf test: Remove x86 rdpmc test
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 4:44 PM Ian Rogers <irogers@google.com> wrote:
>
> This test has been superseded by test_stat_user_read in:
> tools/lib/perf/tests/test-evsel.c
> The updated test doesn't divide-by-0 when running time of a counter is
> 0. It also supports ARM64.

Jiri objected to this when I did the same thing[1] as 'perf test'
doesn't run libperf tests.

Rob

[1] https://lore.kernel.org/all/20200831091113.GA406859@krava/
