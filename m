Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9AA52EDEB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350181AbiETOQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbiETOPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:15:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C63201;
        Fri, 20 May 2022 07:15:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25FB1B82B4F;
        Fri, 20 May 2022 14:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2B2C385A9;
        Fri, 20 May 2022 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653056150;
        bh=2/f9dMyLp9yCKVz+6/1S/e0nzkuFIkzjpaxNCSNnScs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TsjSxRlrGKZ5eF2ZKArkoXb3l3WquR2IGQRmzREnKrlQuLzSdKgTvS6T8JwSvAiRV
         AyMgqJhLDMahYlE2MNPhLkHBhYxFOkuO4KM/But6ZcYqK+c3bJepFBb7WHpGqwE1Zi
         3mlFANrQyk41dEEr04WDEIPLuJTPPaAEU87+Va9J3BrGmVeVXk63tSMB8Qt2E7YLJJ
         DWBDD07eZ9yRARagA8GOU1ifmRVgdVisMU+8TOUU5DTIJcdlIlJreGaPm7KWgTIXNv
         996knJiyZHC47jpfNiHydgUGVvnfZD27vQW39266j96TyNdoM4OIPT8f27QirO8CwO
         FcSj+WNO7qYlA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4804E400B1; Fri, 20 May 2022 11:15:48 -0300 (-03)
Date:   Fri, 20 May 2022 11:15:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, irogers@google.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        zhengjun.xing@linux.intel.com, adrian.hunter@intel.com,
        ak@linux.intel.com, eranian@google.com
Subject: Re: [PATCH V3 0/4] Several perf metrics topdown related fixes
Message-ID: <YoeilN7HLeXckAb2@kernel.org>
References: <20220518143900.1493980-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518143900.1493980-1-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 18, 2022 at 07:38:56AM -0700, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The Patch 1 is a follow-up patch for Ian's ("Fix topdown event weak
> grouping")[1].
> 
> The patch 2 is to fix the perf metrics topdown events in a mixed group.
> It reuses the function introduced in [1].
> Patch 1 & 2 should be on top of [1].
> 
> The patch 3 & 4 are to fix other perf metrics topdown related issues.
> They can be merged separately.
> 
> [1]: https://lore.kernel.org/all/20220517052724.283874-2-irogers@google.com/

Thanks, applied.

- Arnaldo

 
> Changes since V2:
> - Add more comments for the evsel__sys_has_perf_metrics() and
>   topdown_sys_has_perf_metrics()
> - Remove the uncessary evsel->core.leader->nr_members = 0; in patch 2.
>   The value has been updated in the new evsel__remove_from_group().
> - Add Reviewed-by from Ian for patch 4
> 
> Changes since V1:
> - Add comments for the evsel__sys_has_perf_metrics() and
>   topdown_sys_has_perf_metrics()
> - Factor out evsel__remove_from_group()
> - Add Reviewed-by from Ian for patch 3
> 
> Kan Liang (4):
>   perf evsel: Fixes topdown events in a weak group for the hybrid
>     platform
>   perf stat: Always keep perf metrics topdown events in a group
>   perf parse-events: Support different format of the topdown event name
>   perf parse-events: Move slots event for the hybrid platform too
> 
>  tools/perf/arch/x86/util/evlist.c  |  7 ++++---
>  tools/perf/arch/x86/util/evsel.c   | 23 +++++++++++++++++++++--
>  tools/perf/arch/x86/util/topdown.c | 25 +++++++++++++++++++++++++
>  tools/perf/arch/x86/util/topdown.h |  7 +++++++
>  tools/perf/builtin-stat.c          |  7 ++-----
>  tools/perf/util/evlist.c           |  6 +-----
>  tools/perf/util/evsel.c            | 13 +++++++++++--
>  tools/perf/util/evsel.h            |  2 +-
>  8 files changed, 72 insertions(+), 18 deletions(-)
>  create mode 100644 tools/perf/arch/x86/util/topdown.h
> 
> -- 
> 2.35.1

-- 

- Arnaldo
