Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841D659086D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 23:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbiHKV4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 17:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbiHKVz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:55:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04A322B0E;
        Thu, 11 Aug 2022 14:55:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AEDEB822B6;
        Thu, 11 Aug 2022 21:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35ACBC433C1;
        Thu, 11 Aug 2022 21:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660254951;
        bh=kTbxGObabGQ7EanYHkFw676cjQFD3rZRIfyyXUv4DWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DqD1Xrg7/BnTj/0gIoVbtBcyyD7xzqTatQSOW8qrfDeT/viTgx5yctdUMm/mdQNDA
         E4YJv5TFZbsm1NBvJV3E0eMf9kPuWMfoULBdHKbu/denOGcmYl3oQxEhJPDTwuM+SS
         OWC6GSM2Hw8Knzyxw7M64gxwdtBh7HI7EcUdn41rdRPvmuTU0NnszvQQjkFGSTZMCy
         gYRNS6q/Gsikik35+jdfWiTiklYILURPRkKJcbiRAae3OcknoDDf/WANavpj2DZfxC
         jWC8aeggaF5/FpGQQl8/X14/dZLNAa78pFzoi5hUp2kuibFuA4APm0zeOKs57HQs3X
         paUX28BzZARzg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1455A4035A; Thu, 11 Aug 2022 18:55:48 -0300 (-03)
Date:   Thu, 11 Aug 2022 18:55:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ian Rogers <irogers@google.com>, Like Xu <likexu@tencent.com>,
        German Gomez <german.gomez@arm.com>,
        Timothy Hayes <timothy.hayes@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 01/15] perf tools: sync addition of
 PERF_MEM_SNOOPX_PEER
Message-ID: <YvV65OewRk9YJP5K@kernel.org>
References: <20220811062451.435810-1-leo.yan@linaro.org>
 <20220811062451.435810-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811062451.435810-2-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 11, 2022 at 02:24:37PM +0800, Leo Yan escreveu:
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

I'm adding a:

Signed-off-by: Leo Yan <leo.yan@linaro.org>

To the patches you're sending that you are not the original author, as
per defined in:

Documentation/process/submitting-patches.rst

---
The Signed-off-by: tag indicates that the signer was involved in the
development of the patch, or that he/she was in the patch's delivery path.
---

If you disagree and want to retract the patch, please let me know, this
so far is speculative and is only on my local branch for testing.

- Arnaldo

> ---
>  tools/include/uapi/linux/perf_event.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index 4653834f078f..e2b77fbca91e 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
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
> 2.34.1

-- 

- Arnaldo
