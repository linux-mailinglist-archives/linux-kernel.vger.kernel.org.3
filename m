Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFC24B6ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbiBOO1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:27:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiBOO1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:27:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179D7CD322
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:27:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9237B6177F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC95C340F1;
        Tue, 15 Feb 2022 14:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644935258;
        bh=K8CwRMcEe6pZjcF6+lE5iZELKSpvgn/qaNeXWqgk7bE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mAEwGL0A5PgKjx2HZKhRNj/Qy0qlfd/6tCfNLopkbWB6JwtYBNj0J8lu6pV1sjTQI
         32D7WtYskHlUdhi7hkCQCEc/uMmq/WM6e4Q3IDovmAV5vgIn6Nf6+eYGYkRTkH9OIM
         siZ6DLEcDDf2LPhl0FtdLyG0o4F91hkahBu5FQTwvLhI3mJCjAh18S/uefXnrJpr1V
         7yjGPDO4vocfa0PFE1D+aP3EpVt2hG+fda9htNZ3EE6ZsIie/54NeuqCEchjv/YhRX
         6BpAP7eMx15jKaLLNn0U3d5rNbyDvDBcrw/1bALniC/u+Mu9WZkN+GkHTI8+htZ26R
         mCzuwtX2zlReA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A36D4400FE; Tue, 15 Feb 2022 11:27:34 -0300 (-03)
Date:   Tue, 15 Feb 2022 11:27:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/25] perf intel-pt: Add support for Event Trace and TNT
 disable
Message-ID: <Ygu4VgqvrEyWgMqu@kernel.org>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 24, 2022 at 10:41:36AM +0200, Adrian Hunter escreveu:
> Hi
> 
> Brief documentation is in the last patch with more technical details in
> Intel SDM (https://www.intel.com/sdm) version 076.
> 
> The patches touch mostly Intel PT and auxtrace code, with a few supporting
> changes to perf script.
> 
> I am not aware of any hardware that has the new capabilities yet.
> 
> Patches can also be found here:
> 
> 	https://github.com/ahunter6/linux/tree/event-trace
> 

Thanks, applied.

- Arnaldo

 
> Adrian Hunter (25):
>       perf intel-pt: pkt-decoder-test: Fix scope of test_data
>       perf intel-pt: pkt-decoder: Remove misplaced linebreak
>       perf intel-pt: pkt-decoder: Add CFE and EVD packets
>       perf intel-pt: pkt-decoder: Add MODE.Exec IFLAG bit
>       perf intel-pt: decoder: Add config bit definitions
>       perf intel-pt: decoder: Factor out clearing of FUP event variables
>       perf intel-pt: decoder: Add CFE and EVD processing
>       perf intel-pt: decoder: Add MODE.Exec IFLAG processing
>       perf tools: Define Intel PT CFE / EVD event
>       perf tools: Define Intel PT iflag synthesized event
>       perf tools: Define new D and t flags
>       perf auxtrace: Add itrace option "I"
>       perf intel-pt: Record Event Trace capability flag
>       perf intel-pt: Synthesize CFE / EVD event
>       perf intel-pt: Synthesize iflag event
>       perf intel-pt: Synthesize new D and t flags
>       perf intel-pt: Force 'quick' mode when TNT is disabled
>       perf script: Display Intel PT CFE / EVD synthesized event
>       perf script: Display Intel PT iflag synthesized event
>       perf script: Display new D and t flags
>       perf scripts python: intel-pt-events.py: Add Event Trace
>       perf scripting python: Add all sample flags to DB export
>       perf scripts python: export-to-sqlite.py: Export all sample flags
>       perf scripts python: export-to-postgresql.py: Export all sample flags
>       perf intel-pt: Add documentation for Event Trace and TNT disable
> 
>  tools/perf/Documentation/itrace.txt                |   2 +
>  tools/perf/Documentation/perf-intel-pt.txt         | 104 ++++++++-
>  tools/perf/Documentation/perf-script.txt           |  13 +-
>  .../arch/x86/tests/intel-pt-pkt-decoder-test.c     |  17 +-
>  tools/perf/arch/x86/util/intel-pt.c                |   7 +
>  tools/perf/builtin-script.c                        |  78 ++++++-
>  tools/perf/scripts/python/export-to-postgresql.py  |  17 +-
>  tools/perf/scripts/python/export-to-sqlite.py      |  19 +-
>  tools/perf/scripts/python/intel-pt-events.py       |  55 ++++-
>  tools/perf/util/auxtrace.c                         |   4 +
>  tools/perf/util/auxtrace.h                         |   4 +
>  tools/perf/util/event.h                            |  45 +++-
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 245 +++++++++++++++++++--
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |  21 ++
>  .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   |  47 +++-
>  .../util/intel-pt-decoder/intel-pt-pkt-decoder.h   |   3 +
>  tools/perf/util/intel-pt.c                         | 164 +++++++++++++-
>  .../util/scripting-engines/trace-event-python.c    |   3 +-
>  18 files changed, 779 insertions(+), 69 deletions(-)
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
