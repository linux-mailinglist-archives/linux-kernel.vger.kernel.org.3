Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633C95A83E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiHaQ7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiHaQ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:59:23 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8AFE0960
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:58:28 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fa2so7020296pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=TupKKvR6dZz/3iGpRAyOcguuOG/Q6iuwOMieQ0bzyVU=;
        b=uSF2CEdt7dbN626BZ+yeyXPs6NUKow3AXH68ik8oWTc9KRrPdpTHY0tvt4iy05cXPo
         Gjf098D8/sguiFHNa5vvueI29pc24OwxK9+oZLZHGj40yyewW47G7GEUu1nZr1HJvsgR
         Vx7uhEjIqSLjUdpTvFnC/Y+8sbJZhb2biBPPm+R8vc8zAiIat69QzHj2M4lRPFWMu2nR
         2sg+Ak8gYSSbZXxEAYFBHTmJuPxQJkTmcjUGgc5GVn5zxukfragxRf9Rw7gEhoSjyNm1
         ghvd5lGDw882s+erKsZyb+B+U8/31I96vFEjc383BYQPVJMtPuZEcgPycgx6i39+8yvp
         9Hjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=TupKKvR6dZz/3iGpRAyOcguuOG/Q6iuwOMieQ0bzyVU=;
        b=hZMXMinMG+RD9akXC9VfrgjE49SGLcr0p7V4nKBHj13+vgrgNH8lg5UCuYNg5JbHIL
         krVY3acvdQBbohYpvO0DmP7S6a89ljzyrL2PpQ1mCQ9nuVpUeSLVDRUI54eSmWF0/j38
         qhTIipvYtmBw65c+U4ErghF8rHk+ugN9P18JOyZfFegBBVwlm+NU5WX83eqkPS7fF8ta
         DqsSOWrRhW6OE54o+76OJEFfLSVnXMMc/FtJbtj02Kh/gScZud8w9wtpKOvJg3rF2fmw
         Dij6iTFZ9wq8LTyksbwTvY72LBXej5Q4G/fYXhBkuBMDL7fKKy+Y7E+w8f5MbOnr2OR4
         VO7A==
X-Gm-Message-State: ACgBeo0sSNEAD+kPbADI0K7QE6l4ah7PZAmXWQxsqNYyVCO7yCjSoKBP
        T3X+Z4JOU3/AqkreYa8e0eLjM0xj2O54DQ==
X-Google-Smtp-Source: AA6agR5FlvqIoK70Z7dfClOiW6h6rYHmf/RXsXy9uD7rsP6YWnHuqz4j0rhpNDTbM5Jw0ZJxIvHe9g==
X-Received: by 2002:a17:902:d509:b0:16f:1e1:2067 with SMTP id b9-20020a170902d50900b0016f01e12067mr26137455plg.140.1661965107344;
        Wed, 31 Aug 2022 09:58:27 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id p12-20020a635b0c000000b0042a713dd68csm3590306pgb.53.2022.08.31.09.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:58:26 -0700 (PDT)
Date:   Wed, 31 Aug 2022 10:58:23 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, german.gomez@arm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 0/5] coresight: Reduce duplicated sysfs accessors
Message-ID: <20220831165823.GB217472@p14s>
References: <20220830172614.340962-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830172614.340962-1-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have applied this set.

Thanks,
Mathieu

On Tue, Aug 30, 2022 at 06:26:08PM +0100, James Clark wrote:
> Changes since v1:
> 
>   * Keep existing signed offset value types until the very last commit
>     and then remove them all at once
> 
>   * Also split out usages of read_pair() and read32() into separate
>     functions in the last commit 
> 
>   * Whitespace fixes
> 
>   * Replaced any touched scnprintf() with sysfs_emit()
> 
> ======
> 
> The intent of this change is to reduce the large number identical of
> functions created by macros for sysfs accessors. It's possible to re-use
> the same function but pass in the register to access as an argument.
> This reduces the size of the coresight modules folder by 244KB.
> 
> The first two patches are refactors to simplify and remove some dead
> code, and the second two are the changes to use a shared function.
> 
> Testing
> =======
> 
> No changes in any of the outputs:
> 
>   cat /sys/bus/coresight/devices/*/mgmt/* > before.txt
>   cat /sys/bus/coresight/devices/*/mgmt/* > after.txt
>   diff before.txt after.txt
> 
> With the following modules loaded:
> 
>   ls /sys/bus/coresight/devices/
>   etm0  etm2  funnel0  funnel2  replicator0  tmc_etf0  tmc_etf2  tpiu0
>   etm1  etm3  funnel1  funnel3  stm0         tmc_etf1  tmc_etr0
> 
> 
> James Clark (5):
>   coresight: Remove unused function parameter
>   coresight: Simplify sysfs accessors by using csdev_access abstraction
>   coresight: Re-use same function for similar sysfs register accessors
>   coresight: cti-sysfs: Re-use same functions for similar sysfs register
>     accessors
>   coresight: Make new csdev_access offsets unsigned
> 
>  drivers/hwtracing/coresight/coresight-catu.c  |  27 +--
>  drivers/hwtracing/coresight/coresight-catu.h  |   8 +-
>  drivers/hwtracing/coresight/coresight-core.c  |  28 +++
>  .../hwtracing/coresight/coresight-cti-sysfs.c | 213 +++++++-----------
>  drivers/hwtracing/coresight/coresight-etb10.c |  28 +--
>  .../coresight/coresight-etm3x-sysfs.c         |  34 +--
>  drivers/hwtracing/coresight/coresight-priv.h  |  74 +++---
>  .../coresight/coresight-replicator.c          |  10 +-
>  drivers/hwtracing/coresight/coresight-stm.c   |  40 +---
>  .../hwtracing/coresight/coresight-tmc-core.c  |  48 ++--
>  drivers/hwtracing/coresight/coresight-tmc.h   |   4 +-
>  include/linux/coresight.h                     |  23 ++
>  12 files changed, 227 insertions(+), 310 deletions(-)
> 
> -- 
> 2.28.0
> 
