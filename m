Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B7B513528
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 15:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347216AbiD1NeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 09:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347167AbiD1NeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 09:34:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584786378;
        Thu, 28 Apr 2022 06:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A98A460DE9;
        Thu, 28 Apr 2022 13:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E685DC385A9;
        Thu, 28 Apr 2022 13:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651152667;
        bh=DnP9exkGhsGYgxJxwNecTILtYI5DRDFnOujuiuYepj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A0aH/+ToIT48OzvZCW1iw33zWkGyK4bwq/us6yc9vdyyWwlPjTM7SeMkSWT6GBDj8
         ofsXran7qP2k2IaWgpA/aNvpQlSiKEqsjcEoBUumZMBBzoN466NLksAyIYcREiKs9i
         QaQQW7Hp/1vx8yUH6LNjCFBne4DoL/3lNp0LrbNJVH+LNh/mqTvu4h0w4mkgz7BU/G
         a9OD0ZZjhkSU7ButZS9w3C64i86mYgMHUnMKMLwTkjsD/DTHxwF5CHgGGSLDIQ+B5m
         og97rBUTxFfb+H19gb8deojTOIQaOd8XzBBoL1jTm7PvoOp0iCpRC5v25YQlMdxgB7
         EGXsIxd0StTMw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5C017400B1; Thu, 28 Apr 2022 10:31:04 -0300 (-03)
Date:   Thu, 28 Apr 2022 10:31:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/7] perf vendor events intel: Update CLX events to v1.15
Message-ID: <YmqXGCMbBOLcd261@kernel.org>
References: <20220428075730.797727-1-irogers@google.com>
 <96b5c9f4-f0a0-0019-8059-3e833c95b011@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96b5c9f4-f0a0-0019-8059-3e833c95b011@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 28, 2022 at 09:12:26AM -0400, Liang, Kan escreveu:
> 
> 
> On 4/28/2022 3:57 AM, Ian Rogers wrote:
> > Events are generated for CascadeLake Server v1.15 with
> > events from:
> > https://download.01.org/perfmon/CLX/
> > 
> > Using the scripts at:
> > https://github.com/intel/event-converter-for-linux-perf/
> > 
> > This change updates descriptions, adds INST_DECODED.DECODERS and
> > corrects a counter mask in UOPS_RETIRED.TOTAL_CYCLES.
> > 
> > Signed-off-by: Ian Rogers<irogers@google.com>
> 
> Thanks Ian. For the whole series,
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks, applied.

- Arnaldo

