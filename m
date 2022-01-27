Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4499949EC68
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344011AbiA0UWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343981AbiA0UWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:22:23 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7E6C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:22:23 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id z14-20020a17090ab10e00b001b6175d4040so2994211pjq.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iKuuVqdayh65BOs3QlcJ6pbf0rkmkRMe+Lp1oFkny8c=;
        b=bbAvaOrBiYQC7RFxWBcx8VnN8m184zyOBkf16LekFtzpPyThJ4lx2gNpt/eZEV+wiy
         Im4jCQzSINPD87Ptw0Do0AmiL01Gc8WgVMJUSQaaWnppa0Ql7QMmxWs7d/uj5aW2thZG
         +gXMDt3UmgHUGpqJmeNIKGrHLTw1EEJ826Xy1IXiPYOMxipNOk6/HlYxa9GwVmZjU9oG
         Ck8IOzu+lLqAc4quoZGHI2vN0a1tEdQmf/4LeWrTpB1CkPTnxMHI1uPW4KjH/Yk+CioC
         QO062WshhfvjMHgzRibp9SknkZkQF0HqZCxk2ClfPL7gjAp+cr4k+r/6JJ7+K4LLVnXk
         8jZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iKuuVqdayh65BOs3QlcJ6pbf0rkmkRMe+Lp1oFkny8c=;
        b=MkPzuu9kP2jMLed4F6pi6tTaRk/fpPtR/nmMdCZoqM+qbQDrIDUycCAr5UyVnNSbVK
         JHnIpyw/ycGx1eiL8KjvUZ5rneLQaBklOysHc0DJAkDJWyiB2nMnkdL15XI+wKwj2chu
         5XMrJM9JgI+hPhRXjXU3j+Sa3XQFfQ5YiAz5OfF/4ECwR9J08AraQG1c2Bhi2om4X2JH
         XifbJUBJrm60N7FoV/miyRmPTopWqbAfYTFhI3TuKpAgweDZJEYxGVA3bZQ569jYFmNK
         Cy4pSKYbp56k/VCDRkeQzhdtfmuSrlGTmQCchwGe4lPLRVeZp/wpfUhQVHhdSH9IkFh0
         JLKw==
X-Gm-Message-State: AOAM532kS/9p9kECqtPt/Z6JiRiAa4oIMakXOeU+4ah+NUZOWKrh47K/
        3ht/aIZ/NzIuY2tjq2GnedLKoQ==
X-Google-Smtp-Source: ABdhPJzwkgUTEXFE1qykze0xRlKlyYYL2dHK+otqpecyQIADcjZz7ovAKDX79mubX2rWygZ5T4NSRQ==
X-Received: by 2002:a17:902:ce84:: with SMTP id f4mr4634037plg.140.1643314943089;
        Thu, 27 Jan 2022 12:22:23 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id om6sm177678pjb.24.2022.01.27.12.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 12:22:22 -0800 (PST)
Date:   Thu, 27 Jan 2022 13:22:20 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 RESEND 0/7] coresight: trbe: Workaround Cortex-A510
 erratas
Message-ID: <20220127202220.GA2191206@p14s>
References: <1643120437-14352-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643120437-14352-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 07:50:30PM +0530, Anshuman Khandual wrote:
> 	This series adds three different workarounds in the TRBE driver for
> Cortex-A510 specific erratas. But first, this adds Cortex-A510 specific cpu
> part number definition in the platform. This series applies on 5.17-rc1.
> 
> Relevant errata documents can be found here.
> 
> https://developer.arm.com/documentation/SDEN2397239/900
> https://developer.arm.com/documentation/SDEN2397589/900
> 
> Changes in V3:
> 
> https://lore.kernel.org/all/1641872346-3270-1-git-send-email-anshuman.khandual@arm.com/
> 
> - Moved the comment inside trbe_needs_drain_after_disable()
> - Moved the comment inside trbe_needs_ctxt_sync_after_enable()
> 
> Changes in V2:
> 
> https://lore.kernel.org/all/1641517808-5735-1-git-send-email-anshuman.khandual@arm.com/
> 
> Accommodated most review comments from the previous version.
> 
> - Split all patches into CPU errata definition, detection and TRBE workarounds
> - s/TRBE_WORKAROUND_SYSREG_WRITE_FAILURE/TRBE_NEEDS_DRAIN_AFTER_DISABLE
> - s/TRBE_WORKAROUND_CORRUPTION_WITH_ENABLE/TRBE_NEEDS_CTXT_SYNC_AFTER_ENABLE
> - s/trbe_may_fail_sysreg_write()/trbe_needs_drain_after_disable()
> - s/trbe_may_corrupt_with_enable()/trbe_needs_ctxt_sync_after_enable()
> - Updated Kconfig help message for config ARM64_ERRATUM_1902691
> - Updated error message for trbe_is_broken() detection
> - Added new trblimitr parameter to set_trbe_enabled(), improving performance
> - Added COMPILE_TEST dependency in the errata, until TRBE part is available
> 
> Changes in V1:
> 
> https://lore.kernel.org/lkml/1641359159-22726-1-git-send-email-anshuman.khandual@arm.com/
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: coresight@lists.linaro.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Anshuman Khandual (7):
>   arm64: Add Cortex-A510 CPU part definition
>   arm64: errata: Add detection for TRBE ignored system register writes
>   arm64: errata: Add detection for TRBE invalid prohibited states
>   arm64: errata: Add detection for TRBE trace data corruption
>   coresight: trbe: Work around the ignored system register writes
>   coresight: trbe: Work around the invalid prohibited states
>   coresight: trbe: Work around the trace data corruption
> 
>  Documentation/arm64/silicon-errata.rst       |   6 +
>  arch/arm64/Kconfig                           |  59 ++++++++++
>  arch/arm64/include/asm/cputype.h             |   2 +
>  arch/arm64/kernel/cpu_errata.c               |  27 +++++
>  arch/arm64/tools/cpucaps                     |   3 +
>  drivers/hwtracing/coresight/coresight-trbe.c | 114 ++++++++++++++-----
>  drivers/hwtracing/coresight/coresight-trbe.h |   8 --
>  7 files changed, 183 insertions(+), 36 deletions(-)

I have applied this set and sent a pull request to Catalin for the arm64
portion.

Thanks,
Mathieu

> 
> -- 
> 2.25.1
> 
