Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A027D57BE05
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiGTSqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiGTSp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:45:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A7CDF0B;
        Wed, 20 Jul 2022 11:45:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7357B821B4;
        Wed, 20 Jul 2022 18:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F990C3411E;
        Wed, 20 Jul 2022 18:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658342755;
        bh=BPQTo+ZMfUwnwE9+Ibb9aPcdaThaA2NZNCEJsUhFYb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rpiu+lMOe7LQw/XQwmcjijloEwn1YnudjjKKMYUVSvWT5SbnUfgaZeMK62bUm7xXf
         2f/mreg3MhoNdFgbpQBx4qWmwVKQMXhtql6GqzEWknr211aiFb7V+wStgsWkXdVS6y
         wlJB7BQXhhJkhuXpSE92LzZS53GZEETkB4RzTkZDDsZMlc1qCLQRmpsKMXq8ciGny0
         GZGz74tOKpaVKXCo465haSW5yfeKCWgyAdf8IbdIb2/KymyjAC1uZMnJg3YjKPUYPd
         W9POy3dIVtWdg7MNvqjbLxRRfRJz4irpSIpI6Cj8t01nP9UhmlEsUS+jtN+zrqO17n
         g9BUMvIwM/weg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A625E40374; Wed, 20 Jul 2022 15:45:51 -0300 (-03)
Date:   Wed, 20 Jul 2022 15:45:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kajol Jain <kjain@linux.ibm.com>
Subject: Re: [PATCH v5 01/17] perf: Add SNOOP_PEER flag to perf mem data
 struct
Message-ID: <YthNXweIEdNfcoX1@kernel.org>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
 <20220604042820.2270916-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604042820.2270916-2-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jun 04, 2022 at 12:28:04PM +0800, Leo Yan escreveu:
> From: Ali Saidi <alisaidi@amazon.com>
> 
> Add a flag to the perf mem data struct to signal that a request caused a
> cache-to-cache transfer of a line from a peer of the requestor and
> wasn't sourced from a lower cache level.  The line being moved from one
> peer cache to another has latency and performance implications. On Arm64
> Neoverse systems the data source can indicate a cache-to-cache transfer
> but not if the line is dirty or clean, so instead of overloading HITM
> define a new flag that indicates this type of transfer.
> 
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Hey, any knews about this going upstream? PeterZ?

- Arnaldo

> ---
>  include/uapi/linux/perf_event.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index d37629dbad72..7b88bfd097dc 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -1310,7 +1310,7 @@ union perf_mem_data_src {
>  #define PERF_MEM_SNOOP_SHIFT	19
>  
>  #define PERF_MEM_SNOOPX_FWD	0x01 /* forward */
> -/* 1 free */
> +#define PERF_MEM_SNOOPX_PEER	0x02 /* xfer from peer */
>  #define PERF_MEM_SNOOPX_SHIFT  38
>  
>  /* locked instruction */
> -- 
> 2.25.1

-- 

- Arnaldo
