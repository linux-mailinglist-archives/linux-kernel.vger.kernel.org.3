Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FCC59C54C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbiHVRqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbiHVRpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:45:38 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5DCAE46
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:45:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s36-20020a17090a69a700b001faad0a7a34so14697230pjj.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=xtp+J6ERoEJ3kAajXR0YGqzCjFevJgSLg85d4X0k9bE=;
        b=VpY25hWt3FxOgeZCV3NXlzKhHjp2xG1Bb8E/b9zz/EhaS4AGJHUGc2GvLDXAjmDPM0
         kUXYDsSN60xJyFya5XNIErRgznfEScTFbvJQU99NIgpit7LDmXBdp+F5BOgrCr4dJpnM
         P6HSsqKsSNvWK7gZlYQfFGf8tgbCqMXoBTv9PBc3UDwi5hmwbPF+yyucEV0CPg4vCRLh
         LMhZokEECXY4QmFQO21ftzKrLlVtoi0BJ2WreouaH+Jg+bd9rS4fQV/RHA0aktqUUVT3
         tJf55V13M0u+IjZeOaDM+Z/iPryzD2BWEm5FgLmGQHQeyZGGNnWBpMo60DSYMF1HDhfr
         8EgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=xtp+J6ERoEJ3kAajXR0YGqzCjFevJgSLg85d4X0k9bE=;
        b=LTyc2+5jzl1tjJ+iBLdhpjL5+FHI9/2/omvXiLu0PU3co8BozfilRCk8oBaRlJ3aBu
         /vrH/i9r+oBAHEhRvTVDiYjWz1p4W2D7SwRTJ93Qq98C8Mw9cYYrdfd2/933SThUzxQq
         lEO+FpFkpVVeNpQq8H4pR+7hdmlDlP6pFL0bvxB2gGTO3EjptMwpRK+gEcFKrEiJ8bjl
         XPMhullo0yKFIUAYbkyjeNTX/OlvTioB4q6/SCTo3h1tHbBqcyq0ZG9v0tn7yGNlOWLA
         GA9QMdlTwnyxlCx9kxnw1SW3UC6cynnoy41w+NcS1Nz8pB3wqsMiEBtTMwuI0zDSiQ4+
         v0aA==
X-Gm-Message-State: ACgBeo39RKN5+ZLgChYVHLs5WJu0CvbcE6m6FNntsALMhnT45U2KEiux
        yYepcTtAF9/aEi253wtY7tcDmw==
X-Google-Smtp-Source: AA6agR5HRZd1pQeXv6EAxjPUvrFN/krikHo1Me6ZYch4CAbsEItlfMzsgbw5emLzuDPuA5JprvWhTA==
X-Received: by 2002:a17:902:ed92:b0:172:a334:acbb with SMTP id e18-20020a170902ed9200b00172a334acbbmr21298822plj.58.1661190337123;
        Mon, 22 Aug 2022 10:45:37 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id js5-20020a17090b148500b001f1f5e812e9sm8400982pjb.20.2022.08.22.10.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 10:45:34 -0700 (PDT)
Date:   Mon, 22 Aug 2022 11:45:32 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] coresight: Reduce duplicated sysfs accessors
Message-ID: <20220822174532.GE1583519@p14s>
References: <20220725145221.517776-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725145221.517776-1-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 03:52:17PM +0100, James Clark wrote:
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
> James Clark (4):
>   coresight: Remove unused function parameter
>   coresight: Simplify sysfs accessors by using csdev_access abstraction
>   coresight: Re-use same function for similar sysfs register accessors
>   coresight: cti-sysfs: Re-use same functions for similar sysfs register
>     accessors
> 
>  drivers/hwtracing/coresight/coresight-catu.c  |  27 +--
>  drivers/hwtracing/coresight/coresight-core.c  |  14 ++
>  .../hwtracing/coresight/coresight-cti-sysfs.c | 213 +++++++-----------
>  drivers/hwtracing/coresight/coresight-etb10.c |  28 +--
>  .../coresight/coresight-etm3x-sysfs.c         |  34 +--
>  drivers/hwtracing/coresight/coresight-priv.h  |  48 ++--
>  .../coresight/coresight-replicator.c          |  10 +-
>  drivers/hwtracing/coresight/coresight-stm.c   |  40 +---
>  .../hwtracing/coresight/coresight-tmc-core.c  |  48 ++--
>  include/linux/coresight.h                     |  18 ++
>  10 files changed, 196 insertions(+), 284 deletions(-)

I am done reviewing this set.  It would be nice if you could respin this as
quickly as possible so that I could apply it to next early in the cycle.

Thanks,
Mathieu

> 
> -- 
> 2.28.0
> 
