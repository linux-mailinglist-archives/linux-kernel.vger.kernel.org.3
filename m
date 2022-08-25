Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647015A198B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbiHYTbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiHYTbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:31:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCFDAE215;
        Thu, 25 Aug 2022 12:31:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13FA161DAD;
        Thu, 25 Aug 2022 19:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B22C433D6;
        Thu, 25 Aug 2022 19:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661455905;
        bh=tOZXL5MQVK/aIsTN1qyhLBiIqQOmCvdFTX9EltG3Wfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o6FLbZIakoMXFvEhW+rVEpyPPvY1S5UyU54rLzwO3PCdAZpAKg2JUBKjW528IYEGD
         HvzKxWZ+ETbdaj4sjsfMBJ8kCS8ttF900LkqTDPIblxlpmek205wYikjJu7r0CU4Lq
         qxlm7yswEYhWYKXYQ3BzMpkho7rHL2vXWOnPm1X0o7XSSuKlERocORpsovG2EPH4+Q
         pwan/IwHcUpP+sO/+mEe3E+lFAs3MSojfVF1fhXi8ZXUSIrxlgKStgdhUiyvMtFFz0
         zRaMVn85ePAgDIlVZF6LVIaRFs+FxFydjRAoRT56NVQL5YL+z4lbNaMdPBx/eliVyP
         eFMb0Rx13EOWQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1AE6B404A1; Thu, 25 Aug 2022 16:31:42 -0300 (-03)
Date:   Thu, 25 Aug 2022 16:31:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH RFC v1 2/3] perf: Add perf_event_attr::config3
Message-ID: <YwfOHjw/VsIJOPjt@kernel.org>
References: <20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org>
 <20220825-arm-spe-v8-7-v1-2-c75b8d92e692@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825-arm-spe-v8-7-v1-2-c75b8d92e692@kernel.org>
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

Em Thu, Aug 25, 2022 at 01:08:01PM -0500, Rob Herring escreveu:
> Arm SPEv1.2 adds another 64-bits of event filtering control. As the
> existing perf_event_attr::configN fields are all used up for SPE PMU, an
> additional field is needed. Add a new 'config3' field.

Try not to have tools/ and kernel code in the same patch, else you'll
burden kernel developers into testing tools/, which so far has been
refrained.

First you get the kernel bits in, then tooling.

Locally of course you test it together.

- Arnaldo
 
> Signed-off-by: Rob Herring <robh@kernel.org>
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 03b370062741..b53f9b958235 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -333,6 +333,7 @@ enum perf_event_read_format {
>  #define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
>  #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
>  #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
> +#define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
>  
>  /*
>   * Hardware event_id to monitor via a performance monitoring event:
> @@ -474,6 +475,8 @@ struct perf_event_attr {
>  	 * truncated accordingly on 32 bit architectures.
>  	 */
>  	__u64	sig_data;
> +
> +	__u64	config3; /* extension of config2 */
>  };
>  
>  /*
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index 581ed4bdc062..7fad17853310 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -333,6 +333,7 @@ enum perf_event_read_format {
>  #define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
>  #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
>  #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
> +#define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
>  
>  /*
>   * Hardware event_id to monitor via a performance monitoring event:
> @@ -474,6 +475,8 @@ struct perf_event_attr {
>  	 * truncated accordingly on 32 bit architectures.
>  	 */
>  	__u64	sig_data;
> +
> +	__u64	config3; /* extension of config2 */
>  };
>  
>  /*
> 
> -- 
> b4 0.10.0-dev

-- 

- Arnaldo
