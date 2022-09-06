Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48875AE90A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbiIFNFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240191AbiIFNFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:05:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CDA28E13
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:05:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7164D6151E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08ACC433D6;
        Tue,  6 Sep 2022 13:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662469503;
        bh=aJ/ggvrr1g/FXyRjt5ZZskpEza67VcSQAtaqzjZ3K78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eJ/9CcwD5GXX7BNonXoZo2bL1kmptEgn7JqMDnj+/tTEzom/kEcBdRNWC9zt8JGmM
         6QgumB9IcNatIRqjWO/xa/rwYx1WXJRIygaWJjqmwg91nBBcr4V/SqVmmzHObV60fi
         CdxK955+iya2sk9J/rz4i5kh4mXFRg+nk2zEVkVpIU72Ch3PvPcGrYId+PoVtijpeO
         3uXI2/bMp7fDN2iMKr3w1r7aFXBdtEdsfBzos3rtdvk1g/5XM3bncPuCWjtzsQ/ZfF
         T7jRL1cuJ6TctU+BFsXomg8+sI3Qq3IS66GjlIBKvg1N0+OfxURdg91kyZG+DBSZIy
         1Rb0cJ8WXCb7A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 30E2B404A1; Tue,  6 Sep 2022 10:05:01 -0300 (-03)
Date:   Tue, 6 Sep 2022 10:05:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] perf intel-pt: Support itrace option flag d+e to
 log on error
Message-ID: <YxdFfVbDcwnT7DXm@kernel.org>
References: <20220905073424.3971-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905073424.3971-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 05, 2022 at 10:34:18AM +0300, Adrian Hunter escreveu:
> Hi
> 
> Here are a few patches to add the ability to output the decoding debug log
> only when there are decoding errors.
> 
> This is motivated by the fact that a full log can be very large, so just
> getting interesting bits is useful for analyzing errors.
> 
> If necessary, the size of output on error is configurable via perf config,
> and perf_config_scan() was added in the 1st patch to make that simpler.
> 
> The 2nd patch adds the new option flag to auxtrace.
> 
> There are a couple of very minor and essentially unrelated changes in
> patches 3 and 4.
> 
> The main Intel PT change is in patch 5 and there is a small example in the
> commit message.
> 
> 
> Changes in V2:
> 
>       perf intel-pt: Support itrace option flag d+e to log on error
> 	Ensure log_buf is defined before use
> 
>       perf intel-pt: Remove first line of log dumped on error
> 	Remove first line only if the buffer has wrapped

Applied locally, Namhyung: I think your review comment was addressed,
right? If so can I add your Reviewed-by to all the patches in this
series?

- Arnaldo
 
> 
> Adrian Hunter (6):
>       perf tools: Add perf_config_scan()
>       perf auxtrace: Add itrace option flag d+e to log on error
>       perf intel-pt: Improve man page layout slightly
>       perf intel-pt: Improve object code read error message
>       perf intel-pt: Support itrace option flag d+e to log on error
>       perf intel-pt: Remove first line of log dumped on error
> 
>  tools/perf/Documentation/itrace.txt             |   1 +
>  tools/perf/Documentation/perf-config.txt        |   7 ++
>  tools/perf/Documentation/perf-intel-pt.txt      |  13 ++-
>  tools/perf/util/auxtrace.c                      |  13 +++
>  tools/perf/util/auxtrace.h                      |   3 +
>  tools/perf/util/config.c                        |  31 +++++++
>  tools/perf/util/config.h                        |   1 +
>  tools/perf/util/intel-pt-decoder/intel-pt-log.c | 117 +++++++++++++++++++++++-
>  tools/perf/util/intel-pt-decoder/intel-pt-log.h |   3 +-
>  tools/perf/util/intel-pt.c                      |  23 ++++-
>  10 files changed, 206 insertions(+), 6 deletions(-)
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
