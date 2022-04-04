Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CAA4F1BAA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380800AbiDDVWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379006AbiDDQRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:17:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1364381A7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:15:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nt14-20020a17090b248e00b001ca601046a4so5519694pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 09:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ng6DcmM5tFKWfxali81J0mfMImmzHiLurj6u/+uziLk=;
        b=HXOmZE1RtYgubAH+EbMo3I6hVyTda0n3RvWQxbxKNH9WsRFKu7ffxKRotQeemfaTy+
         WG93q2P5TZkBtIjyvteBW1gY4EKU+e3KpS9DVwKTTVZTeml5hMnQUgt3bk5gpOBLemRS
         ZIOtol1sPS1wc9qkY9x4s4R2dIVxjC141YGfSby1pY4lS6Ms5gekCEtxaIz1pKQ9j5Pn
         WERkByf/F8DiINZ4MxSYYF2EIUnuJRY4SDLhGN3Ftl9xIe97pX/973mh2CqajJK+ufJa
         9DW70uFOQ0kB5ih/FliBHjPYO9oXFC0gJGaxMmUtKDB2KuLJMmUWzCV2gqV6hEECZHQ5
         SjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ng6DcmM5tFKWfxali81J0mfMImmzHiLurj6u/+uziLk=;
        b=WtvmYHgy8p+w5/Itw2xSb55ZRr6P7XwWc18cdMFao1OxIIOV0MyVInEbl1BDxAF34h
         VBOLITE6tJ6vwH3yu/aBc4xSSSeAS3TumzqJn4y/L49QZ4lpweLZXqX9ol5TgwCfgCLH
         GVwzGByn5gPy/EgTBr2iTxC4JGn8X8c4V2S8UfeyEcFCXE7eJKUkS8We6Na04Vhi1m8E
         hBUcHE6LieRXYQ0zIpWSA6bBpKOVQtwTpAMVEJFAxfxdquapdjajtQ8FMRx2CSt0sbUq
         7bUGOuo9EecW16JaU1jR+m4TXHcWfpbkxtHpaic7ahSQkfqw0lqUbh6vy2rV3rnQGrRx
         62Hw==
X-Gm-Message-State: AOAM530db+1hqbNuLKH9/HyXSmhoo2XB+Q1NniWFzh9Rt2tnvKJKDWWD
        TzjcvbiTy4unAkbemFzHg7t06w==
X-Google-Smtp-Source: ABdhPJw0bHkRyQrMEI8u1Kx/EMowdX9JWrk1FT5MCnF8rKx/ah4P1uTx38JgRaEc8jLyOH5+qO/ukg==
X-Received: by 2002:a17:90b:713:b0:1c6:c8f5:6138 with SMTP id s19-20020a17090b071300b001c6c8f56138mr27342669pjz.138.1649088957115;
        Mon, 04 Apr 2022 09:15:57 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id p4-20020a637404000000b00375948e63d6sm10641282pgc.91.2022.04.04.09.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 09:15:56 -0700 (PDT)
Date:   Mon, 4 Apr 2022 10:15:54 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org
Subject: Re: [PATCH 00/10] coresight: Add new API to allocate trace source ID
 values
Message-ID: <20220404161554.GA4079910@p14s>
References: <20220308205000.27646-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308205000.27646-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

On Tue, Mar 08, 2022 at 08:49:50PM +0000, Mike Leach wrote:
> The current method for allocating trace source ID values to sources is
> to use a fixed algorithm for CPU based sources of (cpu_num * 2 + 0x10).
> The STM is allocated ID 0x1.
> 
> This fixed algorithm is used in both the CoreSight driver code, and by
> perf when writing the trace metadata in the AUXTRACE_INFO record.
> 
> The method needs replacing as currently:-
> 1. It is inefficient in using available IDs.
> 2. Does not scale to larger systems with many cores and the algorithm
> has no limits so will generate invalid trace IDs for cpu number > 44.
> 
> Additionally requirements to allocate additional system IDs on some
> systems have been seen.
> 
> This patch set  introduces an API that allows the allocation of trace IDs
> in a dynamic manner.
> 
> Architecturally reserved IDs are never allocated, and the system is
> limited to allocating only valid IDs.
> 
> Each of the current trace sources ETM3.x, ETM4.x and STM is updated to use
> the new API.
> 
> perf handling is changed so that the ID associated with the CPU is read
> from sysfs. The ID allocator is notified when perf events start and stop
> so CPU based IDs are kept constant throughout any perf session.
> 
> For the ETMx.x devices IDs are allocated on certain events
> a) When using sysfs, an ID will be allocated on hardware enable, and freed
> when the sysfs reset is written.
> b) When using perf, ID is allocated on hardware enable, and freed on
> hardware disable.
> 
> For both cases the ID is allocated when sysfs is read to get the current
> trace ID. This ensures that consistent decode metadata can be extracted
> from the system where this read occurs before device enable.
> 
> Note: This patchset breaks backward compatibility for perf record.
> Because the method for generating the AUXTRACE_INFO meta data has
> changed, using an older perf record will result in metadata that
> does not match the trace IDs used in the recorded trace data.
> This mismatch will cause subsequent decode to fail. Older versions of
> perf will still be able to decode data generated by the updated system.
> 

I have started looking at this set, comments to follow shortly.

Thanks,
Mathieu

> 
> Applies to coresight/next [b54f53bc11a5]
> Tested on DB410c
> 
> Mike Leach (10):
>   coresight: trace-id: Add API to dynamically assign trace ID values
>   coresight: trace-id: Set up source trace ID map for system
>   coresight: stm: Update STM driver to use Trace ID api
>   coresight: etm4x: Use trace ID API to dynamically allocate trace ID
>   coresight: etm3x: Use trace ID API to allocate IDs
>   coresight: perf: traceid: Add perf notifiers for trace ID
>   perf: cs-etm: Update event to read trace ID from sysfs
>   coresight: Remove legacy Trace ID allocation mechanism
>   coresight: etmX.X: stm: Remove unused legacy source trace ID ops
>   coresight: trace-id: Add debug & test macros to trace id allocation
> 
>  drivers/hwtracing/coresight/Makefile          |   2 +-
>  drivers/hwtracing/coresight/coresight-core.c  |  64 ++---
>  .../hwtracing/coresight/coresight-etm-perf.c  |  16 +-
>  drivers/hwtracing/coresight/coresight-etm.h   |   3 +-
>  .../coresight/coresight-etm3x-core.c          |  93 ++++---
>  .../coresight/coresight-etm3x-sysfs.c         |  28 +-
>  .../coresight/coresight-etm4x-core.c          |  63 ++++-
>  .../coresight/coresight-etm4x-sysfs.c         |  32 ++-
>  drivers/hwtracing/coresight/coresight-etm4x.h |   3 +
>  drivers/hwtracing/coresight/coresight-priv.h  |   1 +
>  drivers/hwtracing/coresight/coresight-stm.c   |  49 +---
>  .../hwtracing/coresight/coresight-trace-id.c  | 255 ++++++++++++++++++
>  .../hwtracing/coresight/coresight-trace-id.h  |  69 +++++
>  include/linux/coresight-pmu.h                 |  12 -
>  include/linux/coresight.h                     |   3 -
>  tools/perf/arch/arm/util/cs-etm.c             |  12 +-
>  16 files changed, 530 insertions(+), 175 deletions(-)
>  create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h
> 
> -- 
> 2.17.1
> 
